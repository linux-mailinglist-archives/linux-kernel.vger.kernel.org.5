Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6E976D55E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjHBRcA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjHBRbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:31:40 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D5A3AA6;
        Wed,  2 Aug 2023 10:29:21 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qRFe6-002TUY-K1; Wed, 02 Aug 2023 19:28:26 +0200
Received: from p5b13a085.dip0.t-ipconnect.de ([91.19.160.133] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qRFe6-000eVY-Bd; Wed, 02 Aug 2023 19:28:26 +0200
Message-ID: <2d82e0312f7d667e36238938a3cb13c95903033e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v8 11/19] sh: add <asm-generic/io.h> including
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Date:   Wed, 02 Aug 2023 19:28:24 +0200
In-Reply-To: <39c79971-12fc-41fc-8cae-b2a0089ed034@app.fastmail.com>
References: <20230706154520.11257-1-bhe@redhat.com>
         <20230706154520.11257-12-bhe@redhat.com>
         <CAMuHMdWmv-Jdvi7a04JGXuA2QARj8c8mpUvY7TOcetPkG4pW7A@mail.gmail.com>
         <0f771b11539d5a3871691af901315ee2034b577c.camel@physik.fu-berlin.de>
         <09094baf-dadf-4bce-9f63-f2a1f255f9a8@app.fastmail.com>
         <c48f6f3c742eaf35e35882064ccf4ed07d4e63fe.camel@physik.fu-berlin.de>
         <39c79971-12fc-41fc-8cae-b2a0089ed034@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.133
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd!

On Wed, 2023-08-02 at 16:19 +0200, Arnd Bergmann wrote:
> On Tue, Aug 1, 2023, at 21:21, John Paul Adrian Glaubitz wrote:
> 
> > > I think ideally all the I/O port stuff in arch/sh/ could just be
> > > removed after the conversion to asm-generic/io.h, but the
> > > microdev_ioport_map() function oddity gets in the way of that,
> > > unless someone wants to clean up that platform. As far as I
> > > can tell, the ethernet, display, USB and PCI devices on it already
> > > broke at some point (afbb9d8d5266b, 46bc85872040a), so it might
> > > be easier to remove it entirely.
> > 
> > I don't have this particular hardware, so I cannot comment on this.
> 
> Sure, as I explained, I'm pretty sure that nobody has
> tried to boot this hardware in a long time, so I did not
> expect you to have one.
> 
> I'll try to follow up with a patch to remove the platform
> later on, based on the explations above.

There is no need to remove any platforms now as we're working on converting
arch/sh to device trees anyway and will eventually get rid of all the board-
specific code during that step.

> > > Having the series go into linux-next sounds appropriate like this,
> > > the entire purpose of that is to find such bugs and Andrew can jus
> > > fold the fixup into the broken patch. 
> > > 
> > > Let me know if you prefer the simple version with the extra
> > > #defines or if we should just use the generic inb/outb implementation
> > > immediately and drop microdev in a separate patch.
> > 
> > Please go ahead with the simple version.
> 
> Done,

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
