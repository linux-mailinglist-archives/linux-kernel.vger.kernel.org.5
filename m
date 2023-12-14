Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB0A8136A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjLNQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjLNQpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:45:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1970E112
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:45:46 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrdVc6P6Cz67CtB;
        Fri, 15 Dec 2023 00:44:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id AF11C1400CA;
        Fri, 15 Dec 2023 00:45:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 16:45:43 +0000
Date:   Thu, 14 Dec 2023 16:45:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "Ryan Roberts" <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "Oliver Upton" <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 12/15] arm64/mm: Split __flush_tlb_range() to elide
 trailing DSB
Message-ID: <20231214164541.000027a1@Huawei.com>
In-Reply-To: <20231214152206.GA3625745@myrica>
References: <20231204105440.61448-1-ryan.roberts@arm.com>
        <20231204105440.61448-13-ryan.roberts@arm.com>
        <20231212113517.GA28857@willie-the-truck>
        <0969c413-bf40-4c46-9f1e-a92101ff2d2e@arm.com>
        <2e6f06d3-6c8e-4b44-b6f2-e55bd5be83d6@arm.com>
        <20231214121336.GA1015@willie-the-truck>
        <fbcda9e1-0473-4669-a869-d4de351c3197@arm.com>
        <20231214152206.GA3625745@myrica>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 15:22:06 +0000
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Thu, Dec 14, 2023 at 12:30:55PM +0000, Robin Murphy wrote:
> > > Robin, Jean-Philippe -- do we need to make sure that the SMMU has completed
> > > its TLB invalidation before issuing an ATC invalidate? My half-baked worry
> > > is whether or not an ATS request could refill the ATC before the TLBI
> > > has completed, therefore rendering the ATC invalidation useless.  
> > 
> > I would agree, and the spec for CMD_ATC_INV does call out a
> > TLBI->sync->ATCI->sync sequence. At the moment the SVA notifier is issuing
> > its own command-based TLBIs anyway so the necessary sync is implicit there,
> > but if and when we get BTM support wired up properly it would be nice not to
> > have to bodge in an additional sync/DSB.  
> 
> Yes agreed, with BTM the CPU must call the notifier that issues ATC
> invalidation after completing the TLBI+DSB instructions.
> 
> SMMU IHI0070F.a  3.9.1 ATS Interface
> 
> 	Software must ensure that the SMMU TLB invalidation is complete before
> 	initiating the ATC invalidation.
> 
> I'm guessing BTM will be enabled in the SMMU driver sometime soon, given
> that there already is one implementation in the wild that could use it. I
> think we didn't enable it because of the lack of separation between shared
> and private VMIDs, but that may now be solvable with the recent rework of
> the VMID allocator.
> 

+CC Shameer.  We'll indeed need to fix this when enabling BTM.

Thanks for the heads up.

Jonathan

> Thanks,
> Jean
> 

