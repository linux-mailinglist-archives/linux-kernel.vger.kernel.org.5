Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F2B75E7E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjGXBgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjGXBfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DAC49C8;
        Sun, 23 Jul 2023 18:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C93F60F90;
        Mon, 24 Jul 2023 01:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D803C433C7;
        Mon, 24 Jul 2023 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162278;
        bh=pK8e/yYzLZhAXR2/H9+hB+uQ+BGORlNDvg4RyFefSH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mtb2PNJLrRVpM6sfuho/mo+Md3/XKTazfxqzCGiO9g7inXVTs6YIBu1MrfWfHZc5N
         RxnWCC/O1IUw6D6QICOR+1kytX/fhGwPo21RtYR5/Bv10AGiqOb3REqQwxKWQ6OKGL
         zUBGo3n/NIdGxg5MhrvA5E550k6ILBBxVBFJECaLEyBJLoQ4ZFzcOTZjUx6J5OWUYc
         NRMH/PEeKe38ue1Zf7cd1B9meaHeRaSikL55/bekE4O12X5xSd7B3ZwkASFFrdYtJH
         JPDgn5hLxuGT18+QZy4iqUxjTaBkRQ6Dqv2JNcDTGWr3o+CymrWrby/1dfPNsYwi6R
         J42ln9+yoB98g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Winston Wen <wentao@uniontech.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.4 4/4] cifs: fix session state check in reconnect to avoid use-after-free issue
Date:   Sun, 23 Jul 2023 21:31:11 -0400
Message-Id: <20230724013111.2327251-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013111.2327251-1-sashal@kernel.org>
References: <20230724013111.2327251-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Winston Wen <wentao@uniontech.com>

[ Upstream commit 99f280700b4cc02d5f141b8d15f8e9fad0418f65 ]

Don't collect exiting session in smb2_reconnect_server(), because it
will be released soon.

Note that the exiting session will stay in server->smb_ses_list until
it complete the cifs_free_ipc() and logoff() and then delete itself
from the list.

Signed-off-by: Winston Wen <wentao@uniontech.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 17fe212ab895d..e04766fe6f803 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3797,6 +3797,12 @@ void smb2_reconnect_server(struct work_struct *work)
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
+		spin_lock(&ses->ses_lock);
+		if (ses->ses_status == SES_EXITING) {
+			spin_unlock(&ses->ses_lock);
+			continue;
+		}
+		spin_unlock(&ses->ses_lock);
 
 		tcon_selected = false;
 
-- 
2.39.2

