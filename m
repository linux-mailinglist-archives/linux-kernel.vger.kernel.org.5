Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E77BB913
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjJFN1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJFN1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:27:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29372AC;
        Fri,  6 Oct 2023 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696598835; x=1728134835;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2cc26gFKLWV1zohqFQ9a2XIcjoRWt0n03Xemi9o+UVA=;
  b=QB5+Gr8lpX+N+lwZkP1bGdyfHOl4uvAFIFG2KuouxAQObNXVvo414EHd
   Kx89qb3T0SGaQO6c4LGGfr6he7Pfx9HMVOY3NnW0RX+2DBxdtpiAOosmY
   9Kqkt6byhXr90lYIKeOU8/d93+4mP7xlDoguYn4xlR3Pm+Mpd7xZM8bNG
   hkpcML+nT7y1pbWSfJo9ePVSHlm+7iRIqf08l+Vk3dNqLO3SZwV5NbtBO
   EH64HgkPDWqBHm60+wj1isIjKGerbgZS4HWflaSL+nNjQl3y5LByc383z
   /LG8Gvi/K3C37Y2tin6bcoJPf71ZMbuO3TaVKO7PVSUq3kC5EhHFRnqLu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="383641043"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="383641043"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 06:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="999328555"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="999328555"
Received: from srab-mobl1.ger.corp.intel.com ([10.252.43.69])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 06:27:11 -0700
Date:   Fri, 6 Oct 2023 16:27:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 0/5] platform/x86: int3472: don't use
 gpiod_toggle_active_low()
In-Reply-To: <29764d46-8d3d-9794-bbde-d7928a91cbb5@redhat.com>
Message-ID: <2e9621e7-59e-dc20-71a-9da6f367557e@linux.intel.com>
References: <20230926145943.42814-1-brgl@bgdev.pl> <e6817d30-b443-1a73-efae-84415604b19f@redhat.com> <CACMJSetWH=Z5ubHb33W0mYvpqkU7vv=nKNBSa9eLmAi94NyrgA@mail.gmail.com> <29764d46-8d3d-9794-bbde-d7928a91cbb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023, Hans de Goede wrote:

> Hi Bart,
> 
> On 9/28/23 20:40, Bartosz Golaszewski wrote:
> > On Thu, 28 Sept 2023 at 14:40, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi All,
> >>
> >> Here is a v2 of Bartosz' "don't use gpiod_toggle_active_low()" series.
> >>
> >> New in v2:
> >> - Rework to deal with ACPI path vs gpiod_lookup.key differences:
> >>   acpi_get_handle(path) -> acpi_fetch_acpi_dev(handle) -> acpi_dev_name(adev)
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >> Bartosz Golaszewski (2):
> >>   platform/x86: int3472: Add new
> >>     skl_int3472_gpiod_get_from_temp_lookup() helper
> >>   gpio: acpi: remove acpi_get_and_request_gpiod()
> >>
> >> Hans de Goede (3):
> >>   platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() helper
> >>   platform/x86: int3472: Stop using gpiod_toggle_active_low()
> >>   platform/x86: int3472: Switch to devm_get_gpiod()
> >>
> >>  drivers/gpio/gpiolib-acpi.c                   |  28 -----
> >>  .../x86/intel/int3472/clk_and_regulator.c     |  54 ++--------
> >>  drivers/platform/x86/intel/int3472/common.h   |   7 +-
> >>  drivers/platform/x86/intel/int3472/discrete.c | 101 ++++++++++++++----
> >>  drivers/platform/x86/intel/int3472/led.c      |  24 +----
> >>  include/linux/gpio/consumer.h                 |   8 --
> >>  6 files changed, 93 insertions(+), 129 deletions(-)
> >>
> >> --
> >> 2.41.0
> >>
> > 
> > Thanks Hans, this looks good to me. I'd let it sit on the list for a
> > week. After that, do you want to take patches 1-4 and provide me with
> > another tag?
> 
> I have just send out a v3 to address Andy's remark about me
> somehow resetting the authorship to me on 2 patches from Bartosz.

> As for your request for a tag for the 4st 4 patches for you to merge
> into gpiolib. I'll go and work work on that. I need to coordinate
> this with Ilpo, with whom I now co-maintain pdx86 .

Thanks all. I've applied patches 1-4 into platform-drivers-x86-int3472 and 
merged that into review-ilpo.

I'll send the IB PR once LKP has done its thing for the branch.


-- 
 i.

