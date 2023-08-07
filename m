Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFD3772474
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjHGMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjHGMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:44:09 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD748170A;
        Mon,  7 Aug 2023 05:44:04 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RKGGR5dwkz9sd0;
        Mon,  7 Aug 2023 14:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691412239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bNrvO4/+qMzoFjscos3JfShU7rKxrT6n1sp3kcgZX3M=;
        b=WA0f4EYxmYq6/5BmYfz4ZJHZcZHMvpEdOsZ0brD2muv8Wn0JuvAG8RaMjUDirA4fYJoptY
        bcfotV2tQNgaYHVqz9uKeTtlip6pfoymcTIC7dnUtlShkWvzl/VOx9jEswr6B52O3hnqcM
        NZkD75v7Xy814SDHB+0oYRmpK/7cHPKAZvueAPeUSZRsUAVw427anQNA70ghi/fxwwo//O
        IGg1VZC3+vML0H8ME4DCZnash4ZOVVbeTK/DBdxlmMkB0rFRNvHEOuHd5iwwh36zgQqpNi
        1Bu9kDO+88FgjQsAjlIITbzoqmrIbu+HkgOwogV93ksE/SnkcFAZiu/ACtVgng==
From:   Frank Oltmanns <frank@oltmanns.dev>
Subject: [PATCH v6 00/11] clk: sunxi-ng: Consider alternative parent rates
 when determining NKM clock rate
Date:   Mon, 07 Aug 2023 14:43:33 +0200
Message-Id: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXm0GQC/43QQW7DIBAF0KtErEsEDOA4q96jqiwMQ40aYwuQ1
 Sry3YuzSVpFVpd/MU//z5VkTAEzOR+uJOEScphiDfrlQOxg4gfS4GomgglgWmg6Xy50DHPoMpY
 umYLdbBLGQgE0eMucRu1JPZ8T+vB1o9/ea/ZpGmkZEpoHkHPWMi7hyEEI1VBOfTLx83W6lNHEm
 I8Olw0bQi5T+r7VXMRG/qPRIiijuoG2xV612onf7FZqgbvVMLFjQbWkdrY/GdPa3j6x5IPFmx1
 LVotJYz130DZaPbHU3TqxvY2qWq6XXlkD9f/wx1rX9QfEyK5y5AEAAA==
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9651; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=TLcLWbpiN9N80eG0Bamx9CGqzn3zJ8QDiaoWzv4D3k4=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk0OcJ1yW2jkl7wb/H9D4rkKiwokhRPZjkdICaA
 z3op1VArlKJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZNDnCQAKCRCaaaIIlErT
 xxy7C/9ILlhcMBZlDeSppghJAUo27grK0wtTOni4DP/AXvzoEoSR42QRuM/aNqGYYK1KpqsaZhS
 EcnnKL8aZGDvF7iEItaKbhxafq3imwcWO93NqYVy2OoEdeR4M/9ZE1+vRXne7Qn86FpFTQUrRJo
 mbfLPU6GATKvarCUgUxdbipG9aLi1CtWst9hdVACvEuMbiB97ziBmhvRCBEXQQ10dvyoVoYl9iw
 6HSSnm/qOklLl96otMHcZanwTvSm0ur1CeBFecSCHFK/HXNzcIOkqIYeoA+bCuOyTiOpEWMbuJf
 H0UBY30YFP8izIrk4nrSqxvn7Rbj68jRMdPHpIsHKWYWo+tbhljD4QD6E4O5WymzAFEX/MF/xAw
 t7n5nRWIHS4kNbecumv5TjQAvYqgOn2At3ixxGIiua4pc5x3aOs7NFujguurb+46qCyL0YOV9Lj
 LBPn8iHKUficCpWiEjaYeQjy/e4rdm4bvriPLqX69gd4P9EZ2syPBrUsGJUm8v1bF25WU=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RKGGR5dwkz9sd0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables NKM clocks to consider alternative parent rates
and utilize this new feature to adjust the pll-video0 clock on Allwinner
A64.

Furthermore, with this patchset pll-video0 considers rates that are
higher than the requested rate when finding the closest rate. In
consequence, higher rates are also considered by pll-video0's
descandents. In total, after applying this patchset, finding the closest
rate is supported by:
  - ccu_nm
  - ccu_nkm
  - ccu_mux
  - ccu_div

This allows us to achieve an optimal rate for driving the board's panel.

To provide some context, the clock structure involved in this process is
as follows:
    clock                       clock type
    --------------------------------------
    pll-video0                  ccu_nm
       pll-mipi                 ccu_nkm
          tcon0                 ccu_mux
             tcon-data-clock    sun4i_dclk

The divider between tcon0 and tcon-data-clock is fixed at 4. Therefore,
in order to achieve a rate that closely matches the desired rate of the
panel, pll-mipi needs to operate at a specific rate.

Tests
=====
So far, this has been successfully tested on the A64-based Pinephone
using three different panel rates:

 1. A panel rate that can be matched exactly by pll-video0.
 2. A panel rate that requires pll-video0 to undershoot to get the
    closest rate.
 3. A panel rate that requires pll-video0 to overshoot to get the
    closest rate.

Test records:

Re 1:
-----
Panel requests tcon-data-clock of 103500000 Hz, i.e., pll-mipi needs to
run at 414000000 Hz. This results in the following clock rates:
   clock                            rate
   -------------------------------------
    pll-video0                 207000000
       hdmi-phy-clk             51750000
       hdmi                    207000000
       tcon1                   207000000
       pll-mipi                414000000
          tcon0                414000000
             tcon-data-clock   103500000

The results of the find_best calls:
ccu_nkm_find_best_with_parent_adj: rate=414000000, best_rate=414000000, best_parent_rate=207000000, n=1, k=2, m=1
ccu_nkm_find_best_with_parent_adj: rate=414000000, best_rate=414000000, best_parent_rate=207000000, n=1, k=2, m=1
ccu_nkm_find_best_with_parent_adj: rate=414000000, best_rate=414000000, best_parent_rate=207000000, n=1, k=2, m=1
ccu_nkm_find_best_with_parent_adj: rate=414000000, best_rate=414000000, best_parent_rate=207000000, n=1, k=2, m=1
ccu_nkm_find_best: rate=414000000, best_rate=414000000, parent_rate=207000000, n=1, k=2, m=1

Re 2:
-----
Panel requests tcon-data-clock of 103650000 Hz, i.e., pll-mipi needs to
run at 414600000 Hz. This results in the following clock rates:
   clock                            rate
   -------------------------------------
    pll-video0                 282666666
       hdmi-phy-clk             70666666
       hdmi                    282666666
       tcon1                   282666666
       pll-mipi                414577776
          tcon0                414577776
             tcon-data-clock   103644444

The results of the find_best calls:
ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
ccu_nkm_find_best_with_parent_adj: rate=414577776, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
ccu_nkm_find_best_with_parent_adj: rate=414577776, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
ccu_nkm_find_best: rate=414577776, best_rate=414577776, parent_rate=282666666, n=11, k=2, m=15

Re 3:
-----
Panel requests tcon-data-clock of 112266000 Hz, i.e., pll-mipi needs to
run at 449064000 Hz. This results in the following clock rates:
   clock                            rate
   -------------------------------------
    pll-video0                 207272727
       hdmi-phy-clk             51818181
       hdmi                    207272727
       tcon1                   207272727
       pll-mipi                449090908
          tcon0                449090908
             tcon-data-clock   112272727

The results of the find_best calls:
ccu_nkm_find_best_with_parent_adj: rate=449064000, best_rate=449090908, best_parent_rate=207272727, n=13, k=2, m=12
ccu_nkm_find_best_with_parent_adj: rate=449064000, best_rate=449090908, best_parent_rate=207272727, n=13, k=2, m=12
ccu_nkm_find_best_with_parent_adj: rate=449090908, best_rate=449090908, best_parent_rate=207272727, n=13, k=2, m=12
ccu_nkm_find_best_with_parent_adj: rate=449090908, best_rate=449090908, best_parent_rate=207272727, n=13, k=2, m=12
ccu_nkm_find_best: rate=449090908, best_rate=449090908, parent_rate=207272727, n=13, k=2, m=12

Changelog:
----------
Changes in v6:
 - Removed unnecessary #include from ccu_nkm.c
 - Link to v5: https://lore.kernel.org/r/20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev

Changes in v5:
 - Remove the dedicated function for calculating the optimal parent rate
   for nkm clocks that was introduced in v2 and again in v4. Instead use
   a simple calculation and require the parent clock to select the
   closest rate to achieve optimal results.
 - Change the order of parameters of nkm_best_rate and
   nkm_best_rate_with_parent_adj as requested my Maxime Ripard.
 - Prefer to not reset the rate of the nkm clock's parent if the ideal
   rate can be reached using the parent's current rate, copying the
   behavior of ccu_mp.
 - Link to v4: https://lore.kernel.org/r/20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev

Changes in v4:
 - Re-introduce a dedicated function for calculating the optimal parent
   rate for nkm clocks that was introduced in v2 and removed in v3. It
   turned out that not having this functionality introduces a bug when
   the parent does not support finding the closest rate:
   https://lore.kernel.org/all/87pm4xg2ub.fsf@oltmanns.dev/
 - Incorporate review remarks:
    - Correcting the parameter name for ccu_nkm_round_rate()'s parent HW
      is now in a separate patch.
    - Use correct parameter order in ccu_nkm_find_best_with_parent_adj.
    - Add ccu_is_better_rate() and use it for determining the best rate
      for nm and nkm, as well as ccu_mux_helper_determine_rate.
    - Consistently introduce new macros for clock variants that support
      finding the closest rate instead of updating existing macros.
    - Use wrapper function for determining a ccu_mux's rate in order to
      support finding the closest rate.
 - Link to v3: https://lore.kernel.org/r/20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev

Changes in v3:
 - Use dedicated function for finding the best rate in cases where an
   nkm clock supports setting its parent's rate, streamlining it with
   the structure that is used in other sunxi-ng ccus such as ccu_mp
   (PATCH 1).
 - Therefore, remove the now obsolete comments that were introduced in
   v2 (PATCH 1).
 - Remove the dedicated function for calculating the optimal parent rate
   for nkm clocks that was introduced in v2. Instead use a simple
   calculation and require the parent clock to select the closest rate to
   achieve optimal results (PATCH 1).
 - Therefore, add support to set the closest rate for nm clocks (because
   pll-mipi's parent pll-video0 is an nm clock) and all clock types that
   are descendants of a64's pll-video0, i.e., nkm, mux, and div (PATCH 3
   et. seq.).
 - Link to v2: https://lore.kernel.org/all/20230611090143.132257-1-frank@oltmanns.dev/

Changes in V2:
 - Move optimal parent rate calculation to dedicated function
 - Choose a parent rate that does not to overshoot requested rate
 - Add comments to ccu_nkm_find_best
 - Make sure that best_parent_rate stays at original parent rate in the unlikely
   case that all combinations overshoot.

Link to V1:
https://lore.kernel.org/lkml/20230605190745.366882-1-frank@oltmanns.dev/

---
Frank Oltmanns (11):
      clk: sunxi-ng: nkm: Use correct parameter name for parent HW
      clk: sunxi-ng: nkm: consider alternative parent rates when determining rate
      clk: sunxi-ng: a64: allow pll-mipi to set parent's rate
      clk: sunxi-ng: Add feature to find closest rate
      clk: sunxi-ng: Add helper function to find closest rate
      clk: sunxi-ng: nm: Support finding closest rate
      clk: sunxi-ng: nkm: Support finding closest rate
      clk: sunxi-ng: mux: Support finding closest rate
      clk: sunxi-ng: div: Support finding closest rate
      clk: sunxi-ng: a64: select closest rate for pll-video0
      clk: sunxi-ng: nkm: Prefer current parent rate

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 36 ++++++++++-------------
 drivers/clk/sunxi-ng/ccu_common.c     | 12 ++++++++
 drivers/clk/sunxi-ng/ccu_common.h     |  6 ++++
 drivers/clk/sunxi-ng/ccu_div.h        | 30 +++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_mux.c        | 15 ++++++++--
 drivers/clk/sunxi-ng/ccu_mux.h        | 38 +++++++++++++++++-------
 drivers/clk/sunxi-ng/ccu_nkm.c        | 55 ++++++++++++++++++++++++++++++-----
 drivers/clk/sunxi-ng/ccu_nm.c         | 13 ++++-----
 drivers/clk/sunxi-ng/ccu_nm.h         | 48 ++++++++++++++++++++++++++++--
 9 files changed, 202 insertions(+), 51 deletions(-)
---
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230626-pll-mipi_set_rate_parent-3363fc0d6e6f

Best regards,
-- 
Frank Oltmanns <frank@oltmanns.dev>

