Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C81E7CD2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjJRDiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJRDiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:38:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3828B101
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 20:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697600299; x=1729136299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L2XI+NRTEILxjtpiFc792xwJDDhVanL35F3Cd6yts6U=;
  b=j3kU9cyRCRMJS7SsDaYtCHMhUZTtG4nt/ZJZieggyX9UfmSyke8sAfl5
   k5JnYoNpvwyhxe0zVGPmUelgiKjGtzl7CK7fA6d790Mp974yO1CQibqhz
   kwsHhPEBditthrDNbAeftZvo8mbtG6OmPYSMyZPimxr8g+253pjiiOThE
   qaXTmLScSW5ZpUfVaYcF1+7gsiDMkP0J9c/C5cufhDinkjtWHqohIB51D
   dPRHO1hAk+c7WLVQLwmua0t8WnI7WCmpLmZOuH+1ZZ8qk/yeuhwhrqdip
   y6la+8QFmBP+uLdo2HV+8vY3bNk8e60JaWJZG/I+4B86F7dpomK5Oa9ok
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388792708"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="388792708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 20:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="4175430"
Received: from kchua1-mobl1.gar.corp.intel.com (HELO intel.com) ([10.215.248.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 20:37:09 -0700
Date:   Wed, 18 Oct 2023 05:38:07 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     kenechukwu maduechesi <maduechesik@gmail.com>
Cc:     outreachy@lists.linux.dev, shreeya.patel23498@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace delay function.
Message-ID: <ZS9THxlJhHfv4gU9@ashyti-mobl2.lan>
References: <20231018004300.GA3189@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018004300.GA3189@ubuntu>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kenechukwu,

On Tue, Oct 17, 2023 at 06:03:05PM -0700, kenechukwu maduechesi wrote:
> Replace udelay() with usleep_range() for more precise delay handling.

The reason is not the precise handling, quite the opposite.

> Reported by checkpatch:
> 
> CHECK: usleep_range is preferred over udelay

Can you tell why?[*]

> Signed-off-by: kenechukwu maduechesi <maduechesik@gmail.com>
> ---
>  drivers/staging/rts5208/sd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
> index 74c4f476b3a4..059f99b0a727 100644
> --- a/drivers/staging/rts5208/sd.c
> +++ b/drivers/staging/rts5208/sd.c
> @@ -865,7 +865,7 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
>  						     PHASE_CHANGE);
>  			if (retval)
>  				return retval;
> -			udelay(50);
> +			usleep_range(50);

What is the range you will be sleeping, now?

Andi

[*] Documentation/timers/timers-howto.rst
