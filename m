Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84276786041
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbjHWS7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbjHWS6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:58:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E19E6A;
        Wed, 23 Aug 2023 11:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JplUTiy3KDtX3Q9UoH0CTZkLyUghHyd5za5FLofVs6pwlIcxSwHia5h5Pq/4lpAc3QZ78PswKCB2Z7QcirfJuLzHk3WJK5XXiorLqZzALVaIsJMZrDiiJuQsxZYaW5tFdL/B1YNwWbsnCIdwqS0vh+AZVRoJ3NaH/i7Ll6eUiIOmR/5ZfpqnvzTc5pPQwMGHnP3HY7cLZDG80107VcO/1f2Uf31oGWB5AK409xxIFQBZe3AF7i3BeCIxQAcnu+4HSukPnBXnvMBdzVPRdP4t2Wd9ZxBIf54KKeNyFOGCSOznluNjinPsQV3/uDOGoaSMDODG2/Jo+97vFB+scKOhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnt/cfpUcLKIY+oEPW+D2FCbNwELvoKGu2dYW3P64uM=;
 b=LPcgQyG7/Z0kWs8PsHyIUg9tvShklse2iZQ3yQsigXkTIf3iwIINZygde6suEXO8/km4l3pTLbt/Q07umkXR0fuy/f1V16kHpt6nGd8mcjF+plIrC9Lnmouy4zWafZ+KG4ne7EyoCRWQbqtQtj6TEwUnVgBFQz7GZvpKtcZ5H4Rprwvn4QE66xDmft1dYqinF2c02dFRwT6KVEqid58xBIRxBW9ThoK3rOVU0+M2R8NqGgh8g92STWsxGDpCtErNUlX1cCmo14XKU2S0tBNDquOVPlwZDZzwqgJ9NqDxzYetx7jH0O1BKH+NtobKLPaBpxEnZGCL/Cwj+VMwvy4eRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnt/cfpUcLKIY+oEPW+D2FCbNwELvoKGu2dYW3P64uM=;
 b=kIFVr/arjW1v2LjJ+pqqC8wI78fKHcXE6o9zH2NONaE2M4fZVINQ8JjWEEePGLYxZXfu0p7lHrY3dvOMqtwwwU+Oyc4bz+U+uqEepfNAFa8TNnwwy3dR11bjNJ2gojRhpxT+rSPOmXGkLusu1IVbvCgqfD0RlU0+rti6cEPYIIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 18:58:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 18:58:41 +0000
Message-ID: <1eeddbdc-c1f0-4499-b3d1-24c96f42a50b@amd.com>
Date:   Wed, 23 Aug 2023 13:58:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>, Ronan Pigott <ronan@rjp.ie>,
        Raymond Jay Golo <rjgolo@gmail.com>
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
 <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0358.namprd03.prod.outlook.com (2603:10b6:8:55::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: eb20b3ab-9a08-43cd-958c-08dba40af78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yl/bma9mfIY6jcY0QNbrt3FYxL8FxlNOU50QdkmMXwvZJJYNQOJJuo6YVdg5CAHUVaeacU/oZPw3u6rjBVWVgTo1psn3q1w+twdMUIGo1rmSvuu8PP6KlHCbLbC0mbMkdaqsZLQkETe7fwD3Tg+Fze1WuQIIwCm1jfLOxn4C7MRmr28jBKJ5VRwfylRJowewsO9RxdDwfgOqJv/zmIh+LAWaPkzOpk1Eb/Pox3StW6kaofQVLqmwhAQgyhrYc/h+luFR0ReuBx7wfaYMuimZnnnaDw4peGveeJfaeNxWzuyZUAebJI3jhgKX1KL1jaZ859EBRF8C34H9S3KC2So7tEzJYsoCnR/0fSaEwUUjHmqIfCxFBE2Mw+DxWfb/mgZRQwjhQIc2hhv7Eih2za2NvFvsZdJbO58/oQd8nCC4MnNuKfyqJYgHXqd+sceZEFrn7CtPgadOLS1j6pFdHpAc9ahEahMAJALkaL9OGLatn9Fb9KqxY4E/NwqivlsK3dBp9K7pfMsnK7PilmvaQuThRrXy31XsB9wct0Eimh1PHSTBPQ/j/3xMauiToEE4MBKUxjIaVCZ1UUbHR7aBkySde3ZeMzsAZ48CvSMa8YdxXac2v+p/anuSOj5Dw5ngOa4fC0rn7W9HwUOnZnkeGdOZFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(186009)(451199024)(1800799009)(31696002)(6486002)(6666004)(53546011)(6506007)(38100700002)(45080400002)(6512007)(86362001)(26005)(83380400001)(36756003)(66476007)(2906002)(66946007)(66556008)(41300700001)(54906003)(316002)(110136005)(5660300002)(44832011)(478600001)(31686004)(4326008)(2616005)(8676002)(8936002)(7416002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdzMEQ3RmRYNTZvaUxaS21pdTN1ZmxkZG8yMFBDNWovRHFkZGJrQmx0TXA0?=
 =?utf-8?B?eXVRWnNpdGVqN2pPVjh6RFZVYStqakRyckpmOU9wc0s3akp6REdBY0Zjayt5?=
 =?utf-8?B?WXQrWFNQSnBCU201ME9mcFI4Qjg0YlZMSjBwS3ZpQy9MODA2QXdJTEVINFdh?=
 =?utf-8?B?R0ZTN25MS0ZNNlVYR3ljSFJ2OE16TUR1bnhzTlRscjd2N2VZM0VYNHZ3UXRo?=
 =?utf-8?B?dTljVVlYVlg0WDdsNW5KanhzK0ZlWEZNVld0Uk02a3hEMEkzVStaODlkWUo5?=
 =?utf-8?B?T2R2UDZUQ1ZHZHRKSUczNDA2bzRYcndCREhMbXZtZm5POUJSTkxoT2YvTXZC?=
 =?utf-8?B?WjZLM0JTc2h1Tzk3Z01JVnhoazBqcTd6cGFwTnNCWkw5dWIwNUZ5Y0RrY25S?=
 =?utf-8?B?R0pGVlErR2xVYXI4NnYrTDhVLzNuNlRzZ0FEbThPVVZCSFBNS2hZbk53OExH?=
 =?utf-8?B?WHJuQjdmVXpjNGYvdERKaTM0d3d5Q0RBcUpCNzJkR29lSjNNWk9RTy8zMm1S?=
 =?utf-8?B?eUorMmdobVViRk1Wd2RuVzNObDNlbTJhZVdaYm9QR29rWGRBNEJzaEhmRFhQ?=
 =?utf-8?B?SFpJMXRGSXRWSUlnaU5qZS9yNWVjdm9GYTJYYU9hVjI2RXNRSmlobmRDMFB6?=
 =?utf-8?B?T3orUVdGNDRBVU1PZ1haYlcwQjdUOGh0UFNWOEhySUlMQk1EbDhhUFNXQWN3?=
 =?utf-8?B?MXdTQytUODk5clAwZVl5R1hRUkpleFhuTVZFZDhlK3NHcmJiZ2ZyOHQ5SUc4?=
 =?utf-8?B?ZmRLTXdKenJEcUJVSDRaVDk0eml4SEdWalpMajF4ZStMOW9ZY0FsQzVxMHNs?=
 =?utf-8?B?ZUtodDB5R3RMdnYrWnR3U080T0YxK09PR25LTlRlelJUTnZaenFWeTltM3Vr?=
 =?utf-8?B?UEJCS3htelBRVFV6d2xDZkttVVBiRGNlMUNnZ0hWTDNXdnR1SXJvUnc1QjhK?=
 =?utf-8?B?SWxscEtFamFDWnIwQWUrMnNOTDR3Nm1uNjduNTE5NHlEdzV0MnNFUXQxcDlE?=
 =?utf-8?B?T1pDeEYxNklRWnBZZjczdTlsdzQ5Q1R5U3RzaFlldVpmNEVTbmo3b0Q2M0xt?=
 =?utf-8?B?di8zZnB1S2I0MzFCYVhTRlU4VFY1SUhIVWYyb2MyNGNGS0xNNHNtYy91cW1w?=
 =?utf-8?B?ODVZZjRaWUpJVWdZa2tHaWhwY3hUc2FHcUQydUxNVFdqWnIwbHlTUWNGQjR6?=
 =?utf-8?B?STF5RUppOEI4YWNGblpSWEMrUlRPQ3hjUUthWDZ2Wm12N3BEaE9EZjhVanhr?=
 =?utf-8?B?Sy9jNncvdHVjazV6eEo5YjV5VFREQUI5TU1DaE5taXZUdUIyR29qU0oxZmox?=
 =?utf-8?B?R2dlRkhNTXlsY2d4VnZ0bysvUGR2YVFsL3puZTQ3aDREb0w4b0plcDU0cDZI?=
 =?utf-8?B?eXBQb0dzODhSYnIvQ2pia3IzTDBQODNOWittWTBHbjh4Sldla1luNzl5QWxn?=
 =?utf-8?B?d3NMcWNib0VkbWhmUFlyZGZpbHkxWTJaY3JzTnJ5d1pvK2pFSGVWNUFHcTRH?=
 =?utf-8?B?WnNmclg0bzAydmlicWZWa1NXZXJ2VUw2Yjh1TFRrRGtJSGU1YS9KdjlIR0F5?=
 =?utf-8?B?cXFTQ1Nkekd0RDgyVnZveUE0UmRIbkFFbG9abDFVYnowR3BiTmpNeVVOOXVm?=
 =?utf-8?B?cjR3SGtyNVQ5NHhzSHgvVnZDRUZtQ0hXMGhWV0s2Yks4ZHVVdmlwTmxVMFZy?=
 =?utf-8?B?YTRWK2F2WGpMRSsyOFhqajcybFJFNndzZEZyNzVWWFdQNVlkcFVZakg4TUg4?=
 =?utf-8?B?U25ISHBITVJncER0dDZWZm0zRzdKNEJjVzFObWFQSlpCSUtrbFVTazVXTXBn?=
 =?utf-8?B?VDBVcjUxWjhtMHVYTnFzaEJxSHkrenErVzRNV0RrOEdZWkxpTlN0dWdDZ2NS?=
 =?utf-8?B?clVEZzBQaHcvR2NEdklmU2JoWXFKVnNkK3ovM0xXSlZxaEFWZ2g2WU9BSzA0?=
 =?utf-8?B?Z1YvVzZFWnlaeDhvTkd3d25xOGI4MTJHRVQwSXJIM3FzWGZ3SmlYYlk3cjQ5?=
 =?utf-8?B?YnpaZmU5cG9NeXV3T3pSVnNUOXMycG9vTUx6M2toUVQ3RmZoYUtPK3N1dFhx?=
 =?utf-8?B?a2MxcThFTUp2VkNNdzg5KzFLTWlBaFBFRHVIV0RDOVBzZDZ4NTF3cjZPeFEy?=
 =?utf-8?Q?5t2TlEbl27pvgXfMsioHm750P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb20b3ab-9a08-43cd-958c-08dba40af78c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 18:58:41.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3B/NoavPqh0S6Jj0EZ8evlT4RlSLdvITD7xsx8OaoV2XLJKzN4CRkMUItrHNJBI+xFKELZ7JqieRIQ810/8rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/2023 12:40, Jarkko Sakkinen wrote:
> On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
>> Dear Jarkko,
>>
>>
>> Thank you for your patch.
>>
>>
>> Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
>>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
>>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
>>> reported systems the TPM doesn't reply at bootup and returns back the
>>> command code. This makes the TPM fail probe.
>>>
>>> Since only Microsoft Pluton is the only known combination of AMD CPU and
>>> fTPM from other vendor, disable hwrng otherwise. In order to make sysadmin
>>> aware of this, print also info message to the klog.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
>>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> Mario’s patch also had the three reporters below listed:
>>
>> Reported-by: Patrick Steinhardt <ps@pks.im>
>> Reported-by: Ronan Pigott <ronan@rjp.ie>
>> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> 
> The problem here is that checkpatch throws three warnings:
> 
> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> #19:
> Reported-by: Patrick Steinhardt <ps@pks.im>
> Reported-by: Ronan Pigott <ronan@rjp.ie>
> 
> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> #20:
> Reported-by: Ronan Pigott <ronan@rjp.ie>
> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> 
> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> #21:
> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 

FWIW I observed the same checkpatch warning when I submitted my version 
of the patch.  I figured it's better to ignore the warning and attribute 
everyone who reported the issue affected them.

If nothing else it gives more people to pull in and check any future 
fixes if there is a regression caused by this patch that forces it to be 
reverted.

> Since bugzilla is not part of the documented process afaik, I used this
> field as the guideline:
> 
> Reported:	2023-08-17 20:59 UTC by Todd Brandt
> 
> How otherwise I should interpret kernel bugzilla?
> 
> In any case new version is still needed as the commit message must
> contain a mention of "Lenovo Legion Y540" as the stimulus for doing
> this code change in the first place.
> 
> BR, Jarkko

