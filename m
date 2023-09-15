Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FAC7A1B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjIOJsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjIOJsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 411552D6B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694771150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1VBwuYXQUntYei3UdowzwFY82byxmtnNnjvSqOT3Vs=;
        b=DG98/YMwmd5GsczuAJdp9bIcbwTf4jD9V4zURg9sBBkx8R+3yqU2KBJWqtNCaVbWABH4g5
        lrwMqgMG95tpZhBL1TUWLFOLoiaRmwT4eDNr8FPrahJFUvVsTqWWdfHy9tXE9jWcSjb7hS
        MQGQq3/IVyhcAta7Uc8zg2+zl17kl50=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-uUgdy8GCOT2hxMumLuW5Fw-1; Fri, 15 Sep 2023 05:45:47 -0400
X-MC-Unique: uUgdy8GCOT2hxMumLuW5Fw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-573f6f0fe9aso1732341a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771146; x=1695375946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1VBwuYXQUntYei3UdowzwFY82byxmtnNnjvSqOT3Vs=;
        b=AmoeApziSM2lmYVWEbE6RJgvESylU6gESBz97fUBnUqSrWuJ/IODrpOJsbiFoTe6oa
         smw4a9/E3T/hfGXqX8yuobyO21kzZu3ZZarQcscQxAn/9WSlR0wApcQwnklBNp0yukG3
         zwCi02png4CY1drwLQ1q11nASfx04aGv0GUi6+fgu7ohvhnCFvfyo5HKc0x4E8ALp7g5
         YDpvnTZar7QpoGmOnqcAxeRH/AxjVkwIcD+d5PY3uQpibqFkbYPFc36mwTkpqs9O5pW5
         7mCY/L5KxmWNSLnd/dQDzRiXW0duJGxtjPK/fr6yms0fjRaljKU+tUhG2iRWIXD1SVOA
         65hg==
X-Gm-Message-State: AOJu0YwzNtmwZxIHtcKHUKVOiFYkG3i8ck0wo3NLJE1N14ee2S99G38Y
        fwUYTgyr12CD5tzmB5BLRi/hEYnHhByLK6VxKK7s1H3soZpEN81ns2Wy9c2ZmZFyGulXRuIZcqm
        4e96ljZGdtJLMCGk1judTm3DeMDfY+SOLWVx18bIx
X-Received: by 2002:a17:90a:488e:b0:25c:8b5e:814 with SMTP id b14-20020a17090a488e00b0025c8b5e0814mr905170pjh.44.1694771146517;
        Fri, 15 Sep 2023 02:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+w0KCMY2aOS5+Qti0qYHaaiMfOlm1MoZJGYHxoE7tu1gXi7tNdwS+brqiPhBxoPCU8oo/3Z3q4o6FnaJnUN8=
X-Received: by 2002:a17:90a:488e:b0:25c:8b5e:814 with SMTP id
 b14-20020a17090a488e00b0025c8b5e0814mr905153pjh.44.1694771146206; Fri, 15 Sep
 2023 02:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230915092003.658361-1-ulf.hansson@linaro.org> <20230915092003.658361-5-ulf.hansson@linaro.org>
In-Reply-To: <20230915092003.658361-5-ulf.hansson@linaro.org>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Fri, 15 Sep 2023 10:45:10 +0100
Message-ID: <CAOgh=FzNordx=_YMiQs2Uj6JQ7Ctqqi=XZbbRAY9cS-F8v68RA@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] pmdomain: apple: Move Kconfig option to the
 pmdomain subsystem
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 10:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The Kconfig option belongs closer to the corresponding implementation,
> hence let's move it from the soc subsystem to the pmdomain subsystem.
>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Sven Peter <sven@svenpeter.dev>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: <asahi@lists.linux.dev>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This patch in the patchset looks the same as yesterday, so...

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/pmdomain/Kconfig       |  1 +
>  drivers/pmdomain/apple/Kconfig | 18 ++++++++++++++++++
>  drivers/soc/apple/Kconfig      | 13 -------------
>  3 files changed, 19 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/pmdomain/apple/Kconfig
>
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 03c8991ad0fd..482d9e970e14 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -3,5 +3,6 @@ menu "PM Domains"
>
>  source "drivers/pmdomain/actions/Kconfig"
>  source "drivers/pmdomain/amlogic/Kconfig"
> +source "drivers/pmdomain/apple/Kconfig"
>
>  endmenu
> diff --git a/drivers/pmdomain/apple/Kconfig b/drivers/pmdomain/apple/Kconfig
> new file mode 100644
> index 000000000000..12237cbcfaa9
> --- /dev/null
> +++ b/drivers/pmdomain/apple/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +if ARCH_APPLE || COMPILE_TEST
> +
> +config APPLE_PMGR_PWRSTATE
> +       bool "Apple SoC PMGR power state control"
> +       depends on PM
> +       select REGMAP
> +       select MFD_SYSCON
> +       select PM_GENERIC_DOMAINS
> +       select RESET_CONTROLLER
> +       default ARCH_APPLE
> +       help
> +         The PMGR block in Apple SoCs provides high-level power state
> +         controls for SoC devices. This driver manages them through the
> +         generic power domain framework, and also provides reset support.
> +
> +endif
> diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
> index a1596fefacff..eff486a77337 100644
> --- a/drivers/soc/apple/Kconfig
> +++ b/drivers/soc/apple/Kconfig
> @@ -4,19 +4,6 @@ if ARCH_APPLE || COMPILE_TEST
>
>  menu "Apple SoC drivers"
>
> -config APPLE_PMGR_PWRSTATE
> -       bool "Apple SoC PMGR power state control"
> -       depends on PM
> -       select REGMAP
> -       select MFD_SYSCON
> -       select PM_GENERIC_DOMAINS
> -       select RESET_CONTROLLER
> -       default ARCH_APPLE
> -       help
> -         The PMGR block in Apple SoCs provides high-level power state
> -         controls for SoC devices. This driver manages them through the
> -         generic power domain framework, and also provides reset support.
> -
>  config APPLE_RTKIT
>         tristate "Apple RTKit co-processor IPC protocol"
>         depends on MAILBOX
> --
> 2.34.1
>
>

