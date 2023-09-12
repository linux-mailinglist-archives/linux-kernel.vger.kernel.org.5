Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F064079D13F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjILMkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjILMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:40:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93860C4;
        Tue, 12 Sep 2023 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694522400; x=1726058400;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dZP1LM+xVZ/yUwnBaICXHVkRiLUwNhOEawORbPO48ZY=;
  b=VEGgBlT8GC62eCUcr8Xylhm/HexevnJOpNWlGUwRvZ7gSwlCqeZ5t23e
   U2Pg2AkfSIUp2llowlOQ4iS5k2u/mcc6xO6T+QQq13CzAlalu+XN14hSo
   xBmLOgT3sjodLR+T0EL1v6082GQYkLRSObLajb/ZoPhem2pv4v/hlPaeN
   qoqaLCTwxHTiVVl74uOWyXRMaEZruqoJGF/nr2ienPwaYs2WxyxCY7EIE
   lWimEFyN10qRyjipW6WSmRQs8HbDcWEzbISWmYHchIpufg55eOb9FjlwK
   adplTkR5uqRHMuecwjrm5dy5uMGU392+rSbpkzPNxTShNgg25l4nkeebD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464731306"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464731306"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693475259"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="693475259"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.45.152])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:39:56 -0700
Message-ID: <ef6648b4-94da-20a8-c1e2-b7d6d0090918@intel.com>
Date:   Tue, 12 Sep 2023 15:39:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH V10 18/23] mmc: sdhci-uhs2: add request() and others
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
 <20230818100217.12725-19-victorshihgli@gmail.com>
 <2b3f8b30-1ee1-31dd-53d7-cb2a0deea511@intel.com>
 <CAK00qKAR_4EaRtLRi_CKPDOy+CTFDw_CzkbmL=GOY2QWTU2yOQ@mail.gmail.com>
 <18716e05-6138-d326-ab29-f90e03650490@intel.com>
 <CAK00qKAEW8qkvXUsnb4UVHBSGAtjT-F1bJiKRMOTWR+Pirg3oA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAK00qKAEW8qkvXUsnb4UVHBSGAtjT-F1bJiKRMOTWR+Pirg3oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/09/23 19:14, Victor Shih wrote:
> On Thu, Aug 31, 2023 at 7:20 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 31/08/23 13:33, Victor Shih wrote:
>>> On Thu, Aug 31, 2023 at 4:33 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 18/08/23 13:02, Victor Shih wrote:
>>>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>>>
>>>>> This is a sdhci version of mmc's request operation.
>>>>> It covers both UHS-I and UHS-II.
>>>>>
>>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>>> ---
>>>>>
>>>>> Updates in V10:
>>>>>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag
>>>>>    in sdhci_uhs2_set_transfer_mode().
>>>>>
>>>>> Updates in V9:
>>>>>  - Modify the annotations in __sdhci_uhs2_send_command().
>>>>>
>>>>> Updates in V8:
>>>>>  - Adjust the position of matching brackets in
>>>>>    sdhci_uhs2_send_command_retry().
>>>>>  - Modify CameCase definition in __sdhci_uhs2_finish_command().
>>>>>  - Modify error message in __sdhci_uhs2_finish_command().
>>>>>  - sdhci_uhs2_send_command_retry() to instead of sdhci_uhs2_send_command()
>>>>>    in sdhci_uhs2_request().
>>>>>  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_request_atomic().
>>>>>  - Add forward declaration for sdhci_send_command().
>>>>>
>>>>> Updates in V7:
>>>>>  - Cancel export state of some functions.
>>>>>  - Remove unnecessary whitespace changes.
>>>>>
>>>>> Updates in V6:
>>>>>  - Add uhs2_dev_cmd() to simplify code.
>>>>>  - Remove unnecessary functions.
>>>>>  - Cancel export state of some functions.
>>>>>  - Drop use CONFIG_MMC_DEBUG().
>>>>>  - Wrap at 100 columns in some functions.
>>>>>
>>>>> ---
>>>>>
>>>>>  drivers/mmc/host/sdhci-uhs2.c | 412 ++++++++++++++++++++++++++++++++++
>>>>>  drivers/mmc/host/sdhci.c      |  49 ++--
>>>>>  drivers/mmc/host/sdhci.h      |   8 +
>>>>>  3 files changed, 454 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>>>>> index 09b86fec9f7b..08fef7174239 100644
>>>>> --- a/drivers/mmc/host/sdhci-uhs2.c
>>>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>>>>> @@ -14,6 +14,8 @@
>>>>>  #include <linux/module.h>
>>>>>  #include <linux/iopoll.h>
>>>>>  #include <linux/bitfield.h>
>>>>> +#include <linux/mmc/mmc.h>
>>>>> +#include <linux/mmc/host.h>
>>>>>
>>>>>  #include "sdhci.h"
>>>>>  #include "sdhci-uhs2.h"
>>>>> @@ -24,6 +26,8 @@
>>>>>  #define SDHCI_UHS2_DUMP(f, x...) \
>>>>>       pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
>>>>>
>>>>> +#define UHS2_ARG_IOADR_MASK 0xfff
>>>>> +
>>>>>  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>>>>>  {
>>>>>       if (!(sdhci_uhs2_mode(host)))
>>>>> @@ -58,6 +62,11 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>>>>>   *                                                                           *
>>>>>  \*****************************************************************************/
>>>>>
>>>>> +static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
>>>>> +{
>>>>> +     return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
>>>>> +}
>>>>> +
>>>>>  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
>>>>>                                           struct regulator *supply,
>>>>>                                           unsigned short vdd_bit)
>>>>> @@ -446,6 +455,408 @@ static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
>>>>>       return err;
>>>>>  }
>>>>>
>>>>> +/*****************************************************************************\
>>>>> + *                                                                           *
>>>>> + * Core functions                                                            *
>>>>> + *                                                                           *
>>>>> +\*****************************************************************************/
>>>>> +
>>>>> +static void sdhci_uhs2_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>>>> +{
>>>>> +     struct mmc_data *data = cmd->data;
>>>>> +
>>>>> +     sdhci_initialize_data(host, data);
>>>>> +
>>>>> +     sdhci_prepare_dma(host, data);
>>>>> +
>>>>> +     sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
>>>>> +     sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
>>>>> +}
>>>>> +
>>>>> +static void sdhci_uhs2_finish_data(struct sdhci_host *host)
>>>>> +{
>>>>> +     struct mmc_data *data = host->data;
>>>>> +
>>>>> +     __sdhci_finish_data_common(host);
>>>>> +
>>>>> +     __sdhci_finish_mrq(host, data->mrq);
>>>>> +}
>>>>> +
>>>>> +static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host, struct mmc_command *cmd)
>>>>> +{
>>>>> +     u16 mode;
>>>>> +     struct mmc_data *data = cmd->data;
>>>>> +
>>>>> +     if (!data) {
>>>>> +             /* clear Auto CMD settings for no data CMDs */
>>>>> +             if (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT) {
>>>>> +                     mode =  0;
>>>>> +             } else {
>>>>> +                     mode = sdhci_readw(host, SDHCI_UHS2_TRANS_MODE);
>>>>> +                     if (cmd->opcode == MMC_STOP_TRANSMISSION || cmd->opcode == MMC_ERASE)
>>>>> +                             mode |= SDHCI_UHS2_TRNS_WAIT_EBSY;
>>>>> +                     else
>>>>> +                             /* send status mode */
>>>>> +                             if (cmd->opcode == MMC_SEND_STATUS)
>>>>> +                                     mode = 0;
>>>>> +             }
>>>>> +
>>>>> +             DBG("UHS2 no data trans mode is 0x%x.\n", mode);
>>>>> +
>>>>> +             sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
>>>>> +             return;
>>>>> +     }
>>>>> +
>>>>> +     WARN_ON(!host->data);
>>>>> +
>>>>> +     mode = SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EBSY;
>>>>> +     if (data->flags & MMC_DATA_WRITE)
>>>>> +             mode |= SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
>>>>> +
>>>>> +     if (data->blocks == 1 &&
>>>>> +         data->blksz != 512 &&
>>>>> +         cmd->opcode != MMC_READ_SINGLE_BLOCK &&
>>>>> +         cmd->opcode != MMC_WRITE_BLOCK) {
>>>>> +             mode &= ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
>>>>> +             mode |= SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
>>>>> +     }
>>>>> +
>>>>> +     if (host->flags & SDHCI_REQ_USE_DMA)
>>>>> +             mode |= SDHCI_UHS2_TRNS_DMA;
>>>>> +
>>>>> +     if ((mmc_card_uhs2_hd_mode(host->mmc)) && cmd->uhs2_cmd->tmode_half_duplex)
>>>>
>>>> Should not check mmc_card_uhs2_hd_mode(host->mmc).  The mmc core
>>>> must get it right.
>>>>
>>>> Also why is the setting different for different commands?
>>>>
>>>
>>> Hi, Adrian
>>>
>>> I will drop the check  mmc_card_uhs2_hd_mode(host->mmc) in the next version.
>>> But I'm not quite sure what the "why is the setting different for
>>> different commands" means.
>>> Could you help explain it a little bit more clearly?
>>
>> In mmc_uhs2_prepare_cmd() there is this code:
>>
>>         if (cmd->opcode == SD_APP_SEND_SCR || cmd->opcode == SD_APP_SD_STATUS ||
>>             cmd->opcode == MMC_SEND_EXT_CSD || cmd->opcode == SD_SWITCH ||
>>             cmd->opcode == SD_READ_EXTR_SINGLE || cmd->opcode == MMC_SEND_CSD ||
>>             cmd->opcode == MMC_SEND_CID)
>>                 cmd->uhs2_cmd->tmode_half_duplex = 0;
>>         else
>>                 cmd->uhs2_cmd->tmode_half_duplex = mmc_card_uhs2_hd_mode(host);
>>
>> So different commands can have different duplex?  Why is that?
>>
> 
> Hi, Adrian
> 
> Please correct me if I understand wrong.
> We use tmode_half_duplex instead of uhs2_tmode0_flag.
> As I know, the above commands need to be sent in tmode0.
> That's why I set different duplex for different commands.

UHS-II Addendum 7.2.1.2 DCMD says:

 "Host may set DM to 1 for DCMD which supports multi-block read / write regardless of
 data transfer length (e.g., CMD18, CMD25). Otherwise, it shall not set DM to 1.
 (e.g. CMD6, CMD17, CMD24). These rules are also applied to other multi-block read / write
 commands defined in other Part of SD specifications (for example, Host may set DM to 1
 for ACMD18 or ACMD25)."

Which sounds like we should check for CMD18 and CMD25 rather than the other way around?
Perhaps use mmc_op_multi() and add a comment.

