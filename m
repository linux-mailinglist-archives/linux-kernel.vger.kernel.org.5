Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4EB77A9BE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjHMQRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjHMQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3746A5;
        Sun, 13 Aug 2023 09:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE99D6147A;
        Sun, 13 Aug 2023 16:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D3FC433C8;
        Sun, 13 Aug 2023 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943323;
        bh=rG8JSyPjzAmsL4ZWf3kMhTAviAKjtsf2MvznkOQWWaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DrMwoLqJyS4GUaMVu/elOG+Px6XcZgCXeWfi0OFZyZdj26aBKVshgJElmrQ1mrEgC
         XSLSbyi0cw2S8I37f8+A29ZNyAEaBy9uy3y/kXFIYF4ikVTNWvF/aSjfUoBD6+D5EM
         RNelCq0iN3HXqsOviy1EGlVHvgJbvt6V26mXWLlS9+vPkq4rzz8zZdNMq8rU+Y9Q3n
         U2eVmi8ruKF5WF3hDb3G+zuEnRG0YH6kZ5rNFzP/Cn/SLloT03QxccrVKs7YwOqbS7
         srnY1sMjaksxFfdKNCRO2qOb9lFMBpzVFmxCazlCg4yRYJhqaV4qLoWeon19o8LYMr
         z/opW2U/gM/UQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dhowells@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 9/9] security: keys: perform capable check only on privileged operations
Date:   Sun, 13 Aug 2023 12:14:27 -0400
Message-Id: <20230813161427.1089101-9-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161427.1089101-1-sashal@kernel.org>
References: <20230813161427.1089101-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.322
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
index 9394d72a77e80..9e52a3e0fc672 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -922,14 +922,19 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
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
 
@@ -1029,7 +1034,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 	down_write(&key->sem);
 
 	/* if we're not the sysadmin, we can only change a key that we own */
-	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
+	if (uid_eq(key->uid, current_fsuid()) || capable(CAP_SYS_ADMIN)) {
 		key->perm = perm;
 		ret = 0;
 	}
-- 
2.40.1

