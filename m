Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE977F75E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351340AbjHQNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351489AbjHQNLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:11:09 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676E735B8;
        Thu, 17 Aug 2023 06:10:40 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 781fc99a341be9fa; Thu, 17 Aug 2023 15:09:35 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0A246662A72;
        Thu, 17 Aug 2023 15:09:35 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v5 05/11] ACPI: thermal: Carry out trip point updates under zone lock
Date:   Thu, 17 Aug 2023 15:09:34 +0200
Message-ID: <3262036.aeNJFYEL58@kreacher>
In-Reply-To: <c53f99db-353a-26c3-3b0a-3a3befbed528@linaro.org>
References: <13318886.uLZWGnKmhe@kreacher> <2236767.iZASKD2KPV@kreacher> <c53f99db-353a-26c3-3b0a-3a3befbed528@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudduuddgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 16, 2023 6:25:30 PM CEST Daniel Lezcano wrote:
> On 07/08/2023 20:08, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > There is a race condition between acpi_thermal_trips_update() and
> > acpi_thermal_check_fn(), because the trip points may get updated while
> > the latter is running which in theory may lead to inconsistent results.
> > For example, if two trips are updated together, using the temperature
> > value of one of them from before the update and the temperature value
> > of the other one from after the update may not lead to the expected
> > outcome.
> > 
> > Moreover, if thermal_get_trend() runs when a trip points update is in
> > progress, it may end up using stale trip point temperatures.
> > 
> > To address this, make acpi_thermal_trips_update() call
> > thermal_zone_device_adjust() to carry out the trip points update and
> > provide a new  acpi_thermal_adjust_thermal_zone() wrapper around
> > __acpi_thermal_trips_update() as the callback function for the latter.
> > 
> > While at it, change the acpi_thermal_trips_update() return data type
> > to void as that function always returns 0 anyway.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> 
> [ ... ]
> 
> >   {
> > -	int i, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
> >   	bool valid;
> > +	int i;
> >   
> > -	if (ret)
> > -		return ret;
> > +	__acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
> >   
> >   	valid = tz->trips.critical.valid |
> >   		tz->trips.hot.valid |
> > @@ -710,6 +732,7 @@ static struct thermal_zone_device_ops ac
> >   	.get_trend = thermal_get_trend,
> >   	.hot = acpi_thermal_zone_device_hot,
> >   	.critical = acpi_thermal_zone_device_critical,
> > +	.update = acpi_thermal_adjust_thermal_zone,
> 
> It is too bad we have to add a callback in the core code just for this 
> driver.
> 
> I'm wondering if it is not possible to get rid of it ?

Well, it is possible to pass the callback as an argument to the function running it.

The code is slightly simpler this way, so I think I'm going to do that.

Please see the appended replacement for patch [02/11].

Of course, it also is possible to provide accessors for acquiring and releasing
the zone lock, which would be more straightforward still (as mentioned before),
but I kind of understand the concerns regarding possible abuse of those by
drivers.

> Is it possible to use an internal lock for the ACPI driver to solve the 
> race issue above ?

No, it is not, and I have already explained it at least once, but let me do
that once again.

There are three code paths that need to be synchronized, because each of them
can run in parallel with any of the other two.

(a) acpi_thermal_trips_update() called via acpi_thermal_notify() which runs
    in the ACPI notify kworker context.
(b) thermal_get_trend(), already called under the zone lock by the core.
(c) acpi_thermal_check_fn() running in a kworker context, which calls
    thermal_zone_device_update() which it turn takes the zone lock.

Also the trip points update should not race with any computations using trip
point temperatures in the core or in the governors (they are carried out under
the zone lock as a rule).

(b) means that the local lock would need to be always taken under the zone
lock and then either acpi_thermal_check_fn() would need to be able to take
the local lock under the zone lock (so it would need to be able to acquire
the zone lock more or less directly), or acpi_thermal_trips_update() can
use the zone lock (which happens in the $subject patch via the new helper
function).

Moreover, using a local lock in acpi_thermal_trips_update() does not provide
any protection for the code using trip temperatures that runs under the zone
lock mentioned above.

So as I said, the patch below replaces [02/11] and it avoids adding a new
callback to zone operations.  The code gets slightly simpler with [02/11]
replaced with the appended one, so I'm going to use the latter.

It requires the $subject patch and patch [11/11] to be rebased, but that
is so trivial that I'm not even going to send updates of these patches.

The current series is available in the acpi-thermal git branch in
linux-pm.git.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] thermal: core: Introduce thermal_zone_device_exec()

Introduce a new helper function, thermal_zone_device_exec(), that can
be used by drivers to run a given callback routine under the zone lock.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   19 +++++++++++++++++++
 include/linux/thermal.h        |    4 ++++
 2 files changed, 23 insertions(+)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -323,6 +323,10 @@ int thermal_zone_unbind_cooling_device(s
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
+void thermal_zone_device_exec(struct thermal_zone_device *tz,
+			      void (*cb)(struct thermal_zone_device *,
+					 unsigned long),
+			      unsigned long data);
 
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -497,6 +497,25 @@ void thermal_zone_device_update(struct t
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
+/**
+ * thermal_zone_device_exec - Run a callback under the zone lock.
+ * @tz: Thermal zone.
+ * @cb: Callback to run.
+ * @data: Data to pass to the callback.
+ */
+void thermal_zone_device_exec(struct thermal_zone_device *tz,
+				void (*cb)(struct thermal_zone_device *,
+					   unsigned long),
+				unsigned long data)
+{
+	mutex_lock(&tz->lock);
+
+	cb(tz, data);
+
+	mutex_unlock(&tz->lock);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_exec);
+
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct



