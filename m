Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791CE797924
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbjIGRD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjIGRD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:03:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659081FDC;
        Thu,  7 Sep 2023 10:03:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 341692187B;
        Thu,  7 Sep 2023 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694105555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4CViMOoPfZYMVVg2g3Ck1Pi4dtsEvBr/cA2U0br7Okw=;
        b=sMXGtweBd2VGVFV79kut/M/2QvpaNuiPG4LQTCcw+Up4FXGCKAIPGFNOAR3gTtGiq3CaPO
        vkT7XE1clY+iHXBJp+y+iLRcqNWtBvZV1U3XqrsqHc9YmysioXbYmu9IfxKz+eQdexgKar
        yDuVkkn9V7TGlwTfvV3ZO3QUqFuDw4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694105555;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4CViMOoPfZYMVVg2g3Ck1Pi4dtsEvBr/cA2U0br7Okw=;
        b=mLX722n7X0xx4fuUvOt2l+0W3MoZ07NaOgu6Aexy3o7jiuiXj0vrbnzw5eKkDwkz/6KGLx
        qcRFE2vc0FbVq5Dg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 7645C2C142;
        Thu,  7 Sep 2023 16:52:34 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-integrity@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joeyli <jlee@suse.com>
Subject: [PATCH] integrity: powerpc: Do not select CA_MACHINE_KEYRING
Date:   Thu,  7 Sep 2023 18:52:19 +0200
Message-ID: <20230907165224.32256-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No other platform needs CA_MACHINE_KEYRING, either.

This is policy that should be decided by the administrator, not Kconfig
dependencies.

cc: joeyli <jlee@suse.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 security/integrity/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 232191ee09e3..b6e074ac0227 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -68,8 +68,6 @@ config INTEGRITY_MACHINE_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
 	depends on SYSTEM_BLACKLIST_KEYRING
 	depends on LOAD_UEFI_KEYS || LOAD_PPC_KEYS
-	select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
-	select INTEGRITY_CA_MACHINE_KEYRING_MAX if LOAD_PPC_KEYS
 	help
 	 If set, provide a keyring to which Machine Owner Keys (MOK) may
 	 be added. This keyring shall contain just MOK keys.  Unlike keys
-- 
2.41.0

