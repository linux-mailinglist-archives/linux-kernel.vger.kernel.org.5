Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0947FABAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjK0Uhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjK0Uhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:37:45 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52375D4B;
        Mon, 27 Nov 2023 12:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gb9jviCYG7NFTrdz5g2ZkQQJS6+Kw66Zcb7brPD4Q4XgOcx2jF1zYQLUZJCs3sBxEdyU+6D1JTm7prCrQnqk4/5xphx4TA8uYgWg9QK4p8UPI2BNJasPHFjwO4x41oJLz8S9wAM0PVB5I3VWvWQlpGe3/rr+htiMqATEl8pz/HF5S8ZZi0W3FyN7q9N3+qjN/ib9BJyCBcCNBtvV6RBayCyoTRN3EjGhiAWxo8rLcx7r7ZzPGDyCFCjeUXC3xg7pw5zRvHnMqZGY9xz07YQshhnrANAf6z5klGlwn6pP/7L+/sQkQ6wrmCy1Q494Y0LO43xMcxEofyT61PuSSV1mHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBKswFDI+aObYTSc29wPDJofLkkbwufY1hg0comR8hI=;
 b=d05VxX++PmM6hQiTQteuxtxja3/JpnIiIYDjaWduWyFB1tJ7Jn2Re+5Z3P+FEE0NmBld+ofvl4POZa2g+aOHdk0LF+aRIGdEH/B5rBvWWlazahs5Bwuw1LnlEsYmR/iQgCpBFiRG7iKwwiJrOuwhZJWYBbrS0Apd3Ib8LMePqXCgv/K4xjGj/tcpdDr62GxvFjGWgqC56W5tsfuPfgXsp/Hmi4TnO3U41olKmJ/CiMtAa8zbi8h27rEgkHNGCSHWwrm3gLBV0LTzYhA2z2mNCI2TbgwNJyJSeoCWrvR/u2Wh/KdwvKaru0y+CDHdcbLC/zucUPa+r/ViblBNtESPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBKswFDI+aObYTSc29wPDJofLkkbwufY1hg0comR8hI=;
 b=vEF+hA5gnsz72F6E3NzxFHAE2TkazMLJFlVzvuh0EiPNhpYgvO9CmkLuA5681YoG6V5x6Im0eFxyxcCUiQaNK1IzsxtNKOF3+9UId8vLFjpZplwApYEsw005dmjvqdsxKUht69qtCYRpG/c4naAFmUH3R6f4Ro+6LKMWHxIbaNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 20:37:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 20:37:48 +0000
Message-ID: <4332dbf1-76be-434a-a65a-d4686cb4d2fd@amd.com>
Date:   Mon, 27 Nov 2023 14:37:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] rtc: Add support for configuring the UIP timeout
 for RTC reads
Content-Language: en-US
To:     =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, tobrohl@gmail.com, aalsing@gmail.com,
        Dhaval.Giani@amd.com, xmb8dsv4@gmail.com, x86@kernel.org,
        dhaval.giani@gmail.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
References: <20231127192553.9734-1-mario.limonciello@amd.com>
 <20231127192553.9734-4-mario.limonciello@amd.com>
 <c179a0cb-1b98-4a4f-a3c6-cad7b980a337@o2.pl>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c179a0cb-1b98-4a4f-a3c6-cad7b980a337@o2.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:5:335::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: e64fb3e3-ae0b-4a11-1124-08dbef88b7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OWz/WcSE0jkmGLPb5VPnF3HocpT1FXL9eusZaR1Ko6nkURAwfk7u5U4cGVnTCGjCKZlysUo0HJz8gkp5BqbsMfwj25sZg9BDAFEOXgasZ1jdC7TSSLEfA7DaZgSYjoj9YnzQ//z3KpOwckU/uduQsb6ammKqLgpFOrSSbdjjrCRlIkl4UGiP099nnWBYpXqp/Zh4bcCk2gdJmANpeg6I2cH1MBQet4qcIwcW6uLKMymA5rf25k4prj4OfxSmNK3U2vqrXpZxMbu52msNKOXUhqNWPlVPWd+mro/4D1iysnidUBXck8d+8c8jsvtkmwlBecMrxrbPQSn82cgPNwwjnRnaiEos9vKM7OM3PLv3RFGpUNhvE/kg5PHlNHP4Gqb3Y6PS4m7yONrz9qQJ05VDkPze59DO0fqNWpoyGyX9J8zh4eJogqWt4Ko1hCFCyxIUFDzHJY8OXqlAASZffIY9LaRltSg6BCcWMnGBvf2HX1CloWNxt9F23obpT7oli4BKhS3A/g+OYeEScCOejPVd1t1LyfpCXs5j1epS35JaycLhEovC51ylk+eLSjfPA76dAZIeBTWa1xdPV/jDBE5R1sUi/IIUsjKkmrMPqx0psmMabsQUfwNO2tyydvHdxzDpwh+2AkgoUL9IybNTAs8SWVc9KGZU2SYh58Uth3dak9A+9wjke+wI7BRbinllQWZVmjeUfUbtgxRvbX62UoWfpTLBQEBzfOgNJrkthB4DNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(41300700001)(36756003)(31686004)(86362001)(83380400001)(5660300002)(7416002)(66574015)(26005)(44832011)(2616005)(2906002)(31696002)(6512007)(53546011)(6506007)(6666004)(8676002)(4326008)(45080400002)(8936002)(478600001)(6486002)(66946007)(110136005)(54906003)(66476007)(66556008)(316002)(557034005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRvOW94VzgwVzNIOWFVSTJ3V1p5cVE3K1BGUmxkZ3BYNVI0MlpONTZNVXVo?=
 =?utf-8?B?NHFxRm1ocU5Pb0w3Qjd0N0pVVXVKNFZJYjVZd2pUUnpkKzJROXVOQ3ptd1Va?=
 =?utf-8?B?b1lOdmppZzYwZHFZUXJJWkVKTmc3MnppYlBpc3BYbE1adDI2YndMNnhuUmlP?=
 =?utf-8?B?ejZyRzNvWkltY2g1N3Jsd3BKRkVLa0F1bFdZUzVxWVhUSGtJQ3NVZHNaSU9Q?=
 =?utf-8?B?dEFSY1dKWjdhcG5mdm5weFZHUXNOWFBpL05LRDlQaWdwUEowVEdYWXg0c3ho?=
 =?utf-8?B?d2FOTS9ER084TWJSTE1NQlM3d3VKN3Zsem8rQjBVVHM0cnBxUzhHOEJ4VUw5?=
 =?utf-8?B?ZlVpbk9VVzhuWDBLVmxpTHhxc0J1ZVBjUzFQRExHdHJjdURaY3pGTmtYTmh6?=
 =?utf-8?B?Yk40OStydmZlUEpSTUQyVjdVV1kzZTQzMmlLRG5BeEd0OXF4eVk1UkdGUUpD?=
 =?utf-8?B?T2xQRWwxQU9LTWQ1aS9zdWQvNnBtc1c4VkpidzJ1WDBtQUdVOHo4RXhHSGR4?=
 =?utf-8?B?eDNhc3pqVTdBblcwUVdUcHFFWmFFMWZWdkYybVFmU09uVHJ2ZXpSL3ZkZUZR?=
 =?utf-8?B?SE40enc3NCtlekpmTGx2a2I4Ylh3U1oxenpNUXU2R05pWFJtTEpzdDlOQUc2?=
 =?utf-8?B?RDYySFVISUdhaDVXaTkxaUVMbVdVbkxia3NBejhHYWs0blRRWnJqeWw2azd1?=
 =?utf-8?B?ejBaSklOSVNvUVREc0ZSaklkZEhjMXBFcmM2b3ZkNDhWaFY3VmZDRjhWcXox?=
 =?utf-8?B?RkR4dUZLN1kyeWh3Z3lmaFpqOWJuZFA0UWp4T0psc2h3R1czd1NlbGNhbmZj?=
 =?utf-8?B?NUZtZWxOczYrUUxneXBwQ1BOeGV5SnpCY201WCs1c3Y0aFFCcXV0QVpsS21K?=
 =?utf-8?B?eEFINTRsM3g1Z2JxVitycHFtSlBPaEgwa2FVV1JlZ1NjK1BhL1IzWmR3ZWhv?=
 =?utf-8?B?VU40Z3k4U25oK2xSRjAybjIvcnFHWEpzdmxDRmViNVp5QmZ5UmxPOFo5Skpm?=
 =?utf-8?B?N1NpYVorYXZxWFdnUHNRNURWQ0FkcHlGZmJWTWZrTnlBTUdQSmxoMlYzRHNv?=
 =?utf-8?B?OHAzYVNWcDNENTB3WS85Q0FaMzI5ZWdtN1l6YWlOb1Z2K1hnQ0FWcHVFZmJC?=
 =?utf-8?B?eUVCSEJudEhZOFh5U0ZGVVh1RUFVeGFOcUZrRFhuRWVWQ2hCVU1YSFRsR0Z3?=
 =?utf-8?B?WlpJano5ZitRWEVxSDZFSnJub2w4eXFPajFkaFJndkdoclhsTmRFMFRaT3p3?=
 =?utf-8?B?VlRMN1JqVXFQWmVTdzVpTk4ra29CMERTcmt0Sk5HY3A5MFgraHExamV2L1NW?=
 =?utf-8?B?Mmw2WjJMcnIzOTNwaXYyUVZtcFdQcTdzVXUzckQ1RGxpcHVUZnhDOHJpK1Jw?=
 =?utf-8?B?UHByR211YVpyNUtOLy9tSzFIZFk4bUNZWUNHdUNGWkdJTXJhY2ZhL0RrZ2tH?=
 =?utf-8?B?ZjZqV3h6NE9razZSZTUrL1dtSEJjeGw1R213dVhDaFJMcUVSdWF2Q2ZlU1JO?=
 =?utf-8?B?UmJwdW41V1NqcFVOSks4UHBiRnBzUWNlYnBYbVRJWTk0dWlZTWc1Wmg5c3Fv?=
 =?utf-8?B?eE5nLzhveHIwUG5kWC9jSlNQU25yOWliaVh3ZjJNVEloaEJOUGhDUjRwdUN3?=
 =?utf-8?B?ZS9USUc1OGNXV0ZHV0dZclJTdmdNZ2orcFdwVUozbGtKWEN2emo4ano5R1lH?=
 =?utf-8?B?Tm9Eam1LQ1lnSW1PUnlDYmJDN3FqcG9FVkYxTW41a3RoUENtOG9HN3BBTDRn?=
 =?utf-8?B?N3lFUW94Vk1QenE0U2xWS0Y3NmlVQjNMOXAySkp4VmJRYkg5cWt4NG5qa2s3?=
 =?utf-8?B?aS9SL0ErTlJsbVNYdngzYis5NStORUU0YmFKODMyVGl0Vk84OHpwRHJTZjJ4?=
 =?utf-8?B?eWdxVTVDT0owYlpMWUtxNFJhYXNZeEJScnVWckUzMG5jL0FDQUpVTHpjdWVO?=
 =?utf-8?B?LytWMHI1V1QyeEhaWVFSNFRTVm9XVWozeURPdms5ZHJuTi9Qcm1ybjIzeGs3?=
 =?utf-8?B?MFBTTUNMV1JVcXVWOTFtcUV1OGVkeURYeDhnUnNmeGtxZzJIZyttZ0VYdXQ1?=
 =?utf-8?B?YUwyb2x6NjJvMGo4SExmaUwvUGF0RFlkYnJaYlcwbGp2RXBtR2Vxa1RybjNI?=
 =?utf-8?Q?IRWHrn0TqLTEY18mNulgDAyYr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64fb3e3-ae0b-4a11-1124-08dbef88b7b4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 20:37:48.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okqRz9risEMsrXer38X1Or6Ykk4oFp56cFpyomrxLTWrXA4826vpINyHzcu58UdS+mk0O6nm4llt1zWC7/y+OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 14:31, Mateusz Jończyk wrote:
> W dniu 27.11.2023 o 20:25, Mario Limonciello pisze:
>> The UIP timeout is hardcoded to 10ms for all RTC reads, but in some
>> contexts this might not be enough time. Add a timeout parameter to
>> mc146818_get_time() and mc146818_get_time_callback().
>>
>> If UIP timeout is configured by caller to be >=100 ms and a call
>> takes this long, log a warning.
>>
>> Make all callers use 10ms to ensure no functional changes.
>>
>> Cc: stable@vger.kernel.org # 6.1.y
>> Fixes: ec5895c0f2d8 ("rtc: mc146818-lib: extract mc146818_avoid_UIP")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2->v3:
>>   * Logic adjustments
>>   * Clarify warning message
>> v1->v2:
>>   * Add a warning if 100ms or more
>>   * Add stable and fixes tags
> [snip]
>> diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
>> index 43a28e82674e..ab077dde397b 100644
>> --- a/drivers/rtc/rtc-mc146818-lib.c
>> +++ b/drivers/rtc/rtc-mc146818-lib.c
>> @@ -8,26 +8,31 @@
>>   #include <linux/acpi.h>
>>   #endif
>>   
>> +#define UIP_RECHECK_DELAY		100	/* usec */
>> +#define UIP_RECHECK_DELAY_MS		(USEC_PER_MSEC / UIP_RECHECK_DELAY)
>> +#define UIP_RECHECK_TIMEOUT_MS(x)	(x / UIP_RECHECK_DELAY_MS)
>> +
>>   /*
>>    * Execute a function while the UIP (Update-in-progress) bit of the RTC is
>> - * unset.
>> + * unset. The timeout is configurable by the caller in ms.
>>    *
>>    * Warning: callback may be executed more then once.
>>    */
>>   bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>> +			int timeout,
>>   			void *param)
>>   {
>>   	int i;
>>   	unsigned long flags;
>>   	unsigned char seconds;
>>   
>> -	for (i = 0; i < 100; i++) {
>> +	for (i = 0; i < UIP_RECHECK_TIMEOUT_MS(timeout); i++) {
> 
> Sorry, this will not work. UIP_RECHECK_DELAY_MS is 10, so
> UIP_RECHECK_TIMEOUT_MS(timeout) will be 1 for timeout=10. Should be
> 
>        for (i = 0; UIP_RECHECK_TIMEOUT_MS(i) < timeout; i++) {
> 
> With this, for i == 99, UIP_RECHECK_TIMEOUT_MS(i) = 9
> for i == 100, UIP_RECHECK_TIMEOUT_MS(i) = 10 and the loop correctly terminates.
> 
> The macro should probably be renamed UIP_RECHECK_LOOPS_MS as it converts
> loop count to ms.

Got it; thanks for that.

> 
>>   		spin_lock_irqsave(&rtc_lock, flags);
>>   
>>   		/*
>>   		 * Check whether there is an update in progress during which the
>>   		 * readout is unspecified. The maximum update time is ~2ms. Poll
>> -		 * every 100 usec for completion.
>> +		 * for completion.
>>   		 *
>>   		 * Store the second value before checking UIP so a long lasting
>>   		 * NMI which happens to hit after the UIP check cannot make
>> @@ -37,7 +42,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>>   
>>   		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
>>   			spin_unlock_irqrestore(&rtc_lock, flags);
>> -			udelay(100);
>> +			udelay(UIP_RECHECK_DELAY);
>>   			continue;
>>   		}
>>   
>> @@ -56,7 +61,7 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>>   		 */
>>   		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
>>   			spin_unlock_irqrestore(&rtc_lock, flags);
>> -			udelay(100);
>> +			udelay(UIP_RECHECK_DELAY);
>>   			continue;
>>   		}
>>   
>> @@ -72,6 +77,10 @@ bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
>>   		}
>>   		spin_unlock_irqrestore(&rtc_lock, flags);
>>   
>> +		if (i >= UIP_RECHECK_TIMEOUT_MS(100))
> 
> Same, should be:
> 
>            if (UIP_RECHECK_TIMEOUT_MS(i) >= 100)
> 
>> +			pr_warn("Reading current time from RTC took around %d ms\n",
>> +				UIP_RECHECK_TIMEOUT_MS(i));
>> +
>>   		return true;
>>   	}
>>   	return false;
> 
> [snip]
> 
> Greetings,
> 
> Mateusz
> 
> 

