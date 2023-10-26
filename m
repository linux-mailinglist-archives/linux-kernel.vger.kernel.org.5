Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD8D7D7EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344625AbjJZIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:52:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5340189;
        Thu, 26 Oct 2023 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698310319; x=1729846319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oxmnZgFXPYnCSuKoLx9CvCYVBXZGdHuhYaPC51yBTf8=;
  b=Y9fDUyP5g8LZpKVI/VAUIPL0V9fFjQTlMnUWsglA7f5XYZzTUnfnGxZK
   8SP3UkQDiVIhR7uwpMDJJCl38UPT1N7NAjTCEbDn03bb3hmb9zUZCN3Jj
   UgIT6iP4nCu19uZ5xXivYlgPga4OpjuNklz1GGsv9PriXYvf71hP1jz4n
   Lp6baCkglNayyMvmNRifQcsnCM3Wd+Ik6JTQrViymcKJ80rSkn7IbhVSe
   D86LwAfBN5NJAMsmshv2d1cw4BKDN1SyLEN7csemq5cP56aAAB5jijyCO
   lB0xv+mMGXNlG5S0lBzEeUTev82znMGtZF7M16cCDQmIU/sco+yBlEOxK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="453962545"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="453962545"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="875858286"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="875858286"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.211.218])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:51:55 -0700
Message-ID: <4221120e-61bb-4672-8775-e7c1512d824b@intel.com>
Date:   Thu, 26 Oct 2023 11:51:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: cqhci: Be more verbose in error irq handler
Content-Language: en-US
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, upstream@semihalf.com
References: <20231016095610.1095084-1-korneld@chromium.org>
 <613c51f0-c32e-4de5-9627-525d92fb06ed@intel.com>
 <CAD=NsqybNrf-=9=5wvoj+9MT3xK3SbX7nDk3N3VLBMyA_u3KTQ@mail.gmail.com>
 <78bb4ad2-853a-4ed4-9998-c4e1122545b6@intel.com>
 <CAD=NsqxDA=usDRa-KV48RkeEROARsw8JqBF5vyJcEEV5r_Fg1w@mail.gmail.com>
 <f0aecb28-6f82-456e-a319-8d13a2e313b6@intel.com>
 <CAD=NsqyJHv4nrtrqU4igtaMR=u6xmUtCpoYk66XzarLpu95idA@mail.gmail.com>
 <cf207da8-8ec4-4b9c-8f01-00e1a8a46238@intel.com>
 <CAD=NsqyvGvbtyMim=Otp-Q-zWW9-+hAh95SOkgvnRusQC_--hQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAD=NsqyvGvbtyMim=Otp-Q-zWW9-+hAh95SOkgvnRusQC_--hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/23 11:29, Kornel Dulęba wrote:
> On Thu, Oct 26, 2023 at 10:14 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 26/10/23 10:56, Kornel Dulęba wrote:
>>> On Thu, Oct 26, 2023 at 8:25 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 25/10/23 11:01, Kornel Dulęba wrote:
>>>>> On Mon, Oct 23, 2023 at 1:38 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>
>>>>>> On 20/10/23 11:53, Kornel Dulęba wrote:
>>>>>>> On Fri, Oct 20, 2023 at 9:41 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>>>
>>>>>>>> On 16/10/23 12:56, Kornel Dulęba wrote:
>>>>>>>>> There are several reasons for controller to generate an error interrupt.
>>>>>>>>> They include controller<->card timeout, and CRC mismatch error.
>>>>>>>>> Right now we only get one line in the logs stating that CQE recovery was
>>>>>>>>> triggered, but with no information about what caused it.
>>>>>>>>> To figure out what happened be more verbose and dump the registers from
>>>>>>>>> irq error handler logic.
>>>>>>>>> This matches the behaviour of the software timeout logic, see
>>>>>>>>> cqhci_timeout.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
>>>>>>>>> ---
>>>>>>>>>  drivers/mmc/host/cqhci-core.c | 5 +++--
>>>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
>>>>>>>>> index b3d7d6d8d654..33abb4bd53b5 100644
>>>>>>>>> --- a/drivers/mmc/host/cqhci-core.c
>>>>>>>>> +++ b/drivers/mmc/host/cqhci-core.c
>>>>>>>>> @@ -700,8 +700,9 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>>>>>>>>>
>>>>>>>>>       terri = cqhci_readl(cq_host, CQHCI_TERRI);
>>>>>>>>>
>>>>>>>>> -     pr_debug("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d TERRI: 0x%08x\n",
>>>>>>>>> -              mmc_hostname(mmc), status, cmd_error, data_error, terri);
>>>>>>>>> +     pr_warn("%s: cqhci: error IRQ status: 0x%08x cmd error %d data error %d\n",
>>>>>>>>> +              mmc_hostname(mmc), status, cmd_error, data_error);
>>>>>>>>> +     cqhci_dumpregs(cq_host);
>>>>>>>>
>>>>>>>> For debugging, isn't dynamic debug seems more appropriate?
>>>>>>>
>>>>>>> Dynamic debug is an option, but my personal preference would be to
>>>>>>> just log more info in the error handler.
>>>>>>
>>>>>> Interrupt handlers can get called very rapidly, so some kind of rate
>>>>>> limiting should be used if the message is unconditional.  Also you need
>>>>>> to provide actual reasons for your preference.
>>>>>>
>>>>>> For dynamic debug of the register dump, something like below is
>>>>>> possible.
>>>>>>
>>>>>> #define cqhci_dynamic_dumpregs(cqhost) \
>>>>>>         _dynamic_func_call_no_desc("cqhci_dynamic_dumpregs", cqhci_dumpregs, cqhost)
>>>>>>
>>>>> Fair point.
>>>>> The reason I'm not a fan of using dynamic debug for this is that my
>>>>> goal here is to improve the warning/error logging information that we
>>>>> get from systems running in production.
>>>>> I.e. if we get a lot of "running CQE recovery" messages, at the very
>>>>> least I'd like to know what is causing them.
>>>>
>>>> So you are saying you want to collect debug information from production
>>>> systems, but don't want to use dynamic debug to do it?
>>>>
>>>>>>> To give you some background.
>>>>>>> We're seeing some "running CQE recovery" lines in the logs, followed
>>>>>>> by a dm_verity mismatch error.
>>>>>>> The reports come from the field, with no feasible way to reproduce the
>>>>>>> issue locally.
>>>>>>
>>>>>> If it is a software error, some kind of error injection may well
>>>>>> reproduce it.  Also if it is a hardware error that only happens
>>>>>> during recovery, error injection could increase the likelihood of
>>>>>> reproducing it.
>>>>>
>>>>> We tried software injection and it didn't yield any results.
>>>>> We're currently looking into "injecting" hw errors by using a small
>>>>> burst field generator to interfere with transfers on the data line
>>>>> directly.
>>>>
>>>> I just tried instrumenting a driver to inject CRC errors and it
>>>> revealed several CQE recovery issues, including spurious TCN for
>>>> tag 31.  I will send some patches when they are ready.
>>>
>>> Sorry, what I meant by it didn't yield results is that Ii didn't
>>> trigger the dm-verity error that we're seeing on production.
>>> With SW injection there are two potential issues that come to my mind:
>>>
>>> 1. In the cqhci_error_irq when TERRI is not valid only a single,
>>> "random" task is marked as bad.
>>> Then in cqhci_recover_mrq we're marking all pending requests as done.
>>> For data transfers this is somewhat bening as it will return with
>>> bytes_xfered=0.
>>> IIUC this will then cause the upper layer to re-enqueue this request.
>>
>> Yes
>>
>>> The bigger problem is a CMD only mrq, which will be mistakenly marked
>>> as completed successfully.
>>
>> I noticed that also.  Notably the only non-data CMD is cache flush.
>>
>> There are several other issues, but patches will describe
>> them better.
> 
> Sure. :)
> 
> jfyi, I've just managed to inject CRC errors by using a burst field generator.
> (Langer P23 if you're interested.)
> I'm using it by touching the D0 MMC line directly, and it yields
> surprisingly good results.
> I've changed the spurious TCN WARN_ONCE to pr_warn and got the following:
> 
> [   71.885698] mmc1: cqhci: error IRQ status: 0x00000000 cmd error 0
> data error -84 TERRI: 0x972e0000
> [   71.885730] mmc1: running CQE recovery
> [   71.888135] cqhci_recovery_finish: TCN: 0x00000000
> [   71.888141] mmc1: cqhci: recovery done
> [   71.888223] mmc1: cqhci: spurious TCN for tag 23
> (...)
> [   95.558736] mmc1: cqhci: error IRQ status: 0x00000000 cmd error 0
> data error -84 TERRI: 0x822e0000
> [   95.558768] mmc1: running CQE recovery
> [   95.561073] cqhci_recovery_finish: TCN: 0x00000000
> [   95.561078] mmc1: cqhci: recovery done
> [   95.561288] device-mapper: verity: 179:3: data block 712181 is corrupted
> 
> Now I get a spurious TCN after every recovery, with the only exception
> being the one that ends up with dm-verity error.
> So it'd seem that there's a race in which the "spurious" TCN hits a
> pending request, enqueued right after recovery was completed.
> I'm currently looking into how to fix it, but if you beat me to it I
> can also test your patches and see if it fixes the dm-verity issue.

OK, but here are some hacks to try:

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 3a8f27c3e310..5eb98da933d5 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2379,6 +2379,9 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 				blk_mq_end_request(req, BLK_STS_OK);
 				return MMC_REQ_FINISHED;
 			}
+			ret = mmc_blk_wait_for_idle(mq, host);
+			if (ret)
+				return MMC_REQ_BUSY;
 			ret = mmc_blk_cqe_issue_flush(mq, req);
 			break;
 		case REQ_OP_READ:
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3d3e0ca52614..8ac1efca2be6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -563,6 +563,16 @@ int mmc_cqe_recovery(struct mmc_host *host)
 
 	host->cqe_ops->cqe_recovery_finish(host);
 
+	if (err) {
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.opcode       = MMC_CMDQ_TASK_MGMT;
+		cmd.arg          = 1; /* Discard entire queue */
+		cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
+		cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
+		cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
+		err = mmc_wait_for_cmd(host, &cmd, 3);
+	}
+
 	mmc_retune_release(host);
 
 	return err;
diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..93e1bbdc446f 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -975,8 +975,13 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 
 	ret = cqhci_halted(cq_host);
 
-	if (!ret)
-		pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
+	if (!ret) {
+		u32 cqcfg;
+
+		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+		cqcfg &= ~CQHCI_ENABLE;
+		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+	}
 
 	return ret;
 }
@@ -987,7 +992,7 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
  * layers will need to send a STOP command), so we set the timeout based on a
  * generous command timeout.
  */
-#define CQHCI_START_HALT_TIMEOUT	5
+#define CQHCI_START_HALT_TIMEOUT	200
 
 static void cqhci_recovery_start(struct mmc_host *mmc)
 {
@@ -1039,6 +1044,8 @@ static void cqhci_recover_mrq(struct cqhci_host *cq_host, unsigned int tag)
 		data->error = cqhci_error_from_flags(slot->flags);
 	} else {
 		mrq->cmd->error = cqhci_error_from_flags(slot->flags);
+		if (!mrq->cmd->error)
+			mrq->cmd->error = -EIO;
 	}
 
 	mmc_cqe_request_done(cq_host->mmc, mrq);


> 
>>
>>>
>>> 2. As for the spurious task completion warning.
>>> I initially thought that it was bening.
>>> The check for !mrq is done before checking if we're currently doing recovery.
>>> So if it's called just right at the end of recovery, right after the
>>> cqhci_recover_mrqs is executed that would explain it.
>>> With that being said if that irq handler is run right after the
>>> recovery is finished we'll end up with a race where a new request,
>>> that was just enqueued, might be mistakenly marked as done.
>>> This would explain the dm-verity errors we're seeing.
>>>
>>>>
>>>>>>
>>>>>>>
>>>>>>> I'd argue that logging only the info that CQE recovery was executed is
>>>>>>> not particularly helpful for someone looking into those logs.
>>>>>>
>>>>>> As the comment says, that message is there because recovery reduces
>>>>>> performance, it is not to aid debugging per se.
>>>>>>
>>>>>>> Ideally we would have more data about the state the controller was in
>>>>>>> when the error happened, or at least what caused the recovery to be
>>>>>>> triggered.
>>>>>>> The question here is how verbose should we be in this error scenario.
>>>>>>> Looking at other error scenarios, in the case of a software timeout
>>>>>>> we're dumping the controller registers. (cqhci_timeout)
>>>>>>
>>>>>> Timeout means something is broken - either the driver, the cq engine
>>>>>> or the card.  On the other hand, an error interrupt is most likely a
>>>>>> CRC error which is not unexpected occasionally, due to thermal drift
>>>>>> or perhaps interference.
>>>>>
>>>>> Right, but my point is that we don't know what triggered CQE recovery.
>>>>
>>>> True, although probably a CRC error.
>>>>
>>>>>
>>>>>>
>>>>>>> Hence I thought that I'd be appropriate to match that and do the same
>>>>>>> in CQE recovery logic.
>>>>>>
>>>>>> It needs to be consistent. There are other pr_debugs, such as:
>>>>>>
>>>>>>                 pr_debug("%s: cqhci: Failed to clear tasks\n",
>>>>>>                 pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
>>>>>>                 pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));
>>>>>>
>>>>>> which should perhaps be treated the same.
>>>>>>
>>>>>> And there are no messages for errors from the commands in
>>>>>> mmc_cqe_recovery().
>>>>>
>>>>> How about this.
>>>>> As a compromise would it be okay to just do a single pr_warn directly
>>>>> from cqhci_error_irq.
>>>>
>>>> Sure, printk_ratelimited() or __ratelimit()
>>>>
>>>>> We could simply promote the existing pr_debug to pr_warn at the
>>>>> beginning of that function.
>>>>> This would tell us what triggered the recovery. (controller timeout,
>>>>> CRC mismatch)
>>>>> We can also consider removing the "running CQE recovery" print for the
>>>>> sake of brevity.
>>>>
>>>> No, that serves a different purpose.
>>>>
>>>>> The only downside of this that I can see is that we'd be running the
>>>>> logic from the interrupt handler directly, but I can't see an easy way
>>>>> around that.
>>>>> What do you think?
>>>>
>>>> Should be OK with rate limiting.
>>>
>>> OK, I'll look into the rate limiting and will send a v2.
>>>
>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>       /* Forget about errors when recovery has already been triggered */
>>>>>>>>>       if (cq_host->recovery_halt)
>>>>>>>>
>>>>>>
>>>>
>>

