Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1198E7EA168
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjKMQnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKMQnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:43:14 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEA1D53;
        Mon, 13 Nov 2023 08:43:09 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 6DB171869B6D;
        Mon, 13 Nov 2023 19:43:06 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tdjbxSMGeGAM; Mon, 13 Nov 2023 19:43:06 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 17F601869B6A;
        Mon, 13 Nov 2023 19:43:06 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HZuMF2TecaTM; Mon, 13 Nov 2023 19:43:06 +0300 (MSK)
Received: from rbta-msk-lt-172751.astralinux.ru (unknown [10.177.20.22])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 071751869AEF;
        Mon, 13 Nov 2023 19:43:04 +0300 (MSK)
From:   Ekaterina Esina <eesina@astralinux.ru>
To:     Steve French <sfrench@samba.org>
Cc:     Ekaterina Esina <eesina@astralinux.ru>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Aurelien Aptel <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Anastasia Belova <abelova@astralinux.ru>
Subject: [PATCH] cifs: fix check of rc in function generate_smb3signingkey
Date:   Mon, 13 Nov 2023 19:42:41 +0300
Message-Id: <20231113164241.32310-1-eesina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra check after condition, add check after generating key
for encryption. The check is needed to return non zero rc before
rewriting it with generating key for decryption.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d70e9fa55884 ("cifs: try opening channels after mounting")
Signed-off-by: Ekaterina Esina <eesina@astralinux.ru>
Co-developed-by: Anastasia Belova <abelova@astralinux.ru>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 fs/smb/client/smb2transport.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.=
c
index 84ea67301303..5a3ca62d2f07 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -458,6 +458,8 @@ generate_smb3signingkey(struct cifs_ses *ses,
 				  ptriplet->encryption.context,
 				  ses->smb3encryptionkey,
 				  SMB3_ENC_DEC_KEY_SIZE);
+		if (rc)
+			return rc;
 		rc =3D generate_key(ses, ptriplet->decryption.label,
 				  ptriplet->decryption.context,
 				  ses->smb3decryptionkey,
@@ -466,9 +468,6 @@ generate_smb3signingkey(struct cifs_ses *ses,
 			return rc;
 	}
=20
-	if (rc)
-		return rc;
-
 #ifdef CONFIG_CIFS_DEBUG_DUMP_KEYS
 	cifs_dbg(VFS, "%s: dumping generated AES session keys\n", __func__);
 	/*
--=20
2.30.2

