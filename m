Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B4D7C4F08
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbjJKJdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjJKJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:33:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B71A91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:33:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S56tf4nkmz6JB1q;
        Wed, 11 Oct 2023 17:30:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 10:33:04 +0100
Date:   Wed, 11 Oct 2023 10:33:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Yicong Yang <yangyicong@huawei.com>, <yangyicong@hisilicon.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <dietmar.eggemann@arm.com>, <rafael@kernel.org>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arch_topology: Support SMT control on arm64
Message-ID: <20231011103303.00002d8f@Huawei.com>
In-Reply-To: <2023101038-numerate-conjoined-f83a@gregkh>
References: <20231010115335.13862-1-yangyicong@huawei.com>
        <2023101025-thieving-eagle-406f@gregkh>
        <713d3125-e21e-005e-7713-53c717aa15da@huawei.com>
        <2023101038-numerate-conjoined-f83a@gregkh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 16:08:25 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Oct 10, 2023 at 09:10:48PM +0800, Yicong Yang wrote:
> > On 2023/10/10 20:33, Greg KH wrote:  
> > > On Tue, Oct 10, 2023 at 07:53:35PM +0800, Yicong Yang wrote:  
> > >> From: Yicong Yang <yangyicong@hisilicon.com>
> > >>
> > >> The core CPU control framework supports runtime SMT control which
> > >> is not yet supported on arm64. Besides the general vulnerabilities
> > >> concerns we want this runtime control on our arm64 server for:  
> > > 
> > > But shouldn't this be part of UEFI?  Why manually try to determine this
> > > at powerup in Linux?  
> > 
> > We can disable/enable SMT by UEFI, but it lacks of flexibility. With runtime
> > support we can disable/enable on demand, rather than disable/enable all the time.
> > In our case, mainly for the below 2 reasons in the commit.  
> 
> Runtime is fine, it's the initial detection that I have questions about,
> see below.
> 
> > > And again, why is this not an issue on the current platforms that
> > > already support CONFIG_HOTPLUG_SMT?  What makes ARM64 so broken it
> > > requires this manual intervention?
> > >   
> > 
> > Currently I see x86 and powerpc supports CONFIG_HOTPLUG_SMT on the mainline.
> > For x86 they build the topology and detects the SMT suppport in the arch
> > code, seems they can directly get the SMT number by reading the system
> > register, refers to arch/x86/kernel/cpu/common.c:detect_ht_early(). For
> > powerpc I see they are reading the threads number from the firmware(OF)
> > and assuming all the SMT have the same thread number, refer to
> > arch/powerpc/kernel/setup-common.c:smp_setup_cpu_maps(). Please corrects
> > me if there's mistakes.
> > 
> > Back to arm64, there's no system registers to directly indicate the thread
> > numbers of each SMT in the system like x86, nor do we have the information
> > from the firmware (OF/ACPI).  
> 
> UEFI/ACPI should be showing you this information, as that's how x86 gets
> the information, right?  If not, it needs to be added as part of the
> specification.
> 
> > I cannot assume all the physical cores have
> > the same thread number, since we may have SMT cores and non-SMT cores on
> > heterogeneous platform. We can only know the SMT information after
> > parsing the firmware information.  
> 
> Ugh, heterogeneous platforms, why???  Anyway, I didn't think about that,
> but even then, the firmware should be giving you this information in a
> standard way, otherwise it's not following the UEFI/ACPI specification
> from what I can tell.

It can be established from ACPI PPTT, but it's pretty indirect.  You'd need
to search all leaf nodes of the tree and find "Processor Hierarchy Nodes
tagged as "Processor is a thread" then walk up from those find common
ancestors.  So ultimately I think you end up doing some form of multiple
pass. I'm not sure it ends up simpler than what yangyicong had here.

There may be better algorithms than the simple nested loop here though
with better scalability.

Jonathan






> 
> thanks,
> 
> greg k-h

