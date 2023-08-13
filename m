Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3777A979
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjHMQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjHMQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:12:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C173C25;
        Sun, 13 Aug 2023 09:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47E5A6145D;
        Sun, 13 Aug 2023 16:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6FEC433C7;
        Sun, 13 Aug 2023 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943085;
        bh=Zvp3Nq6KF4YB6ZDyjWlB1Q4kdCiyKAN1xY3t2kgKPRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPhz1AgKvKeOg5EASR11/Wui+AarZ1kHJVPac6DdmSwV/1ERl4rTIiCIdTum1zMB0
         XLS3QDVGX3YP2KB3jy550/1y29QRLwBL/15+I2vxjhqLsqZfa7HmH1BKBYp6/Mrjhh
         crWoehqJtHizQp2nPUkwMRLhYOYmTgYxEoRDVBvP0yd1atl5F1OHnYNghFqHgRsoeX
         Z3+jG/nqJic9eoOvZjZe5gs35nH5yceUMj5PNK3PATF4CufMfhvCE28dEJJ1tJlhem
         AMoWPRGt98utTLRUhdJCTpqZjdNPYkdoKNbo9q393LgmC0YIuLAT5nNj6j/TLIfr/x
         79LZxH4EyjeIw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dhowells@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 24/25] security: keys: perform capable check only on privileged operations
Date:   Sun, 13 Aug 2023 12:09:35 -0400
Message-Id: <20230813160936.1082758-24-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160936.1082758-1-sashal@kernel.org>
References: <20230813160936.1082758-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.190
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit 2d7f105edbb3b2be5ffa4d833abbf9b6965e9ce7 ]

If the current task fails the check for the queried capability via
`capable(CAP_SYS_ADMIN)` LSMs like SELinux generate a denial message.
Issuing such denial messages unnecessarily can lead to a policy author
granting more privileges to a subject than needed to silence them.

Reorder CAP_SYS_ADMIN checks after the check whether the operation is
actually privileged.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/keyctl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 61a614c21b9b6..e3ffaf5ad6394 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -980,14 +980,19 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 	ret = -EACCES;
 	down_write(&key->sem);
 
-	if (!capable(CAP_SYS_ADMIN)) {
+	{
+		bool is_privileged_op = false;
+
 		/* only the sysadmin can chown a key to some other UID */
 		if (user != (uid_t) -1 && !uid_eq(key->uid, uid))
-			goto error_put;
+			is_privileged_op = true;
 
 		/* only the sysadmin can set the key's GID to a group other
 		 * than one of those that the current process subscribes to */
 		if (group != (gid_t) -1 && !gid_eq(gid, key->gid) && !in_group_p(gid))
+			is_privileged_op = true;
+
+		if (is_privileged_op && !capable(CAP_SYS_ADMIN))
 			goto error_put;
 	}
 
@@ -1088,7 +1093,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 	down_write(&key->sem);
 
 	/* if we're not the sysadmin, we can only change a key that we own */
-	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
+	if (uid_eq(key->uid, current_fsuid()) || capable(CAP_SYS_ADMIN)) {
 		key->perm = perm;
 		notify_key(key, NOTIFY_KEY_SETATTR, 0);
 		ret = 0;
-- 
2.40.1

