Return-Path: <linux-kernel+bounces-21360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E925D828E29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97122288A50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528983D3BB;
	Tue,  9 Jan 2024 19:51:10 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461C3C492;
	Tue,  9 Jan 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-594363b4783so123012eaf.1;
        Tue, 09 Jan 2024 11:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704829867; x=1705434667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9CfEyJdpI18457+5ji9bfNvEco0haGPdav5Z06RXJE=;
        b=WXcf4/j9R3no3LDLWu/ZfddcirramQcZbcOaUkSs8yisbOmlbw51iDZzT0iqDKhusa
         lCEQ/7WEM+6W1ok4qsT9Q83G96YQXWdq4ToYMRKlXsyzu3S9DmVLFOVY/YxCzH1vrjl6
         +kyNMOuqCtSQGkeDf9hIhsmsvdIgObMrBR+SyAolannA7ZuMpctKMGngtu0iNUCCWlmo
         mw1GyRK7FxvU05l2JRttTRfKtV6gbE37azErBGnn9fqniTgrgcRxPpkRo9Uwp8p0c/ru
         4BGdL0NW+Ig9s8R/LB5ZDfwSKQOAyCcmrtgSTMOuFBxaARaJSrJg3sXlhZXR+Xm3zvLV
         cgOw==
X-Gm-Message-State: AOJu0YxGa+NhN7i5nH+QQ2jQvaQNo+a9EAuUJmjS1ve0/CKoVQGlOmBt
	15ukhF4Zy1OSmfsNuZjD3lxY726rtfQXfEwIwF8=
X-Google-Smtp-Source: AGHT+IFQ5yvazC9v/FzYTn7OSLPSMqLku7H0Q6uYYWxIshHalCVuu3eysh1wH8tbatZynnzMVwZKOM7G9D3p2uiMfxI=
X-Received: by 2002:a4a:c912:0:b0:598:81b7:4d25 with SMTP id
 v18-20020a4ac912000000b0059881b74d25mr2591740ooq.1.1704829867536; Tue, 09 Jan
 2024 11:51:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109041218.980674-1-kai.heng.feng@canonical.com>
In-Reply-To: <20240109041218.980674-1-kai.heng.feng@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 20:50:56 +0100
Message-ID: <CAJZ5v0g4_5k-+_-ZPkm5LNOLsveJJqt2t60q_4a3wm+kAFCv_g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI: IPMI: Add helper to wait for when SMI is selected
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 5:12=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Dell servers, many APCI methods of acpi_power_meter module evaluate
> variables inside IPMI region, so the region handler needs to be
> installed. In addition to that, the handler needs to be fully
> functional, and that depends on SMI being selected.
>
> So add a helper to let acpi_power_meter know when the handler is
> installed and ready to be used.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm expecting this to be routed along with patch [2/2] that has
been posted elsewhere.

> ---
> v4:
>  - Wording.
>  - Define and comment on timeout value.
>  - Move the completion to driver_data.
>  - Remove the tenary operator.
>
> v3:
>  - New patch.
>
>  drivers/acpi/acpi_ipmi.c | 23 ++++++++++++++++++++++-
>  include/acpi/acpi_bus.h  |  5 +++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 0555f68c2dfd..5fba4dab5d08 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -22,6 +22,8 @@ MODULE_LICENSE("GPL");
>  /* the IPMI timeout is 5s */
>  #define IPMI_TIMEOUT                   (5000)
>  #define ACPI_IPMI_MAX_MSG_LENGTH       64
> +/* 2s should be suffient for SMI being selected */
> +#define ACPI_IPMI_SMI_SELECTION_TIMEOUT        (2 * HZ)
>
>  struct acpi_ipmi_device {
>         /* the device list attached to driver_data.ipmi_devices */
> @@ -54,6 +56,7 @@ struct ipmi_driver_data {
>          * to this selected global IPMI system interface.
>          */
>         struct acpi_ipmi_device *selected_smi;
> +       struct completion smi_selection_done;
>  };
>
>  struct acpi_ipmi_msg {
> @@ -463,8 +466,10 @@ static void ipmi_register_bmc(int iface, struct devi=
ce *dev)
>                 if (temp->handle =3D=3D handle)
>                         goto err_lock;
>         }
> -       if (!driver_data.selected_smi)
> +       if (!driver_data.selected_smi) {
>                 driver_data.selected_smi =3D ipmi_device;
> +               complete(&driver_data.smi_selection_done);
> +       }
>         list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
>         mutex_unlock(&driver_data.ipmi_lock);
>
> @@ -578,6 +583,20 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_=
address address,
>         return status;
>  }
>
> +int acpi_wait_for_acpi_ipmi(void)
> +{
> +       long ret;
> +
> +       ret =3D wait_for_completion_interruptible_timeout(&driver_data.sm=
i_selection_done,
> +                                                       ACPI_IPMI_SMI_SEL=
ECTION_TIMEOUT);
> +
> +       if (ret <=3D 0)
> +               return -ETIMEDOUT;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_wait_for_acpi_ipmi);
> +
>  static int __init acpi_ipmi_init(void)
>  {
>         int result;
> @@ -586,6 +605,8 @@ static int __init acpi_ipmi_init(void)
>         if (acpi_disabled)
>                 return 0;
>
> +       init_completion(&driver_data.smi_selection_done);
> +
>         status =3D acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
>                                                     ACPI_ADR_SPACE_IPMI,
>                                                     &acpi_ipmi_space_hand=
ler,
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1216d72c650f..afa6e4d4bf46 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -821,11 +821,16 @@ static inline void acpi_put_acpi_dev(struct acpi_de=
vice *adev)
>  {
>         acpi_dev_put(adev);
>  }
> +
> +int acpi_wait_for_acpi_ipmi(void);
> +
>  #else  /* CONFIG_ACPI */
>
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
>  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
>
> +static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> +
>  #endif                         /* CONFIG_ACPI */
>
>  #endif /*__ACPI_BUS_H__*/
> --

