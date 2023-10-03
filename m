Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521B97B6A91
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjJCNbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjJCNbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:31:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C544FA3;
        Tue,  3 Oct 2023 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696339878; x=1727875878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xxqxS0x5dYC4fVbGucgwjPASbXwI7a727oCG19nYfBo=;
  b=e4IDrobHB92BSfB9sjBDnKldDpDicAZtKzr8oz3/B/CKBfQGKLekfXIJ
   Bt11IcS7I/1qD7Xhl0+t8Z9mGzr8kPsznD+lNL+Z64aAG+mOc3386mexm
   wyJbYc2uxmpk1j5Hnnzw69sLDaQikmNkP3RIKMsqBvqFRG6Ckw/cPCoGR
   LDl+l/t/ZQ+meFOWyNjvbfTU9Vux8hYoCSlb1qYWAQBCLM9zIbjo/0PSn
   J/wU4XC/a5HmdCDKf//EYLjJcZYHimhmx19rCFRTblds1sdCp3dcx201H
   2pMachrkpDhkOVVkhAmGKS/Njf1W/ys63126Zd57tR2QnAcHnPtoh6uRM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="4439820"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="4439820"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 06:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="744506253"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="744506253"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 06:31:14 -0700
Date:   Tue, 3 Oct 2023 16:31:12 +0300
From:   Raag Jadav <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 0/2] Drop runtime PM support for Baytrail and
 Lynxpoint pinctrl
Message-ID: <ZRwXoK2fca3buQ9y@black.fi.intel.com>
References: <20231003114036.27674-1-raag.jadav@intel.com>
 <ZRwGGS+Uilr/egln@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRwGGS+Uilr/egln@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 03:16:25PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 03, 2023 at 05:10:34PM +0530, Raag Jadav wrote:
> > This series removes runtime PM support for the devices that are not
> > explicitly attached to acpi_lpss_pm_domain as it is dead code anyway.
> > 
> > This has no functional impact and helps reduce their code and memory
> > footprint.
> > 
> > bloat-o-meter:
> > ==============
> > 
> > Baytrail:
> > add/remove: 2/4 grow/shrink: 0/3 up/down: 49/-103 (-54)
> > Total: Before=16104, After=16050, chg -0.34%
> > 
> > Lynxpoint:
> > add/remove: 7/10 grow/shrink: 1/3 up/down: 152/-223 (-71)
> > Total: Before=7506, After=7435, chg -0.95%
> > 
> > Changes since v1:
> > - Add missing pm.h
> > 
> > Raag Jadav (2):
> >   pinctrl: baytrail: drop runtime PM support
> >   pinctrl: lynxpoint: drop runtime PM support
> > 
> >  drivers/pinctrl/intel/pinctrl-baytrail.c  | 19 ++------------
> >  drivers/pinctrl/intel/pinctrl-lynxpoint.c | 32 +++--------------------
> >  2 files changed, 5 insertions(+), 46 deletions(-)
> 
> You forgot --base... :-(

Sorry, I need to go figure out some send-email automation.

Raag
