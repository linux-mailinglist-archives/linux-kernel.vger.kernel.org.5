Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D4782657
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjHUJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjHUJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:34:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB5091;
        Mon, 21 Aug 2023 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692610474; x=1724146474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8pGk4HMopyDP6wXit6hNYYApLhMQ6ZIRPvMV2Lfe42c=;
  b=bF7StnEvmSPBZ/+AW9ixHZG7zFIbaYN0N6/KEPUzt75rWgzcpeeO53wA
   Rgc0Ica5BSBr7vnZ+vBpQ0oBekRYLDgiVONxiin6RFyFFujZSzvXklat6
   0pmI3e7uKyJMon+hy09oQaTddbC95W1gs3J59BPO57AWLjUZ0rRDregWq
   fCiHVojNpZgFcRk2S9c9lft5d8Oa1BcjRx2N68zc/KYwoANlb02Yq7SZG
   6PXomUd89yM/26V1If9AopkiVQPGZLPzgCidb1oDgYraTcDM4vktQabsS
   LDEpHDF0Li9YqJ0mp/6jq/fbtA3mtz2vT1nCoLazvoyrDW6xcRCWPNwF4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="370978813"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="370978813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 02:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="801202935"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="801202935"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2023 02:34:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY1Is-007tGe-2F;
        Mon, 21 Aug 2023 12:34:30 +0300
Date:   Mon, 21 Aug 2023 12:34:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
Message-ID: <ZOMvpmoWLCgcAyJR@smile.fi.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
 <ZMK60UphgVuj4Z+L@smile.fi.intel.com>
 <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm>
 <ZND/8wd67YbGs8d5@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308141128260.14207@cbobk.fhfr.pm>
 <ZOMcHQc8Em/s6C+y@smile.fi.intel.com>
 <ez2oewpi3yeaiejrvbe433ude75pgm3k3s5sh5gnn7pvnzm7b4@ajuopfgwocft>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ez2oewpi3yeaiejrvbe433ude75pgm3k3s5sh5gnn7pvnzm7b4@ajuopfgwocft>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:51:04AM +0200, Benjamin Tissoires wrote:
> On Aug 21 2023, Andy Shevchenko wrote:
> > On Mon, Aug 14, 2023 at 11:28:58AM +0200, Jiri Kosina wrote:
> > > On Mon, 7 Aug 2023, Andy Shevchenko wrote:

...

> > > > > > > > After I updated GPIO library for the case Benjamin has with CP2112,
> > > > > > > > I have a brief look into the CP2112 driver itself.
> > > > > > > > 
> > > > > > > > From GPIO perspective it has two main (maitenance) issues:
> > > > > > > > - usage of ->to_irq() with IRQ chip present;
> > > > > > > > - having IRQ chip not immutable.
> > > > > > > > 
> > > > > > > > Besides that there are plenty small cleanups here and there.
> > > > > > > > Hence this series.
> > > > > > > 
> > > > > > > Any comments on this?
> > > > > > 
> > > > > > Gentle ping^2 for this...
> > > > > > 
> > > > > > Anything should I do to improve it or is it okay to go as is?
> > > > > 
> > > > > I have been off pretty much the whole July. I am now back and slowly 
> > > > > making my way through everything that accumulated, I will eventually get 
> > > > > to this.
> > > > > 
> > > > > Thanks for the patience,
> > > > 
> > > > Ah, okay, no worries and take your time!
> > > > 
> > > > I was thinking more on Benjamin's answer as last time he had a hw setup
> > > > to test... Not sure what the status of that now and if he has a chance
> > > > to test this or busy enough with something else.
> > > 
> > > Ah, that would be of course nice. Benjamin?
> > 
> > Benjamin? It almost full release cycle passed...
> > I understand if you are busy with something, just tell us.
> 
> Sorry for not answering, I was off in August until just now.
> 
> I tried you series just before taking time off, but the problem was that
> my automation relies on this driver to not be too far from the current
> upstream, as I need to patch it to be able to inject a node child in it.
> 
> Which is why I was very interested in the ACPI/DT work so that I do not
> have to patch the driver.
> 
> Long story short, I'm not able to test it right now (and I got quite
> some backlog as you can imagine). IIRC the code was fine, so I think we
> can just take the series as is, and work on the quirks (if any) later.

Thank you!

The thing that might be broken is interrupts handling. If that works,
I'm pretty confident with the rest.

-- 
With Best Regards,
Andy Shevchenko


