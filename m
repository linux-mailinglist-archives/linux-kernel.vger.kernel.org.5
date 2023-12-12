Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5980F8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377508AbjLLUzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377499AbjLLUyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:54:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7E5139
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:54:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2208CC433C7;
        Tue, 12 Dec 2023 20:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702414444;
        bh=CMc2U1RL4dCSVqNTUqsM8wGc5GpFpsAGlc/XWtzqWiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=McLyV3frz3r77SzrITmb9EhIUetv0qw5/TBS/e/BdS7RTFoEer1J7WC5hil6yNQCN
         b11A82wIK07b4X8FKX6/R99PJxuhlAaAX+0iUw0Na9xJUSzoyRdjTJtY6oUT7nt54n
         oJSMKKSmw7iEItkNj42EEKY1Us0nJmjkv0S7A1NhLbx59wTxEN7pOOLGvDRYd6dqZP
         mRJr9UXgycp30IV0XpG/4/6twK/IJ8r4lF82rVVclcGNfZ6Xzqe2g/OmzBtNbDdG0k
         f9muIEZV76EbRf1vxLx2UtcfZRUXV/78/hcOPCvWouYWlBBlgOYpfGhkp3X980RRjT
         mqiHe1/EcXEsQ==
Date:   Tue, 12 Dec 2023 14:54:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Sanath S <Sanath.S@amd.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
Message-ID: <20231212205402.GA1020129@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd45ee8-364e-495f-bb62-3871d5ca1d80@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:48:41PM -0600, Mario Limonciello wrote:
> On 12/8/2023 16:44, Bjorn Helgaas wrote:
> > On Fri, Dec 08, 2023 at 04:29:42PM -0600, Mario Limonciello wrote:
> > > On 12/8/2023 16:24, Bjorn Helgaas wrote:
> > > > On Wed, Aug 16, 2023 at 10:49:23AM +0530, Sanath S wrote:
> > > > > In the case of Thunderbolt, it contains a PCIe switch and one or
> > > > > more hotplug-capable PCIe downstream ports where the daisy chain
> > > > > can be extended.
> > > > > 
> > > > > Currently when a Thunderbolt Dock is plugged in during S5/Reboot,
> > > > > System BIOS allocates a very minimal number of buses for bridges and
> > > > > hot-plug capable PCIe downstream ports to enumerate the dock during
> > > > > boot. Because of this, we run out of bus space pretty quickly when
> > > > > more PCIe devices are attached to hotplug downstream ports in order
> > > > > to extend the chain.
> > > > > 
> > > > > Before:
> > > > >              +-04.0
> > > > >              +-04.1-[63-c1]----00.0-[64-69]--+-00.0-[65]--
> > > > >              |                               +-01.0-[66]--
> > > > >              |                               +-02.0-[67]--
> > > > >              |                               +-03.0-[68]--
> > > > >              |                               \-04.0-[69]--
> > > > >              +-08.0
> > > > 
> > > > Looks like a clear issue here because there's no other use for
> > > > buses 70-c1.  But what would happen if there were more
> > > > hotplug-capable downstream ports, e.g., assume one at 08.1
> > > > leading to [bus c2-c7]?
> > > > 
> > > > The 04.1 bridge has a lot of space, but 08.1 has very little.
> > > > With this patch, would we distribute it more evenly across
> > > > 04.1 and 08.1?  If not, I think we'll just have the same
> > > > problem when somebody plugs in a similar hierarchy at 08.1.
> > > > 
> > > > > In case of a thunderbolt capable bridge, reconfigure the
> > > > > buses allocated by BIOS to the maximum available buses. So
> > > > > that the hot-plug bridges gets maximum buses and chain can
> > > > > be extended to accommodate more PCIe devices.  This fix is
> > > > > necessary for all the PCIe downstream ports where the daisy
> > > > > chain can be extended.
> > > > > 
> > > > > After:
> > > > >              +-04.0
> > > > >              +-04.1-[63-c1]----00.0-[64-c1]--+-00.0-[65]--
> > > > >              |                               +-01.0-[66-84]--
> > > > >              |                               +-02.0-[85-a3]--
> > > > >              |                               +-03.0-[a4-c0]--
> > > > >              |                               \-04.0-[c1]--
> > > > >              +-08.0
> > > > 
> > > > This doesn't look like anything specific to Thunderbolt; it's just
> > > > that we don't do a good job of reassigning bus numbers in general,
> > > > right?  We shouldn't just punt and say "BIOS should have done
> > > > something" because not all machines *have* BIOS, and the OS can
> > > > reconfigure bus numbers as needed.  The patch certainly isn't
> > > > Thunderbolt-specific.
> > > 
> > >  From the discussions Sanath and I have been in related to this issue
> > > the BIOS is pretty static with it's initialization under the
> > > presumption that the OS will rebalance things if necessary.
> > > ...
> > 
> > > For this particular issue it's being approached a different way.
> > > 
> > > Windows never rebalances things but doesn't suffer from this issue.
> > > That's because Windows actually does a "Downstream port reset" when
> > > it encounters a USB4 router.
> > > 
> > > Sanath posted a quirk that aligned this behavior when encountering
> > > an AMD USB4 router, but as part of the discussion I suggested that
> > > we do it for everyone.
> > > 
> > > https://lore.kernel.org/linux-usb/20231123065739.GC1074920@black.fi.intel.com/
> > > 
> > > So Sanath has a new patch that does this that is under testing right
> > > now and will be posted soon.
> > 
> > Hmm, ok.  I don't know what a "downstream port reset" does or how it
> > resolves the bus number allocation issue, but I'm happy if you have a
> > fix that doesn't need PCI core changes.
> 
> The issue is specifically with resources that were assigned with BIOS in
> this "static case".  The downstream port reset ends up resetting the
> topology and thus the resources get assigned by Linux instead and will
> be better balanced for more devices to be daisy chained.

It sounds like the downstream port reset maybe just resets the bridge
secondary/subordinate bus numbers, which forces Linux to reassign
them?  But Linux isn't smart enough to proactively reassign them?  If
so, the reset sounds a little like a band-aid, not a real fix, but I'm
guessing nobody is signing up to rework that PCI core reassignment
code ;)

Bjorn
