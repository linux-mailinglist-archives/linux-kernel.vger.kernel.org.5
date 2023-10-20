Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64987D1050
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377405AbjJTNNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbjJTNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:13:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED2F19E;
        Fri, 20 Oct 2023 06:13:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1A6C433C8;
        Fri, 20 Oct 2023 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697807589;
        bh=3v3w9N11nD6FfXU/AHmloGedz/Yr2LLf3n2MT+5UOQg=;
        h=From:To:Cc:Subject:Date:From;
        b=iR/1qWGCigk5mb+sUX+mtTgr+F11ZN3V1hOM3Q4nAK8r5fYeUto4kpybOnNrQq5Vb
         nshaIcQcOuDGRRbKWlux8REmv7fgL2opspPCPRrvwwW6F959E0hywgJzEPcS3ovRrv
         uaD7h/HL286fyaHjuucPf9LSoyu9lQXoKiQV/VUexU7JbOPAfHiZVE606VAuTidV+E
         n+Kt2TRA0my61BWCkw9OTaCj+UWq3S8yBiSlLLqUp78+HnuuygqYh/vm48iUhXV3+W
         BbLxxZgaEPWflBfgu+OPwmZs4zxlIqn4GWfiWRZWEPkkWoU0ROZ+r5eUDua9u7URsh
         8u01+wfH6W4yw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Georgia Garcia <georgia.garcia@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: mark new functions static
Date:   Fri, 20 Oct 2023 15:12:57 +0200
Message-Id: <20231020131303.785906-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Two new functions were introduced as global functions when they are
only called from inside the file that defines them and should have
been static:

security/apparmor/lsm.c:658:5: error: no previous prototype for 'apparmor_uring_override_creds' [-Werror=missing-prototypes]
security/apparmor/lsm.c:682:5: error: no previous prototype for 'apparmor_uring_sqpoll' [-Werror=missing-prototypes]

Fixes: c4371d90633b7 ("apparmor: add io_uring mediation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/apparmor/lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 91ff91cf1aaef..4981bdf029931 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -655,7 +655,7 @@ static int profile_uring(struct aa_profile *profile, u32 request,
  * Check to see if the current task is allowed to override it's credentials
  * to service an io_uring operation.
  */
-int apparmor_uring_override_creds(const struct cred *new)
+static int apparmor_uring_override_creds(const struct cred *new)
 {
 	struct aa_profile *profile;
 	struct aa_label *label;
@@ -679,7 +679,7 @@ int apparmor_uring_override_creds(const struct cred *new)
  * Check to see if the current task is allowed to create a new io_uring
  * kernel polling thread.
  */
-int apparmor_uring_sqpoll(void)
+static int apparmor_uring_sqpoll(void)
 {
 	struct aa_profile *profile;
 	struct aa_label *label;
-- 
2.39.2

