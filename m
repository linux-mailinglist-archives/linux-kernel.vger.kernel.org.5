Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247B580C75F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjLKKyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjLKKyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:54:51 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C25F7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:54:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDA7MGYN78L5w/KDiRR38KdzaOg1WUJE5FEQrumIu8rBCOVCYatb8Ec9s+xdh3ZVeayCqFmOqXOB6OdPUOHPwCkcYbsGc60F67m4mmK40/82DWZ2qf+n0L9kS5LX3E4WF+21farjFmP+Gr6Ldurn22oSqVGcRzRs1jzPEnvF5kycwBvdcWkTUjuWVNAXzcAEn4nKo0auBfsQdwbDlLJgE/hnvd1u1ZYU7bRRM9f4veHDrJwwFPKvC79wLYxUJ9GRpAw0DBzCDNjrZhQV1eWKq1bNqoiOG/XGDKxIoM1hZPPVDcyFa/Lh/8hBx+pW6++8Vidpu27XVquC3C20Y30tAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ266Wvh/U4e8Su1DTJcz+RKNNflcVHYKFE8LpTPuYQ=;
 b=RtRmPXcuI9qGDYnn18vuEjun0auJx6S7NECWyL5JpHUTOYgtyFwEieEXILkRwyfPhtSrS/e4NiEdilq47ZlO/73YuqnJFo9FKE8ktG7u/yp2dfHKaSm0bN854HFbx2EJNLes3TiwGir/xsptxDH83LofiGpLph2KmUMgWj9ZVFdBWT1OiLQBC6J0Y3EujeWPSqQdcxj0GRPg/WZQHb10VDCLNJVpTrCIbL6pL+97zqwOBARbCvpsgpq3IQ30zBV2LJqQ61B2GUz5HnmheUE0S24S2vj4gAAgx0ff2pqY1CVaJv8PBBA4n7TAq1tKv/ipTj/MsmNP+LNkUS89Z8UI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQ266Wvh/U4e8Su1DTJcz+RKNNflcVHYKFE8LpTPuYQ=;
 b=glMbWmbr7/8b9ZNzlNryZ4tzQboDuydynmCag+x8yR9rWni13n22wZfESBSNWjpV+8FVTbrwN8FJWbvgvQA+SzyD1/yWcsKab+/E+OH0O4HY9hH5PXBdVk6uapSXYevUF+Ojeog8xBSWmptL+yIWTd4ZQT2+VRbFmvmxGjbEO8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:54:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 10:54:52 +0000
Message-ID: <38f3c90a-9f11-43ba-8657-336486607a4f@amd.com>
Date:   Mon, 11 Dec 2023 11:54:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: Prevent multiple error lines on suspend
Content-Language: en-US
To:     Woody Suwalski <terraluna977@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>
References: <78cc3067-b458-5cf2-d9f4-908aa5a4c5d5@gmail.com>
 <6beb3bab-b559-9333-320f-f0c03eb24326@gmail.com>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6beb3bab-b559-9333-320f-f0c03eb24326@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bd958f-72bb-421b-35ea-08dbfa379a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkVnz5eMoG0QeYCpFxZCib9QpXLJVtpZ1QUP2pnqauAdLc17qrBE1Lg7tvCPVcRHnPui3DAKvzQNDXT210wuTcU5rNp3EUs2J1N1KqY84w7iFYU5k4J5JSOjiBEaFnhkVx6vL35G2RLdeG3lohe7/aJZ6EZz7o96bvy7YpIP03msYmahVbvVbZD5Z1rSSlJ4BfRBhdYOnPI30VbazkGtPAiN3TqpsHfIxVxdGIEKD8g1O7NIZL4D4L08K2qBYt3iQRKmskVGBiEKw7rL206lcBKFrp5+kT89GKiAQXUC5I/0yQ1KnaIMdskxiOiaBQQ4M0mTkVfwCYIga0yB9Sl5ZPNqsjgCU5GJjiEkyD6SGEeHuG2ujKJLoI5CZqPxnmMnQQJlRMs0QFitfomIcF8K/cuuK+iFNQNCung3uDHivf2aF8Y8sYg6FwQ7PpZy03r9mh+Qopk+YOKnAV8xMXk8R1d+787dUwS8muWnytlCFLVH2RFXKGb+XIs8PHfLPB04rBNSdIW3HjkRA41nCVlGLsPiMwVJYdqkmNDRW/ee8TsQcpwUte8/5j7CB5zsdTDMn4viSNNrBZ8skUPa04mseOkW7ZaRlaXRvO56EWuS09avQW/2GQEwfcYnrk+kYGKFADFabzxWMuQKkakExUIm5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2906002)(478600001)(41300700001)(31686004)(66574015)(66556008)(66476007)(6486002)(66946007)(110136005)(15650500001)(316002)(38100700002)(6666004)(86362001)(31696002)(4326008)(8936002)(8676002)(6506007)(6512007)(36756003)(5660300002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUcwUjBhY2pTRWI3WkpENUNsOFZiSTRPVlhaWmUzVTNOZXVJY2dqODVxUk1I?=
 =?utf-8?B?UkVQU3RlL3E2OTRHOEEybXc5UjQ1cGpCb01QdWRPY1FwK1hwcndteDh6TGlV?=
 =?utf-8?B?YXVHWm1haUJ5d2JzQ3YvT2lsVGh0QldtV1J1RFFreTZDUk14UTVzMzhLUlBE?=
 =?utf-8?B?OFpLTlJ0d3cxL1BaZXhvYTdGbkwweEY4OE5WNXNlSDloSDBzazJXTkk1WHhX?=
 =?utf-8?B?QW5mTlRVenpFZGVuTndwYlNDSnpKUnFkN2NMNnFLeFlTbXB2UEVkNlBUOTR2?=
 =?utf-8?B?Mk56KzUvNUZhdzA0bm8ra0dBa3VPV3BMYklTUW5TMU5Cc3ZodXA0M0p1L2FG?=
 =?utf-8?B?a0hLc1Myc2NjZkRraGF0bDNRR3F5QXRSSDdjUFJycFVSQTJLWSthZUY1eXVZ?=
 =?utf-8?B?N2VMRDVROFoxa1NxUGlFSWlSZjBRaEVweWx0eG1SeGNmRXRqUWE2a1NSOWF3?=
 =?utf-8?B?aTNJWEpSbndzcDJRdi9WWW9QWHM2U0ZnajFsRW95S2JPVzJNNUdnMUFVdlNE?=
 =?utf-8?B?NTh0NXFQY09EOXkrZzIzK3UxRm81cUsybHpCelJsd0o0VXNlRzc4YWt5UFNI?=
 =?utf-8?B?QnpaTzRWZllDT2pjcHJWdDNLNkRLVGF0dlUrOWRMUXM4TzNBc3d3VkdOaUpJ?=
 =?utf-8?B?TUNIMEo2UG8rWmc3U0hYUFl1RUJjaE1PTHRuZUVqUUtrVDFiYzhkL2lESjJ1?=
 =?utf-8?B?Rjc4eTk4OFdsM25qZWZla1c1bkJ0MStQODZUNExYYUxmZUlMOXM3RmY1TzhX?=
 =?utf-8?B?T3pHdTIxemZPNnJ2bjQydllrOGhzRzRyZFJCQ0ZEbmoyQWtDZGdaSDE4WXNV?=
 =?utf-8?B?d1dmWU5pQ0FNMkQ1OUxwME5ES2RSUG1lQXZsdnd4QXBwRmpuWUVRZWdlYnRF?=
 =?utf-8?B?RjlkUXRXa3lJMG5uSUxEUmRRU1ZBZUEzK1VBakFaMnZKOGpyRjM4R0xGZnJ0?=
 =?utf-8?B?ODk5QTBmZnRCemJ1Rk1hempYQStZNVdibWdyWm1YdTh5ZUhTVGpFSFVKZ2cz?=
 =?utf-8?B?ekxDWWk1Y3g3YVM0cllheEFvWU1Tc1dDbHU3cUZ5YzN3ZW4rejlTYXZObHpH?=
 =?utf-8?B?dHFFOHAwNVNQZ0pkRERBVjdreGI1a3RjSW1rRWlUWWw0YXpKZlVqcS95K0Vm?=
 =?utf-8?B?ZFVDdWVFdDgvYTBodUZtV0dsSFZDdG11TllKajZPaEdsQnBqT2JuaTNvSmM3?=
 =?utf-8?B?b2E3NVpCa3RtZDdjWVFpLy9YRmt0WEZsRlRyRTVGT0Y1dmRKa1RGZTVISzl4?=
 =?utf-8?B?ek91MzRickM4Q0NvRmw2R3l2bWdwOWJBcDNOYkpvSFQxbmZKOU1GbENFMnRU?=
 =?utf-8?B?RStoYUpaZnRuTWEzaDNkVVFUVVN1VHQ5WEhVMWR6NkZNejJNQWh6WUYzNDB1?=
 =?utf-8?B?eEpXSTRjSkI5M0VXcStvUkpSbUhyOUVGb2JweExIRVMrbUxUMFJZeFlaam5q?=
 =?utf-8?B?R1FucXRqN1hGc2gzdFZ1enhvR2tDNC9jb1d1b2krVHVqR3pvK2kyU05qV2xy?=
 =?utf-8?B?OGx6c3dUb0hLN2FlR251bmFNcEpOOVphUFJ3MU5vVGZPRk40SXJWeFJQczk1?=
 =?utf-8?B?clpRdWdkU3FEN0p3cGJBbkNTTWdvajUybWh2aSswZlZEM2c2NHNuZmR1TEZi?=
 =?utf-8?B?T2JGR2tLS2FIUWwwYUM2TkMvTFpQMVZtL2ZIenJ5ZUZiWldLZjdYdFYyNVdk?=
 =?utf-8?B?WDVpYndLSDRxNTUwSjdSYmdUTzJac2hpYlN4d2JOK2trWTdEQVZyOFVuUTBw?=
 =?utf-8?B?eFA5cmFjZEZSclR4YjRnV0xQSTZDUDBCd2R4M3hVNHArYzZEUDNwdkxEK1dN?=
 =?utf-8?B?emFscDV3QXVRTVZLb3grY2hMcDNzUVhQUElOZ3VYUk1MbkVjT0lmMDZ2dDFM?=
 =?utf-8?B?STNKUVNnWDJtWmtrajA2MnRVQXM2L3ZybTcrRDZvYnc0VG1waDZBNnlBWkZi?=
 =?utf-8?B?WnlxcGFtZWd1NmJjM2lOU1RRTlhYTmZhVDJFTjVOOGs5dkpQZVJBZFhUZE0v?=
 =?utf-8?B?UGR5SUxBellsY2kxcllEQU1EYjhTTW9TTkV1VVYzRGV5ek94MjFZeUJ4ckhp?=
 =?utf-8?B?TVV2VHM0bDBBemhVRm5UZ2x2SS84ajlvQjI3RzBGZm0yeDNpOWdoYXE5a1d1?=
 =?utf-8?Q?5f+sQW9fvPfQ5fuB66AbN0po1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bd958f-72bb-421b-35ea-08dbfa379a88
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:54:52.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSiMMl6CGWzy3znlkW/ew5IwCNoIzhCOphrXwtfM/Zl91V9BX2UMBku5CCGhpkLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.12.23 um 19:24 schrieb Woody Suwalski:
> Hello, it has been now over 2 weeks and I have not seen any response 
> to this patch.
> Has it been lost in the cracks of the wide internet ? :-(

Well your patch is malformed ("#" before each line in the commit 
message) and probably ended up being ignored because of that.

Apart from that it would probably be much easier to move the call to 
radeon_debugfs_ring_init() into the if (ring->ring_obj == NULL) check in 
the caller.

Regards,
Christian.

>
> Thanks, Woody
>
>
> Woody Suwalski wrote:
>> # Fix to avoid multiple error lines printed on every suspend by 
>> Radeon driver's debugfs.
>> #
>> # radeon_debugfs_init() calls debugfs_create_file() for every ring.
>> #
>> # This results in printing multiple error lines to the screen and 
>> dmesg similar to this:
>> # debugfs: File 'radeon_ring_vce2' in directory '0000:00:01.0' 
>> already present!
>> #
>> # The fix is to run lookup for the file before trying to (re)create 
>> that debug file.
>>
>> # Signed-off-by: Woody Suwalski <terraluna977@gmail.com>
>>
>> diff --git a/drivers/gpu/drm/radeon/radeon_ring.c 
>> b/drivers/gpu/drm/radeon/radeon_ring.c
>> index e6534fa9f1fb..72b1d2d31295 100644
>> --- a/drivers/gpu/drm/radeon/radeon_ring.c
>> +++ b/drivers/gpu/drm/radeon/radeon_ring.c
>> @@ -549,10 +549,15 @@ static void radeon_debugfs_ring_init(struct 
>> radeon_device *rdev, struct radeon_r
>>  #if defined(CONFIG_DEBUG_FS)
>>      const char *ring_name = radeon_debugfs_ring_idx_to_name(ring->idx);
>>      struct dentry *root = rdev->ddev->primary->debugfs_root;
>> -
>> -    if (ring_name)
>> -        debugfs_create_file(ring_name, 0444, root, ring,
>> -                    &radeon_debugfs_ring_info_fops);
>> +    struct dentry *lookup;
>> +
>> +    if (ring_name) {
>> +        if ((lookup = debugfs_lookup(ring_name, root)) == NULL)
>> +            debugfs_create_file(ring_name, 0444, root, ring,
>> +                        &radeon_debugfs_ring_info_fops);
>> +        else
>> +            dput(lookup);
>> +    }
>>
>>  #endif
>>  }
>>
>

