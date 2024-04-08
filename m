Return-Path: <linux-kernel+bounces-134693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE2489B528
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8C41F2147C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6974915A8;
	Mon,  8 Apr 2024 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bft/Mse5"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5F1C3E;
	Mon,  8 Apr 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538880; cv=none; b=bIUgwy+wOJIEVEPlWNYuNJrJO+X+5w/HSys4pTG80QYbSElLmiDCIV6lXYPNc74WUrhp4MOXEE6dbASn6hbUctIxgGmBaroYHwk0N5GHiqVfI9FdF2IskaMMebFH/Zt2nW4lwpe4YdHvOnUhd73z7Rq4EpVgUkzEDMw8CVe/mrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538880; c=relaxed/simple;
	bh=MY0XT4B3pDzF9IJCSggOxvfZtmHPlsS1ZeKs0nQG6x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpuxCKeGPXm1GtDzHX0Nyx2OfXFUPm+RrLnebp2zjwFIZqV5bdfncKl5JfkCvemuncO0oouuf3aOF/KlH7De55vtfF5zx/Ymz7ApNGHl5AEBXY43AXE/fOT7U3Ec489NLMb+iLhdEbVpzqajtzPGfjnHubOo21Wrz64GxmXGE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bft/Mse5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d718ee7344so45807591fa.2;
        Sun, 07 Apr 2024 18:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712538875; x=1713143675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8SfdCvFB9haCi91r/Pc68opHQaIfcH4FUkOHMtcvc8=;
        b=bft/Mse5p552v3dLbAZt1OD9qIzONFFBAb01FbkHSPSICIsQIpXKjwFPg+qStfXjOy
         XBqzvM+SX3fuGFnOwKDKrZKhbnjDJLpRZ6I+VtqBvmME47gSe+dPBwddoo0oSl00PunS
         hkV3JFYaj8n7iL5qcX6Ap0/GWdjD74cTEMZxCi3y2vOYqVBeLRVigkON07ALl3kuq2cz
         EoI7NWlwogx4Vp9LR14PE4gkiarlot9rYJ8BDK6erjyZxTBoSs678abGxag9thyfb08n
         BAoZY78Dnh0ZNbHvMdJNZbcGq5k773zjkTmCQmK39cnK8rPeTzUEYp6LnjA8Awh69LhC
         q7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712538875; x=1713143675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8SfdCvFB9haCi91r/Pc68opHQaIfcH4FUkOHMtcvc8=;
        b=uM9DF2zTRxDD93vBxDNv3WNCxRzGXGI8i1oU5G/AhgD7iMGssK4+FWc9KYQ2Fo/ge6
         78i5yFALhWKli1tOv2xv1LvY8nE3PTrmZ/YM3irRJy9XkC75HBBgo8PvO2kE7mQMBKHu
         g06rP5S25xlAR4XmYmS32JwjOpaTopslrO9UTMuVTHzZqdPTfvnpDzBHUIRT0Tt8wsfy
         Hlv04JLe1puPKlhbfYDX8CRrTTCLgRFDatCsXmwyvt/tz5b73EdeHzqlBhdyCSEjCO2W
         3VC+3Hh3EIqaZX7qNfXk6kB8/oMb6cB/lQoqHrZWJLOshMo562a2X08AawarjQF4pJFB
         LNXg==
X-Forwarded-Encrypted: i=1; AJvYcCXOyqgyrFsPGP51GM+J5DalA91FdeZgGx3D4Fy4UWbWDfcnKA55LTNUVTTJKhHu7oOYcISMFhEF4b9OY9wWOO7mgRvG4Nj3XxTvSQ==
X-Gm-Message-State: AOJu0YwnmVLpAg4oNOIndDAahxRrn5BoJPTTEhjKKT0M4ERvctRpLjwE
	kosOqzxDubWR9TYDza55ktuFV2IRugh/jBTjj5XXLQMWGFFpA7CG12oOCxoBpBiY2EJlY3WsqDA
	UXiD54Q5G1iFEdXblNNH52lPzNkM=
X-Google-Smtp-Source: AGHT+IHqqybqlXZEhwrW29/KSVk4Pqnd8aEDFyT0l1iMW9mHSHN9Ne1UPcIFso0pV6N7hbwAx91sudrFub5UckQCU9Y=
X-Received: by 2002:ac2:42cf:0:b0:516:d504:5ae8 with SMTP id
 n15-20020ac242cf000000b00516d5045ae8mr5631687lfl.21.1712538874672; Sun, 07
 Apr 2024 18:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404062347.3219795-1-cristian.marussi@arm.com> <20240404062347.3219795-3-cristian.marussi@arm.com>
In-Reply-To: <20240404062347.3219795-3-cristian.marussi@arm.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 7 Apr 2024 20:14:23 -0500
Message-ID: <CABb+yY3yzj167ypLPPV7OvqDWfv9y9EFQeZ5pxPAx7xUyyvLVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mailbox: arm_mhuv3: Add driver
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, sudeep.holla@arm.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:25=E2=80=AFAM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Add support for ARM MHUv3 mailbox controller.
>
> Support is limited to the MHUv3 Doorbell extension using only the PBX/MBX
> combined interrupts.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 -> v2
> - fixed checkpatch warnings about side-effects
> - fixed sparse errors as reported
>   | Reported-by: kernel test robot <lkp@intel.com>
>   | Closes: https://lore.kernel.org/oe-kbuild-all/202403290015.tCLXudqC-l=
kp@intel.com/
> ---
>  MAINTAINERS                 |    9 +
>  drivers/mailbox/Kconfig     |   11 +
>  drivers/mailbox/Makefile    |    2 +
>  drivers/mailbox/arm_mhuv3.c | 1063 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1085 insertions(+)
>  create mode 100644 drivers/mailbox/arm_mhuv3.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa3b947fb080..e957b9d9e32a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12998,6 +12998,15 @@ F:     Documentation/devicetree/bindings/mailbox=
/arm,mhuv2.yaml
>  F:     drivers/mailbox/arm_mhuv2.c
>  F:     include/linux/mailbox/arm_mhuv2_message.h
>
> +MAILBOX ARM MHUv3
> +M:     Sudeep Holla <sudeep.holla@arm.com>
> +M:     Cristian Marussi <cristian.marussi@arm.com>
> +L:     linux-kernel@vger.kernel.org
> +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> +F:     drivers/mailbox/arm_mhuv3.c
> +
>  MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
>  M:     Alejandro Colomar <alx@kernel.org>
>  L:     linux-man@vger.kernel.org
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 42940108a187..d20cdae65cfe 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -23,6 +23,17 @@ config ARM_MHU_V2
>           Say Y here if you want to build the ARM MHUv2 controller driver=
,
>           which provides unidirectional mailboxes between processing elem=
ents.
>
> +config ARM_MHU_V3
> +       tristate "ARM MHUv3 Mailbox"
> +       depends on ARM64 || COMPILE_TEST
> +       help
> +         Say Y here if you want to build the ARM MHUv3 controller driver=
,
> +         which provides unidirectional mailboxes between processing elem=
ents.
> +
> +         ARM MHUv3 controllers can implement a varying number of extensi=
ons
> +         that provides different means of transports: supported extensio=
ns
> +         will be discovered and possibly managed at probe-time.
> +
>  config IMX_MBOX
>         tristate "i.MX Mailbox"
>         depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 18793e6caa2f..5cf2f54debaf 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -9,6 +9,8 @@ obj-$(CONFIG_ARM_MHU)   +=3D arm_mhu.o arm_mhu_db.o
>
>  obj-$(CONFIG_ARM_MHU_V2)       +=3D arm_mhuv2.o
>
> +obj-$(CONFIG_ARM_MHU_V3)       +=3D arm_mhuv3.o
> +
>  obj-$(CONFIG_IMX_MBOX) +=3D imx-mailbox.o
>
>  obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)    +=3D armada-37xx-rwtm-mailbox.o
> diff --git a/drivers/mailbox/arm_mhuv3.c b/drivers/mailbox/arm_mhuv3.c
> new file mode 100644
> index 000000000000..e4125568bec0
> --- /dev/null
> +++ b/drivers/mailbox/arm_mhuv3.c
> @@ -0,0 +1,1063 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM Message Handling Unit Version 3 (MHUv3) driver.
> + *
> + * Copyright (C) 2024 ARM Ltd.
> + *
> + * Based on ARM MHUv2 driver.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +/* =3D=3D=3D=3D=3D=3D MHUv3 Registers =3D=3D=3D=3D=3D=3D */
> +
> +/* Maximum number of Doorbell channel windows */
> +#define MHUV3_DBCW_MAX                 128
> +/* Number of DBCH combined interrupt status registers */
> +#define MHUV3_DBCH_CMB_INT_ST_REG_CNT  4
> +#define MHUV3_INVALID_DOORBELL         0xFFFFFFFFUL
> +
> +/* Number of FFCH combined interrupt status registers */
> +#define MHUV3_FFCH_CMB_INT_ST_REG_CNT  2
> +
> +#define MHUV3_STAT_BYTES               (sizeof(u32))
>
Simply 4 please.

> +#define MHUV3_STAT_BITS                        (MHUV3_STAT_BYTES * __CHA=
R_BIT__)
>
just 32.

> +
> +/* Not a typo ... */
> +#define MHUV3_MAJOR_VERSION            2
> +
> +enum {
> +       MHUV3_MBOX_CELL_TYPE,
> +       MHUV3_MBOX_CELL_CHWN,
> +       MHUV3_MBOX_CELL_PARAM,
> +       MHUV3_MBOX_CELLS
> +};
> +
> +/* CTRL_Page */
> +
> +struct blk_id {
> +       u32 blk_id : 4;

Please avoid name clashes.

> +       u32 pad : 28;
> +} __packed;
> +
> +struct feat_spt0 {
> +       u32 dbe_spt : 4;
> +       u32 fe_spt : 4;
> +       u32 fce_spt : 4;
> +       u32 tze_spt : 4;
> +       u32 rme_spt : 4;
> +       u32 rase_spt : 4;
> +       u32 pad: 8;
> +} __packed;
> +
> +struct feat_spt1 {
> +       u32 auto_op_spt : 4;
> +       u32 pad: 28;
> +} __packed;
> +
> +struct dbch_cfg0 {
> +       u32 num_dbch : 8;
> +       u32 pad: 24;
> +} __packed;
> +
> +struct ffch_cfg0 {
> +       u32 num_ffch : 8;
> +       u32 x8ba_spt : 1;
> +       u32 x16ba_spt : 1;
> +       u32 x32ba_spt : 1;
> +       u32 x64ba_spt : 1;
> +       u32 pad : 4;
> +       u32 ffch_depth : 10;
> +       u32 pad2 : 6;
> +} __packed;
> +
> +struct fch_cfg0 {
> +       u32 num_fch : 10;
> +       /* MBX only registers */
> +       u32 fcgi_spt : 1;
> +       /* ------------------ */
> +       u32 num_fcg : 5;
> +       u32 num_fch_per_grp : 5;
> +       u32 fch_ws : 8;
> +       u32 pad : 3;
> +} __packed;
> +
> +struct ctrl {
> +       u32 op_req : 1;
> +       u32 ch_op_mask : 1;
> +       u32 pad : 30;
> +} __packed;
> +
> +struct fch_ctrl {
> +       u32 pad : 2;
> +       u32 int_en : 1;
> +       u32 pad2 : 29;
> +} __packed;
> +
> +struct iidr {
> +       u32 implementer : 12;
> +       u32 revision : 4;
> +       u32 variant : 4;
> +       u32 product_id : 12;
> +} __packed;
> +
> +struct aidr {
> +       u32 arch_minor_rev : 4;
> +       u32 arch_major_rev : 4;
> +       u32 pad : 24;
> +} __packed;
> +
I am not sure about using bitfields on register values. I know v2
driver also uses bitfields but this still is not very portable and is
dependent on compiler behaviour. We may actually save some loc by not
having unused fields if we use shifts and masks. Though I don't
strongly feel either way.

> +struct ctrl_page {
> +       struct blk_id blk_id;
> +       u8 pad[0x10 - 0x4];
> +       struct feat_spt0 feat_spt0;
> +       struct feat_spt1 feat_spt1;
> +       u8 pad1[0x20 - 0x18];
> +       struct dbch_cfg0 dbch_cfg0;
> +       u8 pad2[0x30 - 0x24];
> +       struct ffch_cfg0 ffch_cfg0;
> +       u8 pad3[0x40 - 0x34];
> +       struct fch_cfg0 fch_cfg0;
> +       u8 pad4[0x100 - 0x44];
> +       struct ctrl ctrl;
> +       /* MBX only registers */
> +       u8 pad5[0x140 - 0x104];
> +       struct fch_ctrl fch_ctrl;
> +       u32 fcg_int_en;
> +       u8 pad6[0x400 - 0x148];
> +       /* ------------------ */
Why the decoration ? Maybe comment on what different starts from here.

> +       u32 dbch_int_st[MHUV3_DBCH_CMB_INT_ST_REG_CNT];
> +       u32 ffch_int_st[MHUV3_FFCH_CMB_INT_ST_REG_CNT];
> +       /* MBX only registers */
> +       u8 pad7[0x470 - 0x418];
> +       u32 fcg_int_st;
> +       u8 pad8[0x480 - 0x474];
> +       u32 fcg_grp_int_st[32];
> +       u8 pad9[0xFC8 - 0x500];
> +       /* ------------------ */
> +       struct iidr iidr;
> +       struct aidr aidr;
> +       u32 imp_def_id[12];
> +} __packed;
> +
> +/* DBCW_Page */
> +
> +struct xbcw_ctrl {
> +       u32 comb_en : 1;
> +       u32 pad : 31;
> +} __packed;
> +
> +struct pdbcw_int {
> +       u32 tfr_ack : 1;
> +       u32 pad : 31;
> +} __packed;
> +
> +struct pdbcw_page {
> +       u32 st;
> +       u8 pad[0xC - 0x4];
> +       u32 set;
> +       struct pdbcw_int int_st;
> +       struct pdbcw_int int_clr;
> +       struct pdbcw_int int_en;
> +       struct xbcw_ctrl ctrl;
> +} __packed;
> +
> +struct mdbcw_page {
> +       u32 st;
> +       u32 st_msk;
> +       u32 clr;
> +       u8 pad[0x10 - 0xC];
> +       u32 msk_st;
> +       u32 msk_set;
> +       u32 msk_clr;
> +       struct xbcw_ctrl ctrl;
> +} __packed;
> +
> +struct dummy_page {
> +       u8 pad[0x1000];
> +} __packed;
> +
> +struct mhu3_pbx_frame_reg {
> +       struct ctrl_page ctrl;
> +       struct pdbcw_page dbcw[MHUV3_DBCW_MAX];
> +       struct dummy_page ffcw;
> +       struct dummy_page fcw;
> +       u8 pad[0xF000 - 0x4000];
> +       struct dummy_page impdef;
> +} __packed;
> +
> +struct mhu3_mbx_frame_reg {
> +       struct ctrl_page ctrl;
> +       struct mdbcw_page dbcw[MHUV3_DBCW_MAX];
> +       struct dummy_page ffcw;
> +       struct dummy_page fcw;
> +       u8 pad[0xF000 - 0x4000];
> +       struct dummy_page impdef;
> +} __packed;
> +
> +/* Macro for reading a bitfield within a physically mapped packed struct=
 */
> +#define readl_relaxed_bitfield(_regptr, _field)                         =
       \
> +       ({                                                              \
> +               u32 _rval;                                              \
> +               typeof(_regptr) _rptr =3D _regptr;                       =
 \
> +               _rval =3D readl_relaxed(_rptr);                          =
 \
> +               ((typeof(*_rptr) __force *)(&_rval))->_field;           \
> +       })
> +
> +/* Macro for writing a bitfield within a physically mapped packed struct=
 */
> +#define writel_relaxed_bitfield(_value, _regptr, _field)               \
> +       ({                                                              \
> +               u32 _rval;                                              \
> +               typeof(_regptr) _rptr =3D _regptr;                       =
 \
> +               _rval =3D readl_relaxed(_rptr);                          =
 \
> +               ((typeof(*_rptr) __force *)(&_rval))->_field =3D _value; =
 \
> +               writel_relaxed(_rval, _rptr);                           \
> +       })
> +
> +/* =3D=3D=3D=3D=3D=3D MHUv3 data structures =3D=3D=3D=3D=3D=3D */
> +
> +enum mhuv3_frame {
> +       PBX_FRAME,
> +       MBX_FRAME
> +};
> +
> +static char *mhuv3_str[] =3D {
> +       "PBX",
> +       "MBX"
> +};
> +
> +enum mhuv3_extension_type {
> +       FIRST_EXT =3D 0,
> +       DBE_EXT =3D FIRST_EXT,
> +       FCE_EXT,
> +       FE_EXT,
> +       MAX_EXT
> +};
> +
> +struct mhuv3;
> +
> +/**
> + * struct mhuv3_protocol_ops - MHUv3 operations
> + *
> + * @rx_startup: Receiver startup callback.
> + * @rx_shutdown: Receiver shutdown callback.
> + * @read_data: Read available Sender in-band LE data (if any).
> + * @rx_complete: Acknowledge data reception to the Sender. Any out-of-ba=
nd data
> + *              has to have been already retrieved before calling this.
> + * @tx_startup: Sender startup callback.
> + * @tx_shutdown: Sender shutdown callback.
> + * @last_tx_done: Report back to the Sender if the last transfer has com=
pleted.
> + * @send_data: Send data to the receiver.
> + *
> + * Each supported transport protocol provides its own implementation of
> + * these operations.
> + */
> +struct mhuv3_protocol_ops {
> +       int (*rx_startup)(struct mhuv3 *mhu, struct mbox_chan *chan);
> +       void (*rx_shutdown)(struct mhuv3 *mhu, struct mbox_chan *chan);
> +       void *(*read_data)(struct mhuv3 *mhu, struct mbox_chan *chan);
> +       void (*rx_complete)(struct mhuv3 *mhu, struct mbox_chan *chan);
> +       void (*tx_startup)(struct mhuv3 *mhu, struct mbox_chan *chan);
> +       void (*tx_shutdown)(struct mhuv3 *mhu, struct mbox_chan *chan);
> +       int (*last_tx_done)(struct mhuv3 *mhu, struct mbox_chan *chan);
> +       int (*send_data)(struct mhuv3 *mhu, struct mbox_chan *chan, void =
*arg);
> +};
> +
> +/**
> + * struct mhuv3_mbox_chan_priv - MHUv3 channel private information
> + *
> + * @ch_idx: Channel window index associated to this mailbox channel.
> + * @doorbell: Doorbell bit number within the @ch_idx window.
> + *           Only relevant to Doorbell transport.
> + * @ops: Transport protocol specific operations for this channel.
> + *
> + * Transport specific data attached to mmailbox channel priv data.
> + */
> +struct mhuv3_mbox_chan_priv {
> +       u32 ch_idx;
> +       u32 doorbell;
> +       const struct mhuv3_protocol_ops *ops;
> +};
> +
> +/**
> + * struct mhuv3_extension - MHUv3 extension descriptor
> + *
> + * @type: Type of extension
> + * @max_chans: Max number of channels found for this extension.
> + * @base_ch_idx: First channel number assigned to this extension, picked=
 from
> + *              the set of all mailbox channels descriptors created.
> + * @mbox_of_xlate: Extension specific helper to parse DT and lookup asso=
ciated
> + *                channel from the related 'mboxes' property.
> + * @combined_irq_setup: Extension specific helper to setup the combined =
irq.
> + * @channels_init: Extension specific helper to initialize channels.
> + * @chan_from_comb_irq_get: Extension specific helper to lookup which ch=
annel
> + *                         triggered the combined irq.
> + * @pending_db: Array of per-channel pending doorbells.
> + * @pending_lock: Protect access to pending_db.
> + */
> +struct mhuv3_extension {
> +       enum mhuv3_extension_type type;
> +       unsigned int max_chans;
> +       unsigned int base_ch_idx;
> +       struct mbox_chan *(*mbox_of_xlate)(struct mhuv3 *mhu,
> +                                          unsigned int channel,
> +                                          unsigned int param);
> +       void (*combined_irq_setup)(struct mhuv3 *mhu);
> +       int (*channels_init)(struct mhuv3 *mhu);
> +       struct mbox_chan *(*chan_from_comb_irq_get)(struct mhuv3 *mhu);
> +       u32 pending_db[MHUV3_DBCW_MAX];
> +       /* Protect access to pending_db */
> +       spinlock_t pending_lock;
> +};
> +
> +/**
> + * struct mhuv3 - MHUv3 mailbox controller data
> + *
> + * @frame:     Frame type: MBX_FRAME or PBX_FRAME.
> + * @auto_op_full: Flag to indicate if the MHU supports AutoOp full mode.
> + * @major: MHUv3 controller architectural major version.
> + * @minor: MHUv3 controller architectural minor version.
> + * @tot_chans: The total number of channnels discovered across all exten=
sions.
> + * @cmb_irq: Combined IRQ number if any found defined.
> + * @ctrl: A reference to the MHUv3 control page for this block.
> + * @pbx: Base address of the PBX register mapping region.
> + * @mbx: Base address of the MBX register mapping region.
> + * @ext: Array holding descriptors for any found implemented extension.
> + * @mbox: Mailbox controller belonging to the MHU frame.
> + */
> +struct mhuv3 {
> +       enum mhuv3_frame frame;
> +       bool auto_op_full;
> +       unsigned int major;
> +       unsigned int minor;
> +       unsigned int tot_chans;
>
may be num_chans or chan_count ?


> +       int cmb_irq;
> +       struct ctrl_page __iomem *ctrl;
> +       union {
> +               struct mhu3_pbx_frame_reg __iomem *pbx;
> +               struct mhu3_mbx_frame_reg __iomem *mbx;
> +       };
> +       struct mhuv3_extension *ext[MAX_EXT];
> +       struct mbox_controller mbox;
> +};
> +
> +#define mhu_from_mbox(_mbox) container_of(_mbox, struct mhuv3, mbox)
> +
> +typedef int (*mhuv3_extension_initializer)(struct mhuv3 *mhu);
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Doorbell tr=
ansport protocol operations =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D *=
/
> +
> +static void mhuv3_doorbell_tx_startup(struct mhuv3 *mhu, struct mbox_cha=
n *chan)
> +{
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       /* Enable Transfer Acknowledgment events */
> +       writel_relaxed_bitfield(0x1, &mhu->pbx->dbcw[priv->ch_idx].int_en=
, tfr_ack);
> +}
> +
> +static void mhuv3_doorbell_tx_shutdown(struct mhuv3 *mhu, struct mbox_ch=
an *chan)
> +{
> +       unsigned long flags;
> +       struct mhuv3_extension *e =3D mhu->ext[DBE_EXT];
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
In order of decreasing line-lengths please everywhere.

> +       /* Disable Channel Transfer Ack events */
> +       writel_relaxed_bitfield(0x0, &mhu->pbx->dbcw[priv->ch_idx].int_en=
, tfr_ack);
> +
> +       /* Clear Channel Transfer Ack and pending doorbells */
> +       writel_relaxed_bitfield(0x1, &mhu->pbx->dbcw[priv->ch_idx].int_cl=
r, tfr_ack);
> +       spin_lock_irqsave(&e->pending_lock, flags);
> +       e->pending_db[priv->ch_idx] =3D 0;
> +       spin_unlock_irqrestore(&e->pending_lock, flags);
> +}
> +
> +static int mhuv3_doorbell_rx_startup(struct mhuv3 *mhu, struct mbox_chan=
 *chan)
> +{
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       /* Unmask Channel Transfer events */
> +       writel_relaxed(BIT(priv->doorbell), &mhu->mbx->dbcw[priv->ch_idx]=
msk_clr);
> +
> +       return 0;
> +}
> +
> +static void mhuv3_doorbell_rx_shutdown(struct mhuv3 *mhu,
> +                                      struct mbox_chan *chan)
> +{
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       /* Mask Channel Transfer events */
> +       writel_relaxed(BIT(priv->doorbell), &mhu->mbx->dbcw[priv->ch_idx]=
msk_set);
> +}
> +
> +static void mhuv3_doorbell_rx_complete(struct mhuv3 *mhu, struct mbox_ch=
an *chan)
> +{
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       /* Clearing the pending transfer generates the Channel Transfer A=
ck */
> +       writel_relaxed(BIT(priv->doorbell), &mhu->mbx->dbcw[priv->ch_idx]=
clr);
> +}
> +
> +static int mhuv3_doorbell_last_tx_done(struct mhuv3 *mhu,
> +                                      struct mbox_chan *chan)
> +{
> +       int done;
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       done =3D !(readl_relaxed(&mhu->pbx->dbcw[priv->ch_idx].st) &
> +                BIT(priv->doorbell));
> +       if (done) {
> +               unsigned long flags;
> +               struct mhuv3_extension *e =3D mhu->ext[DBE_EXT];
> +
> +               /* Take care to clear the pending doorbell also when poll=
ing */
> +               spin_lock_irqsave(&e->pending_lock, flags);
> +               e->pending_db[priv->ch_idx] &=3D ~BIT(priv->doorbell);
> +               spin_unlock_irqrestore(&e->pending_lock, flags);
> +       }
> +
> +       return done;
> +}
> +
> +static int mhuv3_doorbell_send_data(struct mhuv3 *mhu, struct mbox_chan =
*chan,
> +                                   void *arg)
> +{
> +       int ret =3D 0;
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +       struct mhuv3_extension *e =3D mhu->ext[DBE_EXT];
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&e->pending_lock, flags);
> +       /* Only one in-flight Transfer is allowed per-doorbell */
> +       if (!(e->pending_db[priv->ch_idx] & BIT(priv->doorbell))) {
> +               e->pending_db[priv->ch_idx] |=3D BIT(priv->doorbell);
> +               writel_relaxed(BIT(priv->doorbell),
> +                              &mhu->pbx->dbcw[priv->ch_idx].set);
> +       } else {
> +               ret =3D -EBUSY;
> +       }
> +       spin_unlock_irqrestore(&e->pending_lock, flags);
> +
> +       return ret;
> +}
> +
> +static const struct mhuv3_protocol_ops mhuv3_doorbell_ops =3D {
> +       .tx_startup =3D mhuv3_doorbell_tx_startup,
> +       .tx_shutdown =3D mhuv3_doorbell_tx_shutdown,
> +       .rx_startup =3D mhuv3_doorbell_rx_startup,
> +       .rx_shutdown =3D mhuv3_doorbell_rx_shutdown,
> +       .rx_complete =3D mhuv3_doorbell_rx_complete,
> +       .last_tx_done =3D mhuv3_doorbell_last_tx_done,
> +       .send_data =3D mhuv3_doorbell_send_data,
> +};
> +
> +/* Sender and receiver mailbox ops */
> +static bool mhuv3_sender_last_tx_done(struct mbox_chan *chan)
> +{
> +       struct mhuv3 *mhu =3D mhu_from_mbox(chan->mbox);
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       return priv->ops->last_tx_done(mhu, chan);
> +}
> +
> +static int mhuv3_sender_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct mhuv3 *mhu =3D mhu_from_mbox(chan->mbox);
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       if (!priv->ops->last_tx_done(mhu, chan))
> +               return -EBUSY;
> +
> +       return priv->ops->send_data(mhu, chan, data);
> +}
> +
> +static int mhuv3_sender_startup(struct mbox_chan *chan)
> +{
> +       struct mhuv3 *mhu =3D mhu_from_mbox(chan->mbox);
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       if (priv->ops->tx_startup)
> +               priv->ops->tx_startup(mhu, chan);
> +
> +       return 0;
> +}
> +
> +static void mhuv3_sender_shutdown(struct mbox_chan *chan)
> +{
> +       struct mhuv3 *mhu =3D mhu_from_mbox(chan->mbox);
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       if (priv->ops->tx_shutdown)
> +               priv->ops->tx_shutdown(mhu, chan);
> +}
> +
> +static const struct mbox_chan_ops mhuv3_sender_ops =3D {
> +       .send_data =3D mhuv3_sender_send_data,
> +       .startup =3D mhuv3_sender_startup,
> +       .shutdown =3D mhuv3_sender_shutdown,
> +       .last_tx_done =3D mhuv3_sender_last_tx_done,
> +};
> +
> +static int mhuv3_receiver_startup(struct mbox_chan *chan)
> +{
> +       struct mhuv3 *mhu =3D mhu_from_mbox(chan->mbox);
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       return priv->ops->rx_startup(mhu, chan);
> +}
> +
> +static void mhuv3_receiver_shutdown(struct mbox_chan *chan)
> +{
> +       struct mhuv3 *mhu =3D mhu_from_mbox(chan->mbox);
> +       struct mhuv3_mbox_chan_priv *priv =3D chan->con_priv;
> +
> +       priv->ops->rx_shutdown(mhu, chan);
> +}
> +
> +static int mhuv3_receiver_send_data(struct mbox_chan *chan, void *data)
> +{
> +       dev_err(chan->mbox->dev,
> +               "Trying to transmit on a MBX MHUv3 frame\n");
> +       return -EIO;
> +}
> +
> +static bool mhuv3_receiver_last_tx_done(struct mbox_chan *chan)
> +{
> +       dev_err(chan->mbox->dev, "Trying to Tx poll on a MBX MHUv3 frame\=
n");
> +       return true;
> +}
> +
> +static const struct mbox_chan_ops mhuv3_receiver_ops =3D {
> +       .send_data =3D mhuv3_receiver_send_data,
> +       .startup =3D mhuv3_receiver_startup,
> +       .shutdown =3D mhuv3_receiver_shutdown,
> +       .last_tx_done =3D mhuv3_receiver_last_tx_done,
> +};
> +
> +static struct mbox_chan *mhuv3_dbe_mbox_of_xlate(struct mhuv3 *mhu,
> +                                                unsigned int channel,
> +                                                unsigned int doorbell)
> +{
> +       struct mbox_controller *mbox =3D &mhu->mbox;
> +       struct mbox_chan *chans =3D mbox->chans;
> +       struct mhuv3_extension *e =3D mhu->ext[DBE_EXT];
> +
> +       if (channel >=3D e->max_chans || doorbell >=3D MHUV3_STAT_BITS) {
> +               dev_err(mbox->dev, "Couldn't xlate to a valid channel (%d=
: %d)\n",
> +                       channel, doorbell);
> +               return ERR_PTR(-ENODEV);
> +       }
> +
> +       return &chans[e->base_ch_idx + channel * MHUV3_STAT_BITS + doorbe=
ll];
> +}
> +
> +static void mhuv3_dbe_combined_irq_setup(struct mhuv3 *mhu)
> +{
> +       int i;
> +       struct mhuv3_extension *e =3D mhu->ext[DBE_EXT];
> +
> +       if (mhu->frame =3D=3D PBX_FRAME) {
> +               struct pdbcw_page __iomem *dbcw =3D mhu->pbx->dbcw;
> +
> +               for (i =3D 0; i < e->max_chans; i++) {
> +                       writel_relaxed_bitfield(0x1, &dbcw[i].int_clr, tf=
r_ack);
> +                       writel_relaxed_bitfield(0x0, &dbcw[i].int_en, tfr=
_ack);
> +                       writel_relaxed_bitfield(0x1, &dbcw[i].ctrl, comb_=
en);
> +               }
> +       } else {
> +               struct mdbcw_page __iomem *dbcw =3D mhu->mbx->dbcw;
> +
> +               for (i =3D 0; i < e->max_chans; i++) {
> +                       writel_relaxed(0xFFFFFFFF, &dbcw[i].clr);
> +                       writel_relaxed(0xFFFFFFFF, &dbcw[i].msk_set);
> +                       writel_relaxed_bitfield(0x1, &dbcw[i].ctrl, comb_=
en);
> +               }
> +       }
> +}
> +
> +static int mhuv3_dbe_channels_init(struct mhuv3 *mhu)
> +{
> +       int i;
> +       struct mhuv3_extension *e =3D mhu->ext[DBE_EXT];
> +       struct mbox_controller *mbox =3D &mhu->mbox;
> +       struct mbox_chan *chans;
> +
> +       chans =3D mbox->chans + mbox->num_chans;
> +       e->base_ch_idx =3D mbox->num_chans;
> +       for (i =3D 0; i < e->max_chans; i++) {
> +               int k;
> +               struct mhuv3_mbox_chan_priv *priv;
> +
> +               for (k =3D 0; k < MHUV3_STAT_BITS; k++) {
> +                       priv =3D devm_kmalloc(mbox->dev, sizeof(*priv), G=
FP_KERNEL);
> +                       if (!priv)
> +                               return -ENOMEM;
> +
> +                       priv->ch_idx =3D i;
> +                       priv->ops =3D &mhuv3_doorbell_ops;
> +                       priv->doorbell =3D k;
> +                       chans++->con_priv =3D priv;
> +                       mbox->num_chans++;
> +               }
> +       }
> +
> +       spin_lock_init(&e->pending_lock);
> +
> +       return 0;
> +}
> +
> +static struct mbox_chan *mhuv3_dbe_chan_from_comb_irq_get(struct mhuv3 *=
mhu)
> +{
> +       int i;
> +       struct mhuv3_extension *e =3D mhu->ext[DBE_EXT];
> +       struct device *dev =3D mhu->mbox.dev;
> +
> +       for (i =3D 0; i < MHUV3_DBCH_CMB_INT_ST_REG_CNT; i++) {
> +               unsigned int channel, db =3D MHUV3_INVALID_DOORBELL;
> +               u32 cmb_st, st;
> +
> +               cmb_st =3D readl_relaxed(&mhu->ctrl->dbch_int_st[i]);
> +               if (!cmb_st)
> +                       continue;
> +
> +               channel =3D i * MHUV3_STAT_BITS + __builtin_ctz(cmb_st);

__ffs instead of __builtin_ctz please.

> +               if (channel >=3D e->max_chans) {
> +                       dev_err(dev, "Invalid %s channel:%d\n",
> +                               mhuv3_str[mhu->frame], channel);
> +                       break;
> +               }
> +
> +               if (mhu->frame =3D=3D PBX_FRAME) {
> +                       unsigned long flags;
> +                       u32 active_dbs, fired_dbs;
> +
> +                       st =3D readl_relaxed_bitfield(&mhu->pbx->dbcw[cha=
nnel].int_st,
> +                                                   tfr_ack);
> +                       if (!st) {
> +                               dev_warn(dev, "Spurios IRQ on %s channel:=
%d\n",
> +                                        mhuv3_str[mhu->frame], channel);
> +                               continue;
> +                       }
> +
> +                       active_dbs =3D readl_relaxed(&mhu->pbx->dbcw[chan=
nel].st);
> +                       spin_lock_irqsave(&e->pending_lock, flags);
> +                       fired_dbs =3D e->pending_db[channel] & ~active_db=
s;
> +                       if (fired_dbs) {
> +                               db =3D __builtin_ctz(fired_dbs);
> +                               e->pending_db[channel] &=3D ~BIT(db);
> +                               fired_dbs &=3D ~BIT(db);
> +                       }
> +                       spin_unlock_irqrestore(&e->pending_lock, flags);
> +
> +                       /* Clear TFR Ack if no more doorbells pending */
> +                       if (!fired_dbs)
> +                               writel_relaxed_bitfield(0x1,
> +                                                       &mhu->pbx->dbcw[c=
hannel].int_clr,
> +                                                       tfr_ack);
> +               } else {
> +                       st =3D readl_relaxed(&mhu->mbx->dbcw[channel].st_=
msk);
> +                       if (!st) {
> +                               dev_warn(dev, "Spurios IRQ on %s channel:=
%d\n",
> +                                        mhuv3_str[mhu->frame], channel);
> +                               continue;
> +                       }
> +                       db =3D __builtin_ctz(st);
> +               }
> +
> +               if (db !=3D MHUV3_INVALID_DOORBELL) {
> +                       dev_dbg(dev, "Found %s ch[%d]/db[%d]\n",
> +                               mhuv3_str[mhu->frame], channel, db);
> +
> +                       return &mhu->mbox.chans[channel * MHUV3_STAT_BITS=
 + db];
> +               }
> +       }
> +
> +       return ERR_PTR(-EIO);
> +}
> +
> +static int mhuv3_dbe_init(struct mhuv3 *mhu)
> +{
> +       struct mhuv3_extension *e;
> +       struct device *dev =3D mhu->mbox.dev;
> +
> +       if (!readl_relaxed_bitfield(&mhu->ctrl->feat_spt0, dbe_spt))
> +               return 0;
> +
> +       dev_dbg(dev, "%s: Initializing DBE Extension.\n", mhuv3_str[mhu->=
frame]);
> +
> +       e =3D devm_kzalloc(dev, sizeof(*e), GFP_KERNEL);
> +       if (!e)
> +               return -ENOMEM;
> +
> +       e->type =3D DBE_EXT;
> +       /* Note that, by the spec, the number of channels is (num_dbch + =
1) */
> +       e->max_chans =3D
> +               readl_relaxed_bitfield(&mhu->ctrl->dbch_cfg0, num_dbch) +=
 1;
> +       e->mbox_of_xlate =3D mhuv3_dbe_mbox_of_xlate;
> +       e->combined_irq_setup =3D mhuv3_dbe_combined_irq_setup;
> +       e->channels_init =3D mhuv3_dbe_channels_init;
> +       e->chan_from_comb_irq_get =3D mhuv3_dbe_chan_from_comb_irq_get;
> +
> +       mhu->tot_chans +=3D e->max_chans * MHUV3_STAT_BITS;
> +       mhu->ext[DBE_EXT] =3D e;
> +
> +       dev_info(dev, "%s: found %d DBE channels.\n",
> +                mhuv3_str[mhu->frame], e->max_chans);
> +
> +       return 0;
> +}
> +
> +static int mhuv3_fce_init(struct mhuv3 *mhu)
> +{
> +       struct device *dev =3D mhu->mbox.dev;
> +
> +       if (!readl_relaxed_bitfield(&mhu->ctrl->feat_spt0, fce_spt))
> +               return 0;
> +
> +       dev_dbg(dev, "%s: FCE Extension not supported by driver.\n",
> +               mhuv3_str[mhu->frame]);
> +
> +       return 0;
> +}
> +
> +static int mhuv3_fe_init(struct mhuv3 *mhu)
> +{
> +       struct device *dev =3D mhu->mbox.dev;
> +
> +       if (!readl_relaxed_bitfield(&mhu->ctrl->feat_spt0, fe_spt))
> +               return 0;
> +
> +       dev_dbg(dev, "%s: FE Extension not supported by driver.\n",
> +               mhuv3_str[mhu->frame]);
> +
> +       return 0;
> +}
> +
> +static mhuv3_extension_initializer mhuv3_extension_init[MAX_EXT] =3D {
> +       mhuv3_dbe_init,
> +       mhuv3_fce_init,
> +       mhuv3_fe_init,
> +};
> +
> +static int mhuv3_initialize_channels(struct device *dev, struct mhuv3 *m=
hu)
> +{
> +       int i, ret =3D 0;
> +       struct mbox_controller *mbox =3D &mhu->mbox;
> +
> +       mbox->chans =3D devm_kcalloc(dev, mhu->tot_chans,
> +                                  sizeof(*mbox->chans), GFP_KERNEL);
> +       if (!mbox->chans)
> +               return -ENOMEM;
> +
> +       for (i =3D FIRST_EXT; i < MAX_EXT && !ret; i++)
> +               if (mhu->ext[i])
> +                       ret =3D mhu->ext[i]->channels_init(mhu);
> +
> +       return ret;
> +}
> +
> +static struct mbox_chan *mhuv3_mbox_of_xlate(struct mbox_controller *mbo=
x,
> +                                            const struct of_phandle_args=
 *pa)
> +{
> +       unsigned int type, channel, param;
> +       struct mhuv3 *mhu =3D mhu_from_mbox(mbox);
> +
> +       if (pa->args_count !=3D MHUV3_MBOX_CELLS)
> +               return ERR_PTR(-EINVAL);
> +
> +       type =3D pa->args[MHUV3_MBOX_CELL_TYPE];
> +       if (type >=3D MAX_EXT)
> +               return ERR_PTR(-EINVAL);
> +
> +       channel =3D pa->args[MHUV3_MBOX_CELL_CHWN];
> +       param =3D pa->args[MHUV3_MBOX_CELL_PARAM];
> +
> +       return mhu->ext[type]->mbox_of_xlate(mhu, channel, param);
> +}
> +
> +static int mhuv3_frame_init(struct mhuv3 *mhu, void __iomem *regs)
> +{
> +       int i, ret =3D 0;
> +       struct device *dev =3D mhu->mbox.dev;
> +
> +       mhu->ctrl =3D regs;
> +       mhu->frame =3D readl_relaxed_bitfield(&mhu->ctrl->blk_id, blk_id)=
;
> +       if (mhu->frame > MBX_FRAME) {
> +               dev_err(dev, "Invalid Frame type- %d\n", mhu->frame);
> +               return -EINVAL;
> +       }
> +
> +       mhu->major =3D readl_relaxed_bitfield(&mhu->ctrl->aidr, arch_majo=
r_rev);
> +       mhu->minor =3D readl_relaxed_bitfield(&mhu->ctrl->aidr, arch_mino=
r_rev);
> +       if (mhu->major !=3D MHUV3_MAJOR_VERSION) {
> +               dev_warn(dev, "Unsupported MHU %s block - major:%d  minor=
:%d\n",
> +                        mhuv3_str[mhu->frame], mhu->major, mhu->minor);
> +               return -EINVAL;
> +       }
> +       mhu->auto_op_full =3D !!readl_relaxed_bitfield(&mhu->ctrl->feat_s=
pt1,
> +                                                    auto_op_spt);
> +       /* Request the PBX/MBX to remain operational */
> +       if (mhu->auto_op_full)
> +               writel_relaxed_bitfield(0x1, &mhu->ctrl->ctrl, op_req);
> +
> +       dev_dbg(dev, "Found MHU %s block - major:%d  minor:%d\n",
> +               mhuv3_str[mhu->frame], mhu->major, mhu->minor);
> +
> +       if (mhu->frame =3D=3D PBX_FRAME)
> +               mhu->pbx =3D regs;
> +       else
> +               mhu->mbx =3D regs;
> +
> +       for (i =3D FIRST_EXT; i < MAX_EXT && !ret; i++)
> +               ret =3D mhuv3_extension_init[i](mhu);
> +
> +       return ret;
> +}
> +
> +static irqreturn_t mhuv3_pbx_comb_interrupt(int irq, void *arg)
> +{
> +       int ret =3D IRQ_NONE;
> +       unsigned int i, found =3D 0;
> +       struct mhuv3 *mhu =3D arg;
> +       struct device *dev =3D mhu->mbox.dev;
> +       struct mbox_chan *chan;
> +
> +       for (i =3D FIRST_EXT; i < MAX_EXT; i++) {
> +               /* FCE does not participate to the PBX combined */
> +               if (i =3D=3D FCE_EXT || !mhu->ext[i])
> +                       continue;
> +
> +               chan =3D mhu->ext[i]->chan_from_comb_irq_get(mhu);
> +               if (!IS_ERR(chan)) {
>
  'continue' for error instead, to have fewer indented lines.

> +                       struct mhuv3_mbox_chan_priv *priv =3D chan->con_p=
riv;
> +
> +                       found++;
> +                       if (chan->cl) {
> +                               mbox_chan_txdone(chan, 0);
> +                               ret =3D IRQ_HANDLED;
> +                       } else {
> +                               dev_warn(dev,
> +                                        "TX Ack on UNBOUND channel (%u)\=
n",
> +                                        priv->ch_idx);
> +                       }
> +               }
> +       }
> +
> +       if (!found)
> +               dev_warn_once(dev, "Failed to find channel for the TX int=
errupt\n");
> +
> +       return ret;
> +}
> +
> +static irqreturn_t mhuv3_mbx_comb_interrupt(int irq, void *arg)
> +{
> +       int ret =3D IRQ_NONE;
> +       unsigned int i, found =3D 0;
> +       struct mhuv3 *mhu =3D arg;
> +       struct device *dev =3D mhu->mbox.dev;
> +       struct mbox_chan *chan;
> +
> +       for (i =3D FIRST_EXT; i < MAX_EXT; i++) {
> +               if (!mhu->ext[i])
> +                       continue;
> +
> +               /* Process any extension which could be source of the IRQ=
 */
> +               chan =3D mhu->ext[i]->chan_from_comb_irq_get(mhu);
> +               if (!IS_ERR(chan)) {
  'continue' for error instead, to have fewer indented lines.


> +                       void *data =3D NULL;
> +                       struct mhuv3_mbox_chan_priv *priv =3D chan->con_p=
riv;
> +
> +                       found++;
> +                       /* Read and acknowledge optional in-band LE data =
first. */
> +                       if (priv->ops->read_data)
> +                               data =3D priv->ops->read_data(mhu, chan);
> +
> +                       if (chan->cl && !IS_ERR(data)) {
> +                               mbox_chan_received_data(chan, data);
> +                               ret =3D IRQ_HANDLED;
> +                       } else if (!chan->cl) {
> +                               dev_warn(dev,
> +                                        "RX Data on UNBOUND channel (%u)=
\n",
> +                                        priv->ch_idx);
> +                       } else {
> +                               dev_err(dev, "Failed to read data: %lu\n"=
,
> +                                       PTR_ERR(data));
> +                       }
> +
> +                       if (!IS_ERR(data))
> +                               kfree(data);
> +
> +                       /*
> +                        * Acknowledge transfer after any possible option=
al
> +                        * out-of-band data has also been retrieved via
> +                        * mbox_chan_received_data().
> +                        */
> +                       if (priv->ops->rx_complete)
> +                               priv->ops->rx_complete(mhu, chan);
> +               }
> +       }
> +
> +       if (!found)
> +               dev_warn_once(dev, "Failed to find channel for the RX int=
errupt\n");
> +
> +       return ret;
> +}
> +
> +static int mhuv3_setup_pbx(struct mhuv3 *mhu)
> +{
> +       struct device *dev =3D mhu->mbox.dev;
> +
> +       mhu->mbox.ops =3D &mhuv3_sender_ops;
> +
> +       if (mhu->cmb_irq > 0) {
> +               int ret;
> +
> +               ret =3D devm_request_threaded_irq(dev, mhu->cmb_irq, NULL=
,
> +                                               mhuv3_pbx_comb_interrupt,
> +                                               IRQF_ONESHOT, "mhuv3-pbx"=
, mhu);
> +               if (!ret) {
> +                       int i;
> +
> +                       mhu->mbox.txdone_irq =3D true;
> +                       mhu->mbox.txdone_poll =3D false;
> +
> +                       for (i =3D FIRST_EXT; i < MAX_EXT; i++)
> +                               if (mhu->ext[i])
> +                                       mhu->ext[i]->combined_irq_setup(m=
hu);
> +
> +                       dev_dbg(dev, "MHUv3 PBX IRQs initialized.\n");
> +
> +                       return 0;
> +               }
> +
> +               dev_err(dev, "Failed to request PBX IRQ - ret:%d", ret);
> +       }
> +
> +       dev_info(dev, "Using PBX in Tx polling mode.\n");
> +       mhu->mbox.txdone_irq =3D false;
> +       mhu->mbox.txdone_poll =3D true;
> +       mhu->mbox.txpoll_period =3D 1;
> +
> +       return 0;
> +}
> +
> +static int mhuv3_setup_mbx(struct mhuv3 *mhu)
> +{
> +       int ret, i;
> +       struct device *dev =3D mhu->mbox.dev;
> +
> +       mhu->mbox.ops =3D &mhuv3_receiver_ops;
> +
> +       if (mhu->cmb_irq <=3D 0) {
> +               dev_err(dev, "Missing MBX combined IRQ !\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D devm_request_threaded_irq(dev, mhu->cmb_irq, NULL,
> +                                       mhuv3_mbx_comb_interrupt, IRQF_ON=
ESHOT,
> +                                       "mhuv3-mbx", mhu);
> +       if (ret) {
> +               dev_err(dev, "Failed to request MBX IRQ - ret:%d\n", ret)=
;
> +               return ret;
> +       }
> +
> +       for (i =3D FIRST_EXT; i < MAX_EXT; i++)
> +               if (mhu->ext[i])
> +                       mhu->ext[i]->combined_irq_setup(mhu);
> +
> +       dev_dbg(dev, "MHUv3 MBX IRQs initialized.\n");
> +
> +       return ret;
> +}
> +
> +static int mhuv3_irqs_init(struct mhuv3 *mhu, struct platform_device *pd=
ev)
> +{
> +       int ret;
> +
> +       dev_dbg(mhu->mbox.dev, "Initializing %s block.\n", mhuv3_str[mhu-=
>frame]);
> +
> +       if (mhu->frame =3D=3D PBX_FRAME) {
> +               mhu->cmb_irq =3D platform_get_irq_byname_optional(pdev, "=
combined");
> +               ret =3D mhuv3_setup_pbx(mhu);
> +       } else {
> +               mhu->cmb_irq =3D platform_get_irq_byname(pdev, "combined"=
);
> +               ret =3D mhuv3_setup_mbx(mhu);
> +       }
> +
> +       return ret;
> +}
> +
> +static int mhuv3_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct mhuv3 *mhu;
> +       void __iomem *regs;
> +       struct device *dev =3D &pdev->dev;
> +
> +       mhu =3D devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
> +       if (!mhu)
> +               return -ENOMEM;
> +
> +       regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);
> +
> +       mhu->mbox.dev =3D dev;
> +       ret =3D mhuv3_frame_init(mhu, regs);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D mhuv3_irqs_init(mhu, pdev);
> +       if (ret)
> +               return ret;
> +
> +       mhu->mbox.of_xlate =3D mhuv3_mbox_of_xlate;
> +       ret =3D mhuv3_initialize_channels(dev, mhu);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_mbox_controller_register(dev, &mhu->mbox);
> +       if (ret)
> +               dev_err(dev, "failed to register ARM MHUv3 driver %d\n", =
ret);
> +
> +       platform_set_drvdata(pdev, mhu);
> +
> +       return ret;
> +}
> +
> +static int mhuv3_remove(struct platform_device *pdev)
> +{
> +       struct mhuv3 *mhu =3D platform_get_drvdata(pdev);
> +
> +       if (mhu->auto_op_full)
> +               writel_relaxed_bitfield(0x0, &mhu->ctrl->ctrl, op_req);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mhuv3_of_match[] =3D {
> +       { .compatible =3D "arm,mhuv3", .data =3D NULL },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, mhuv3_of_match);
> +
> +static struct platform_driver mhuv3_driver =3D {
> +       .driver =3D {
> +               .name =3D "arm-mhuv3-mailbox",
> +               .of_match_table =3D mhuv3_of_match,
> +       },
> +       .probe =3D mhuv3_probe,
> +       .remove =3D mhuv3_remove,
> +};
> +module_platform_driver(mhuv3_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ARM MHUv3 Driver");
> +MODULE_AUTHOR("Cristian Marussi <cristian.marussi@arm.com>");
> --
> 2.34.1
>

