Return-Path: <linux-kernel+bounces-163534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05718B6CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D6C1C21929
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14B67C082;
	Tue, 30 Apr 2024 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="rBl3fgoB"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC285920
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465444; cv=fail; b=jFDECn5Oreuo4VImrf6M8xSSxgs8FwT7VOeXa+iMtCxOtJckOO0tYx1x2hwvijkiV3r/GaYAPug4DyfQkXnuq04RJv8ccwwCV13LwQ7AVW4L1kKZR0mHZ4eLCs5Sg6Phr4FEUycw5YZOo6UjhslhmCqdSbJkrrDnr0iDyiXg3SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465444; c=relaxed/simple;
	bh=GdRpwOz0bn2OqdiDud8vGmrjRu5WtegbhCuhzUCP1sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=frT3BoYY3wEREEqeTGHGeeKYi8veiNBxQFrG+7Zp2UL5xztuD5VDulIjgXxyceC7uJ0NSff8pQ48GjeuXKR9e2+F09BgHhPDc2h/UQr7fuBJbwd15gauInCjY/NqSG8Q0PeHuuoRF8DlDFs0cMPZ+8yq8wzzBf80OwhflUynPXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=rBl3fgoB; arc=fail smtp.client-ip=40.107.247.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axShy3ecPc5mXcLJZSUAnNn3a2idGThFbwX3oeNYiZjFm7zPQqqjO6cokJwoS6M+40lh39Xl45oXAY5GUnImdvcHbSECSUwsHWeikB4v4SWbmjz5+fSxphDd0yrUkD89B9zsIXa8fqlA8YDPdem3c5Xa1lkV8RSp2ME8/nhmWD4ANulbMD8xdT/iEMxGRwrM7t1OKGj/xIe+FRuBaOlYz4O5k7Y3AW8kNnMkj6vpiVOxJECGFRayBHFi4iobhvmZhSaDHQrLl99C3a9qoHLtDzEFLcQ8mdcLCjnFZY2LFAFOfRoIv4HI2tmoBNMUpvvaRv63b8XdE8aKEQR3AwPo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t0obIAfhWMJxCN0b9NkiSav1HYsII15JjGomu+5TSY=;
 b=ePWh9jt7YXXzp2ht826APktT3ZxrvNxh3CX8/2OzASkOT6JnD5G6OvMokuCqRg6H/0I9uoUb2I6EvpVBAfRfCpmH8fclqjNk+S6Y2T10hqF6mEds8mdhZ0IypmLF4K242OHlbGKGB/zTDtcp+P9Hbemj+pSOJCCjnGFgJBz8y9entCohu7gNogi60mGdz0o8rdZtOcA8mCkgoYch81EHcTjaqGk+iZUnxJkkuTJs/CtFUsJGNalC5udeL7U6fvnFi93Zgu6Etl457Agsy+8wWx4Htd4/vy8QQbxS8p3jMYHaOuanpLhbTOdqmuKCrSnIwvkxVQl6dGCf/LGNgpTB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=de.bosch.com; dmarc=pass (p=reject sp=none pct=100) action=none
 header.from=de.bosch.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t0obIAfhWMJxCN0b9NkiSav1HYsII15JjGomu+5TSY=;
 b=rBl3fgoBZDpmc0PNYu+5F0Xpeav4c8dlfFz78M678Ltuto/1sNTt/T04xDTBTC1yqn75snpV41qSjn0HWRbQ5Rp3LoMm5YoXXLxBBskJseQTOFDGiRMvFpaLGxMSCCj1Di8eXh7jbJI062D70Xl+Nh/UWgtVDdFV+u53Ct/3DIuaoUZ2FCAG8sGUu/LHcGs8/I+OJwd5aOGiktEO1v0bAe5l2MNXZVZhYn3vLxLWY2Gr8JJApTNcyU0dnsE0QhkaN9KpBfmH4D598udJc1nKLuATwzYMpWn4dPIjzA7gpqDsnr7HmdPeg5v2PjcRpkSbt8XpGqM5SW1KTn0Oco8tfw==
Received: from AM0PR04CA0058.eurprd04.prod.outlook.com (2603:10a6:208:1::35)
 by AM7PR10MB3608.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:134::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 08:23:57 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:208:1:cafe::46) by AM0PR04CA0058.outlook.office365.com
 (2603:10a6:208:1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 08:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 08:23:57 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 10:23:41 +0200
Received: from [10.34.222.178] (10.139.217.196) by FE-EXCAS2001.de.bosch.com
 (10.139.217.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Tue, 30 Apr
 2024 10:23:41 +0200
Message-ID: <eadf2812-85c8-4458-b504-10a60a16d1ea@de.bosch.com>
Date: Tue, 30 Apr 2024 10:23:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: core: Make dev->driver usage safe in
 dev_uevent()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, Rafael J Wysocki <rafael@kernel.org>,
	<syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com>, Eugeniu Rosca
	<eugeniu.rosca@bosch.com>
References: <20240430045531.4062232-1-dirk.behme@de.bosch.com>
 <2024043030-remnant-plenty-1eeb@gregkh>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <2024043030-remnant-plenty-1eeb@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM7PR10MB3608:EE_
X-MS-Office365-Filtering-Correlation-Id: 815a53d7-9446-438a-be04-08dc68eee176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE5qMmZnQ2VMVkVuU2t2YldSbzdDRFlsVmtUbGlLaUZIVXVrNC9VRjFyeTRu?=
 =?utf-8?B?YUdqME5pY0xrc3ZPMXJWSWpWZVY0Z3BOYXkvZVY2M0U0TUlRaEphaUV1TUFq?=
 =?utf-8?B?UTRRNzhTUlord1NUMkwrVktqdU1tR3Brc2Z6N3ZyeFNRa3QwbGdoSFpDNi96?=
 =?utf-8?B?Z0pmaWdpeFp3NGcvNlRIdU1FM01hcWgxOXVyN2xQS1FudmJYZWNIcGJFb0Nr?=
 =?utf-8?B?WitjMWN2QVhQNUwyKzdWc1NHVGJwVjVHekczbWgyMzhVYllaR1BDZGQzeVRj?=
 =?utf-8?B?dUN2bFdmbUM1RHM0VnNtQXJTcE1nZ1VGNlJMQUp5eWlYM3pFR0M0M2JDa1F0?=
 =?utf-8?B?RE05TTZwVTN2bnozeTlGQjB1VDNKTWxSUjB2TFpOMUpRZkU1TGVnOElUT0FO?=
 =?utf-8?B?VjNJN2Q1WGhWSmpxcVpKbHVuUjdoVGRFTE4zV3NWMnpHK0NkMWx5LzlMY3hT?=
 =?utf-8?B?V0hSYTliaHZMclZvelVqS1NuT29WSE4yME5QYkIvZ1lNZlU1eUZLR1ZXRk9E?=
 =?utf-8?B?cy95UloxTHlFZzlUUVdRbzk0clZTeXdHWGk3UDkxbWhvRjlkUGh6N3hiUzNU?=
 =?utf-8?B?MUtjRjNQZi9EQVlTQmpmVWg2bm1acjVoR0RkbmhDaSs3MVZnSlVlaC9lWCtp?=
 =?utf-8?B?QWJBNkhWUVcxT1JIeEZMdmZHakxiUjd2ZkozRWtXelNZVER6NDEzTy95VEtM?=
 =?utf-8?B?M1hPd3NTYlFKdE1uUjlWUTUvYWQ5UkVIV2RCWHFZSDZxMkJWTVdMMkJuNnls?=
 =?utf-8?B?WTNCZCtUMTZtS2xZSmg0VHVvenBtbUVxTmxOSStiM3kvOGlWZUFlbVJ0ZmZH?=
 =?utf-8?B?VzIyVVBRQjR1KzdPdDlJdWIyNkxxckNIVnROSkxWRUViZFdNdUJOK1hqbCt0?=
 =?utf-8?B?SVJQUUhjQWhmOWU1MzVnVHlvTlZIeENteTE5bzFReUJDdmtpeEVuRU9PN3lk?=
 =?utf-8?B?ZDJnMjNnOWVUemZSSmtER1grenUwSVlVUnJhRVBpOEpyU1JVM0JKSjgxTEJO?=
 =?utf-8?B?NnpkZTh0UkMrMSsrZTNHckV2cUFhREp0OXFsRk9QMlNCZ2lmK3hHekQyRVVv?=
 =?utf-8?B?ZHFZSy8wdXYrQ0FNbGI2TmVXSDV2T25NemRWMExhaG44QnVNcmZjaytWMUhn?=
 =?utf-8?B?d1dtU3o2VmlJNnhWWFVKbTdWbkhleE5IVGZrSXZMa0VGUGU2d0drQSt5V09U?=
 =?utf-8?B?WFdLRkVNbVBkMFRxaGRDbTlTOWZKcFYvaFVWNVllN2d2NHdyR3Era014ejhz?=
 =?utf-8?B?SFZJMHF2dTJEZVB4RHhCMGJhVFgzVEl1UGlqelVWZkE5dndaektBWGI4VlNo?=
 =?utf-8?B?NklCdmNVU1hGVE5sKzRFekRxQWFQNXhremFUU2dZNnpHTStRNEo3OXQvVzRD?=
 =?utf-8?B?cDg5R0tDY2NaMGFZeTRlNmFKMVBDczAzWHdYSjFkc0N3SXp1angrWkM4MCtR?=
 =?utf-8?B?WCswUDVoaEdqNmRGNkNzcDZwTVhsOFdjL2RUQm9Eck5NMlFsMVlIV1JNZjFT?=
 =?utf-8?B?d1puUWdueXM1dXcwMkJLSFFDZ2R5aGVzT0h0WDh1UGhOVmlqM3JrcmY0djNv?=
 =?utf-8?B?d2YvTTlDdFBndFY5eXh3b051c3hpY1BUdnV3eGxHV1ZqbTluTElTWWkxeVor?=
 =?utf-8?B?bFY3bGt2UG8yUjZWYjdnUnJBVHBybEE3ZklFUy9hRzl5dnRkK21YNUJMK3Fn?=
 =?utf-8?B?dW9yNTg0dXIrdHlZa25ER2FZUU5ub0xhbU1ubDc0RGtONUtkY05zZysxbjM3?=
 =?utf-8?Q?3w5sRUFrNEUA0aPyqPiY/bNk4j8Wlf8UnThL8HA?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:23:57.3303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 815a53d7-9446-438a-be04-08dc68eee176
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3608

Hi Greg,

On 30.04.2024 09:20, Greg Kroah-Hartman wrote:
> On Tue, Apr 30, 2024 at 06:55:31AM +0200, Dirk Behme wrote:
>> Inspired by the function dev_driver_string() in the same file make sure
>> in case of uninitialization dev->driver is used safely in dev_uevent(),
>> as well.
> 
> I think you are racing and just getting "lucky" with your change here,
> just like dev_driver_string() is doing there (that READ_ONCE() really
> isn't doing much to protect you...)
> 
>> This change is based on the observation of the following race condition:
>>
>> Thread #1:
>> ==========
>>
>> really_probe() {
>> ...
>> probe_failed:
>> ...
>> device_unbind_cleanup(dev) {
>>        ...
>>        dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
>>        ...
>>        }
>> ...
>> }
>>
>> Thread #2:
>> ==========
>>
>> dev_uevent() {
> 
> Wait, how can dev_uevent() be called if probe fails?  Who is calling
> that?
> 
>> ...
>> if (dev->driver)
>>        // If dev->driver is NULLed from really_probe() from here on,
>>        // after above check, the system crashes
>>        add_uevent_var(env, "DRIVER=%s", dev->driver->name);
>>
>> dev_driver_string() can't be used here because we want NULL and not
>> anything else in the non-init case.
>>
>> Similar cases are reported by syzkaller in
>>
>> https://syzkaller.appspot.com/bug?extid=ffa8143439596313a85a
>>
>> But these are regarding the *initialization* of dev->driver
>>
>> dev->driver = drv;
>>
>> As this switches dev->driver to non-NULL these reports can be considered
>> to be false-positives (which should be "fixed" by this commit, as well,
>> though).
>>
>> Fixes: 239378f16aa1 ("Driver core: add uevent vars for devices of a class")
>> Cc: syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com
>> Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
>> Tested-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>>   drivers/base/core.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 5f4e03336e68..99ead727c08f 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -2639,6 +2639,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
>>   static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>>   {
>>   	const struct device *dev = kobj_to_dev(kobj);
>> +	struct device_driver *drv;
>>   	int retval = 0;
>>   
>>   	/* add device node properties if present */
>> @@ -2667,8 +2668,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>>   	if (dev->type && dev->type->name)
>>   		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
>>   
>> -	if (dev->driver)
>> -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
>> +	/* dev->driver can change to NULL underneath us because of unbinding
>> +	 * or failing probe(), so be careful about accessing it.
>> +	 */
>> +	drv = READ_ONCE(dev->driver);
>> +	if (drv)
>> +		add_uevent_var(env, "DRIVER=%s", drv->name);
> 
> Again, you are just reducing the window here.  Maybe a bit, but not all
> that much overall as there is no real lock present.
> 
> So how is this actually solving anything?


Looking at dev_driver_string() I hoped that it just reads *once*. I.e. 
we don't care if we read NULL or any valid pointer, as long as this 
pointer read is done only once ("atomically"?). If READ_ONCE() doesn't 
do that, I agree, it's not the (race) fix we are looking for.

Initially, I was thinking about anything like [1] below. I.e. adding a 
mutex lock.  But not sure if that is better (acceptable?).


> And who is calling a uevent
> on a device that is not probed properly?  Userspace? 


To my understanding, yes, user space. The mentioned syzkaller has the 
callstack [2]. To my understanding a dev_info()/dev_err() in the failing 
probe() does trigger systemd-journal/udevd to write that to a log (?).

We are using a (I2C) test module probe() like [3] to trigger this issue. 
If you iterate through the delays you might find a "window" to hit this 
race. Usually, we found a delay between 1 - 2 ms for that.

Best regards

Dirk


[1]

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2a1d3b2a043f..45c6edd90122 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -900,6 +900,7 @@ static int dev_uevent(struct kset *kset, struct 
kobject *kobj,
                       struct kobj_uevent_env *env)
  {
         struct device *dev = kobj_to_dev(kobj);
+       const char *driver_name = NULL;
         int retval = 0;

         /* add device node properties if present */
@@ -928,8 +929,13 @@ static int dev_uevent(struct kset *kset, struct 
kobject *kobj,
         if (dev->type && dev->type->name)
                 add_uevent_var(env, "DEVTYPE=%s", dev->type->name);

+       /* Synchronization with really_probe() modifying dev->driver */
+       device_lock(dev);
         if (dev->driver)
-               add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+               driver_name = dev->driver->name;
+       device_unlock(dev);
+       if (driver_name)
+               add_uevent_var(env, "DRIVER=%s", driver_name);

         /* Add common DT information about the device */
         of_device_uevent(dev, env);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 6143bf085e94..176dc8cd0bb1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -400,7 +400,9 @@ static int really_probe(struct device *dev, struct 
device_driver *drv)
         }

  re_probe:
+       device_lock(dev);
         dev->driver = drv;
+       device_unlock(dev);

         /* If using pinctrl, bind pins now before probing */
         ret = pinctrl_bind_pins(dev);
@@ -472,7 +474,9 @@ static int really_probe(struct device *dev, struct 
device_driver *drv)
         devres_release_all(dev);
         dma_deconfigure(dev);
         driver_sysfs_remove(dev);
+       device_lock(dev);
         dev->driver = NULL;
+       device_unlock(dev);
         dev_set_drvdata(dev, NULL);
         if (dev->pm_domain && dev->pm_domain->dismiss)
                 dev->pm_domain->dismiss(dev);

[2]

read to 0xffff88811759c468 of 8 bytes by task 3901 on cpu 1:
  dev_uevent+0x235/0x380 drivers/base/core.c:2670
  uevent_show+0x10c/0x1f0 drivers/base/core.c:2742
  dev_attr_show+0x3a/0xa0 drivers/base/core.c:2445
  sysfs_kf_seq_show+0x17c/0x250 fs/sysfs/file.c:59
  kernfs_seq_show+0x7c/0x90 fs/kernfs/file.c:205
  seq_read_iter+0x2d7/0x940 fs/seq_file.c:230
  kernfs_fop_read_iter+0xc6/0x310 fs/kernfs/file.c:279
  call_read_iter include/linux/fs.h:2104 [inline]
  new_sync_read fs/read_write.c:395 [inline]
  vfs_read+0x5bc/0x6b0 fs/read_write.c:476
  ksys_read+0xeb/0x1b0 fs/read_write.c:619
  __do_sys_read fs/read_write.c:629 [inline]
  __se_sys_read fs/read_write.c:627 [inline]
  __x64_sys_read+0x42/0x50 fs/read_write.c:627
  x64_sys_call+0x27ad/0x2d30 arch/x86/include/generated/asm/syscalls_64.h:1
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1d0 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[3]

static int waitms = 0;
module_param(waitms, int, 0660);
MODULE_PARM_DESC(waitms, "delay time in ms. If no value is given there 
is no delay (0ms)");

static int waitus = 0;
module_param(waitus, int, 0660);
MODULE_PARM_DESC(waitus, "delay time in us. If no value is given there 
is no delay (0ms)");

static int i2c_dummy_probe(struct i2c_client *client,
				 const struct i2c_device_id *id)
{
	int ret = -ENXIO;

	i2c_set_clientdata(client, NULL);

	if (waitms)
		dev_info(&client->dev, "probe() called. waiting %dms\n", waitms);
	if (waitus)
		dev_info(&client->dev, "probe() called. waiting %dus\n", waitus);

	if (waitms)
		msleep(waitms);

	if (waitus)
		udelay(waitus);

/* failure: */
	/* We intentionally want probe() to return with failure */
	i2c_set_clientdata(client, NULL);
	dev_err(&client->dev, "Error: probe failed with %d\n", ret);
	return ret;
}


