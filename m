Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF80D7E6710
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjKIJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjKIJrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:47:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66BC72D7E;
        Thu,  9 Nov 2023 01:47:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A45E12FC;
        Thu,  9 Nov 2023 01:47:50 -0800 (PST)
Received: from [10.1.39.38] (e133047.arm.com [10.1.39.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42FDA3F703;
        Thu,  9 Nov 2023 01:47:02 -0800 (PST)
Message-ID: <d838bdeb-e047-465b-8f0c-bd8e720f5018@arm.com>
Date:   Thu, 9 Nov 2023 09:47:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/6] mmc: block: Be sure to wait while busy in CQE
 error recovery
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-4-adrian.hunter@intel.com>
From:   Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20231103084720.6886-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2023 08:47, Adrian Hunter wrote:
> STOP command does not guarantee to wait while busy, but subsequent command
> MMC_CMDQ_TASK_MGMT to discard the queue will fail if the card is busy, so
> be sure to wait by employing mmc_poll_for_busy().
> 
> Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/mmc/core/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 3d3e0ca52614..befde2bd26d3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -553,6 +553,8 @@ int mmc_cqe_recovery(struct mmc_host *host)
>  	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
>  	mmc_wait_for_cmd(host, &cmd, 0);
>  
> +	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true, MMC_BUSY_IO);
> +
>  	memset(&cmd, 0, sizeof(cmd));
>  	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
>  	cmd.arg          = 1; /* Discard entire queue */

