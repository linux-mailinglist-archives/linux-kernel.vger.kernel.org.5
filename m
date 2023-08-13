Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2145877A85E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjHMQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjHMQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:01:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D01713;
        Sun, 13 Aug 2023 09:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E1D2634AA;
        Sun, 13 Aug 2023 16:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9D3C433C7;
        Sun, 13 Aug 2023 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942457;
        bh=7KNCKgpXPZx9LzGuFTGpvnOq/y5JMiPeJYs8FwqmIUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJ6KpW3YxTtc1IaFa/hgICNxjRCf0u3B+/38gzlDzt/0RBA2k68qmjI+2cG88fwKW
         m9aew8rp+zTgmAKTzVy3JJ1OjAeyTF5wQMSGN6CGmZvYwa7Wm94w+Qnlg3kAcY+bv4
         bc7x9xGmo5hjyvFmx5bafJbJg3SbyY7UfJ4c3TplQ4bkQthPYYGm/1kzYlQjpxAaAy
         w/+HR4Y9Ugl5PzNP7QSntt033kRV/y6ZzVcHeYqAvIbYYcc87dhl5I4aXKSNkGt5CN
         t6/qj1wtM+W0ep4pvsPfTlB6Dvj5ZK7W/9taTVap4TUecHSlfjtZYzrDjXT4w2aTW8
         gxDvK2bS8epqQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        zdi-disclosures@trendmicro.com,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/47] ksmbd: no response from compound read
Date:   Sun, 13 Aug 2023 11:59:06 -0400
Message-Id: <20230813160006.1073695-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
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
 fs/smb/server/smb2pdu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d2873dc4322d7..29212c1a0eed3 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6307,6 +6307,11 @@ int smb2_read(struct ksmbd_work *work)
 	unsigned int max_read_size = conn->vals->max_read_size;
 
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

