Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5968D75E95E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGXByS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjGXBxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:53:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C78A42;
        Sun, 23 Jul 2023 18:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C905A60F9D;
        Mon, 24 Jul 2023 01:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C045C433CB;
        Mon, 24 Jul 2023 01:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162285;
        bh=3AzuwKlHf+f/HDKjoC0ziigGLf+7jEqY6zNVASDpf20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6WzT6Hn6n9FIAdpPAw9vf7bB0nNgxA9Dr0kcFBCHbGDcfR2dIXdMUwcqirqeoCMI
         xgvb2dy79M4uSvYUZ58Oo2tOzCPzCMt05stifcFM/24rwn6XQouE2yEATDazKheGEL
         q4sURjUhgd/Z7h1gBcmKcHUii9F0eLIjm2H9smq5XOUiIRQrcRmEAe7uUMP1gp94sV
         vr0wCxDoFQ5DQon+DItvevS+MGHr28aHVpLuVVJjWhFNOBcUjHvm2cbFalCReKARWP
         9tq66Zk6VTqNtfXGZ+yF4K5+xIxROl1hErbAGFtsuBsK4zax1qxSlc0nULxnepcmAO
         GHcH5mZC24knQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Winston Wen <wentao@uniontech.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 3/3] cifs: fix session state check in reconnect to avoid use-after-free issue
Date:   Sun, 23 Jul 2023 21:31:19 -0400
Message-Id: <20230724013119.2327427-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013119.2327427-1-sashal@kernel.org>
References: <20230724013119.2327427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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
index 3ca593cdda76e..ba46156e32680 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3841,6 +3841,12 @@ void smb2_reconnect_server(struct work_struct *work)
 
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

