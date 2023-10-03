Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F57B6B12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbjJCOJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjJCOJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:09:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D1595;
        Tue,  3 Oct 2023 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696342157; x=1727878157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Pwk/VZxlKOZi/7FoSiOwBQdjVQGNzZH6YXHnKj3nPAo=;
  b=cKll2msomjn9dliCeSgLc+ov15r4fVOd5DoO5jJEY6cbsVxgBgsCxgHB
   9P//bwhkJYnmdyJ9BGrIZ3d5+OFfjeoP6QsxOHFr4ktbYFBzTGhj1csNa
   tcu/ssyl+4UrCQ52TNBmy8rodV0GlbMHyDgP2aBGGJRtWT5iHt2MrXaSl
   buBjW+Lf2HEScVxMCa78B/NF7HwZEts9DByTBD/e/qLatOxQ1lGJACRSQ
   FRxiGvfQby3gYF/ARgpPKv9crlKhjGTLr3docU+bWk6V/IW+l8A0jnT61
   isHMoTnOJfnHQTVfwOIL57s0Gevp54ewjL0KttuW6BNAK5yQ4CYyIav1p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381765116"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381765116"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:05:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841363465"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="841363465"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:05:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qng1H-00000002VPj-3mwS;
        Tue, 03 Oct 2023 17:05:03 +0300
Date:   Tue, 3 Oct 2023 17:05:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/2] ACPI: property: Allow _DSD buffer data only for
 byte accessors
Message-ID: <ZRwfjywiffWxWnX5@smile.fi.intel.com>
References: <20231002134630.2601294-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0ib_N_ojhoC_z9YCOgmT7q2zy1jMBAFc=pmBmrX-j5Drg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ib_N_ojhoC_z9YCOgmT7q2zy1jMBAFc=pmBmrX-j5Drg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 03:59:26PM +0200, Rafael J. Wysocki wrote:
> On Mon, Oct 2, 2023 at 3:46 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > +       if (obj->type == ACPI_TYPE_BUFFER) {
> > +               if (proptype != DEV_PROP_U8)
> > +                       return -EPROTO;
> >                 items = obj;
> > +       } else
> > +               items = obj->package.elements;
> 
> The braces that are missing here (as per the coding style) were added
> while applying the patch.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


