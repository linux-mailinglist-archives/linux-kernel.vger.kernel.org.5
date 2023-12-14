Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B9812FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573011AbjLNM0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572989AbjLNM0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:26:30 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F2E11A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:26:36 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-46660a641f2so268691137.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702556795; x=1703161595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2Q8hlZ64NbmJ0/ekFmh7A+/wN3OLdaYsRhF1/tMxRs=;
        b=2SPUgaQFC9IWe+1lIiZoD+/02se25m2NtbGisXy4ym64j7aJt0KsWzfa4iKEKq4o9k
         4yXM+znMqYhYQWDCFXoLU54RpaPnuCaEVJUX+iwcSWFyt2yNvyrn9MsKAIIlwxq8ParK
         ahIP7qXNa9pKO9a50i+/ibXSV9lK21SxDlwm5/subM9JiwOAnRwDrYPc05kkJErISQzn
         JcOJbGJx+6gmZrNQFdMtgvP6IAAINbhUBnm38t9iSBLkChn3kV1XwSd17HcdEBywOHKg
         4bTS6tsh2ruy8vL3uI6AUd932nMGMWg2ZOpH8AGVBabuzuDLnLSb3We+nSCCct8YYcPZ
         lsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556795; x=1703161595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2Q8hlZ64NbmJ0/ekFmh7A+/wN3OLdaYsRhF1/tMxRs=;
        b=clcN0DHI30NeXJ6yWvbQZz9Oj604ERRUx5zdm1X+IWXpdYxoXs0aryo3oOss+jz66y
         V4iVRfJHEwu77j5BY1L7xVvTgsfFrSRyn1QxMlUeJYGUrpp3GRNnR576R6I/6H7JAOoA
         91eAVx4SugNHAX9CymnXp4N1tJQLGtOQDE/OJuuTC7zlxA4g9KgkovbCi6EJHeAOMvuS
         9TIb065RLJNwTDXFfoXOEZZScz1fcE7V3C/pgmoCP1CtwHJ/vsyYX4MC0SXu1s6txG9l
         n+s9FT6iSmQoVb8B7MybTrvn7hamRJKZUdftdtxKklT8qE4W1DIGe80/Lbj+R8fIj0Y6
         CJPg==
X-Gm-Message-State: AOJu0Yz3ZuNOTdIffnbL0u4RcxuzVectOVn0Z9uBaZoK45ueW5Dz13yr
        1rx16DysxtHaX87lykUmM9NDemFBHTgTD9qdyoyg+g==
X-Google-Smtp-Source: AGHT+IFJnd3NWdiALNpof+UgNDsWh0lKMJt0WRqf4oRVtEa5JqmD+fdi95HGY5hitlPjecpCFXm/yCAIBJ43ZrsRK9c=
X-Received: by 2002:a05:6102:3f14:b0:466:255a:69fe with SMTP id
 k20-20020a0561023f1400b00466255a69femr6746510vsv.35.1702556795153; Thu, 14
 Dec 2023 04:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20231208102020.36390-1-brgl@bgdev.pl> <20231208102020.36390-3-brgl@bgdev.pl>
In-Reply-To: <20231208102020.36390-3-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Dec 2023 13:26:24 +0100
Message-ID: <CAMRc=MfV7uf-K-+aGN8QWrGBDjvvtcsimWDTXEBZMHXrmFiSgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: use a mutex to protect the list of GPIO devices
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 11:20=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The global list of GPIO devices is never modified or accessed from
> atomic context so it's fine to protect it using a mutex. Add a new
> global lock dedicated to the gpio_devices list and use it whenever
> accessing or modifying it.
>
> While at it: fold the sysfs registering of existing devices into
> gpiolib.c and make gpio_devices static within its compilation unit.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If there are no objections, I'll apply it tomorrow.

Bart
