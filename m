Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9245E75A8A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGTIHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjGTIHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:07:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4272110;
        Thu, 20 Jul 2023 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689840424; x=1721376424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TKk/dHPABP1tFlo3srgjojySwslI5+zRhVJkwa3qF4k=;
  b=BTVLpyL/BJ3NoXbnu2NBT5E7CbKpjYZGbgSWzSR3CEYoIhiwPtiP0LU6
   2uZkW7dMd/cdBpAZNuW8ICXOPepUQUMvH/vZR15rLCWxdnwIOnoNYLCnk
   acj9nyazJ6f195F2YycEYVD1SN4a55Wk44TlG3a29b2lotx5CMCGxl36C
   FQWrlS9diyhb1ek6FvHd9ISQPWJ9xY+rw10LjfmOXrSSq0UbA7tvxwb39
   bcpFDAH4pzhp76QYqWXu8vH1jQmP/yPOhgTZtMqu19CJPEPB1RGYGNDw0
   SraWlhVtU0GgN3rVvkw+Mo7JEbmqTdAeEcSjFytR3+y3B3QLMxg0cyQ4d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="364125384"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="364125384"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 01:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="970954013"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="970954013"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.109])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 01:07:00 -0700
Message-ID: <047c746f-0787-37ec-7989-cd932f288564@intel.com>
Date:   Thu, 20 Jul 2023 11:06:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH V8 06/23] mmc: core: Support UHS-II card control and
 access
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-7-victorshihgli@gmail.com>
 <37b29961-2b66-6dd3-e7c4-3ff291c8972b@intel.com>
 <CAK00qKBX55WVkKRJ4bkXN97VYg0yz72G+osir1AQWALszoGEOQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAK00qKBX55WVkKRJ4bkXN97VYg0yz72G+osir1AQWALszoGEOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/23 13:24, Victor Shih wrote:
> On Mon, Jul 10, 2023 at 9:24 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 21/06/23 13:01, Victor Shih wrote:
>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>
>>> Embed UHS-II access/control functionality into the MMC request
>>> processing flow.
>>>
>>> Updates in V8:
>>>  - Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
>>>  - Modify return value in sd_uhs2_attach().
>>>
>>> Updates in V7:
>>>  - Add mmc_uhs2_card_prepare_cmd helper function in sd_ops.h.
>>>  - Drop uhs2_state in favor of ios->timing.
>>>  - Remove unnecessary functions.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>>> ---
>>>  drivers/mmc/core/block.c   |   18 +-
>>>  drivers/mmc/core/core.c    |    8 +
>>>  drivers/mmc/core/mmc_ops.c |   25 +-
>>>  drivers/mmc/core/mmc_ops.h |    1 +
>>>  drivers/mmc/core/sd.c      |   13 +-
>>>  drivers/mmc/core/sd.h      |    4 +
>>>  drivers/mmc/core/sd_ops.c  |   11 +
>>>  drivers/mmc/core/sd_ops.h  |   18 +
>>>  drivers/mmc/core/sd_uhs2.c | 1137 +++++++++++++++++++++++++++++++++++-
>>>  9 files changed, 1176 insertions(+), 59 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>> index 2e9d3760c202..013ab071db9b 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -918,15 +918,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>>>
>>>       struct scatterlist sg;
>>>
>>> -     cmd.opcode = MMC_APP_CMD;
>>> -     cmd.arg = card->rca << 16;
>>> -     cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
>>> -
>>> -     err = mmc_wait_for_cmd(card->host, &cmd, 0);
>>> -     if (err)
>>> -             return err;
>>> -     if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
>>> -             return -EIO;
>>> +     err = mmc_app_cmd(card->host, card);
>>> +             if (err)
>>> +                     return err;
>>>
>>>       memset(&cmd, 0, sizeof(struct mmc_command));
>>>
>>> @@ -1612,6 +1606,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>>       struct request *req = mmc_queue_req_to_req(mqrq);
>>>       struct mmc_blk_data *md = mq->blkdata;
>>>       bool do_rel_wr, do_data_tag;
>>> +     bool do_multi;
>>> +
>>> +     do_multi = (card->host->flags & MMC_UHS2_SD_TRAN) ? true : false;
>>>
>>>       mmc_blk_data_prep(mq, mqrq, recovery_mode, &do_rel_wr, &do_data_tag);
>>>
>>> @@ -1622,7 +1619,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>>               brq->cmd.arg <<= 9;
>>>       brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>>>
>>> -     if (brq->data.blocks > 1 || do_rel_wr) {
>>> +     if (brq->data.blocks > 1 || do_rel_wr || do_multi) {
>>>               /* SPI multiblock writes terminate using a special
>>>                * token, not a STOP_TRANSMISSION request.
>>>                */
>>> @@ -1635,6 +1632,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>>               brq->mrq.stop = NULL;
>>>               readcmd = MMC_READ_SINGLE_BLOCK;
>>>               writecmd = MMC_WRITE_BLOCK;
>>> +             brq->cmd.uhs2_tmode0_flag = 1;
>>>       }
>>>       brq->cmd.opcode = rq_data_dir(req) == READ ? readcmd : writecmd;
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 7b8227e7ed26..04783f37da92 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -334,6 +334,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
>>>
>>>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>>  {
>>> +     struct uhs2_command uhs2_cmd;
>>> +     __be32 payload[4]; /* for maximum size */
>>>       int err;
>>>
>>>       init_completion(&mrq->cmd_completion);
>>> @@ -351,6 +353,8 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>>       if (err)
>>>               return err;
>>>
>>> +     mmc_uhs2_card_prepare_cmd(host, mrq, uhs2_cmd, payload);
>>> +
>>>       led_trigger_event(host->led, LED_FULL);
>>>       __mmc_start_request(host, mrq);
>>
>> __mmc_start_request() is also called by mmc_wait_for_req_done()
>> but uhs2_cmd is local to mmc_start_request(), so if mmc_wait_for_req_done()
>> is ever called in UHS2 case with cmd->retries, it looks like
>> host controller might try to access uhs2_cmd which is no
>> longer valid?
>>
>>
> 
> Hi, Adrian
> 
>       I traced the code between the SD card initialization process and
> found that
>       __mmc_start_request() is only called by mmc_start_request in the
> UHS2 case.
>       I'm not sure if there's anything I'm missing, could you help me
> with more comments?

Perhaps mmc_send_status() used in block.c ?

>       Or may you have any ideas on how to avoid this situation?
> 

Need to get Ulf's view, but putting "struct uhs2_command uhs2_cmd"
and "__be32 payload[4]" in struct mmc_command or struct mmc_request
would seem to be options.  If size is a concern, some optimization
to reduce the size of struct uhs2_command looks possible, and is
max payload len actually only 2 at the moment.

