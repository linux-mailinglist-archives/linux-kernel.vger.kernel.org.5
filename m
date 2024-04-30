Return-Path: <linux-kernel+bounces-163593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A92A8B6D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080A61F21F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FA4127B78;
	Tue, 30 Apr 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="J52oAJEY"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF41292FC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467072; cv=fail; b=sHg1wjlxRJ0Aw4B8Es/i5v/frbB5GteXEe2N3eCTF+RTVEWpIG8pwBLDoNpGMtzCAoI7WwiXW4UrQXIGu+dU/t94sikOt34Zzbl9znpnlkEExebHMIN22hqgdo+zTDdgFE7K2ykKWVJa5c1aCrUjEJpqeixyhkzeDP5ex9Eh8ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467072; c=relaxed/simple;
	bh=d5slJz/Z68XGgcmkimb+deuyWect4hvH345bz82/WXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f5znPgWd01euLbIS/51bWOdGS6iDDZFgS3CYl4DGZgoFdEckRsw3WrxldVblmXKkkcf2I4q3dlAZPXJQWjeyd3tnCPKxIPhIh6hf/CN/hCroVCnztLKLQNzhayh1Rp2Ip6gRaeHjgYpcrxSB1tiOP8LxK3PgSwPjknKI66yHP3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=J52oAJEY; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxyIsHXVJ/AYUcGXJ/it1iBn9baqiKHHOjqk26ObnMwbMM/pU16cY8xmUTePb+cY7yQAbgo8XaMHwsdGqdSfMx9ba9sRwigWcvqu3bn+pKZNVAx7qvB4UcHl/eXQGl5h40fTkr04AhJ0rqSCApoowIJdY1VyIEHxIPj182oJGBj1eDdurzILMx/g830/cDKBlYyp0YBhyaCnl8U2A4aHCgDnKqGeUYV1gI967qTzyNQaRUkGu1AUm9Yu8wJ50QotHUz6+V0pUNuXmUUSZkYv3w8EE/AVonZrT7xAz6uHzfu5L2lTH+t022GFU1ZfgbIArGxo9xO49A2nZj3F/q556g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NA+4N2fl0hEeyq3XHO1WW0I1qDWBH+HmGNsekNuWoNk=;
 b=QgsFVDq/sw4g/wg/yi6JnBpRHK0ghRBqbQ3v5eHorUdgLLdM7ZzFNbGvGPsOfXVhrZn8JHSHAkUVMQhlSJI9QwJB1vetGIp+TzmN2tmmJ3ve7FTdVa0VC892NASsxBDoQhJ/dP8MwnVEhL0SmQsohecSMm1tRJbpGD2nY3EpubSD20LF/rQ2SEyxPoCAF9VeTFNeYAkFbUffqWo2mQEb0qAzFqZD48F/VMp2E78iE5Lw5n+omoqQMURKRwxNem9hB6yJJcwiwxebfIW3MnDUX+E/fMpTPwaV+Fk06DDwY9ZSCnAfP60zdTmGEzFRcrXQIQS3ZgsH3ob9acf82NtNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=de.bosch.com; dmarc=pass (p=reject sp=none pct=100) action=none
 header.from=de.bosch.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA+4N2fl0hEeyq3XHO1WW0I1qDWBH+HmGNsekNuWoNk=;
 b=J52oAJEYVcV8i6AdOHyryx9kNBZCuUvPVE0244o1A0J8JEuic8EY6vJcSecHzp31SUV9qpB0xgaw6igCS163sGNa1xV4WU2o36dLikM60TyDY7lKbZkE15xycMV0jkyHGqyi1Iqyrdzg7/DS8MiKOE3HqVZBmPn2mT/iWS6/jckI2uKdTaRnPOLfEHqjpwj6qLoeYW4VRB9gZ8UY+lIPmvAcHxaBkYFxgf+7cEkgGHQPaTV7CGjcZvl1QAk6KvlmYKEPUPjM+xuoJiriH1mD7BBZEERGqHWhJXVKctkzYyfEHjRqFnltB3SjMI0jJR/Y3msQakpWp5euODwSHsFLwA==
Received: from DB8PR09CA0007.eurprd09.prod.outlook.com (2603:10a6:10:a0::20)
 by DU0PR10MB7483.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:426::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 08:51:04 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::bc) by DB8PR09CA0007.outlook.office365.com
 (2603:10a6:10:a0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 08:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Tue, 30 Apr 2024 08:51:00 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 10:50:53 +0200
Received: from [10.34.222.178] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Tue, 30 Apr
 2024 10:50:52 +0200
Message-ID: <4f197ed9-e0d2-478b-b236-bea682303e91@de.bosch.com>
Date: Tue, 30 Apr 2024 10:50:52 +0200
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
 <eadf2812-85c8-4458-b504-10a60a16d1ea@de.bosch.com>
 <2024043041-arrange-defy-30de@gregkh>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <2024043041-arrange-defy-30de@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|DU0PR10MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ce6524-350b-4802-ffd2-08dc68f2a910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400014|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2hWdnlNTnkyaHBEU0N6cjc5U0kzNisxZkQzVGJkakxJeFE2N04remtaZnZF?=
 =?utf-8?B?MnNwRFJDelQ4eVJrOXlFdmpSSWJGNm9LSU1oa2dBek1YNkp6MDFmdXZtQ2JE?=
 =?utf-8?B?ZFdMOTRLVU5wT3ZJM3Z5dWE0ZW5aTHJIWDhtTlVRYmVhY2lRRU1GcWZ2REkz?=
 =?utf-8?B?ajJsOFBZaFFsVmRVMmduMWpYai9oUjNhTkFlODdUSlgvN1NOWmwrOVJDdjh0?=
 =?utf-8?B?MEpiNVhmRS8xRFB5eVBndVJaTTB4U1Zac0V2UmlrVjNuenJ1czRrdkh5YURP?=
 =?utf-8?B?NmZibVRWZTBTVUNxRytHYk1TNVVZY0ZZUk9Ib1VpYS8yNE9maXR0cDJkd1pF?=
 =?utf-8?B?QndndmRmNG1wU0QrbW9zRVdXTHByZk5rUG82Sm5jNm9KSDdWMjllSHlEOGYr?=
 =?utf-8?B?d1BtREJZdm1kRmNOYjJRUWtrUWloRUxaUzR3Rm9jRzVGQ2tQaDhuckYwWUF3?=
 =?utf-8?B?OWxadkFBNXI4dGF3ZklpV01hNjdKb2Z3eUhoR2VNSGJUeEl6UU1ROTJuZysr?=
 =?utf-8?B?UzdudUlkNXcybjZqdThTV0hCWnMwSithWDJ5alpxU09VYUI2WFc3Z1o4WlEz?=
 =?utf-8?B?aGJDUEdEV3NQVjM5cWYyRy9xcnZIK1Z1Qk9JQnoxWGtXRVZtV2dWT2Z6QUtS?=
 =?utf-8?B?KzJUazZEZk5qeVpDUUtYRlBUYTJKcFFQQmphTURxK2JKOXcvMVZEYjlqYWlZ?=
 =?utf-8?B?bzk0WTBPRkFWV1UrU2IwZjFVUUFDTHgrVlRzQnphMHJKRnJYb3lCc0duR05y?=
 =?utf-8?B?WEtXcXFvY01sVUdrSzJvNUJqZ255TzN3ZEVBby84K0x3WFBOcE41Y1BHN1FH?=
 =?utf-8?B?cVpMRW83WGRvZmtyeTlsdUJESERmZWx0dHFtZnBxa3l4UVVHRmxnOHQ2OEFi?=
 =?utf-8?B?K2VrNWhLZEx6TytzcEZjQjMxbkxoSE83eWZaNVFxdk9wNnFtSnRQblpCdFpp?=
 =?utf-8?B?K2t3L3RWcmIybHZUQmxBN2ZxT2RUUFFsL082dmhlQmd0UUZmZXZBbnFkc01n?=
 =?utf-8?B?Qy85Y3RBNkJNa1cxWjdqMnF3WWt2ZnpTTkpwR2xGSzQ0ODdUSFhsd21OODAw?=
 =?utf-8?B?SkhGb3ZmZTNPa29yWGxkVmd4MDVBeUUrQVdKcjFlUlZwbVZVbDhnbjIxRGVF?=
 =?utf-8?B?NmdxUmhrcHo3TTZVWGlEaWZ1cGZEK3hHc2oxVFBKYmd1VzFnYThnN08yL1Bm?=
 =?utf-8?B?U0tKaVFTKzc1dHJPSEpXamt6RjZhRzVTK2FDS285Z1pTWU9FUE85MXE2SmlL?=
 =?utf-8?B?UVljdERKQWpvdEw0OFhaWkVFSVZaWXEya2hwdlBRMFh3TVcveGtVbTBybmxq?=
 =?utf-8?B?eFh0bTBDU2Rva0FHRVl1dndjLzlNcndDM3ROSDF1SW5FcmlNL0ZGRDZwOWFQ?=
 =?utf-8?B?Q3J4ZU40UGRrTTdCSFQxTG5BSzgvUUlXZ21yK2Q2TUFqSzlIaUJoalNrZU55?=
 =?utf-8?B?bndIK29WVDZvaDhoQk92eDBZcWZ6dE1hamFtNVRmZXdsWDNRZlhaVmtiWDdo?=
 =?utf-8?B?dC92ekNjWlZudndaai8wM0RBcGlFeUd1SlZONGM4ZitQVXBkczBneHpYMmtl?=
 =?utf-8?B?ZGtOKzFwMkhRKzVwVFF5Z2NtajI0d2pRbGZjTWM3WFJIa1RKTDZic05xYzQ4?=
 =?utf-8?B?ZE1TTjNwTHVsbnNRSlMydmFHa1VudXFaT2o5T0c3SzNITk8vc0ZnazZaOWo1?=
 =?utf-8?B?OTNEcmlQd2x2c2NJN1BsTnYxQ1ZVUEcza2NZU0dzWDdoaGJvcklweUlWd0ND?=
 =?utf-8?Q?HfCSgZss+d9XZxZ/Ze4WvvkqqXO7dKU0FKPyKEE?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:51:00.6511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ce6524-350b-4802-ffd2-08dc68f2a910
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7483

On 30.04.2024 10:41, Greg Kroah-Hartman wrote:
> On Tue, Apr 30, 2024 at 10:23:36AM +0200, Dirk Behme wrote:
>> Hi Greg,
>>
>> On 30.04.2024 09:20, Greg Kroah-Hartman wrote:
>>> On Tue, Apr 30, 2024 at 06:55:31AM +0200, Dirk Behme wrote:
>>>> Inspired by the function dev_driver_string() in the same file make sure
>>>> in case of uninitialization dev->driver is used safely in dev_uevent(),
>>>> as well.
>>>
>>> I think you are racing and just getting "lucky" with your change here,
>>> just like dev_driver_string() is doing there (that READ_ONCE() really
>>> isn't doing much to protect you...)
>>>
>>>> This change is based on the observation of the following race condition:
>>>>
>>>> Thread #1:
>>>> ==========
>>>>
>>>> really_probe() {
>>>> ...
>>>> probe_failed:
>>>> ...
>>>> device_unbind_cleanup(dev) {
>>>>         ...
>>>>         dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
>>>>         ...
>>>>         }
>>>> ...
>>>> }
>>>>
>>>> Thread #2:
>>>> ==========
>>>>
>>>> dev_uevent() {
>>>
>>> Wait, how can dev_uevent() be called if probe fails?  Who is calling
>>> that?
>>>
>>>> ...
>>>> if (dev->driver)
>>>>         // If dev->driver is NULLed from really_probe() from here on,
>>>>         // after above check, the system crashes
>>>>         add_uevent_var(env, "DRIVER=%s", dev->driver->name);
>>>>
>>>> dev_driver_string() can't be used here because we want NULL and not
>>>> anything else in the non-init case.
>>>>
>>>> Similar cases are reported by syzkaller in
>>>>
>>>> https://syzkaller.appspot.com/bug?extid=ffa8143439596313a85a
>>>>
>>>> But these are regarding the *initialization* of dev->driver
>>>>
>>>> dev->driver = drv;
>>>>
>>>> As this switches dev->driver to non-NULL these reports can be considered
>>>> to be false-positives (which should be "fixed" by this commit, as well,
>>>> though).
>>>>
>>>> Fixes: 239378f16aa1 ("Driver core: add uevent vars for devices of a class")
>>>> Cc: syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com
>>>> Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
>>>> Tested-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
>>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>>> ---
>>>>    drivers/base/core.c | 9 +++++++--
>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>> index 5f4e03336e68..99ead727c08f 100644
>>>> --- a/drivers/base/core.c
>>>> +++ b/drivers/base/core.c
>>>> @@ -2639,6 +2639,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
>>>>    static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>>>>    {
>>>>    	const struct device *dev = kobj_to_dev(kobj);
>>>> +	struct device_driver *drv;
>>>>    	int retval = 0;
>>>>    	/* add device node properties if present */
>>>> @@ -2667,8 +2668,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>>>>    	if (dev->type && dev->type->name)
>>>>    		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
>>>> -	if (dev->driver)
>>>> -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
>>>> +	/* dev->driver can change to NULL underneath us because of unbinding
>>>> +	 * or failing probe(), so be careful about accessing it.
>>>> +	 */
>>>> +	drv = READ_ONCE(dev->driver);
>>>> +	if (drv)
>>>> +		add_uevent_var(env, "DRIVER=%s", drv->name);
>>>
>>> Again, you are just reducing the window here.  Maybe a bit, but not all
>>> that much overall as there is no real lock present.
>>>
>>> So how is this actually solving anything?
>>
>>
>> Looking at dev_driver_string() I hoped that it just reads *once*. I.e. we
>> don't care if we read NULL or any valid pointer, as long as this pointer
>> read is done only once ("atomically"?). If READ_ONCE() doesn't do that, I
>> agree, it's not the (race) fix we are looking for.
> 
> Yes, what if you read it, and then it is unloaded from the system before
> you attempt to access drv->name?  not good.
> 
>> Initially, I was thinking about anything like [1] below. I.e. adding a mutex
>> lock.  But not sure if that is better (acceptable?).
> 
> a proper lock is the only way to correctly solve this.


Would using device_lock()/unlock() for locking like done below [1] 
acceptable?

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



