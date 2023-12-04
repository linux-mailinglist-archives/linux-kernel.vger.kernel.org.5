Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A7803EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjLDTtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDTtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:49:21 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD2C1;
        Mon,  4 Dec 2023 11:49:28 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 83275814bbd9dbf2; Mon, 4 Dec 2023 20:49:26 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 44A11668764;
        Mon,  4 Dec 2023 20:49:26 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 3/3] thermal: netlink: Use for_each_trip() in thermal_genl_cmd_tz_get_trip()
Date:   Mon, 04 Dec 2023 20:49:03 +0100
Message-ID: <2912793.e9J7NaK4W3@kreacher>
In-Reply-To: <5733564.DvuYhMxLoT@kreacher>
References: <5733564.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhr
 ihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make thermal_genl_cmd_tz_get_trip() use for_each_trip() instead of an open-
coded loop over trip indices.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_netlink.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -450,10 +450,10 @@ out_cancel_nest:
 static int thermal_genl_cmd_tz_get_trip(struct param *p)
 {
 	struct sk_buff *msg = p->msg;
+	const struct thermal_trip *trip;
 	struct thermal_zone_device *tz;
 	struct nlattr *start_trip;
-	struct thermal_trip trip;
-	int ret, i, id;
+	int id;
 
 	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
 		return -EINVAL;
@@ -470,16 +470,12 @@ static int thermal_genl_cmd_tz_get_trip(
 
 	mutex_lock(&tz->lock);
 
-	for (i = 0; i < tz->num_trips; i++) {
-
-		ret = __thermal_zone_get_trip(tz, i, &trip);
-		if (ret)
-			goto out_cancel_nest;
-
-		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, i) ||
-		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip.type) ||
-		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, trip.temperature) ||
-		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, trip.hysteresis))
+	for_each_trip(tz, trip) {
+		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID,
+				thermal_zone_trip_id(tz, trip)) ||
+		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip->type) ||
+		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, trip->temperature) ||
+		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, trip->hysteresis))
 			goto out_cancel_nest;
 	}
 



