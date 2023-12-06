Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47B80792C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379528AbjLFUKy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 15:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442877AbjLFUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:10:51 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7048311F;
        Wed,  6 Dec 2023 12:10:57 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso32417fac.1;
        Wed, 06 Dec 2023 12:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893457; x=1702498257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32NboKdEEry+p7HRVVx+YEW6Zjud8R5v5yW1kUM2NMU=;
        b=sKlJBRc++kmYVjtJBIMsWf2mFcme5f1AiYWDvJP0v1AzxUkBuYdwa/e/h/sZotFAil
         Blwf0bWPbZANUmLAk8tqY37x2z/COhp2R8n2elh5DTSx9yd3YgHjvHumlee9wel2fiIU
         6lpZ9ItDeFHqwZQPVT/njkNAQQSA0obiDvnx8HYT6GoEDB65UhZwLFbkR5Lkm2GyiQ/V
         +PAnONmshaUGDb4ORJPVHWl9uAIemhAjUFmkk/FGyjE/f1h+X3ZkyvPb0KhF8jDscBBW
         XNj2FwDf6qqwNPI8Opc44YDvObCzOhzBytj9kUANcwnkKHU/1L5x+FkdjTnlfAI+EnDg
         OenQ==
X-Gm-Message-State: AOJu0YxyY4WrPsFOvwgqpeoSG5T0QwHVanVw9fzTc3bWQTOd2MWg3nXs
        R5ZIiU6SgqDAv5Zj1z1NrFwNQLy0GiSxuMradeo=
X-Google-Smtp-Source: AGHT+IHPAP8AL59zyFtPtTB7eVNF84HILsRrEh/VOneuGIXezqqewr+VNupPVANN38p6QKK7bV7A6or59SU+DB3njKw=
X-Received: by 2002:a05:6870:9e84:b0:1fa:f195:e3b4 with SMTP id
 pu4-20020a0568709e8400b001faf195e3b4mr3000102oab.2.1701893456740; Wed, 06 Dec
 2023 12:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20231129084247.32443-1-liuhaoran14@163.com>
In-Reply-To: <20231129084247.32443-1-liuhaoran14@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 21:10:46 +0100
Message-ID: <CAJZ5v0goHCBcgFhphtenVKoFPyWN83Uuoo30q3E4DtEH=w4Q7A@mail.gmail.com>
Subject: Re: [PATCH] [ACPI] sbshc: Add error handling for acpi_driver_data
To:     Haoran Liu <liuhaoran14@163.com>
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

On Wed, Nov 29, 2023 at 9:43 AM Haoran Liu <liuhaoran14@163.com> wrote:
>
> This patch enhances the acpi_smbus_hc_add and acpi_smbus_hc_remove
> functions in drivers/acpi/sbshc.c by adding error handling for the
> acpi_driver_data calls. Previously, these functions did not check
> the return value of acpi_driver_data, potentially leading to
> stability issues if the function failed and returned a null pointer.

This needs to describe a real scenario in which acpi_driver_data() can
return NULL for each of the 2 places modified by the patch.

> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>  drivers/acpi/sbshc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index 16f2daaa2c45..1394104d3894 100644
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -267,6 +267,12 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
>         init_waitqueue_head(&hc->wait);
>
>         hc->ec = acpi_driver_data(acpi_dev_parent(device));
> +       if (!hc->ec) {
> +               pr_err("Failed to retrieve parent ACPI device data\n");
> +               kfree(hc);
> +               return -ENODEV;
> +       }
> +
>         hc->offset = (val >> 8) & 0xff;
>         hc->query_bit = val & 0xff;
>         device->driver_data = hc;
> @@ -288,6 +294,11 @@ static void acpi_smbus_hc_remove(struct acpi_device *device)
>                 return;
>
>         hc = acpi_driver_data(device);
> +       if (!hc) {
> +               pr_err("Failed to retrieve ACPI SMBus HC data\n");
> +               return;
> +       }
> +
>         acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
>         acpi_os_wait_events_complete();
>         kfree(hc);
> --
> 2.17.1
>
