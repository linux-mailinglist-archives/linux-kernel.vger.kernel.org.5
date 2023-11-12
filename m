Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED39A7E9145
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 15:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjKLOoG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Nov 2023 09:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKLOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 09:44:05 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7352D57;
        Sun, 12 Nov 2023 06:44:02 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-582050ce2d8so415840eaf.0;
        Sun, 12 Nov 2023 06:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699800242; x=1700405042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0a8CXLEZpahW3IPv8vcTRw+EWiu/yxFVb4isOKde8s=;
        b=BleN5sP0jBaOFVzSKfFPrWjp2mdNtAhu1TzEl+HW3Zu/eDAKWylHnsxt81aRhdaDTA
         0+Hmw+ha63uifRj/nmrTkoDtnpAs9HC/UNH3gAXUZ6SQnxk//BJIrsw2s7Se53fOMX2w
         nUxy41odewsZw+3zfS2c536u01FcDAfS2NrJ0ch+8eFUsxKrinYRO0qm3GR67DUfZPC4
         CzyFTavedfC66qIFYTCFtL8z0ZdEimL03/tBkHOKkjwT6xW//+0mh6dzasmQK1lPsn7A
         9PQs7yy7kHFZ+g/Z2wTqSNJ+T1iDCn4c5TuCbiIfrbyuCdyeoBTcleSQ/LK8dVNLk1qL
         Jrkg==
X-Gm-Message-State: AOJu0Yy7IdJh/k1gzHHFTr5TnDoAXvD58YZEf095KZeD8MuYz40/ytUc
        yBm3DIOsNwBaMStSnVtHlR9Xk+de8aMySYrFJgFI6LFu
X-Google-Smtp-Source: AGHT+IHi9NJTrKDGu9WMJ2Mzn3zTE9sa0z3dteNscBR/YGmx3MwsyqyxhWnx5UcQZtEp1jjIVBMePaSkh1PcTs1IFfA=
X-Received: by 2002:a4a:b1cb:0:b0:589:dc7a:75e5 with SMTP id
 j11-20020a4ab1cb000000b00589dc7a75e5mr3582362ooo.1.1699800241866; Sun, 12 Nov
 2023 06:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20231111132402.4142-1-shiqiang.deng213@gmail.com>
In-Reply-To: <20231111132402.4142-1-shiqiang.deng213@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 12 Nov 2023 15:43:50 +0100
Message-ID: <CAJZ5v0gPCp=3-1z6Ok1g=xkDMu6zN3C3iiH2mtEKXi9sheH7cw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: custom_method: fix a possible memory leak
To:     "shiqiang.deng" <shiqiang.deng213@gmail.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, Nov 11, 2023 at 2:25 PM shiqiang.deng
<shiqiang.deng213@gmail.com> wrote:
>
> In the cm_write() function, memory is allocated,
> and at the end of the function when uncopied_bytes is 0,
> the memory is freed. If uncopied_bytes is not equal to 0,
> a memory leak occurs.
>
> Signed-off-by: shiqiang.deng <shiqiang.deng213@gmail.com>
> ---
>  drivers/acpi/custom_method.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index d39a9b474727..5103c7c3a6ce 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -77,6 +77,9 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
>                 if (ACPI_FAILURE(status))
>                         return -EINVAL;
>                 add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
> +       } else {
> +               kfree(buf);
> +               buf = NULL;
>         }
>
>         return count;
> --

That was discussed in the past and I still would rather drop this I/F
completely instead of patching it for minor issues.
