Return-Path: <linux-kernel+bounces-15612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E27822ED1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822581C22ED8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C191A5AD;
	Wed,  3 Jan 2024 13:43:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9D1A5A9;
	Wed,  3 Jan 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-594cabe74f8so371544eaf.0;
        Wed, 03 Jan 2024 05:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289408; x=1704894208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyL0U7ReWWKWObMLjmNTrzqgyVE7GbO/GB0G3IW1n/Q=;
        b=JVlYE9RdZwnNlU6muVlj/fg8fzRU3rlNGf/SdjhULQL+uuSXlqVgtBawRd8AY3LJze
         49Ezc2uucoOJS3uzgMFjzqp0oilxl4JdnrEDP+Llp7EhEk6bODwBacn2lbTXpEVRLuUn
         QIyRfEV8sN7/8QoEMY1n0IFVugKRZKhEJPBWgeO9MUonZAspkwaMbdmS+tc8JcDkbjO3
         fT9YCoaeAP4sIEqCwonWT2q/NucLv2E3mWQF8XnZwJKcADpvNQGeQqb5AFTa80zHB4DN
         6HqiMQs6hS/2MLn8KQConcoRKFbTWVB6+8Gnz/DcOrwKJL/2AzkPcx95QMwYQCQv+LpV
         4WyQ==
X-Gm-Message-State: AOJu0YwON7gqXLaKYgJq98Vh/oAdOtYjtx055MBUQO80wl2ehHQRIY1R
	Zd99VSFTFFyxz8W77YuNKxgrrUDkj05uJkiRi2o=
X-Google-Smtp-Source: AGHT+IEC6R6yy8QXkJ17hVm3ZlKs1VGTCfBHtP3fTfVqTVdvlug5pCsjHyh8OxZs1lUlkEBTccNYVshItdhlTm9euqM=
X-Received: by 2002:a4a:dc96:0:b0:594:ad62:bab9 with SMTP id
 g22-20020a4adc96000000b00594ad62bab9mr20085697oou.1.1704289408312; Wed, 03
 Jan 2024 05:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230905104721.52199-1-lpieralisi@kernel.org> <20231227110038.55453-1-lpieralisi@kernel.org>
In-Reply-To: <20231227110038.55453-1-lpieralisi@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 14:43:16 +0100
Message-ID: <CAJZ5v0gUBU=VL8E34sjROssoGNbLnhmUQVHGWT60hgBG_ufTHw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] irqchip/gic-v3: Enable non-coherent GIC designs probing
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Fang Xiang <fangxiang3@xiaomi.com>, Marc Zyngier <maz@kernel.org>, 
	Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 12:00=E2=80=AFPM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> This series is v4 of previous series:
>
> v3: https://lore.kernel.org/all/20231006125929.48591-1-lpieralisi@kernel.=
org
> v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@kernel.=
org
> v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.=
org
>
> v3 -> v4:
>         - Dropped patches [1-3], already merged
>         - Added Linuxized ACPICA changes accepted upstream
>         - Rebased against v6.7-rc3
>
> v2 -> v3:
>         - Added ACPICA temporary changes and ACPI changes to implement
>           ECR https://bugzilla.tianocore.org/show_bug.cgi?id=3D4557
>         - ACPI changes are for testing purposes - subject to ECR code
>           first approval
>
> v1 -> v2:
>         - Updated DT bindings as per feedback
>         - Updated patch[2] to use GIC quirks infrastructure
>
> Original cover letter
> ---
> The GICv3 architecture specifications provide a means for the
> system programmer to set the shareability and cacheability
> attributes the GIC components (redistributors and ITSes) use
> to drive memory transactions.
>
> Albeit the architecture give control over shareability/cacheability
> memory transactions attributes (and barriers), it is allowed to
> connect the GIC interconnect ports to non-coherent memory ports
> on the interconnect, basically tying off shareability/cacheability
> "wires" and de-facto making the redistributors and ITSes non-coherent
> memory observers.
>
> This series aims at starting a discussion over a possible solution
> to this problem, by adding to the GIC device tree bindings the
> standard dma-noncoherent property. The GIC driver uses the property
> to force the redistributors and ITSes shareability attributes to
> non-shareable, which consequently forces the driver to use CMOs
> on GIC memory tables.
>
> On ARM DT DMA is default non-coherent, so the GIC driver can't rely
> on the generic DT dma-coherent/non-coherent property management layer
> (of_dma_is_coherent()) which would default all GIC designs in the field
> as non-coherent; it has to rely on ad-hoc dma-noncoherent property handli=
ng.
>
> When a consistent approach is agreed upon for DT an equivalent binding wi=
ll
> be put forward for ACPI based systems.
>
> Lorenzo Pieralisi (3):
>   ACPICA: MADT: Add GICC online capable bit handling
>   ACPICA: MADT: Add new MADT GICC/GICR/ITS non-coherent flags handling
>   irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing
>
>  drivers/acpi/processor_core.c    | 21 +++++++++++++++++++++
>  drivers/irqchip/irq-gic-common.h |  8 ++++++++
>  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
>  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
>  include/acpi/actbl2.h            | 12 ++++++++++--
>  include/linux/acpi.h             |  3 +++
>  6 files changed, 55 insertions(+), 2 deletions(-)
>
> --

I can apply the first 2 patches, but I would need an ACK for the 3rd one.

Alternatively, feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the first 2 patches and route them via ARM64.

Thanks!

