Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10F6796E7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242613AbjIGBSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjIGBSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:18:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D825211B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 18:18:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68bec3a9bdbso363398b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 18:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694049514; x=1694654314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7u27T0bQj1X7QekOBppD1CzIesHT7gApB9/gnZSSYp0=;
        b=sJab0hyXibX8SGB/sEXxDAWjLzR4lls4wFsyNKjyo+FA4zwReNEjdbQUBcqCPOCn3l
         z2ckB7zv5vjOMrQ/z2nOrd+8aUsyYBfPZWTwLWiEsa67lBnVGvKn0ejjFK7DM6wFrAhl
         hWc7Ua/bqZsSKuY8jcGPz3SG4TFmhTZm01/+EP3WnuqI/QniwfA6oUjHJZI21CX3cB55
         tvEWY6KttNYtnk5kRrmLQZlN8qtmo3y4HkSji55PZPi78JTIKHAbZ4XGSHiglx0fKR1E
         TLz0HHnty6HmoT8PnEYulbZqZeY73pb8yWbUfw/92jkFJn3X533aDhaPvGqMe7weNgYO
         sCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694049514; x=1694654314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7u27T0bQj1X7QekOBppD1CzIesHT7gApB9/gnZSSYp0=;
        b=KW6VFFt0akylC/B6yIJecucJ2/pmsIrxmfj3xcuLqtv89kq8exENhUxhD48miqMk8I
         GvJEsaOrz0EU/Awzy+s3UqL+fsMEC6d60NBHl2BMKgF5ooNpCi3ju1e/WxP34958fA/L
         tK72xnEHbRrs1P02u5wy1prjdpb1PCL5DMscHyujIDq/PH7fA+o9+TGULsfB7XTAVZna
         rJUtFTRg1kQ3Dp56JlyG6unBBafSFVRUXqtZbTwvWw5DKZdPe3p+piifq2aVP9rOlEJ7
         7B0S4Ha/naAuRD1VRrd0IREn3jY+QM2RqePYXaQ9T6/aGo37ORgH3IERL0TE17ZmfTGo
         wuEA==
X-Gm-Message-State: AOJu0YydTZfm+lDtvRrE9AOzA3riadAHwtVd1kI7paauo0YgJoeWj5gl
        YpDRpUAokMJNZaR0me8pjURN
X-Google-Smtp-Source: AGHT+IHDyJS7/XnXMH6CR9TlIy/WCuIpyVOSQCL2gGQws/HrGH4V/9reg7NV0VAcFTfcb6xNJHJYUw==
X-Received: by 2002:a05:6a20:ce92:b0:14d:6309:fc90 with SMTP id if18-20020a056a20ce9200b0014d6309fc90mr16187594pzb.8.1694049514254;
        Wed, 06 Sep 2023 18:18:34 -0700 (PDT)
Received: from thinkpad ([120.138.12.139])
        by smtp.gmail.com with ESMTPSA id v25-20020a62a519000000b0068be348e35fsm11277982pfm.166.2023.09.06.18.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 18:18:33 -0700 (PDT)
Date:   Thu, 7 Sep 2023 06:48:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org, kw@linux.com,
        lpieralisi@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
Message-ID: <20230907011828.GA2865@thinkpad>
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 03:38:19PM +0800, Jiaxun Yang wrote:
> 
> 
> 在 2023/8/6 22:30, Huacai Chen 写道:
> > Hi, Jiaxun,
> > 
> > On Sun, Aug 6, 2023 at 10:20 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> > > 
> > > 
> > > 在 2023/7/25 14:10, Jiaxun Yang 写道:
> > > > This is a partial revert of commit 8b3517f88ff2 ("PCI:
> > > > loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
> > > > 
> > > > There are many MIPS based Loongson systems in wild that
> > > > shipped with firmware which does not set maximum MRRS properly.
> > > > 
> > > > Limiting MRRS to 256 for all as MIPS Loongson comes with higher
> > > > MRRS support is considered rare.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
> > > > Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> > > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Ping?
> > > I expect this patch to go through PCI fixes tree.
> > Can we do it like this by modifying the existing loongson_mrrs_quirk()?
> 
> Hmm, I'm not sure this will work, since loongson_mrrs_quirk only run on
> bridges
> but the old quirk should run on every single device.
> 

Why do you need to walk through every single device instead of just bridges?
I'm not the maintainer, but my suggestion is to go for Huacai Chen's solution.

This avoids iterating over bridges/devices two times.

Also, please rename firmware to BIOS, as firmware commonly represents the
software running on PCIe endpoint devices.

- Mani

> Thanks
> Jiaxun
> 
> > 
> > static void loongson_mrrs_quirk(struct pci_dev *pdev)
> > {
> >          /*
> >           * Some Loongson PCIe ports have h/w limitations of maximum read
> >           * request size. They can't handle anything larger than this. So
> >           * force this limit on any devices attached under these ports.
> >           */
> >          struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> > 
> > #ifdef CONFIG_MIPS
> >          set_pcie_ports_to_mrrs_256_to_emulate_the_firmware_behavior();
> > #endif
> > 
> >          bridge->no_inc_mrrs = 1;
> > }
> > 
> > > Thanks
> > > - Jiaxun
> > > 
> > > > ---
> > > > v2: Rename quirk name to: loongson_old_mrrs_quirk
> > > > ---
> > > >    drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++
> > > >    1 file changed, 38 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > > > index fe0f732f6e43..d0f68b102d10 100644
> > > > --- a/drivers/pci/controller/pci-loongson.c
> > > > +++ b/drivers/pci/controller/pci-loongson.c
> > > > @@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > > >    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > > >                        DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
> > > > 
> > > > +#ifdef CONFIG_MIPS
> > > > +static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
> > > > +{
> > > > +     struct pci_bus *bus = pdev->bus;
> > > > +     struct pci_dev *bridge;
> > > > +     static const struct pci_device_id bridge_devids[] = {
> > > > +             { PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> > > > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> > > > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> > > > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> > > > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> > > > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> > > > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> > > > +             { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
> > > > +             { 0, },
> > > > +     };
> > > > +
> > > > +     /* look for the matching bridge */
> > > > +     while (!pci_is_root_bus(bus)) {
> > > > +             bridge = bus->self;
> > > > +             bus = bus->parent;
> > > > +             /*
> > > > +              * There are still some wild MIPS Loongson firmware won't
> > > > +              * set MRRS properly. Limiting MRRS to 256 as MIPS Loongson
> > > > +              * comes with higher MRRS support is considered rare.
> > > > +              */
> > > > +             if (pci_match_id(bridge_devids, bridge)) {
> > > > +                     if (pcie_get_readrq(pdev) > 256) {
> > > > +                             pci_info(pdev, "limiting MRRS to 256\n");
> > > > +                             pcie_set_readrq(pdev, 256);
> > > > +                     }
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +}
> > > > +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_old_mrrs_quirk);
> > > > +#endif
> > > > +
> > > >    static void loongson_pci_pin_quirk(struct pci_dev *pdev)
> > > >    {
> > > >        pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
> 

-- 
மணிவண்ணன் சதாசிவம்
