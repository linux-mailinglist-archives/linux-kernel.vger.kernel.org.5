Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F17755E63
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjGQIZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:25:10 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93562F1;
        Mon, 17 Jul 2023 01:25:07 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4R4FWM4k6Yz9sZP;
        Mon, 17 Jul 2023 10:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689582303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NK8nuXSKhaOPtyMYcKeXahGMtHToDdOeNI9Wj3uVVcw=;
        b=rus4/utspm2OnlDb+/3oYddZciCq3vxoIrTcIvbmxAo+7pzxmAe+Gtp69wt2G1r7L3u0ab
        KzJj1HYPlyPsYIxStHsnN0yivi0s9A0yQAVt4JmvOCju+VNulGQjBXyd2QvY1192FJRcPv
        Spi4Sp5gd/R1Vh3LdOpH2vXtg00ivnkfoc3pIAPB8o8ivXRdC695ie5TLJ9M3C6zoSgB3L
        YihggnvsZxSaZlHrFLTTItoi4k5dtGd4flGV4NXbY/3dEVajWZh19Ppmth5fMXffXWqC2L
        fo936h6GsIuiQsv0OeAKrkUf4ObZ9GAIp7VPgIJiDpUoPivzJs32a+vbje1q2A==
References: <20230617131041.18313-1-frank@oltmanns.dev>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "A.s. Dong" <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v5 0/2] clk: fractional-divider: Improve approximation
 when zero based and export
In-reply-to: <20230617131041.18313-1-frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 10:24:49 +0200
Message-ID: <874jm3lzce.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-06-17 at 15:10:39 +0200, Frank Oltmanns <frank@oltmanns.dev> wrote:
> The fractional divider approximation does not utilize the full available
> range for clocks that are flagged CLK_FRAC_DIVIDER_ZERO_BASED. This
> patchset aims to fix that.
>
> It also adds test cases for the edge cases of fractional divider clocks
> with and without the CLK_FRAC_DIVIDER_ZERO_BASED flag to highlight the
> changes.
>
> Finally, it also exports clk_fractional_divider_general_approximation so
> that the test cases (but also other users like rockchip clk driver) can
> be compiled as a module.
>
> Unfortunately, I have no boards to test this patch. So all we have are
> the unit tests. It seems the only user of this flag in mainline is
> drivers/clk/imx/clk-composite-7ulp.c, therefore I'm cc-ing
> get_maintainers.pl --git-blame -f drivers/clk/imx/clk-composite-7ulp.c
> in the hopes of a wider audience.

Are there remarks or questions on this patchset? Anything that needs to
be improved?

Thanks,
  Frank

>
> Thank you for considering this contribution,
>   Frank
>
> P.S.: V4 was short-lived, because it triggered a compiler warning on
> clang. I'm sorry for the noise. -- Frank
>
> V4: https://lore.kernel.org/all/20230617102919.27564-1-frank@oltmanns.dev/
> V3: https://lore.kernel.org/all/20230614185521.477924-1-frank@oltmanns.dev/
> V2: https://lore.kernel.org/lkml/20230613083626.227476-1-frank@oltmanns.dev/
> V1: https://lore.kernel.org/lkml/20230529133433.56215-1-frank@oltmanns.dev/
>
> Changes in V5 (since V4):
>  - Fix compiler warnings on clang by removing superfluous variable max_m
>    in the test cases for the maximum denominator (n) and max_n in the
>    test cases for max numerator (m).
>    Thank you, Intel, for your kernel test robot!
>
> Changes in V4 (since V3):
>  - Export clk_fractional_divider_general_approximation so that users
>    (e.g., the testcases) can be compiled as modules.
>  - Change test cases so that they test
>    clk_fractional_divider_general_approximation again (like in V2)
>    instead of clk_fd_round_rate (like in V3), but keeping the structure
>    of V3 with separate file and individual test cases for each edge
>    case.
>
> Changes in V3 (since V2):
>  - Completely reworked the test cases
>    - Moved tests to separate file as per Stephen's request
>    - Move each edge case into their individual test case as per
>      Stephen's request
>    - Test clk_fd_round_rate instead of
>      clk_fractional_divider_general_approximation as testing the latter
>      broke builds
>
> Changes in V2 (since V1):
>  - Added test case as requested by Stephen Boyd
>  - Fixed commit message as the Cc: was missing a closing bracket, so that the
>    original mail unfortunately did not go out to A. s. Dong.
>
> Frank Oltmanns (2):
>   clk: fractional-divider: Improve approximation when zero based and
>     export
>   clk: fractional-divider: tests: Add test suite for edge cases
>
>  drivers/clk/.kunitconfig                  |   1 +
>  drivers/clk/Kconfig                       |   7 +
>  drivers/clk/Makefile                      |   1 +
>  drivers/clk/clk-fractional-divider.c      |  27 +++-
>  drivers/clk/clk-fractional-divider_test.c | 157 ++++++++++++++++++++++
>  5 files changed, 186 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/clk/clk-fractional-divider_test.c
