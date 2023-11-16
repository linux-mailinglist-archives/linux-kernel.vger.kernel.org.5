Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46337EE9E4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbjKPXMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjKPXMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:12:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2441181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:12:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94C7C433C8;
        Thu, 16 Nov 2023 23:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700176362;
        bh=Wxb3DtYTe23fEMHKUZEE6WZBpPDcJd4ks8nGwGN/WpU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pzUw+lBeYCIF4xTHByHz7GNB4IKjdeyk8i2h1SfHV99iBHt/XXUYe9iKyVmC9hiJL
         JNu82ReEgREhFjG2+MQjThM5UN2LhbcsOe1zMMiIqm4zXpKKU8hWd7IrXoPiTaIDpu
         HsIWrxpC2xYPYVUUQlTwUmkL/4EVS07tUcbmGvfDe2MwxehKwZ89AOdfCJxvmvWgil
         lO+pJTSMFoZAPjXil/fkTcAgXxTwyp02ThPyoslYakDGCayL+wzg0ggSm3/2neB/9N
         tZSlKL9OPGmUTF2oHNdHazfXmHHo7TntmHHgoCL85exiotnfTpM/XBXeIG4NCvAccB
         fm0Ip8IgEwBfg==
Date:   Thu, 16 Nov 2023 15:12:38 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Mario Marietto <marietto2008@gmail.com>
cc:     Chuck Zmudzinski <brchuckz@netscape.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chuck Zmudzinski <brchuckz@aol.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>
Subject: Re: [PATCH] arm/mm: add option to prefer IOMMU ops for DMA on Xen
In-Reply-To: <CA+1FSij82weDFfsfBQpnPjQJ9K6JVhHxF4JTOKPjwm-8SUrD=A@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2311161507400.773207@ubuntu-linux-20-04-desktop>
References: <20231111184538.2371-1-brchuckz.ref@aol.com> <20231111184538.2371-1-brchuckz@aol.com> <e5ebfde9-7a74-4908-b0b9-db47c4e76315@arm.com> <alpine.DEB.2.22.394.2311141407140.160649@ubuntu-linux-20-04-desktop> <edefba96-0a17-4b3d-992c-6bfe9e62bf97@netscape.net>
 <CA+1FSih45=vtpa+bfYGDFEXd6u=+V8wLsBoo8=2rmj7V0Lj_Ow@mail.gmail.com> <CA+1FSiiuFMvZAHHXFQHRF=gQSoZTxLEZSDYfCgw8j6HiGkkDXw@mail.gmail.com> <CA+1FSij82weDFfsfBQpnPjQJ9K6JVhHxF4JTOKPjwm-8SUrD=A@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-171887673-1700176362=:773207"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-171887673-1700176362=:773207
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

My guess is that the issue is one of these two:

1) version mismatch between Xen and Xen tools
   E.g. Xen from staging and Xen Tools from 4.18

2) missing Xen modules in Linux Dom0
   Was /etc/init.d/xencommons run at boot?
   Is /proc/xen mounted?
   Are the privcmd, gntdev, xenfs, modules loaded?


On Thu, 16 Nov 2023, Mario Marietto wrote:
> I've found a similar error on this post,made on 2012 :
> https://groups.google.com/g/qubes-devel/c/W1lM4ELuVVI
> and according to what has been asked there,I want to post some further relevant informations to help you to help me to debug 
> the problem :
> root@devuan-bunsen:/Dati/xen# xl dmesg ---> https://pastebin.ubuntu.com/p/YvtdCPwMWW/
> 
> root@devuan-bunsen:/Dati/xen# dmesg ---> https://pastebin.ubuntu.com/p/9cNxCTXVrd/
> root@devuan-bunsen:/var/log/xen# mousepad xenstored-access.log ---> https://pastebin.ubuntu.com/p/RTPBG9nS8R/
> root@devuan-bunsen:/var/log/xen# mousepad xenstored.log ---> https://pastebin.ubuntu.com/p/T354ts33nP/
> 
> very thanks.
> 
> On Thu, Nov 16, 2023 at 10:51 AM Mario Marietto <marietto2008@gmail.com> wrote:
>       Hello to everyone.
> 
> I'm trying to boot Linux 6.1.y as Xen dom0 on the Chromebook xe303c12, aka Snow and configure and start a very basic domU
> guest,following the Chuck's tutorial,located here :
> 
> https://github.com/mobile-virt/u-boot-chromebook-xe303c12/tree/chromebook/xen#starting-a-domu-guest
> 
> What I did has been to carefully follow his instructions,but I haven't found a solution to fix this problem,yet :
> 
> # sudo xl create devuan.cfg -c
> 
> Parsing config from devuan.cfg
> libxl: error: libxl_create.c:720:libxl__domain_make: domain creation fail: Permission denied
> libxl: error: libxl_create.c:1309:initiate_domain_create: cannot make domain: -3
> 
> This is my devuan.cfg file :
> 
> kernel = '/Dati/xen/kernels/zImage-6.1.59-stb-xen-cbe+'
> memory = '512'
> name = 'Devuan'
> vcpus = '1'
> disk = [ '/Dati/xen/devuan.img,,xvda,w' ]
> extra = 'console=hvc0 root=/dev/xvda rw init=/sbin/init xen-fbfront.video=24,1024,768'
> 
> (I have tried also with root=/dev/xvda1 and root=/dev/xvda2,but leaving disk = [ '/Dati/xen/devuan.img,,xvda,w' ] and not xvda1 or 2)
> 
> I have no  idea about the reason(s) I always get that error,but I don't think it is caused by a wrong creation of the devuan.img
> file. Can someone point me in the right direction to understand what could be wrong ? I haven't found any useful information on the
> internet.
> 
> This is bootxen.scr file where I have configured dom0_mem=768 :
> 
> mmc dev 1
> ext2load mmc 1:3 0x42000000 zImage-6.6.0-xen-iommu-dma-on-xen
> ext2load mmc 1:3 0x51000000 xen-4.17-armhf-armmp-0x51004000.ub
> ext2load mmc 1:3 0x5ffec000 exynos5250-snow.dtb
> fdt addr 0x5ffec000
> fdt resize 1024
> fdt set /chosen \#address-cells <0x2>
> fdt set /chosen \#size-cells <0x2>
> fdt set /chosen xen,xen-bootargs "console=dtuart dtuart=serial0 dom0_mem=768M dom0_max_vcpus=2 bootscrub=0 vwfi=native sched=null"
> fdt mknod /chosen dom0
> fdt set /chosen/dom0 compatible  "xen,linux-zimage" "xen,multiboot-module" "multiboot,module"
> fdt set /chosen/dom0 reg <0x0 0x42000000 0x0 0x87C200 >
> fdt set /chosen xen,dom0-bootargs "console=tty1 root=/dev/mmcblk1p4 rw rootwait clk_ignore_unused --no-log"
> bootm 0x51000000 - 0x5ffec000
> 
> and I've rebooted the Chromebook using this command :
> 
> SMDK5250 # mmc dev 1
> SMDK5250 # ext2load mmc 1:3 0x50000000 bootxen.scr; source 0x50000000
> 
> This is the memory available on the machine after having booted the machine ready for xen :
> # free -m
>               total        used        free      shared  buff/cache   available
> Mem:             741         329         108           7         332         412
> Swap:              0           0           0
> 
> Thanks in advance for any support.
> 
> On Wed, Nov 15, 2023 at 8:41 PM Mario Marietto <marietto2008@gmail.com> wrote:
>       ---> So I plan to do some tests and see what DMA ops the other devices use if swiotlb-xen is disabled and also what DMA
>       ops the other devices use when Linux runs on the Chromebook on bare metal without Xen. If these tests show the problem
>       can be fixed by disabling swiotlb-xen with a Kconfig  or command line option, I will propose v2 to implement that as a
>       solution.
> 
> and this could bring you to the next level of our project. Try to install xen on different devices. At least it is my next
> project. I've already bought two arm64 phones where xen can be installed because there is a hack to overcome the bootloader /
> hypervisor protection mechanism. For sure I hope that you also want to buy them to work on this together. And don't worry about
> how much money they will cost you. I've bought them used and refurbished. Or you could buy only one,that I suggest could be the
> SM-A600G (Samsung Galaxy A6) with Exynos7870. Please start looking for it at a good price. 
> 
> On Wed, Nov 15, 2023 at 6:57 PM Chuck Zmudzinski <brchuckz@netscape.net> wrote:
>       On 11/14/2023 5:20 PM, Stefano Stabellini wrote:
>       > On Tue, 14 Nov 2023, Robin Murphy wrote:
>       >> On 11/11/2023 6:45 pm, Chuck Zmudzinski wrote:
>       >> > Enabling the new option, ARM_DMA_USE_IOMMU_XEN, fixes this error when
>       >> > attaching the Exynos mixer in Linux dom0 on Xen on the Chromebook Snow
>       >> > (and probably on other devices that use the Exynos mixer):
>       >> >
>       >> > [drm] Exynos DRM: using 14400000.fimd device for DMA mapping operations
>       >> > exynos-drm exynos-drm: bound 14400000.fimd (ops 0xc0d96354)
>       >> > exynos-mixer 14450000.mixer: [drm:exynos_drm_register_dma] *ERROR* Device
>       >> >                               14450000.mixer lacks support for IOMMU
>       >> > exynos-drm exynos-drm: failed to bind 14450000.mixer (ops 0xc0d97554): -22
>       >> > exynos-drm exynos-drm: adev bind failed: -22
>       >> > exynos-dp: probe of 145b0000.dp-controller failed with error -22
>       >> >
>       >> > Linux normally uses xen_swiotlb_dma_ops for DMA for all devices when
>       >> > xen_swiotlb is detected even when Xen exposes an IOMMU to Linux. Enabling
>       >> > the new config option allows devices such as the Exynos mixer to use the
>       >> > IOMMU instead of xen_swiotlb_dma_ops for DMA and this fixes the error.
>       >> >
>       >> > The new config option is not set by default because it is likely some
>       >> > devices that use IOMMU for DMA on Xen will cause DMA errors and memory
>       >> > corruption when Xen PV block and network drivers are in use on the system.
>       >> >
>       >> > Link:
>       >> > https://lore.kernel.org/xen-devel/acfab1c5-eed1-4930-8c70-8681e256c820@netscape.net/
>       >> >
>       >> > Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
>       >> > ---
>       >> > The reported error with the Exynos mixer is not fixed by default by adding
>       >> > a second patch to select the new option in the Kconfig definition for the
>       >> > Exynos mixer if EXYNOS_IOMMU and SWIOTLB_XEN are enabled because it is
>       >> > not certain setting the config option is suitable for all cases. So it is
>       >> > necessary to explicitly select the new config option during the config
>       >> > stage of the Linux kernel build to fix the reported error or similar
>       >> > errors that have the same cause of lack of support for IOMMU on Xen. This
>       >> > is necessary to avoid any regressions that might be caused by enabling the
>       >> > new option by default for the Exynos mixer.
>       >> >   arch/arm/mm/dma-mapping.c |  6 ++++++
>       >> >   drivers/xen/Kconfig       | 16 ++++++++++++++++
>       >> >   2 files changed, 22 insertions(+)
>       >> >
>       >> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>       >> > index 5409225b4abc..ca04fdf01be3 100644
>       >> > --- a/arch/arm/mm/dma-mapping.c
>       >> > +++ b/arch/arm/mm/dma-mapping.c
>       >> > @@ -1779,6 +1779,12 @@ void arch_setup_dma_ops(struct device *dev, u64
>       >> > dma_base, u64 size,
>       >> >    if (iommu)
>       >> >            arm_setup_iommu_dma_ops(dev, dma_base, size, iommu, coherent);
>       >> >   +#ifdef CONFIG_ARM_DMA_USE_IOMMU_XEN
>       >>
>       >> FWIW I don't think this really needs a config option - if Xen *has* made an
>       >> IOMMU available, then there isn't really much reason not to use it, and if for
>       >> some reason someone really didn't want to then they could simply disable the
>       >> IOMMU driver anyway.
>       >
>       > The fact that the Exynos IOMMU is exposed to Linux is a mistake. Xen
>       > doesn't recognize the Exynos IOMMU (it is not one of the IOMMUs Xen has
>       > a driver for) so it assigns the IOMMU to Dom0. It doesn't happen on
>       > purpose, it happens by accident. Certain things are going to break,
>       > specifically I am fairly certain PV drivers are going to break.
>       >
>       > If Xen recognized the Exynos IOMMU as an IOMMU it would probably hide it
>       > from Dom0. (Today Xen doesn't have a list of IOMMUs Xen recognizes but
>       > doesn't have a driver for.)
>       >
>       > I think it is OK for Chuck and others to play around with this
>       > configuration but I wouldn't add a new kconfig option to Linux to
>       > support it.
>       >
>       > If we do want a kconfig option, I would add a kconfig option or Linux
>       > command line option to enable/disable swiotlb-xen. Basically a way to
>       > force-enable or force-disable xen_swiotlb_detect(). That could be
>       > generally useful for debugging and would also solve the problem here as
>       > it could be used to force-disable swiotlb-xen. I would imagine that the
>       > end result is the same: the default ops (iommu_ops) are used.
> 
>       I will try this. It isn't exactly what I have tested until now because
>       in all my tests so far all the DMA capable devices on the Chromebook use
>       swioltlb-xen except for the two devices that need to use the Exynos IOMMU
>       to fix the error with the Exynos mixer.
> 
>       >
>       >
>       >
>       >> > +  if (dev->dma_ops == &iommu_ops) {
>       >> > +          dev->archdata.dma_ops_setup = true;
>       >>
>       >> The existing assignment is effectively unconditional by this point anyway, so
>       >> could probably just be moved earlier to save duplicating it (or perhaps just
>       >> make the xen_setup_dma_ops() call conditional instead to save the early return
>       >> as well).
>       >>
>       >> However, are the IOMMU DMA ops really compatible with Xen? The comments about
>       >> hypercalls and foreign memory in xen_arch_need_swiotlb() leave me concerned
>       >> that assuming non-coherent DMA to any old Dom0 page is OK might not actually
>       >> work in general :/
>       >
>       > Xen has (not yet upstreaming) support for nested IOMMU (Xen uses the
>       > IOMMU while also it exposes a virtual IOMMU to guests.) In those cases
>       > the iommu_ops should be compatible with Xen.
>       >
>       > swiotlb-xen is useful in cases where there is no IOMMU on the platform
>       > (or the IOMMU doesn't cover all DMA-capable devices) and Dom0 is 1:1
>       > mapped. See include/xen/arm/swiotlb-xen.h:xen_swiotlb_detect. If Dom0 is
>       > not 1:1 mapped swiotlb-xen doesn't work. If an IOMMU is present and
>       > covers all DMA-capable devices, then swiotlb-xen is superfluous.
> 
>       It seems that swiotlb-xen works on this Chromebook since all but two
>       of the DMA capable devices use it when configured with the Kconfig option
>       added here and it seems to work fine so I presume Dom0 is 1:1 mapped as
>       expected. It is possible that on this device, the IOMMU is only covering
>       the two devices that need to use the Exynos IOMMU in the tests I have done.
>       There are many other DMA capable devices that use swiotlb-xen DMA ops
>       on Xen, but I have not checked what DMA ops the other devices use when
>       Linux runs on the Chromebook on bare metal without Xen.
> 
>       So I plan to do some tests and see what DMA ops the other devices use if
>       swiotlb-xen is disabled and also what DMA ops the other devices use when
>       Linux runs on the Chromebook on bare metal without Xen. If these tests
>       show the problem can be fixed by disabling swiotlb-xen with a Kconfig  or
>       command line option, I will propose v2 to implement that as a solution.
> 
>       > This last case is the interesting case for virtual IOMMU and Linux usage of
>       > iommu_ops.
> 
> 
> 
> --
> Mario.
> 
> 
> 
> --
> Mario.
> 
> 
> 
> --
> Mario.
> 
> 
--8323329-171887673-1700176362=:773207--
