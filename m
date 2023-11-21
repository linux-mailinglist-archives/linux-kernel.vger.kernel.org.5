Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346CA7F3719
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjKUUGH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 15:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKUUGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:06:04 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F4D45;
        Tue, 21 Nov 2023 12:06:01 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f5ccc1ca61so791729fac.0;
        Tue, 21 Nov 2023 12:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700597160; x=1701201960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZdmFrIm/sdRXr/gN6Rcmkno5GanwFZMzxl8GvUJAxk=;
        b=MgNK0ywecweAs4S5/i2nik+5fozXUsRPCpmUbsdwfl+RXc5oD/0di3xHnbOUD4K3pJ
         oVRRhnT7Uv7ZLKF7QcPMymqY7P/q4zaVffrOHMV9oehlCVReIwW8rvqILk2Ite4SCJQz
         BswfPrj9Y4/HSAaHx892LoQqsXj9M6lQZtjE3HpHepZgjyUpE7GsR8LnErX9zURrWpX5
         qh1C+WZX5a4TAKEv7O20JTjXKRbSMRPYEk+N4hIUw9a9z9s0RdZ39gfcomKVWhs9Fuu4
         nBsQwyG9dMd1SgrLsklNOfUqgN9ogoll3r5iRzn1l3Ap4wJa9gJdHqDUjbzXLNedc6uy
         zG4Q==
X-Gm-Message-State: AOJu0Yz7poZRt+8qaDfF7ZnUHUZoW0zkjGo/Hj81KudcH39yXDCCbVfK
        roGJqsakI9JKEFFC6mWYhpD5zzQD+LnKxmr58VE=
X-Google-Smtp-Source: AGHT+IEUTj1Q2x9aQhHHr04XswTW5/vAfHw6sCqC93RK+4mY7Oj098zk0VNw2dddy2WYd0nD4mZbYocawm3vAlqS36I=
X-Received: by 2002:a05:6870:7a18:b0:1e9:9440:fe4a with SMTP id
 hf24-20020a0568707a1800b001e99440fe4amr372851oab.3.1700597160593; Tue, 21 Nov
 2023 12:06:00 -0800 (PST)
MIME-Version: 1.0
References: <ea6ef128-fa22-44b3-bd10-c136bc89c036@ancud.ru>
In-Reply-To: <ea6ef128-fa22-44b3-bd10-c136bc89c036@ancud.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Nov 2023 21:05:49 +0100
Message-ID: <CAJZ5v0hxkoeFYVxQ_ZYCMK+0L=7WdBQHRp6ouv+FzahfMrs_eQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: OSL: Initialize output value
To:     Nikita Kiryushin <kiryushin@ancud.ru>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>,
        Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 8:45 PM Nikita Kiryushin <kiryushin@ancud.ru> wrote:
>
> Buffer variable for result (value32) is not initialized.
> This can lead to unexpected behavior, if underlying platform-specific
> raw_pci_read fails to report error (uninitialized value will be treated
> as valid pci-read result), or exposition of unexpected data to PCI
> config space reader.
>
> Zeroing of buffer value addresses the later problem and makes the
> behavior in the former case somewhat more predictable.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c5f0231ee6b0 ("ACPICA: Fix acpi_os_read_pci_configuration prototype")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>   drivers/acpi/osl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index c09cc3c68633..d3c0f7f01a29 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -788,7 +788,7 @@ acpi_os_read_pci_configuration(struct acpi_pci_id
> *pci_id, u32 reg,
>                                u64 *value, u32 width)
>   {
>         int result, size;
> -       u32 value32;
> +       u32 value32 = 0U;

So wouldn't it be better to avoid modifying *value at all if
raw_pci_read() returns an error?

And if it returns a success, why wouldn't it be trusted?

>         if (!value)
>                 return AE_BAD_PARAMETER;
> --
