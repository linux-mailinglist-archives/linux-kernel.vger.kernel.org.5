Return-Path: <linux-kernel+bounces-20979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19EB82880D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38944286CA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7439AFC;
	Tue,  9 Jan 2024 14:27:54 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3339AEE;
	Tue,  9 Jan 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bc21303a35so344595b6e.0;
        Tue, 09 Jan 2024 06:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704810471; x=1705415271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=speyU9W4fgWPfDREd0VxrelBC2TKMQY2s8f/k65X9Vw=;
        b=bw9jgu+zGNUQlHaiKashSgUWtwWHannAqm0zuLNGcZ/xe0aF5TN8JL31gceXLqinIS
         VS/2jQdQ1MM5sHEZsafXgYRSUCUeWY2Y/se9rCbNlhj1VOsyH8GLlSaiUUJa5t46IBDt
         2WfPRqwgqC2p2aWO4HPj9G/db4ks+hYe3WWLGGc/OGJGfmfWbhNb7u1GpuWZW/VyW8Xv
         5j406FOqbwtuXtD3zzujhc1j5nN7yOXSbs25yzmoMmh8mKv3oFFSES/sYxtxn1HJuD40
         zAiajycqfdUoRrMbg6fgPLxeFOwVMfEm+p0+rlfSO44hrwSFlW2imAhjSwKM1DxWZcRA
         qUNg==
X-Gm-Message-State: AOJu0YzX1DRYsxTGQiUup+8WcNdVhXWoYK2x7+zcX5qH2/crH6UE6fwp
	A4sNGYrVktzHI2WNmehn0Ase8EIESE+0YMrtYVw=
X-Google-Smtp-Source: AGHT+IHY1jFISnsaNGMvSmCaJqgqyDbrcVYMQaLmXNN65Tot1RoyyJ/7Y1Qsx35HBWPmk/RBi3ZHclzvWQyOB3wOZ1s=
X-Received: by 2002:a05:6808:30a2:b0:3bd:3bf4:8a0f with SMTP id
 bl34-20020a05680830a200b003bd3bf48a0fmr2316881oib.4.1704810471272; Tue, 09
 Jan 2024 06:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230905104721.52199-1-lpieralisi@kernel.org> <20231227110038.55453-1-lpieralisi@kernel.org>
 <20231227110038.55453-2-lpieralisi@kernel.org>
In-Reply-To: <20231227110038.55453-2-lpieralisi@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 15:27:40 +0100
Message-ID: <CAJZ5v0ik38AkaK6UVkSg9gOOztVzhFotCWBPhvowvRvozoAUVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ACPICA: MADT: Add GICC online capable bit handling
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Fang Xiang <fangxiang3@xiaomi.com>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 12:00=E2=80=AFPM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> ACPICA commit 16f0befdeddf25756f317907798192bbaa417e5e
>
> Implement code to handle the GICC online capable bit management
> added into ACPI v6.5.
>
> Link: https://github.com/acpica/acpica/commit/16f0befd
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> ---
>  include/acpi/actbl2.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 3751ae69432f..2b4dd2c3348f 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
>  /* ACPI_MADT_ENABLED                    (1)      Processor is usable if =
set */
>  #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1) /* 01: Performance Interr=
upt Mode */
>  #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2) /* 02: VGIC Maintenance I=
nterrupt mode */
> +#define ACPI_MADT_GICC_ONLINE_CAPABLE   (1<<3) /* 03: Processor is onlin=
e capable  */
>
>  /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
>
> --

Applied as 6.8-rc1 material along with the [2/3].

Thanks!

