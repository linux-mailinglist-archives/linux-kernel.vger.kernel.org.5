Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20576166F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjGYLjW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 07:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjGYLjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:39:15 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563011BF5;
        Tue, 25 Jul 2023 04:38:47 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qOGN1-0045DE-4s; Tue, 25 Jul 2023 13:38:27 +0200
Received: from p5b13a085.dip0.t-ipconnect.de ([91.19.160.133] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qOGN0-000XJ6-T1; Tue, 25 Jul 2023 13:38:27 +0200
Message-ID: <1835ec88216c9be58f9bce518575f6348158b231.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v1] sh: boards: fix CEU buffer size passed to
 dma_declare_coherent_memory()
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Date:   Tue, 25 Jul 2023 13:38:25 +0200
In-Reply-To: <20230725110942.GB31069@pendragon.ideasonboard.com>
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
         <20230724171229.GC11977@pendragon.ideasonboard.com>
         <31ad16fe8f1435805185ba8e889512ec181a867e.camel@physik.fu-berlin.de>
         <20230724174331.GD11977@pendragon.ideasonboard.com>
         <314b21abaade55ba55ccdd930f9fdf24028cadf0.camel@physik.fu-berlin.de>
         <20230725110942.GB31069@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.133
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 14:09 +0300, Laurent Pinchart wrote:
> On Tue, Jul 25, 2023 at 07:50:56AM +0200, John Paul Adrian Glaubitz wrote:
> > On Mon, 2023-07-24 at 20:43 +0300, Laurent Pinchart wrote:
> > > > arch/sh is being maintained again, so it's save to keep these boards. At some point, we're
> > > > going to convert the architecture to using Device Trees which should reduce the maintenance
> > > > burden anyways.
> > > 
> > > Keeping the architecture is fine for newer systems, but is anyone really
> > > maintaining the Renesas SH board ?
> > 
> > I own Renesas evaluation boards, including SH7785LCR-based and
> > SH7724-based boards.
> 
> Will you have time to port them to DT, or would you rather focus on
> J-core systems ? Do those boards still boot a mainline kernel ?
> 
> Dropping Renesas SH board files doesn't preclude anyone from moving them
> to DT, all the information will remain in the git history. Unless you
> plan to move to DT in a reasonably near future, I think dropping support
> for the CEU at least, if not the whole board files, could be a good
> option.

I'm not sure why you are trying to convince me to kill off support for SuperH
boards. I have just stepped up maintenance of arch/sh to keep SuperH hardware
supported in the kernel because I have been a maintainer of Debian's SuperH
port for several years now.

There is also a small community of SuperH enthusiasts now hacking on the kernel
which is coming together for discussion in #linux-sh on libera IRC.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
