Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1386782B09
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjHUN4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjHUN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:56:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF32BC;
        Mon, 21 Aug 2023 06:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A2C6350E;
        Mon, 21 Aug 2023 13:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DBBC433C8;
        Mon, 21 Aug 2023 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692626167;
        bh=jel4fUf+0JYpfPTyqRyltlE7za2egmMDujCQYpha1Rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isOVBb/EjluIBUNJz/3Vu1qAN9i7mK0l9u1a3ewlOiKTd+vV0oKG3M2Kfm6EXdihP
         SgEw9B8nAi+VrvJOXfUAFxDXKutU+yGBwxHc+KLNtizQIOX1qCo5gD8ktWfwGfgTiT
         mT2B0rmOujVAZbUY1PxSxoLqpG3XZIIVtdhZzPmjVS4qBCfJ2mhxgG1q8Fvcot9nD+
         6aN9F68sJkoIruyRmzXGsKH9Et18zZ8NM7DyJuHyIecSuZjXbxKzM34eOwIr89I7x8
         0BBBfy5eqqU3P7YPVpQrHBhKgaHddWYqWyBSnkeG++GSPxVHK6sXoiVW9xa2vYkY56
         davLelnP62x2Q==
Date:   Mon, 21 Aug 2023 15:56:02 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
Message-ID: <th5mtwmzkugj74uuxrrwbsrncwpfrvzovfsqqet3tk6lrsvlcn@vm2rqd26l5vh>
References: <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm>
 <ZND/8wd67YbGs8d5@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308141128260.14207@cbobk.fhfr.pm>
 <ZOMcHQc8Em/s6C+y@smile.fi.intel.com>
 <ez2oewpi3yeaiejrvbe433ude75pgm3k3s5sh5gnn7pvnzm7b4@ajuopfgwocft>
 <ZOMvpmoWLCgcAyJR@smile.fi.intel.com>
 <ZOMv4VB0bZpupNlN@smile.fi.intel.com>
 <CAO-hwJ+Pa0yMV5taEc9+RXEWJzkotpyj4gz2qftyLV4G73F-mg@mail.gmail.com>
 <CAO-hwJ+EaFJEmuBYKRLmy-=xtOu96L=c5=zM=hS=0Ju_zGV=oA@mail.gmail.com>
 <ZOM+awN2CU+V1R1H@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOM+awN2CU+V1R1H@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 21 2023, Andy Shevchenko wrote:
> On Mon, Aug 21, 2023 at 12:27:22PM +0200, Benjamin Tissoires wrote:
> > On Mon, Aug 21, 2023 at 12:19 PM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > > On Mon, Aug 21, 2023 at 11:35 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Aug 21, 2023 at 12:34:30PM +0300, Andy Shevchenko wrote:
> > > > > On Mon, Aug 21, 2023 at 10:51:04AM +0200, Benjamin Tissoires wrote:
> > > > > > On Aug 21 2023, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > Long story short, I'm not able to test it right now (and I got quite
> > > > > > some backlog as you can imagine). IIRC the code was fine, so I think we
> > > > > > can just take the series as is, and work on the quirks (if any) later.
> > > > >
> > > > > Thank you!
> > > > >
> > > > > The thing that might be broken is interrupts handling. If that works,
> > > > > I'm pretty confident with the rest.
> > > >
> > > > I.o.w. first 5 patches to test is already 98% of guarantee that everything
> > > > is fine.
> > >
> > > Actually I applied you series locally, and applied Danny's patches on
> > > top, and I could run your series in qemu with the cp2112 as USB
> > > passthrough.
> > >
> > > Everything is working fine, so I can take this one just now.
> > 
> > I've pushed the series to for-6.6/cp2112, but for some reasons, b4
> > doesn't seem to believe the series is the one you submitted.
> > 
> > Would you mind double checking on your side if everything is good?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=for-6.6/cp2112
> 
> Everything is fine as far as I can tell.

Great, thanks for double checking.

Cheers,
Benjamin

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
