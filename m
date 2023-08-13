Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1235F77A801
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjHMPxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjHMPwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D742D6D;
        Sun, 13 Aug 2023 08:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C1E463290;
        Sun, 13 Aug 2023 15:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E51C433C7;
        Sun, 13 Aug 2023 15:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941863;
        bh=TsOBTcXGH1ZXSB1qcDVhgmW3xJXi2PIi00ebZWVIcco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yxg9rvG8blFJC5lf3XoyFUp6h6dVjTV+cC16RhE814nBSogdLrHcuZh9ItcBVTZrB
         aalgqb6KbVRS4IWOdYjH8ZoN7yBSQmiFbFzxMrBlgieviQj8OAlG5lQixOtGyZYBoX
         mwzBMhTrJwYgUsN7q6LpXfNrPQ7MaLpdHG93xeWjlKalDgraIFx8gEcwoQR1oFhpql
         BJI40TYQeJKOgG8EwQRZJIVN1/G5tq57hbY6dznLYJoMiPLUeyvmyYDaxuu3sOMewq
         xWjWK4J+MWgViB7MkSeT8ZT7LPgf211Hw+g3B4zxl3p2xyj3je4iO2DTYwqSOOnT+D
         UT912Dluy5ynQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Winston Wen <wentao@uniontech.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.4 27/54] cifs: fix charset issue in reconnection
Date:   Sun, 13 Aug 2023 11:49:06 -0400
Message-Id: <20230813154934.1067569-27-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Winston Wen <wentao@uniontech.com>

[ Upstream commit a43f95fdd39490f7b156fd126f1e90ec2d5553f1 ]

We need to specify charset, like "iocharset=utf-8", in mount options for
Chinese path if the nls_default don't support it, such as iso8859-1, the
default value for CONFIG_NLS_DEFAULT.

But now in reconnection the nls_default is used, instead of the one we
specified and used in mount, and this can lead to mount failure.

Signed-off-by: Winston Wen <wentao@uniontech.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h | 1 +
 fs/smb/client/cifssmb.c  | 3 +--
 fs/smb/client/connect.c  | 5 +++++
 fs/smb/client/misc.c     | 1 +
 fs/smb/client/smb2pdu.c  | 3 +--
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index ca2da713c5fe9..87c6ce54c72d0 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1062,6 +1062,7 @@ struct cifs_ses {
 	unsigned long chans_need_reconnect;
 	/* ========= end: protected by chan_lock ======== */
 	struct cifs_ses *dfs_root_ses;
+	struct nls_table *local_nls;
 };
 
 static inline bool
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index a0c4e9874b010..a49f95ea7cf6f 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -129,7 +129,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	}
 	spin_unlock(&server->srv_lock);
 
-	nls_codepage = load_nls_default();
+	nls_codepage = ses->local_nls;
 
 	/*
 	 * need to prevent multiple threads trying to simultaneously
@@ -200,7 +200,6 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 		rc = -EAGAIN;
 	}
 
-	unload_nls(nls_codepage);
 	return rc;
 }
 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 853209268f507..e965196e4f746 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1837,6 +1837,10 @@ static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 			    CIFS_MAX_PASSWORD_LEN))
 			return 0;
 	}
+
+	if (strcmp(ctx->local_nls->charset, ses->local_nls->charset))
+		return 0;
+
 	return 1;
 }
 
@@ -2280,6 +2284,7 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 
 	ses->sectype = ctx->sectype;
 	ses->sign = ctx->sign;
+	ses->local_nls = load_nls(ctx->local_nls->charset);
 
 	/* add server as first channel */
 	spin_lock(&ses->chan_lock);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 70dbfe6584f9e..d7e85d9a26553 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -95,6 +95,7 @@ sesInfoFree(struct cifs_ses *buf_to_free)
 		return;
 	}
 
+	unload_nls(buf_to_free->local_nls);
 	atomic_dec(&sesInfoAllocCount);
 	kfree(buf_to_free->serverOS);
 	kfree(buf_to_free->serverDomain);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 17fe212ab895d..5f20a754fb13b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -242,7 +242,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	}
 	spin_unlock(&server->srv_lock);
 
-	nls_codepage = load_nls_default();
+	nls_codepage = ses->local_nls;
 
 	/*
 	 * need to prevent multiple threads trying to simultaneously
@@ -324,7 +324,6 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		rc = -EAGAIN;
 	}
 failed:
-	unload_nls(nls_codepage);
 	return rc;
 }
 
-- 
2.40.1

