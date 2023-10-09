Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E1B7BD87E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbjJIK0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbjJIK0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:26:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8579199;
        Mon,  9 Oct 2023 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696847208; x=1728383208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S1l/fw0soDOrQwjCkmNHYr7DgrjWlS+RPFsltmZ9bR8=;
  b=ThK9d7uLx79qV+miNv0sqciUnLk40KPVTiKFtw30IpYVagRvAoJLBDBN
   vBhKN+XbTE9H3b9rPge+igFE86blW6KlKDlOeALVxqecjlhnAn3NwLG3k
   VTukU5JnJ2jcyBs/m0h9AcIAAeeWQi5NrPzhxZorUE7HihYS9DQeafpCY
   fHCwsPO6LbvfJ0dwayh2pWKQExXY5sx+GntS0hEOWLZQpB7EzhTEodCtA
   FXgWI0uHtGph2yj9uIJG7HdoXZr0RYmRqhWbFPGcb16ASvsEEbjJhiG94
   1HapjqBTw5kc9wRUQ010E9U0YSvmCABFqnJFHpZbBsazJOBk/h9ye7cgx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="386956921"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="386956921"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="746625130"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="746625130"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.36.27])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:26:45 -0700
Message-ID: <05d0ff56-e227-45c5-a24a-b2c7e5951534@intel.com>
Date:   Mon, 9 Oct 2023 13:26:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] mmc: sdhci-pci-o2micro: Fix Bayhub SD host
 hardware tuning compatibility issue for BanQ card
Content-Language: en-US
To:     =?UTF-8?B?5YiY55WF?= <liuchang_125125@163.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaper.liu@bayhubtech.com,
        chevron.li@bayhubtech.com, thomas.hu@bayhubtech.com,
        charl.liu@bayhubtech.com
References: <20230928102202.8393-1-liuchang_125125@163.com>
 <529b935f-dc21-4889-8fb1-04eea7ab511c@intel.com>
 <215186cb.1b46.18b1249201f.Coremail.liuchang_125125@163.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <215186cb.1b46.18b1249201f.Coremail.liuchang_125125@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/23 05:34, 刘畅 wrote:
> 
> At 2023-09-29 14:00:45, "Adrian Hunter" <adrian.hunter@intel.com> wrote:
>>On 28/09/23 13:22, liuchang_125125@163.com wrote:
>>> From: Charl Liu <liuchang_125125@163.com>
>>> 
>>> 1.Driver get the card's MID and OID by init_card callback
>>> function to judge whether the card is BanQ card
>>> 2.Update tuning setting to make sure tuning done can be set
>>> 3.Stop transfer for CMD19 after tuning done is set to avoid data
>>> line inhibit and then set input phase manually for BanQ card
>>
>>Changing each driver for each card is not a scalable way to
>>do things.
>>
> 
> This solution is suitable for cards that take longer time (>150 ns) to handle CMD19. So far, it is only found that BanQ card belongs to the above-mentioned cards.
> 
>>What is different about banq cards than other cards?
>>
> 
> In the tuning stage, if the interval between BanQ card receiving
> the data of the previous CMD19 and host sending the next CMD19
> is less than 330ns, BanQ card will not return data pattern to host,
> which will result in tuning timeout error.

So why not just recover from the timeout error when it happens
instead of checking for BanQ card?

> Other cards do not have this issue.
> 
>>What is wrong with the way sdhci-pci-o2micro does tuning?
>>
> 
> In order to reduce tuning time, O2/Bayhub use hardware tuning which
> is suitable for cards that respond quickly to CMD19.
> Host will automatically send next CMD19 after receiving data pattern returned by card.
> The interval is very short (about 150 ns), and less than 330ns,
> which will result in the compatibility issue.
> 
>>> 
>>> Signed-off-by: Charl Liu <liuchang_125125@163.com>
>>> ---
>>> Change in V1:
>>> Update the tuning process to be compatibility with BanQ card.
>>> 
>>> Change in V2:
>>> Remove unused variables in order to fix compilation warnings
>>> noticed by kernel test robot.
>>> ---
>>>  drivers/mmc/host/sdhci-pci-o2micro.c | 201 ++++++++++++++++++++++++---
>>>  1 file changed, 179 insertions(+), 22 deletions(-)
>>> 
>>> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
>>> index 7bfee28116af..668de44c6ba2 100644
>>> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
>>> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
>>> @@ -36,6 +36,7 @@
>>>  #define O2_SD_MISC_CTRL2	0xF0
>>>  #define O2_SD_INF_MOD		0xF1
>>>  #define O2_SD_MISC_CTRL4	0xFC
>>> +#define O2_SD_DLL_CTRL		0x1B0
>>>  #define O2_SD_MISC_CTRL		0x1C0
>>>  #define O2_SD_EXP_INT_REG	0x1E0
>>>  #define O2_SD_PWR_FORCE_L0	0x0002
>>> @@ -78,7 +79,8 @@ static const u32 dmdn_table[] = {0x2B1C0000,
>>>  #define DMDN_SZ ARRAY_SIZE(dmdn_table)
>>>  
>>>  struct o2_host {
>>> -	u8 dll_adjust_count;
>>> +	u8 dll_adjust_count: 4;
>>> +	u8 banq_card_setting: 4;
>>>  };
>>>  
>>>  static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
>>> @@ -311,14 +313,101 @@ static int sdhci_o2_dll_recovery(struct sdhci_host *host)
>>>  	return ret;
>>>  }
>>>  
>>> +static void sdhci_o2_send_stop_transmission(struct sdhci_host *host)
>>> +{
>>> +	struct mmc_host *mmc = host->mmc;
>>> +	struct mmc_command cmd = {};
>>> +	struct mmc_request mrq = {};
>>> +
>>> +	cmd.opcode = MMC_STOP_TRANSMISSION;
>>> +	cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
>>> +	cmd.busy_timeout = 150;
>>> +
>>> +	mrq.cmd = &cmd;
>>> +
>>> +	mmc_wait_for_req(mmc, &mrq);
>>> +
>>> +	/*
>>> +	 * Command CRC error may occur due to compatibility issue.
>>> +	 * It is normal and ignore it here.
>>> +	 */
>>> +	if ((cmd.error != 0) && (cmd.error != -EILSEQ))
>>> +		pr_err("%s: CMD12 error: %d\n", mmc_hostname(mmc), cmd.error);
>>> +}
>>> +
>>> +static void sdhci_o2_tuning_setting(struct mmc_host *mmc, bool isbanq, u8 phase_num)
>>> +{
>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
>>> +	struct sdhci_pci_chip *chip = slot->chip;
>>> +	u32 reg_val;
>>> +
>>> +	if (isbanq) {
>>> +		/* update tuning command times for BanQ card */
>>> +		pci_read_config_dword(chip->pdev, O2_SD_TUNING_CTRL, &reg_val);
>>> +		reg_val &= 0x00FFFFFF;
>>> +		reg_val |= 0x02000000;
>>> +		pci_write_config_dword(chip->pdev, O2_SD_TUNING_CTRL, reg_val);
>>> +	} else {
>>> +		reg_val = sdhci_readl(host, O2_SD_DLL_CTRL);
>>> +		reg_val &= ~BIT(28);
>>> +		sdhci_writel(host, reg_val, O2_SD_DLL_CTRL);
>>> +
>>> +		/* Update tuning command times for normal card */
>>> +		pci_read_config_dword(chip->pdev, O2_SD_TUNING_CTRL, &reg_val);
>>> +		reg_val &= 0x00FFFFFF;
>>> +		reg_val |= (phase_num * 3) << 24;
>>> +		pci_write_config_dword(chip->pdev, O2_SD_TUNING_CTRL, reg_val);
>>> +	}
>>> +}
>>> +
>>> +static void sdhci_o2_configure_banq_best_input_phase(struct sdhci_host *host)
>>> +{
>>> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
>>> +	struct sdhci_pci_chip *chip = slot->chip;
>>> +
>>> +	u16 dll_phase_configure = 0;
>>> +	u16 best_input_phase = 0;
>>> +
>>> +	switch (chip->pdev->device) {
>>> +	case PCI_DEVICE_ID_O2_FUJIN2:
>>> +		best_input_phase = 0x0;
>>> +		break;
>>> +
>>> +	case PCI_DEVICE_ID_O2_SEABIRD0:
>>> +	case PCI_DEVICE_ID_O2_SEABIRD1:
>>> +		best_input_phase = 0x0;
>>> +		break;
>>> +
>>> +	case PCI_DEVICE_ID_O2_GG8_9860:
>>> +	case PCI_DEVICE_ID_O2_GG8_9861:
>>> +	case PCI_DEVICE_ID_O2_GG8_9862:
>>> +	case PCI_DEVICE_ID_O2_GG8_9863:
>>> +		best_input_phase = 0xB;
>>> +		break;
>>> +
>>> +	default:
>>> +		break;
>>> +	}
>>> +
>>> +	/* configure the best input phase (0xB) for BanQ card */
>>> +	dll_phase_configure = sdhci_readw(host, 0x1B2);
>>> +	dll_phase_configure = (dll_phase_configure & (u16)0xF0FF) |
>>> +		(best_input_phase << 8) | BIT(12);
>>> +	sdhci_writew(host, dll_phase_configure, 0x1B2);
>>> +}
>>> +
>>>  static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>  {
>>>  	struct sdhci_host *host = mmc_priv(mmc);
>>>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
>>>  	struct sdhci_pci_chip *chip = slot->chip;
>>> +	struct o2_host *o2_host = sdhci_pci_priv(slot);
>>>  	int current_bus_width = 0;
>>>  	u32 scratch32 = 0;
>>> +	u16 data_timeout_counter_value = 0;
>>>  	u16 scratch = 0;
>>> +	u8 phase_num = 0;
>>>  	u8  scratch_8 = 0;
>>>  	u32 reg_val;
>>>  
>>> @@ -334,6 +423,31 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>  	if (WARN_ON(!mmc_op_tuning(opcode)))
>>>  		return -EINVAL;
>>>  
>>> +	if ((chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9860) ||
>>> +		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9861) ||
>>> +		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9862) ||
>>> +		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9863)) {
>>> +		phase_num = 14;
>>> +	} else {
>>> +		phase_num = 11;
>>> +	}
>>> +
>>> +	/* UnLock WP */
>>> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
>>> +	scratch_8 &= 0x7f;
>>> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>>> +
>>> +	sdhci_o2_tuning_setting(mmc, (bool)o2_host->banq_card_setting, phase_num);
>>> +
>>> +	if (o2_host->banq_card_setting) {
>>> +		/*
>>> +		 * set data timeout counter value to 0 to ensure that
>>> +		 * the tuning process can be completed
>>> +		 */
>>> +		data_timeout_counter_value = sdhci_readw(host, SDHCI_TIMEOUT_CONTROL);
>>> +		sdhci_writew(host, data_timeout_counter_value & (u16)0xFFF0, SDHCI_TIMEOUT_CONTROL);
>>> +	}
>>> +
>>>  	/* Force power mode enter L0 */
>>>  	scratch = sdhci_readw(host, O2_SD_MISC_CTRL);
>>>  	scratch |= O2_SD_PWR_FORCE_L0;
>>> @@ -351,23 +465,13 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>  		reg_val &= ~SDHCI_CLOCK_CARD_EN;
>>>  		sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
>>>  
>>> -		if (host->timing == MMC_TIMING_MMC_HS200 ||
>>> -		    host->timing == MMC_TIMING_UHS_SDR104) {
>>> -			/* UnLock WP */
>>> -			pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
>>> -			scratch_8 &= 0x7f;
>>> -			pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>>> -
>>> +		if ((host->timing == MMC_TIMING_MMC_HS200) ||
>>> +			(host->timing == MMC_TIMING_UHS_SDR104)) {
>>>  			/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
>>>  			pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
>>>  			reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
>>>  			reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
>>>  			pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
>>> -
>>> -			/* Lock WP */
>>> -			pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
>>> -			scratch_8 |= 0x80;
>>> -			pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>>>  		}
>>>  
>>>  		/* Start clk */
>>> @@ -375,10 +479,19 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>  		reg_val |= SDHCI_CLOCK_CARD_EN;
>>>  		sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
>>>  		break;
>>> +	case PCI_DEVICE_ID_O2_GG8_9860:
>>> +	case PCI_DEVICE_ID_O2_GG8_9861:
>>> +	case PCI_DEVICE_ID_O2_GG8_9862:
>>> +	case PCI_DEVICE_ID_O2_GG8_9863:
>>>  	default:
>>>  		break;
>>>  	}
>>>  
>>> +	/* Lock WP */
>>> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
>>> +	scratch_8 |= 0x80;
>>> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>>> +
>>>  	/* wait DLL lock, timeout value 5ms */
>>>  	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
>>>  		scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
>>> @@ -416,6 +529,20 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>  		sdhci_set_bus_width(host, current_bus_width);
>>>  	}
>>>  
>>> +	/* update input phase for BanQ card */
>>> +	if (o2_host->banq_card_setting) {
>>> +		/* recover the data timeout counter value */
>>> +		sdhci_writew(host, data_timeout_counter_value, SDHCI_TIMEOUT_CONTROL);
>>> +
>>> +		/*
>>> +		 * Stop transfer for CMD19 after tuning done is set to
>>> +		 * avoid data line inhibit
>>> +		 */
>>> +		sdhci_o2_send_stop_transmission(host);
>>> +
>>> +		sdhci_o2_configure_banq_best_input_phase(host);
>>> +	}
>>> +
>>>  	/* Cancel force power mode enter L0 */
>>>  	scratch = sdhci_readw(host, O2_SD_MISC_CTRL);
>>>  	scratch &= ~(O2_SD_PWR_FORCE_L0);
>>> @@ -428,6 +555,24 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>  	return 0;
>>>  }
>>>  
>>> +static void sdhci_o2_init_card(struct mmc_host *mmc, struct mmc_card *card)
>>> +{
>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
>>> +	struct o2_host *o2_host = sdhci_pci_priv(slot);
>>> +	unsigned int manfid;
>>> +	unsigned short oemid;
>>> +
>>> +	manfid = card->raw_cid[0] >> 24;
>>> +	oemid = (card->raw_cid[0] >> 8) & 0xFFFF;
>>> +
>>> +	/* judge whether the card is BanQ card */
>>> +	if (manfid == 0x89 && oemid == 0x303)
>>> +		o2_host->banq_card_setting = 1;
>>> +	else
>>> +		o2_host->banq_card_setting = 0;
>>> +}
>>> +
>>>  static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
>>>  {
>>>  	int ret;
>>> @@ -596,15 +741,20 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>>>  	scratch &= 0x7f;
>>>  	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>>>  
>>> -	if (chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9860 ||
>>> -	    chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9861 ||
>>> -	    chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9862 ||
>>> -	    chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9863) {
>>> +	if ((chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9860) ||
>>> +		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9861) ||
>>> +		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9862) ||
>>> +		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9863)) {
>>>  		dmdn_208m = 0x2c500000;
>>>  		dmdn_200m = 0x25200000;
>>>  	} else {
>>>  		dmdn_208m = 0x2c280000;
>>>  		dmdn_200m = 0x25100000;
>>> +
>>> +		/* open-clock for old project */
>>> +		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
>>> +		scratch_32 &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
>>> +		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
>>>  	}
>>>  
>>>  	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
>>> @@ -619,10 +769,6 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>>>  			o2_pci_set_baseclk(chip, dmdn_200m);
>>>  	}
>>>  
>>> -	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
>>> -	scratch_32 &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
>>> -	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
>>> -
>>>  	/* Lock WP */
>>>  	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
>>>  	scratch |= 0x80;
>>> @@ -632,6 +778,11 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>>>  	sdhci_o2_enable_clk(host, clk);
>>>  }
>>>  
>>> +static void sdhci_o2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>> +{
>>> +	sdhci_writeb(host, 0x0E, SDHCI_TIMEOUT_CONTROL);
>>> +}
>>> +
>>>  static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  {
>>>  	struct sdhci_host *host = mmc_priv(mmc);
>>> @@ -705,6 +856,7 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>>>  	host = slot->host;
>>>  
>>>  	o2_host->dll_adjust_count = 0;
>>> +	o2_host->banq_card_setting = 0;
>>>  	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>>>  
>>>  	/*
>>> @@ -718,7 +870,9 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>>>  
>>>  	sdhci_pci_o2_enable_msi(chip, host);
>>>  
>>> +	host->mmc_host_ops.init_card = sdhci_o2_init_card;
>>>  	host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
>>> +
>>>  	switch (chip->pdev->device) {
>>>  	case PCI_DEVICE_ID_O2_SDS0:
>>>  	case PCI_DEVICE_ID_O2_SEABIRD0:
>>> @@ -770,6 +924,8 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>>>  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>>>  		slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
>>>  		host->mmc_host_ops.init_sd_express = sdhci_pci_o2_init_sd_express;
>>> +
>>> +		sdhci_writel(host, 0xFFFFFFFF, SDHCI_INT_STATUS);
>>>  		break;
>>>  	default:
>>>  		break;
>>> @@ -1022,7 +1178,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>>>  		/* Set output delay*/
>>>  		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
>>>  		scratch_32 &= 0xFF0FFF00;
>>> -		scratch_32 |= 0x00B0003B;
>>> +		scratch_32 |= 0x00B000CB;
>>>  		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
>>>  
>>>  		/* Lock WP */
>>> @@ -1051,6 +1207,7 @@ static const struct sdhci_ops sdhci_pci_o2_ops = {
>>>  	.set_bus_width = sdhci_set_bus_width,
>>>  	.reset = sdhci_reset,
>>>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>>> +	.set_timeout = sdhci_o2_set_timeout,
>>>  };
>>>  
>>>  const struct sdhci_pci_fixes sdhci_o2 = {
>>> 
>>> base-commit: 0e945134b680040b8613e962f586d91b6d40292d

