Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA07BA575
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbjJEQRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbjJEQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:06 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90FB2B8BD;
        Thu,  5 Oct 2023 08:39:04 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 1F718202B9.A610D
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:213:242:ac11:64])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 1F718202B9;
        Thu,  5 Oct 2023 17:39:02 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1696520342;
        bh=wb0qOjYa0NLZXWs/au0QyqK7ZnXXS/M96J9imzOO2PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JdFf+yh4V05PQd/0idF9BeZNkuJaPcemOGAKGfCIeg3LEYHJWEIFJs8ZofW+gF590
         vfDqgoT7FMNhIUvyzslj4gJ9qlV4MRtuWuPbLY40cYO8raVahWjNRw783GFc6CBJxE
         vKKTSGoc4JqKrifF/YUkSHfSmgM+5G/njA0rwRdI=
Received: from librem.dyn.cs.kuleuven.be (unknown [IPv6:2a02:2c40:500:a006:548e:e4dd:76a4:afd8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id EE746D4E69480;
        Thu,  5 Oct 2023 17:39:01 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v7 12/13] selftests/sgx: Discard unsupported ELF sections
Date:   Thu,  5 Oct 2023 17:38:53 +0200
Message-Id: <20231005153854.25566-13-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the test enclave with -static-pie may produce a dynamic symbol
table, but this is not supported for enclaves and any relocations need to
happen manually (e.g., as for "encl_op_array"). Thus, opportunistically
discard ".dyn*" and ".gnu.hash" which the enclave loader cannot handle.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/test_encl.lds | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index 333a3e78fdc9..ffe851a1cac4 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -33,6 +33,8 @@ SECTIONS
 		*(.note*)
 		*(.debug*)
 		*(.eh_frame*)
+		*(.dyn*)
+		*(.gnu.hash)
 	}
 }
 
-- 
2.25.1

