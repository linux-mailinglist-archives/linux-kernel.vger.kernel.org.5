Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AA8807885
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442786AbjLFTWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379257AbjLFTWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:22:23 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68AFB2;
        Wed,  6 Dec 2023 11:22:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkUKs9AcmOfR8S04vIticFX0gAIPLFx3UaigZWM6KTRxQZFKA3VOZPOfdGh20yzSlJrGGH4k21bsoRpvt+B3pDQm5A+tr4Is0zv47j5Q3nRZ8FB/QBeDc9trUvsx3DFsGs9N3+2mVjd3B8LaXzPe657SKRjKQsI5KqgD/vgVNe2vA4eY2DMgdmIct/xnM4D2CVb+Tblnkuzidm17frXB368MK3yQdQlRzftm9/t/aLxqntSMlzSygqkKcBG9HK1AU1nBT8SbbZExbi5BGRTDcqe0g5X/KGnRWexwDIT9TyxEjHt41DNPoAxzkt8C05leVuf+HtLk7dNXkPD/CzRpyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c6brYtxmRs0AJ6VN5ZISbBnl2ZOCThHDzwIo6sWYRA=;
 b=V1NwYtDRoRPZIMjkq3yWrN1n2UuhD38vx2ZTHm4BJzxAmKPz2cOW6ojIgMHbemYz6BjOHFNl/rG7f2dgcf1wGHVN/MilwlQ8bWKJHrAiUtRH56YQzzXyTmmaA3l1AbEaNMa1CZd5hJ9BJKdiVtVuZSRtY5NINdDWKzmmsUqQv7Su8laE+iyn0pl+eOK1lUTuqQR8/MQDYC6BjWC3feyfLX7s9H5oQufra3FLnzA0WhNh/BCrVLr7IIOsniuMs6vcPUHTbXqVRDdvsdP44O6KcL/QizvpBDM9JEOUIIRUSlft2+cSznaDj7tn3WOGPmsOYVWwDBkG9NScHoV6EuJF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c6brYtxmRs0AJ6VN5ZISbBnl2ZOCThHDzwIo6sWYRA=;
 b=YGXhD3o0OwEdFLGOSCf5bTKgCX8+e5EfMvx/wACq8HGKwApZK1X5RBa1LxmP9V9sslgGrPlBUr0kXqyztz0huQ2HumGduMebJzzbt0jMH9ykz2KrR8cS9tIgZfmHzEiXYbjarTZWsTZP8tcbTYd6INNQvzE/Yy/CzxuLRlViWPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Wed, 6 Dec 2023 19:22:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 19:22:27 +0000
Message-ID: <abc96443-ed27-4021-afa9-280be027e355@amd.com>
Date:   Wed, 6 Dec 2023 13:22:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: i8042: Quiet down probe failure messages
Content-Language: en-US
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231206175818.2568-1-mario.limonciello@amd.com>
 <87zfyngoe4.fsf@nvidia.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87zfyngoe4.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:806:a7::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 18155d7c-7c9f-49cb-e0a9-08dbf690af02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYJypmINTER9SHwsRbcYTSDJ5hqM3arqORGQOS+1crnUBZWRLIkhTt7vviSy9eUCh2baWcDhUCzS+pqYrlTPn7JB2NEn1SapgMtdEQ3IkZjeeAS6ooj/oljAtRGQOGDHk4Fao4IJMr/uWDNYwNzhauzAg+TnsLMpLFz0UIHHCa7ygawLv5MEyer5eNGYs5tVXT8wh+hzm+IENw2Gz+C/j6Rn2OsOIZhzZhW6ZLGYpc0agbNMpQotHEMwh+FERm/b6gTgoE+NNN4iHMHMB4Q/c8iua/XWh9lqUXf6pa07K/lL6o90w9W0D5sN7axBLqGacD/pQGXw7uFTBFUCXNScnja8Pt8/UnKOpN0Ma/6A05aKE0pI9bSG6yCm4kc3eyUekrE/yn9dx7ckCX0lx6JzwMn56eD4Od3BPlqf3nntCfstgkpVnO3TyJul8K93ApR4wegEiaVNLtS85uTYqsUJb4CdJ3lC4jKUGgLr42WO7Dg/nilH2nVJbsC1TeqIZjoXRPNt3Mg8bIFVjhjvTeWIbhiR2vpsIWnIMy8vj+q3cUsJVYNXdf60ZCzvgEUvJ89+8+5tmOQf1PPD2Sx71J+B3FgsKRgn3568jEnaE655yR+eCr24AqcM7Q9iI6mPUY6m3nvJtnp/WtF4FzLabJZyD2Um0SZFBmoLk3kyySyFA3G5OoRF0bWjfBfXMoRvucMU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(31686004)(2616005)(26005)(53546011)(6512007)(6486002)(6506007)(478600001)(38100700002)(31696002)(86362001)(36756003)(5660300002)(2906002)(44832011)(41300700001)(83380400001)(15650500001)(8936002)(8676002)(4326008)(66556008)(66476007)(66946007)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUxtR0h0enZGWmJ0U1dyY1E4ZDVyS3lXM3duQytleGx4eGxVb2VNS2V3ZUJH?=
 =?utf-8?B?Q0NvOEdmSEVpTTJPQm4zdkN3MytuZnYrZkJrN2k2Z1RSREhGelFZTFdxRStZ?=
 =?utf-8?B?MFo2MTlTdXBMajJrK0JtV09rMGl0OEZjQTJ4ZVpEaEdXY1pQZFFibktZTXdU?=
 =?utf-8?B?UTkzK1g1ajAvemxnRm9xejJKY3NISGlNdzM0T0NMRUM2V3NqZjRZekNML29V?=
 =?utf-8?B?VGtMRVIwdmRZWnYxWUc2VnpHNkFYYXJudU1ySzlOYkRQR0YxZSsvQm5pUWFJ?=
 =?utf-8?B?S2hGcGpoVG0wVnRibjlLdUxva1ordTBBek12dG5oU2lwWmV3UEJOSy9yeDY5?=
 =?utf-8?B?UnR6eHNndG4zNUkyK1pvSkF2OGdUbkZJcFRYODI4WDBsNVBKbXhldEJSTngr?=
 =?utf-8?B?eDM0ZjlFbXF5TTFLbjdrUXFQRXdLYzFtY3kxUjdsZGZTQW9MNW1EQkwzMmls?=
 =?utf-8?B?Q2lPeENtN2ZuWnV1eTcvN29wcS92c1hhK0kzUHJ4K0VDN3VMSEtjbmVoaXZ3?=
 =?utf-8?B?d0o5dW1NTHM2OVE4dWhIQnBQdjExZDBXQ0hMaEhhYThjRkRXZzRpdVpMWjlh?=
 =?utf-8?B?VStzRnYxVFBiaVgxOWRuK3oxelUxUUh0aGxVcUd3bjEzVExsZndlQ1d2azU1?=
 =?utf-8?B?aWhpekxtMFJHQ1VjczJMSFBLaWpjVmV4YkI4N1N2bXRCOXhCM0xZeHZnaytk?=
 =?utf-8?B?d3lMVFhaVkJwNHhCUFZ6TXpERWJPcTdQYklVRmsyUDhyakNhdVJEb0dZbHMv?=
 =?utf-8?B?ZWlJM3NyMlFzRzR2cWRXVzNnUy85TC9Iek1JSTF3czVLWXFaTWtKcWEySW9W?=
 =?utf-8?B?blVDcW1kSFVvM2FaMm5uU0gvNlU0UitwN2o4U0ZCT3cySGFRUnZxaEd1NDZ5?=
 =?utf-8?B?clhOUWVlZ2RId2xsMGs2UFdwSEptTThuRExUaU4zWmNiWWN6OHhVeWNBaHJM?=
 =?utf-8?B?bkNvZ3Z3YVo2a2dta0lRN3pKRDRJNlZTNGJ0WHJYakhIOHVmYXZMb2hhZEdK?=
 =?utf-8?B?bWozTkcyYmNNajFZOTlZTVVtWDRFN2dSWHhSaUVKQmpNS3lpaTJQS2xSc0l1?=
 =?utf-8?B?L1FHVzB1bER2ejZnMHhsOG1ZYjRlelhhZllhdlFNUXhzUzJ1bDFuZksxenM2?=
 =?utf-8?B?RDkvZ3lxRUZDdHdOc1pac1UyYWJJbFVTZ0lGalBJeWh1OFk2RzVaWXZHU011?=
 =?utf-8?B?bTczZ1JxRkVOQUF0S05rblRqcEIvMU1kamFhMHI5MkJXcThnT0QvY2FmVEUx?=
 =?utf-8?B?WjlvUDhtWlBRalo2dW51a3A1YmZZdzJuWjJ0VDlJVlBZY205ZTdnQitlWDdy?=
 =?utf-8?B?ZjAva0M4OTlXbVJNUUNlQndCcWgxK3o1UWtLanNxRDcrRnp4ZFVYZ0lnR2hx?=
 =?utf-8?B?Y3lyd25DZGJ6bithZWRzREoxdXZ3d25MblhXM0h0ZTRqWWNIUWFkbGRSM0J2?=
 =?utf-8?B?OEhKQ1dGQXFpcEh0clo2blBNZ1ZLaE1oc1RKVURGN0VVdDZTVDRMdTV3YVMw?=
 =?utf-8?B?RGJ4WFBZYmkzV2RLbnZYN3RlOGFkeXNmUnVrWnRHM0VpeXI0b2M2OERXdERs?=
 =?utf-8?B?YUNXMmhOMmNnTjhYalh0YlgzUERDTzYvYXBQcXF4cDg4bzlVdk1USXFYS0dx?=
 =?utf-8?B?b29ZdEZXZHJjeVVybzhpUkRUTUFpaEtMWWNqSlhVSXh1RTVQc1pqaTBPdTd3?=
 =?utf-8?B?dFRHWFdON2dvdUpBSGFTREVNNTVhNzlYWTdOSmxmNTVrelNuWUZmd091eDFW?=
 =?utf-8?B?VUxsUXJyMWNNNUVlZVowNitRMFFsUnJWbGJIcVFaRE5zRWJvanFKbU9oUXpt?=
 =?utf-8?B?Mk5pd3FZMzhqMEhJWTlpNXBkY2pJekVhQWI3MVBla1ZFRHFiaEdCeVY1dUR0?=
 =?utf-8?B?a2JUbUJYaEl4b2ZxZkhmNDdCdmNqMlllYzNlak9CMlI1S1NveStyOEZiaWRu?=
 =?utf-8?B?dHl3QjNHZnpURExXcFRja0lXNXcxTDlCU2tteXpxbUlTcGE5bXNFQUpjRnMr?=
 =?utf-8?B?NWtia0hxVVRrR1BsUm14RzVyaTZLS3UrQTdiMnhCN3B3dnYyZDRicjVFYUJi?=
 =?utf-8?B?WVJXbzk0bTh4Q1grOGQ2bDVQblp2c21WdTV1dmhYdks4UXJCL3o3RHpvNHpl?=
 =?utf-8?Q?EUInj39jWqaTqteVQBcjUc4K0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18155d7c-7c9f-49cb-e0a9-08dbf690af02
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:22:27.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhBNeUEZU4pvK9ljlSirp5gmldXI+cblbIAs09f26T68GodtXVChtoXklkGtzYuNW4By1MFmg5GfhCuv/tNgtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2023 12:46, Rahul Rameshbabu wrote:
> On Wed, 06 Dec, 2023 11:58:18 -0600 Mario Limonciello <mario.limonciello@amd.com> wrote:
>> The Framework 16" laptop doesn't have a PS/2 keyboard. At bootup the
>> following messages are emitted:
>>
>> i8042: PNP: No PS/2 controller found.
>> i8042: PNP: Probing ports directly.
>> i8042: Can't read CTR while initializing i8042
>> i8042: probe of i8042 failed with error -5
>>
>> The last two messages are ERR and WARN respectively.  These messages
>> might be useful for one boot while diagnosing a problem for someone
>> but as there is no PS/2 controller in PNP or on the machine they're
>> needlessly noisy to emit every boot.
>>
>> Downgrade the CTR message to debug and change the error code for the
>> failure so that the base device code doesn't emit a warning.
>>
>> If someone has problems with i8042 and they need this information,
>> they can turn on dynamic debugging to get these messages.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
> 
> For the Framework 16, I think the following should be done.
> 
> Use SERIO_QUIRK_NOPNP for the device to avoid the PS/2 controller
> probing. You can find examples in drivers/input/serio/i8042-acpipnpio.h
> under the i8042_dmi_quirk_table. This will prevent emitting the first
> two messages in the shared snippet.

I had tried this initially, and yes those first two messages are 
removed.  But TBH I'm not too worried about those as they're INFO. 
Adding a quirk just switches them over to a new INFO message.

But the ERR and WARN messages still come up.  The 3 messages that show 
up are:

i8042: PNP detection disabled
i8042: Can't read CTR while initializing i8042
i8042: probe of i8042 failed with error -5

I'm more concerned that ERR and WARN messages show up making you think 
there is a problem to look into.

> 
> 
>>   drivers/input/serio/i8042.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
>> index 9fbb8d31575a..95dd585fdc1a 100644
>> --- a/drivers/input/serio/i8042.c
>> +++ b/drivers/input/serio/i8042.c
>> @@ -1008,8 +1008,8 @@ static int i8042_controller_init(void)
>>   			udelay(50);
>>   
>>   		if (i8042_command(&ctr[n++ % 2], I8042_CMD_CTL_RCTR)) {
>> -			pr_err("Can't read CTR while initializing i8042\n");
>> -			return i8042_probe_defer ? -EPROBE_DEFER : -EIO;
>> +			pr_debug("Can't read CTR while initializing\n");
> 
> I also think this error message should be pr_err in the situation that
> the SERIO_QUIRK_PROBE_DEFER quirk is not used. I think what you are
> likely looking for is avoiding emitting this message when the
> SERIO_QUIRK_PROBE_DEFER quirk is used for noise reduction purposes.

SERIO_QUIRK_PROBE_DEFER isn't set on this machine.

> 
>> +			return i8042_probe_defer ? -EPROBE_DEFER : -ENXIO;
> 
> I do not think this change makes sense to me personally. It is indeed an
> I/O issue with the i8042 controller on the Framework motherboard, so the
> error should be -EIO when i8042_probe_defer is not set.

With i8042.debug enabled I can see that the error is a wait read 
timeout.  So I had thought -ENXIO ("No such device or address") made 
sense here.

If you feel strongly that the errors and warnings should stay as is I I 
wonder if this should be looked at from i8042_pnp_init().

In the no PNP device declared case it still probes, why isn't PNP trusted?

> 
>>   		}
>>   
>>   	} while (n < 2 || ctr[0] != ctr[1]);
> 
> --
> Thanks,
> 
> Rahul Rameshbabu


