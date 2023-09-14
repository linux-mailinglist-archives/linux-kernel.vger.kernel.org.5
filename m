Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283AE7A0B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbjINRCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjINRCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:02:52 -0400
Received: from mailhost.m5p.com (mailhost.m5p.com [74.104.188.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59601BD9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:02:48 -0700 (PDT)
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:1f07:15ff:0:0:0:f7])
        by mailhost.m5p.com (8.17.1/8.15.2) with ESMTPS id 38EH252b038701
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 14 Sep 2023 13:02:11 -0400 (EDT)
        (envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
        by m5p.com (8.17.1/8.15.2/Submit) id 38EH25Ba038700;
        Thu, 14 Sep 2023 10:02:05 -0700 (PDT)
        (envelope-from ehem)
Date:   Thu, 14 Sep 2023 10:02:05 -0700
From:   Elliott Mitchell <ehem+xen@m5p.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        smita.koralahallichannabasappa@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, rric@kernel.org,
        james.morse@arm.com
Subject: Re: [PATCH] Revert "EDAC/mce_amd: Do not load edac_mce_amd module on
 guests"
Message-ID: <ZQM8jRx8uKEbEo00@mattapan.m5p.com>
References: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
 <ZPqQEHXgmak1LMNh@mattapan.m5p.com>
 <20230908035911.GAZPqcD/EjfKZ0ISrZ@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908035911.GAZPqcD/EjfKZ0ISrZ@fat_crate.local>
X-Spam-Status: No, score=0.4 required=10.0 tests=KHOP_HELO_FCRDNS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on mattapan.m5p.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 05:59:11AM +0200, Borislav Petkov wrote:
> On Thu, Sep 07, 2023 at 08:08:00PM -0700, Elliott Mitchell wrote:
> > This reverts commit 767f4b620edadac579c9b8b6660761d4285fa6f9.
> > 
> > There are at least 3 valid reasons why a VM may see MCE events/registers.
> 
> Hmm, so they all read like a bunch of handwaving to me, with those
> probable hypothetical "may" formulations.

Indeed.  At what point is the lack of information and response long
enough to simply commit a revert due to those lacks?

Even with the commit message having been rewritten and the link to:
https://lkml.kernel.org/r/20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com
added, this still reads as roughly:

"A hypothetical bug on a hypothetivisor"

I rather suspect a genuine issue was observed, but with absolutely no
detail this is useless.  I can make some guesses, but those guesses
relation to reality is dubious.


On Wed, Sep 13, 2023 at 03:50:12PM +0000, Luck, Tony wrote:
> > Also, please note that the EDAC modules don't handle MCE events
> > directly. They act on information passed from the MCE subsystem.
> >
> > Furthermore, there are other EDAC modules that have the same !hypervisor
> > check, so why change only this one?
> 
> The older Intel EDAC drivers translated system physical addresses to DIMM
> addresses by digging around in the CONFIG and MMIO space of the memory
> controller devices. It would seem unwise for a VMM to give access to those
> addresses to a guest (in general ... perhaps OK for a Xen style "DOM0" guest that is
> handling many tasks for the VMM?).

Which seems oddly similar to:
"the Linux kernel may be handling adminstrative duties/hardware
for a hypervisor.  In this case, the events need to be processed and
potentially passed back through the hypervisor."


On Wed, Sep 13, 2023 at 12:21:50PM -0400, Yazen Ghannam wrote:
> The MCE decoder may access some newer MCA registers, or request info
> from the MCE subsystem. But this is for informational error decoding. It
> won't support any actions that a guest could take.
> 
> The AMD64 EDAC module reads system-specific memory controller registers
> through non-architectural interfaces. So also unwise or not useful for a
> guest to access.

This could be emulated.  With it not being officially specified the
emulation may not be too accurate, but it is possible.  Admittedly VMware
may have abandoned this level of perfect emulation accuracy, but one
could do it.  Which would be "full virtualization of MCE events."


On Wed, Sep 13, 2023 at 10:36:50AM -0400, Yazen Ghannam wrote:
> Furthermore, there are other EDAC modules that have the same !hypervisor
> check, so why change only this one?

Indeed.  Those will also need similar treatment, but that wouldn't be a
revert of 767f4b620eda.  I found 767f4b620eda in the process of looking
for the correct hook point.



There are at least two, and possibly more, points of view with regards
to MCE and virtualization.  I keep noticing most implementers are
strictly thinking of perfect, full virtualization of hardware, and
missing what is actually desired.

Full virtualization is where you are renting an actual physical slice of
actual hardware, proper virtualization of CEs and UEs is desireable.

In reality most clients merely want to rent the processing power the
hardware provides and not deal with actually owning the hardware.  To
them, CEs are an annoyance since they clutter logs and they're not
something they're in a position to deal with.  Instead the owner of the
hardware wants the CEs so they can monitor hardware health.

What you want depends on your SLAs, but the most prominent authors keep
missing that many clients (VM owners) don't actually want to deal with
CEs.  A SLA could also state a single UE means discarding current VM
state and rolling back to the last known good checkpoint.


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445


