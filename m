Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88837E8298
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbjKJT2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjKJT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC505FC1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:17:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B30C43395;
        Fri, 10 Nov 2023 05:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699595887;
        bh=6jXXATptriAJy5nj+X6zZWbsGcJ/lAxUy2SkkDTh5Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVhrjbxgDG9DvG77tW3VTrHS+lCoyJJZqHqgV/dcIWv8zWPS7L90jjg6YLg4dVq2X
         /pHjDLdv0U4tj/UcXpormPO9guF+gkv5H3ruXYybgUObOC0qwMAAV/hzpopzaLhshA
         EVejXEUkDTCTKjOqTblx6bs7Iag1YBJCxLcQAwkOwQJOFeRHUtU3ztw1aBsRbQ06YX
         AdmxyETG79mtJiCJYPR0guaZXoadMPi9h+/S4u10wqQGNAyVxGL3XIUlvpWjjRgimt
         DdUgU2+dFxQl+Y5meSPsufyCcp8r+cqEjFAqos8W8Gj7am2cvVHIo9gpx/aqnY0FzG
         wN93G6cfFrgAg==
Date:   Fri, 10 Nov 2023 13:58:04 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] platform/chrome: Implement quickselect for median
 calculation
Message-ID: <ZU3GbHTA3x19h2Zi@google.com>
References: <20231109185439.1535962-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109185439.1535962-1-visitorckw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 02:54:32AM +0800, Kuan-Wei Chiu wrote:
> In addition to the algorithmic improvement, this series includes
> several typo fixes to enhance the overall code quality and maintain
> consistency.

The typo fixes are not necessary to be in the same series.  I would suggest
you separate the typo fixes to "an" (squash them) independent patch.

Please also use more specific prefix (e.g. "platform/chrome: sensorhub: ") to
make the title more clear.

> static int quickselect_test(void)
> {
> 	s64 *arr;
> 	s64 median_old, median_new;
> 	ktime_t start, end;
> 	s64 delta;
> 	const size_t array_length = 1000;
> 	const s64 seed = 1;
> 
> 	arr = kmalloc(array_length * sizeof(s64), GFP_KERNEL);
> 	if (!arr)
> 		return -ENOMEM;
> 
> 	init_array(arr, array_length, seed);
> 	start = ktime_get();
> 	median_old = cros_ec_sensor_ring_median(arr, array_length);
> 	end = ktime_get();
> 	delta = ktime_us_delta(end, start);
> 	printk(KERN_ALERT "time of original function: %lld\n", delta);
> 
> 	init_array(arr, array_length, seed);
> 	start = ktime_get();
> 	median_new = cros_ec_sensor_ring_median_new(arr, array_length);
> 	end = ktime_get();
> 	delta = ktime_us_delta(end, start);
> 	printk(KERN_ALERT "time of new function: %lld\n", delta);
> 
> 	kfree(arr);
> 
> 	/* return 0 on success */
> 	return median_old != median_new;
> }
> 
> /* Result:
>  * time of original function: 897
>  * time of new function: 16
>  */

Could you also run the micro-benchmark for n = 64[2][3]?

[2] https://elixir.bootlin.com/linux/v6.6/source/include/linux/platform_data/cros_ec_sensorhub.h#L64
[3] https://elixir.bootlin.com/linux/v6.6/source/drivers/platform/chrome/cros_ec_sensorhub_ring.c#L154
