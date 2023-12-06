Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485BA807C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379691AbjLFXEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379801AbjLFXE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:04:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930351730
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:04:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3F3C433C7;
        Wed,  6 Dec 2023 23:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701903860;
        bh=LEvFvYjL9I1XGOhYY//WRx9a8Ko8atL6psfa0q6AHSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vQHPkvqZkT29dSrhEYJIQF2Z80fyRW9u1Mniww+y/eeaQgrF7XYqrhvA6qEIfIyk+
         MQ0OzrmHyyBV5+PDXq6Lz3umXqEfb5DT6NHqH+c+dfrF/ZJbnvNri+JxlxcEoK7nxn
         bEI6QKZOXK/XH1ArsJKJG3vn2h3Ym/A0+vafS+WTU6ftlXUQN9PSyBb+9qzfk9xODU
         kvIxSsj2sje9p3v9uLp5yYjEceCAxc8BE35tomUa4rQofu+1QWuKPZDPmiBAm8v+tP
         Gee9sZcuy1zQiCKCtOLZwHcIP2zkwXcSmhVYKYCLveKLXAtI+nWVQOBol7YtZCxGB6
         VylZsaR2aaS1A==
Date:   Wed, 6 Dec 2023 17:04:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Call PCI ACPI _DSM with consistent revision
 argument
Message-ID: <20231206230419.GA733407@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73628abc-dbb8-4dac-b83d-a78462b327b8@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 02:12:54PM -0600, Mario Limonciello wrote:
> On 11/30/2023 16:29, Bjorn Helgaas wrote:
> > On Fri, Nov 10, 2023 at 12:55:01PM -0600, Mario Limonciello wrote:
> > > The PCI ACPI _DSM is called across multiple places in the PCI core
> > > with different arguments for the revision.
> > > 
> > > The PCI firmware specification specifies that this is an incorrect
> > > behavior.
> > > "OSPM must invoke all Functions other than Function 0 with the
> > >   same Revision ID value"
> > 
> > This patch passes the same or a larger Revision ID than before, so
> > everything should work the same because the spec requires backwards
> > compatibility.  But it's conceivable that it could break on firmware
> > that does the revision check incorrectly.
> > 
> > Is this fixing a problem other than the spec compliance issue?
> 
> It was just a spec compliance issue I noticed when implementing the other
> two patches.
> 
> > I agree the PCI FW spec says this.  It was added in r3.3 by the ECN at
> > https://members.pcisig.com/wg/Firmware/document/previewpdf/13988, but
> > I don't quite understand that ECN.
> > 
> > ACPI r6.5, sec 9.1.1, doesn't include the "must invoke all Functions
> > with same Revision ID" language, and the ASL example there clearly
> > treats revisions higher than those implemented by firmware as valid,
> > although new Functions added by those higher revisions are obviously
> > not supported.
> > 
> > PCI FW also says OSPM should not use a fixed Revision ID, but should
> > start with the highest known revision and "successively invoke
> > Function 0 with decremented values of Revision ID until system
> > firmware returns a value indicating support for more than Function 0"
> > (added by the same ECN), and I don't think Linux does this part.
> > 
> > So I think the fixed "pci_acpi_dsm_rev" value as in your patch works
> > fine with the ACPI ASL example, but it doesn't track the "successively
> > decrement" part of PCI FW.  I don't know the reason for that part of
> > the ECN.
> 
> Do you think it's better to respin to take this into account and be more
> stringent or "do nothing"?

To me, it seems better to do nothing unless a change would solve a
problem.  I raised it as a question to the PCI Firmware workgroup
(https://members.pcisig.com/wg/Firmware/mail/thread/32031), but I
haven't heard anything.

Regrettably, that link only works for PCI-SIG members; here's the text
of my question:

  Sorry to reopen this old topic.  This ECN was approved and appears
  in r3.3.  We're contemplating Linux changes to conform to it.

  I think I understand the ACPI requirement for OSPM to invoke _DSM
  Function 0 to learn whether a Function is supported (because a
  non-zero Function may have completely arbitrary return values, so
  invoking that Function has no way to return "this Function Index
  isn't supported").

  I don't understand why it's important for OSPM to "invoke all
  Functions other than Function 0 with the same Revision ID."  That
  idea doesn't appear in ACPI r6.5, sec 9.1.1 or in the sample ASL
  there.  Is there a benefit to using the same Revision ID for all
  Functions?  (Of course OSPM must invoke Function 0 with Revision ID
  N to learn whether Function X is supported for Revision ID N.)

  I also don't understand why "OSPM should successively invoke
  Function 0 with decremented values of Revision ID until system
  firmware returns a value indicating support for more than Function
  0."  ACPI r6.5 doesn't suggest that, and the sample ASL returns
  different bitmasks depending on the Revision ID supplied by OSPM,
  including a default case that returns a bitmask including all
  Functions implemented by the firmware if OSPM supplied a higher
  Revision ID from the future.  What is the benefit of probing with
  decremented Revision IDs?

  Is there something PCI-specific here, or should these requirements
  be in the ACPI spec instead of the PCI Firmware spec?

> > Unrelated to this patch, I think it's a bug that Linux fails to invoke
> > Function 0 in a few cases, e.g., DSM_PCI_PRESERVE_BOOT_CONFIG,
> > DSM_PCI_POWER_ON_RESET_DELAY, and DSM_PCI_DEVICE_READINESS_DURATIONS.
> > 
> > Per spec, OSPM must invoke Function 0 to learn which other Functions
> > are supported.  It's not explicitly stated, but I think this is
> > required because a supported non-zero Function may return "any data
> > object", so there's no return value that would mean "this Function
> > Index is not supported."
> 
> What are your thoughts on the other two patches in the series?
> Should they wait for a consumer or prepare the API to match the spec.

I'd prefer to wait until there are users of the new functions.
There's no real benefit to adding functions that are never called.

Bjorn
