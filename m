Return-Path: <linux-kernel+bounces-16705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056DE8242B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2082865A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F32233C;
	Thu,  4 Jan 2024 13:35:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527ED22334;
	Thu,  4 Jan 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59629f0f67aso57258eaf.0;
        Thu, 04 Jan 2024 05:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704375304; x=1704980104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPOBlrT+Hvev/tHtkK2FVsdHMq9cCjaun2aMkEdXZ60=;
        b=nTMo/CnH87RjoxqkUQ47+y/mkHTFztFE2Z1L8IY/I/IFVXYXU/ggIAUHOjBZEKAwVy
         +Xk/74MZ5yCttF0E1ELf5CEjR0dRaJRkkSeKMmc8WvZXd8D++zqKX4NUpZ9V1ZxfygYH
         pg9Uiq6U5R7cmZzip27NQXPATPWDbKwS+Hh+LzCfKEJRYFHU45Rfjr6TZ2HM6o6UbxMX
         FLLMXGTLkN3/T0zD66/F2/qkIeAK6b/giTO3sVELvbpJGFFIL6QwC8uu1GHTCFRhWBOV
         xNrLTT27LVnlyVAauNhtTJdSJUCt5yHp0XaTJwJ7VnauqUcRp7Q81vpH/OLjESXRQFZG
         nmlg==
X-Gm-Message-State: AOJu0Ywq+F8pkqft1yIYZ1STN66conoT7phBmJuvORPUnaH0lfjtmAdJ
	+LxhDhCcH9QeVbt1Xa0kDvHY8NhkeisBGoJgEuk=
X-Google-Smtp-Source: AGHT+IEHtp6El0WtLZP5MfVkZjqjk0cwJsvNNJarHg6gXgFiWXAV/7/t71UShEM7xPHCyiqNrzySM9UiDb9PbyMmH6Y=
X-Received: by 2002:a4a:da09:0:b0:596:2965:be22 with SMTP id
 e9-20020a4ada09000000b005962965be22mr752377oou.1.1704375304371; Thu, 04 Jan
 2024 05:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024819.848979-1-kai.heng.feng@canonical.com>
In-Reply-To: <20240104024819.848979-1-kai.heng.feng@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 14:34:52 +0100
Message-ID: <CAJZ5v0gNa7XvUo3B1srXaWBrWx+Bx=w=D7ddi-mqda8xBdWwCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: IPMI: Add helper to wait for when SMI is selected
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:48=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> The function of acpi_power_meter module on Dell system requires IPMI
> handler is installed and SMI is selected.

Does the firmware use _DEP to let the OS know about this dependency?

> So add a helper to let acpi_power_meter know when IPMI handler and SMI
> are ready.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>  - New patch.
>
>  drivers/acpi/acpi_ipmi.c | 17 ++++++++++++++++-
>  include/acpi/acpi_bus.h  |  5 +++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 0555f68c2dfd..54862cab7171 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
>  #define IPMI_TIMEOUT                   (5000)
>  #define ACPI_IPMI_MAX_MSG_LENGTH       64
>
> +static struct completion smi_selected;
> +
>  struct acpi_ipmi_device {
>         /* the device list attached to driver_data.ipmi_devices */
>         struct list_head head;
> @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct devi=
ce *dev)
>                 if (temp->handle =3D=3D handle)
>                         goto err_lock;
>         }
> -       if (!driver_data.selected_smi)
> +       if (!driver_data.selected_smi) {
>                 driver_data.selected_smi =3D ipmi_device;
> +               complete(&smi_selected);
> +       }
>         list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
>         mutex_unlock(&driver_data.ipmi_lock);
>
> @@ -578,10 +582,21 @@ acpi_ipmi_space_handler(u32 function, acpi_physical=
_address address,
>         return status;
>  }
>
> +int acpi_wait_for_acpi_ipmi(void)
> +{
> +       long ret;
> +
> +       ret =3D wait_for_completion_interruptible_timeout(&smi_selected, =
2 * HZ);
> +
> +       return ret > 0 ? 0 : -ETIMEDOUT;

What will happen if the IPMI driver is unloaded after this has returned 0?

> +}
> +EXPORT_SYMBOL_GPL(acpi_wait_for_acpi_ipmi);
> +
>  static int __init acpi_ipmi_init(void)
>  {
>         int result;
>         acpi_status status;
> +       init_completion(&smi_selected);
>
>         if (acpi_disabled)
>                 return 0;
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

