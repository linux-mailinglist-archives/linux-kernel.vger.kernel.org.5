Return-Path: <linux-kernel+bounces-12437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5781F4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097471C21B98
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420C63C0B;
	Thu, 28 Dec 2023 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="ZTRdhT1y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD01FDD;
	Thu, 28 Dec 2023 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 5E86E40564;
	Thu, 28 Dec 2023 11:08:29 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1703743710; bh=nOX6jjTicKxqmOSERrqk583i64MzTIyy5OLB82ZzTv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTRdhT1yd+lcRCUOlGTMlRLWUJP6aBO4M+m5XV3w8tint5euG4BSa94c+xsKq4+m/
	 hSPud5i0yagcLi3Bcmd9w/QEi+HYqz3yu+GyhBZQi/f4TCd3xVSoYjZTjob+IVxTm3
	 dLf/5BA6Wk+MKXn2WkKRQVmC9zfeZb7L2Ke3E+2bWfDzN+4WskCBxtVnPvv0Eai1uP
	 Wi4vNJqj6uGhBWpAh4EDY2l1bxhi92kr4Hr5fyX7bjSBQ+uxjP2gmUCf5isnyRJz+R
	 JwSu6yfUhYY9a1+27hT05cju82qtA7fDrvUGR9hcKAr1GZOKVNafGVLwHnUW5mrFzs
	 1pbHn8COU8Zuw==
Date: Thu, 28 Dec 2023 11:08:26 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <grhpb3vyajjmceuwgna36g6k2esjtw6qrv35ldlwgdmlvjvuo5@2b3q27zxttxa>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227180306.6319-1-johan+linaro@kernel.org>

On Wed, Dec 27, 2023 at 07:03:06PM +0100, Johan Hovold wrote:
> The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> device address in MSB order when setting it using the
> EDL_WRITE_BD_ADDR_OPCODE command.
> 
> Presumably, this is the case for all non-ROME devices which all use the
> EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> use a different command and expect the address in LSB order).
> 
> Reverse the little-endian address before setting it to make sure that
> the address can be configured using tools like btmgmt or using the
> 'local-bd-address' devicetree property.
> 
> Note that this can potentially break systems with boot firmware which
> has started relying on the broken behaviour and is incorrectly passing
> the address via devicetree in MSB order.
> 
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
> Cc: stable@vger.kernel.org      # 5.1
> Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

The same issue was present on sc7180 (qcom,wcn3991-bt) and this patch
fixes it.

Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180

Thanks!

> ---
> 
> Hi Qualcomm people,
> 
> Could you please verify with your documentation that all non-ROME
> devices expect the address provided in the EDL_WRITE_BD_ADDR_OPCODE
> command in MSB order?
> 
> I assume this is not something that anyone would change between firmware
> revisions, but if that turns out to be the case, we'd need to reverse
> the address based on firmware revision or similar.
> 
> Johan
> 
> 
>  drivers/bluetooth/btqca.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index fdb0fae88d1c..29035daf21bc 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -826,11 +826,15 @@ EXPORT_SYMBOL_GPL(qca_uart_setup);
>  
>  int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  {
> +	bdaddr_t bdaddr_swapped;
>  	struct sk_buff *skb;
>  	int err;
>  
> -	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6, bdaddr,
> -				HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
> +	baswap(&bdaddr_swapped, bdaddr);
> +
> +	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6,
> +				&bdaddr_swapped, HCI_EV_VENDOR,
> +				HCI_INIT_TIMEOUT);
>  	if (IS_ERR(skb)) {
>  		err = PTR_ERR(skb);
>  		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
> -- 
> 2.41.0

