Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194CC7DC087
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjJ3TbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3TbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:31:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282B2A9;
        Mon, 30 Oct 2023 12:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698694256; x=1730230256;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oE5glMctpbfYlLJs53M3TJqVUGKgwDxVjEE0ZRcfHpM=;
  b=NV3cAfTKh5BNgEUMPp5/yH4Fu+uaNWL6hMCxcDUDyKIVFToxMyQKw0T4
   G19bKDnjCm9fTEQ37RLj9x6x8QQ9RO1wzht3pRIO/V2inW5cIzKpM0a0T
   6RPoxQqsyekTEShaUBH9VMskv9fJ/6PJ0TyTkRbxeLmyX7z7kh8n7SkPU
   9enC7YRS9Q2keXSsAJHc0yEIZ5V4yIS5G5XQIGei/10qIOIYazgDG4PSB
   Z9dMar8ubxnNh8r0xpdhkaeX+e3VRP37xdV1F7bBxnpCdwHL+QM5ja4ah
   YcnXOhbthPVrGsMlKyvs7ikuJTvYmvLe3x7FAf3i1IfIEQrXJeh1j6Tho
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="387965408"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="387965408"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 12:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1007520505"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="1007520505"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.41.161])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 12:30:54 -0700
Message-ID: <e7c12e07-7540-47ea-8891-2cec73d58df1@intel.com>
Date:   Mon, 30 Oct 2023 21:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: cqhci: Add a quirk to clear stale TC
Content-Language: en-US
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20231027145623.2258723-1-korneld@chromium.org>
 <20231027145623.2258723-2-korneld@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231027145623.2258723-2-korneld@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/23 17:56, Kornel Dulęba wrote:
> This fix addresses a stale task completion event issued right after the
> CQE recovery. As it's a hardware issue the fix is done in form of a
> quirk.
> 
> When error interrupt is received the driver runs recovery logic is run.
> It halts the controller, clears all pending tasks, and then re-enables
> it. On some platforms a stale task completion event is observed,
> regardless of the CQHCI_CLEAR_ALL_TASKS bit being set.
> 
> This results in either:
> a) Spurious TC completion event for an empty slot.
> b) Corrupted data being passed up the stack, as a result of premature
>    completion for a newly added task.
> 
> To fix that re-enable the controller, clear task completion bits,
> interrupt status register and halt it again.
> This is done at the end of the recovery process, right before interrupts
> are re-enabled.
> 
> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
> ---
>  drivers/mmc/host/cqhci-core.c | 42 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci.h      |  1 +
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index b3d7d6d8d654..e534222df90c 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -1062,6 +1062,45 @@ static void cqhci_recover_mrqs(struct cqhci_host *cq_host)
>  /* CQHCI could be expected to clear it's internal state pretty quickly */
>  #define CQHCI_CLEAR_TIMEOUT		20
>  
> +/*
> + * During CQE recovery all pending tasks are cleared from the
> + * controller and its state is being reset.
> + * On some platforms the controller sets a task completion bit for
> + * a stale(previously cleared) task right after being re-enabled.
> + * This results in a spurious interrupt at best and corrupted data
> + * being passed up the stack at worst. The latter happens when
> + * the driver enqueues a new request on the problematic task slot
> + * before the "spurious" task completion interrupt is handled.
> + * To fix it:
> + * 1. Re-enable controller by clearing the halt flag.
> + * 2. Clear interrupt status and the task completion register.
> + * 3. Halt the controller again to be consistent with quirkless logic.
> + *
> + * This assumes that there are no pending requests on the queue.
> + */
> +static void cqhci_quirk_clear_stale_tc(struct cqhci_host *cq_host)
> +{
> +	u32 reg;
> +
> +	WARN_ON(cq_host->qcnt);
> +	cqhci_writel(cq_host, 0, CQHCI_CTL);
> +	if ((cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)) {
> +		pr_err("%s: cqhci: CQE failed to exit halt state\n",
> +			mmc_hostname(cq_host->mmc));
> +	}
> +	reg = cqhci_readl(cq_host, CQHCI_TCN);
> +	cqhci_writel(cq_host, reg, CQHCI_TCN);
> +	reg = cqhci_readl(cq_host, CQHCI_IS);
> +	cqhci_writel(cq_host, reg, CQHCI_IS);
> +
> +	/*
> +	 * Halt the controller again.
> +	 * This is only needed so that we're consistent across quirk
> +	 * and quirkless logic.
> +	 */
> +	cqhci_halt(cq_host->mmc, CQHCI_FINISH_HALT_TIMEOUT);
> +}

Thanks a lot for tracking this down!

It could be that the "un-halt" starts a task, so it would be
better to force the "clear" to work if possible, which
should be the case if CQE is disabled.

Would you mind trying the code below?  Note the increased
CQHCI_START_HALT_TIMEOUT helps avoid trying to clear tasks
when CQE has not halted.


diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..534c13069833 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -987,7 +987,7 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
  * layers will need to send a STOP command), so we set the timeout based on a
  * generous command timeout.
  */
-#define CQHCI_START_HALT_TIMEOUT	5
+#define CQHCI_START_HALT_TIMEOUT	500
 
 static void cqhci_recovery_start(struct mmc_host *mmc)
 {
@@ -1075,28 +1075,27 @@ static void cqhci_recovery_finish(struct mmc_host *mmc)
 
 	ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
 
-	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-		ok = false;
-
 	/*
 	 * The specification contradicts itself, by saying that tasks cannot be
 	 * cleared if CQHCI does not halt, but if CQHCI does not halt, it should
 	 * be disabled/re-enabled, but not to disable before clearing tasks.
 	 * Have a go anyway.
 	 */
-	if (!ok) {
-		pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));
-		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
-		cqcfg &= ~CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		cqcfg |= CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		/* Be sure that there are no tasks */
-		ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
-		if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-			ok = false;
-		WARN_ON(!ok);
-	}
+	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
+		ok = false;
+
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg &= ~CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
+
+	if (!ok)
+		cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT);
 
 	cqhci_recover_mrqs(cq_host);
 

