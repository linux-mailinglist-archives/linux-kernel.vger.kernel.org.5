Return-Path: <linux-kernel+bounces-1541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBB6814FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117821F24521
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC843DB84;
	Fri, 15 Dec 2023 18:47:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A6841843;
	Fri, 15 Dec 2023 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2C96C15;
	Fri, 15 Dec 2023 10:48:40 -0800 (PST)
Received: from [10.57.85.151] (unknown [10.57.85.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09F173F738;
	Fri, 15 Dec 2023 10:47:53 -0800 (PST)
Message-ID: <cd717e08-1f53-47c3-902d-56f4a8d80f46@arm.com>
Date: Fri, 15 Dec 2023 18:48:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Various Exynos targets never return to no cooling
Content-Language: en-US
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20231213134258eucas1p23b66a7989c326176386f4a7c619cde75@eucas1p2.samsung.com>
 <20231213134235.1607510-1-m.majewski2@samsung.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231213134235.1607510-1-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mateusz,

On 12/13/23 13:42, Mateusz Majewski wrote:
> Hi,
> 
>> I understand your requirement for the interrupts only mode, but
>> maybe till the moment there is no fix upstream, you can enable
>> it as well?
> 
> We (actually Marek and independently another coworker) had an idea how
> to solve this while still avoiding polling all the time, and it turned
> out to be quite simple to implement (PoC-quality). The idea was to run
> several cycles of polling after each interrupt. This could be done like
> this:

That's cool PoC, if we don't find any other solution, we would have
consider it as well. So let's try first tackle from other angle...

> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 6482513bfe66..b4bffe405194 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -760,6 +760,12 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
>   {
>   	struct exynos_tmu_data *data = id;
>   
> +	/* TODO: would need some API */
> +	mutex_lock(&data->tzd->lock);
> +	data->tzd->additional_poll_reps = 10;
> +	data->tzd->additional_poll_jiffies = HZ / 10;
> +	mutex_unlock(&data->tzd->lock);
> +
>   	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
>   
>   	mutex_lock(&data->lock);
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 625ba07cbe2f..c825d068402f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -299,12 +299,24 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>   
>   static void monitor_thermal_zone(struct thermal_zone_device *tz)
>   {
> +	unsigned long delay;
> +
>   	if (tz->mode != THERMAL_DEVICE_ENABLED)
> -		thermal_zone_device_set_polling(tz, 0);
> +		delay = 0;
>   	else if (tz->passive)
> -		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
> +		delay = tz->passive_delay_jiffies;
>   	else if (tz->polling_delay_jiffies)
> -		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
> +		delay = tz->polling_delay_jiffies;
> +	else
> +		delay = 0; /* TODO: ??? */
> +
> +	if (tz->additional_poll_reps > 0) {
> +		tz->additional_poll_reps -= 1;
> +		if (delay == 0 || tz->additional_poll_jiffies < delay)
> +			delay = tz->additional_poll_jiffies;
> +	}
> +
> +	thermal_zone_device_set_polling(tz, delay);
>   }
>   
>   static void handle_non_critical_trips(struct thermal_zone_device *tz,
> @@ -425,6 +437,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
>   	tz->temperature = THERMAL_TEMP_INVALID;
>   	tz->prev_low_trip = -INT_MAX;
>   	tz->prev_high_trip = INT_MAX;
> +	tz->additional_poll_jiffies = 0;
> +	tz->additional_poll_reps = 0;
>   	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
>   		pos->initialized = false;
>   }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index c7190e2dfcb4..576b1f3ef25d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -172,6 +172,8 @@ struct thermal_zone_device {
>   	int passive;
>   	int prev_low_trip;
>   	int prev_high_trip;
> +	int additional_poll_reps;
> +	unsigned long additional_poll_jiffies;
>   	atomic_t need_update;
>   	struct thermal_zone_device_ops *ops;
>   	struct thermal_zone_params *tzp;
> 
> In my tests this is enough to resolve the issue consistently on both
> TM2E and XU4, both before and after my other patchset.
> 
> To be honest, this is not the most elegant solution probably and it
> still doesn't really take into account the governor needs. Therefore, if
> 
>> Regarding this topic, I just wanted to tell you that I had conversation
>> with Rafael & Daniel last Fri. Rafael gave me a hint to his latest work
>> in his repo regarding potentially similar race with temperature value.
> 
> brings a better solution, it would be great :)
> 

I have spent some time to better understand the machinery in those
updates and notifications in the core and the governors. I've also
checked the hint from Rafael about maybe similar trip & temp dance.
(that change is in PM linux-next:
"44844db91397 thermal: core: Add trip thresholds for trip crossing 
detection")

Unfortunately, that won't help, since in this TMU we get the
temperature value wrong sometimes IIUC (CMIIW).

Are we able inside the exynos_tmu_threaded_irq() get information
which of the 2 (3 if count critical) IRQs for low_temp, high_temp
has triggered?
I can see in the ->tmu_clear_irqs() we read the IRQ pending reg.
If we are able to say which of the two temp values triggered
that action, then thermal framework shouldn't ignore that and use
extra features to mitigate the glitching of the temp value.
IMO it would be correct because IRQ was triggered based on physics
so the value that we would pass and use is valid.
You would probably need to properly track those temp values and where
you are with the programmed trips (some extra context in the driver).

The exynos_get_temp() needs to work like today - no faking temperature,
no filtering, etc, always report best known temp from that reg.
Different components in thermal can read that temp e.g. sysfs.

In all governors 'tz->temperature' is used, which is good (not the
tz->ops->get_temp(). So let's try to introduce something simple:

----------------------------------------8<---------------------------

diff --git a/drivers/thermal/samsung/exynos_tmu.c 
b/drivers/thermal/samsung/exynos_tmu.c
index 667bb18205fc..345ea0836b99 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -786,8 +786,13 @@ static int exynos7_tmu_read(struct exynos_tmu_data 
*data)
  static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
  {
         struct exynos_tmu_data *data = id;
+       int temp;

-       thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
+       temp = exynos_determine_temp_based_on_irq(data);
+
+       thermal_zone_device_update_with_temp(data->tzd,
+                               THERMAL_EVENT_TEMP_SAMPLE,
+                               temp);

         mutex_lock(&data->lock);
         clk_enable(data->clk);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9c17d35ccbbd..4cdc7b7eed1e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -495,6 +495,43 @@ void thermal_zone_device_update(struct 
thermal_zone_device *tz,
  }
  EXPORT_SYMBOL_GPL(thermal_zone_device_update);

+void thermal_zone_device_update_with_temp(struct thermal_zone_device *tz,
+                                         enum thermal_notify_event event,
+                                         int temp)
+{
+       const struct thermal_trip *trip;
+
+       mutex_lock(&tz->lock);
+       if (device_is_registered(&tz->device))
+               goto unlock;
+
+       if (atomic_read(&in_suspend))
+               goto unlock;
+
+       if (!thermal_zone_device_is_enabled(tz))
+               goto unlock;
+
+       tz->last_temperature = tz->temperature;
+       tz->temperature = temp;
+
+       trace_thermal_temperature(tz);
+
+       thermal_genl_sampling_temp(tz->id, temp);
+
+       __thermal_zone_set_trips(tz);
+
+       tz->notify_event = event;
+
+       for_each_trip(tz, trip)
+               handle_thermal_trip(tz, trip);
+
+       monitor_thermal_zone(tz);
+
+unlock:
+       mutex_unlock(&tz->lock);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_update_with_temp);
+
  static void thermal_zone_device_check(struct work_struct *work)
  {
         struct thermal_zone_device *tz = container_of(work, struct
-------------------------------->8-----------------------------------

There is this event not used in thermal fwk: THERMAL_EVENT_TEMP_SAMPLE,
which could also suit here.

Some extras:
There is a callback which is used in step_wise governor:
get_tz_trend()
      tz->ops->get_trend()
which is not implemented in the Exynos TMU tz. We can use it
and provide the trend, if we still have to after this modification.

Beside:
1. This new API function should be faster on some devices, e.g.
those which has temperature sensor attached to some slow bus
(I have heard about temperature overhead even a few
milli-seconds)
2. Sounds to re-use the information from such drivers like
this Exynos which has IRQs for particular temp value and
can avoid 2nd reading, which might cause confusion by providing
different value due to glitch/rounding.

So I think I could justify this new API interface.

Let me know what you think about this approach.

Regards,
Lukasz

