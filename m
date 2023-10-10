Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289847C04CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbjJJTjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJJSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:23:54 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE610A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7m3jnFwGC29bY/1dNTtH5n7yzydNYfIQ9vmAlnia1mGgsRt+GgQxzZuGQvKlhKt/W36iYPXH3pjS7Jy9OqO+oko/547vTVUHZUGraeeS5TnNxluBmJkCHueVjHSavqDfyg6UT2luIOE2CGN/VIX3Ju24UbT+kB82iamBzRcYVVyRN/DwnHJNIoFJKPHwJqc1GiDZESVYQVWu3xlfvjrjy9IN1tDsYgLsggt8u36/DdyCckDbVbHYqRbAbfTwrRf8FRd1w4kINPCbixxmFsMLBIMdzp+9idkqHEDmdC2fZdCsouMLx6TuLw44bEZ0r3vCYK9msDQw4MLDfP7TJjq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwXHv2sTZzQKSFOddUqt85kLqG6N8381v/aqgn+x7p8=;
 b=DdUWMwKSbL+ZAVe0K5EbF/mOLl3g1Vm8jWgdK4iSn90s/kXcCzpRP9kfbijuOG6bHnLUKdrJnJi3MoSGiPiKSSkk5YgFntRtG4qPTj5mzpjfimYxIFInB3KPcll+oQGIwBtN6Vj0WC8KnVlChSIV+HUWRUdQzD84dOzO5fe0ILWaW8kBzt3sO5QIAai7GoU+j7WpQ6mSwcpvcU257m0js1HUyBj7mPpQJ4fMdK0y4HL1pEr88kaHjOysKvqcW9iWWTRnRKEKEBAALaGINFUtkdWlVqdDWPljWueo0JC3kY0WeDeJsAlJluCS5fsEKBVtm5DD2vDHD5Kw4TZQz85j7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwXHv2sTZzQKSFOddUqt85kLqG6N8381v/aqgn+x7p8=;
 b=sosLvaQGOKinN2z8VK5PjsYAm34Bj0QXx6AB74yev4TMpiTGZ8daF9u+n32MKs8gx2+cDrmp6OGGOFQIUwFzt83mSU4wFKKSq++fjfCqMGNurun2tS15uRkQUNIvnlknzfKaRSi0AZHOZ3IEI0If58ixSQbc7JWEXHYq9ezQ1EzM60Bk+ueH7tKSUoWVPvTfU1THSCOEnze2PKdGbuyBkq/fJpdrwWah5VfpVz+aJIPyg4bl1kdvQpYUsrKYlRAjjK5HsBFYIpT61G6R0JF5EyK+Hz9j+WRW70od6yVGKNaiKhwWcUscJLc3sx1ubjBFuLrHz98J7Xrfh6w6nQTzEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4950.namprd12.prod.outlook.com (2603:10b6:a03:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 18:23:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 18:23:29 +0000
Date:   Tue, 10 Oct 2023 15:23:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        will@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Message-ID: <20231010182328.GS3952@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com>
 <ZR7hKYU1Wj+VTqpO@arm.com>
 <20231005165458.GM682044@nvidia.com>
 <ZSVe0nb02S4kz5D2@arm.com>
 <20231010150502.GM3952@nvidia.com>
 <ZSWHkvhutlnvVLUZ@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSWHkvhutlnvVLUZ@arm.com>
X-ClientProxiedBy: MN2PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:160::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2a3ee2-6ca5-4ce6-180f-08dbc9be0072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h33vw98oftw/D+xoqxfDMMzVRRN3ee76103sLo9/Ba0DfFjbENR7xNGoipSC7RtCwd0Vu+BKJAOCTeTBAfWL8vCDer6dvkeP9t0dTfU7iv4uPVBk514Gte07V+AOU5Wnh/JoxDlTvR3SBUhPR/KrmHxWRLpT/QVnBqDzKl6MF285h/q3jUuqXUSJyqgXVKyU5TiMy8ZzjgHBUiUSnpskpqtRyUA2ekO1K2bl+ucLbi4fcRr3D1g27qBRX5ItZ62xOQTXuosb15sw0yY5i4+/UUVFAoOnqrMp0U5Js01Os5zl+8VfRnv4Jon9KNVNQZZzsclUQsdmk3ySlVUa137NxQymXyLrZxCKCohIiG47Wb+F1wAJlFreWnS2fTlt28qycgzto6su52o7SoLE2tw123DDEXQ+UyVFJFYqiz4+rINl47V+5s1nak+fHVRk0HwNNlUvTp1vosSfNo8EO5FnUTIQZQHKvZoPBMGoZuzjPCJbVedQz0mmS/ZXhhBYTD+tXLeKIwJkgpCAMAs5UrCSy+7XxFvX72j9XgruMnS5jQtScaBLCpD+xKLeL/eBMXfd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6512007)(66946007)(66556008)(83380400001)(2616005)(1076003)(26005)(66476007)(6916009)(4326008)(2906002)(316002)(41300700001)(6506007)(8936002)(478600001)(6486002)(8676002)(5660300002)(33656002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ijg3ZfCMsVgzYCtZ4XV9YCGJ6O7z3EPhv1oOdLXDfa26+11GY/fSFg6FWuv?=
 =?us-ascii?Q?qSznqqUMGqznI1LUUOnHbVushHutANWdx5EmQtiyhTwOBPnwx110KvT2z/cK?=
 =?us-ascii?Q?6fV9J1yhq80EtDSEz9NcVeYgGRcdRi6lgZnj9sM/goie9ivyQN7/btrfDa0c?=
 =?us-ascii?Q?j7OOoiXZQK141p3UVxhWk4Sp+wb4TWNILsYS3YjVyVpkN2S/PNNzJx/TR6F1?=
 =?us-ascii?Q?ZfG0yz3t9oksbKM546PebhSejNsFzccCx3sRl2KQouGiIyu7emVa24PklSes?=
 =?us-ascii?Q?ecgdPW3BHSvDIKKh1YTx+HayheuuN+D5GDf8cc7CCCa7pxkw14q/pO1kELSd?=
 =?us-ascii?Q?tPI7BOEaNLWd92R/3azPaKft5W/1/eWEsSJHIfGpDgHu8IEpIrSA8itO5Fda?=
 =?us-ascii?Q?jgZjN8I+y3vol2WtPHPZSeoni79n40c8gGjBH0O9aZgfZAJ/XGAZetiG4uH7?=
 =?us-ascii?Q?+ZOEizbLvlexgTibvvcDTHfXsTFAOthaNGgzswAB51kY9ouPbl89MsFvhBdJ?=
 =?us-ascii?Q?xz7V1BUibWc8ErQ0HYuePFXSuPzAUnVnmNbMxfUxHi+K25gHCEWeOgXiOB2A?=
 =?us-ascii?Q?2Bmua6PnLXyEn5ccc5wwmvz7HKaKePKvxRH+EYtyJnqCowufpRm4oA2DT88d?=
 =?us-ascii?Q?haQA6oPqISzKaRgcmXGmOKLyiWIcF0lg9zyRwbJefIHxPwvekLsYrFty0ivO?=
 =?us-ascii?Q?xEsIwxrDnAVq/21hC6SdNHidx/dBXWJfuQaKI5cy2GwEPhEywbI+8DRTybEB?=
 =?us-ascii?Q?Xm8Ka/IE6iKdM5rI/T7kUb9zDgf+v8Ga1KTwrM0d6YRYDy5mWcI1NHMmd5HR?=
 =?us-ascii?Q?2WP/QuwecYlmrnK/GNTB2Bqi2MqzVQV6NW+FRyuTKPYIglX8bYebD59O2i5O?=
 =?us-ascii?Q?01CUbBhRMASAiIgQO6LwksoDUeISQCxGE7i9nF2wB7YT+rZ0GDy4qxD2efpF?=
 =?us-ascii?Q?o6y1BUhu6Fwbtp371DdNcibJOdXICUj1jpVSuiuuEMGU8SXQZ6dCk2nTAiIv?=
 =?us-ascii?Q?rIT4n9tKWOG0NTBFuaDG/c6HPn+COqMEPTepRwwK2bJCFyD34e0yOEaVY9am?=
 =?us-ascii?Q?lOVTPG6jiO7o6Lc/9NgJ9pcWjZxyOzH8nFi3v/rr/f8Ci+Q9GGkHBP22D2oj?=
 =?us-ascii?Q?TRvTavjCXNUcn4gtQt7qWfd68DGxJwP5f+wE1cSvtjjfrRZE5WfGzxGBvqzx?=
 =?us-ascii?Q?xp5sHIvONxLkFIGOsUhv/JbAleIlFkDt85Ii/gSSxMyuEB3sFIv7TZ+W4Fxk?=
 =?us-ascii?Q?8+/rjn7VZc41jXcSnCqPg1dongXCvIwhxo5kbHftufwQiPon6kDDx8skjRjP?=
 =?us-ascii?Q?96636FqRGBtmWvD4M+/5FIDklRV8VHSbNasolJwgs6Veyw6Jo29ett7C1Z6Q?=
 =?us-ascii?Q?Shvf9+4oGCuHxs5HdthNlDpnyvFMuqpaq3J2fFro/C0KUUWdYesk64D+wjd6?=
 =?us-ascii?Q?9cyRFVL1CTI3BEkkR21dMTnlKe1nrDR9lL6H0tHXn/g77JfZ40H73ho9Tvw+?=
 =?us-ascii?Q?dhFDNMDVTSlpLVAilg+qRRiY2TugNnOEXFC/0+9aVLO1aQoXIa8ime7G4gy0?=
 =?us-ascii?Q?TPTQrFf6RtdcID6cqIwCzVjrr9MKOo82rtE8E2l/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2a3ee2-6ca5-4ce6-180f-08dbc9be0072
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 18:23:29.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbJEs4UOuj1357ew1/g0fx6aJcLfu5ivcFyAHops2mf49AnNa7m+6huWzzSTecAg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 06:19:14PM +0100, Catalin Marinas wrote:

> This has been fixed in newer architecture versions but we haven't
> added Linux support for it yet (and there's no hardware available
> either). AFAIK, there's no MTE support for CXL-attached memory at
> the moment in the current interconnects, so better not pretend it's
> general purpose memory that supports all the features.

I don't know much about MTE, but the use case imagined for CXL memory
allows the MM to exchange any system page with a CXL page. So there
cannot be a behavioral difference.

Can usespace continue to use tagged pointers even if the mm has moved
the pages to CXL that doesn't support it?

The main purpose for this is to tier VM memory, so having CXL
behaviorally different in a VM seems fatal to me.

Linux drivers need a way to understand this, like we can't have a CXL
memory pool driver or GPU driver calling memremap_pages() and getting
a somewhat broken system because of MTE incompatibilities. So maybe
ARM really should block memremap_pages() in case of MTE until
everything is resolved?

From the mm perspective we can't have two kinds of cachable struct
pages running around that are functionally different.

> Other than preventing malicious guest behaviour, it depends what the VM
> needs cacheable access for: some GPU memory that's only used for sharing
> data and we don't need all features or general purpose memory that a VM
> can use to run applications from etc. The former may not need all the
> features (e.g. can skip exclusives) but the latter does.

Like CXL memory pooling GPU memory is used interchangably with every
kind of DDR memory in every context. It must be completely transparent
and interchangable via the mm's migration machinery.

> > > I've seen something similar in the past with
> > > LSE atomics (or was it exclusives?) not being propagated. These don't
> > > make the memory safe for a guest to use as general purpose RAM.
> > 
> > At least from a mm perspective, I think it is important that cachable
> > struct pages are all the same and all interchangable. If the arch
> > cannot provide this it should not allow the pgmap/memremap to succeed
> > at all. Otherwise drivers using these new APIs are never going to work
> > fully right..
> 
> Yes, for struct page backed memory, the current assumption is that all
> are the same, support all CPU features. It's the PFN-based memory where
> we don't have such guarantees.

I see it got a bit confused, I am talking about memremap_pages() (ie
include/linux/memremap.h), not memremap (include/linux/io.h) for
getting non-struct page memory. It is confusing :|

memremap_pages() is one of the entry points of the struct page hotplug
machinery. Things like CXL drivers assume they can hot plug in new
memory through these APIs and get new cachable struct pages that are
functionally identical to boot time cachable struct pages.

> We have an additional flag, VM_MTE_ALLOWED, only set for mappings backed
> by struct page. We could probe that in KVM and either fall back to
> non-cacheable or allow cacheable if MTE is disable at the vCPU level.

I'm not sure what this does, it is only set by shmem_map? That is
much stricter than "mappings backed by struct page"

Still, I'm not sure how to proceed here - we veered into this MTE
stuff I don't know we have experiance with yet.

Thanks,
Jason
