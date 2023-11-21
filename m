Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C627F3071
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjKUONc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 09:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjKUONb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:13:31 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B210DB;
        Tue, 21 Nov 2023 06:13:27 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d31666d89cso860816a34.1;
        Tue, 21 Nov 2023 06:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576007; x=1701180807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLbXOVCOe8I9i74gRQ9M4a7DNGH8GboOO++V6GgCwbg=;
        b=k+6QVqUN7HjVevNjxhI9s9eUHkDR9CBbxIBq0t6kgr3Q34nNHhpKQ3svlfkL6XD50d
         N7yZYiED1v8i1xdInC1fpTGlZZWi7TuHRilEFM4i/fV4h4m4XY5Fm09Xr3EPKGK7zo1j
         OxqRYiHE3706vCfS4pEuJl8ZDeUc0mA5/cc6RrHPrN70FQSsnsTb+zkEsgHgwaZAvPug
         vT6ewn7K+uVvuYz7J+ZeOkOI1BbhuM5U2G79ExP6Ocp+4Q7DeGE7R2jaNU9Pmli5uB8+
         3JVzYHvluXLRRFNIXwl71PNG0dp3AEvqpvDIFpxuo02s03xQ7q5mgK5w4WPg5JlpI4Az
         N3Bw==
X-Gm-Message-State: AOJu0Yy+xHU4MVvf9wSCTDvV/G+pU4xma33LkjYu6Q/yzpUnPH2q9Soo
        g1skojBbWE2i6YF/PP3M8MQThKumq8JUZt/U6/wI/JfA
X-Google-Smtp-Source: AGHT+IHgx6g+rJKOcCkESy4ug8DTJ8F31cIDaD+ZrrB5NezRtOLqENCOINUQU1xJDQAKNRJgK3KuYy8BDPz6c+am2Jo=
X-Received: by 2002:a4a:d44c:0:b0:584:1080:f0a5 with SMTP id
 p12-20020a4ad44c000000b005841080f0a5mr9931337oos.1.1700576007055; Tue, 21 Nov
 2023 06:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20231121070826.1637628-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20231121070826.1637628-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Nov 2023 15:13:16 +0100
Message-ID: <CAJZ5v0jgxVR9t604tC6LNOoD5Pv9vyhZNx=LiAcr4OR_C4_PcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Fix an error print in DisCo for Imaging support
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Tue, Nov 21, 2023 at 9:33 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> The recently merged DisCo for Imaging support used a wrong printk
> specifier in printing a message. Fix it by using %zu instead of %lu.
> Also use "bits" instead of "bytes" as these are indeed bytes.
>
> Fixes: a6cb0a611273 ("ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/mipi-disco-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
> index cad72d1fc127..7286cf4579bc 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -533,7 +533,7 @@ static void init_csi2_port(struct acpi_device *adev,
>         if (ret < 0) {
>                 acpi_handle_debug(handle, "Lane polarity bytes missing\n");
>         } else if (ret * BITS_PER_TYPE(u8) < num_lanes + 1) {
> -               acpi_handle_info(handle, "Too few lane polarity bytes (%lu vs. %d)\n",
> +               acpi_handle_info(handle, "Too few lane polarity bits (%zu vs. %d)\n",
>                                  ret * BITS_PER_TYPE(u8), num_lanes + 1);
>         } else {
>                 unsigned long mask = 0;
> --

Applied (with a slightly adjusted subject), thanks!
