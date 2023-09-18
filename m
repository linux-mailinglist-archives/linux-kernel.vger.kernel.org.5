Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0E17A46CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbjIRKS2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 06:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbjIRKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:17:55 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA890A6;
        Mon, 18 Sep 2023 03:17:50 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-573128cd77dso581368eaf.0;
        Mon, 18 Sep 2023 03:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695032270; x=1695637070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujoKUEtOXd64dilUqJr56DQH0KgEx9BHmLMjC6p30VE=;
        b=e6AVsm0xB0U9R92JSHaaXe2Lupj8FSsxLkari0BaBIVfUi/3iYsTgG5Dr3nkF6umBo
         6fhLRRjBwK7jGJxhojsLbHOW+N1/8wLR5Q/KpzWmGCxK1XUc4zoxf5Qh6DlM1O3B1VyA
         3nYXZzqahEmh0gXtROrYTSBS1f6eqwf/UAWy8dPNGydBz/th/vj4rkZ4SnCLWT0AoLyX
         vSfzozwzRZUyLbkVqv0YraXlviQ16kI2OCn2tondmueZfQTRPD4PqDI13wD1rFYUsSsP
         XZAwB3XszXejH6oaQSpczPE0U9WilrfGDAEuc9vf+De6DKnzw5dW4IOIY9neWhtH/lcQ
         0UTQ==
X-Gm-Message-State: AOJu0Yw92F2rrE7vsdmS3tVjrYHQSsBGHj8GKSptrn/oveR7LX87ur8R
        +Rb5/RCeFRv7+Pr7ndnXpwhyKMF7P+XC9EH0vGY=
X-Google-Smtp-Source: AGHT+IG3MV+KQ555ea0PzKJil3qPofKljFz7qtLM1LpTYMGqHFsWCayWqHWt83VjNPXLXJY7G5/ASyHu3cie4JY2a9M=
X-Received: by 2002:a4a:de83:0:b0:56e:94ed:c098 with SMTP id
 v3-20020a4ade83000000b0056e94edc098mr7683183oou.0.1695032269858; Mon, 18 Sep
 2023 03:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230914222527.3472379-1-michal.wilczynski@intel.com>
In-Reply-To: <20230914222527.3472379-1-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Sep 2023 12:17:35 +0200
Message-ID: <CAJZ5v0gCEUmvbPQpJYJw6p_8KB1Jb3-bgcyBKZwdQReimZPw=g@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: processor_pdc: Fix uninitialized access of buf
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 12:25 AM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Bug was introduced during unification of setting CAP_SMP_T_SWCOORD for
> _PDC and _OSC methods. Third u32 in buffer is never being zero-ed before
> setting bits on it. The memory is not guaranteed to be zero as it was
> allocated by kmalloc() instead of kzalloc(). Fix this by initializing
> third u32 in buffer to 0.
>
> Fixes: b9e8d0168a7a ("ACPI: processor: Set CAP_SMP_T_SWCOORD in arch_acpi_set_proc_cap_bits()")
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/processor_pdc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
> index 1a8591e9a9bf..994091bd52de 100644
> --- a/drivers/acpi/processor_pdc.c
> +++ b/drivers/acpi/processor_pdc.c
> @@ -19,6 +19,7 @@ static void acpi_set_pdc_bits(u32 *buf)
>  {
>         buf[0] = ACPI_PDC_REVISION_ID;
>         buf[1] = 1;
> +       buf[2] = 0;
>
>         /* Twiddle arch-specific bits needed for _PDC */
>         arch_acpi_set_proc_cap_bits(&buf[2]);
> --

Applied as 6.6-rc material, thanks!
