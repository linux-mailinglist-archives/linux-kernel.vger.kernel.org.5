Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C927A76CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjITJEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjITJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:03:44 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97738E52
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:02:51 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 35CB38A;
        Wed, 20 Sep 2023 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1695200571;
        bh=LqQi9cbwVGnsnr4W3l34OevCOxKkaiW8cXfPwk3LzP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Al2gktbhpjdT2t7pmqjibmiq7Z9pGqUlsIsCZDH98Ame25hx3o9F4nESrTZtqBruj
         b7UkdIsW4gwY2RX6IIRVXRGcBRYMDrvlgkWYRQbg8thmzOeaQzJNwScUz5q+ztYPtq
         csHDedlms1SnD+QOYDtDztHaqXwSi0vrGZKtxwu0=
Date:   Wed, 20 Sep 2023 02:02:49 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: ABI: sysfs-driver-regulator-output
Message-ID: <25844d80-fadb-44c3-a0e6-334aa6e4afd7@hatter.bewilderbeest.net>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
 <90b1af83-cb03-476f-9147-eb06247bf09c@hatter.bewilderbeest.net>
 <2023090330-bling-mammary-3177@gregkh>
 <6eb78818-7838-4616-bf44-05c215bfa8b3@hatter.bewilderbeest.net>
 <763bd845-d8d6-489c-bd31-305ed14bc40f@sirena.org.uk>
 <1518370c-e0cd-4d78-af54-3e2cf4dd6e3c@hatter.bewilderbeest.net>
 <5282acd1-3c7a-4948-83f2-2829910ab841@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5282acd1-3c7a-4948-83f2-2829910ab841@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 07:03:47AM PDT, Mark Brown wrote:
>On Sun, Sep 10, 2023 at 01:50:37PM -0700, Zev Weiss wrote:
>> On Mon, Sep 04, 2023 at 05:24:31AM PDT, Mark Brown wrote:
>
>> > It's a clear on read interrupt.
>
>> Sure, analogous behavior in hardware is reasonably common, but that doesn't
>> strike me as a very compelling reason to design the kernel<->userspace
>> interface to mimic it -- providing nicer interfaces than the raw hardware is
>> one of the main reasons for having an OS in the first place, after all.
>
>If it were something other than the userspace consumer I'd be a bit more
>concerned but that's all sharp edges and direct access in a very
>controlled system.  In any case clear on write is the obvious
>alternative approach.

I'm using this driver in production systems, and I think 
Naresh/9elements do or intend to as well (and in my case at least, 
they're systems human operators can and do log in to).  I, for one, 
would thus very much prefer it be treated as a first-class citizen and 
afforded considerations of robustness and such as with any other driver.  
(I'm not entirely sure what other sharp edges with it you're referring 
to.)

To make a slightly more concrete proposal (or perhaps just flesh out one 
I vaguely gestured at previously), how about something along the lines 
of the below, as a modification on top of Naresh's patch -- most of the 
code to do it via uevents is already there anyway.  With this code in 
place I can run 'udevadm monitor -p' and see the expected events 
delivered when I manually enable & disable the regulator via its 'state' 
sysfs attribute, which I think basically fulfills the requirements we're 
aiming for?  Naresh, could using netlink/uevents work for your needs?


Thanks,
Zev


diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 74247e526a42..df783ca02757 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -32,7 +32,6 @@ struct userspace_consumer_data {
  
  	struct kobject *kobj;
  	struct notifier_block nb;
-	unsigned long events;
  };
  
  static ssize_t name_show(struct device *dev,
@@ -93,30 +92,12 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
  	return count;
  }
  
-static DEFINE_SPINLOCK(events_lock);
-
-static ssize_t events_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
-{
-	struct userspace_consumer_data *data = dev_get_drvdata(dev);
-	unsigned long e;
-
-	spin_lock(&events_lock);
-	e = data->events;
-	data->events = 0;
-	spin_unlock(&events_lock);
-
-	return sprintf(buf, "0x%lx\n", e);
-}
-
  static DEVICE_ATTR_RO(name);
  static DEVICE_ATTR_RW(state);
-static DEVICE_ATTR_RO(events);
  
  static struct attribute *attributes[] = {
  	&dev_attr_name.attr,
  	&dev_attr_state.attr,
-	&dev_attr_events.attr,
  	NULL,
  };
  
@@ -137,19 +118,35 @@ static const struct attribute_group attr_group = {
  	.is_visible =  attr_visible,
  };
  
+/*
+ * This will of course need more of a real implementation (handling more than
+ * a single set event bit) and should probably live somewhere else, but for
+ * the sake of brevity...
+ */
+static const char *regulator_event_str(unsigned long event)
+{
+	switch (event) {
+	case REGULATOR_EVENT_PRE_DISABLE:
+		return "pre-disable";
+	case REGULATOR_EVENT_DISABLE:
+		return "disable";
+	case REGULATOR_EVENT_ENABLE:
+		return "enable";
+	default:
+		return "NYI";
+	}
+}
+
  static int regulator_userspace_notify(struct notifier_block *nb,
  				      unsigned long event,
  				      void *ignored)
  {
  	struct userspace_consumer_data *data =
  		container_of(nb, struct userspace_consumer_data, nb);
-	static const char * const *envp[] = { "NAME=events", NULL };
-
-	spin_lock(&events_lock);
-	data->events |= event;
-	spin_unlock(&events_lock);
+	char eventstr[128];
+	char *envp[] = { "NAME=event", eventstr, NULL };
  
-	sysfs_notify(data->kobj, NULL, dev_attr_events.attr.name);
+	scnprintf(eventstr, sizeof(eventstr), "EVENT=%s", regulator_event_str(event));
  	kobject_uevent_env(data->kobj, KOBJ_CHANGE, envp);
  
  	return NOTIFY_OK;

