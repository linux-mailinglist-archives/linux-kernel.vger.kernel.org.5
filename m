Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544367BD94A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbjJILKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346171AbjJILKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:10:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C03AAF;
        Mon,  9 Oct 2023 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696849852; x=1728385852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/hGFy3dY+abobqliqfXMKxSmSYBUujSLeMlrXMfTXFg=;
  b=cPQ15Qc1mS51SAHu2HIi5opr3rKdtTUcD+AhqkyH/kbrOS1DvypuCft0
   AvNwcp9Fa+iqYWthlgQF1dG12cnpbrbQbaU0wRSwAc9GCklppmgBGgigl
   iWX7ARQ2U6LPK2W9hRAMX2ppfXcXGN/k72DRAslVt1E/CVFDlk2XPfqrk
   Dh2J5hj7oTwMufzczkfQWEhm5iWqFz4j9sVyrjZ05fq7jC96x40Hp8nFv
   tHpWa4tyKObdSBHqOtOgS8IGC1Qse9ETcSSztob6foq31UGfkgdJBDo6V
   vzcm6S93ueKvf4pc5zitTaWNA4zm4cCkqdW3qQt80rZaN2wbEHk9dR19E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="450618176"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="450618176"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 04:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="876761195"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="876761195"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 09 Oct 2023 04:10:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6F4F722B; Mon,  9 Oct 2023 14:10:48 +0300 (EEST)
Date:   Mon, 9 Oct 2023 14:10:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/20] pinctrl: intel: lynxpoint: Convert to platform
 remove callback returning void
Message-ID: <20231009111048.GF3208943@black.fi.intel.com>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
 <20231009083856.222030-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009083856.222030-7-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:38:42AM +0200, Uwe Kleine-König wrote:
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
