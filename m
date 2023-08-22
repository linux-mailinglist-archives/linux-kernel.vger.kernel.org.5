Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99798784342
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjHVOGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbjHVOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:06:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204DFE57;
        Tue, 22 Aug 2023 07:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMhhpUksmVB6mTvwX9+nC9QC1opmYjFhjnHT3x5r7GFPitlt9e1G/BsBaYBTObb8wX/EoH2WxSOtew4ATot6jL/9HlldIyY04eAjkHM4+0fuwekZkEbVa4lAVcG/qBpvGFx7AXuc9O0IPfVgoY7LU8HxAQPyvOrsoWh35v0LK267RONMocvCVHkDO8bBcyxVcwN+JibbA55BC3EDI9b2yNNAUPSSufinCGpPTZqddgWuPeUxVtPKW2l1q513VxbTHNkduK7F8RmFRSobOL/f35d04T+EA34Gj9Je4COelXVJTtmXSfZ40J2cKP/n+UEGcO6ZdtSmWDTCTo7TqSEePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o8SjQFqzXYi5RasDSlrJv0PGO9PefNMvw5/INPz5oM=;
 b=aRd1WBj+cxO77a4I5qlwjX3LFGr6dFN9XaF25krCWtqGu0ZpGlj1IaATlbt1fE7KRSnwVHquJleIFoje2AtRlG1c7EXCmbSyHaBiH6AA6WrrXlA6jn4EkDoKIqnwTYuXDDpVn+bfKHEqzLHYE099LHGkgr4pDBN5k2UVVOLCEd+X2Lz9m2tNk33CG36WX/Y6tMl1BM7X6gVUf3V4xqWl5k54pq94vpEorhyoWP54TIog/5ihIWM/YW0/HMUxb+GPeqGKQAXXIdh8i5UZhOu04b93h0CuQ41BAClFSw4Qi5vJztH1UVKMYRQZo9mRFPu86qhgGK/3Kv75ki51OFIw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o8SjQFqzXYi5RasDSlrJv0PGO9PefNMvw5/INPz5oM=;
 b=bLcrh3WK2Fk8d7qffXgzEf0Wc6j/vZly6eeSuGpwA7OpA6ZvgLBc4Tbt0+n5XgOKGtAAuRRfjTOKa1+sPKK/3r4CBhTNgy/2G+rPrvvC8fH8P+S8PxWjuOQTChClsHJCbfy8p/TH+TRww1YYHweD7QzZ0/370zHgoSdFh7R/GLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:05:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:05:17 +0000
Message-ID: <b7d45df7-3d1c-4b31-9da1-5f81d3e5b279@amd.com>
Date:   Tue, 22 Aug 2023 09:05:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: Don't make vendor check required for probe
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Todd Brandt <todd.e.brandt@intel.com>,
        Patrick Steinhardt <ps@pks.im>, Ronan Pigott <ronan@rjp.ie>,
        Raymond Jay Golo <rjgolo@gmail.com>
References: <20230821140230.1168-1-mario.limonciello@amd.com>
 <CUZ3T3G99JG2.29X1G67HRO9QT@suppilovahvero>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CUZ3T3G99JG2.29X1G67HRO9QT@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:805:66::45) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 518346cb-4e11-42f9-fa4c-08dba318cf55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jg/7VIetJBnwj4DmbdE3DuK1EwxUgrM5OFrcP9bZgjnPlRr1n17sb+2VkGQWc/E7HB3rKiNUsNc4alcidKv/ERi5+OrSYJLWVDnEZNd4rRCHD+gaIb2sQgzfC30QU9Ml/v7ts4ZfvCOEmjFEK7W1UClaZBR7WdIWdZHZBY7p5lwhDTQzOiAmPTR1zkyAQ0soOhHv1oHlVq4vxP6PLbe/jfouMeu5amc3qkdp72giPjUmK892tkAQl7WUn6QRt+rvuUmWegHuSu985kTP6Ey3PdDFsgFA0ONBHsrWXqkjBlLGzdrUxHGiq/DeaOINCXxGXKoM5Ncj1UTEfvc1v2NrXO2Pn3EeMcSaLoIM+7j+IgTNzwvoBsVDym5masx/SwooBR80402KL33dY3q2iP5SAtfwoUr5RmdhB8MGqVZcSx15XU2AKt8oStlyKyc+zLhJNqdZ/UMLiY0SBTnBxeBNpw63OCkL4aRse6i9D7znAlxdVM+Z0JMI2lWO6Wq77F62TIXAsXY82NcZlKlOcrwmanGTJhqUrprJRuyzt4FkBRiMimhnYW5zDQ3rWPrs+2/VIm855LqYydf7PGXriRD0HzOxr3+UMGi59I7XtB+o/uDB2dpeDFCnn6PgdwRdsg58HOPtSga2xRL/ajs1S2KtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(4326008)(966005)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6486002)(53546011)(6506007)(83380400001)(2906002)(31686004)(31696002)(86362001)(44832011)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmdKWGdNK0FQQWYvNW94cFBDVUFCRUJFZmJGa0lvbDc3LzdUQzhpQlpGWngv?=
 =?utf-8?B?dVpLV0ZnRTRnamt3UGFWRHFydHJXa2dYVWlveGRQMXZOdlpwb0oya3F6V1Ni?=
 =?utf-8?B?UkF2SHdCNHB6amdzTytDZ2ZKaGVBa0VLTVVuWDA4a0puTitJRzlJR0tFNDQ2?=
 =?utf-8?B?M0VWVlZBSlNzR1EycEo0VUFVTHh2YU5Eb2tZa3k5U2sxNVhweWFucmRsMjJv?=
 =?utf-8?B?REcrRXd5S1NaOVhOQ3lqczd1UFZUemNzbHU0ZXVpZm95YnZkaERBTUt6cjVI?=
 =?utf-8?B?cHM3cHNBNDdqUlB3VFRYUEVlSVlIdnh2M2FINmRHL3VUVUJhSFgyQjRqTEpJ?=
 =?utf-8?B?djhFa2ZuSFozL1I3NFdDOTBEdVpESDBSSG5Gb1NqOWFsVTNZbEpwSVZoeVVQ?=
 =?utf-8?B?QklmUkhWdjNLb3RHRTJNM1cyZ3BYL09MUFA4N2lnZDRLQU5IOVlnYjZ6MGo3?=
 =?utf-8?B?VmJ1QWk1amxEWjNxeEdtWHkxb1FKYmMvbnRJUjg3bE9zYTc3Q2NwRExIcWJQ?=
 =?utf-8?B?NHhnMU02VS83dTFJbUhmN0wvQUVHY284SDFRUjRJOTQyaGFZbEhUQmNQZ3ky?=
 =?utf-8?B?emw0aDhzQXV6R0M0UVBGQURQWWszWWdoUWNoaWhnL1A0N08zSU5CdmVmaUhn?=
 =?utf-8?B?K3Y3Rm41dTIxcERJa1RPUFBxZkhKWnN4cXZLODVFL3E0RDdTYnk2SzVZWG9B?=
 =?utf-8?B?Z01uU0pBd1NEdnhiQ3lCb1RpWjl1OXZNWm54eUpicnVpbmFCcjBPV1lHcms5?=
 =?utf-8?B?VFA2WFdSa0oxalNNRW1CbVI5aldSRE53QWRzVWc3QUVReXlLRHluM2hCUDJt?=
 =?utf-8?B?Sk56WDNHRWF3LzhCaEY3bmhVcVpTdGFYbHlqSlB0M2xnbis0UWxmM2FkUmtZ?=
 =?utf-8?B?bW11bisva2s2cTNPWWdTd0pWcytmb1ViRC9NU3UxcnR6S0xuN3JnTWEwOGhO?=
 =?utf-8?B?WHNVa1ZvenR2MXRhVzN5b1laZGllWm9pSENVakJ3VHgrZEhaYTF3NERJWTBS?=
 =?utf-8?B?K2RBN043SWFRbVptVXV6TGd4b2luWFNXZHdLTVpzQStBL1o1QUUzK0k2SFgx?=
 =?utf-8?B?VEJiTVRIRGl6UmNja0ZEVUlZWE9LOFF5ZUdwdTM5UEpKTVRSb1VRSkYydjFJ?=
 =?utf-8?B?MENqOUEyZU15b09DWitCY1ZZTitvZ1lyTmxNNXR1R240MkordmwvNnNrOENw?=
 =?utf-8?B?TDJES0RGY0Z5SGVnU0ZXVkN5U1Y3elJQK1oxdG5sbzVoMmFLMkhsTi9PakF2?=
 =?utf-8?B?L3htODl1SzZ1eS9iTGpFRjFKOEptenYzeXp6LzE0NXVlYXVBbnI4clZVeGFO?=
 =?utf-8?B?blRQZnV2MVhmdHRGSEt2QW82Sm54Q0RmNnRXc0s0WFA5QllUQ09ZdzVXdzV5?=
 =?utf-8?B?NVN4WGdLTnlNMWFxZTBMTUVmVkxBNk9lbUhwaWtkSWFETHl0cFlkVytkRW5i?=
 =?utf-8?B?aVg0clZoamN0c0Q4ZXpzNVNRWVl5WGovTWJWdWNUU01qQUxxWkdLS082WGRY?=
 =?utf-8?B?bjNBUTN4RmV1SSttVk5ZVytpVmdtNjd2SzNwTjYvalQvLzVaK3FENnFORnNZ?=
 =?utf-8?B?ZVU1dTlJbnRxVGJ3RkV1WXJzMW5KWnNXbHplMjZycVZkZExBVHI1WmczRzRN?=
 =?utf-8?B?eldXcnNxbTBRUkpWL1ZlMVMyaFZ2MnZhdWNDMStKUjBxOXpoY1RRd3gyRVhJ?=
 =?utf-8?B?S3A5TnY3eUtaSEk0SE1DaHlsSitIQVRrYXZSN0ljak9VTitNanhGbGNNbDE5?=
 =?utf-8?B?RXhUMUM0Q1JPM2pkajlJeFduZ3dFYnlNNkZyZ2xBUUsrRklyWGhwak5EMlJi?=
 =?utf-8?B?c0pwWGsyN1NGdThvaXJzamR4NStaVlVBUWZINnlnbndsc0lKT2Q4czNMNDVF?=
 =?utf-8?B?SEJuSU1UcEs4dzNFMVVqeHZueXVxeUM3VzlJZFRYRG9wQU1RdVF0ZW9CdVhQ?=
 =?utf-8?B?dzduZ1YrbWd0L29pUWdMQ2IyaHE3Qm1RaUpZajhXSmU2dW9KUnJJbkNyWVYr?=
 =?utf-8?B?MDI1SmVxQmFHLzJyTlA4RVZNWXAyS3cyUG1oWExRZlFUTkJtUTBYUVZybkc4?=
 =?utf-8?B?RmFJd1dudkFldytlYmtSb2V6cmpFcFFYMmZNaUtha3YyTkUvdEN0NXdNazJY?=
 =?utf-8?Q?3yBlM5hZ4uV6Gh4Irg+O1dFFb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518346cb-4e11-42f9-fa4c-08dba318cf55
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:05:17.3546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZabO6f+YHQQdC6n6JZ7juNDMFZ+qo2cHPS+t3gtGLIown3akJdMCl4GbgjFYo9bNNXeSbPD19nxFLuLzd0jog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/2023 08:22, Jarkko Sakkinen wrote:
> On Mon Aug 21, 2023 at 5:02 PM EEST, Mario Limonciello wrote:
>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
>> reported systems the TPM doesn't reply at bootup and returns back the
>> command code. This makes the TPM fail probe.
>>
>> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, check
>> the chip vendor and if it's not AMD don't run the checks.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
>> Reported-by: Patrick Steinhardt <ps@pks.im>
>> Reported-by: Ronan Pigott <ronan@rjp.ie>
>> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Check x86 vendor for AMD
>> ---
>>   drivers/char/tpm/tpm_crb.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>> index 9eb1a18590123..7faf670201ccc 100644
>> --- a/drivers/char/tpm/tpm_crb.c
>> +++ b/drivers/char/tpm/tpm_crb.c
>> @@ -465,8 +465,12 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
>>   
>>   static int crb_check_flags(struct tpm_chip *chip)
>>   {
>> +	int ret = 0;
>> +#ifdef CONFIG_X86
>>   	u32 val;
>> -	int ret;
>> +
>> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>> +		return ret;
>>   
>>   	ret = crb_request_locality(chip, 0);
>>   	if (ret)
>> @@ -481,6 +485,7 @@ static int crb_check_flags(struct tpm_chip *chip)
>>   
>>   release:
>>   	crb_relinquish_locality(chip, 0);
>> +#endif
> 
> Looks much better but the main question here is that is this combination
> possible:
> 
> 1. AMD CPU
> 2. Non-AMD fTPM (i.e. manufacturer property differs)
> 
> BR, Jarkko

Yes that combination is possible.

Pluton TPM uses the tpm_crb driver.
