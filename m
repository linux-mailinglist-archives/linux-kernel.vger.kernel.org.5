Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792BC761890
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjGYMm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGYMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:42:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A9B0;
        Tue, 25 Jul 2023 05:42:25 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D301D5AA;
        Tue, 25 Jul 2023 14:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690288885;
        bh=SqM2HUkiO7n7nmt9WNDtTCUEd9QDVHxh+GOS5VByUsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Km+AoXR4QtahlTTZReqYIDRyocpPBIGkOoWVaWZrEWz/ugSb5/k89sxMd/zk6DmM/
         XPkk2fq0szLBB3lwt/JJjRiqtiU2X+Fj8E7LkWBcGP6BA+Wk1ugbcAEC1ZkkpvqCCh
         0zYgE7To7ssdQbR66UcW9s3Jqc0reFpaHBL/N3Cc=
Date:   Tue, 25 Jul 2023 15:42:30 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1] sh: boards: fix CEU buffer size passed to
 dma_declare_coherent_memory()
Message-ID: <20230725124230.GG31069@pendragon.ideasonboard.com>
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
 <20230724171229.GC11977@pendragon.ideasonboard.com>
 <31ad16fe8f1435805185ba8e889512ec181a867e.camel@physik.fu-berlin.de>
 <20230724174331.GD11977@pendragon.ideasonboard.com>
 <314b21abaade55ba55ccdd930f9fdf24028cadf0.camel@physik.fu-berlin.de>
 <20230725110942.GB31069@pendragon.ideasonboard.com>
 <1835ec88216c9be58f9bce518575f6348158b231.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1835ec88216c9be58f9bce518575f6348158b231.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:38:25PM +0200, John Paul Adrian Glaubitz wrote:
> On Tue, 2023-07-25 at 14:09 +0300, Laurent Pinchart wrote:
> > On Tue, Jul 25, 2023 at 07:50:56AM +0200, John Paul Adrian Glaubitz wrote:
> > > On Mon, 2023-07-24 at 20:43 +0300, Laurent Pinchart wrote:
> > > > > arch/sh is being maintained again, so it's save to keep these boards. At some point, we're
> > > > > going to convert the architecture to using Device Trees which should reduce the maintenance
> > > > > burden anyways.
> > > > 
> > > > Keeping the architecture is fine for newer systems, but is anyone really
> > > > maintaining the Renesas SH board ?
> > > 
> > > I own Renesas evaluation boards, including SH7785LCR-based and
> > > SH7724-based boards.
> > 
> > Will you have time to port them to DT, or would you rather focus on
> > J-core systems ? Do those boards still boot a mainline kernel ?
> > 
> > Dropping Renesas SH board files doesn't preclude anyone from moving them
> > to DT, all the information will remain in the git history. Unless you
> > plan to move to DT in a reasonably near future, I think dropping support
> > for the CEU at least, if not the whole board files, could be a good
> > option.
> 
> I'm not sure why you are trying to convince me to kill off support for SuperH
> boards. I have just stepped up maintenance of arch/sh to keep SuperH hardware
> supported in the kernel because I have been a maintainer of Debian's SuperH
> port for several years now.

If you're willing to maintain the SuperH support, that's nice :-) I'm
not concerned about the arch side, but I'd like to drop the non-DT
support in corresponding drivers in DRM and V4L2.

> There is also a small community of SuperH enthusiasts now hacking on the kernel
> which is coming together for discussion in #linux-sh on libera IRC.

-- 
Regards,

Laurent Pinchart
