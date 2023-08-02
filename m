Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49F876CE77
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjHBNY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjHBNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DADDA;
        Wed,  2 Aug 2023 06:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92CA861994;
        Wed,  2 Aug 2023 13:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4CCC433C8;
        Wed,  2 Aug 2023 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690982692;
        bh=DDm1LEyHVrqgVPbORsJTPU+hVDJwprYsNNL9IHeL+5k=;
        h=Date:From:To:Cc:Subject:From;
        b=nWjglhibGmIAoJ0wRJHiguhdY/s9FGgXJNwpF0vJi9mJ8pofv2p7JYopQP/LkiAo2
         SrzWDgQqEqxd+zUR8u/m4gwZH4DMVKXhPwjATpsaMIbE/csJS8XoMj36otYrK9WRIZ
         qkcP3LbpzDOaGSitQOh2VAH/jqg5vdA9FTa1T49wj7DhBvRU4R9pG/WD/ME722baiR
         VjIJVMlWetVgQP/RUfMmdqwZtvoQx6CspYJwak8pPv9rAzbhxdlDfWtqR8eMKU/7cm
         Uc10RjfRmaThlihTV+AUKeNc6/c9NyFrzIGGSpUVo7Ij1DbCVdZbl8EWMeW342sz+c
         psQ4JFmi/JWiQ==
Date:   Wed, 2 Aug 2023 07:25:56 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] alpha: Replace one-element array with flexible-array member
Message-ID: <ZMpZZBShlLqyD3ax@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct osf_dirent with flexible-array
member.

This results in no differences in binary output.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/alpha/kernel/osf_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index d98701ee36c6..5db88b627439 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -97,7 +97,7 @@ struct osf_dirent {
 	unsigned int d_ino;
 	unsigned short d_reclen;
 	unsigned short d_namlen;
-	char d_name[1];
+	char d_name[];
 };
 
 struct osf_dirent_callback {
-- 
2.34.1

