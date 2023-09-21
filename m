Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF847A9939
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjIUSML convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 14:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjIUSLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:11:19 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2E6880B7;
        Thu, 21 Sep 2023 10:38:50 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qjENN-003VFB-V1; Thu, 21 Sep 2023 09:45:29 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qjENN-002Iwn-NI; Thu, 21 Sep 2023 09:45:29 +0200
Message-ID: <f61e1f218ee4d5a87121c0e5ee0d8694364ea2dd.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Sep 2023 09:45:29 +0200
In-Reply-To: <d2f5cdc1-4bff-4f1d-a7b2-38eee6a6a86d@app.fastmail.com>
References: <20230802184849.1019466-1-arnd@kernel.org>
         <20230802184849.1019466-4-arnd@kernel.org>
         <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
         <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com>
         <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
         <190041c8-2d99-4bc3-adc3-6fbe902c1265@app.fastmail.com>
         <CAMuHMdXyLHitBWOMp74cqtJbSs6q_4sPOEee+x72tE-E2G-KWg@mail.gmail.com>
         <d2f5cdc1-4bff-4f1d-a7b2-38eee6a6a86d@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, 2023-09-15 at 17:49 +0200, Arnd Bergmann wrote:
> On Fri, Sep 15, 2023, at 17:41, Geert Uytterhoeven wrote:
> > On Wed, Sep 13, 2023 at 4:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Sep 13, 2023, at 16:13, Geert Uytterhoeven wrote:
> > > 
> > > Right, it looks like the GENERIC_IOMAP part if gone from that
> > > series, and I also see that the PCI host bridge does not actually
> > 
> > No, 02/30 still enables it.
> 
> Ok.
> 
> > > map the port I/O window. That's usually fine because very few
> > > drivers actually need it, and it also means that there should be
> > > no need for GENERIC_IOMAP or the simpler alternative.
> > > 
> > > The first version probably only did it accidentally, which is a
> > > common mistake, and I think the ones for hexagon, m68k, and
> > > mips can probably be removed as well with some simplifiations.
> > 
> > When not selecting GENERIC_IOMAP in v2, the build fails with:
> > 
> > sh4-linux-gnu-ld: lib/devres.o: in function `pcim_iomap_release':
> > devres.c:(.text+0x234): undefined reference to `pci_iounmap'
> 
> Odd, that one is provided based on CONFIG_GENERIC_PCI_IOMAP
> and should be provided by common code, despite the similar
> naming this is unrelated to CONFIG_GENERIC_IOMAP.

So, what would be the suggestion now to move forward? Shall I include this
series for 6.7 or better wait until after Yoshinori's series to convert
to device tree has been merged?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
