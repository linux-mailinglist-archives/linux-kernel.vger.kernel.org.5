Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F877D4070
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjJWTtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJWTtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:49:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F119B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698090585; x=1729626585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J8kkGPGrRHzQhaJcAp1Zd8ubZN3m3z/0+i1UyhXKh5Q=;
  b=c5hkTmAUw7VoVqA7hLCgBOMvTGdSKmarUjaKg0/gbgKBm+VLd0hbMs7e
   xRDuWGYKzPswhvymK4E77cOCe17lPAv5qdimx74/uU/6jEKAUTsh4RuPR
   KW3lJpuPDB6OVCQ67UOd4LWHM/+qCm4/pa4iwKfdV4kcL8qTwiCpzylE8
   NPcvo3jM2hz61QRbAoj/vng+y7CKA0proEgO0yPkcYQIvOl9NKn2Ne2GZ
   kmJtv0GacOQaJTJmxONPy7J3Xd6W13OOHFrcRjZIWXZnjeVWN7FkMnVF7
   3eSbKfSn5QbvrAra3YispknbqFAbIUnolO+a9iXsUt7/Y3x1Rx/CJQRUj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8471606"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="8471606"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 12:49:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751735780"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="751735780"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 12:49:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qv0vh-000000081YY-12zx;
        Mon, 23 Oct 2023 22:49:37 +0300
Date:   Mon, 23 Oct 2023 22:49:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v8 2/2] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Message-ID: <ZTbOUIAxuOGgLH+y@smile.fi.intel.com>
References: <20231023102327.3074212-1-glider@google.com>
 <20231023102327.3074212-2-glider@google.com>
 <ZTZZyuWKIMSGv+dF@smile.fi.intel.com>
 <CAG_fn=VOJM5Ok+rvTMB08TKW=1xkU+LmMDWEPugxBaE0XgbL_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=VOJM5Ok+rvTMB08TKW=1xkU+LmMDWEPugxBaE0XgbL_w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 03:50:42PM +0200, Alexander Potapenko wrote:
> On Mon, Oct 23, 2023 at 1:32 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Oct 23, 2023 at 12:23:27PM +0200, Alexander Potapenko wrote:

...

> > > +                             val = bitmap_read(bitmap, i, nbits);
> > > +                             (void)val;
> >
> > Is it marked with __must_check? Otherwise why do we need this?
> 
> That was a weak attempt to prevent the compiler from completely
> optimizing away the bitmap_read() calls, but I haven't really looked
> at the result.
> The reality is that even with this check the calls are deleted, and
> the size of the function is only 68 bytes.
> Replacing the val assignment with a WRITE_ONCE() actually ensures the
> bitmap_read() calls are not deleted:
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index ba567f53feff1..ae57ae48ef3ad 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -1360,8 +1360,7 @@ static void __init test_bitmap_read_perf(void)
>                         for (i = 0; i < TEST_BIT_LEN; i++) {
>                                 if (i + nbits > TEST_BIT_LEN)
>                                         break;
> -                               val = bitmap_read(bitmap, i, nbits);
> -                               (void)val;
> +                               WRITE_ONCE(val, bitmap_read(bitmap, i, nbits));
>                         }
>                 }
>         }

Okay, whatever you choose, please add a comment explaining this.

-- 
With Best Regards,
Andy Shevchenko


