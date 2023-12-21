Return-Path: <linux-kernel+bounces-8555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1797281B957
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38B2283FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264CC6D6E8;
	Thu, 21 Dec 2023 14:13:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479016D6D4;
	Thu, 21 Dec 2023 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbb72a1754so205874a34.0;
        Thu, 21 Dec 2023 06:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703167980; x=1703772780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/WbGoRshQ4VaQFeCygAMbZ4TZHbi2rym6nHpBDGXK4=;
        b=gvDm2QATSOVMzDfJq3gfO2YtSCZT81KokCM85jTRBTcdzdAc+Vp/FK/9qya90uvDsq
         WElOwKnd8HOud1+ZvGzsKH/J83iwqIILRWdS7GVMUdVbBqNzodL17EhV/0U69RvDkfXz
         gS9t78oRU5DfdaYU+DrrBxYnbI2sPdpL6QKECC7EFYZ9ShLq0+yDu+EqaNrNDJO5kdMp
         FP28u2CdVj4dCLhOfKDvdFGxEtHEm80C3yPdHH5p/nGMMdQLd2FShzmR5lYyN/wVpRSM
         mFZkaQ83/diAERLGmMxWmaGSLcSBGgQPcaHqCqoQAyu5Q4pmr5JjMcgESuYr/spT2Q8n
         gSww==
X-Gm-Message-State: AOJu0YwcA7Ddm4IYk9Yjk8UrcQ9revMqrug8n3eI/fpjfzS3dEf/ECvC
	havbyKHVOjxpeL9a1cPcBEZfdaNY98c2N87KC5A=
X-Google-Smtp-Source: AGHT+IG7ayD+vIeXhXXVYd0QVilpfO8Q6f1ptPsa6AlyPvCxe/FOHZX56xr6bCFJsC6PH0SN4rS0VSOmVDUj44MqmHM=
X-Received: by 2002:a4a:b803:0:b0:593:fbd5:10aa with SMTP id
 g3-20020a4ab803000000b00593fbd510aamr5926811oop.1.1703167980304; Thu, 21 Dec
 2023 06:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216001312.1160-1-jarredwhite@linux.microsoft.com>
In-Reply-To: <20231216001312.1160-1-jarredwhite@linux.microsoft.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 15:12:49 +0100
Message-ID: <CAJZ5v0gZ39zJEGV7gQLg6Y0=ke1W7bctqtZ46K+SR9RT5Bx4Hg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] acpi: Use access_width over register_width for
 system memory accesses
To: Jarred White <jarredwhite@linux.microsoft.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 1:13=E2=80=AFAM Jarred White
<jarredwhite@linux.microsoft.com> wrote:
>
> To align with ACPI 6.3+, since bit_width can be any 8-bit value, we canno=
t
> depend on it being always on a clean 8b boundary.

So presumably, there are systems out there in which the platform
firmware uses bit_width that is not on a clean 8-bit boundary.

It would be good to mention them here.

> Instead, use access_width
> to determine the size and use the offset and width to shift and mask the
> bits we want to read/write out. Make sure to add a check for system memor=
y
> since pcc redefines the access_width to subspace id.

And it would be good to add a comment to the code for it too.

>
> Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
> ---
> Original thread
> https://lore.kernel.org/all/20230925180552.76071-1-jarredwhite@linux.micr=
osoft.com/
> ---
> changelog:
> v1-->v2:
>         1. Fixed coding style errors
>         2. Backwards compatibility with ioremapping of address still an
>            open question. Suggestions are welcomed.
>
>  drivers/acpi/cppc_acpi.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..fb37e1727bf8 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -163,6 +163,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, n=
ominal_freq);
>  show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
>  show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
>
> +/* Use access_width to determine the total number of bits */
> +#define ACCESS_WIDTH_TO_BITS(reg) 8 << ((reg)->access_width - 1)

Consider adding parens around the entire expression, or you may get
unexpected results.

> +
> +/* Shift and apply the mask for CPC reads/writes */
> +#define MASK_VAL(val) (((val) >> reg->bit_offset) &                    \
> +                                       GENMASK((reg->bit_width), 0))

'reg' should be an argument of the macro or it will be prone to subtle mist=
akes.

> +
>  static ssize_t show_feedback_ctrs(struct kobject *kobj,
>                 struct kobj_attribute *attr, char *buf)
>  {
> @@ -777,6 +784,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>                         } else if (gas_t->space_id =3D=3D ACPI_ADR_SPACE_=
SYSTEM_MEMORY) {
>                                 if (gas_t->address) {
>                                         void __iomem *addr;
> +                                       size_t access_width;
>
>                                         if (!osc_cpc_flexible_adr_space_c=
onfirmed) {
>                                                 pr_debug("Flexible addres=
s space capability not supported\n");
> @@ -784,7 +792,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>                                                         goto out_free;
>                                         }
>
> -                                       addr =3D ioremap(gas_t->address, =
gas_t->bit_width/8);
> +                                       access_width =3D ACCESS_WIDTH_TO_=
BITS(gas_t) / 8;

What would happen if the platform firmware incorrectly provided
reg->access_witdh =3D=3D 0?

> +                                       addr =3D ioremap(gas_t->address, =
access_width);
>                                         if (!addr)
>                                                 goto out_free;
>                                         cpc_ptr->cpc_regs[i-2].sys_mem_va=
ddr =3D addr;
> @@ -980,6 +989,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *=
reg, u64 val)
>  static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 =
*val)
>  {
>         void __iomem *vaddr =3D NULL;
> +       int size;
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg =3D &reg_res->cpc_entry.reg;
>
> @@ -991,7 +1001,7 @@ static int cpc_read(int cpu, struct cpc_register_res=
ource *reg_res, u64 *val)
>         *val =3D 0;
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
> -               u32 width =3D 8 << (reg->access_width - 1);
> +               u32 width =3D ACCESS_WIDTH_TO_BITS(reg);
>                 u32 val_u32;
>                 acpi_status status;
>
> @@ -1015,7 +1025,12 @@ static int cpc_read(int cpu, struct cpc_register_r=
esource *reg_res, u64 *val)
>                 return acpi_os_read_memory((acpi_physical_address)reg->ad=
dress,
>                                 val, reg->bit_width);
>
> -       switch (reg->bit_width) {
> +       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +               size =3D ACCESS_WIDTH_TO_BITS(reg);
> +       else
> +               size =3D reg->bit_width;
> +
> +       switch (size) {
>         case 8:
>                 *val =3D readb_relaxed(vaddr);
>                 break;
> @@ -1034,18 +1049,22 @@ static int cpc_read(int cpu, struct cpc_register_=
resource *reg_res, u64 *val)
>                 return -EFAULT;
>         }
>
> +       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +               *val =3D MASK_VAL(*val);
> +
>         return 0;
>  }
>
>  static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64=
 val)
>  {
>         int ret_val =3D 0;
> +       int size;
>         void __iomem *vaddr =3D NULL;
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg =3D &reg_res->cpc_entry.reg;
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
> -               u32 width =3D 8 << (reg->access_width - 1);
> +               u32 width =3D ACCESS_WIDTH_TO_BITS(reg);
>                 acpi_status status;
>
>                 status =3D acpi_os_write_port((acpi_io_address)reg->addre=
ss,
> @@ -1067,7 +1086,14 @@ static int cpc_write(int cpu, struct cpc_register_=
resource *reg_res, u64 val)
>                 return acpi_os_write_memory((acpi_physical_address)reg->a=
ddress,
>                                 val, reg->bit_width);
>
> -       switch (reg->bit_width) {
> +       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +               size =3D ACCESS_WIDTH_TO_BITS(reg);
> +               val =3D MASK_VAL(val);
> +       } else {
> +               size =3D reg->bit_width;
> +       }
> +
> +       switch (size) {
>         case 8:
>                 writeb_relaxed(val, vaddr);
>                 break;
> --

