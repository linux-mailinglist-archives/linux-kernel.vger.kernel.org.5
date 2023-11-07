Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593E27E49C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjKGUYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjKGUYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:24:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD67D7E;
        Tue,  7 Nov 2023 12:24:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA29C433C9;
        Tue,  7 Nov 2023 20:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699388650;
        bh=dPAbyc0bKaR20nuSJ6PMy6LKPAw4pz1rFnfWsbX6j3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EbItIntR5TdOYz66NjOPE45+b2KH0IFppBEE+qLVrXdjXfGsM4cpQc/yvhc4m00aQ
         2q6mVNkjbmIVLe8ugkEeaMT95oaCY5+Snrj8Czsk7U6HYhzE1r9NbA3AMlf9F6XL+7
         hgcU+00E0sq8xSW7YRQGwA++CpoRt5se13dcYyVc=
Date:   Tue, 7 Nov 2023 21:24:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, apatel@ventanamicro.com
Subject: Re: [PATCH 5.10 00/95] 5.10.200-rc1 review
Message-ID: <2023110700-clad-matter-31bf@gregkh>
References: <20231106130304.678610325@linuxfoundation.org>
 <8aec1bd5-befc-486c-9e47-7571b937b8c7@linaro.org>
 <CAEUSe7_g2LbOkb6BqqdPha4SX4669O33H0a04sJ7AfbR1wfA_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7_g2LbOkb6BqqdPha4SX4669O33H0a04sJ7AfbR1wfA_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 12:14:21PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On Mon, 6 Nov 2023 at 11:53, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> > On 06/11/23 7:03 a. m., Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.10.200 release.
> > > There are 95 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.200-rc1.gz
> > > or in the git tree and branch at:
> > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > There seems to be a problem building for RISC-V with GCC 8, 12, and Clang 17. This is with defconfig, allnoconfig, tinyconfig:
> >
> > -----8<-----
> > /builds/linux/drivers/irqchip/irq-riscv-intc.c: In function 'riscv_intc_init':
> > /builds/linux/drivers/irqchip/irq-riscv-intc.c:119:17: error: implicit declaration of function 'fwnode_dev_initialized'; did you mean 'zone_is_initialized'? [-Werror=implicit-function-declaration]
> >    119 |                 fwnode_dev_initialized(of_fwnode_handle(node), true);
> >        |                 ^~~~~~~~~~~~~~~~~~~~~~
> >        |                 zone_is_initialized
> > cc1: some warnings being treated as errors
> > make[3]: *** [/builds/linux/scripts/Makefile.build:286: drivers/irqchip/irq-riscv-intc.o] Error 1
> > make[3]: Target '__build' not remade because of errors.
> > make[2]: *** [/builds/linux/scripts/Makefile.build:503: drivers/irqchip] Error 2
> > make[2]: Target '__build' not remade because of errors.
> > make[1]: *** [/builds/linux/Makefile:1832: drivers] Error 2
> > make[1]: Target '__all' not remade because of errors.
> > make: *** [Makefile:192: __sub-make] Error 2
> > make: Target '__all' not remade because of errors.
> > ----->8-----
> >
> > Currently bisecting.
> 
> -----8<-----
> Bisection done!
> First commit presenting NEW behaviour: 6751b1fbf98ba2c40bbdda22e2e6714a9c27b91b
> 
> commit 6751b1fbf98ba2c40bbdda22e2e6714a9c27b91b
> Author: Anup Patel <apatel@ventanamicro.com>
> Date:   Tue Oct 3 10:13:51 2023 +0530
> 
>     irqchip/riscv-intc: Mark all INTC nodes as initialized
> 
>     [ Upstream commit e13cd66bd821be417c498a34928652db4ac6b436 ]
> ----->8-----
> 
> Reverting that commit makes the build happy again.

Thanks, will go drop that now.

greg k-h
