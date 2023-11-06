Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3157E19B4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjKFFo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFFoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:44:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA1FCC;
        Sun,  5 Nov 2023 21:44:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3BCC433C7;
        Mon,  6 Nov 2023 05:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699249461;
        bh=8uXGC6j+jfsNh6sHXtDnoNTF/2ftSR8fSzs9oPCpqQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OS5M2bp36cODi/AWL8cjpYlQJYPbjXNrwcmrKB8uQ9+48tu3TsOKbXFlgP6GqS4Fk
         5YLfGxIkzBvauYf/0XjF8AuBmLp0CNTFAE+OJ8wzPrPuC3t+FePbOqLoI02mE9A+XD
         5BnfBcAz/89hSGgllKBNRoeCon2Yk6hx8VHvhwP5dezS/f98M5tTFAG68UyZSXaGci
         7kBa051CRcSWU8v0xIR/QHYWN9HK3dQGhDSMcawRi1200bi+B0luUo8mM4zir1wk0l
         ywc3m+NLkyik7NI8OMaIPOLwHJZ2HEIXnZvYcJSKzm+pEVclxqga4ZCXRgAYybcj4p
         eV2yV1bdredig==
Date:   Mon, 6 Nov 2023 11:14:13 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH 2/2] bus: mhi: host: pci_generic: Add SDX75 based modem
 support
Message-ID: <20231106054413.GD2474@thinkpad>
References: <1699242172-79472-1-git-send-email-quic_qianyu@quicinc.com>
 <1699242172-79472-3-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699242172-79472-3-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 11:42:52AM +0800, Qiang Yu wrote:
> Add generic info for SDX75 based modems. SDX75 takes longer to set ready
> during power up. Hence use separate configuration.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 08f3f03..cd6cd14 100644
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
> @@ -600,6 +620,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
> +		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
