Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34B812199
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442799AbjLMWhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:37:02 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1ABB7;
        Wed, 13 Dec 2023 14:37:08 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67ef9c6745eso6598076d6.1;
        Wed, 13 Dec 2023 14:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507028; x=1703111828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhslwT3u/DM8BEIb5CNvkmOQPz2c8s+oUi5ecuMmZqY=;
        b=F/udJqYgCzCXgAh7y9VkrRAG7uVjrykp9ycw4BvTN+czBVk6BflLx8Wz5lhs7bGouT
         4Wz3bZf0RTNzAKZYaSaH5lgc+gASML2Bk3V3nmL/q43AJMpzPueIVCVxRyyg8xvT98EK
         tuZtEYz5/oeppXauyXGbptwLcjVezrssAbeVbLs2UUMe/0c4Z6l10bdAC36hDH0rqYXd
         kOp4/uzpscZmDonlmLQn0blPJ9GLdq2zWkkAkbNpSh9RRpPFptOlhoB4/gVz6T/jhEQb
         ZmpPxUACIypLkhrmi+NeBeJaB8a3SZ3wgilRkmywVELG44pdUCwMLsZ8kyROZKfqprio
         8Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507028; x=1703111828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhslwT3u/DM8BEIb5CNvkmOQPz2c8s+oUi5ecuMmZqY=;
        b=EjWWNR37MYZc0M3nk4ioTCU0EaItlBRKGtA5WHthghyht3tDpd+U95I/si/nR0gQbf
         o++jMIoWDrChj60Ofxk73vQimAiloL5stmnhTb9q2d2uHpiyYl5cVqFVIAvN6mf7BUwp
         gD1FRSHPQpC/DaccPHOwbjMmXzuOQ+OQDVbNHYVujaKww/DxeXbB60xENl2rYOi2TPuY
         mRLY3F0ECLpl2hFxFwCq69tycRL4Dl1shz8Kft9rXaT/qSZQKw62y9PARaY71DZCQGXl
         csumcV0zHTReJS6b+ngbWBbb0YAvL7czd+szuOgoXZC81EP0bYnAtWIANSB/OscFUhDE
         7ZGg==
X-Gm-Message-State: AOJu0Yzu9TVLem/Ooh9ulqJdX9NVd9NZneLGBqIWDON54tCzqyIDUGMo
        sgBB4iNjKlOHc1w52RuoM8OfT9+N3QbRbR4HGRpTJGAtg+N5uw==
X-Google-Smtp-Source: AGHT+IE/pf8cFq4+dbNNQjWRVssYU1BLZNUl2mjooowkoBVqDRSq1PjFThd80lRcIrnMdTuMrs0MuDyWQH3O1ow44WU=
X-Received: by 2002:a0c:c48b:0:b0:67a:a721:82f1 with SMTP id
 u11-20020a0cc48b000000b0067aa72182f1mr8302603qvi.75.1702507027837; Wed, 13
 Dec 2023 14:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20231213223020.2713164-1-gnstark@salutedevices.com> <20231213223020.2713164-4-gnstark@salutedevices.com>
In-Reply-To: <20231213223020.2713164-4-gnstark@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Dec 2023 00:36:31 +0200
Message-ID: <CAHp75Vc1zZFWB8PPrg8oeAKz9aHnQrrSjdGyGd8mWcmeZdJ9qA@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] devm-helpers: introduce devm_mutex_init
To:     George Stark <gnstark@salutedevices.com>
Cc:     pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hdegoede@redhat.com, mazziesaccount@gmail.com,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, nikitos.tr@gmail.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:30=E2=80=AFAM George Stark <gnstark@salutedevice=
s.com> wrote:
>
> Using of devm API leads to a certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapper.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() is
> extended so introduce devm_mutex_init().

...

> +#ifdef mutex_destroy
> +static inline void devm_mutex_release(void *res)
> +{
> +       mutex_destroy(res);
> +}
> +#endif
> +
> +/**
> + * devm_mutex_init - Resource-managed mutex initialization
> + * @dev:       Device which lifetime mutex is bound to
> + * @lock:      Pointer to a mutex
> + *
> + * Initialize mutex which is automatically destroyed when the driver is =
detached.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock=
)
> +{
> +       mutex_init(lock);
> +#ifdef mutex_destroy
> +       return devm_add_action_or_reset(dev, devm_mutex_release, lock);
> +#else
> +       return 0;
> +#endif
> +}

If this is going to be accepted, you may decrease the amount of ifdeffery.

#ifdef ...
#else
#define devm_mutex_init(dev, lock)  mutex_init(lock)
#endif


--=20
With Best Regards,
Andy Shevchenko
