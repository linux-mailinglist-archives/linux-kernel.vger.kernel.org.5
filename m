Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7837BD946
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbjJILKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346171AbjJILKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:10:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B592BA6;
        Mon,  9 Oct 2023 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696849816; x=1728385816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pa/hUMltIcQcrQ6tgeOUqEiyuzE3UCtC/iY4kx/jAPE=;
  b=Bp+SwkegZGWKLc2S9Wa3weOYy9jONsGtquYRxnVV5yZXdnov+1MCH1l1
   HULTy1DD0+fc0wo7xdBLL8hPQgy/+rdJ+e8RgsWSvpsk379qvUa7Wa0iL
   3UvTfn1ZErShyrkXvzf1d05fy8g1ynGeAzbFl3s9A8rSVMh3db0EfiHNz
   QaBHuoCSfMSdkyoDYRBtWVRzh1GOPwPpaYrTJxzTaRe/vHZ+kJRf/bMNe
   OeZsbX1etYhmAypOoNYGXGgueAann3ByTJX8PCvaspy537ny8kVMx67I2
   1X+utfOSMFxUt8PFrRjmv1VP34OGRYSenqbdXLSBFQnFk1oy+x93WDFSN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="387981919"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="387981919"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 04:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="823298035"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823298035"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 04:10:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D6EE022B; Mon,  9 Oct 2023 14:10:12 +0300 (EEST)
Date:   Mon, 9 Oct 2023 14:10:12 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/20] pinctrl: intel: cherryview: Convert to platform
 remove callback returning void
Message-ID: <20231009111012.GE3208943@black.fi.intel.com>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
 <20231009083856.222030-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009083856.222030-6-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:38:41AM +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
