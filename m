Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747027D1B6C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjJUGva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 02:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUGv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 02:51:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7877513E;
        Fri, 20 Oct 2023 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697871084; x=1729407084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=naPtkrzRmbCE7KFu9q04yne3z9WnO3pY8BdWgIrnkMw=;
  b=Ro889KAKPydIICyjH0jG8hJkDwLF6KkH9enXfby+7MpBK20UpoXlX0r/
   6j/YHJxcXG0R3vsNYRgGu7loCivmXsMX7ZLgQH3qPf28C8UAMsyb3IZ/r
   wZG4jRVOCz3KKFj+EJsQGTNjVGWe5iqD/y/AUxLg2bZyLKFVOBKKjRdXA
   0JZx4j8353Gv+GdAj88vVB74lkkkVr6J8zchzPqxgeB0Uq/rMsXnSVyfi
   em2eWvtApi5WMvdQuSkmy1SrBYnEJlGhHQYO3thpDZjki0G2mitMCC1uJ
   2egLcH6yWyF3/68BkiTnq0QRfNFIWH6jZQWjA1KEPtvcs7WEcmb/ELIGj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="386427172"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="386427172"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 23:51:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="751142310"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="751142310"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 23:51:19 -0700
Date:   Sat, 21 Oct 2023 09:51:15 +0300
From:   Raag Jadav <raag.jadav@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, linux@roeck-us.net, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 4/8] ACPI: utils: use acpi_dev_uid_match() for
 matching _UID
Message-ID: <ZTN042OQ4kx1PaQt@black.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
 <ZTJYK02w8HZg26eI@smile.fi.intel.com>
 <ZTJmnv6CsZUt0pIS@black.fi.intel.com>
 <CAJZ5v0jvAeibnXSq92CBd1uXUgRnvsP0kEqfL8Du552=LT1dog@mail.gmail.com>
 <ZTLC5Jo97gYsL5wX@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTLC5Jo97gYsL5wX@black.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 09:11:56PM +0300, Raag Jadav wrote:
> On Fri, Oct 20, 2023 at 07:11:53PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Oct 20, 2023 at 1:38 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > >
> > > On Fri, Oct 20, 2023 at 01:36:27PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> > > > > Convert manual _UID references to use standard ACPI helpers.
> > > >
> > > > Yes, while not so obvious this is the correct replacement.
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > I think this is the only case which would suffer from the more obvious
> > > behaviour, i.e.
> > >
> > > bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> > > {
> > >         const char *uid1 = acpi_device_uid(adev);
> > >
> > >         return uid1 && uid2 && !strcmp(uid1, uid2);
> > > }
> > >
> > > That said, we can't be particularly sure about it's potential future users,
> > > especially when the usage will not be limited to just ACPI core since we're
> > > exporting it.
> > 
> > I actually agree with this, so please switch over to the above.
> 
> Will send out a v2, thanks.
> 
> Andy, can I add your review for this?

IIUC you agree with the usage format, but not the actual helper.
So I'm gonna drop it from the first patch and keep it for the rest,
except this one.

Let me know if I'm doing this wrong.

Raag
