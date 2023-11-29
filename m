Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A657FD1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjK2JJZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 04:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjK2JJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:09:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E519B1;
        Wed, 29 Nov 2023 01:09:28 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SgD5t3LfDz6HJkv;
        Wed, 29 Nov 2023 17:09:06 +0800 (CST)
Received: from lhrpeml100002.china.huawei.com (unknown [7.191.160.241])
        by mail.maildlp.com (Postfix) with ESMTPS id 93A30140EE7;
        Wed, 29 Nov 2023 17:08:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Nov 2023 09:08:21 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Wed, 29 Nov 2023 09:08:21 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kevin Tian" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Thread-Topic: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Thread-Index: AQHaB7eiyREckpQTNkq/zZ6Gqko1E7CRNsbw
Date:   Wed, 29 Nov 2023 09:08:21 +0000
Message-ID: <55ed1ac0f2024c429b396cb751773d62@huawei.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: 26 October 2023 03:49
> To: Jason Gunthorpe <jgg@ziepe.ca>; Kevin Tian <kevin.tian@intel.com>;
> Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin
> Murphy <robin.murphy@arm.com>; Jean-Philippe Brucker
> <jean-philippe@linaro.org>; Nicolin Chen <nicolinc@nvidia.com>; Yi Liu
> <yi.l.liu@intel.com>; Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: iommu@lists.linux.dev; linux-kselftest@vger.kernel.org;
> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Lu
> Baolu <baolu.lu@linux.intel.com>
> Subject: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
> 
> Hi folks,
> 
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework for nested translation. Nested
> translation is a hardware feature that supports two-stage translation
> tables for IOMMU. The second-stage translation table is managed by the
> host VMM, while the first-stage translation table is owned by user
> space. This allows user space to control the IOMMU mappings for its
> devices.
> 
> When an IO page fault occurs on the first-stage translation table, the
> IOMMU hardware can deliver the page fault to user space through the
> IOMMUFD framework. User space can then handle the page fault and
> respond
> to the device top-down through the IOMMUFD. This allows user space to
> implement its own IO page fault handling policies.
> 
> User space indicates its capability of handling IO page faults by
> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> for page fault delivery. On a successful return of HWPT allocation, the
> user can retrieve and respond to page faults by reading and writing to
> the file descriptor (FD) returned in out_fault_fd.
> 
> The iommu selftest framework has been updated to test the IO page fault
> delivery and response functionality.
> 
> This series is based on the latest implementation of nested translation
> under discussion [1] and the page fault handling framework refactoring in
> the IOMMU core [2].
> 
> The series and related patches are available on GitHub: [3]
> 
> [1]
> https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@int
> el.com/
> [2]
> https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@li
> nux.intel.com/
> [3]
> https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-deliv
> ery-v2

Hi Baolu,

Do you have a corresponding Qemu git to share? I could give it a spin on our ARM 
platform. Please let me know.

Thanks,
Shameer

