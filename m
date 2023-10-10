Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584437BFEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjJJOIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjJJOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:08:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10937A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:08:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23933C433C7;
        Tue, 10 Oct 2023 14:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696946908;
        bh=FU6HIBdqNLvn3NJ9WG2a3FtDPhzK1Gp4R0TfIcUP1wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UP4lBPMPjwr7ttVcKqdL46QKbNc8HO7IJd9/DYuSv+ZeybSuk6wtsTppLyuZvn1sL
         UaKnY1ZqbPx1xcYlUnDEBmv/rp2B/9AaQPwFS63G/HfgDgEWwbZJAgz4uHp1Bx/9id
         FwxdtE8K/svnEnj3YMBjL/7zJ+byuGb0DXhnzgqQ=
Date:   Tue, 10 Oct 2023 16:08:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     yangyicong@hisilicon.com, catalin.marinas@arm.com, will@kernel.org,
        sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com, rafael@kernel.org,
        jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch_topology: Support SMT control on arm64
Message-ID: <2023101038-numerate-conjoined-f83a@gregkh>
References: <20231010115335.13862-1-yangyicong@huawei.com>
 <2023101025-thieving-eagle-406f@gregkh>
 <713d3125-e21e-005e-7713-53c717aa15da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713d3125-e21e-005e-7713-53c717aa15da@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:10:48PM +0800, Yicong Yang wrote:
> On 2023/10/10 20:33, Greg KH wrote:
> > On Tue, Oct 10, 2023 at 07:53:35PM +0800, Yicong Yang wrote:
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> The core CPU control framework supports runtime SMT control which
> >> is not yet supported on arm64. Besides the general vulnerabilities
> >> concerns we want this runtime control on our arm64 server for:
> > 
> > But shouldn't this be part of UEFI?  Why manually try to determine this
> > at powerup in Linux?
> 
> We can disable/enable SMT by UEFI, but it lacks of flexibility. With runtime
> support we can disable/enable on demand, rather than disable/enable all the time.
> In our case, mainly for the below 2 reasons in the commit.

Runtime is fine, it's the initial detection that I have questions about,
see below.

> > And again, why is this not an issue on the current platforms that
> > already support CONFIG_HOTPLUG_SMT?  What makes ARM64 so broken it
> > requires this manual intervention?
> > 
> 
> Currently I see x86 and powerpc supports CONFIG_HOTPLUG_SMT on the mainline.
> For x86 they build the topology and detects the SMT suppport in the arch
> code, seems they can directly get the SMT number by reading the system
> register, refers to arch/x86/kernel/cpu/common.c:detect_ht_early(). For
> powerpc I see they are reading the threads number from the firmware(OF)
> and assuming all the SMT have the same thread number, refer to
> arch/powerpc/kernel/setup-common.c:smp_setup_cpu_maps(). Please corrects
> me if there's mistakes.
> 
> Back to arm64, there's no system registers to directly indicate the thread
> numbers of each SMT in the system like x86, nor do we have the information
> from the firmware (OF/ACPI).

UEFI/ACPI should be showing you this information, as that's how x86 gets
the information, right?  If not, it needs to be added as part of the
specification.

> I cannot assume all the physical cores have
> the same thread number, since we may have SMT cores and non-SMT cores on
> heterogeneous platform. We can only know the SMT information after
> parsing the firmware information.

Ugh, heterogeneous platforms, why???  Anyway, I didn't think about that,
but even then, the firmware should be giving you this information in a
standard way, otherwise it's not following the UEFI/ACPI specification
from what I can tell.

thanks,

greg k-h
