Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B57EDD86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbjKPJVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbjKPJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:21:12 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00FE1AB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:21:08 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67089696545so3084366d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700126468; x=1700731268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL39H6t6bxsTD+ztOctS1932vRb+QRkl89FhLK7eO2w=;
        b=JNMw6s5rSK6aDd8SMSh4RhDcGyigZuz9BGcs5euMtWaKZYpBFWJD9J0ev1egp29pKe
         SGQF5rg70UdOFExlx88rrV7MABEQ3bFyUCPIhHFKgQGkNL07/jlovj4Px5uPZQK0Ju7m
         eNg3uxTFz7+N/FblKvu9aosTHZYKPhbPmq4hFlqNJaEwXpAwHmkuu1qCWV3U0KVsz+cx
         7TdMAa7e0gQRsSynqYYqmu44P0RpwxqDJBfh1lLb6HPRD9a7olrhNg8XYy1ap7JFnRjf
         GB5FIL0RiQMtZ+cZqBnerjQHNWQOkZGAcP25SZbHD6RF3nkI6RG/FtSyTBQ9EqP1f1S0
         gK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700126468; x=1700731268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL39H6t6bxsTD+ztOctS1932vRb+QRkl89FhLK7eO2w=;
        b=saeGNaDjCyJTWGL65/DpNu0N+ONbu4Ty3yCkmcikLGg7XlIvg2eMQBOohaXMkQ4qp6
         3xv0N8ZTCgizIelMC4PW9sql8ko2ZnQI3KCkt3/nKS0L+zdLjFkCrTObbDmEJwFZ01ct
         HDgUxa2P+W7RFOLbQk8oe75bTUTApK5N2eqQ86W9el3nQAdjRzJZTKS8Yf6BrwR2VPSe
         Bi/NOQyDAR61XTwmGlYZR3PXh8d/QWZb4S8Uyi/1MDAayhu5A73cnt/J/YxRtQWXFpPI
         rjrw3HE4uG+ellm2i3uQy80HZQz63q/el4cjVtNj/t11/IkJQxlyzu+TqWtlzKJkGPcZ
         65dw==
X-Gm-Message-State: AOJu0YyGCiYGq9pOvEXQbRJWwJeaPy5rXspEYrIvCEDyKkBoov4RVKYL
        vJo+UVzqAOARhtzML5OoN73ab2qu2ilXSOuabDzHfQ==
X-Google-Smtp-Source: AGHT+IHC6nwGkpF/PSyV/svhCqIi/GYkWrnJGNLPzykP9GcOVpjYZIb5GpU44Ibf43ZB0BLs7Gg4kVobl5xh6hb3jWM=
X-Received: by 2002:ad4:5cc6:0:b0:66d:15de:329c with SMTP id
 iu6-20020ad45cc6000000b0066d15de329cmr11619912qvb.43.1700126467765; Thu, 16
 Nov 2023 01:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-21-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-21-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 10:20:31 +0100
Message-ID: <CAG_fn=UhFURUGqFXCrWym98PLzSR9oYfVDFvLpoaRO91_CMenw@mail.gmail.com>
Subject: Re: [PATCH 20/32] s390: Turn off KMSAN for boot, vdso and purgatory
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> All other sanitizers are disabled for these components as well.
>
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
(see a nit below)

> ---
>  arch/s390/boot/Makefile          | 1 +
>  arch/s390/kernel/vdso32/Makefile | 1 +
>  arch/s390/kernel/vdso64/Makefile | 1 +
>  arch/s390/purgatory/Makefile     | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index c7c81e5f9218..5a05c927f703 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -8,6 +8,7 @@ GCOV_PROFILE :=3D n
>  UBSAN_SANITIZE :=3D n
>  KASAN_SANITIZE :=3D n
>  KCSAN_SANITIZE :=3D n
> +KMSAN_SANITIZE :=3D n

Nit: I think having even a one-line comment before this block
(something similar to
https://elixir.bootlin.com/linux/latest/source/arch/x86/boot/Makefile#L12)
will make it more clear.

But given that the comment wasn't there before, leaving this up to you.
