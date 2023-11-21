Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191F17F2B14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjKUK5k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 05:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKUK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:57:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC8C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:57:29 -0800 (PST)
Received: from lhrpeml100001.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SZLmv0DcRz6J9yP;
        Tue, 21 Nov 2023 18:52:31 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 10:57:27 +0000
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.035;
 Tue, 21 Nov 2023 10:57:27 +0000
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Jianyong Wu <jianyong.wu@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "justin.he@arm.com" <justin.he@arm.com>
Subject: RE: [PATCH] arm64/kvm: Introduce feature extension for SMCCC filter
Thread-Topic: [PATCH] arm64/kvm: Introduce feature extension for SMCCC filter
Thread-Index: AQHaGIJSPxqmEiVqkkOrXIqhoEeoZ7B9TvAAgABHfQCABwlmkA==
Date:   Tue, 21 Nov 2023 10:57:27 +0000
Message-ID: <9367235ee3b34a30af43a5689173f61e@huawei.com>
References: <20231116114152.912344-1-jianyong.wu@arm.com>
 <ZVZoKlWrjV1L3CBo@shell.armlinux.org.uk> <ZVakIv5mw6YUlHms@thinky-boi>
In-Reply-To: <ZVakIv5mw6YUlHms@thinky-boi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.211]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Oliver Upton <oliver.upton@linux.dev>
> Sent: Thursday, November 16, 2023 11:22 PM
> To: Russell King (Oracle) <linux@armlinux.org.uk>
> 
> On Thu, Nov 16, 2023 at 07:06:18PM +0000, Russell King (Oracle) wrote:
> > On Thu, Nov 16, 2023 at 11:41:52AM +0000, Jianyong Wu wrote:
> > > 821d935c87b introduces support for userspace SMCCC filtering, but lack
> > > of a way to tell userspace if we have this feature. Add a corresponding
> > > feature extension can resolve this issue.
> > >
> > > For example, the incoming feature Vcpu Hotplug needs the SMCCC filter.
> > > As there is no way to check this feature, VMM will run into error when
> > > it calls this feature on an old kernel. It's bad for backward compatible.
> >
> > Can't you just attempt to use the SMCCC filtering, and if it errors out
> > with the appropriate error code, decide that SMCCC filtering is not
> > available?
> 
> That would also work, as we return ENXIO for the unsupported ioctl.
> 
> > That's how most things like kernel syscalls work - if they're not
> > implemented they return -ENOSYS. glibc can detect that and use a
> > fallback.
> 
> I generally agree, but KVM has gone in the other direction of providing
> auxiliary interfaces for discovering new UAPI. ENXIO has been slightly
> overloaded to imply that a given ioctl is non-existent or otherwise
> unsupported due to some dynamic configuration.


Agreed. We require this check for vCPU Hotplug series as well exactly
for the reason you stated above i.e. to clearly distinguish the case
when KVM host does not support SMCCC filter and when it does but an
error is purged out during configuration of this filter. In the later
we would like to abort the VM initialization (as being done in RFC V2)
but in former we would just continue without supporting vCPU Hotplug
feature. Handling is different in each.

Thanks
Salil.

> 
> Is it ideal? Of course not. With that said userspace may as well use the
> preferred / documented discoverability mechanism. And in Jianyong's case
> the KVM documentation is rather unambiguous (for once) about how you
> discover device attributes.
> 
> https://docs.kernel.org/virt/kvm/api.html#kvm-has-device-attr
> 
> --
> Thanks,
> Oliver
