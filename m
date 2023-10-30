Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2D7DBD44
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjJ3QA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjJ3QAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:00:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D576E8;
        Mon, 30 Oct 2023 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698681622; x=1730217622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R95PXWqdcCQqpxhYQ7a+K0L2FvJAJWH3UWqlEom9KTY=;
  b=RHW2qKjILCtfZpI0Zmmy3urwmK+hfxLvgbYmIBvgN9QVHEDCZtgGTcGL
   VxPmB7zGht4GV7X24KhJw2hPlAY0k5h2l0BhXmaj9PGQ1lRYluvvDw5ss
   McuN1axJKSAgzt6ZVrl4sRuW09AZchjAnKKN2RY6ltucUcEDGYitIuRwQ
   uKaiB94Kcax0NGsEpjqJclP5ojm0PwHOeH2HfDCuTvx2XcAacOg51p6eQ
   my+QU3KH/8oe02j/dDQBZ8o7f7B8AYCBx4KvuV7IS3d8ZJ435d2SN6pxm
   +AsgUC+I8mAphlT+MwxiRbCSMgP2mhxDkFmmHGeb2IuZf0u9DGpwx4H6n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="9630399"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="9630399"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 09:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="850955302"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="850955302"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 09:00:19 -0700
Date:   Mon, 30 Oct 2023 18:00:16 +0200
From:   Raag Jadav <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        len.brown@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZT_TENjSBRpwMw90@black.fi.intel.com>
References: <20231026083335.12551-1-raag.jadav@intel.com>
 <20231027081855.GK3208943@black.fi.intel.com>
 <ZTuMo2qDO6Aqq3D_@black.fi.intel.com>
 <ZTvGaNZmGWpsM-yw@black.fi.intel.com>
 <20231027142856.GL3208943@black.fi.intel.com>
 <ZTvqYwFWm9PQeKIU@black.fi.intel.com>
 <CAJZ5v0hkB6Lm82ie6hfzFVDaqEj7DYxnYxD5NRQNXZxKZjL+xg@mail.gmail.com>
 <CAJZ5v0i6H3aaDv1pPoygSHLLNA9YUr2AkMus=Cbb=KvyV5BEpg@mail.gmail.com>
 <ZTzNBAPe0ToFUqIw@black.fi.intel.com>
 <ZT+BiykmKepdAA8K@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT+BiykmKepdAA8K@smile.fi.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 12:12:27PM +0200, Andy Shevchenko wrote:
> On Sat, Oct 28, 2023 at 11:58:12AM +0300, Raag Jadav wrote:
> > On Fri, Oct 27, 2023 at 07:40:38PM +0200, Rafael J. Wysocki wrote:
> 
> ...
> 
> > We'd probably end up with an oops trying to strcmp into a random address
> > without knowing its type, so I think Mika's would be a better approach.
> > 
> > #define acpi_dev_uid_match(adev, uid2)                                                          \
> > ({                                                                                              \
> >         const char *uid1 = acpi_device_uid(adev);                                               \
> >         u64 __uid1;                                                                             \
> >                                                                                                 \
> >         _Generic(uid2,                                                                          \
> >                  int: uid1 && !kstrtou64(uid1, 0, &__uid1) && (typeof(uid2))__uid1 == uid2,     \
> >                  const char *: uid1 && uid2 && !strcmp(uid1, (const char *)uid2),               \
> >                  default: false);                                                               \
> >                                                                                                 \
> > })
> > 
> > This one I atleast got to compile, but I'm not very well versed with _Generic,
> > so this could definitely use some comments.
> 
> If you go this way, make _Generic() use simple in the macro with a help of two
> additional functions (per type). Also you need to take care about uid2 type to
> be _any_ unsigned integer. Or if you want to complicate things, then you need
> to distinguish signed and unsigned cases.

My initial thought was to have separate functions per type, but then
I realized it would become an unnecessary inconvenience to maintain
one per type. Having it inline with _Generic would make it relatively
easier, but I'll leave it to the maintainers to decide.

> P.S.
> All to me it seems way too overengineered w/o any potential prospective user.

I found a couple of acpi_dev_uid_to_integer() usages which could be
simplified with this implementation, but let's see how everyone feels
about this.

Thanks for the comments,
Raag
