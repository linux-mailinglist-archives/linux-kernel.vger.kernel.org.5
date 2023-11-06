Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F887E19B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKFFnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFFnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:43:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164BCFA;
        Sun,  5 Nov 2023 21:43:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5454AC433C8;
        Mon,  6 Nov 2023 05:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699249391;
        bh=e583JGY0G0pVmOX1ecIKiTB6ae+xfhdJaZ6fBELBZc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDQciV5AMLLj35Epnxcgf91p7dF4rK1PKDfPfYTfNll2CoWi7U9GC6bL8y+TxVcif
         IVvcoe1mmoiNG/lwdMUdQy75XdSKcXp2ldAC6jlraXmhOrfwjfRDouzX2DxO9a2DLD
         jW2pxBnCrW4BHQZC6sUAB2AneZlKuKYtuqx0iJ9GiEfOvzglnDEkDKTDjomQx11IcF
         7wsnSViZwJj99Z/NTQTm7DFabX4/LEqWdoA0HrrmFSbU50Cvt3QQWjk9OOT5RjJz+e
         /ZR5mAfsVgwjs0mE8BYpGT7TrvQbTOnJtB7v8JxAqCcKktf95W04BKocpjOOyD4yqA
         21g6tMpiKkLGw==
Date:   Mon, 6 Nov 2023 11:13:05 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH 1/2] bus: mhi: host: Add a separate timeout parameter for
 waiting ready
Message-ID: <20231106054305.GC2474@thinkpad>
References: <1699242172-79472-1-git-send-email-quic_qianyu@quicinc.com>
 <1699242172-79472-2-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699242172-79472-2-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 11:42:51AM +0800, Qiang Yu wrote:
> Some devices(eg. SDX75) take longer than expected (default, 8 seconds) to
> set ready after reboot. Hence add optional ready timeout parameter and pass
> the appropriate timeout value to mhi_poll_reg_field() to wait enough for
> device ready as part of power up sequence.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/init.c     |  1 +
>  drivers/bus/mhi/host/internal.h |  2 +-
>  drivers/bus/mhi/host/main.c     |  5 +++--
>  drivers/bus/mhi/host/pm.c       | 24 +++++++++++++++++-------
>  include/linux/mhi.h             |  4 ++++
>  5 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index f78aefd..65ceac1 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -881,6 +881,7 @@ static int parse_config(struct mhi_controller *mhi_cntrl,
>  	if (!mhi_cntrl->timeout_ms)
>  		mhi_cntrl->timeout_ms = MHI_TIMEOUT_MS;
>  
> +	mhi_cntrl->ready_timeout_ms = config->ready_timeout_ms;
>  	mhi_cntrl->bounce_buf = config->use_bounce_buf;
>  	mhi_cntrl->buffer_len = config->buf_len;
>  	if (!mhi_cntrl->buffer_len)
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 2e139e7..30ac415 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -321,7 +321,7 @@ int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
>  				    u32 *out);
>  int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
>  				    void __iomem *base, u32 offset, u32 mask,
> -				    u32 val, u32 delayus);
> +				    u32 val, u32 delayus, u32 timeout_ms);
>  void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
>  		   u32 offset, u32 val);
>  int __must_check mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index dcf627b..6cf1145 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -40,10 +40,11 @@ int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
>  
>  int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
>  				    void __iomem *base, u32 offset,
> -				    u32 mask, u32 val, u32 delayus)
> +				    u32 mask, u32 val, u32 delayus,
> +				    u32 timeout_ms)
>  {
>  	int ret;
> -	u32 out, retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
> +	u32 out, retry = (timeout_ms * 1000) / delayus;
>  
>  	while (retry--) {
>  		ret = mhi_read_reg_field(mhi_cntrl, base, offset, mask, &out);
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 8a4362d..a2f2fee 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -163,6 +163,7 @@ int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
>  	enum mhi_pm_state cur_state;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	u32 interval_us = 25000; /* poll register field every 25 milliseconds */
> +	u32 timeout_ms;
>  	int ret, i;
>  
>  	/* Check if device entered error state */
> @@ -173,14 +174,18 @@ int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
>  
>  	/* Wait for RESET to be cleared and READY bit to be set by the device */
>  	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
> -				 MHICTRL_RESET_MASK, 0, interval_us);
> +				 MHICTRL_RESET_MASK, 0, interval_us,
> +				 mhi_cntrl->timeout_ms);
>  	if (ret) {
>  		dev_err(dev, "Device failed to clear MHI Reset\n");
>  		return ret;
>  	}
>  
> +	timeout_ms = mhi_cntrl->ready_timeout_ms ?
> +		mhi_cntrl->ready_timeout_ms : mhi_cntrl->timeout_ms;
>  	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
> -				 MHISTATUS_READY_MASK, 1, interval_us);
> +				 MHISTATUS_READY_MASK, 1, interval_us,
> +				 timeout_ms);
>  	if (ret) {
>  		dev_err(dev, "Device failed to enter MHI Ready\n");
>  		return ret;
> @@ -479,7 +484,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  
>  		/* Wait for the reset bit to be cleared by the device */
>  		ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
> -				 MHICTRL_RESET_MASK, 0, 25000);
> +				 MHICTRL_RESET_MASK, 0, 25000, mhi_cntrl->timeout_ms);
>  		if (ret)
>  			dev_err(dev, "Device failed to clear MHI Reset\n");
>  
> @@ -492,8 +497,8 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  		if (!MHI_IN_PBL(mhi_get_exec_env(mhi_cntrl))) {
>  			/* wait for ready to be set */
>  			ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs,
> -						 MHISTATUS,
> -						 MHISTATUS_READY_MASK, 1, 25000);
> +						 MHISTATUS, MHISTATUS_READY_MASK,
> +						 1, 25000, mhi_cntrl->timeout_ms);
>  			if (ret)
>  				dev_err(dev, "Device failed to enter READY state\n");
>  		}
> @@ -1111,7 +1116,8 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  	if (state == MHI_STATE_SYS_ERR) {
>  		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
>  		ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
> -				 MHICTRL_RESET_MASK, 0, interval_us);
> +				 MHICTRL_RESET_MASK, 0, interval_us,
> +				 mhi_cntrl->timeout_ms);
>  		if (ret) {
>  			dev_info(dev, "Failed to reset MHI due to syserr state\n");
>  			goto error_exit;
> @@ -1202,14 +1208,18 @@ EXPORT_SYMBOL_GPL(mhi_power_down);
>  int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
>  {
>  	int ret = mhi_async_power_up(mhi_cntrl);
> +	u32 timeout_ms;
>  
>  	if (ret)
>  		return ret;
>  
> +	/* Some devices need more time to set ready during power up */
> +	timeout_ms = mhi_cntrl->ready_timeout_ms ?
> +		mhi_cntrl->ready_timeout_ms : mhi_cntrl->timeout_ms;
>  	wait_event_timeout(mhi_cntrl->state_event,
>  			   MHI_IN_MISSION_MODE(mhi_cntrl->ee) ||
>  			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
> -			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
> +			   msecs_to_jiffies(timeout_ms));
>  
>  	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
>  	if (ret)
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 039943e..d0f9b522 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -266,6 +266,7 @@ struct mhi_event_config {
>   * struct mhi_controller_config - Root MHI controller configuration
>   * @max_channels: Maximum number of channels supported
>   * @timeout_ms: Timeout value for operations. 0 means use default
> + * @ready_timeout_ms: Timeout value for waiting device to be ready (optional)
>   * @buf_len: Size of automatically allocated buffers. 0 means use default
>   * @num_channels: Number of channels defined in @ch_cfg
>   * @ch_cfg: Array of defined channels
> @@ -277,6 +278,7 @@ struct mhi_event_config {
>  struct mhi_controller_config {
>  	u32 max_channels;
>  	u32 timeout_ms;
> +	u32 ready_timeout_ms;
>  	u32 buf_len;
>  	u32 num_channels;
>  	const struct mhi_channel_config *ch_cfg;
> @@ -330,6 +332,7 @@ struct mhi_controller_config {
>   * @pm_mutex: Mutex for suspend/resume operation
>   * @pm_lock: Lock for protecting MHI power management state
>   * @timeout_ms: Timeout in ms for state transitions
> + * @ready_timeout_ms: Timeout in ms for waiting device to be ready (optional)
>   * @pm_state: MHI power management state
>   * @db_access: DB access states
>   * @ee: MHI device execution environment
> @@ -419,6 +422,7 @@ struct mhi_controller {
>  	struct mutex pm_mutex;
>  	rwlock_t pm_lock;
>  	u32 timeout_ms;
> +	u32 ready_timeout_ms;
>  	u32 pm_state;
>  	u32 db_access;
>  	enum mhi_ee_type ee;
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
