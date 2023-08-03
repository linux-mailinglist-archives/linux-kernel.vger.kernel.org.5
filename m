Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B685076F443
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHCUwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHCUwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:52:49 -0400
X-Greylist: delayed 428 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 13:52:47 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D826C11F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:52:47 -0700 (PDT)
Received: from hatter.bewilderbeest.net (63-228-114-1.tukw.qwest.net [63.228.114.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 3BAFE783;
        Thu,  3 Aug 2023 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1691095539;
        bh=rqLvNnIUzrROBT5rajV36LBK+ny6+l2//bZ787j+lX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhL62TV2yHCgtCLXCMNy6nG3wukcImfjmhjBbDWP+XreY0GCrVku3IgD5CDWFhLD0
         8UZLOMEpHD7qYEBrZPyiqgbhjJVMDb/gxuye1Ab2pKaBHewkppUYFM3ag6mYPSVxUR
         x3/MqJ8tP9SjEdzdci9DKx+SL++vEGK1xU84Jo7k=
Date:   Thu, 3 Aug 2023 13:45:37 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: userspace-consumer: Add regulator event
 support
Message-ID: <d3ea0fe2-00bb-493b-aca7-ba7a31bd3c78@hatter.bewilderbeest.net>
References: <20230803111225.107572-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230803111225.107572-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 04:12:25AM PDT, Naresh Solanki wrote:
>Add sysfs attribute to track regulator events received from regulator
>notifier block handler.
>

Hi Naresh,

Could you provide a bit more detail on how this is intended to be used?  
Some of the details (more below) seem a bit odd to me...

>Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>---
> drivers/regulator/userspace-consumer.c | 52 +++++++++++++++++++++++++-
> 1 file changed, 51 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
>index 97f075ed68c9..a0b980022993 100644
>--- a/drivers/regulator/userspace-consumer.c
>+++ b/drivers/regulator/userspace-consumer.c
>@@ -29,6 +29,10 @@ struct userspace_consumer_data {
>
> 	int num_supplies;
> 	struct regulator_bulk_data *supplies;
>+
>+	struct kobject *kobj;
>+	struct notifier_block nb;
>+	unsigned long events;
> };
>
> static ssize_t name_show(struct device *dev,
>@@ -89,12 +93,30 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
> 	return count;
> }
>
>+static DEFINE_MUTEX(events_lock);
>+
>+static ssize_t events_show(struct device *dev,
>+			   struct device_attribute *attr, char *buf)
>+{
>+	struct userspace_consumer_data *data = dev_get_drvdata(dev);
>+	unsigned long e;
>+
>+	mutex_lock(&events_lock);
>+	e = data->events;
>+	data->events = 0;

...particularly this bit -- a read operation on a read-only file (and 
especially one with 0644 permissions) having side-effects (clearing the 
value it accesses) seems on the face of it like fairly surprising 
behavior.  Is this a pattern that's used elsewhere in any other sysfs 
files?

>+	mutex_unlock(&events_lock);
>+
>+	return sprintf(buf, "0x%lx\n", e);
>+}
>+
> static DEVICE_ATTR_RO(name);
> static DEVICE_ATTR_RW(state);
>+static DEVICE_ATTR_RO(events);

New sysfs attributes should be documented in Documentation/ABI, which 
this appears to be missing.

However, it looks like this would expose the values of all the 
REGULATOR_EVENT_* constants as a userspace-visible ABI -- is that 
something we really want to do?

>
> static struct attribute *attributes[] = {
> 	&dev_attr_name.attr,
> 	&dev_attr_state.attr,
>+	&dev_attr_events.attr,
> 	NULL,
> };
>
>@@ -115,12 +137,28 @@ static const struct attribute_group attr_group = {
> 	.is_visible =  attr_visible,
> };
>
>+static int regulator_userspace_notify(struct notifier_block *nb,
>+				      unsigned long event,
>+				      void *ignored)
>+{
>+	struct userspace_consumer_data *data =
>+		container_of(nb, struct userspace_consumer_data, nb);
>+
>+	mutex_lock(&events_lock);
>+	data->events |= event;
>+	mutex_unlock(&events_lock);
>+

Using a single global mutex (events_lock) to protect a single member of 
a per-device struct looks weird.  Unless there's something subtle going 
on that I'm not seeing, it seems like the lock should be a member of the 
data struct instead of global, and since no blocking operations happen 
under it could it just be a spinlock?  Or since it's just some simple 
updates to a single variable, why not just use an atomic_t and skip the 
lock entirely?

>+	sysfs_notify(data->kobj, NULL, dev_attr_events.attr.name);
>+
>+	return NOTIFY_OK;
>+}
>+
> static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> {
> 	struct regulator_userspace_consumer_data tmpdata;
> 	struct regulator_userspace_consumer_data *pdata;
> 	struct userspace_consumer_data *drvdata;
>-	int ret;
>+	int i, ret;
>
> 	pdata = dev_get_platdata(&pdev->dev);
> 	if (!pdata) {
>@@ -153,6 +191,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> 	drvdata->num_supplies = pdata->num_supplies;
> 	drvdata->supplies = pdata->supplies;
> 	drvdata->no_autoswitch = pdata->no_autoswitch;
>+	drvdata->kobj = &pdev->dev.kobj;
>
> 	mutex_init(&drvdata->lock);
>
>@@ -186,6 +225,13 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> 	}
> 	drvdata->enabled = !!ret;
>
>+	drvdata->nb.notifier_call = regulator_userspace_notify;
>+	for (i = 0; i < drvdata->num_supplies; i++) {
>+		ret = devm_regulator_register_notifier(drvdata->supplies[i].consumer, &drvdata->nb);
>+		if (ret)
>+			goto err_enable;
>+	}
>+
> 	return 0;
>
> err_enable:
>@@ -197,6 +243,10 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> static int regulator_userspace_consumer_remove(struct platform_device *pdev)
> {
> 	struct userspace_consumer_data *data = platform_get_drvdata(pdev);
>+	int i;
>+
>+	for (i = 0; i < data->num_supplies; i++)
>+		devm_regulator_unregister_notifier(data->supplies[i].consumer, &data->nb);
>
> 	sysfs_remove_group(&pdev->dev.kobj, &attr_group);
>
>
>base-commit: 4fb53b2377c364e3753d6e293913b57dad68e98b
>-- 
>2.41.0
>
