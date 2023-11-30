Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217177FEC23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjK3JrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3JrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:47:06 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22271D50;
        Thu, 30 Nov 2023 01:47:12 -0800 (PST)
Received: from pyrite.rasen.tech (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 38D768C1;
        Thu, 30 Nov 2023 10:46:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701337593;
        bh=A+ZecSE4hjPnaI3Hh8yXuuX/lFO1rYZCXT1nhjdZtw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwfEEZ7SpVU/OdE+/rfMspmM71hg225W3lQ8u4HuQL39vM0NYE9zqAUquXppYJ1be
         NY+hif7gIyqf+RhFCLYNnztvFeWmifdDfk4e/FH1t+ghvgkntskwB56Ce1ahGV9PxW
         heNlfR1N9ctz0WpO6qAZoYifdZJgc1k87IxCr3QI=
Date:   Thu, 30 Nov 2023 18:47:00 +0900
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: rkisp1: debug: Add register dump for IS
Message-ID: <ZWhaFL48cgdHsOPN@pyrite.rasen.tech>
References: <20231129092956.250129-1-paul.elder@ideasonboard.com>
 <20231129092956.250129-3-paul.elder@ideasonboard.com>
 <170128834260.3048548.11979514587961676400@ping.linuxembedded.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170128834260.3048548.11979514587961676400@ping.linuxembedded.co.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 08:05:42PM +0000, Kieran Bingham wrote:
> Quoting Paul Elder (2023-11-29 09:29:55)
> > Add register dump for the image stabilizer module to debugfs.
> > 
> 
> Is the Image Stabilizer on all variants of the ISP?
> 
> I.e. is it valid register space on the RK3399 implementation?

Yes, it is.

> 
> If so then:
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > ---
> >  .../platform/rockchip/rkisp1/rkisp1-debug.c    | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > index 71df3dc95e6f..f66b9754472e 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > @@ -139,6 +139,21 @@ static int rkisp1_debug_dump_mi_mp_show(struct seq_file *m, void *p)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_mi_mp);
> >  
> > +static int rkisp1_debug_dump_is_show(struct seq_file *m, void *p)
> > +{
> > +       static const struct rkisp1_debug_register registers[] = {
> > +               RKISP1_DEBUG_SHD_REG(ISP_IS_H_OFFS),
> > +               RKISP1_DEBUG_SHD_REG(ISP_IS_V_OFFS),
> > +               RKISP1_DEBUG_SHD_REG(ISP_IS_H_SIZE),
> > +               RKISP1_DEBUG_SHD_REG(ISP_IS_V_SIZE),
> 
> I expect so as you haven't added the register macros in this series so
> they must already be there ...

Yep :)


Paul

> 
> 
> > +               { /* Sentinel */ },
> > +       };
> > +       struct rkisp1_device *rkisp1 = m->private;
> > +
> > +       return rkisp1_debug_dump_regs(rkisp1, m, 0, registers);
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_is);
> > +
> >  #define RKISP1_DEBUG_DATA_COUNT_BINS   32
> >  #define RKISP1_DEBUG_DATA_COUNT_STEP   (4096 / RKISP1_DEBUG_DATA_COUNT_BINS)
> >  
> > @@ -235,6 +250,9 @@ void rkisp1_debug_init(struct rkisp1_device *rkisp1)
> >  
> >         debugfs_create_file("mi_mp", 0444, regs_dir, rkisp1,
> >                             &rkisp1_debug_dump_mi_mp_fops);
> > +
> > +       debugfs_create_file("is", 0444, regs_dir, rkisp1,
> > +                           &rkisp1_debug_dump_is_fops);
> >  }
> >  
> >  void rkisp1_debug_cleanup(struct rkisp1_device *rkisp1)
> > -- 
> > 2.39.2
> >
