Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5AF78DD32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbjH3SsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343618AbjH3QRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:17:02 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8579E1A3;
        Wed, 30 Aug 2023 09:16:56 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 8838a3f6621ea0da; Wed, 30 Aug 2023 18:16:55 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 74E3966316E;
        Wed, 30 Aug 2023 18:16:54 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v1 2/4] thermal: core: Add function for registering tripless thermal zones
Date:   Wed, 30 Aug 2023 18:13:35 +0200
Message-ID: <3255685.aeNJFYEL58@kreacher>
In-Reply-To: <1870450.tdWV9SEqCh@kreacher>
References: <1870450.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhht
 vghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegrmhhithhksehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Multiple callers of thermal_zone_device_register() don't pass any trips
to it and they might use a shortened argument list for that, so add
a special function with fewer arguments for this purpose.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   11 +++++++++++
 include/linux/thermal.h        |   13 +++++++++++++
 2 files changed, 24 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1400,6 +1400,17 @@ struct thermal_zone_device *thermal_zone
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register);
 
+struct thermal_zone_device *thermal_tripless_zone_device_register(
+					const char *type,
+					void *devdata,
+					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp)
+{
+	return thermal_zone_device_register_with_trips(type, NULL, 0, 0, devdata,
+						       ops, tzp, 0, 0);
+}
+EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
+
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
 {
 	return tzd->devdata;
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -317,6 +317,12 @@ struct thermal_zone_device *thermal_zone
 					const struct thermal_zone_params *tzp,
 					int passive_delay, int polling_delay);
 
+struct thermal_zone_device *thermal_tripless_zone_device_register(
+					const char *type,
+					void *devdata,
+					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp);
+
 void thermal_zone_device_unregister(struct thermal_zone_device *tz);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
@@ -377,6 +383,13 @@ static inline struct thermal_zone_device
 					int passive_delay, int polling_delay);
 { return ERR_PTR(-ENODEV); }
 
+static inline struct thermal_zone_device *thermal_tripless_zone_device_register(
+					const char *type,
+					void *devdata,
+					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp)
+{ return ERR_PTR(-ENODEV); }
+
 static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 { }
 



