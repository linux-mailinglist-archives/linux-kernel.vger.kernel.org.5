Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78F76FFDC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjHDMCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHDMCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:02:06 -0400
X-Greylist: delayed 54983 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 05:02:03 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7AB1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:02:03 -0700 (PDT)
Received: from hatter.bewilderbeest.net (63-228-114-1.tukw.qwest.net [63.228.114.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 886647FE;
        Fri,  4 Aug 2023 05:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1691150523;
        bh=P75iOFLVIMOLdegGcjsSjikSFGkZ0kg0NdzDI15wre8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXnAZaJWBgAPO3GzHe+l83YYdVusf1I+QC6KR+mJfYNw2ksWyooMfuCi1O5Gxx/vx
         mYXJaTqvNZRUsUwFsTejiMAFGUaUw74XHIxG4fm2nXNiF2Ty3zPl8YexqwGKI4QqjQ
         Lms3StD7RFmDST3dtD5d0Asfh5gJMerYe59Zbsy0=
Date:   Fri, 4 Aug 2023 05:02:02 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: userspace-consumer: Add regulator event
 support
Message-ID: <0643fa76-5320-4e1a-84d4-c3be4b1d1df6@hatter.bewilderbeest.net>
References: <20230803111225.107572-1-Naresh.Solanki@9elements.com>
 <d3ea0fe2-00bb-493b-aca7-ba7a31bd3c78@hatter.bewilderbeest.net>
 <CABqG17j1KGoW3UVM1kttg08V0R0xC0gP3YOyE7DeboE4SWa+vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CABqG17j1KGoW3UVM1kttg08V0R0xC0gP3YOyE7DeboE4SWa+vw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 01:59:44AM PDT, Naresh Solanki wrote:
>Hi Zev,
>
>
>On Fri, 4 Aug 2023 at 02:15, Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> On Thu, Aug 03, 2023 at 04:12:25AM PDT, Naresh Solanki wrote:
>> >Add sysfs attribute to track regulator events received from regulator
>> >notifier block handler.
>> >
>>
>> Hi Naresh,
>>
>> Could you provide a bit more detail on how this is intended to be used?
>> Some of the details (more below) seem a bit odd to me...
>My application registers a event callback on the 'events' to track regulator
>events
>Reference:
>https://github.com/9elements/pwrseqd/blob/main/src/VoltageRegulatorSysfs.cpp#L258
>>
>> >Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> >---
>> > drivers/regulator/userspace-consumer.c | 52 +++++++++++++++++++++++++-
>> > 1 file changed, 51 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
>> >index 97f075ed68c9..a0b980022993 100644
>> >--- a/drivers/regulator/userspace-consumer.c
>> >+++ b/drivers/regulator/userspace-consumer.c
>> >@@ -29,6 +29,10 @@ struct userspace_consumer_data {
>> >
>> >       int num_supplies;
>> >       struct regulator_bulk_data *supplies;
>> >+
>> >+      struct kobject *kobj;
>> >+      struct notifier_block nb;
>> >+      unsigned long events;
>> > };
>> >
>> > static ssize_t name_show(struct device *dev,
>> >@@ -89,12 +93,30 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>> >       return count;
>> > }
>> >
>> >+static DEFINE_MUTEX(events_lock);
>> >+
>> >+static ssize_t events_show(struct device *dev,
>> >+                         struct device_attribute *attr, char *buf)
>> >+{
>> >+      struct userspace_consumer_data *data = dev_get_drvdata(dev);
>> >+      unsigned long e;
>> >+
>> >+      mutex_lock(&events_lock);
>> >+      e = data->events;
>> >+      data->events = 0;
>>
>> ...particularly this bit -- a read operation on a read-only file (and
>> especially one with 0644 permissions) having side-effects (clearing the
>> value it accesses) seems on the face of it like fairly surprising
>> behavior.  Is this a pattern that's used elsewhere in any other sysfs
>> files?
>These are regulator events & are valid when it occurs.
>Userspace application is intended to consume them as soon as the
>event is notified by kernel sysfs_notify.
>

Sure, but that doesn't really address what I was concerned about -- as 
written this is a read operation on a read-only file (0444, not 0644 as 
I mistakenly wrote above) that nevertheless alters the state of an 
internal kernel data structure.  Can you point to any other sysfs 
attributes that behave like that?  I can't think of one offhand, and I'd 
be reluctant to establish the precedent.

Would a uevent-based mechanism maybe be a better fit for the problem 
you're trying to solve?

>>
>> >+      mutex_unlock(&events_lock);
>> >+
>> >+      return sprintf(buf, "0x%lx\n", e);
>> >+}
>> >+
>> > static DEVICE_ATTR_RO(name);
>> > static DEVICE_ATTR_RW(state);
>> >+static DEVICE_ATTR_RO(events);
>>
>> New sysfs attributes should be documented in Documentation/ABI, which
>> this appears to be missing.
>Sure I can check.
>>
>> However, it looks like this would expose the values of all the
>> REGULATOR_EVENT_* constants as a userspace-visible ABI -- is that
>> something we really want to do?
>Yes.

Given that the REGULATOR_EVENT_* constants are defined in headers under 
include/linux and not include/uapi, it doesn't seem like they were 
intended to be used as part of a userspace-visible interface.  If 
they're going to be, I think they should be moved to the uapi directory 
so that applications can use the proper definitions from the kernel 
instead of manually replicating it on their own (but I suspect we should 
probably find a different approach instead).

>>
>> >
>> > static struct attribute *attributes[] = {
>> >       &dev_attr_name.attr,
>> >       &dev_attr_state.attr,
>> >+      &dev_attr_events.attr,
>> >       NULL,
>> > };
>> >
>> >@@ -115,12 +137,28 @@ static const struct attribute_group attr_group = {
>> >       .is_visible =  attr_visible,
>> > };
>> >
>> >+static int regulator_userspace_notify(struct notifier_block *nb,
>> >+                                    unsigned long event,
>> >+                                    void *ignored)
>> >+{
>> >+      struct userspace_consumer_data *data =
>> >+              container_of(nb, struct userspace_consumer_data, nb);
>> >+
>> >+      mutex_lock(&events_lock);
>> >+      data->events |= event;
>> >+      mutex_unlock(&events_lock);
>> >+
>>
>> Using a single global mutex (events_lock) to protect a single member of
>> a per-device struct looks weird.  Unless there's something subtle going
>> on that I'm not seeing, it seems like the lock should be a member of the
>> data struct instead of global, and since no blocking operations happen
>> under it could it just be a spinlock?  Or since it's just some simple
>> updates to a single variable, why not just use an atomic_t and skip the
>> lock entirely?
>Intent is that only one thread at a time is to be allowed to access/modify
>the data->events variable to prevent potential data corruption and
>race conditions. Sure can change it to spinlock or atomic_t.
>
>>
>> >+      sysfs_notify(data->kobj, NULL, dev_attr_events.attr.name);
>> >+
>> >+      return NOTIFY_OK;
>> >+}
>> >+
>> > static int regulator_userspace_consumer_probe(struct platform_device *pdev)
>> > {
>> >       struct regulator_userspace_consumer_data tmpdata;
>> >       struct regulator_userspace_consumer_data *pdata;
>> >       struct userspace_consumer_data *drvdata;
>> >-      int ret;
>> >+      int i, ret;
>> >
>> >       pdata = dev_get_platdata(&pdev->dev);
>> >       if (!pdata) {
>> >@@ -153,6 +191,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
>> >       drvdata->num_supplies = pdata->num_supplies;
>> >       drvdata->supplies = pdata->supplies;
>> >       drvdata->no_autoswitch = pdata->no_autoswitch;
>> >+      drvdata->kobj = &pdev->dev.kobj;
>> >
>> >       mutex_init(&drvdata->lock);
>> >
>> >@@ -186,6 +225,13 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
>> >       }
>> >       drvdata->enabled = !!ret;
>> >
>> >+      drvdata->nb.notifier_call = regulator_userspace_notify;
>> >+      for (i = 0; i < drvdata->num_supplies; i++) {
>> >+              ret = devm_regulator_register_notifier(drvdata->supplies[i].consumer, &drvdata->nb);
>> >+              if (ret)
>> >+                      goto err_enable;
>> >+      }
>> >+
>> >       return 0;
>> >
>> > err_enable:
>> >@@ -197,6 +243,10 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
>> > static int regulator_userspace_consumer_remove(struct platform_device *pdev)
>> > {
>> >       struct userspace_consumer_data *data = platform_get_drvdata(pdev);
>> >+      int i;
>> >+
>> >+      for (i = 0; i < data->num_supplies; i++)
>> >+              devm_regulator_unregister_notifier(data->supplies[i].consumer, &data->nb);
>> >
>> >       sysfs_remove_group(&pdev->dev.kobj, &attr_group);
>> >
>> >
>> >base-commit: 4fb53b2377c364e3753d6e293913b57dad68e98b
>> >--
>> >2.41.0
>> >
