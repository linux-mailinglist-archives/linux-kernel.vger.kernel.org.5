Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3704D7B7153
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbjJCSu7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjJCSu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:50:56 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3CF9B;
        Tue,  3 Oct 2023 11:50:53 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6bc9353be9bso168644a34.1;
        Tue, 03 Oct 2023 11:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696359053; x=1696963853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtmU+2BPb9XNUrXvybi5wLHb9uDgJzpyWhEvJ9afzl0=;
        b=kkDvJWOKsIZaw7BuUvwrkkE6qucbSDNbfIS4AKXQ/IlGi2mAN+ehvsTaIG/5W3kgN8
         WqhJsQGokrxFoSBYEuo6uHSc9LKH2D2D+G3pewe8C/FzxpIVRSyS1v8lP8flTzKGa4zn
         xRx76TYQeI1p0odAsZ+WIHeLFoLhr5Sk2J+cgXos+wARWJsCET25t+ZOKBUqksN9FA1U
         VVzWw/VMO4FBgLcge9cRw1/K4kWfUbWsIiL33uHuWtejGxzQCeKg8t1/mHkesfVge2Ua
         vTVn7bmHLKf3GeLFQepwK6GdBdpJFq+KGyUq7y79/KKHGLn2pn8NH8LqQfFQeF2xFLcn
         m8tA==
X-Gm-Message-State: AOJu0YzQpQF8uKR1kSZQWKhzmNfEwBhzISWhGQ4MgnouHMTkPP/sJdSX
        Q8zi2w9HFmtYaAsB3LYpjDRlhSJAFTm+zFvFdu9zZqM8/EU=
X-Google-Smtp-Source: AGHT+IFYN5h5648JxSFBF0rPTdkQtq207jLp+ThdPn4mk/HwNfd3j0kRgAzA1sxYc+qinsdz2c6Zg/AjeM7zYGfba0M=
X-Received: by 2002:a05:6808:309b:b0:3a9:e8e2:579d with SMTP id
 bl27-20020a056808309b00b003a9e8e2579dmr473542oib.2.1696359052777; Tue, 03 Oct
 2023 11:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230925180552.76071-1-jarredwhite@linux.microsoft.com>
In-Reply-To: <20230925180552.76071-1-jarredwhite@linux.microsoft.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 20:50:41 +0200
Message-ID: <CAJZ5v0iHJcZzF=hGLRH+tT6uqCrfHbLw_KJD5dSRRTrsbeVMUQ@mail.gmail.com>
Subject: Re: [PATCH] acpi: Use access_width over register_width for system
 memory accesses
To:     Jarred White <jarredwhite@linux.microsoft.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 8:06 PM Jarred White
<jarredwhite@linux.microsoft.com> wrote:
>
> To align with ACPI 6.3+, since bit_width can be any 8-bit value, we cannot
> depend on it being always on a clean 8b boundary. Instead, use access_width
> to determine the size and use the offset and width to shift and mask the
> bit swe want to read/write out. Make sure to add a check for system memory
> since pcc redefines the access_width to subspace id.

This is fine, but what if there are systems in the field where
bit_width is invalid, but they just happen to work because of the way
it is currently handled?

> Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
> ---
>  drivers/acpi/cppc_acpi.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..07619b36c056 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -777,6 +777,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>                         } else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>                                 if (gas_t->address) {
>                                         void __iomem *addr;
> +                                       size_t access_width;
>
>                                         if (!osc_cpc_flexible_adr_space_confirmed) {
>                                                 pr_debug("Flexible address space capability not supported\n");
> @@ -784,7 +785,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>                                                         goto out_free;
>                                         }
>
> -                                       addr = ioremap(gas_t->address, gas_t->bit_width/8);
> +                                       access_width = ((8 << (gas_t->access_width - 1)) / 8);

The 8 << (gas_t->access_width - 1) is duplicated twice below.  There
could be an inline function doing that computation.

And the outer parens above are not needed AFAICS.

> +                                       addr = ioremap(gas_t->address, access_width);
>                                         if (!addr)
>                                                 goto out_free;
>                                         cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
> @@ -980,6 +982,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>  static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>  {
>         void __iomem *vaddr = NULL;
> +       int size;
>         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>
> @@ -1015,7 +1018,12 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>                 return acpi_os_read_memory((acpi_physical_address)reg->address,
>                                 val, reg->bit_width);
>
> -       switch (reg->bit_width) {
> +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +               size = (8 << (reg->access_width - 1));

Code duplication, outer perens not needed.

> +       else
> +               size = reg->bit_width;
> +
> +       switch (size) {
>         case 8:
>                 *val = readb_relaxed(vaddr);
>                 break;
> @@ -1034,12 +1042,16 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>                 return -EFAULT;
>         }
>
> +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +               *val = (*val >> reg->bit_offset) & GENMASK((reg->bit_width) - 1, 0);

The formula on the right-hand side of this is duplicated below.
Again, there could be an inline function doing this.

> +
>         return 0;
>  }
>
>  static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  {
>         int ret_val = 0;
> +       int size;
>         void __iomem *vaddr = NULL;
>         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg = &reg_res->cpc_entry.reg;
> @@ -1067,7 +1079,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>                 return acpi_os_write_memory((acpi_physical_address)reg->address,
>                                 val, reg->bit_width);
>
> -       switch (reg->bit_width) {
> +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +               size = (8 << (reg->access_width - 1));
> +               val = (val >> reg->bit_offset) & GENMASK((reg->bit_width) - 1, 0);
> +       } else
> +               size = reg->bit_width;

Missing braces (as per the kernel coding style).

> +
> +       switch (size) {
>         case 8:
>                 writeb_relaxed(val, vaddr);
>                 break;
> --
> 2.34.1
>
