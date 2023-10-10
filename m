Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37FC7C4557
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjJJXQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJJXQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:16:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5888E;
        Tue, 10 Oct 2023 16:16:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AD1C433C7;
        Tue, 10 Oct 2023 23:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696979781;
        bh=+/tFFsbWCbzFmHJU9b80+XvPt1sCZXKDdVVDEtowj5w=;
        h=From:To:Cc:Subject:Date:From;
        b=pXMC74Z2Goa7waeHAX/KsqDoV1yCMsrupkzcpVrj5XXkaT3LTE7a9taVjXKYBTs1z
         wF60FN1h8iUIy73IMhLuofGTHlv1Z3ma9CHfpdGCtHeczFeXQITbuXWo2qR2qW7OKX
         8CwabQbTWuOoRCytmGKySX+cP90SJgKYY4o4jSmaVD/CtNtbx0XR+UfxyrIQ6aEmk2
         8HZN+0ubURxTGMGvJqmGKefQGxIvMbbX4BNv5Wh5puB03yEphVNrg46Tu9g/kHSzp4
         XefdyPR+/1YqAktmK4M23sPvL29jBcAPojx0CoFY70NFm5qzU0nP2SGw/9t1BYgqpE
         AwFNBCACjQJ7g==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     keyrings@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org (open list:KEYS-TRUSTED),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] KEYS: trusted: Rollback init_trusted() consistently
Date:   Wed, 11 Oct 2023 02:16:16 +0300
Message-Id: <20231010231616.3122392-1-jarkko@kernel.org>
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

Do bind neither static calls nor trusted_key_exit() before a successful
init, in order to maintain a consistent state. In addition, depart the
init_trusted() in the case of a real error (i.e. getting back something
else than -ENODEV).

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/linux-integrity/CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com/
Cc: stable@vger.kernel.org # v5.13+
Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 85fb5c22529a..fee1ab2c734d 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -358,17 +358,17 @@ static int __init init_trusted(void)
 		if (!get_random)
 			get_random = kernel_get_random;
 
-		static_call_update(trusted_key_seal,
-				   trusted_key_sources[i].ops->seal);
-		static_call_update(trusted_key_unseal,
-				   trusted_key_sources[i].ops->unseal);
-		static_call_update(trusted_key_get_random,
-				   get_random);
-		trusted_key_exit = trusted_key_sources[i].ops->exit;
-		migratable = trusted_key_sources[i].ops->migratable;
-
 		ret = trusted_key_sources[i].ops->init();
-		if (!ret)
+		if (!ret) {
+			static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
+			static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
+			static_call_update(trusted_key_get_random, get_random);
+
+			trusted_key_exit = trusted_key_sources[i].ops->exit;
+			migratable = trusted_key_sources[i].ops->migratable;
+		}
+
+		if (!ret || ret != -ENODEV)
 			break;
 	}
 
-- 
2.39.2

