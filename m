Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7947D4510
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjJXBin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXBil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:38:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E292DE;
        Mon, 23 Oct 2023 18:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOJue2FwCXr4Ws2KOr8MaowOiKCO753069NNT3YtqjtXIvcV/DL+rQQADzK94YwJSkfACy/CS1bAbKJ13hf043G9QasUS1xIFik9E0p8UQax2o93ZTLuhFn9zgHSdeK3PXAM1zIt020X/X8sQLEzmzKRLPYUwJo26ypM8aCd6wJokmpaCB+xD5wUrNNxs9s+skPvQZArWAYJRxgxublBD4s+UTofhjj+yhJFIeYV65YIRU6F1Mq4hYuBo78y4GhumVqPfIKBb1Pz2x446UDFu3bQSE0N3KNAjynHkIIXO8OWtF2ujfypCnmaeWzFmfj3EnTQzmra3FgK7gT6A7T26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1kKeX/ihbXvvqP29nTaG88FY+RiFfbbwuu7Z17YBTs=;
 b=msN+zMxnRINDpJvPSANuhlxeUCegPhu+bwuRVQxhu+Qrvj1JoEqtGnUUoQvMnbMynnzm8cpPevYAXcja4cr0psRwCc6/DlwjEmYEwmkkSlcLekC5zn7HnTrsi8CmQ+Q6jeLV2r/W1yQLTHYH/OemxgCnmrZD0sMrw/ax/IlmuVXmPkRFSSI0qQXYNom9pCyGPV/RfkIloaHBGBJ4q/G4yEVje24fGpUTJCWRTXMEPtkIG2TtnDPMay2XCghJxJk4lSoc/To+6rTS/nw6gN1zhnSmkgt9eSNEgDPktY+wh6fA62zStulpGqabEPAyc7CFJ3PK9AALralePcQdx1wDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1kKeX/ihbXvvqP29nTaG88FY+RiFfbbwuu7Z17YBTs=;
 b=asVZ9TXA+bHEzs9QQLn3prq1LeUMdiRtBryhxyjgxRizPeSW2UHW2VVeZDBem7Sw6XJJzo8U+5YwJkJXCeeCIF5Ro4qiPTwp2ZNIxWJmJk7Qj4iTC0lioQkcj9mDsJriTuJbfvNo1F8cEmOvQOecsChOwhhfTyvrW+58qrXaSII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 24 Oct
 2023 01:38:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Tue, 24 Oct 2023
 01:38:34 +0000
Message-ID: <3f9086f6-935f-48a7-889b-c71398422fa1@amd.com>
Date:   Mon, 23 Oct 2023 20:38:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] tpm: Add tpm_buf_read_{u8,u16,u32}
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Julien Gomes <julien@arista.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-6-jarkko@kernel.org>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231024011531.442587-6-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:806:d2::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: eb84bda3-27c3-4c6f-05fb-08dbd431ef8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVf0AMHsmReD/yqcHR7gG7/8tMa5PorDxM+/YgcWIe5nNdNBH5oBTKo3XLVBb20iXqVIkFi4CX6LB8EdDgBusVfLaNR0lticazklgdia6GcJzBLR7st3jvDa7kfiWnESsrEurpRtr9uu5PrsF7QFTAmSFrmFhyg5TZZNJ7yn96CXzfmQJgEJ1qhW9m5Pi+0SthGCauAiQOf8keBPwhy84DjBgHatJ457W/RxoL0myNSEBb1gEWi7I673tbehrpOd+JqzCcZ953B7bbRNzNHHz8PpmuHrAR1J9Psd1PW1BP2ElAUgel7Ui3oP37wlSHgFOymTrQiWBNxPCHDu6D6fHDwDoUYRbiF961ZFRLbi4l2OVvv7Lo34rP0JM8TEjln8/8ugNMihc3PyFXTr89A1PlxtpwobFBDeqAlnMB1nTKJ/UQ9IUPhJ79fvQJCTOs27sYVnia5fF4flfk2ZY9poq395xHvgLqVZtvNO1HrOU75LDNGzpfhVSnic/ROrAOcqf3fNk1W3/5toIL3gyS46G49wHYC2IcD/f8I4/WOG9MVtJo6gZwEGkgSQfCCuZj84bqFwL5NTQNYoScJi+9k3/r35o1ymlBW3uvqHCNRFcKE990GiYeHzkYH+rCa1CdRHkl+lMymPomH2iOq1qGAgsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(6506007)(316002)(6512007)(8676002)(53546011)(66476007)(6666004)(54906003)(44832011)(38100700002)(5660300002)(66556008)(26005)(8936002)(2616005)(478600001)(6486002)(31686004)(41300700001)(4326008)(83380400001)(7416002)(2906002)(86362001)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnFIRjhJNDh6NnM5Skg2VENPNFZVcUJ0ZmkwSkY5WXcvL1RoQnJTb01sd2Qy?=
 =?utf-8?B?S2lxNEpRbGN4Q3lTT3UycGZxbTI4aS9XS212OFpXalRGSWtkZVZILzBFK3lt?=
 =?utf-8?B?Z2pRekp4bGdOVVFsaUJoZEFBZXZqTktXWWoxSlpKWHozU3BKaC9qRWRhZWpU?=
 =?utf-8?B?cHRQb3A5TGd4ZlJoWFJtZldkOVJqZ1RnWTR4QUZPaXdnUjZZUVA4SE5LbWVB?=
 =?utf-8?B?Qmt1eWc1emRId0xhd1NXTDJzUzRDSGxEeW8renJpVWIrM1dxNVhKQ3NzSmtH?=
 =?utf-8?B?VzgwcUQzTktycHJ2VUg3RVYyb3V0Y2lxVkhHbXlVSkRRSVhXZHJPdzdDRWFh?=
 =?utf-8?B?STNnV3pxZnd3ZnNuRTh0c1grMXhKbWhDNENkZUt4LzdSalFxVzltWWlXT0Jo?=
 =?utf-8?B?OG90LzN3M1JZUVVKc2Y0a29WWG9WMXBFc0tNUmNrOWdqQnRDeC9tRjdHSWpW?=
 =?utf-8?B?TWk3U1B0TmQxM0NnWldPcUlzWVNDeXl0VTZhWUU2eHo4bnd5M3Z5ZkJNdnZi?=
 =?utf-8?B?cTJXcU9TdFlyQndKblVhb3RPakNmbXd0OGtYelU1UE41VWhBQkJsNjc4ampz?=
 =?utf-8?B?WDdSR1BIZzhRTHRyZ1JJYlAwS0dSQ3dFSm9BY3M1MHdmMnR1Q3o1TTlDUHFl?=
 =?utf-8?B?QVg3ZTdTYUxWamNLMGkweXVFQU43WlFVN2tBdm9xTHJ4elRzWXhqYkU2VFdN?=
 =?utf-8?B?Wjkwa0dZLzF1cU1kWS9lTWtSVG9kVGdkMG85eGx5NFVWdUJ1ZWRuT2ZwS0VD?=
 =?utf-8?B?bWZ4VG9nNDhXR2FEbnFac1NyZEJFejRSRGhnRFlXRW5WTTEyWVhSNTJBdndI?=
 =?utf-8?B?WldNMWpCSmFSdWVXck9QWEltTG84bXIvbVVZelNqZ0t6M0p2ZUowTURIODAz?=
 =?utf-8?B?UFVNQzJNM1dJOUdzVE5BK1l1VGU5WTlSM0JwTFhUcERja293OEtQcTZtSmhK?=
 =?utf-8?B?RkZSWXYydkxmSStHRUt6VXdpYXRMS0pueEFIN3Z2WjBaTzQ4cDZOR25jODdy?=
 =?utf-8?B?UzdEUFk2L2s5bFZZMlpZbnlWMG9aWFNERGxaU2dyZUdqMWkySTFycXZxSmJW?=
 =?utf-8?B?OFlpVHRSMTdkL0luZ2tuN2xCd1liRnlUMis4cW0vRUlhaW5MQ2FhQk9obitP?=
 =?utf-8?B?QSs5Y1I0OURmbmN0cGFjMlNJU2IxcDdQUmdsekYvSkNPMDB1dkM0MkdrSnBi?=
 =?utf-8?B?cDU2ZTdnTmZSNjhVSFRQdkttTC9hU3ZLVGhFSENmY2Q5N0gzSVNnSGdGNUc1?=
 =?utf-8?B?dVpSdjhwWWhJM3FNdlRFZFJLMkNoWWdWbnYvalVmQ3V3M3NKcUpsWllNUEFv?=
 =?utf-8?B?dk1Hc3AwdkRnUE9XM3Z4V3RldFp2bGtjQXZmVEMrL1d2Rk5iTEhOZTcydmFr?=
 =?utf-8?B?clJIa3Z6VFhwU1VMeGtCbVRwMzNLSUY5OW4xcHRaWUErYmh0YXVWblp5Y3FB?=
 =?utf-8?B?QzVIak1LR3FEdFpzRmlWKzJPbDJZNFliUTA2RTgwU1dHU21LRHdFQ2pMUWRk?=
 =?utf-8?B?cGgxMXgwWnZRYlBrZHh5K2VoaUpqSEVWc0Z1RTFCN2d0SUtCRmZzdzdNcjJh?=
 =?utf-8?B?VVJoR0pIVzF6VnlUY0k2QUhQM2JzUE9XS04zc2QvbXJtMUc5WWF0cHNWUCtq?=
 =?utf-8?B?cEJTNjJDNjhlUEZpY1NHSjI2TlFCTWR1MEZJbEw1UEVtT1R2d2lYQlZGckFZ?=
 =?utf-8?B?UnV6TzhvcWRqMkh2ZnVndnhvakRjSm9MVmVtZStBNC9BaUNOcWNzY2FWTEg0?=
 =?utf-8?B?aDdjQUFWRWdnTjVneUtGRjF2Uk5vU01naTI3ODhTZTJlQURlKzR0YW1ac20r?=
 =?utf-8?B?dVFvUElxQ293SjEwdFJzRE1TUlo5NVpoLzdDM1pVSStjcXFmUmhLSnRWZXhG?=
 =?utf-8?B?SnR0TGJtWUpkSWp3dXJVamZJQ0xIeTFSUThNeUtJSXNNdnBTdmU3OWtGZ1Vx?=
 =?utf-8?B?NnZZTmdoMXJQMGxCdnZVOHlLMHBOdUpzN01SMFBwd3BOeWlVMGV6elpRa3RR?=
 =?utf-8?B?c1FGNGowcmZZZTU0UjNBRlJxSmIyUmkxSnRqSGlETGZ1MEJNTmx5NXJGT1Vk?=
 =?utf-8?B?YWR2ODUxTElCZkg1L3VreXdsTlB0VjhVbzRuY01TdkZoc2RJOGw5Z2NZblY5?=
 =?utf-8?Q?Cm0CvB01Rqj7zVZV6/UlAgZKQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb84bda3-27c3-4c6f-05fb-08dbd431ef8a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 01:38:34.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiWqFtlFPANe0cuU0wdSMQD0JDtj3pen4kOIFpzxzAKXS4zxNfu1XZC3H60UckO39BHVaM2bx2Uf2n/XZy5KTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2023 20:15, Jarkko Sakkinen wrote:
> Add tpm_buf_read_u8(), tpm_buf_read_u16() and tpm_read_u32() for the sake
> of more convenient parsing of TPM responses.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   drivers/char/tpm/tpm-buf.c | 69 ++++++++++++++++++++++++++++++++++++++
>   include/linux/tpm.h        |  3 ++
>   2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index f1d92d7e758d..bcd3cbcd9dd9 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -124,3 +124,72 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
>   	tpm_buf_append(buf, (u8 *)&value2, 4);
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> +
> +/**
> + * tpm_buf_read() - Read from a TPM buffer
> + * @buf:	&tpm_buf instance
> + * @offset:	offset within the buffer
> + * @count:	the number of bytes to read
> + * @output:	the output buffer
> + */
> +static void tpm_buf_read(const struct tpm_buf *buf, off_t *offset, size_t count, void *output)
> +{
> +	if (*(offset + count) >= buf->length) {
> +		WARN(1, "tpm_buf: overflow\n");
> +		return;
> +	}

In the overflow case wouldn't you want to pass an error code up instead 
of just showing a WARN trace?

The helper functions can't tell the difference, and the net outcome is 
going to be that if there is overflow you get a warning trace in the 
kernel log and whatever garbage "value" happened to have going to the 
caller.  It's a programmer error but it's also unpredictable what 
happens here.

I think it's cleaner to have callers of 
tpm_buf_read_u8/tpm_buf_read_u16/tpm_buf_read_u32 to to be able to know 
something wrong happened.

> +
> +	memcpy(output, &buf->data[*offset], count);
> +	*offset += count;
> +}
> +
> +/**
> + * tpm_buf_read_u8() - Read 8-bit word from a TPM buffer
> + * @buf:	&tpm_buf instance
> + * @offset:	offset within the buffer
> + *
> + * Return: next 8-bit word
> + */
> +u8 tpm_buf_read_u8(const struct tpm_buf *buf, off_t *offset)
> +{
> +	u8 value;
> +
> +	tpm_buf_read(buf, offset, sizeof(value), &value);
> +
> +	return value;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
> +
> +/**
> + * tpm_buf_read_u16() - Read 16-bit word from a TPM buffer
> + * @buf:	&tpm_buf instance
> + * @offset:	offset within the buffer
> + *
> + * Return: next 16-bit word
> + */
> +u16 tpm_buf_read_u16(const struct tpm_buf *buf, off_t *offset)
> +{
> +	u16 value;
> +
> +	tpm_buf_read(buf, offset, sizeof(value), &value);
> +
> +	return be16_to_cpu(value);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
> +
> +/**
> + * tpm_buf_read_u32() - Read 32-bit word from a TPM buffer
> + * @buf:	&tpm_buf instance
> + * @offset:	offset within the buffer
> + *
> + * Return: next 32-bit word
> + */
> +u32 tpm_buf_read_u32(const struct tpm_buf *buf, off_t *offset)
> +{
> +	u32 value;
> +
> +	tpm_buf_read(buf, offset, sizeof(value), &value);
> +
> +	return be32_to_cpu(value);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 687b5173bdab..6590bd1f0a0e 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -337,6 +337,9 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
>   void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
>   void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
>   void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
> +u8 tpm_buf_read_u8(const struct tpm_buf *buf, off_t *offset);
> +u16 tpm_buf_read_u16(const struct tpm_buf *buf, off_t *offset);
> +u32 tpm_buf_read_u32(const struct tpm_buf *buf, off_t *offset);
>   
>   /*
>    * Check if TPM device is in the firmware upgrade mode.

