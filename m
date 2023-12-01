Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C696B800537
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377793AbjLAILE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:11:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A108610FC;
        Fri,  1 Dec 2023 00:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701418268; x=1732954268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XXTiE0KX84FeRtROAy8E+cghO1kCf3YR1Lfb3hphWyM=;
  b=apSuMulPbRUWEOkcz/SAMv3r5pH5+QHHrnGii9Z5ZiFOKeol8TCqZ8oH
   wrS+x3w3I9B+sKeJYp3OX90OrS+XDa3jDvc/uA0HPYYcccLMgTTdIHzkG
   TbYdSE7Vsayq7KDqWT+ZBy0m8anj/6nDUnH6GBnR4sO6chHPUP4r454tB
   CBOMKdjG4/nttgptsql2vyjdm13B6RJ0gNcGYSDrpBw/ZD5Y0x1shkaMa
   FqozeOkj7RWNrHKs1Dhk9YR790PtLjno0nl6aiXVzVL5Uc0Q/BlGNwzM6
   5J+Vya6JBTJGElWe8k0qvYrSCFqgxdeaOW6c4uFgZsz0c7HveeKmJwLFC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="397350523"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="397350523"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 00:10:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803967888"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="803967888"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga001.jf.intel.com with SMTP; 01 Dec 2023 00:10:44 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 01 Dec 2023 10:10:43 +0200
Date:   Fri, 1 Dec 2023 10:10:43 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Alexandru Ardelean <alex@shruggie.ro>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        a-govindraju@ti.com, trix@redhat.com, abdelalkuor@geotab.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] USB: typec: tps6598x: use device 'type' field to
 identify devices
Message-ID: <ZWmVA9KTVhZ4YCPO@kuha.fi.intel.com>
References: <20231123210021.463122-1-alex@shruggie.ro>
 <ZWdKI9UOZ6INP0Tu@kuha.fi.intel.com>
 <47ffbb30-34a7-4f5b-b262-3e068e574c8a@kernel.org>
 <ZWhp9M8165DiTNTd@kuha.fi.intel.com>
 <292f5d48-8567-4b60-ad03-6cf70f71bacc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <292f5d48-8567-4b60-ad03-6cf70f71bacc@kernel.org>
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

On Thu, Nov 30, 2023 at 03:30:54PM +0200, Roger Quadros wrote:
> Hi Heikki,
> 
> On 30/11/2023 12:54, Heikki Krogerus wrote:
> > Hi Roger,
> > 
> >>> Why not just match against the structures themselves?
> >>>
> >>>         if (tps->data == &tps25750_data)
> >>>                 ...
> >>
> >> Then you need to declare tps25750_data and friends at the top of the file?
> >>
> >> A better approach might be to have type agnostic quirk flags for the special
> >> behavior required for different types. This way, multiple devices can share
> >> the same quirk if needed.
> >>
> >> e.g.
> >> NEEDS_POWER_UP instead of TIPD_TYPE_APPLE_CD321X
> >> SKIP_VID_READ instead of TIPD_TYPE_TI_TPS25750X
> >> INIT_ON_RESUME instead of TIPD_TYPE_TI_TPS25750X
> >>
> >> Also rename cd321x_switch_power_state() to tps6598x_switch_power_state().
> > 
> > No. Functions like that isolate cd321x specific functionality into an
> > actual "function" just like they should.
> > 
> > Quirk flags mean that if something breaks, it will almost always break
> > for everybody (there is no real isolation with quirk flags), and when
> > things are fixed and when features are added, we are forced to always
> > "dance" around those quirk flags - you always have to consider them.
> > 
> > Platform/device type checks are just as bad IMO, but in one way they
> > are better than quirk flags. There is no question about what a
> > platform check is checking, but quirk flags can so easily become
> > incomprehensible (just what exactly does it mean when you say
> > NEEDS_POWER_UP, SKIP_VID_READ and so on (you would need to document
> > those quirks, which is waste of effort, and in reality nobody will do).
> > 
> > In case of tipd/code.c, it should be converted into a library that
> > only has the common/shared functionality. CD321, TPS2579x, TPS6598x
> > and what ever there is, then will have a glue driver that handles
> > everything that specific for their controller type.
> 
> Do you mean that you want to treat the 3 devices as different incompatible devices
> so each one has a separate driver which warrants for a different DT binding
> for each and also Kconfig symbol?

I did not consider that, I was thinking that we would still continue
with just one probe driver for all of these, but now that you
mentioned this, maybe it would actually make sense to have separate
full fledged probing drivers for all of these. Do you think it would
be better like that? Would it be a problem to split the bindings?

thanks,

-- 
heikki
