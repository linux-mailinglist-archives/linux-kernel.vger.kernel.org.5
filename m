Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F46762CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGZHLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjGZHLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A88A3C24;
        Wed, 26 Jul 2023 00:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3971A61709;
        Wed, 26 Jul 2023 07:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4FEC433C8;
        Wed, 26 Jul 2023 07:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690355245;
        bh=7abV0l4C3qKzncBqw93/hcngzGzhBVF9y7thXLvQed0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CT3Qy7r2CYKduSMwIaVtpHDFiL0YN5NMei7s4lsNfvWhK9h9dg6iPDW3yqxOklL7m
         DNTHNQUDPlAS/Dv3nbHjQpI8Zkscw56rgJ4sen9K3tXnEJDurjAIjpEMinK+rlHIob
         uG5r6fefxNZIXhrVzbFhpt/3maXqHRod+wOLRbX7VwSggKc6Eqzo/vh8yJrLQk7pkC
         27yFJeTHUmsMLRwqKzJU7NuPqJib5QVRlXzJONNzTNtvTJfZ3Q19DguOvg4iMtq+Qt
         pBSeZgf8QVlnYZcyxBChqZPjPYRvTEbIEMbyqM3qiir09vgFQaPhf1KYa8tc6GG3jm
         L92GIW6um5D8Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qOYcX-0003T7-1x;
        Wed, 26 Jul 2023 09:07:41 +0200
Date:   Wed, 26 Jul 2023 09:07:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hemantg@quicinc.com
Subject: Re: [PATCH v12 2/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Message-ID: <ZMDGPTSEvfpHRDvh@hovoldconsulting.com>
References: <20230726052245.609987-1-quic_tjiang@quicinc.com>
 <20230726052245.609987-3-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726052245.609987-3-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 01:22:45PM +0800, Tim Jiang wrote:
> This patch adds support for QCA2066 firmware patch and NVM downloading.
> as the RF performance of QCA2066 SOC chip from different foundries may
> vary. Therefore we use different NVM to configure them based on board ID.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c   | 76 ++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btqca.h   |  3 +-
>  drivers/bluetooth/hci_qca.c |  7 ++++
>  3 files changed, 83 insertions(+), 3 deletions(-)
  
> +static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
> +		   size_t max_size, struct qca_btsoc_version ver, u16 bid)
> +{
> +	u8 rom_ver;
> +	u32 soc_ver;
> +	const char *variant;
> +
> +	soc_ver = get_soc_ver(ver.soc_id, ver.rom_ver);
> +	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> +
> +	if ((le32_to_cpu(ver.soc_id) & 0x0000ff00) == QCA_HSP_GF_SOC_ID)  /* hsp gf chip */
> +		variant = "g";
> +	else
> +		variant = "";
> +
> +	if (bid == 0x0)
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
> +	else
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
> +
> +	bt_dev_dbg(hdev, "%s: nvm name is %s", __func__, fwname);

no need for "nvme name is" if you keep __func__ as a prefix

> +}
> +
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>  		   const char *firmware_name)
> @@ -582,6 +645,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	int err;
>  	u8 rom_ver = 0;
>  	u32 soc_ver;
> +	u16 boardid = 0;
>  
>  	bt_dev_dbg(hdev, "QCA setup on UART");

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 453000df7aec..353c775f53ef 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1939,6 +1939,11 @@ static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
>  	.num_vregs = 0,
>  };
>  
> +static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
> +	.soc_type = QCA_QCA2066,
> +	.num_vregs = 0,
> +};

Add before qca_soc_data_qca6390 to maintain some order.

> +
>  static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
>  	.soc_type = QCA_WCN6750,
>  	.vregs = (struct qca_vreg []) {
> @@ -2429,6 +2434,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>  	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
>  	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
>  	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
> +	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},

Keep the entries sorted by compatible.

Johan
