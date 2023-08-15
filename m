Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2277D4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbjHOUvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbjHOUuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:50:54 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992981FE6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy6bsedaKixA2Eu0nXKTX2j0BgetPnTZy7nGGcETKdnH+sCfuAsoruGaIw8lh7bi6paXnfROTsYL7xWpsLdMa6z9sYlIzn40bdFxh2HdvufDdqv1U1s/4wODQ6ABn+snYdeEAMn0d+I4ZyIocJYt4kstNn5TatvtjdBVt9k/q0RjWGBbxCQQSkPsgIpZ9GH2Zet8k/AyCdr4dIW2KmvDttby0RO70dQ23nOXP9/fadKtXGXV9zjodwu0vBTM8UxTrBwqDAOQwAZJRsOsHj7lA8UdCu5vuDYMrgK1nq4qHnzyHDe4kRC0RaMPQFaF83Wy9sBiD2ek/DpZFwo9O/xt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1htQ6CXypYJYwCYCKNYPt2O+4WsIIEjBGiSv6ZrdCxA=;
 b=LV7mHXEEzhHTuOE3Dfvo0/xs8ZqmTtYKbTG/qen2iBvDdZucdDu6hCSPSVo72ooe3WdtpWCsZ/Xs95slEAaxu0/9J5rZQhv2/kyy95jE5TQg3oCfY9cOgaR0sPSakXWyQFf0SQKwuNVBv5M5GxlVwlmSIe9ptbwisUvDfWV9/at0RTDBB905cIyoaJh07TYKBjdsb+vZqsTBzthEabYjVQU8E63HusC5v6HYIE5TtO8w3LTvgaCCVCNxvoYy/pamDmdonGYiHsuxBO50IelWpPJFXZJYugjRhPdqMlXzd/+NGXuAg1Vfx3AKCEjjHWmYaVEO34s/RhKv85oULaD4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1htQ6CXypYJYwCYCKNYPt2O+4WsIIEjBGiSv6ZrdCxA=;
 b=bEvMTpOVHE/KibGi+ipjslajIuFOgmAsbWRjaqyql0kcx1Gd5xy5IFAC+eHmwkIXbdjhp+xAQAOpwmVd7kZBo5LvtEm8R4UNlJvUqnZDQJGiBNHBC+wPNDRfcQtpVOSifbARqrB99OSjkLjo9CYd7aBZoHJPYxg03WH7i29kkaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 20:50:20 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 20:50:20 +0000
Message-ID: <064cdef7-d90b-9fa6-fc04-30637c992f60@amd.com>
Date:   Tue, 15 Aug 2023 15:50:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Borislav Petkov <bp@alien8.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:5:190::37) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a22ec0-cb4b-4e7b-c60a-08db9dd13cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQ3/VH+x7VMLefcv3ah1lMdjM+rmYlCca1i4q2k98el6G8vJJlvr/FnXAUY8p6+QsV99qQywzhQfA2v/bOLuHmhH2I5CecUgOG/m3jh38ZxHsxMNfYm2s0kWTNQj5kDiMbFhxBR10vdPRz23ZwRLtZfLwDvmIRLRzNE+qxkaNzep/3gBq2AASNNFQbBdAIrbj5stsHCM0A/AMhlN/cKc83HvMffubsCrhblwBVjSDQX/ZfuQSsxX1S3LisJFc/+PM05CT3o5vMgyoB6rOem4a54OIocj9RjfGUDv9Oai8IAbcOd+IQMvaMVkOPO8wSNz/HX76CU9SRkdDKLWHjhLZ2IHbBin2w4Z2/H05nhwzwvm/aqVC49dhmzeNX38AqGt6Ie3uEY0k0fewR5jWRWWKnD5zjk8rByrVS03FUPM1Jg/bGkr53516hX8jewiceiRnvKOuzhnqr5CuWtV67/uZO2N467HYgcvbcZJFc/okDZ18L0WIaKu3Yb0NYvE3Mz//fpt7O/UlewvpGfyukVAbEvWKMNj6N1c2GfTLRyxsFQFZPfQplksL+DvYO4Zd9OUALSgKkHyNLq6sSgn7IkinW5njTbkbZvSIPp+M2dpZ1EGnAdY0mE6lH1C6ClxYwfnKRTZLNcYBMd6g+wmuhiZMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(1800799009)(186009)(451199024)(36756003)(54906003)(66476007)(66946007)(31696002)(41300700001)(4326008)(86362001)(53546011)(66556008)(8676002)(6512007)(966005)(6486002)(8936002)(26005)(6506007)(5660300002)(2616005)(2906002)(31686004)(316002)(478600001)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmFZT0RmMXFoNmJ3QW9FZ3FTckt2dGtxcjRpSnZ0dUo3NVZOZW51dWJOak9F?=
 =?utf-8?B?MHZZV3lJN29WSWxmRlRLUVJidWFyOUhGTkpYTXR6aWxIdXB5aUNoOUxtUHl3?=
 =?utf-8?B?MUhzRld3ZGtIMWdIM0F4ay9xZm9yamdnbnFiTkFmWkxZSjVsVGFIZDNxYml0?=
 =?utf-8?B?SjVteDJJcFZTbEZuL25PNEZkUnpFOW0vbmVLR0dDY2NWSmNjNHFZaUExWkVk?=
 =?utf-8?B?WFFHRWJLUmN2T1JINE9UZzVSZDBrLzdMMnRkeWpibFNzUUlBa2sydHZ5SXZH?=
 =?utf-8?B?Y1kyL3pMdXZBV1hIYnFKUmJ3VFdtaWNYR2tBdW05azlFOTgvd0RRWHc1SVVr?=
 =?utf-8?B?UzBFRWlwMUZxMjNWY3lrdVVLMGRrQzA0UUl4TU4xQXlwNXRIV2pzb2pyRkda?=
 =?utf-8?B?UllTakhkcjU2cjRGUmh3cHFOUzVBYVMvdmczRStackhnVTEvZ2I0dm1PQzNK?=
 =?utf-8?B?RXlkSnFoRVJjbXRaY3hmRkhvZngwTjFQMjNKeG9jZStRcE5qM2N5TWFLNndZ?=
 =?utf-8?B?eVErODZJWXBqaWtqcmYrZThra1h4MjcxU2V1VEZCNzg4c1ZITjdNdTJMOG04?=
 =?utf-8?B?Rm1WK2pjR04zUUpQZFMxVFpqR0xwdDI1anpUVC9pTXAwcXVQYitqZkFGdVN3?=
 =?utf-8?B?Qlc1S0dSL1FCd1VydVRNNW1jc3JOK0E1aURtV2dnYWE1bEtoMGU4NmY1N0ls?=
 =?utf-8?B?YWJaa1IvMENOLzNhTGFPWGUwdFZrSTdXV2hheGJTSS8veCtpaktkQTN2WHBF?=
 =?utf-8?B?MmxEblNwaHplYXYrWnBRcWJVTVBBUnZJN3RzL0dVcS9oRVdmUmg1dlNUdkZE?=
 =?utf-8?B?MXhEZjYyUXJobU44ZTlwVmpSanFoYkYzSDhtci9UR25Rb2plR2hxcHJIRWt2?=
 =?utf-8?B?SXlud0ptOWVDdkhzaWRIeVJZeDltQ04zVlFYangrMnppVk9MUkU4QVk1Tjk4?=
 =?utf-8?B?ZkZ1TVBiNFpaaFRHSFliUVgyT0xheEFHeS9oWG5XdnBiemNCVE85SVQrZlpK?=
 =?utf-8?B?a2czVmYzUWgzNmRqbXFsZUlQV1JuTTVBbmdoTVhudEk1MCtOQlVSVGFDYWxF?=
 =?utf-8?B?UEtncXB6VVVqUDNTSVBJaGdiL2xNQlkzRHZZeGNYWnI4Y1JnMzJzbWdBU3NV?=
 =?utf-8?B?T1VhSVVjcEpONEc3YzJmaUg4MTRvelNDR2RoWlp0Y3FKMTZSMGtRNmYyOG1n?=
 =?utf-8?B?RVd4NktPTjRUQVdiZ0Y4VVhoTGY5ckhRY05mQ2hFa0JhQzZCdWpINUJoT1dh?=
 =?utf-8?B?cnk4RnZiVTN1WVRMVDBsYWZZZ2RJWC91Z0dLR3R5RmFqcTJjakNXQ0s4d0xC?=
 =?utf-8?B?VUR2cEtFQXJ0SmVHQlQwdjZkWkZlN0VYOWg3U3hCMGRWYUQ5U2lqeXhaNDhP?=
 =?utf-8?B?UU05aWJDUFlzSnJmMlM5R2VYZ01aRnVJL0pNZXdDYVdITzF1Qks4SHQwb3Ay?=
 =?utf-8?B?eTl0UkVXR3ZXbzdxWThKMEtKN09TaDRIZS9mUnEvSzgrTHltMXEvZG1IOGww?=
 =?utf-8?B?Ujh2SHYrT0pxSUYweE8vS1lobHdmQUYzNW9ibE14ZXdoc0c3dGxLa1hhVUtq?=
 =?utf-8?B?QzMxZXl3MEQ0K2tHTU5NcTkyeDFzejNxSjFUVmtzakQ0dmxWWkZyc3dBeGZh?=
 =?utf-8?B?TmVSdnpNZWcxM0QyQWJzQXBwYUNkekVnZmJmT0lDcVl1T0lOTERJZ0Rjd1Mw?=
 =?utf-8?B?RTJmRDFrNTE5VDd3UUhQeHZDWTBYWHphSjN3VzMvTXFRNDZJNFdPdzFBZDJS?=
 =?utf-8?B?dXJHUnRwR01qTmJHTk9RNmVlN0JtYmZ6dVlQOEpvNy94NHVTWkZ0MCtKdGRP?=
 =?utf-8?B?OVQ0UUFEQnlPSVZ1S2hpOUxQVDg0ZVJmbHN3QjhlZk4yb3Q1YXZnMGJrYnZh?=
 =?utf-8?B?N3JtSWNaMHpVUG5ZQndHY0VTVlYrWDd5TmVsOGlUcCs4azFSWDlucVRGQlQ5?=
 =?utf-8?B?MjRudG1sdERXandVZ3prMmg4V0xaTFNEeHVaUklhL3FHUURLUXE1RWgxdGg3?=
 =?utf-8?B?VFNid3lNcHdvWUd3RU9UZmZWdjRJcTBTRHg5dVpITGUvcEZqSUVKcFFGbmV5?=
 =?utf-8?B?aTk4RlFzT1plTkZ6OHZzdCtRYTBQUG1LVUZrejhQenc0b2wvNHlqTlhYWVky?=
 =?utf-8?Q?Mq5P0GxetnuJ/rPz7ASPQDwaw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a22ec0-cb4b-4e7b-c60a-08db9dd13cfe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 20:50:20.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FGjtpFpC3YEuEjvasrhkcSbpq/JcypU0GYx81Y6m+tDXINP2rB4q5QsBlD1vUy3ukvvJTAsiJh5wwpjZxrMwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
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
> The sevguest driver was a first mover in the confidential computing
> space. As a first mover that afforded some leeway to build the driver
> without concern for common infrastructure.
> 
> Now that sevguest is no longer a singleton [1] the common operation of
> building and transmitting attestation report blobs can / should be made
> common. In this model the so called "TSM-provider" implementations can
> share a common envelope ABI even if the contents of that envelope remain
> vendor-specific. When / if the industry agrees on an attestation record
> format, that definition can also fit in the same ABI. In the meantime
> the kernel's maintenance burden is reduced and collaboration on the
> commons is increased.
> 
> Convert sevguest to use CONFIG_TSM_REPORTS to retrieve the blobs that
> the SNP_{GET,GET_EXT}_REPORT ioctls produce. An example flow for
> retrieving the SNP_GET_REPORT blob via the TSM interface utility,
> assuming no nonce and VMPL==2:
> 
>      echo 2 > /sys/class/tsm/tsm0/privlevel
>      dd if=/dev/urandom bs=64 count=1 | xxd -p -c 0 > /sys/class/tsm/tsm0/inhex
>      hexdump -C /sys/class/tsm/tsm0/outblob
> 
> ...while the SNP_GET_EXT_REPORT flow needs to additionally set the
> format to "extended":
> 
>      echo 2 > /sys/class/tsm/tsm0/privlevel
>      echo extended > /sys/class/tsm/tsm0/format
>      dd if=/dev/urandom bs=64 count=1 | xxd -p -c 0 > /sys/class/tsm/tsm0/inhex
>      hexdump -C /sys/class/tsm/tsm0/outblob
> 
> The old ioctls can be lazily deprecated, the main motivation of this
> effort is to stop the proliferation of new ioctls, and to increase
> cross-vendor colloboration.
> 
> Note, only compile-tested.

I just got back from vacation, so I'll apply and test as soon as I get a 
chance.

> 
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dionna Glaze <dionnaglaze@google.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/virt/coco/sev-guest/Kconfig     |    1
>   drivers/virt/coco/sev-guest/sev-guest.c |   81 +++++++++++++++++++++++++++++++
>   2 files changed, 82 insertions(+)
> 
> diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
> index da2d7ca531f0..1cffc72c41cb 100644
> --- a/drivers/virt/coco/sev-guest/Kconfig
> +++ b/drivers/virt/coco/sev-guest/Kconfig
> @@ -5,6 +5,7 @@ config SEV_GUEST
>   	select CRYPTO
>   	select CRYPTO_AEAD2
>   	select CRYPTO_GCM
> +	select TSM_REPORTS
>   	help
>   	  SEV-SNP firmware provides the guest a mechanism to communicate with
>   	  the PSP without risk from a malicious hypervisor who wishes to read,
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index f48c4764a7a2..5941081502e8 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -16,6 +16,7 @@
>   #include <linux/miscdevice.h>
>   #include <linux/set_memory.h>
>   #include <linux/fs.h>
> +#include <linux/tsm.h>
>   #include <crypto/aead.h>
>   #include <linux/scatterlist.h>
>   #include <linux/psp-sev.h>
> @@ -769,6 +770,78 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
>   	return key;
>   }
>   
> +static u8 *sev_report_new(struct device *dev, const struct tsm_desc *desc,
> +			  size_t *outblob_len)
> +{
> +	struct snp_guest_dev *snp_dev = dev_get_drvdata(dev);
> +	const int report_size = SZ_16K;

The response buffer from the PSP is limited to 4K, so the report size can 
be SZ_4K.

> +	const int ext_size = SZ_16K;
> +	int ret, size;
> +
> +	if (desc->inblob_len != 64)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (desc->outblob_format == TSM_FORMAT_EXTENDED)
> +		size = report_size + ext_size;
> +	else
> +		size = report_size;
> +
> +	u8 *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
> +
> +	if (desc->outblob_format == TSM_FORMAT_EXTENDED) {
> +		struct snp_ext_report_req ext_req = {
> +			.data = { .vmpl = desc->privlevel },
> +			.certs_address = (__u64)buf + report_size,
> +			.certs_len = ext_size,
> +		};
> +		memcpy(&ext_req.data.user_data, desc->inblob, desc->inblob_len);
> +
> +		struct snp_guest_request_ioctl input = {
> +			.msg_version = 1,
> +			.req_data = (__u64)&ext_req,
> +			.resp_data = (__u64)buf,
> +		};

Won't the compiler complain about this declaration being after the memcpy()?

> +
> +		ret = get_ext_report(snp_dev, &input, SNP_KARG);
> +	} else {
> +		struct snp_report_req req = {
> +			.vmpl = desc->privlevel,
> +		};
> +		memcpy(&req.user_data, desc->inblob, desc->inblob_len);
> +
> +		struct snp_guest_request_ioctl input = {
> +			.msg_version = 1,
> +			.req_data = (__u64) &req,
> +			.resp_data = (__u64) buf,
> +		};

Ditto here.

Thanks,
Tom

> +
> +		ret = get_report(snp_dev, &input, SNP_KARG);
> +	}
> +
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	*outblob_len = size;
> +	no_free_ptr(buf);
> +	return buf;
> +}
> +
> +static const struct tsm_ops sev_tsm_ops = {
> +	.name = KBUILD_MODNAME,
> +	.report_new = sev_report_new,
> +};
> +
> +static const struct attribute_group *sev_tsm_attribute_groups[] = {
> +	&tsm_default_attribute_group,
> +	&tsm_extra_attribute_group,
> +	NULL,
> +};
> +
> +static void unregister_sev_tsm(void *data)
> +{
> +	unregister_tsm(&sev_tsm_ops);
> +}
> +
>   static int __init sev_guest_probe(struct platform_device *pdev)
>   {
>   	struct snp_secrets_page_layout *layout;
> @@ -842,6 +915,14 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	snp_dev->input.resp_gpa = __pa(snp_dev->response);
>   	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
>   
> +	ret = register_tsm(&sev_tsm_ops, &pdev->dev, sev_tsm_attribute_groups);
> +	if (ret)
> +		goto e_free_cert_data;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, unregister_sev_tsm, NULL);
> +	if (ret)
> +		goto e_free_cert_data;
> +
>   	ret =  misc_register(misc);
>   	if (ret)
>   		goto e_free_cert_data;
> 
