Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D9E7834BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjHUVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjHUVPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:15:30 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC13CE6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:15:28 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-79b191089a3so1178091241.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692652528; x=1693257328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVxMQR3O7prohkAR0NEt8dxjD9BUuL3A4STMNK5vyIw=;
        b=y4gLvQKEAKU7W2cyE4KIQW4Gkbnx5JHSHCWKjIN/ngyBg1eXjPD8U1IZ0a45DjVX31
         kdJZgwvaH3Vgam5Z3sOI/FxlTSSt/lTxJRJoCrFm+xL9fBXN+XPnYZ3gUoYxQqhfOO/m
         zM1Qo0AOdOB+2FK6rnGwHzktHLrynqL1M6NBHbGvQMpbW+VqqfpIl/FaQIUJC7WIzXn9
         j5qhwLeUfiCqnoehRYF7vzMUSDZ6C6HZSIJDSeFS5hJsoLq72b6ZC6SJYMKatTB7V/Ft
         eGoZsqI2wycPfvXMk4MikSIsYgtlIgdifJLxv5KwakccCIuA7vOyvNxswvYLI3NFLKg1
         19eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692652528; x=1693257328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVxMQR3O7prohkAR0NEt8dxjD9BUuL3A4STMNK5vyIw=;
        b=JBnncNvTWaPXgOUefhyycFdgYlnriGNMSVYz/Y34hjCPxMXh9xqcjSeWVK04FGViO/
         +sNveb3XTAGIOtQp7/IHU+Xojv+iDOebfJsy8NEbdvQ1XBE8UnMj5MIWi5kJAybGkGaa
         lHs6BeXJsTBvdkJf4mDT7yMtZ3V7dt+2tVwtbRr/Bdve7FO4cj0NWD+DSF5v7cfmxHk6
         rD2kTabRdbZxHCbEMGOofs3Qn6Is8iTgQuhmKVzxNcZFI6Sf7T0ORGzBoKqa5K/B0TIC
         BuXWPD8uwGtbioRpXmmUyIdGzYv3dUoFDGpZCujFzuU7nM8H14ZE3/DAcl57NofklfQT
         kt8g==
X-Gm-Message-State: AOJu0Yw5bujPfak5jEY/MQFo2wyWLEGwFfd387e6jqU6PGHB4hl40Mmj
        rmHA8NLDpSnZjR02aDEC+bJE70gRvd6c9E+ik0urlA==
X-Google-Smtp-Source: AGHT+IHrN69c706NpzC/QYE+qahB0V/hEamTm027MsZjAY0tjH6FHgj8LBUCk4zFiuLsGW4Cx3RMPqBBI95VGXTXJm8=
X-Received: by 2002:a67:ff93:0:b0:443:7bbc:e397 with SMTP id
 v19-20020a67ff93000000b004437bbce397mr6244538vsq.26.1692652528045; Mon, 21
 Aug 2023 14:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230812194457.6432-1-brgl@bgdev.pl> <20230812194457.6432-2-brgl@bgdev.pl>
In-Reply-To: <20230812194457.6432-2-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Aug 2023 23:15:17 +0200
Message-ID: <CAMRc=MfeooECP4+8phon31FC25LhwKC1DxfQDvr81-di8NAf_w@mail.gmail.com>
Subject: Re: [PATCH 1/4] genirq/irq_sim: dispose of remaining mappings before
 removing the domain
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 9:45=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> If the device providing simulated interrupts is unbound (real life
> example: gpio-sim is disabled with users that didn't free their irqs)
> and removes the simulated domain while interrupts are still requested,
> we will hit memory issues when they are eventually freed and the
> mappings destroyed in the process.
>
> Specifically we'll access freed memory in __irq_domain_deactivate_irq().
>
> Dispose of all mappings before removing the simulator domain.
>
> Fixes: b19af510e67e ("genirq/irq_sim: Add a simple interrupt simulator fr=
amework")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Please disregard this patch. I realized that it should be up to the
owner of the domain to dispose of mappings. Just like core GPIO does
for the domains it controls.

I will send the rest separately once they're reworked.

Bart
