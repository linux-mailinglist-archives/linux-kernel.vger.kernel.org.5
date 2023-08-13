Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64A477A8F2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjHMQIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjHMQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:08:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB80D170A;
        Sun, 13 Aug 2023 09:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F21A6382B;
        Sun, 13 Aug 2023 16:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7455BC433C7;
        Sun, 13 Aug 2023 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942804;
        bh=9SZ396wiruZFafkXo3jZlywba68S7OpczLTeNWRGrvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOpK71swMJBwySCb1z5NCuWaeMmXVM4ZkT2nU7K+T/vi9xVVskRczzsn9HKWyWQKz
         V1NycM7caaiaGnKWvp0/tXzi6D5P3x14CsREJ+wvhzp+SMYduSi57UF5zBBMjzGJFX
         uCvSoKHDq+MLgcRkbEazQKS7koZi4jsjCIdgCf+9gaCzFq6fT5bgUH6WD6qlP+YGfy
         BGJwV2ssgMFShUnlB/Ls6rJGVsiWMsVY18Dw6hu4UhyrcR9rhvQE1vbnxToFY/t8Qe
         3XSu7FBtxbI5HZeLubv0t7BRrzgoYaL7/C8Ga9CX2EcKwV4IGik76jtY9xGtvXTj/p
         bzdyajw04IxDg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        zdi-disclosures@trendmicro.com,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, brauner@kernel.org,
        dchinner@redhat.com, senozhatsky@chromium.org,
        viro@zeniv.linux.org.uk, ddiss@suse.de, mmakassikis@freebox.fr
Subject: [PATCH AUTOSEL 5.15 06/31] ksmbd: fix out of bounds in smb3_decrypt_req()
Date:   Sun, 13 Aug 2023 12:05:39 -0400
Message-Id: <20230813160605.1080385-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit dc318846f3dd54574a36ae97fc8d8b75dd7cdb1e ]

smb3_decrypt_req() validate if pdu_length is smaller than
smb2_transform_hdr size.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21589
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 9f9d07caa57e9..a4673831fc10d 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8642,7 +8642,8 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
 	int rc = 0;
 
-	if (buf_data_size < sizeof(struct smb2_hdr)) {
+	if (pdu_length < sizeof(struct smb2_transform_hdr) ||
+	    buf_data_size < sizeof(struct smb2_hdr)) {
 		pr_err("Transform message is too small (%u)\n",
 		       pdu_length);
 		return -ECONNABORTED;
-- 
2.40.1

