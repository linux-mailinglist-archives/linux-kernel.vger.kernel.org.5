Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391F775EE5F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjGXIwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjGXIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:52:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24FFFB;
        Mon, 24 Jul 2023 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690188764; x=1721724764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AFK87Oy7ijOEjIfPgqTKmw5kmr9MTaaez0cnQ9KaiPk=;
  b=E9ltUVdfCeVw77AuoXWmkZPDA7VYUlSofBtZ/nnkLD/3RBKgmGsBKQXU
   IGlPOv7uSVmyf+7dbFkbnakI+WKRem6yyyULybPsoBenn+j1NkbyKwoVc
   7naGuNj2jSzO1BiWAMFNCrKyorbyU4/KsD8Qme+FIwUgiCBBgh6MD+m2K
   ySK9zQE5Z7m6Hmqt+5nkUTgzXxoT9FSSXjGRbRwGIRtY5X5e5o/y0mnNm
   GCaEJu3YsDj7Yjrg8GjBXyEbVxgGsJwbrW5FAhH/7kWtJsUgaZXrgwmlN
   Cv7B+ukThpsUokg3dHm4j0aPKU4GC0SlSffJDv7FWl+dkZHIYdRyODlms
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="398288419"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398288419"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="728833974"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="728833974"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jul 2023 01:52:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNrJ1-005GiM-2f;
        Mon, 24 Jul 2023 11:52:39 +0300
Date:   Mon, 24 Jul 2023 11:52:39 +0300
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
Subject: Re: [PATCH v4 1/3] serial: core: Controller id cannot be negative
Message-ID: <ZL471yzIKu1xG/PF@smile.fi.intel.com>
References: <20230724050709.17544-1-tony@atomide.com>
 <20230724050709.17544-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724050709.17544-2-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:07:03AM +0300, Tony Lindgren wrote:
> The controller id cannot be negative. Let's fix the ctrl_id in preparation
> for adding port_id to fix the device name.
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Andy Shevchenko <andriy.shevchenko@linux.intel.com>

???
Missing Reviewed-by: I suppose?

-- 
With Best Regards,
Andy Shevchenko


