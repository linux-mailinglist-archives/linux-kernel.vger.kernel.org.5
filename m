Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5669377D3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjHOTwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbjHOTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:51:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364AA19A4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et+BRfbwfp7M7JEs8iwNisnaoE22MqnfU2ILSFzwBxfXoYOnOSiavk+x7qEeFUAl8ChxteHlZnHmE6yCwTUpdQZUQOYPYFuVV/KOVtyDue6JhOmOIfL1ET2aBVXDteUzbTOiJi2WrOPqvqlMF2ZwA9vuU3VWp9NJG8uPJ4BRbBJMZfTyw+rv2/BnfseSmubrzTD8SMToTuF3N8QpkoV8nVH4ivYeRPt9AzeKPaovnmj0zmCh42ZSjbprGLtX+6Ewv7seY45eLaTz4b4X0xBG4ABIw2jTx4l7UPlhLqilpYAGSrqWjyVWFspf1OgM9l2MdUGFirltxmtKa2OsAoQk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkRMHRxraKammyS3Q6Yg4c/fdZW43Z2Y2SvUCKwO4HA=;
 b=BnY1ztFhmRuz/9LLPqTDJmPZBFq3ekjS9SKz0Z3VIUo5aoybeRwoElFErdxGzEGzmYvBKF1KfNgkJEeKy9qrC4LyYt+vfEzPH9x/tQ4eVsdfWeHIB8BL0jkbUJM5QBV/dIBTU7Q0eFCCEkjbkW0qVkwIFpFGuGOYO2SDDcyJIVC+cLecuknA04eDtTN0/q/UjUNt7wjx9yXtt9OStACT8dJboA1uBNnI37upops2h1/gEvPF7FJK9i6HKWdG+cIwqstJaw5OdS3nU5aMbf4+M5czc1Q/UrCjL6bfByPwtk1EalLpx/ylqpO8ucMAtqMGW/KkAzAdhZMB/SREezw3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkRMHRxraKammyS3Q6Yg4c/fdZW43Z2Y2SvUCKwO4HA=;
 b=ljx5umP5T4UH4WdLnZitT70oJ1yROvtarALC/BtmfXjR8+aA3vxjD0bfaE4vc24GuKZnurVL1TSryXe9jQCct7FkybdUODzgMbUvSNSTIcY/QxWR78rul4IG41V64lSyiHrKTxEWSXUimhkSBxp8Ttk9xCgBo34KdAhVtTkD0lQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 19:51:50 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 19:51:49 +0000
Message-ID: <53d6b712-e2e6-9188-51c7-6190a42dcc5f@amd.com>
Date:   Tue, 15 Aug 2023 14:51:47 -0500
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
X-ClientProxiedBy: DM6PR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:5:337::16) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b595433-9bb6-4f95-15d9-08db9dc910a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FP+Q0oRvil25oqi0GLw9rw6ryFNwzLoqEq2HxCHo/ixPhZ6loa+g4V4eKhuDdPtfV55+zi2O5/bO89EdprksM7HZqQ2SxT0c24CBq8/D3pghDqDJxUM9zvOIgef532QtpsDoUSyWOkjEFQV9BW4Rjp89fg17ubzN7eXb0eZjmhyKeynFvQoEKygps6GVMAuvQFUh5aMWSuIWLfkeq+jieRS88X7YThkJfDoVq429YnnIrIIvumJh50dmun+YtvKaM1qI9PAD+dGDXaqLm55yhKLtc6+k0HJGmWdR0o6eroxO5MUGUO7rgJUj2x1n3ghSFDjsfMAwGbOWs6IH/cRPzRF9gfUfzdk9hEZA5+UOsW+F8+CPcaKkNp2hmFpbxY5NCYo9dIzurCSNi9Hr3DlhugHJxQlnqdLbbZ3l96Ku2tdJpEd+HUsnCuQhtzYEMOtsOXHRliNOE/49r34GpqWx6AzYMB/8NYYMlsnENV2cJJI4XmAzTMmqv07HpZ8Md3a42cBELBALlyixZk1sarmbJdlmBy17k54Ehdw7wdX6SbBbp+rFfDulDRximoHNr+TDPynO73EMbDm4Xe724r+9+wXutwkVKPT2ie6PNyrB4D8rEfTRFeMAzZJOjHiy4hlJYY3IYjyP75pDwt0llfXq3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(1800799009)(186009)(451199024)(316002)(66476007)(38100700002)(31696002)(6486002)(2616005)(6506007)(966005)(6512007)(36756003)(53546011)(7416002)(26005)(41300700001)(66556008)(83380400001)(54906003)(31686004)(5660300002)(4326008)(8936002)(86362001)(8676002)(66946007)(2906002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTkySWF3SVpYQ29KTnExbkRyQWQra1laakZVV003eEZyaDc0RlZNbTZzaDRW?=
 =?utf-8?B?KzBzZ0ZmUWZVOXJtTm9GUEhnY2VZa1R3eVp6ZStlMkxhZVdCZytXMFFhcE83?=
 =?utf-8?B?U1V1WDlYSjFmZ0VtSUtSaG1ZUEIyenZPK3FWMHZVWnNOcmNqSkRtWjczSTBD?=
 =?utf-8?B?dkh0MnZhVldOU1dpQ0hFZDI5eS9mdXdNejRrcjRQYktjeGoxa2hML01BK3pK?=
 =?utf-8?B?QmNBdUN4LytVZEg3dEZrZGl4Y3hVaDVGb0dtNWErU3BCc3Vjb2pYL0VHeXNt?=
 =?utf-8?B?RjVNaGIxY014bFdBWExTYW8zd1VSblJ6WmpuLzZBQThQdWpCTTZiNjkxVGEz?=
 =?utf-8?B?NjltUWNOWE1Sd2wwOUpHRmRtclM1VUlpbkRLTW9RTW8zazBPL3d6NnZHV2Ix?=
 =?utf-8?B?c1J1Wmh6aE5OUSs3QXlQQVRCUTRPWHl3TDdVcXdXYzYyK0xNNUtrSmI2MXk1?=
 =?utf-8?B?YU9tVEdoem5mdC9iay9xWE1OSVc2QjJFSVYxTjA2VmJlOStlRTJQVjIzM25H?=
 =?utf-8?B?UHhRMUhsVjk2N1JWTGZVZlFVdFpOblFTRHF1Rmw1ZVBjQlg1SVFCdXZudVZR?=
 =?utf-8?B?dnJmZm4wQUhub0lDUTlKNVY1bVZ4aEIwazVzTzhDWVRFRjlteTRkTlVYUitx?=
 =?utf-8?B?cWtRMUVTRmRHTEZ6b2FSOWpHVWp6MFNLVXZnR0RnS2VkWFZiQWIxc3FPV2pY?=
 =?utf-8?B?MW9wcEtvb0ZDZ2JreVRMd29uM3F1NGJJVE9JQWVIRXlMaS9nNnFyZDVjSEh5?=
 =?utf-8?B?Z0hoT2xaU0NGMU5WZFo4TEtGRjd0WGd6cThQZlNtL2Y0Z3F6RWh5YkxhbUpz?=
 =?utf-8?B?NkFCSUNFMXdGcjM1QmtzUCs2UlB3cW5CdEdUMjRjRzJRclZLZlVkVVBlelJa?=
 =?utf-8?B?dktwYjh3Y08wd091UDNMRjNSS2plc24ya1RMZUxjWmlzazA1M1ZyTkJHWW1k?=
 =?utf-8?B?YmNMaklzYW03YloxY2xzQTRIenFhOTZndmMvRDBJRDIzM3BHdG1LWUpLUXpR?=
 =?utf-8?B?OWJsYWFFSlpvNjFwKzNTOElCYUM5NkJicnhlUzFyd1A3dFd4Y2NFZFM3a2pV?=
 =?utf-8?B?Yjh2eHhGS3BjSWh3SlczblVJWVdhbmdVOVVoZlpVeElwaUZaTFR0L0lHTEZZ?=
 =?utf-8?B?SDlHWFZaV1VHcUNOM1ZFZlZVektldDlNL0FhZFVPVXBGZnRaVnhqbEtITFRP?=
 =?utf-8?B?WVFjVGNNakFNWUdRMUZFTjlKalVEMmJnNUZ4ZWhmcXRXVXYveEhqZXNmNURS?=
 =?utf-8?B?Um5PNFZZOWNNRDZ3NVBscUtjR1lkNk90NmJkTGVVVVNWY2creHcyVUcwQkNx?=
 =?utf-8?B?ZVVxbnFrMlhRSXFTdGJEY25lNEpLYUZycngvZ25pdWQvZFhuWk42YU1JYTI1?=
 =?utf-8?B?UzlSM2ZOTDJWbm41a3ZDc2hteHV2VWYxQTBZWDQ5bVlIb0lZbHdMdENsOTZM?=
 =?utf-8?B?S09ZL3ArRE1XRlpreDRRcTByd0ZiN1ZoVkUzU3NoZ2hVZk10MDdaTEJUMGkv?=
 =?utf-8?B?SWxBNUlxWTdhWEFhMHdPNG9adHlieGlCU04xZHlEd2dKL2FUSTNxVlNVUEs1?=
 =?utf-8?B?VTZHNzE0b0JaTnJCcVBNVVFOMVZzRzAzZUw5TnV1TDl6U212bG5IS1gvTklR?=
 =?utf-8?B?cEtYdlR4MllXemU4QmthaGwrQmJmdEhVa0poU2ptbHphSFg2dWhqYTZWZFlZ?=
 =?utf-8?B?OXB5RThpNDN0WTVnUGZraGV0cjBNMURyS1BscVM3QWg4WTZ1SFVJNGxuRS80?=
 =?utf-8?B?UXc3cm9oNTlFNEpSb0pNaXNoYmxWejAxRC9HdDM1RWZBUTFsaXdjUlFqaUJX?=
 =?utf-8?B?VGhIWnZMK2UxVitXNC9hZjVsWTJrbC9udWJIZG1UMDNlZzd0Y1lNWXFQK1d3?=
 =?utf-8?B?WWlReGVqZk9obk5wcTlFcndOODhDZUpIckxYaDVzVUlIQ1dyUjdoSTlZUy9V?=
 =?utf-8?B?K0tXSERSV09JWHU0T3lQcEZTUnlCbGFiWmZLM1cxWDRTdUR3elNNS25wY1d2?=
 =?utf-8?B?L2NKeXlHU1dqVHRvenRqaG94WVFKUTlNc0NndWZ6ZFMzMDA3a21wTlFpYXQ2?=
 =?utf-8?B?T0FOUmJqSHJBK2pSN1lsMVBNUHNnMzFldnFZdXFrVU0vV2xvRlBLdjU0eDlV?=
 =?utf-8?Q?Fk005ua8/S4Ivp8ljD0ayFd6Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b595433-9bb6-4f95-15d9-08db9dc910a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 19:51:49.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw5RU8E568G9zfpWASfFDztruVL6m0ysTzzeB50KDS9ySJ+CG30wzhEEXfqQKaA0LlnLbASeRWE3dyYorhC01Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Is an array_index_nospec() call needed after this check?

> +
> +	rc = hex2bin(inblob, buf, inblob_len);
> +	if (rc < 0)
> +		return rc;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	if (memcmp(tsm_report.desc.inblob, inblob, inblob_len) == 0)
> +		return len;
> +	memcpy(tsm_report.desc.inblob, inblob, inblob_len);

Should the portion of tsm_report.desc.inblob that is not updated be 
cleared if inblob_len != TSM_INBLOB_MAX?

> +	tsm_report.desc.inblob_len = inblob_len;
> +	tsm_report.write_generation++;
> +
> +	return len;
> +}
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

Looks like rc is used uninitialized.

> +	}
> +
> +	dev = device_create_with_groups(tsm_class, parent, 0, NULL, groups,
> +					"tsm0");

You can go out to 100 characters now, so this could all be one line.

Thanks,
Tom

> +	if (IS_ERR(dev))
> +		return PTR_ERR(dev);
> +
> +	provider.ops = ops;
> +	provider.dev = dev;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(register_tsm);
> +
