Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E5777E0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244934AbjHPMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbjHPMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:00:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600692112
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2SVyxxmAZ8iG9f4N545cpWsmg+8pi6BNW6YmFYVkwWn3DapN/Ot+9uPihTN/WceN45OArG5WLIUV5GnaERnibjv6KqlmU29axns9aaI9ppACFUYZuCo6fqtT1rXhIC10RKQ5gAGhCbxYuMM3iQcruvRviDinaTn4qPb93HayFwOzwd2AM65pVGpD5PnCg25LeyqmhLCJNtRKVqSG19cZq9kMbcwbKts7fU5YJG/XpGnyYm1xggFEZj9L4DtSBU6P0yK6EPa6tMOotsb+fHvcLe3/06QPtfOXxWBsfZs+wpCDPHlj3M79nmiVlDNvL4vw2TvQNYxWQuZBGOmDCmjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNeMqioYb+FLPCKuGDCsdgK+YsAd1NeM87xOI2i7ewU=;
 b=ar5NfkAr6/7QPvV7KI9MLYdkI/kRae31ZZkGuXgkay3SM63TpYbtw8Lb6Y9zLuZAz+d7AM0QDYa+CHRAZoYpxEMYAwWr83ySwIX51LInikt9766YaEYzpbRg4b8usbTmuNZnBB+XT9srDAIdplhpfe4SjnBTuR0q9ADN7y5KrkJvUXLIw5qpMbgAbzxRzLAk3r41OI0x7Jy4nCMteUZoAHbkLC5vKaMI5U+4BAMHbu/bjudv2ijE9jBt72mfHglHhPl8ZwDvZp4vFFXMA4S6/6gAbqmDmOuEQtyygI8YlVFVjSZx5Y0QlT/6z6lekBx1pLdXFTeGoGqrXSbx4I7I5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNeMqioYb+FLPCKuGDCsdgK+YsAd1NeM87xOI2i7ewU=;
 b=lyRr7m0L4BQJ3iSqZ4qtBrYwcY+y1jDqLDsKvKpWrQHTL5iJOwyRd0wLOpiz8NaxUkRtVC6mrtEFwJUSodjbOudds9wNbZGYdGK7C88ZQKfuzdu4KPhbzTxjsfy4/L++C5FqdWO9I/muN8/S2aEIF5eDyOT/wYjs1QtJEkr5BxU7V/Vn4PJffpOWV+ts2gHvwh5v/UEbnC1qyavQDly5q8KhSEKA1dOTG0dqQTB64JWhE2yCSEsQYEqQ1qUp0J6Z22wYxVBgAubf8a722D1GKDJiL38YatZVY2eHwulElrtdTM9Mix8G6wRKoNDFfvOrLBxZpS6jzXIjmmPHH3XZqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 12:00:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 12:00:01 +0000
Date:   Wed, 16 Aug 2023 08:59:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        jean-philippe@linaro.org, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add a configurable
 tlbi_range_max_n_shift for TLBI
Message-ID: <ZNy6Pw/Jxn6jsIxl@nvidia.com>
References: <20230814215701.5455-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814215701.5455-1-nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0332.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: cb83c7f8-5196-4cc3-1874-08db9e5051e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeQ2i9a4ZD1gQ8JEvmbnKnn9AyI7JsRj3C/METRVotboW4ZafRXqKoS5qD8E7AvSshPW612bjniN6cVmFpijDthWzlpfKpz1vps9+LmBLsbfbqQ+ldyMyzXqcYhczSZMuQhPmgKKRbCXfwOYGUgJdtWKTABThU3orNvuHs9RebSdX9quGaJehgqF/ViylZMuybPduuNzQLE2T3RQYH6/lOFOw/77uMANRuEowInXvngjuFYnaILGW31rNPqrIzgjhoxogMDeIkM0SLoO+GV6BhkSig8DeqaLk+RaD0jvqi9EckzE1Tjqe7C7KaLXo3bilsc2+BOHquCLtz06RSdfNFCsvf8zDG/DxQ+r9CxCFWDOtAC1xZV4zlAQfRudeP1W2bpj6Q88blzKUgX7QNpeXRXs6tsC/EzNa68tEQ2M0BQQ85wb6TJUjVYVxZP7wGOIkrOkt5Vt1TsK872TbfOoFxDGfqzor8gYXuIuwVNreT51GpTrvbpJftjah5CUDBQRKofNryGM+2pjCli3N2um6CdHtm2DDf3PpAPrm4S9zlCcnGQOlxfORsQPYPAY90Hm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(6636002)(66946007)(66476007)(66556008)(37006003)(41300700001)(5660300002)(38100700002)(8676002)(4326008)(8936002)(6862004)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(6506007)(36756003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CO2qtIz8kGPknedRT1/X7shE6s4CBWopJHKgtjzw8wQuo2s23RqCmpx9MP9w?=
 =?us-ascii?Q?UrHrmaOX7iEOl2BENCqY7Z9jZw9QkhV86Ev63hWB7VBxpvKKQvyzusjSus/e?=
 =?us-ascii?Q?9yKDzHyuabTq+wf4/ttMTJzamHIejllwPb3U7OvHG9vijIy6d/otPz2Q4CpH?=
 =?us-ascii?Q?YxfsUE27WvVGK73el4bHMucs3Kp79i1cbyiibmQbYna3QErBizdSOLTsHTbB?=
 =?us-ascii?Q?JcVeEomtb+4yri2sQ0ZWy8lITYqckpr/NeU12opb8ZQOVCghuBTkpJkl8x5x?=
 =?us-ascii?Q?7lWNYDv2zXsgH3Qt+/JQqFIZcJqp/CSKZZYnghJFLgjTg5eWvkL0kuQsbIr2?=
 =?us-ascii?Q?ZNNWcq9W8cq9dnYtMD9etvaddVoHLyiCpDmz/AnHNDPVkvg6JJx0jg2plo/f?=
 =?us-ascii?Q?ElrkjdoV88xKCVNx1UglayFXHxHUelLnOIZnwO3hHaQE0jyLLzwYnRr6iObc?=
 =?us-ascii?Q?dlfS8fvXyJ9gBeZ7p1A/gyjoJQLX2THT+q9k5K+lprcf+YIWGJJgZO2BLigH?=
 =?us-ascii?Q?kFffbq2aSWDiFczqgNIFD8hreh8SkEU6syp7JI4Z34tU43g0XSUVCD6R4fk7?=
 =?us-ascii?Q?GLplKSrv8/S+bjxH4tpWf8l+9F5VEeM3NE3o28l/QAvfGq0RP0XD0BCAK44e?=
 =?us-ascii?Q?0EBIZUwsiecT9XXGiLVzAITcY2LYMsDYInMHtUYRk0EzPo4npXUr33icMljf?=
 =?us-ascii?Q?2xdKUef7ggfI+q0Ub5wzr0ar7AiCwpx0GS9JZOJEZH0PHTSJHYZbtKsoSeDi?=
 =?us-ascii?Q?LM2KvKqtpaUu8JQaSBjOoJm4FBahW6mGNayL5h68XiRTk+L5hWTEzvu8heP4?=
 =?us-ascii?Q?hrkPJ80ynZScEmn2nvVznWblv/RujG2+NuFtPTXimtqHiveJ/A+RgHij7+z4?=
 =?us-ascii?Q?PpKQ2tdx5UnzJQfPmN+hNngPuZUpozJBpaJQWUB1pyzjsCbTY01zGpG7aEFg?=
 =?us-ascii?Q?rGSDy6rq6t1+o3a+gDrNfweT8DmRrLWCYW43swtpR5HO9QZJwBkqs8O2EbWc?=
 =?us-ascii?Q?bWs9jyJ27+26sbcB4+DEVedQ4D3PWkkmrqtIQ/H6aII+ytlc4JPA+Aa+YRfI?=
 =?us-ascii?Q?2SXbJCeMvlF8qGdkqKf0bSF8QOpIOO2cN44jDTvhO8nWRUwVxU4DrShL7kFL?=
 =?us-ascii?Q?JTVb7qdCTI9pGMRXAfEBSjjmFxOeVqEjVMkjFuCzjPZqAId8g+qkuy2VD3jE?=
 =?us-ascii?Q?2JXWz494WER1a1+aPNMpQphCYBvE1N6X8Fej+qdUIzw2JyEsY1pArpG22jHi?=
 =?us-ascii?Q?MV8Y1uNttoATEyzaev4XyzVAr1Vak1qkqJF0A8bP5CGplEkC0P9KiffkmANK?=
 =?us-ascii?Q?2FHGS/NhbZfnzkpsiFVe4jN9RLy5n1rQHdHGoGqQSrn6Z29Eu/yPBwI9qL81?=
 =?us-ascii?Q?fn3+nvyU1a8dqENhXNh6VkJCvVPeg4SKp7Swj/Dncy75Hzgi4g0dMdw3MRwD?=
 =?us-ascii?Q?5wVwZOY2F9r1dDi77C91fVjDeBr0MEJ1vvNL3wY+VY2StXEZQ7cOfxnLompo?=
 =?us-ascii?Q?QVY/ySsHLyoUZkAVZIE/ZYRcmTXhpC8G54Um/V0MrTiYeHqsA7wqSSTqSiFi?=
 =?us-ascii?Q?ccJ48U2a7D6YR3h2Nl/9cHPhVDOh/55MNlPsUrRC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb83c7f8-5196-4cc3-1874-08db9e5051e3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:00:01.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a96l3yHTM71Pyb2RIw3upO0Ud262oF32c93ETDrzZTvMbJc/bes84avx7xN1r+X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:57:01PM -0700, Nicolin Chen wrote:
> +static ssize_t tlbi_range_max_n_shift_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev->parent);
> +
> +	return sprintf(buf, "%u\n", smmu->tlbi_range_max_n_shift);
> +}

sysfs_emit and missing newline

> +static ssize_t tlbi_range_max_n_shift_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t size)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev->parent);
> +	unsigned int max_n_shift;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 0, &max_n_shift);
> +	if (ret)
> +		return ret;
> +	if (max_n_shift > VA_BITS || max_n_shift < PAGE_SHIFT)
> +		return -EINVAL;
> +	smmu->tlbi_range_max_n_shift = max_n_shift;
> +	return size;

This seems convoluted for a uapi, you should just make it
'invalidate_threshold' in bytes or something simpler.

> +
> +static struct attribute_group arm_smmu_group = {
> +	.name = "arm-smmu-v3",
> +	.attrs = arm_smmu_attrs,
> +};

Do we really need the subdirectory?

Jason
