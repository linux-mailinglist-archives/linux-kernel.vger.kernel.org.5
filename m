Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF727741AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjHHRZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjHHRZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41CE2026B;
        Tue,  8 Aug 2023 09:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B779761034;
        Tue,  8 Aug 2023 07:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CD2C433C8;
        Tue,  8 Aug 2023 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691481075;
        bh=zYWbFm1/5e8c6yGDQtvPeFqNeW0eye+n0KrF9/tpOdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GORxKpn1qyJyRQAUVa0NRqqSh8gH5UfcYN0OvvFB7FG/dfmcImQ+icgXX1KJg9jQl
         rMBpdeKHebLqlWNag/1Y8MPpXj51WDMPpuTS1kcKVx+gdFVbxVDDkmU1+rve/8FZZO
         Owc4ILSLZbL016K2AMJJOYtePbeaIxDNzGDIYifvaf6te/4W+wqZbVZGFnb05Mb6Is
         pU2EuXskXyLHnNmmCgrMUJbRokD3hCAKXv0uQDSNRYSxi+IlEovYeaA/+9/183/1WB
         ChrUYpmF6JDWPaJXyYo7j8Fcjg4u92dc6mwNX8OCHEmvcRq43cjqJDjQxVCQHnA+bZ
         7RIbDMbII6Srg==
Date:   Tue, 8 Aug 2023 13:21:03 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Add SDX75 based modem
 support
Message-ID: <20230808075103.GD4990@thinkpad>
References: <1691460215-45383-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1691460215-45383-1-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:03:35AM +0800, Qiang Yu wrote:
> Add generic info for SDX75 based modems. SDX75 takes longer than expected
> (default, 8 seconds) to set ready after reboot. Hence add optional ready
> timeout parameter to wait enough for device ready as part of power up
> sequence.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/bus/mhi/host/init.c        |  1 +
>  drivers/bus/mhi/host/main.c        |  7 ++++++-
>  drivers/bus/mhi/host/pci_generic.c | 22 ++++++++++++++++++++++
>  drivers/bus/mhi/host/pm.c          |  6 +++++-
>  include/linux/mhi.h                |  4 ++++
>  5 files changed, 38 insertions(+), 2 deletions(-)
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
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 74a7543..8590926 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -43,8 +43,13 @@ int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
>  				    u32 mask, u32 val, u32 delayus)
>  {
>  	int ret;
> -	u32 out, retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
> +	u32 out, retry;
> +	u32 timeout_ms = mhi_cntrl->timeout_ms;
>  
> +	if (mhi_cntrl->ready_timeout_ms && mask == MHISTATUS_READY_MASK)
> +		timeout_ms = mhi_cntrl->ready_timeout_ms;

Instead of handling the timeout inside mhi_poll_reg_field(), you should pass the
appropriate timeout value to this function.

> +
> +	retry = (timeout_ms * 1000) / delayus;
>  	while (retry--) {
>  		ret = mhi_read_reg_field(mhi_cntrl, base, offset, mask, &out);
>  		if (ret)
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index fcd80bc..9c601f0 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -269,6 +269,16 @@ static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
>  	MHI_EVENT_CONFIG_HW_DATA(5, 2048, 101)
>  };
>  
> +static const struct mhi_controller_config modem_qcom_v2_mhiv_config = {
> +	.max_channels = 128,
> +	.timeout_ms = 8000,
> +	.ready_timeout_ms = 50000,
> +	.num_channels = ARRAY_SIZE(modem_qcom_v1_mhi_channels),
> +	.ch_cfg = modem_qcom_v1_mhi_channels,
> +	.num_events = ARRAY_SIZE(modem_qcom_v1_mhi_events),
> +	.event_cfg = modem_qcom_v1_mhi_events,
> +};
> +
>  static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
>  	.max_channels = 128,
>  	.timeout_ms = 8000,
> @@ -278,6 +288,16 @@ static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
>  	.event_cfg = modem_qcom_v1_mhi_events,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
> +	.name = "qcom-sdx75m",
> +	.fw = "qcom/sdx75m/xbl.elf",
> +	.edl = "qcom/sdx75m/edl.mbn",
> +	.config = &modem_qcom_v2_mhiv_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.sideband_wake = false,
> +};
> +
>  static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
>  	.name = "qcom-sdx65m",
>  	.fw = "qcom/sdx65m/xbl.elf",
> @@ -597,6 +617,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
> +		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 8a4362d..6f049e0 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -1202,14 +1202,18 @@ EXPORT_SYMBOL_GPL(mhi_power_down);
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

Since you are using this extended timeout value in a couple of places (not just
for checking READY_STATE), it is better to use the existing "timeout_ms"
parameter.

- Mani

>  	wait_event_timeout(mhi_cntrl->state_event,
>  			   MHI_IN_MISSION_MODE(mhi_cntrl->ee) ||
>  			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
> -			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
> +			   msecs_to_jiffies(timeout_ms));
>  
>  	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
>  	if (ret)
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index f6de4b6..a43e5f8 100644
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
> @@ -326,6 +328,7 @@ struct mhi_controller_config {
>   * @pm_mutex: Mutex for suspend/resume operation
>   * @pm_lock: Lock for protecting MHI power management state
>   * @timeout_ms: Timeout in ms for state transitions
> + * @ready_timeout_ms: Timeout in ms for waiting device to be ready (optional)
>   * @pm_state: MHI power management state
>   * @db_access: DB access states
>   * @ee: MHI device execution environment
> @@ -413,6 +416,7 @@ struct mhi_controller {
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

-- 
மணிவண்ணன் சதாசிவம்
