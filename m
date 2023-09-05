Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99D9792BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbjIEQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354165AbjIEKAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C3CB4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76CB2601D4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FB6C433C8;
        Tue,  5 Sep 2023 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693908020;
        bh=UisXsBbG/7SOBMzTUSO9ECmJ9xjtD0EjCsd2Conv+no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjbGDCdA8SK8NuSqJ1rFD8pgktW409yLTH9H+18wIA2UntWdLSfdCahc9vscoOO1x
         MJPleTUWugmKqaOBdfyIf9XymzY7Zh/f+M/zot0icqhoSoaMRTXsE34f23E9GVhSD1
         OjhfOf9Iy6gpGY+vEy5Gt25uAfM2kmJvlddpoMUCFR4b+kNhSyqaD3XEaHtB0Ds8en
         40zqD0NXhC54qbLRNl4io8oqSiYpuJpjOW4LHfzjr6BmMrMG0fkGIcOyM798G7mn39
         fKRq5ahwAPC3MLeE82S5/WMoGxFhl8VtmjkX/ZuU7jyfwlEYj3DHL5AxTCiT0BINYf
         6DCQ8qJfyAV1g==
Date:   Tue, 5 Sep 2023 12:00:16 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Fang Xiang <fangxiang3@xiaomi.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3-its: Mark GIC as non-shareable by OF
 property
Message-ID: <ZPb8MPNa4KWitO+U@lpieralisi>
References: <20230904020431.27057-1-fangxiang3@xiaomi.com>
 <86sf7ue6yk.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86sf7ue6yk.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 08:24:51AM +0100, Marc Zyngier wrote:
> On Mon, 04 Sep 2023 03:04:31 +0100,
> Fang Xiang <fangxiang3@xiaomi.com> wrote:
> > 
> > GIC600/GIC700 integration in some platforms does not support the
> > sharability feature. Commit a8707f553884 ("irqchip/gic-v3: Add
> > Rockchip 3588001 erratum workaround") added flags to indicate the
> > integration design error, but the quirk is just applied with
> > RK3588/RK3588S and GIC600.
> > 
> > The property are named "force-non-shareable" to be vendor agnostic,
> > since apparently similar integration design errors exist in other
> > platforms and they can reuse the same property in their GIC ITS
> > device-node.
> 
> No. If this is a problem, this must be dealt with in the following
> manner:
> 
> - a standard property, which is documented in the ITS binding
> - an equivalent ACPI property, equally documented
> - separate instances of the property for the core GIC and the ITS
>   (because the RDs are *not* defined at the ITS level)

I am about to post a patchset to start discussion on how to "fix"
these designs (in DT - ACPI will follow the approach we agree on),
let's take it from there.

Thanks,
Lorenzo

> > Signed-off-by: Fang Xiang <fangxiang3@xiaomi.com>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index e0c2b10d154d..2e92eac1e5f3 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -5055,6 +5055,16 @@ static int __init its_compute_its_list_map(struct resource *res,
> >         return its_number;
> >  }
> > 
> > +static void its_of_update_shareability(struct its_node *its)
> > +{
> > +       if (!fwnode_property_present(its->fwnode_handle,
> > +                               "force-non-shareable"))
> > +               return;
> > +
> > +       its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
> > +       gic_rdists->flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> 
> There is no reason why we should conflate the two, other than your
> implementation being monolithic.
> 
> > +}
> > +
> >  static int __init its_probe_one(struct resource *res,
> >                                 struct fwnode_handle *handle, int numa_node)
> >  {
> > @@ -5130,6 +5140,7 @@ static int __init its_probe_one(struct resource *res,
> >         its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
> > 
> >         its_enable_quirks(its);
> > +       its_of_update_shareability(its);
> 
> As mentioned above, we need a mechanism that works across firmware implementations.
> 
> > 
> >         err = its_alloc_tables(its);
> >         if (err)
> > --
> > 2.34.1
> > 
> > #/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
> \
> 
> Please fix your email setup.
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
