Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACCA7767C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHIS67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHIS66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:58:58 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D156E2127;
        Wed,  9 Aug 2023 11:58:41 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RLfTp2kn8z9tqw;
        Wed,  9 Aug 2023 20:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691607518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0YKvXT2KTxuKbCA3hfvQcc37tbMysXpUHS3VgATp4w=;
        b=b8GzOv6ExfexVopbHz3/mLUFMyxkjAeP4OSx1wHyTGUXoe+wG0fJsbu9N4cUOhD3/23fNT
        BgTdSAKas3t7GHhjELrgT3m2X/A1SOdbw0i7lWfdlXa93uBCGMwslj3D4CSWingZ1l0rn4
        yY9tHL3NABRz47D+OUJ+iuxsYYbMcWpNbtPPWb/hf/JPuuMM5SXgwJTtVCLcmOFEQ+QqmO
        b7EqSuHF0eltdIAX3p8yM0HxfO5HHE/FknFMiSDwUXm7/TPSqkP5zPThebTuQXidaKZmbP
        QRrcsDc8fm3EHEUSc7DeUw46U29Zmj4ZRNxGVng8nUwnK64gXEOB5DFzi0Fpsg==
References: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev>
 <CAGb2v66dU2Ao9hBiwgu32i7_svqMT+Pz=BVnN0ZvmLhFm+jy6A@mail.gmail.com>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     wens@csie.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/11] clk: sunxi-ng: Consider alternative parent
 rates when determining NKM clock rate
In-reply-to: <CAGb2v66dU2Ao9hBiwgu32i7_svqMT+Pz=BVnN0ZvmLhFm+jy6A@mail.gmail.com>
Date:   Wed, 09 Aug 2023 20:58:21 +0200
Message-ID: <877cq42gc2.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4RLfTp2kn8z9tqw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-08-10 at 00:44:53 +0800, Chen-Yu Tsai <wens@csie.org> wrote:
> On Mon, Aug 7, 2023 at 8:44=E2=80=AFPM Frank Oltmanns <frank@oltmanns.dev=
> wrote:
>>
>> This patchset enables NKM clocks to consider alternative parent rates
>> and utilize this new feature to adjust the pll-video0 clock on Allwinner
>> A64.
>>
>> Furthermore, with this patchset pll-video0 considers rates that are
>> higher than the requested rate when finding the closest rate. In
>> consequence, higher rates are also considered by pll-video0's
>> descandents. In total, after applying this patchset, finding the closest
>> rate is supported by:
>>   - ccu_nm
>>   - ccu_nkm
>>   - ccu_mux
>>   - ccu_div
>>
>> This allows us to achieve an optimal rate for driving the board's panel.
>>
>> To provide some context, the clock structure involved in this process is
>> as follows:
>>     clock                       clock type
>>     --------------------------------------
>>     pll-video0                  ccu_nm
>>        pll-mipi                 ccu_nkm
>>           tcon0                 ccu_mux
>>              tcon-data-clock    sun4i_dclk
>>
>> The divider between tcon0 and tcon-data-clock is fixed at 4. Therefore,
>> in order to achieve a rate that closely matches the desired rate of the
>> panel, pll-mipi needs to operate at a specific rate.
>>
>> Tests
>> =3D=3D=3D=3D=3D
>> So far, this has been successfully tested on the A64-based Pinephone
>> using three different panel rates:
>>
>>  1. A panel rate that can be matched exactly by pll-video0.
>>  2. A panel rate that requires pll-video0 to undershoot to get the
>>     closest rate.
>>  3. A panel rate that requires pll-video0 to overshoot to get the
>>     closest rate.
>>
>> Test records:
>>
>> Re 1:
>> -----
>> Panel requests tcon-data-clock of 103500000 Hz, i.e., pll-mipi needs to
>> run at 414000000 Hz. This results in the following clock rates:
>>    clock                            rate
>>    -------------------------------------
>>     pll-video0                 207000000
>>        hdmi-phy-clk             51750000
>>        hdmi                    207000000
>>        tcon1                   207000000
>>        pll-mipi                414000000
>>           tcon0                414000000
>>              tcon-data-clock   103500000
>>
>> The results of the find_best calls:
>> ccu_nkm_find_best_with_parent_adj: rate=3D414000000, best_rate=3D4140000=
00, best_parent_rate=3D207000000, n=3D1, k=3D2, m=3D1
>> ccu_nkm_find_best_with_parent_adj: rate=3D414000000, best_rate=3D4140000=
00, best_parent_rate=3D207000000, n=3D1, k=3D2, m=3D1
>> ccu_nkm_find_best_with_parent_adj: rate=3D414000000, best_rate=3D4140000=
00, best_parent_rate=3D207000000, n=3D1, k=3D2, m=3D1
>> ccu_nkm_find_best_with_parent_adj: rate=3D414000000, best_rate=3D4140000=
00, best_parent_rate=3D207000000, n=3D1, k=3D2, m=3D1
>> ccu_nkm_find_best: rate=3D414000000, best_rate=3D414000000, parent_rate=
=3D207000000, n=3D1, k=3D2, m=3D1
>>
>> Re 2:
>> -----
>> Panel requests tcon-data-clock of 103650000 Hz, i.e., pll-mipi needs to
>> run at 414600000 Hz. This results in the following clock rates:
>>    clock                            rate
>>    -------------------------------------
>>     pll-video0                 282666666
>>        hdmi-phy-clk             70666666
>>        hdmi                    282666666
>>        tcon1                   282666666
>>        pll-mipi                414577776
>>           tcon0                414577776
>>              tcon-data-clock   103644444
>>
>> The results of the find_best calls:
>> ccu_nkm_find_best_with_parent_adj: rate=3D414600000, best_rate=3D4145777=
76, best_parent_rate=3D282666666, n=3D11, k=3D2, m=3D15
>> ccu_nkm_find_best_with_parent_adj: rate=3D414600000, best_rate=3D4145777=
76, best_parent_rate=3D282666666, n=3D11, k=3D2, m=3D15
>> ccu_nkm_find_best_with_parent_adj: rate=3D414577776, best_rate=3D4145777=
76, best_parent_rate=3D282666666, n=3D11, k=3D2, m=3D15
>> ccu_nkm_find_best_with_parent_adj: rate=3D414577776, best_rate=3D4145777=
76, best_parent_rate=3D282666666, n=3D11, k=3D2, m=3D15
>> ccu_nkm_find_best: rate=3D414577776, best_rate=3D414577776, parent_rate=
=3D282666666, n=3D11, k=3D2, m=3D15
>>
>> Re 3:
>> -----
>> Panel requests tcon-data-clock of 112266000 Hz, i.e., pll-mipi needs to
>> run at 449064000 Hz. This results in the following clock rates:
>>    clock                            rate
>>    -------------------------------------
>>     pll-video0                 207272727
>>        hdmi-phy-clk             51818181
>>        hdmi                    207272727
>>        tcon1                   207272727
>>        pll-mipi                449090908
>>           tcon0                449090908
>>              tcon-data-clock   112272727
>>
>> The results of the find_best calls:
>> ccu_nkm_find_best_with_parent_adj: rate=3D449064000, best_rate=3D4490909=
08, best_parent_rate=3D207272727, n=3D13, k=3D2, m=3D12
>> ccu_nkm_find_best_with_parent_adj: rate=3D449064000, best_rate=3D4490909=
08, best_parent_rate=3D207272727, n=3D13, k=3D2, m=3D12
>> ccu_nkm_find_best_with_parent_adj: rate=3D449090908, best_rate=3D4490909=
08, best_parent_rate=3D207272727, n=3D13, k=3D2, m=3D12
>> ccu_nkm_find_best_with_parent_adj: rate=3D449090908, best_rate=3D4490909=
08, best_parent_rate=3D207272727, n=3D13, k=3D2, m=3D12
>> ccu_nkm_find_best: rate=3D449090908, best_rate=3D449090908, parent_rate=
=3D207272727, n=3D13, k=3D2, m=3D12
>>
>> Changelog:
>> ----------
>> Changes in v6:
>>  - Removed unnecessary #include from ccu_nkm.c
>>  - Link to v5: https://lore.kernel.org/r/20230806-pll-mipi_set_rate_pare=
nt-v5-0-db4f5ca33fc3@oltmanns.dev
>>
>> Changes in v5:
>>  - Remove the dedicated function for calculating the optimal parent rate
>>    for nkm clocks that was introduced in v2 and again in v4. Instead use
>>    a simple calculation and require the parent clock to select the
>>    closest rate to achieve optimal results.
>>  - Change the order of parameters of nkm_best_rate and
>>    nkm_best_rate_with_parent_adj as requested my Maxime Ripard.
>>  - Prefer to not reset the rate of the nkm clock's parent if the ideal
>>    rate can be reached using the parent's current rate, copying the
>>    behavior of ccu_mp.
>>  - Link to v4: https://lore.kernel.org/r/20230717-pll-mipi_set_rate_pare=
nt-v4-0-04acf1d39765@oltmanns.dev
>>
>> Changes in v4:
>>  - Re-introduce a dedicated function for calculating the optimal parent
>>    rate for nkm clocks that was introduced in v2 and removed in v3. It
>>    turned out that not having this functionality introduces a bug when
>>    the parent does not support finding the closest rate:
>>    https://lore.kernel.org/all/87pm4xg2ub.fsf@oltmanns.dev/
>>  - Incorporate review remarks:
>>     - Correcting the parameter name for ccu_nkm_round_rate()'s parent HW
>>       is now in a separate patch.
>>     - Use correct parameter order in ccu_nkm_find_best_with_parent_adj.
>>     - Add ccu_is_better_rate() and use it for determining the best rate
>>       for nm and nkm, as well as ccu_mux_helper_determine_rate.
>>     - Consistently introduce new macros for clock variants that support
>>       finding the closest rate instead of updating existing macros.
>>     - Use wrapper function for determining a ccu_mux's rate in order to
>>       support finding the closest rate.
>>  - Link to v3: https://lore.kernel.org/r/20230702-pll-mipi_set_rate_pare=
nt-v3-0-46dcb8aa9cbc@oltmanns.dev
>>
>> Changes in v3:
>>  - Use dedicated function for finding the best rate in cases where an
>>    nkm clock supports setting its parent's rate, streamlining it with
>>    the structure that is used in other sunxi-ng ccus such as ccu_mp
>>    (PATCH 1).
>>  - Therefore, remove the now obsolete comments that were introduced in
>>    v2 (PATCH 1).
>>  - Remove the dedicated function for calculating the optimal parent rate
>>    for nkm clocks that was introduced in v2. Instead use a simple
>>    calculation and require the parent clock to select the closest rate to
>>    achieve optimal results (PATCH 1).
>>  - Therefore, add support to set the closest rate for nm clocks (because
>>    pll-mipi's parent pll-video0 is an nm clock) and all clock types that
>>    are descendants of a64's pll-video0, i.e., nkm, mux, and div (PATCH 3
>>    et. seq.).
>>  - Link to v2: https://lore.kernel.org/all/20230611090143.132257-1-frank=
@oltmanns.dev/
>>
>> Changes in V2:
>>  - Move optimal parent rate calculation to dedicated function
>>  - Choose a parent rate that does not to overshoot requested rate
>>  - Add comments to ccu_nkm_find_best
>>  - Make sure that best_parent_rate stays at original parent rate in the =
unlikely
>>    case that all combinations overshoot.
>>
>> Link to V1:
>> https://lore.kernel.org/lkml/20230605190745.366882-1-frank@oltmanns.dev/
>>
>> ---
>> Frank Oltmanns (11):
>>       clk: sunxi-ng: nkm: Use correct parameter name for parent HW
>>       clk: sunxi-ng: nkm: consider alternative parent rates when determi=
ning rate
>>       clk: sunxi-ng: a64: allow pll-mipi to set parent's rate
>>       clk: sunxi-ng: Add feature to find closest rate
>>       clk: sunxi-ng: Add helper function to find closest rate
>>       clk: sunxi-ng: nm: Support finding closest rate
>>       clk: sunxi-ng: nkm: Support finding closest rate
>>       clk: sunxi-ng: mux: Support finding closest rate
>>       clk: sunxi-ng: div: Support finding closest rate
>>       clk: sunxi-ng: a64: select closest rate for pll-video0
>>       clk: sunxi-ng: nkm: Prefer current parent rate
>
> Whole series applied. There were some conflicts on patch 10 I had to
> fix up. I also took the liberty of realigning some of the lines.
> Please check if things are correct:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?h=
=3Dsunxi/clk-for-6.6&id=3Dbf8eb12f52c49e10ca1d86564bfa096e09c51c38
>

Thank you. I'm sorry, I used the wrong base-commit. Yours looks perfect!

Also thank you for re-indenting. Looks cleaner.

Best regards,
  Frank

>
> ChenYu
>
>>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 36 ++++++++++-------------
>>  drivers/clk/sunxi-ng/ccu_common.c     | 12 ++++++++
>>  drivers/clk/sunxi-ng/ccu_common.h     |  6 ++++
>>  drivers/clk/sunxi-ng/ccu_div.h        | 30 +++++++++++++++++++
>>  drivers/clk/sunxi-ng/ccu_mux.c        | 15 ++++++++--
>>  drivers/clk/sunxi-ng/ccu_mux.h        | 38 +++++++++++++++++-------
>>  drivers/clk/sunxi-ng/ccu_nkm.c        | 55 ++++++++++++++++++++++++++++=
++-----
>>  drivers/clk/sunxi-ng/ccu_nm.c         | 13 ++++-----
>>  drivers/clk/sunxi-ng/ccu_nm.h         | 48 ++++++++++++++++++++++++++++=
--
>>  9 files changed, 202 insertions(+), 51 deletions(-)
>> ---
>> base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
>> change-id: 20230626-pll-mipi_set_rate_parent-3363fc0d6e6f
>>
>> Best regards,
>> --
>> Frank Oltmanns <frank@oltmanns.dev>
>>
