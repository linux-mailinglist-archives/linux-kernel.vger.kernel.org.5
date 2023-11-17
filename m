Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954577EFB02
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjKQVpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjKQVpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:45:39 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB29AD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:45:36 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso351535866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700257534; x=1700862334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGFlEAYvYwVwffh6sLgp4waOfz+LHysgSd3bAAPCd40=;
        b=LINqJrq3xG9qZ8V1wHbgGFBsicvRtsI2BTZNVl+YktN5FYVbEv6I3AikOqNkUxNzwq
         e8QPuv7tLpB25kQ8CDbNB3SloplkSBeTZS2Po28kzcKo4sRFh8XOi4FK9iV7/WthVAwW
         8T1AKd0mIGIVGEh3tWigDBMQZSLW0s7365NCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257534; x=1700862334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGFlEAYvYwVwffh6sLgp4waOfz+LHysgSd3bAAPCd40=;
        b=gOSxkvBMjipB+FMR0AckTKXM9v6hrG8QL6GDWlkS5lYcfqFNYjHYJ6yDEdQVBIQonW
         pFoFKbUNuNo9Y1MKVMSR4caQOy4iC2vY3Q8JStfvwzrNDxk/rfK1v0D3p6T39Uo95TEh
         YUf8zKyPne2DGMNMT3XVTxoqTuUjGYn5gup9Asp7rxFx8Q0CnepWY4NKsMa1EpaCzAA/
         5f/edEmpVYbGi2m8w8QaSb96/4emmEPF45VT+eCZHZWYhXsPV9bdzPnY54M0TsFBe68F
         CxJ5T9PJ80DsT+H5m6G0y5oTRm3PmXQpeH3PQ6lu0enDNF62PVxCFBXtnegI2lIRBGht
         JwIA==
X-Gm-Message-State: AOJu0YyQQRjNic9gzzhrtEKmwZ2guEQZar/CcmjJuuIoUqCG0lCytpUf
        8Ag1Lp2Sw196GaWjgfQb2w+qnONNwwzH61O3MFEGCg==
X-Google-Smtp-Source: AGHT+IF8k6E8mvCH1/VMYoP86tae0AcJwW69nJyoUr4Xvhd5yuJFIdmU9EQKwOgCxt2ZOydnHHnVvg==
X-Received: by 2002:a17:907:c78d:b0:9e3:fc27:9356 with SMTP id tz13-20020a170907c78d00b009e3fc279356mr341357ejc.51.1700257534189;
        Fri, 17 Nov 2023 13:45:34 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id jo26-20020a170906f6da00b009ddaa2183d4sm1187872ejb.42.2023.11.17.13.45.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 13:45:33 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40837124e1cso19995e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:45:33 -0800 (PST)
X-Received: by 2002:a05:600c:1c83:b0:3fe:eb42:7ec with SMTP id
 k3-20020a05600c1c8300b003feeb4207ecmr55080wms.1.1700257533517; Fri, 17 Nov
 2023 13:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20231114021529.1834-1-lizhe.67@bytedance.com>
In-Reply-To: <20231114021529.1834-1-lizhe.67@bytedance.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Nov 2023 13:45:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XhqDxmk=yTdujwtFyF23NZ13LORH0GMS5_iTAEVva_rA@mail.gmail.com>
Message-ID: <CAD=FV=XhqDxmk=yTdujwtFyF23NZ13LORH0GMS5_iTAEVva_rA@mail.gmail.com>
Subject: Re: [RFC] softlockup: serialized softlockup's log
To:     lizhe.67@bytedance.com
Cc:     akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com,
        lecopzer.chen@mediatek.com, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 13, 2023 at 6:16=E2=80=AFPM <lizhe.67@bytedance.com> wrote:
>
> From: Li Zhe <lizhe.67@bytedance.com>
>
> If multiple CPUs trigger softlockup at the same time, the softlockup's
> logs will appear staggeredly in dmesg, which will affect the viewing of
> the logs for developer. Since the code path for outputting softlockup log=
s
> is not a kernel hotspot and the performance requirements for the code
> are not strict, locks are used to serialize the softlockup log output
> to improve the readability of the logs.
>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  kernel/watchdog.c | 3 +++
>  1 file changed, 3 insertions(+)

This seems reasonable to me. It might be interesting to talk about in
your commit message how this interacts with the various options. From
code inspection, I believe:

* If `softlockup_all_cpu_backtrace` then this is a no-op since other
CPUs will be prevented from running the printing code while one is
already printing.

* I'm not 100% sure what happens if `softlockup_panic` is set and I
haven't sat down to test this myself. Will one CPUs panic message
interleave the other CPUs traces. I guess in the end both CPUs will
call panic()? Maybe you could experiment and describe the behavior in
your commit message?


> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 5cd6d4e26915..8324ac194d0a 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -448,6 +448,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct =
hrtimer *hrtimer)
>         struct pt_regs *regs =3D get_irq_regs();
>         int duration;
>         int softlockup_all_cpu_backtrace =3D sysctl_softlockup_all_cpu_ba=
cktrace;
> +       static DEFINE_SPINLOCK(watchdog_timer_lock);

I'd be tempted to define this outside the scope of this function. I
need to dig more, but I'm pretty sure I've seen cases where a soft
lockup could trigger while I was trying to print traces for a
hardlockup, so it might be useful to grab the same spinlock in both
places...
