Return-Path: <linux-kernel+bounces-63296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26638852D62
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7CEB29D73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D6286A6;
	Tue, 13 Feb 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="ghA2HRJH"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2124.outbound.protection.outlook.com [40.107.247.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DC24B29;
	Tue, 13 Feb 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818451; cv=fail; b=IdY2evk3HQPvYiqALIcFW/cH39FYui5dT/in2ot0Id1WeWlR5CMvo0OnI4MHaGLafdsmpEl+P3VD5YNkqNkKRmu35eJUbpJEfrY/0uKhpXIK3raD7K3NZaBSz63qvNbmEmp+ImtR11UcBBdj9dCu809jbbTUxC21YqMdhnb3mAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818451; c=relaxed/simple;
	bh=zq2Ctr7Ikpi3NVpXHsOHCIZRNNg5a//MpocQahu9/3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TCjjtyYeK3XNIiASaTAv65NmINxYXwlXUaVu3zg5RU2TeZqpvdo8i5PzxpQnHOH/hWI4/ByU7o4Knyp7IucLUzqeYZ6uE/4zyCRyQ+EjOPwJkGvYiG85CcfmNeI3AiLhwdB73WhoSfgctmEe4KtV45Q5BImMHVTWLuPkJDbvqWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=ghA2HRJH; arc=fail smtp.client-ip=40.107.247.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHvZ3Tey4x7reoRkcy7dXqll1ISLx9n3sMqmM198qoAFGwpjCnWi/IuJat06/w6HM+u4LW6W+04H5VydBDYnD5wdsmMX5Lyoc7h39lzR50nrMSw6QjVjBwBsoh8RIhgKSGbvJJrmZyPfzsIUJ3aR/lEOERNgS61HExBf+KWEfkFUMl+L336mJBhDG+zf75O749hsFmqFpYxKWu7G9+eMPmhQfdQ2dTgwTjIEqTzyrnhrRh+pK0UoWjdqzvMmF2QKIAjtF2MnRYESpjiXtgC8mU+2cLzUZL8xg+yZi21Qg95+Uz+Qh2AqE+VbCYtpcm6/H7bQ2ZKC5gDN3CpvMBm69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHR5ijszBJNSecrVm8u7zia1vQA3cXNLw5iWdxahQ+Y=;
 b=c6tsBtJLC2W56uU2SSKucqEdVAFj8gLdSNv1l9Tg/P74OUDSUfVECcCOkyYFKIwUd4kQTkLtf1uUf1cnhDhK63foqLPfmFqG3JTfr0l5zzH8HDVhsniLnSjGdTDTRXRxfiM38IjWhvXkVyeAC3ej118VHCcqCVmNilSTf7/aEUbsPNZ/9eZQOQ1N59FIz7z12kkXOPKNW/CajQ0nfjf9RdNYMOQmEHWynzYMs6luIneNWSizS4flFuAJPN6nByL7Di6x4q5PxF7TOIXnKTBOMsxCw8u+PU/XxmSdOSf7JTlHz8YZehXpWzMIWev26tufh1bv3cHJeaMQY3lwOvkp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHR5ijszBJNSecrVm8u7zia1vQA3cXNLw5iWdxahQ+Y=;
 b=ghA2HRJHm9VQMIl/UEy7uXeSsBAM6Ae60S4l3PNfiUt5n7C0pSx7L1jLWjmibDMfgWvkaWzlOlqptlmcYJjwHPaJ78mhF+ixvHYjgWeOY0oI6Ao6a43kLeLjzNICjigZvg7KKsmuLl0uEzQXU9Yoz1btdwF1dz99ipwZ2BIFL7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM0PR08MB5300.eurprd08.prod.outlook.com (2603:10a6:208:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Tue, 13 Feb
 2024 10:00:46 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::e661:f010:4f67:a6c]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::e661:f010:4f67:a6c%6]) with mapi id 15.20.7270.031; Tue, 13 Feb 2024
 10:00:45 +0000
Message-ID: <2a23817d-b797-4659-a4e6-5c8a75864c90@wolfvision.net>
Date: Tue, 13 Feb 2024 11:00:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] usb: misc: onboard_dev: add support for non-hub
 devices
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-2-f85b04116688@wolfvision.net>
 <ZcJ9OnYOtUVMu2Yk@google.com>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZcJ9OnYOtUVMu2Yk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::42) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM0PR08MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 940d5c64-0078-46d5-79b5-08dc2c7aa565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XAWOCE7U46S1NFUSqXX0sPWzZ/BzJ+j+6FVyg5rcert/1oWr7rnQF9ntAUyxDQW78EeoN2T8KQaMhlXXDzIXW94PW0I+646oWM0585ApJJ9HYQb5YQ2j5UZk6jGZFfa6Pr5isfapembVXeYJlH9O//G1lEMZeSDHcsrq9fMMSwp42rU1Vz5owPamgaVY/bIpyVfqFEjJw35fLOoT/71sDpd9JP9l4A0kIh9cnzhNIx2Cnut+Gq6ShoePtBGIKFF/74KBpmLofGSOh5jfWq57nJ7fGrRWeypvCf7R8zEyiT1qwwlrug5oNz3+Ee7f2MnAorbqhsuKMvwSpX0B7LLSJ+5LJ85GHBAvpc5ytbD/I8h09a4qdFqc6MFxhxFzm7pi0z7BlUCK31aTRVhP6CIhNf5CLU3v/Dom0k+JlW6NCslczm3L2habpiGZd2o9Tg8TfVY9vksseonaZGSjEt4rC7f8Av6y6KNIgHKmdDfO+C9zwbc84dzjcbclT8UTaiPalVlE6U52KSkPm/bG6ocGwX2IlKZAnGfCYUeffjrJHcTTjGvXBbQZyY08Q7cy7y2X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(44832011)(31686004)(41300700001)(26005)(2616005)(478600001)(4326008)(7416002)(54906003)(5660300002)(6916009)(53546011)(8676002)(8936002)(66946007)(66556008)(66476007)(83380400001)(36756003)(316002)(86362001)(6506007)(6512007)(31696002)(38100700002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2dhdkRkY0RSM2Q4R3gzdWhxTW8ydXM5OHJnbWI5YzhGemo4UE9RRDhCRFAv?=
 =?utf-8?B?Y3kwY3UwWms2MmFCdjd6bmpWQW5XdWlJVGx5NGVPazFlbzZXSXlEY2R2Ry9W?=
 =?utf-8?B?WDk5cUdaUjUyZWxoUFQ0N3lwZmQ0K0RkOEFrNnArczlpYkQ3d2N0U0tKd0Y2?=
 =?utf-8?B?cEFVeERmdnZsMEl6SjJKWE41eVBaVWtKZjd6blRwTWlQNlFYTVRKTkwyQ1Ay?=
 =?utf-8?B?QjR5SWthWU1rVHhUZTNKUG51dUxHSk5lbmlGN1RqM2NidkVXM0UrUWt1MDRx?=
 =?utf-8?B?NGI3UDdkSFhyTGo0UHFSZTNDMjBUa1Z0SERDMlFsM0xDQTdORUVkaVpwWGY1?=
 =?utf-8?B?VjlUN2RPSE1TeW51YndVRld0cHdSc0M5cEN3RGZRUko2V2RkOVBqL3hValV1?=
 =?utf-8?B?QkNRZXJsS1V5bkhacXNVcnNqQnZBYy9JVDNnWGRYMDdlU0dEZVNzLzlLZFpP?=
 =?utf-8?B?aUpGalN3M2w4NXJJcklGTTZhdzEzTCtyemVCTmVVUUNnWFBTR0tpOUdPVGxM?=
 =?utf-8?B?eDN3cUp5cjNIZ2pYdWl1SkptdXVvYXNhcHZHbkEzVHZIUjZ6SE5tV0wwMVUr?=
 =?utf-8?B?YWFWRDNaa3BidEFyQVVXMVorcWVCd2VyNGtuUkF3Sk1Rd1lVdUZOYTh2YjJ2?=
 =?utf-8?B?Umdyc1c2THorVUd2aEtoL0dOa08vdWM5VUozMFd0SDkySWVaUDdkT29SSi9F?=
 =?utf-8?B?UmpiNWlpTWdwU2YrYUhHV2ZUSlNYMFJIVmk4QmYzcHlmV3lZMzJRdjQzZEtP?=
 =?utf-8?B?SGo0SGN6dEY3UVlTYzdVdkQxdFZVdEYwOTlNVjY3VHVCSVBMOS9FdXZ5cm5X?=
 =?utf-8?B?bkd2eSsvQnNtRlRyUkVxS0JCc0w0RGxCMFNHeEk0U2VaRURBRExUSGhXYWxL?=
 =?utf-8?B?eXA2NjNQYUROTjdqdXdrWnlrUEVKS1pOUlN1Z3ZINDRsU3JhTytELzhUY29x?=
 =?utf-8?B?WStiY1lLTWx4K2RSSkw5dytaNUJWWGlDVEh1RHlJVSs4UURUNWV3Y2JJbEFS?=
 =?utf-8?B?VGM3NzlkOUpOTlI1NXpxSEtramlaSjJxVG16NXM3dVJJbzB2Y0RmUUFvNlU3?=
 =?utf-8?B?MVBrYXNKNHAxRmR3djJjMnVMejMzR1hYSU9OU3lzMlEyVUw4emRIUy9RUmlS?=
 =?utf-8?B?MXk3TzczamNBMG5udWRGZTk2SVFjd1VjQStqbi9SYTZrNE1ReXNuUG9MS0po?=
 =?utf-8?B?NWJaalk0c043Q25GSTlKUEUzNyt6aWhxN2p4eGRxWStBRjFuUEFaWnovLzVt?=
 =?utf-8?B?WE1VY3dVRm9NVlpsVUFuQXJreEVpbW9NUlBnTVZCbG9RWFlhR3pZOXlGV0Z5?=
 =?utf-8?B?SnBTM0YyMDFwYkxsN3ZORE5JT2NnMlVkZGxMWHpFYU9DOXRUYWQ4UElQTkNq?=
 =?utf-8?B?Yzd3Ykk2STlhNmR2Q3F5c2UrRHNJTC9qMllEMno4VUVXNlpER3Z6bjRob2ND?=
 =?utf-8?B?eDFaZW1HQnVIZkZtVmNVVnJuU0M3SnFVV25sa05Za2ZySkNkRjg0a3ZLUXFy?=
 =?utf-8?B?d2NSNit2NVcvbUlETVBJRi9abFdHU1NzMjltRGlNbERVS3hzMTU3YVk0RDVw?=
 =?utf-8?B?ZndZUDVEaXlCS3RoZ0UreEdEeHprcUpWNHVvejVLbzBRTkFHOUYzMXMwL3o5?=
 =?utf-8?B?ODUvbjJKbzUvSmZyUjZ6NHZSbGJ1aTFIT1ZjN0NQeGlTV0MwQTRaSFk5VmFJ?=
 =?utf-8?B?R2p0QU54U0dmUTZtUGZjcFpaUUYrc0x0a05CaVhnRmZqUUgwK2k5VktNUWxo?=
 =?utf-8?B?d0R3UTlId2Q4NktlZVVFQUMwVlYyYTd2OHJzbm9IRFBRWlZtdU85a0RlQUhi?=
 =?utf-8?B?RnFwMWFJU21ycHNVNjRlVWRuRDNhOU0vQ1M0R2xXalF3T2taZHRSZjF4ZVVS?=
 =?utf-8?B?WWVoSEcyMlZwWmFkcCt4MUhldXcrQlE1WWwwb3g5cXV1dzVKUWdWZlBLY0Rm?=
 =?utf-8?B?QmR6NThzRU1tYzBNZFJXSTVRcVRKVmRLa0w1NjRyNnluRUFoRkQwQnQyZGly?=
 =?utf-8?B?OXNsbkwrNWsvYnpwTWV2L1FHekM3ZGdTdUFuR3F2YnM2WGlaOU9DK3daRGll?=
 =?utf-8?B?ZE5nNm9NTDhkTEgwcVMyK0pCb0JYV0VXWlBkdEJXdjRuZUJpUHpaUUVTcXRw?=
 =?utf-8?B?V1BNUTZrY2dNbnZ3Uk1SUXUwbXdVRG5LMkNFQjlIRm1RZU9MUFdzWmNob0RS?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 940d5c64-0078-46d5-79b5-08dc2c7aa565
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 10:00:45.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlJmBj4ibowwyCLS89kK0Mf+sGrD0FPQzBVwpMKzqj/eN8uvp6qaSJ/hHQk2RMO9ATVTAOKCtS4yfMNXS4MAxViw07cE7lzc1NY/z/cbt2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5300

On 06.02.24 19:40, Matthias Kaehlcke wrote:
> On Tue, Feb 06, 2024 at 02:59:30PM +0100, Javier Carrasco wrote:
>> Most of the functionality this driver provides can be used by non-hub
>> devices as well.
>>
>> To account for the hub-specific code, add a flag to the device data
>> structure and check its value for hub-specific code.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>  drivers/usb/misc/onboard_usb_dev.c |  3 +++
>>  drivers/usb/misc/onboard_usb_dev.h | 10 ++++++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
>> index e2e1e1e30c1e..3ac21ec38ac0 100644
>> --- a/drivers/usb/misc/onboard_usb_dev.c
>> +++ b/drivers/usb/misc/onboard_usb_dev.c
>> @@ -123,6 +123,9 @@ static int __maybe_unused onboard_dev_suspend(struct device *dev)
>>  	if (onboard_dev->always_powered_in_suspend)
>>  		return 0;
>>  
>> +	if (!onboard_dev->pdata->is_hub)
>> +		return onboard_dev_power_off(onboard_dev);
> 
> Why turn the device always off when it isn't a hub? It could be a device
> with wakeup support.
> 
> I really regret making 'off in suspend' the default :(
> 


The power management seems to be a critical point to consider.

Maybe we keep the current implementation and add support to non-hub
devices by simply adding a check to set power_off to false:

static int __maybe_unused onboard_dev_suspend(struct device *dev)

{

        struct onboard_dev *onboard_dev = dev_get_drvdata(dev);

        struct usbdev_node *node;

        bool power_off = true;



        if (onboard_dev->always_powered_in_suspend)

                return 0;



        mutex_lock(&onboard_dev->lock);



        list_for_each_entry(node, &onboard_dev->udev_list, list) {

                if (!device_may_wakeup(node->udev->bus->controller))

                        continue;



~                if (usb_wakeup_enabled_descendants(node->udev) ||

+                    !onboard_dev->pdata->is_hub) {

                        power_off = false;

                        break;

                }

        }



        mutex_unlock(&onboard_dev->lock);



        if (!power_off)

                return 0;



        return onboard_dev_power_off(onboard_dev);

}


Best regards,
Javier Carrasco


