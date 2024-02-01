Return-Path: <linux-kernel+bounces-48224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A188458C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8716F1F21FBF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DE55B660;
	Thu,  1 Feb 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tqK4hFKl"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B053391;
	Thu,  1 Feb 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793647; cv=fail; b=WTnb0Rz2lDav6sKp+pPYanXhmZHQKCjruKI9k7WffVUsW370wuIL0E/TEJ1U08RBXKfbfURj9po/jDEtvPXH1tO25bpCmmDTfadbrVSyvVxpwrPLmFgoSwSwoSFSPl0Ge1jnW8lsE7RT9sgmKWkBFAK8jV6JSwNcdoWeEN9uifI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793647; c=relaxed/simple;
	bh=MOsncZVSNpdfKkWLalRPUp5mgRqUkpXJ/4a7lTgKgjI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tbZZt9MpvERgAxtB3AVdm+KQzXfSX3/zV/uhpUrsqNyFqqydomiC8FBhGJBz+OvlsxOjZFOnwLd7UxYMCrO5htrBpE9mVCpYX5aB0Rp0UgY9JlSDLs2ooUjedZdrYlRxd9SFtIr6n5TrWDKs4+tJbozh5ugc9bXqOtLwGfjw5pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tqK4hFKl; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQo/yggy9rY+iY/h8PFKeigAS0/MWeSRbfVcvgmtnWHKX5P8XXTas0U8Wz8PokQmX2SaIH/WnxiYEGIL7KSIYA1kbuM03IzxnumEmn7vtJvwOTIExdecOSj96+HS4LaIY0JPFYlbLgCW/ZaY+mTTRZkcugfVCse9ut6RTZDbb3Fq+OFVyAXiyzH7mdQJcHXLAdOfviQalWCBewcqiE5QSF9udGAa7KeZitpVuvmx6LZ2Q+ai/LTK7cJlpWrzLz3H0WmX4XH+Wk4mLUIybQDSCGfXw7bLnta7J3UlHshgJYa/37lLzbPaOyFTAPhk1Agp6D5X/exQ9l7jJPCPc28+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9TKr/Yu8N05pChFiTPwJdXiKC1yDDY2aJQZ+/CGibM=;
 b=jtCLWA99cNl1alqh/kEGPnzu0ijQafvakBWhNCQaG2036dQ5GYvqQ+Q9UYsHyHoTxnpktqL3KjH3PL5u8blIoufQefRodaD5PA1JcrLR1BybHKGsudaYbIYYkB9Mj8uskZhvG18KYOZvUNxc3j5+3Ro/t/jmwj1Y9c+zMIGiUep2VbNvke+iH7WKZD9gU7DDv7gUZ1fnocUIuqPTcaEKVfy3epy/09cOf23dDszYFSSMr1BU6qZk59PspxLS93a2Ka93ESAgcks+tSgsLl771Qu3yRRHbyw0GY3OPiMqJOCW+cV2+SQPEiHQtKVPqXSppkkIEGXS+zeQ7VrD2kuoBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9TKr/Yu8N05pChFiTPwJdXiKC1yDDY2aJQZ+/CGibM=;
 b=tqK4hFKlfD2dURa7JMxLqxWLq/Z+oCRdCtrDH/nrJPAhH/O6quPYbA446lH5ehAe/3sUVGpXnefc/rx/GKCWU7I2WjxUDbkGTfTHtY2a3n8mbksrqF/Vi1gBVdRDc/6TC1dUISt8dX6se1K13H8AQSQjJyFWnIagJWxkWlV7z3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Thu, 1 Feb
 2024 13:20:41 +0000
Received: from LV2PR12MB5966.namprd12.prod.outlook.com
 ([fe80::4196:178:d5af:9f2]) by LV2PR12MB5966.namprd12.prod.outlook.com
 ([fe80::4196:178:d5af:9f2%6]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 13:20:41 +0000
Message-ID: <e73426f6-6d50-4ed7-8613-1ec42fa3f991@amd.com>
Date: Thu, 1 Feb 2024 18:50:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/hsmp: switch to use device_add_groups()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: naveenkrishna.chatradhi@amd.com, LKML <linux-kernel@vger.kernel.org>,
 Carlos Bilbao <carlos.bilbao@amd.com>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org
References: <2024012822-exalted-fidgeting-f180@gregkh>
 <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com>
Content-Language: en-US
From: "Hegde, Suma" <Suma.Hegde@amd.com>
In-Reply-To: <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::18) To LV2PR12MB5966.namprd12.prod.outlook.com
 (2603:10b6:408:171::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5966:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d6034f-d4ea-428e-4255-08dc23289650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vKl7fDo5shimNBZCKj61npNsFFYur13zhWXwR+koiANa8CmFuQMTC/CpAJBRNH/NNzwqGc+O2xtnl2ZKAd5I/7iaQx+szQm2niSwfEv34RJjUVlHlNuUKXs3tkez1WQEnAHZgYYeSQkseceBQzM4D1JGQtg/8N9Knxf1coCkmDpJsw48Da8E27EGqBvVMLDhYA50FxG5Ib6JJlDSePJ8gSgNBRqNsDDzcy9UBhpwevWulQ65n1yMQ/XrzgHnGu+gpSgo873ajG60OW8XqFtoxu+wMrwp2t34T9nNdnQyy7VHQBp48u7NM/kNkAehWG0+JP0UTEx8PhBxus285EhGj4UhxwlEFpD+psnjyvtMluuUxhS8tLZa0I81EhYLN0Xg+Id+r0tTUf/NgFK+K09v0JFqlW7uChtip20dSzqJC5BxDRAJjrhKNlpeya52uhZhfBgT6mnlpPktz0AfhHLBDWpWjg9nByOByiEPK9jzQ0dnO/tu1G2gR9+VykXmtFwI4WiWHCmk2AzeHnJgzhemOSry/aWbjTPGxbcLdx2/HqNs+qWtbGEOKKSN1OsGkRS1gekLUoshv4E8gd8evLwTVUZg8xk1zkEhpdp25Njl1eMCdqWn6ZefmG2/Qm0LtWaBwli3phBc2WrxVJ1F74KoY4uhiCwPP/gI8Oq7CWSaI91ssRTtaACfmKB/djfqIFKN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5966.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(2616005)(83380400001)(66574015)(478600001)(6666004)(6512007)(41300700001)(53546011)(8676002)(6506007)(66556008)(4326008)(8936002)(6486002)(36756003)(316002)(66946007)(66476007)(54906003)(31686004)(2906002)(5660300002)(38100700002)(31696002)(110136005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blY1cWRybkl0cDNpMC9aa1VPd0RTMnJrWlU3VHI2QTgrMkV6ank3V3I2YjVp?=
 =?utf-8?B?WDFCNjBHQWNDL05pYnBPYnRMT09iM3FwNUppazRVN2pQYndIU3RaSHRRdkVx?=
 =?utf-8?B?ZUxMSG9EN0RqcDBmZVhWSExNd01xOHdYNDlnUm5WM28wdkVpZExyREtkbFJE?=
 =?utf-8?B?SWxuQ0FOTHhNVHpIaEJpNzk1U0NQbzk0ZWpTdUJxWGovU1RTcFAyWVdGeHRP?=
 =?utf-8?B?YklYMlNZOWhDR2FOaytGaVd2QVB2UnByMmRJTTF6Y3RJcEx6UE5mV3NmcitO?=
 =?utf-8?B?bVF6VGNzMlhGc0dqYjRFQWFBSFB4UGRSckZDaFdSdU1LYjI3anh1eVZXRnQz?=
 =?utf-8?B?WXJ6c3BueFRpRXdkcTdjcGJsalRDNWY0dGVja1U2RWYwRU1md3ZKbGJUVkJB?=
 =?utf-8?B?R0tBWlF4cS9CRC9IWkF6aVlsYWhkTGcyWVMvbXdtb1BKUngxVzNlZGxxb2lK?=
 =?utf-8?B?SUszSk55bmVmbCszaUk5bmtTZ3RWaW55SWl6VCs5VC8rRHJ1ZkFUajZzU2xS?=
 =?utf-8?B?dFFhQXdYYlRuUTdvTVpnZjhKZEtVdlNBZEZaMlkxTTA0OXFSNTBSK0lYczNw?=
 =?utf-8?B?TkM0aVl1bTdJcTRqMkozUkcreEpKZEZCZTIvMldZVWU4a3hBcnArZ3htR1p2?=
 =?utf-8?B?R2FKL2JHNTgxSUJ5V0FmbzFJdjhzMmp1VXc1WEpJM1BIM2JoYlVvNWg1TXEx?=
 =?utf-8?B?RlZjVEpmRnlFeUdwOFN6MTBGSWdtZHhpWVhZZS8ydkpIV0pxTTBuUWMxdWxx?=
 =?utf-8?B?N2JuMEw0eGdXU0J5WkpiT0dwMU1WdTMyeWdWbXo5aW9qOGloa0gyZG4zTWQ5?=
 =?utf-8?B?SjFMSnRSN1pHRGhZQWp4SElEQlFuOHJrSmg3Mlp4SXR2dzl5UGx0MGRMemsw?=
 =?utf-8?B?Rm56N3NSdHQ5SUpnNThWTXJWaFJQeml4RHArbEE2Ynlpa2czVEFHK3RTRUxH?=
 =?utf-8?B?VnZFNTBTa0ltSVJadUVGSlkwZWYvN3lRWEZHNTN5VWZSS0g3RGdHYXlyQ3lt?=
 =?utf-8?B?RGZVUjFpejJmTmIyZGRqZTFYU2FDaFBEYjkyaGhCWUlWdDRnb2t3cXpvM1g2?=
 =?utf-8?B?QVVPN0ZIYVFWKy8wSUtTL2hDYkJuMmR4dmxMTkNqWGxIak1GZFpDVVQ4MFgr?=
 =?utf-8?B?cVIwbjE3THFhWXBrQVFCR1pYM1NWdlRpMU1XMzBZaHNVemFaMWJSRHQ2Tyt4?=
 =?utf-8?B?MVQrOHR5bWxUd0gveWxvSHJ2cmlWS1hPOEVHcTVOUFU5NzcxMlhTNkpIZXpR?=
 =?utf-8?B?Uy9nMG5xVHQ3ZTVYS3JRTmxHWlNPajZEd3BrdVdQVG1oZDlaTDdnWnowQUpq?=
 =?utf-8?B?TEZLRWJMVFFhcFBVM25ONytXWDR0S3MzOXNvdy92OHdMVmZrS3pNNTNWcUwx?=
 =?utf-8?B?d1Z6RFo4c3dvYkdhU2dobGNHakg3djE5K0ZhQ2lobjlsSmVZT2szU1ErQ3Ju?=
 =?utf-8?B?WFNwNkFQQytLOC9FbWRZU1RvcmpReEowNFNBczJYbVdrRXFQV1czeVlsUGJN?=
 =?utf-8?B?RnlqSFVZdUU2UnRZakhoRkl6MEQxWkpxSXcxazBIMFBNNzJwNm8xdXNNUHpj?=
 =?utf-8?B?Zmh3RXNySTFrKzdwTDNlZXlvZTZlZkt1TGNLVkliQ2xhVHpNeDRBZ2w5a0Iz?=
 =?utf-8?B?a3crVnd1VFB6bWViNnpZTFd1ZmdVMWQ5M2VRTEs3UDBNSFRNSXFMTHYzTXdU?=
 =?utf-8?B?Rkd4dDRoTzdzRmxGdHBpVG45ME5TY2ZVSEJ4clZUVFd6SzNxYkE1MU05eG1u?=
 =?utf-8?B?eVBmMEoyZkJvYnhBTmxpS1pheGlqZFVHUXVFMU9Sd1lOMkMwNE1BRHJTZXkz?=
 =?utf-8?B?eHppNGhQTXFKeHZpaDRIcXgvaG1CMU9MaUdVM01ERXo2eW9BdU5nWFhxbmtL?=
 =?utf-8?B?MEJPdGdhM211UzBDNGZxOTJvRXcxQ3hoTFQ3R1RLSHlNWmJ2ejduOG5CcG1C?=
 =?utf-8?B?bUloeGZYck4raTRveW1yR2ZzUDFIdGVsMWxzWG9BWG82eTFmZ0hHTFlZTFhp?=
 =?utf-8?B?SEtrRWZIdWZ5N1hvUlM3dC95MWp5WGNlVEo3cHJ6RFpLVjhnRytYZnV5bVh3?=
 =?utf-8?B?Skt2bzl2RWRCVndRcnkvcnJvTGNoUEFiS0x5YmRhSU9seUg1THBRNzNXWSsr?=
 =?utf-8?Q?QL3XBoOukOdh0van94GueXt/U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d6034f-d4ea-428e-4255-08dc23289650
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5966.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 13:20:41.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mb1M0wGQXsHkYsE5n2ZorIMUsoGnT2CF8ykxOGtS6UH5+gJg6GaRKdPgkFZLsVSid8wak5T0GimRXy5aJ78QaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

On 1/29/2024 6:16 PM, Ilpo Järvinen wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> + Cc Suma Hegde.
>
> On Sun, 28 Jan 2024, Greg Kroah-Hartman wrote:
>
>> The use of devm_*() functions works properly for when the device
>> structure itself is dynamic, but the hsmp driver is attempting to have a
>> local, static, struct device and then calls devm_() functions attaching
>> memory to the device that will never be freed.
>>
>> The logic of having a static struct device is almost never a wise
>> choice, but for now, just remove the use of devm_device_add_groups() in
>> this driver as it obviously is not needed.

Hi Greg,

Could you please hold on merging this patch for a week? I will push a 
patch for converting platform specific structure's memory allocation 
from static to a dynamic

allocation.

>>
>> Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
>> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
>> Cc: platform-driver-x86@vger.kernel.org
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   drivers/platform/x86/amd/hsmp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
>> index b55d80e29139..49ef0b1d6df0 100644
>> --- a/drivers/platform/x86/amd/hsmp.c
>> +++ b/drivers/platform/x86/amd/hsmp.c
>> @@ -471,7 +471,7 @@ static int hsmp_create_sysfs_interface(void)
>>                if (ret)
>>                        return ret;
>>        }
>> -     return devm_device_add_groups(plat_dev.dev, hsmp_attr_grps);
>> +     return device_add_groups(plat_dev.dev, hsmp_attr_grps);
>>   }
> Thanks Greg for bringing this up. I've added Suma who has some patches
> which change code around this area.
Thanks Ilpo for adding me. I will push patch to address above issue on 
top of "Add ACPI probing support for HSMP" patch series.
> --
>   i.

Thanks and Regards,

Suma


