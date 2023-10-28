Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FD57DA60D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 11:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjJ1I6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjJ1I6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 04:58:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF6F0;
        Sat, 28 Oct 2023 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698483498; x=1730019498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zkDqM+9rJKFk7nc3myPOxx1gyUxiQNwZjfLWSN5JOjA=;
  b=nxZz79By0PSJPrAJ48xwFUB6VTaKoM4zINiIikbN8bfTdnfaHzOzq5PK
   JDGkBXCrB9YwtASZMAfKcqvn7Mv5u4rC8au7T20BmFD5IT2kc7fAcsJtg
   zKnPut+Ypdj607IJDiWuRA2jZYsf/MKrVBsy8x8+nqfP7+nHiprPjDtoA
   JVpXi4WcUBrAPWMtShS/RxnsNKG4zTKQ57TXub2+ijB7463GUnV+RrzsP
   2RSUserdCzyhstGccjVCPbCf7Lm+i0JD9N6qITxh2zVbq5vh7cmnvTenb
   61lWG248axnqGWCnSgW4bXdpdr3vm6QAQBf+8K+3i5Y51+0WJr51vG8X0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="368103964"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="368103964"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 01:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="830235817"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="830235817"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 01:58:15 -0700
Date:   Sat, 28 Oct 2023 11:58:12 +0300
From:   Raag Jadav <raag.jadav@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        len.brown@intel.com, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTzNBAPe0ToFUqIw@black.fi.intel.com>
References: <20231026083335.12551-1-raag.jadav@intel.com>
 <20231027081855.GK3208943@black.fi.intel.com>
 <ZTuMo2qDO6Aqq3D_@black.fi.intel.com>
 <ZTvGaNZmGWpsM-yw@black.fi.intel.com>
 <20231027142856.GL3208943@black.fi.intel.com>
 <ZTvqYwFWm9PQeKIU@black.fi.intel.com>
 <CAJZ5v0hkB6Lm82ie6hfzFVDaqEj7DYxnYxD5NRQNXZxKZjL+xg@mail.gmail.com>
 <CAJZ5v0i6H3aaDv1pPoygSHLLNA9YUr2AkMus=Cbb=KvyV5BEpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i6H3aaDv1pPoygSHLLNA9YUr2AkMus=Cbb=KvyV5BEpg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 07:40:38PM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 27, 2023 at 7:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Oct 27, 2023 at 6:51 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > >
> > > On Fri, Oct 27, 2023 at 05:28:56PM +0300, Mika Westerberg wrote:
> > > >
> > > > Indeed, but using the _Generic() you should be able to have
> > > > a single acpi_dev_uid_match() to work for either type so:
> > > >
> > > > acpi_dev_uid_match(adev, "1")
> > > >
> > > > and
> > > >
> > > > acpi_dev_uid_match(adev, 1)
> > > >
> > > > would both work with type checkings etc.
> > > >
> > > > Not sure if this is worth the trouble though.
> > >
> > > Well, in that case we can probably try both and hope for the best ;)
> > >
> > > bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
> > > {
> > >         const char *uid1 = acpi_device_uid(adev);
> > >         u64 uid1_d;
> > >
> > >         return uid1 && uid2 && (!strcmp(uid1, uid2) ||
> > >                (!kstrtou64(uid1, 0, &uid1_d) && uid1_d == (u64)uid2));
> > > }
> > >
> > > But I'm guessing the compiler wouldn't be very happy about this.
> >
> > IMO it would be better to use the observation that if the uid2 string
> > can be successfully cast to an int and the device's unique_id string
> > can't be cast to an int (or the other way around), there is no match.
> >
> > If they both can be cast to an int, they match as long as the casting
> > results are equal.
> >
> > If none of them can be cast to an int,  they need to be compared as strings.
> 
> Or if the strings don't match literally, try to convert them both to
> ints and compare.

We'd probably end up with an oops trying to strcmp into a random address
without knowing its type, so I think Mika's would be a better approach.

#define acpi_dev_uid_match(adev, uid2)                                                          \
({                                                                                              \
        const char *uid1 = acpi_device_uid(adev);                                               \
        u64 __uid1;                                                                             \
                                                                                                \
        _Generic(uid2,                                                                          \
                 int: uid1 && !kstrtou64(uid1, 0, &__uid1) && (typeof(uid2))__uid1 == uid2,     \
                 const char *: uid1 && uid2 && !strcmp(uid1, (const char *)uid2),               \
                 default: false);                                                               \
                                                                                                \
})

This one I atleast got to compile, but I'm not very well versed with _Generic,
so this could definitely use some comments.

Raag
