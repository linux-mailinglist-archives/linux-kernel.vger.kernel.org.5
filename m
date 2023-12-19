Return-Path: <linux-kernel+bounces-4523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9762F817ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A020A1C21BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A69215B1;
	Tue, 19 Dec 2023 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqQed9Mu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D91381;
	Tue, 19 Dec 2023 00:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF2CC433CA;
	Tue, 19 Dec 2023 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702945804;
	bh=dw3k5aL/+6q2ocOCHy31//nhjrvy16fo24znW4qvxy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UqQed9MujdbM2y2QI6n6x1UOSn5io0ur9S0LEQaA5dV9T1nl4BL08O2LwaFX/mSb1
	 DV8vAEBU5zmeelUVdkYrF459xs4/ctuN165RYzo8Df44Wur8wldRRYDbgd13InHw2y
	 YlzBCbu1IEcI8S9ZvyyHiiZrRLMdWLpYsY39fLefa5a4ZfY+wDW1ODGWW1J8x+LZOu
	 nG/NjW52sJA/K52ZWIfMwbcm3aopP6CLVpT/ctgwspvukJbHBg/U0rut1iW4ZIriTU
	 8r7KQGFx0kQECZcT2yPJqmPM7sV8UR/M2iOsPTw+XpikDECz3+B0+G3mJsw5+Vv9TS
	 seECCCXdIfrcQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e40b43798so239561e87.0;
        Mon, 18 Dec 2023 16:30:04 -0800 (PST)
X-Gm-Message-State: AOJu0YzEF84r4wjUuAmcPW4O74Pe5zxNwsC17esBD47/10OR0bzRvWz0
	fW7qpC2VCvcNmyJ8FJ413jOeAWK09JyZyvG7Htg=
X-Google-Smtp-Source: AGHT+IFInPMQlA+Ca8x14vA0j4gu69kLAYi40K1ird4Pq+zJBgicUUnX0qhOg0GlzoKLjwX4/8r8hXyMjuGpJVtIDH0=
X-Received: by 2002:a19:9141:0:b0:50e:48c4:ba7d with SMTP id
 y1-20020a199141000000b0050e48c4ba7dmr43425lfj.2.1702945802370; Mon, 18 Dec
 2023 16:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215063714.7684-1-hao.qin@mediatek.com>
In-Reply-To: <20231215063714.7684-1-hao.qin@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 18 Dec 2023 18:29:52 -0600
X-Gmail-Original-Message-ID: <CAGp9LzrFWRo-DF7de4EC49ezUHjcw6SsWXMhMAxe1a=8YM7sVQ@mail.gmail.com>
Message-ID: <CAGp9LzrFWRo-DF7de4EC49ezUHjcw6SsWXMhMAxe1a=8YM7sVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: btusb: mediatek: add a recovery method for MT7922
To: Hao Qin <hao.qin@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <deren.Wu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, 
	Chris Lu <chris.lu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hao,

On Fri, Dec 15, 2023 at 12:40=E2=80=AFAM Hao Qin <hao.qin@mediatek.com> wro=
te:
>
> From: "hao.qin" <hao.qin@mediatek.com>
>
> For MT7922, perform a reset before patch download to avoid
> unexpected problems caused by inconsistency between upper layer
> status and dongle status. Add USB reset retry to recover from
> unexpected patch download failure.

After looking through the patch, I guess the patch providing the reset
mechanism for
1) the core layer to call when cmd is timeout
2) resetting the device before the patch download
3) handling situations where something goes wrong during the patch
download phase
right ? if so, the description should be revised to make the patch
close to what it does

>
> Signed-off-by: hao.qin <hao.qin@mediatek.com>
> ---
>  drivers/bluetooth/btusb.c | 66 +++++++++++++++++++++++++++------------
>  1 file changed, 46 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 0926e4451802..778e1a0d9cae 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2812,7 +2812,7 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *h=
dev,
>          * WMT command.
>          */
>         err =3D wait_on_bit_timeout(&data->flags, BTUSB_TX_WAIT_VND_EVT,
> -                                 TASK_INTERRUPTIBLE, HCI_INIT_TIMEOUT);
> +                                 TASK_INTERRUPTIBLE, HCI_CMD_TIMEOUT);

The changes are not specific to MT7922 and do not align with the
commit description. Kindly consider moving them to another patch and
provide clear reasons why they are necessary for MT7922 or any other
chipsets.

>         if (err =3D=3D -EINTR) {
>                 bt_dev_err(hdev, "Execution of wmt command interrupted");
>                 clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
> @@ -2994,28 +2994,22 @@ static u32 btusb_mtk_reset_done(struct hci_dev *h=
dev)
>         return val & MTK_BT_RST_DONE;
>  }
>
> -static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
> +static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
> -       struct btmediatek_data *mediatek;
>         u32 val;
>         int err;
>
> -       /* It's MediaTek specific bluetooth reset mechanism via USB */
> -       if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> -               bt_dev_err(hdev, "last reset failed? Not resetting again"=
);
> -               return -EBUSY;
> -       }
> -
> -       err =3D usb_autopm_get_interface(data->intf);
> -       if (err < 0)
> -               return err;
> -
> -       btusb_stop_traffic(data);
> -       usb_kill_anchored_urbs(&data->tx_anchor);
> -       mediatek =3D hci_get_priv(hdev);
> -

It seems that you refactored the existing btusb_mtk_reset in the
patch. Could you please create another patch specifically for the
refactoring without introducing any functional changes of MT7922 prior
to adding the patch? This way would be good for ease of review and
tracking in the future. Additionally, it ensures that those working on
MT7921 are aware of the patch and its modifications.

> -       if (mediatek->dev_id =3D=3D 0x7925) {
> +       if (dev_id =3D=3D 0x7922) {
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> +               val |=3D 0x00002020;
> +               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
> +               btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001)=
;
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> +               val |=3D (1 << 0);

We can utilize BIT(0) instead of 1 << 0

> +               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
> +               msleep(100);
> +       } else if (dev_id =3D=3D 0x7925) {
>                 btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
>                 val |=3D (1 << 5);

We can utilize BIT(5) instead of 1 << 5

>                 btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
> @@ -3053,14 +3047,41 @@ static int btusb_mtk_reset(struct hci_dev *hdev, =
void *rst_data)
>         err =3D readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
>                                  val & MTK_BT_RST_DONE, 20000, 1000000);
>         if (err < 0)
> -               bt_dev_err(hdev, "Reset timeout");
> +               bt_dev_err(hdev, "Subsys reset timeout");

I guess it would be better to avoid the unnecessary change unrelated
to the patch.

> +
> +       if (dev_id =3D=3D 0x7922)
> +               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x0000=
00FF);
>
>         btusb_mtk_id_get(data, 0x70010200, &val);
>         if (!val)
>                 bt_dev_err(hdev, "Can't get device id, subsys reset fail.=
");
>
> -       usb_queue_reset_device(data->intf);
> +       return err;
> +}
> +
> +static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       struct btmediatek_data *mediatek;
> +       int err;
> +
> +       /* It's MediaTek specific bluetooth reset mechanism via USB */
> +       if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> +               bt_dev_err(hdev, "last reset failed? Not resetting again"=
);
> +               return -EBUSY;
> +       }
> +
> +       err =3D usb_autopm_get_interface(data->intf);
> +       if (err < 0)
> +               return err;
> +
> +       btusb_stop_traffic(data);
> +       usb_kill_anchored_urbs(&data->tx_anchor);
> +       mediatek =3D hci_get_priv(hdev);
>
> +       err =3D btusb_mtk_subsys_reset(hdev, mediatek->dev_id);
> +
> +       usb_queue_reset_device(data->intf);
>         clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
>
>         return err;
> @@ -3119,6 +3140,8 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>                 fwname =3D FIRMWARE_MT7668;
>                 break;
>         case 0x7922:
> +               btusb_mtk_subsys_reset(hdev, dev_id);
> +               fallthrough;
>         case 0x7961:
>         case 0x7925:
>                 if (dev_id =3D=3D 0x7925)
> @@ -3134,6 +3157,9 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>                                                 btusb_mtk_hci_wmt_sync);
>                 if (err < 0) {
>                         bt_dev_err(hdev, "Failed to set up firmware (%d)"=
, err);
> +                       btusb_stop_traffic(data);
> +                       usb_kill_anchored_urbs(&data->tx_anchor);
> +                       usb_queue_reset_device(data->intf);

The change doesn't appear to be specific to MT7922, as the commit
description suggests. Please consider splitting it into another patch
to address any existing chipset issues, if necessary.

>                         return err;
>                 }
>
> --
> 2.18.0
>
>

