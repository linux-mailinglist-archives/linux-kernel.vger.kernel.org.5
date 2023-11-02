Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566237DF28E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376327AbjKBMhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347626AbjKBMhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:37:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFBC199;
        Thu,  2 Nov 2023 05:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698928475; x=1730464475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yCF7BDVIYKalEi/HaZ90Ts9couhyZV50EQlfDFbgZIY=;
  b=htP2uhNlz6Mlq+wxP2Njc8djy8LZkdugHVw027SxHWCRF/ZY7mxgyNcI
   jmA34gnwRffGeIY+CUEqjw8sHD4Ee24lvODvjPbpruTJPgykfy/EVx21R
   I0YU8eh77Wd+JIHkNOKuNVme/uqGM31LKGCMbFiGdV1fdAcdxLZFSpcIf
   ozUE+fA9Q5qa1F5LttYmRd0jbBRNSjcWxqMnfzsRw1dzecRa/VgXpdJ7O
   94Jxy6Vp5qns4vpe4p71Ydu+6tYSeiwWJtKhrogvCE9k7AIpfeb/lmHPQ
   NjEJgpvI+F/C2IL0z6aWKvOTDlGvFneYvJjlTcUOtAWfqy7Cs7/cNOyfc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="368906158"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="368906158"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="790383087"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="790383087"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:34:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qyWu6-0000000AgYp-0xdv;
        Thu, 02 Nov 2023 14:34:30 +0200
Date:   Thu, 2 Nov 2023 14:34:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Move default strength
 assignment to a switch-case
Message-ID: <ZUOXVSij9497HrBR@smile.fi.intel.com>
References: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdb3wLAZfU+_E0r5Rr_HD-bdFpf7K6bMD6dqiK1Ryv7NAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb3wLAZfU+_E0r5Rr_HD-bdFpf7K6bMD6dqiK1Ryv7NAQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 08:36:11AM +0100, Linus Walleij wrote:
> On Mon, Oct 30, 2023 at 4:54 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

(...)

> > +               case 1: /* Set default strength value in case none is given */
> 
> So where does this 1 come from in the end? That's the piece I
> am missing in this explanation. Somewhere, someone decided
> to pass 1 to indicate "pull to default resistance".
> 
> Is it coming from ACPI firmware?

No, it's pure Linux kernel decision.
gpio_set_bias() is who made that. That's why it needs to be chosen on global
level.

We may even document somewhere that arguments let's say up to 10 do not make
any sense in real life, as even for 1.2 v it will give 120 mA current on a single
pin. Yet, theoretically that's possible for discrete industrial GPIOs, so we
can choose "very big number" if such case appears in the future. I don't want
to change 1 to something else right now as it may break things.

> for default pull" should be added to the constant definition in the
> code.

-- 
With Best Regards,
Andy Shevchenko


