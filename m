Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51E8811406
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379203AbjLMOD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378993AbjLMOD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:03:57 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E478107
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:04:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kak2+TZetYIlCVMKLHXDgCkvry/S3Ubop7MqhIs1V7aVdRb2F9fxxVRPdVJ/RnqBlvY7Gn51eVB6JmxWOCiJ/XWl0hjNP3Oa0Tl8YE+wBS4DVQk1vHdMGIA53HZVwbbFlTkuADEjxcn8o2X0ipm0GldOPvgDgD/q2hUg+dlxwtdqpBbx7V8teQ1M6kDG0DAtcyTI0LSZzD6DNn0r5lF6+QkGzDzJZrM7BOSze8fjs7YNCkwnpVJ6dfYmi1Ie60KzLArbhxA55Ep4sq+9DtEGR9FCzuzvaIUTTcr2AnE3Jgo0LfSQJPJHofoSJgUJAXSAOf8iDMqulcHWbabSSgP2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9vTUJl2LOahluXSqUMl2Y7QWGrbwFFZegpbSjVnd/U=;
 b=ZRzCJdy4VmRrATnW0s6FP8fkq5QWe31w2t1JwEkqsAXuBtQSldMXDyIPMesBD3SBlEomPttfqK1WBx185EvPxFZML7OssRWcYrKweEHJkPymIsi3iT/noq0FnAGtAevCp2n4kBMh9l9JcF9x+R4ZQibaalIMlI8WYDaUHIwrtT7jfAfx1nmibA94uz1OUs5xn+Rc1ccrZabYa5LRH1S6uuTkkx66+CzxGUDWsWEHm3OvNXPiS+riFatekmYg6JAZ6KJW3T55T1yK95jVIEzMrB3osFkmNeUmaxNSd8LWU0hQhbppxmqae6o1yDDCy+72j3LH8eGrqRQ4gzYaTEDvjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9vTUJl2LOahluXSqUMl2Y7QWGrbwFFZegpbSjVnd/U=;
 b=Ewfg+oAOHMTl+9FZCDS0Gp+CEm0stN/c3uGpy+pxH7dcrOIPszd4RjfhOomnAwuMMvDQ9X4jed9kjFkLiPjHd7Cr5Gza5ioRmPIx/vZPC6MtrlHdi4EoeTdWOVcFh+hBxfcomwM4hEPB1ctcHs67TSKHWygH1kQlc/pR0+9Ncy01t8waYm6NOh1E98eHAX/UYUm3/iUPhWoaYXI74eEqHWDE4fecip88dNZE3OMoiX6Zy8F1OMWuuEAT8aIWBVWlpHRBc8qPrrs3dFdBnV4K66ylaW6vIsbdv7lSPAKOVJUHTRs7YnHAOkt0dtAfPJQZ6R3oo3vPYc1PY1fH2ylD5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 14:04:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:04:00 +0000
Date:   Wed, 13 Dec 2023 10:03:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, yi.l.liu@intel.com, kevin.tian@intel.com,
        nicolinc@nvidia.com, eric.auger@redhat.com, vasant.hegde@amd.com,
        jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
        pandoh@google.com, loganodell@google.com
Subject: Re: [RFC PATCH 4/6] iommufd: Introduce data struct for AMD nested
 domain allocation
Message-ID: <20231213140359.GU3014157@nvidia.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212160139.174229-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL1PR13CA0259.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be0193c-7099-484a-f150-08dbfbe45b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7Hq0w3W/cBW8SSxHhaqc6tekxIQBBLkwF22PinKcdojHTE6UMLSbLrTOFxlsiFNNb8qR+LjbP/KvnH1ZmggTVVPMNGLQAfKVlk1qpdokEk+AsXAaZE0naOg/UZb+TB+OIZm9oe3yFaB8LN+EeQb4ZreKLYSUkBEt5KtED0qIZO7u629czBDb+2ws3s2zgvWOhV/0HiGnVNPkZXXIDFJtZeTKJ0kjcYHlEpTRxieKqRoe6aqvIWXZFN3/yIgJxvIOiF/gz3usM9d6WQ9dmKU64eUKUGW+ussxMIHUBtF6WmbtZPdPT+X8ii0aru10ag2CVW+SDSXwCGLtCs/v25RIxUSyMGrnrjUjDEohq/acWMCdU/Kwj78asJrfcNoFWM83omEIWK/5k6yxYdJUTr2ESokucOdmCO6EtBGreJZmb1KsvcwsBp6r7GDLSwyHoFc6DVGXBegOI466JLhrIYAIyJJmaAFYRDk49JvT9BcabeGe1VNKfrb8i2ak8vr9Apd0pyVk8IXAsiPe57VTNkFNsVCNSKYMiC5AKCcv3wWrjU+G/CfVQlYtTRxeI+dQtVI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2906002)(41300700001)(33656002)(36756003)(86362001)(38100700002)(66556008)(6916009)(66476007)(6486002)(6512007)(478600001)(2616005)(6506007)(83380400001)(1076003)(26005)(7416002)(5660300002)(8936002)(8676002)(316002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A6CvbpEMz207i/95ghQ74vPximsK9CXxnsKud5aONP8FA9kzUy3SyJgRWHHx?=
 =?us-ascii?Q?qq2o8pV8S9kIQ7D34J3KTRzAIkT5nD97cP+0lsgjoDfKX2mwLHfBZYwhsU6T?=
 =?us-ascii?Q?uvvDJns/xwV4yhY6WOOM8LL0OLmD2ErSy2QrTGvvogbB5ZN4j7N5L9WvjmT5?=
 =?us-ascii?Q?IRbgb4XVVoWonsrgGYWgzeV4gqO1G50vGuNQUsQUZRmMj0bAGkuKJUvKJIP1?=
 =?us-ascii?Q?WVdqJfMEcDk3euMhIhj+rai37uFyjECENGzeZLR8Ay2aMECFiLPLuJM7+0Uw?=
 =?us-ascii?Q?V6X0+94nOqIhT8oqycoqvx7I2otINksA4g1lBlKgtN2mNcE0mcSRx9YEaJZq?=
 =?us-ascii?Q?ngtgjgfOMwNkSqC4NK/fID/JUfu0Qwcsi3SAL0T4eJAp/bf4OLh4ZCawEt49?=
 =?us-ascii?Q?9JarqfAPKzU98SXhcRt2Zmlo5jJxL8VnF5VubH56ZlXrrnxqhVm8Wrr0EGQA?=
 =?us-ascii?Q?HMTO7dGVm1qXXOwO+OlhP9tdCCWjQzmiLe+/S5ox3WzqRpLQZn/ThthGIT6a?=
 =?us-ascii?Q?9pEnz+z09fBEfh+ELAZT8I1NTGDGpOYVuvC0u1Ow0C439NRfo8yARw9SaX4Y?=
 =?us-ascii?Q?LROdMXvnpgkTn1k0zeR1EUzHiRio0+f64QFp6FgbLMmBuTyJ6sPXNAKrv8uZ?=
 =?us-ascii?Q?YrFQ8WhGvHsvXCUDVB8s8Ms5fvcZkWY1T9aN+FF2O82Kb1e0gn+PFnD+SS28?=
 =?us-ascii?Q?9lMIT7OCNUn0KAHMMeVEigk5PzsbY5m2PtzgF2JRfAlfM7vUjKBB/7YyZAKz?=
 =?us-ascii?Q?LEhuw+t0U9MThsrlv8wsfM6YqIJ4yjFkVJGkyWBZo2PPGVMMzG8ha0vpr7nD?=
 =?us-ascii?Q?gPSCR1k7PrOHnIyxwzK7QMI04O1bSxQH/um9+L2rFmmDOg/r0+cApbPZMJeX?=
 =?us-ascii?Q?0lbUd0v80PO8kc/yz3OcSfPsgOskrsACEMtPKcydJq6ayjvpuAvQE7kXGSsT?=
 =?us-ascii?Q?TZnnEcspIoovdusJ/v7/bi/Q4E2fNFh0YjkGLuuo/LSRA2wZe9TAd5FgwDH9?=
 =?us-ascii?Q?jzPQBQEzOMzrnNEWSWcbOc3HTmg6D2m9rBNT+HM4H4cDqZDxIl88WHC97Pcb?=
 =?us-ascii?Q?spxUJnLeRNzxvpePNUPOCQZX55JGPk1JUR13Uq/qkRO/HIsT1GL9ZnDk4jfJ?=
 =?us-ascii?Q?zcgsYUmkeoP11DsDMj3gqN1Zj2KB/3DaRIM9nbAJDPTx0px4yUuiYBeLQOw0?=
 =?us-ascii?Q?oFbto/wEb31o0AQBDB548Jtzcegb8OKEZH3okzYnPTQNJZFboEymGDHSERIU?=
 =?us-ascii?Q?WmSKsx1YkqmXRjPPNFaUBkpARygA6kNvbnQgBU1G26R71Y0ZbMbwhUW8qHFc?=
 =?us-ascii?Q?ECZaywSXIdCklTJT7cRkQpPk0imYSB6k0IwiQ4lkgA1cHu67wNDVQ/JoD3FD?=
 =?us-ascii?Q?go6DMLZuJz8+W2LVZ9wC0dO4Mibglny85yk4k40FibXtt+vbdrdaqr+3IiGJ?=
 =?us-ascii?Q?JaC+vGf10KsRJzurHVsqeavJzRTRwh94Wovo3krOS6CVGDL7I4jF6r5CmL00?=
 =?us-ascii?Q?I9E3zC3PxrGmooJDg/xXvqbsTbaZ7Re8IWhWK6NBxtFO+6QU8dY5uLadH4vM?=
 =?us-ascii?Q?BMBz72M1liwbzGY1t2kLkCnsaQDlEtPS7/k6dtVX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be0193c-7099-484a-f150-08dbfbe45b01
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 14:04:00.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tIa0t29cYeD5gzZA0gx8N3u/sJNtH1N8hha2bokvaCvwKETMYQAPa2+LRtBo53+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:01:37AM -0600, Suravee Suthikulpanit wrote:
> Introduce IOMMU_HWPT_DATA_AMD_V2 data type for AMD IOMMU v2 page table,
> which is used for stage-1 in nested translation. The data structure
> contains information necessary for setting up the AMD HW-vIOMMU support.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index bf4a1f8ab748..e2240d430dd1 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -389,14 +389,37 @@ struct iommu_hwpt_vtd_s1 {
>  	__u32 __reserved;
>  };
>  
> +/**
> + * struct iommu_hwpt_amd_v2 - AMD IOMMU specific user-managed
> + *                            v2 I/O page table data
> + * @gcr3: GCR3 guest physical ddress
> + * @gid: Guest ID
> + * @iommu_id: IOMMU host device ID
> + * @gdev_id: Guest device ID
> + * @gdom_id: Guest domain ID
> + * @glx: GCR3 table levels
> + * @guest_paging_mode: Guest v2 page table paging mode
> + */
> +struct iommu_hwpt_amd_v2 {
> +	__aligned_u64 gcr3;
> +	__u32 gid;
> +	__u32 iommu_id;
> +	__u16 gdev_id;
> +	__u16 gdom_id;
> +	__u16 glx;
> +	__u16 guest_paging_mode;

Add explicit padding please

Also, I'm pretty sure that most of these IDs cannot be here.

These are Ok:

	__aligned_u64 gcr3; // table top pointer
	__u16 gdom_id;      // virtual cache tag
        __u16 glx;          // configuration of radix
        __u16 guest_paging_mode; // configuration of radix

These are confusing, probably incorrect.

 +	__u32 gid;
 +	__u32 iommu_id;
 +	__u16 gdev_id;

iommu_id is the RID of the IOMMU, so definately not. The iommu
instance to work on is specifed by the generic dev_id which becomes a
struct device * in the driver callback. Access the target iommu
instance via dev_iommu_priv_get()/etc

The translation of gdev_id to pdev_dev needs to be connected to some
future viommu object, so this shouldn't be part of this series, and
will eventually be provided through some new viommu object API - see
my long outline email

The viommu object should hold the GID. I'm not sure you need a GID
right now (can you just issue invalidation on the physical side?), but
if you do need GID to bridge until the viommu is ready it should
probably be allocated by and stored in the nesting parent.

Jason
