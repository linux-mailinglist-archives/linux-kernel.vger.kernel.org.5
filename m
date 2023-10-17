Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9F87CCBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344176AbjJQTOs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 15:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbjJQTOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:14:46 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F29B0;
        Tue, 17 Oct 2023 12:14:44 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57bf04841ccso1234523eaf.0;
        Tue, 17 Oct 2023 12:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570084; x=1698174884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZgk6uHj6JMqUTxY3b500iwfSpr3E1HiVVNb/KHfLA8=;
        b=uLDF+KjH/YxGVyzKPUCYAKEYmejfJKKqVF75utXV6WC9vWKRkAnHrbv0oiv1oKTQV1
         wSBamTKAyVzaULaUNmQnKmFVS4IlmpwTvxQ9uilPf/ThUgwBjZTNgxiIoRKdHa0eiviW
         ov9XUZvTGkLeKBzRjLZMb/w2uos0ZhNdnztYN9+v5WlxIum/eklEYufq88jJX6sqemMa
         Idks7ykszjzwQl2bEAmy9iE9HGwjQ7D0YLmmTQW0TTzGP2z5oR4zfodfn0uEbhHg+JNK
         8tlntHj5zTwTK54NGPckKaRDvnGwvFLWZ3MFU5ro0nyPAU/aFCvRiYlYpPe2OoBpyWJd
         C0nA==
X-Gm-Message-State: AOJu0YzSYWE/xr1S3UnPA6grPL22h80IchpL78oiVpB7v0SnxIyH+OSU
        lk3YIYCPSz6IEn9JKTv6ONL1exunrCncqG+MAts=
X-Google-Smtp-Source: AGHT+IHyts0f7fQpbo3zEbuKiB2OLrYKBCflycYErs7DLU/JCwdV+MnVFQreB7ffj0e1/6HFWON8gOvqt/9qeyG2clU=
X-Received: by 2002:a4a:4f15:0:b0:581:e7b8:dd77 with SMTP id
 c21-20020a4a4f15000000b00581e7b8dd77mr1614253oob.1.1697570084014; Tue, 17 Oct
 2023 12:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com> <20230808162800.61651-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230808162800.61651-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Oct 2023 21:14:33 +0200
Message-ID: <CAJZ5v0itBZHagHde-Y3WkiXLO2edFaGjiZeko8Jy51Qna7eg2Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] device property: Use fwnode_property_string_array_count()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
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

On Tue, Aug 8, 2023 at 6:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use fwnode_property_string_array_count() instead of open coded variant.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 8c40abed7852..3bb9505f1631 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -473,7 +473,7 @@ int fwnode_property_match_string(const struct fwnode_handle *fwnode,
>         const char **values;
>         int nval, ret;
>
> -       nval = fwnode_property_read_string_array(fwnode, propname, NULL, 0);
> +       nval = fwnode_property_string_array_count(fwnode, propname);
>         if (nval < 0)
>                 return nval;
>
> --
> 2.40.0.1.gaa8946217a0b
>
