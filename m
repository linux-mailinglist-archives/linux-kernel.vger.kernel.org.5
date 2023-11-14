Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65F7EA8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjKNCZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 21:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNCZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:25:14 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE825197;
        Mon, 13 Nov 2023 18:25:11 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b2ec9a79bdso3497845b6e.3;
        Mon, 13 Nov 2023 18:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699928710; x=1700533510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKiAJjTNs7WcE2Ce9uXLdnwpO1Y/3hJtt0IPtMHm3js=;
        b=hEDbb3IHpJ5k0clBWkhGqBFd3T5ZBjk4GvUw8ifGKMI+rtb9lC2qv71kTvURv4Nz45
         Nyxnw896+s1Xx1+ckflZKgm5X1KyQLjMIRREdk5ua8b5fOVFMmab2azE/vYMct6lFD6q
         xD7zWAT2ioeia/L3J9S/qxOldFs9QLbBvEjvJjNgCDwC2IdH7YBvA1A/HVJiBWCdP3Rn
         k8pWI9qAh9gbHdaNKN5SZ0aVJAXSWcv6Vcc0UbZ2mB459z0BLxONEx9k18s3NBJWR7Ss
         dUeElvqKC9u47ewLBpo0AMbwVFLfp0X9u5CYJ3O+jtGxthpjrRZ6MbfhE95KvJmZLtSM
         u8Mg==
X-Gm-Message-State: AOJu0Yz6yGmTOE9G4K9drY+SmXGpCaxECfZMeT2fCYkcTlFKuFSkwU8a
        qW4MxWtLsuK//HIgtbauOG3tr1YLCyI=
X-Google-Smtp-Source: AGHT+IE9QDBnNpH0wQx7gD5eO3HmdTyHHogcdgpPK6w7OvsO5lMfGXHW6+PToaJwx3oe35bSmmW/VQ==
X-Received: by 2002:a05:6808:a94:b0:3b0:d583:dc4 with SMTP id q20-20020a0568080a9400b003b0d5830dc4mr10042988oij.54.1699928710614;
        Mon, 13 Nov 2023 18:25:10 -0800 (PST)
Received: from localhost.localdomain ([2001:569:5237:2a00:8821:5c5b:1bed:aff7])
        by smtp.gmail.com with ESMTPSA id fj35-20020a056a003a2300b006c34a39eeb9sm244052pfb.218.2023.11.13.18.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 18:25:10 -0800 (PST)
From:   Kelvie Wong <kelvie@kelvie.ca>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Kelvie Wong <kelvie@kelvie.ca>
Subject: [PATCH RFC] Add a lockdown_hibernate parameter
Date:   Mon, 13 Nov 2023 18:23:11 -0800
Message-ID: <20231114022503.6310-1-kelvie@kelvie.ca>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the user to tell the kernel that they know better (namely,
they secured their swap properly), and that it can enable hibernation.

I've been using this for about a year now, as it doesn't seem like
proper secure hibernation was going to be implemented back then, and
it's now been a year since I've been building my own kernels with this
patch, so getting this upstreamed would save some CO2 from me building
my own kernels every upgrade.

Some other not-me users have also tested the patch:

https://community.frame.work/t/guide-fedora-36-hibernation-with-enabled-secure-boot-and-full-disk-encryption-fde-decrypting-over-tpm2/25474/17

Signed-off-by: Kelvie Wong <kelvie@kelvie.ca>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/power/hibernate.c                        | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 426fa892d311..54785faba9e0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2804,6 +2804,11 @@
 			to extract confidential information from the kernel
 			are also disabled.
 
+	lockdown_hibernate	[HIBERNATION]
+			Enable hibernation even if lockdown is enabled. Enable this only if
+			your swap is encrypted and secured properly, as an attacker can
+			modify the kernel offline during hibernation.
+
 	locktorture.nreaders_stress= [KNL]
 			Set the number of locking read-acquisition kthreads.
 			Defaults to being automatically set based on the
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 89c71fce225d..2221c531d54c 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -36,6 +36,7 @@
 #include "power.h"
 
 
+static int lockdown_hibernate;
 static int nocompress;
 static int noresume;
 static int nohibernate;
@@ -82,7 +83,7 @@ void hibernate_release(void)
 bool hibernation_available(void)
 {
 	return nohibernate == 0 &&
-		!security_locked_down(LOCKDOWN_HIBERNATION) &&
+		(lockdown_hibernate || !security_locked_down(LOCKDOWN_HIBERNATION)) &&
 		!secretmem_active() && !cxl_mem_active();
 }
 
@@ -1340,6 +1341,12 @@ static int __init nohibernate_setup(char *str)
 	return 1;
 }
 
+static int __init lockdown_hibernate_setup(char *str)
+{
+	lockdown_hibernate = 1;
+	return 1;
+}
+
 __setup("noresume", noresume_setup);
 __setup("resume_offset=", resume_offset_setup);
 __setup("resume=", resume_setup);
@@ -1347,3 +1354,4 @@ __setup("hibernate=", hibernate_setup);
 __setup("resumewait", resumewait_setup);
 __setup("resumedelay=", resumedelay_setup);
 __setup("nohibernate", nohibernate_setup);
+__setup("lockdown_hibernate", lockdown_hibernate_setup);
-- 
2.37.3

