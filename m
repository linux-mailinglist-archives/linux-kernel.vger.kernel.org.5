Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA03769AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjGaP3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGaP3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:29:33 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C65CD8;
        Mon, 31 Jul 2023 08:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690817372; x=1722353372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r6p4UYBzZIcZlPsVkiH+JqrhWJB+PYumP6aR3T61fa8=;
  b=mr/TgK1W0tyH4LWLHIlSv8Inrb7Qfo7tuqgZ5CnsB5qZdbDJOBnmSNxH
   j+wtV/tf6Xgw2v42KQpwEUlGaPl8C9BPwLflfutqQ8MzJI3rPTmincCRo
   2jyd55hvooySrfYmcgiLv5/C+9H5AmagXIJqeN44GBKU0gvHFZHoAkGH5
   mlybEja+2KM3Jt2FPNyWtsFMvIgDzg9CusCqYXtPHG+ujQVKgWrdfy42g
   ANHo9QOrZQdKK3o1DzgcEGDgrdAzakdb1Gut94dn+bL5jSctTfgk7k+V4
   cOfjru4rbdukUpVDkS9m/Onv0wRUZltqxDvk6V6otLtUSpP2/tA5z3ft0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="432866617"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="432866617"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 08:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852096003"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="852096003"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 08:29:28 -0700
Message-ID: <e5d23a32-1ac5-d6a8-c9a4-15dfdd96ace8@intel.com>
Date:   Mon, 31 Jul 2023 18:29:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH V9 00/23] Add support UHS-II for GL9755
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230721101349.12387-1-victorshihgli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230721101349.12387-1-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/23 13:13, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> 
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
> 
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
> 
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
> 
> Patch structure
> ===============
> patch#1-#6:  for core
> patch#7-#22: for sdhci
> patch#23:    for GL9755
> 
> Changes in v9 (July. 21, 2023)
> * rebased to the linux-kernel-v6.5.0-rc1 in Ulf Hansson next branch.
> * according to the comments provided by Adrian Hunter to modify the
>   patches base on the [V8 00/23] Add support UHS-II for GL9755.
> * Patch#2: move sd_uhs2_operation definition of PatchV8[05/23]
>            to PatchV9[02/23] for avoid compilation errors.
>            move uhs2_control definition of PatchV8[05/23]
>            to PatchV9[02/23] for avoid compilation errors.
>            move mmc_host flags definition of PatchV8[05/23]
>            to PatchV9[02/23] for avoid compilation errors.
>            move mmc_host flags MMC_UHS2_SUPPORT definition of
>            PatchV8[05/23] to PatchV9[02/23] for avoid compilation errors.
>            move mmc_host flags MMC_UHS2_SD_TRAN definition of
>            PatchV8[05/23] to PatchV9[02/23] for avoid compilation errors.
> * Patch#7: Modify the commit message.
> * Patch#8: Modify the commit message.
> * Patch#11: Modify annotations in sdhci_get_vdd_value().
> * Patch#14: Simplity the turning_on_clk in sdhci_set_ios().
> * Patch#18: Modify the annotations in __sdhci_uhs2_send_command().
> * Patch#19: Cancel export state of sdhci_set_mrq_done() function.
> * Patch#23: Rename gl9755_pre_detect_init() to sdhci_gli_pre_detect_init().
>             Rename gl9755_uhs2_reset_sd_tran() to
>             sdhci_gli_uhs2_reset_sd_tran().
> 
> Reference
> =========
> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230621100151.6329-1-victorshihgli@gmail.com/
> 
> ----------------- original cover letter from v8 -----------------
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> 
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
> 
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
> 
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
> 
> Patch structure
> ===============
> patch#1-#6:  for core
> patch#7-#22: for sdhci
> patch#23:    for GL9755
> 
> Changes in v8 (June. 21, 2023)
> * rebased to the linux-kernel-v6.4.0-rc6 in Ulf Hansson next branch.
> * fix most of checkpatch warnings/errors.
> * according to the comments provided by Adrian Hunter to modify the
>   patches base on the [V7 00/23] Add support UHS-II for GL9755.
> * Patch#6: Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
>            Modify return value in sd_uhs2_attach().
> * Patch#7: Use tabs instead of spaces.
> * Patch#8: Modify MODULE_LICENSE from "GPL v2" to "GPL".
> * Patch#10: Adjust the position of matching brackets.
> * Patch#11: Adjust the position of matching brackets.
>             Add the initial value of the pwr in sdhci_uhs2_set_power().
> * Patch#13: Initialization be combined with declaration and realigned
>             in sdhci_calc_timeout_uhs2().
>             Forward declare struct mmc_command in sdhci_uhs2.h.
> * Patch#14: Add the judgment formula for MMC_TIMING_SPEED_A_HD,
>             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
>             __sdhci_uhs2_set_ios().
>             Add the switch case for MMC_TIMING_SPEED_A_HD,
>             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
>             sdhci_get_preset_value().
>             mmc_opt_regulator_set_ocr() to instead of
>             mmc_regulator_set_ocr() in sdhci_uhs2_set_ios().
> * Patch#15: usleep_range() to instead of udelay() in
>             sdhci_uhs2_interface_detect().
>             read_poll_timeout() to instead of read_poll_timeout_atomic()
>             in sdhci_uhs2_interface_detect().
>             Modify return value in sdhci_uhs2_do_detect_init().
> * Patch#16: Remove unnecessary include file.
>             read_poll_timeout() to instead of read_poll_timeout_atomic()
>             in sdhci_uhs2_enable_clk().
>             Put the comment on the end and put the lines in descending
>             line length in sdhci_uhs2_enable_clk().
>             Modify return value in sdhci_uhs2_enable_clk().
> * Patch#17: Reorder the definitions and lose the parentheses in
>             sdhci_uhs2_set_config().
>             read_poll_timeout() to instead of read_poll_timeout_atomic()
>             in sdhci_uhs2_check_dormant().
> * Patch#18: Adjust the position of matching brackets in
>             sdhci_uhs2_send_command_retry().
>             Modify CameCase definition in __sdhci_uhs2_finish_command().
>             Modify error message in __sdhci_uhs2_finish_command().
>             sdhci_uhs2_send_command_retry() to instead of
>             sdhci_uhs2_send_command() in sdhci_uhs2_request().
>             Use sdhci_uhs2_mode() to simplify code in
>             sdhci_uhs2_request_atomic().
>             Add forward declaration for sdhci_send_command().
> * Patch#19: Forward declare struct mmc_request in sdhci_uhs2.h.
>             Remove forward declaration of sdhci_send_command().
>             Use mmc_dev() to simplify code in sdhci_request_done_dma().
> * Patch#20: Change return type to void for __sdhci_uhs2_add_host_v4().
>             Remove unused variables in __sdhci_uhs2_add_host_v4().
> * Patch#22: Add config select MMC_SDHCI_UHS2 in Kconfig.
> * Patch#23: Use sdhci_get_vdd_value() to simplify code in 
>             gl9755_set_power().
>             Use read_poll_timeout_atomic() to simplify code in
>             sdhci_wait_clock_stable().
>             Use read_poll_timeout_atomic() to simplify code in
>             sdhci_gl9755_reset().
> 
> Reference
> =========
> [1] https://gitlab.com/VictorShih/linux-uhs2.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230331105546.13607-1-victor.shih@genesyslogic.com.tw/
> 
> ----------------- original cover letter from v7 -----------------
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> 
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
>   [2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
>   Setup Sequence.
> 
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
>   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
>   Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
> 
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
> 
> Patch structure
> ===============
> patch#1-#6:  for core
> patch#7-#22: for sdhci
> patch#23:    for GL9755

For patches 7 - 23:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

