Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D70A77092F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjHDTog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjHDToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:44:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ADDE60;
        Fri,  4 Aug 2023 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691178273; x=1722714273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J3UrcL2aKfNjWWixBt8W2nMV1RiEIIjNK75fxVLF/Jg=;
  b=eHAF5ZgcSCu9smFEcTBHBMAQw+j1OzRDU+lH14qFYEjFqWw1/U7WJ/vv
   EgMslUsScTNPkEsdLPxZGKVkhykK8cq0SHu+TkTgvbvHgdUYWkzwRVVjb
   +MFg8OeHM9kIvQClPqua7luXh/eSC+aRsJECkKpbLtPKDUqGKhdF+2/+8
   XPsENrS0ce6Yg5uAjd2u4PVWm+mu00r4/AWtxxqHD9ceCzJcazXxpOj1O
   dAwGr9/buhxucNjavoEvMKkVYfHIXy6cwERIOpbP9r0gWgbqOvQhx4ZD1
   MTh/AF2SgTfQMN+zc68APzbmOCN/FZEaZeC8ZhlFoL/97rydNIx0gGbQ+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="360292365"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="360292365"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="800174396"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="800174396"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2023 12:44:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qS0if-005JjU-3C;
        Fri, 04 Aug 2023 22:44:17 +0300
Date:   Fri, 4 Aug 2023 22:44:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Reinit port_id when adding back
 serial8250_isa_devs
Message-ID: <ZM1VET3hymOZEG4/@smile.fi.intel.com>
References: <20230804123546.25293-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804123546.25293-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:35:44PM +0300, Tony Lindgren wrote:
> After fixing the serial core port device to use port->port_id instead of
> port->line, unloading a hardware specific 8250 port driver started
> producing an error for "sysfs: cannot create duplicate filename".
> 
> This is happening as we are wrongly initializing port->port_id to zero
> when adding back serial8250_isa_devs instances, and the serial8250:0.0
> sysfs entry may already exist. For serial8250 devices, we typically have
> multiple devices mapped to a single driver instance. For the
> serial8250_isa_devs instances, the port->port_id is the same as port->line.
> 
> Let's fix the issue by re-initializing port_id when adding back the
> serial8250_isa_devs instances in serial8250_unregister_port().

Good catch and fix, thank you!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


