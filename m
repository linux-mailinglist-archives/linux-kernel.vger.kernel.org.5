Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A067FED56
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345070AbjK3Kyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3Kym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:54:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13789E6;
        Thu, 30 Nov 2023 02:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701341689; x=1732877689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1bA8QdXkqNyYvXu1SfXfNGr8LDOv/Eh71Y2D+1xrOws=;
  b=gGrFpjIC5gP5BJpEzdvs8DxrzyqSgo18C2R/CJReAxAVnkJ6wkD55OX5
   9sksjgcZRWDj1QUqh0t+KD8xL8SpXTtL98NLs92jQ4te0RWrvjGK6e/jx
   6Fldvp43c8eZrdLvYmOS4k8zgd5WiWZYkuEGBhVKsXaBHRJmdcf9KUquP
   /qB1oSLoHReBI6gdDXUrGrOpWhuLb4lonw6LRaSKt2p5yRI2dh4M/VNuo
   yAcp2/xjUstaFyryVFbre8ox406Rlw1pRl7gupOZfJJb4yoYUj23ZWmPJ
   vciUbaA4cMsfn8ZiEGJPPz7tKp3mQrflaUMFDBbUATvXlEKRQNKDPteJq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="295220"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="295220"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:54:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="773021159"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="773021159"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 30 Nov 2023 02:54:44 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 30 Nov 2023 12:54:44 +0200
Date:   Thu, 30 Nov 2023 12:54:44 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Alexandru Ardelean <alex@shruggie.ro>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        a-govindraju@ti.com, trix@redhat.com, abdelalkuor@geotab.com
Subject: Re: [PATCH] USB: typec: tps6598x: use device 'type' field to
 identify devices
Message-ID: <ZWhp9M8165DiTNTd@kuha.fi.intel.com>
References: <20231123210021.463122-1-alex@shruggie.ro>
 <ZWdKI9UOZ6INP0Tu@kuha.fi.intel.com>
 <47ffbb30-34a7-4f5b-b262-3e068e574c8a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ffbb30-34a7-4f5b-b262-3e068e574c8a@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

> > Why not just match against the structures themselves?
> > 
> >         if (tps->data == &tps25750_data)
> >                 ...
> 
> Then you need to declare tps25750_data and friends at the top of the file?
> 
> A better approach might be to have type agnostic quirk flags for the special
> behavior required for different types. This way, multiple devices can share
> the same quirk if needed.
> 
> e.g.
> NEEDS_POWER_UP instead of TIPD_TYPE_APPLE_CD321X
> SKIP_VID_READ instead of TIPD_TYPE_TI_TPS25750X
> INIT_ON_RESUME instead of TIPD_TYPE_TI_TPS25750X
> 
> Also rename cd321x_switch_power_state() to tps6598x_switch_power_state().

No. Functions like that isolate cd321x specific functionality into an
actual "function" just like they should.

Quirk flags mean that if something breaks, it will almost always break
for everybody (there is no real isolation with quirk flags), and when
things are fixed and when features are added, we are forced to always
"dance" around those quirk flags - you always have to consider them.

Platform/device type checks are just as bad IMO, but in one way they
are better than quirk flags. There is no question about what a
platform check is checking, but quirk flags can so easily become
incomprehensible (just what exactly does it mean when you say
NEEDS_POWER_UP, SKIP_VID_READ and so on (you would need to document
those quirks, which is waste of effort, and in reality nobody will do).

In case of tipd/code.c, it should be converted into a library that
only has the common/shared functionality. CD321, TPS2579x, TPS6598x
and what ever there is, then will have a glue driver that handles
everything that specific for their controller type.

Before this driver is reorganised like that (any volunteers?), we'll
have the PD controller type checks, but quirk flags we will not have.

In general, you should only use quirk flags if there is no other
way to move forward - they are the last resort. They are dangerous,
and even in the best case they reduce the maintenability of the code.

thanks,

-- 
heikki
