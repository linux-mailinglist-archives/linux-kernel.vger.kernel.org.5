Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC4077E40A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbjHPOoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343839AbjHPOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:44:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3B2D4A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY4x5FQ8glZBqPsN15kgbmwQlqeJ1lsRFdXI/QLWEhB1pwLu+qtlp5MHj+SEzaBqg/SCyToOwPAhG0u4JWQ4l3u0w5UgCZCozk+y2ikm3oXMIB/EqeMt7+UXIRu1laoXcd6nvBKJTrOJJZ6GrhbCVoe6zEoFieZRmhAHBioZPGnHrqJ66urj2zYxBHxmWY4Fy6+Q3NTeenmx6sQ6DX6M7N9zAS9A0WxC8wFlf9UCAni6RxRPmPiV7jl/CuIS+4wMHt3d/8RovpbDgNuDzdclA/p4eW3IN74DnPEBxYpzwzW90d2Vk0Erwr9x1OB1MzcoD7VYnjyVC+y/iCOV+jZeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl14qWNLjQWvauSM96pEZeX7+gkzZN/QQg1soGhA4vY=;
 b=NAKL5P5aF2NWJRwFjtLQQ4Qe27es5MTf0f/WuRGfvv56Eh4jrxZTE4uaHmREXI9HntBEWNTuq95UKnNi0SyQg6c2+hNCUb7A61XtjY77B7vigy+t8masLAVVzQebbJRSngBm8nGDIFk1zY55cnSpSRXzUeyU5j4bL6MtjZslG3qOWwz+B9nhfGiGKgudjinRWmwgKlQYH92MHC1yuCCbV6vlbazTpzNJiDZAOwY0Y4GzHYLFwQe4yXefnyV9MviqvuwrWsYrd/xJWErff7xVAeawETSuSLAOy05kMpsvHIwDVDSLVimvxGzP4cWxOXBS3lTFTQKUcz1ceXPpSmIdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl14qWNLjQWvauSM96pEZeX7+gkzZN/QQg1soGhA4vY=;
 b=yMIp16Z7n3doMUvh9ij/lzE5CJ6Sg3dg4eDc44HTW5+bKLSFTQ2ccaHbgct7bmGmLci/yBew1lybkUDYqfO083RtMGGAhN0Voi7+jYyGUUMoqKlB3ss8B6s3rHDWaJb8jQbBEXVn1S1ZiGcTBD01JuwftxzKLaIauOdIFBNtG64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 14:44:09 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:44:09 +0000
Message-ID: <7fada981-bc73-774e-bff3-e9be56c52b66@amd.com>
Date:   Wed, 16 Aug 2023 09:44:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/5] tsm: Introduce a shared ABI for attestation
 reports
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::18) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: d75422d7-005f-46ae-9554-08db9e674010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVfGbAh+w1U5y7ZAjWcLwT+Qgl2iL/n5XolOfMTL5FBX+EIEmLZ3ZErGuiODYz4Aogw+FzI2u5o2Eqo/fHeRptCfEvk9B3VxbDRWzdt9SPg0h/J54nAYOGgbwLD+tMfjVvIP7lTgcylqVmsLEoe7DWPmX1fv93CSitjsKcoLWQNGr9HdDjWibb17DlieDE8juiLIKD5pzfpoR2yUV4yTdO8qoOnHNiqSSuDidnPAvo3eTHtwgnFoGudrS9mTTpfdbhAhow+ghWZ2nIDseWwO5oZLjZo2zxuOcFmAH2vmjNIPf6n7IYg1sYtbGFTrv2B282rWd09jYCsnPE5lByS8lgnA5QafB/WqubBK7DeOMiPkX+efzpq0Sqx12u6vXEeTPtzveK0sUN7Bb0Ad4rjckB/L5CDzqnkpREWq7dUXB8N5jS6vfWshVSIkiq5yK2+JTSUZ9jbLe859aiNMD6vq6/6u9TMvxz9dRcWfIAAVXdPhENQRvsB5Vp2FVeBRtH/MFlG3VNj2mU321qimTZiDdMRNzkUTc+HAAeiqyZ/KQwIOhetKOTBvPeAf0WkGc8Qxf03orIQY0ThDhvqtpQFmg/SMUog8leXC+hLQ4jKCCkCOgGnlJPPSpL4y0ffABxvbqGVEeed/kNzka3JUXepeJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(66946007)(66476007)(66556008)(966005)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(30864003)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUc5R0VNMnB5U1RGKzdNUEgwUmNNd1YwQ3p6TDN1VGZ5aWpLMXFUaXpMVWQv?=
 =?utf-8?B?ek8yQ3JuNDRkUG9JWVdkZXh3dlZUQjFMYWFFdXdNbzFXZmMzdTliTFJQQTR1?=
 =?utf-8?B?ZEhXNm53cmgrNGpxQVRjRi9rZTduL3YzR3NtMUN5NUVERjVab1VwR0RKanUy?=
 =?utf-8?B?ajNUMjJXVmpmNFR6aVJFeHJtSVVUUTFYSDNNWDEzeGZjTDBiUnU0R0FTMWl3?=
 =?utf-8?B?U0tzUHpOQzI5QjJVdHFQSnNDakFaVnNDeks0VEYxRzFheW0zNGV1UkI0ZElI?=
 =?utf-8?B?azdybzMrWERNbjNBbnBZY0Z3dHMrQjR3NUxlZzhudituUGxSZGw1UlZwUW11?=
 =?utf-8?B?djFGTXpMSjdiVDdjNTFLS25lcGRIS1FsaTR0VFdzYkxEMHlEL1hKaVdOZzJL?=
 =?utf-8?B?cVhuMXBadlRuZk10Q2NKQXYxdHVXT2EvZytFcDFJdy84Z0NvdXhNeUZ3NklB?=
 =?utf-8?B?UjdYNjVlUW9WSGxxcnNVWXlVQlhEODVTNVI4a0VtM0wxalloYU4rSXJkT1Ji?=
 =?utf-8?B?SUVhUkFPT1d4aVgyYXZWdEZtTVdxZUMyWWc0Mnc2YmFWLy8vckh1ZkxtSlpz?=
 =?utf-8?B?VCtzeCtOV25BL0ZTT1dLamM3ZG04dE52MnpJaXM5SVQwV2dES0dzUVNlSlNP?=
 =?utf-8?B?QTREdmZwREVwZ0pVbjJSV1crUkx4a3JORlBLa2Q2TDczMzA4UmpqMnBRRzJa?=
 =?utf-8?B?MVVJbGcyVno2UjhPejNQVEVua0RPODV3NVVJeFN1Z1oyUXBBeDhsb2syNWJr?=
 =?utf-8?B?TnlSRllFOHlHdTkrWWRrbE5UdnRod0NoaTFYRm52K1d3WUc2UkFLeEg4RWVl?=
 =?utf-8?B?V2REZkY1OUhzek5lYmFkajNMd1lUSEdwbEd6YktOaENVZkFvZXhaL08rbXhT?=
 =?utf-8?B?aE5BUGFYSlRJOU1ySnQ2U0dkU2FvV21sNzYzWlhVeU1oeXE0Z3BieHdSL1ZY?=
 =?utf-8?B?aU9DYWJac1B0d1lieXR2eURTbGc2cjVTODJkRzZ0TzRwZDdhVFBISHd3cC9U?=
 =?utf-8?B?TTNNK1k3c3c5aGwrNitOb2RIWXU3QkZiN2VNMkNIb2VrNWFoaml3M0NabCsr?=
 =?utf-8?B?MDJxSTA0T0pvN2hxWmpIb243VUJMV1RudDg1REtONmE1N0tVQmRLaTl0NDBD?=
 =?utf-8?B?Z3BpWUNuTEQzMk1VNnVHemlMSVhBN3BuZ3Eva2RXaURtY2pKK0p3ODNsOHBp?=
 =?utf-8?B?aWtZT2ZZWHhUdkMvQnRZLzlvd0FOeXp4WDNSNHlUYzVVUFRhZVZJZnZpLzZ4?=
 =?utf-8?B?cVF5SSt5a243WGJyaTRIeXZlcEZJZHVpQlB6SmViL3NtaTErRDQxbFhVNEFx?=
 =?utf-8?B?LzB0YXVKcEZqL3NpTGRkdXpibEVXTnYwUGFCRDUrN0I5MXZzNVBSTHVXWnpM?=
 =?utf-8?B?dmxValZVeWFCTFhPcXlscWkzTTk0bDBtdmJvN2JnK0U1TjhHcXU4Tk85N3lU?=
 =?utf-8?B?YkF2MTdxUEdOR0hKamk3ZEVKandtR0EwRU8vTExqaCtXTlVLanZyc2Q0cGRn?=
 =?utf-8?B?UjlReUFCK2VSbU56ZGZQZ0Q4MHZtbXBQUFkyYmNub0ZLUHE5ZW5XNHpiUkIz?=
 =?utf-8?B?elBuMmZZSFlXMFFCMWtHcUtMZDNSRmJPN1hTQXdBMVZDcFphUDhuemEwSXRP?=
 =?utf-8?B?YUhQSlVyYnVoQzZlQWhvWGVSVkRoZEFSZFhzMUxqKzRhaENxWDBGRDA2QTNX?=
 =?utf-8?B?R0JhYTgrbWIyQlZUTUZWUS9tdXVqNzN4cUsxWmVvYW14N1EzZXhsV0FNODBl?=
 =?utf-8?B?VDZqZjZFR2RqcGVEU21Vb3BlR0JpK29meGdCZXViS1ozOEJlM2xRV2xSenV0?=
 =?utf-8?B?aE5sOEJLTmlheFc1NUZSMTRZSXVzS2ZScFZTZTJNUE9JTTcvR1dIcW9qWjcw?=
 =?utf-8?B?bUJMMERqZzFoVytMNDc4OHNlMzdUbzBJUnRFNmp0dG9vSFV0SC80ZFlLL2pE?=
 =?utf-8?B?MXNkK1F4K1dFS2tFMHlWb05kVGRFT3RQN2F1ODFWNGp6WW45YU12L25heHVO?=
 =?utf-8?B?YzJvd3ZHREs0b0drWG5RbTZQbEZXSElpQ3Jyd08zZzRROWxiM2p1YTJFdlp4?=
 =?utf-8?B?MEpFWnY0akRpWEllYXc1QXJ3RElPV0FzeDJXN1JDaGZaUkpFUmx5TUQ1QlJW?=
 =?utf-8?Q?pyYW2nW2GIRJ3wVUYJCJE4D7W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75422d7-005f-46ae-9554-08db9e674010
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:44:09.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtdjOT5thVshAyxd/o9fHIZ4EBYNnwoWSCGUURcFyhSQ8Vd8OQXbgT4+Cuv6WxlwY7dpbyAfwbvPAD0UfyfkSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 02:43, Dan Williams wrote:
> One of the common operations of a TSM (Trusted Security Module) is to
> provide a way for a TVM (confidential computing guest execution
> environment) to take a measurement of its launch state, sign it and
> submit it to a verifying party. Upon successful attestation that
> verifies the integrity of the TVM additional secrets may be deployed.
> The concept is common across TSMs, but the implementations are
> unfortunately vendor specific. While the industry grapples with a common
> definition of this attestation format [1], Linux need not make this
> problem worse by defining a new ABI per TSM that wants to perform a
> similar operation. The current momentum has been to invent new ioctl-ABI
> per TSM per function which at best is an abdication of the kernel's
> responsibility to make common infrastructure concepts share common ABI.
> 
> The proposal, targeted to conceptually work with TDX, SEV, COVE if not
> more, is to define a sysfs interface to retrieve the TSM-specific blob.
> 
>      echo $hex_encoded_userdata_plus_nonce > /sys/class/tsm/tsm0/inhex
>      hexdump /sys/class/tsm/tsm0/outblob
> 
> This approach later allows for the standardization of the attestation
> blob format without needing to change the Linux ABI. Until then, the
> format of 'outblob' is determined by the parent device for 'tsm0'.
> 
> The expectation is that this is a boot time exchange that need not be
> regenerated, making it amenable to a sysfs interface. In case userspace
> does try to generate multiple attestation reports it includes conflict
> detection so userspace can be sure no other thread changed the
> parameters from its last configuration step to the blob retrieval.
> 
> TSM specific options are encoded as 'extra' attributes on the TSM device
> with the expectation that vendors reuse the same options for similar
> concepts. The current options are defined by SEV-SNP's need for a
> 'privilege level' concept (VMPL), and the option to retrieve a
> certificate chain in addition to the attestation report ("extended"
> format).
> 
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-class-tsm |   47 +++++
>   MAINTAINERS                               |    8 +
>   drivers/virt/coco/Kconfig                 |    4
>   drivers/virt/coco/Makefile                |    1
>   drivers/virt/coco/tdx-guest/Kconfig       |    1
>   drivers/virt/coco/tsm.c                   |  290 +++++++++++++++++++++++++++++
>   include/linux/tsm.h                       |   45 +++++
>   7 files changed, 396 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
>   create mode 100644 drivers/virt/coco/tsm.c
>   create mode 100644 include/linux/tsm.h
> 

> +static ssize_t privlevel_store(struct device *dev,
> +			       struct device_attribute *attr, const char *buf,
> +			       size_t len)
> +{
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	if (tsm_report.desc.privlevel == val)
> +		return len;
> +	tsm_report.desc.privlevel = val;
> +	tsm_report.write_generation++;

So I'm wondering if this use of write_generation helps or not. Since it 
isn't incremented if the levels are the same, that might present race 
conditions.

What if user A requests vmpl 2 and privlevel is already 2, then 
write_generation is not incremented. But before user A can read back the 
generation value user B can request vmpl 3 and cause write_generation to 
be incremented.

This may not be a problem for VMPL, since that can be checked in the 
returned attestation report, but it could be for the report format. If the 
extended format is requested but changed to default, then the additional 
certs might not be returned and the guest may think there aren't any...?

Maybe incrementing the write_generation no matter what is best.

Thanks,
Tom

> +
> +	return len;
> +}
> +
> +static ssize_t privlevel_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", tsm_report.desc.privlevel);
> +}
> +
> +static DEVICE_ATTR_RW(privlevel);
> +
> +static ssize_t format_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t len)
> +{
> +	enum tsm_format format;
> +
> +	if (sysfs_streq(buf, "default"))
> +		format = TSM_FORMAT_DEFAULT;
> +	else if (sysfs_streq(buf, "extended"))
> +		format = TSM_FORMAT_EXTENDED;
> +	else
> +		return -EINVAL;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	if (tsm_report.desc.outblob_format == format)
> +		return len;
> +	tsm_report.desc.outblob_format = format;
> +	tsm_report.write_generation++;
> +
> +	return len;
> +}
> +
> +static ssize_t format_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	if (tsm_report.desc.outblob_format == TSM_FORMAT_DEFAULT)
> +		return sysfs_emit(buf, "default\n");
> +	return sysfs_emit(buf, "extended\n");
> +}
> +
> +static DEVICE_ATTR_RW(format);
> +
> +static struct attribute *tsm_extra_attributes[] = {
> +	&dev_attr_format.attr,
> +	&dev_attr_privlevel.attr,
> +	NULL,
> +};
> +
> +struct attribute_group tsm_extra_attribute_group = {
> +	.attrs = tsm_extra_attributes,
> +};
> +EXPORT_SYMBOL_GPL(tsm_extra_attribute_group);
> +
> +/*
> + * Input is a small hex blob, rather than a writable binary attribute, so that
> + * it is conveyed atomically.
> + */
> +static ssize_t inhex_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t len)
> +{
> +	u8 inblob[TSM_INBLOB_MAX];
> +	size_t inblob_len;
> +	int rc;
> +
> +	inblob_len = len;
> +	if (buf[len - 1] == '\n')
> +		inblob_len--;
> +	if (inblob_len & 1)
> +		return -EINVAL;
> +	inblob_len /= 2;
> +	if (inblob_len > TSM_INBLOB_MAX)
> +		return -EINVAL;
> +
> +	rc = hex2bin(inblob, buf, inblob_len);
> +	if (rc < 0)
> +		return rc;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	if (memcmp(tsm_report.desc.inblob, inblob, inblob_len) == 0)
> +		return len;
> +	memcpy(tsm_report.desc.inblob, inblob, inblob_len);
> +	tsm_report.desc.inblob_len = inblob_len;
> +	tsm_report.write_generation++;
> +
> +	return len;
> +}
> +
> +static ssize_t inhex_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	char *end;
> +
> +	guard(rwsem_read)(&tsm_rwsem);
> +	if (!tsm_report.desc.inblob_len)
> +		return 0;
> +	end = bin2hex(buf, tsm_report.desc.inblob, tsm_report.desc.inblob_len);
> +	*end++ = '\n';
> +	return end - buf;
> +}
> +static DEVICE_ATTR_RW(inhex);
> +
> +static ssize_t generation_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	guard(rwsem_read)(&tsm_rwsem);
> +	return sysfs_emit(buf, "%lu\n", tsm_report.write_generation);
> +}
> +static DEVICE_ATTR_RO(generation);
> +
> +static struct attribute *tsm_attributes[] = {
> +	&dev_attr_inhex.attr,
> +	&dev_attr_generation.attr,
> +	NULL,
> +};
> +
> +static ssize_t outblob_read(struct file *f, struct kobject *kobj,
> +			    struct bin_attribute *bin_attr, char *buf,
> +			    loff_t offset, size_t count)
> +{
> +	guard(rwsem_read)(&tsm_rwsem);
> +	if (!tsm_report.desc.inblob_len)
> +		return -EINVAL;
> +
> +	if (!tsm_report.outblob ||
> +	    tsm_report.read_generation != tsm_report.write_generation) {
> +		const struct tsm_ops *ops = provider.ops;
> +		size_t outblob_len;
> +		u8 *outblob;
> +
> +		kvfree(tsm_report.outblob);
> +		outblob = ops->report_new(provider.dev->parent,
> +					  &tsm_report.desc, &outblob_len);
> +		if (IS_ERR(outblob))
> +			return PTR_ERR(outblob);
> +		tsm_report.outblob_len = outblob_len;
> +		tsm_report.outblob = outblob;
> +		tsm_report.read_generation = tsm_report.write_generation;
> +	}
> +
> +	return memory_read_from_buffer(buf, count, &offset,
> +				       tsm_report.outblob,
> +				       tsm_report.outblob_len);
> +}
> +static BIN_ATTR_RO(outblob, 0);
> +
> +static struct bin_attribute *tsm_bin_attributes[] = {
> +	&bin_attr_outblob,
> +	NULL,
> +};
> +
> +struct attribute_group tsm_default_attribute_group = {
> +	.bin_attrs = tsm_bin_attributes,
> +	.attrs = tsm_attributes,
> +};
> +EXPORT_SYMBOL_GPL(tsm_default_attribute_group);
> +
> +static const struct attribute_group *tsm_default_attribute_groups[] = {
> +	&tsm_default_attribute_group,
> +	NULL,
> +};
> +
> +int register_tsm(const struct tsm_ops *ops, struct device *parent,
> +		 const struct attribute_group **groups)
> +{
> +	const struct tsm_ops *conflict;
> +	struct device *dev;
> +	int rc;
> +
> +	if (!parent)
> +		return -EINVAL;
> +
> +	if (!groups)
> +		groups = tsm_default_attribute_groups;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	conflict = provider.ops;
> +	if (conflict) {
> +		pr_err("\"%s\" ops already registered\n", conflict->name);
> +		return rc;
> +	}
> +
> +	dev = device_create_with_groups(tsm_class, parent, 0, NULL, groups,
> +					"tsm0");
> +	if (IS_ERR(dev))
> +		return PTR_ERR(dev);
> +
> +	provider.ops = ops;
> +	provider.dev = dev;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(register_tsm);
> +
> +int unregister_tsm(const struct tsm_ops *ops)
> +{
> +	guard(rwsem_write)(&tsm_rwsem);
> +	if (ops != provider.ops)
> +		return -EBUSY;
> +	provider.ops = NULL;
> +	device_unregister(provider.dev);
> +	provider.dev = NULL;
> +	kvfree(tsm_report.outblob);
> +	tsm_report.outblob = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(unregister_tsm);
> +
> +static int __init tsm_init(void)
> +{
> +	tsm_class = class_create("tsm");
> +	return PTR_ERR_OR_ZERO(tsm_class);
> +}
> +module_init(tsm_init);
> +
> +static void __exit tsm_exit(void)
> +{
> +	class_destroy(tsm_class);
> +}
> +module_exit(tsm_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports via sysfs");
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> new file mode 100644
> index 000000000000..6dc2f07543b8
> --- /dev/null
> +++ b/include/linux/tsm.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TSM_H
> +#define __TSM_H
> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +
> +#define TSM_INBLOB_MAX 64
> +
> +enum tsm_format {
> +	TSM_FORMAT_DEFAULT,
> +	TSM_FORMAT_EXTENDED,
> +};
> +
> +/**
> + * struct tsm_desc - option descriptor for generating tsm report blobs
> + * @privlevel: optional privilege level to associate with @outblob
> + * @inblob_len: sizeof @inblob
> + * @inblob: arbitrary input data
> + * @outblob_format: for TSMs with an "extended" format
> + */
> +struct tsm_desc {
> +	unsigned int privlevel;
> +	size_t inblob_len;
> +	u8 inblob[TSM_INBLOB_MAX];
> +	enum tsm_format outblob_format;
> +};
> +
> +/*
> + * arch specific ops, only one is expected to be registered at a time
> + * i.e. only one of SEV, TDX, COVE, etc.
> + */
> +struct tsm_ops {
> +	const char *name;
> +	u8 *(*report_new)(struct device *dev, const struct tsm_desc *desc,
> +			  size_t *outblob_len);
> +};
> +
> +extern struct attribute_group tsm_default_attribute_group;
> +extern struct attribute_group tsm_extra_attribute_group;
> +
> +int register_tsm(const struct tsm_ops *ops, struct device *parent,
> +		 const struct attribute_group **groups);
> +int unregister_tsm(const struct tsm_ops *ops);
> +#endif /* __TSM_H */
> 
> 
