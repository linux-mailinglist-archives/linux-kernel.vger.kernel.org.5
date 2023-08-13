Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC77877A9C2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjHMQSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjHMQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232622D6D;
        Sun, 13 Aug 2023 09:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB4BD625D8;
        Sun, 13 Aug 2023 16:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F17C433C7;
        Sun, 13 Aug 2023 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942813;
        bh=qjsdbStZwCL6zMnWUu77kWh/UnQGr1JJxFmwa1lG9ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHLwughjl6ZfkNSF6RP5eaRtp6kbEtvJHcrJ9ThNvmT1mwbpjEMuaIrKpLAtbPGZv
         XSaXyrzzLI0kNSnE/otB/3YN9rkal0XsVXXCipVSM48UMRwnDe2bUv+ZfA0rHSxjAH
         Gzh6go5b7Ge8zFH4SzKUYd7Y7TRfSG0rKA0BTTtmvSy0b+WBZ3ZiifnG6yIdJJLPK9
         o2sdwjP2gThtG3tgPdQqM8+gqJbinHuKS6jOW7NzPElrRsEWD4YfK9GMZcHh1n2uzj
         LlwMhW6Dgd37s8taioWCqNqiLVEXYSV/lwcwAnB2FwMcAMEqepjzPa1BXndiBDtWy3
         HAz9xoOqdCPDw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        zdi-disclosures@trendmicro.com,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, brauner@kernel.org,
        dchinner@redhat.com, viro@zeniv.linux.org.uk, ddiss@suse.de,
        mmakassikis@freebox.fr
Subject: [PATCH AUTOSEL 5.15 07/31] ksmbd: no response from compound read
Date:   Sun, 13 Aug 2023 12:05:40 -0400
Message-Id: <20230813160605.1080385-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit e202a1e8634b186da38cbbff85382ea2b9e297cf ]

ksmbd doesn't support compound read. If client send read-read in
compound to ksmbd, there can be memory leak from read buffer.
Windows and linux clients doesn't send it to server yet. For now,
No response from compound read. compound read will be supported soon.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21587, ZDI-CAN-21588
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index a4673831fc10d..437bfc970bc5e 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6246,6 +6246,11 @@ int smb2_read(struct ksmbd_work *work)
 
 	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
+	if (work->next_smb2_rcv_hdr_off) {
+		work->send_no_response = 1;
+		err = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_PIPE)) {
-- 
2.40.1

