Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825857FC239
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbjK1Nzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344765AbjK1Nze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:55:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE909B5;
        Tue, 28 Nov 2023 05:55:40 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SfkVd4WZ8z6JB96;
        Tue, 28 Nov 2023 21:55:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 774E61400C9;
        Tue, 28 Nov 2023 21:55:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 13:55:37 +0000
Date:   Tue, 28 Nov 2023 13:55:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Gavin Shan <gshan@redhat.com>, <linux-pm@vger.kernel.org>,
        <loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-parisc@vger.kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>,
        James Morse <james.morse@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC 10/22] drivers: base: Move cpu_dev_init() after
 node_dev_init()
Message-ID: <20231128135536.00002ab9@Huawei.com>
In-Reply-To: <ZVywLPwhILp083Jk@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
        <E1r0JLV-00CTxS-QB@rmk-PC.armlinux.org.uk>
        <095c2d24-735b-4ce2-ba2e-9ec2164f2237@redhat.com>
        <ZVHXk9JG7gUjtERt@shell.armlinux.org.uk>
        <ZVywLPwhILp083Jk@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Tue, 21 Nov 2023 13:27:08 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Nov 13, 2023 at 08:00:19AM +0000, Russell King (Oracle) wrote:
> > On Mon, Nov 13, 2023 at 10:58:46AM +1000, Gavin Shan wrote:  
> > > 
> > > 
> > > On 11/7/23 20:30, Russell King (Oracle) wrote:  
> > > > From: James Morse <james.morse@arm.com>
> > > > 
> > > > NUMA systems require the node descriptions to be ready before CPUs are
> > > > registered. This is so that the node symlinks can be created in sysfs.
> > > > 
> > > > Currently no NUMA platform uses GENERIC_CPU_DEVICES, meaning that CPUs
> > > > are registered by arch code, instead of cpu_dev_init().
> > > > 
> > > > Move cpu_dev_init() after node_dev_init() so that NUMA architectures
> > > > can use GENERIC_CPU_DEVICES.
> > > > 
> > > > Signed-off-by: James Morse <james.morse@arm.com>
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > ---
> > > > Note: Jonathan's comment still needs addressing - see
> > > >    https://lore.kernel.org/r/20230914121612.00006ac7@Huawei.com
> > > > ---
> > > >   drivers/base/init.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >   
> > > 
> > > With Jonathan's comments addressed:  
> > 
> > That needs James' input, which is why I made the note on the patch.  
> 
> I'm going to be posting the series without RFC soon, and it will be
> with Jonathan's comment unaddressed - because as I've said several
> times it needs James' input and we have sadly not yet received that.
> 
> Short of waiting until James can respond, I don't think there are
> any other alternatives.

In the interests of expediency I'm fine with that.  (To be honest I'd
forgotten I even made that comment ;)

Jonathan

> 
> I do hope we can get this queued up for v6.8 though.
> 

