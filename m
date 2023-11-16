Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACFF7EE24F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbjKPOGL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 09:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjKPOGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:06:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656D811F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:06:06 -0800 (PST)
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SWMC54dvMz6GDCc;
        Thu, 16 Nov 2023 22:01:21 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 16 Nov 2023 14:06:03 +0000
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031;
 Thu, 16 Nov 2023 14:06:03 +0000
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Cornelia Huck <cohuck@redhat.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "rmk@armlinux.org.uk" <rmk@armlinux.org.uk>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "justin.he@arm.com" <justin.he@arm.com>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>
Subject: RE: [PATCH] arm64/kvm: Introduce feature extension for SMCCC filter
Thread-Topic: [PATCH] arm64/kvm: Introduce feature extension for SMCCC filter
Thread-Index: AQHaGIJSPxqmEiVqkkOrXIqhoEeoZ7B86xkAgAAOImA=
Date:   Thu, 16 Nov 2023 14:06:03 +0000
Message-ID: <2ea495b04a7d484aa570059298e20862@huawei.com>
References: <20231116114152.912344-1-jianyong.wu@arm.com>
 <877cmhq1zp.fsf@redhat.com>
In-Reply-To: <877cmhq1zp.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.150.188]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, November 16, 2023 1:09 PM
> To: Jianyong Wu <jianyong.wu@arm.com>; maz@kernel.org; james.morse@arm.com;
> will@kernel.org
> 
> On Thu, Nov 16 2023, Jianyong Wu <jianyong.wu@arm.com> wrote:
> 
> > 821d935c87b introduces support for userspace SMCCC filtering, but lack
> > of a way to tell userspace if we have this feature. Add a corresponding
> > feature extension can resolve this issue.
> >
> > For example, the incoming feature Vcpu Hotplug needs the SMCCC filter.
> > As there is no way to check this feature, VMM will run into error when
> > it calls this feature on an old kernel. It's bad for backward compatible.
> 
> Can't you simply query via KVM_HAS_DEVICE_ATTR whether the SMCCC
> filtering controls exist?


Agreed. In fact, this is what I had earlier intended to do but deferred this
change. As of now, RFC V2 of vCPU Hotplug series does not have this check yet
while installing the SMCCC filters in KVM Host.

Thanks

> > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> > ---
> >  Documentation/virt/kvm/api.rst | 3 ++-
> >  arch/arm64/kvm/arm.c           | 1 +
> >  include/uapi/linux/kvm.h       | 1 +
> >  3 files changed, 4 insertions(+), 1 deletion(-)
> >

