Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA89E77B478
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjHNIma convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjHNImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:42:11 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B83A10B;
        Mon, 14 Aug 2023 01:42:11 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d62bdd1a97dso4176400276.3;
        Mon, 14 Aug 2023 01:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692002530; x=1692607330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZne+Le5QqxdXNtZ7brJGNgIF3GQo0uhPPT5CceibE0=;
        b=VbdNN1LK56aJpOfZagHrZM2p8L+MfzU+S0MYhwmRHcZ1RtInzxV+GXP4tBYPpjvZYc
         KezZu/16u+KIFVI6AfNDXVqhLhdIxbzlTvBk5tfjAr8Fzg1M9Mhdlb2/0ccjIrto6n7/
         WOxZlK9yeE7zLftHKuOduLrG8aXlpxyxm1lmDM3RSHDwkdJY+OP9VG80KwbTpPN/9+Z5
         jDRfhtRVq4xZxWsPAg+mQzgc7YptwcJMlyt7STmcAnvgfDVhVhNki1lYmc+NyKgfzOAb
         jaAm93mA96QJZGmirTimd7fmXREVAClTHsrCIbdB95fJs3o0cJ7VcLoCECZAQBks5gOZ
         tMNw==
X-Gm-Message-State: AOJu0YzTvmHcE/w9JPNmTBV14zDvQC3PDf4w1x4seoVzA0xBv9N0qK1M
        z+17jlDD2CGL1MNhnORbdafFhS4BP7Cbpw==
X-Google-Smtp-Source: AGHT+IGHz08kCZ+x3KT3qgo8LrWOjc0+TXxiP/8W2wpiWgfw+/gmS42Zj5VsOklA3QDe0iff+yCruA==
X-Received: by 2002:a81:a54e:0:b0:586:a684:e7ba with SMTP id v14-20020a81a54e000000b00586a684e7bamr9625810ywg.39.1692002529781;
        Mon, 14 Aug 2023 01:42:09 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id w13-20020a81a20d000000b005840bd271c5sm2596830ywg.100.2023.08.14.01.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:42:08 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d62bdd1a97dso4176371276.3;
        Mon, 14 Aug 2023 01:42:08 -0700 (PDT)
X-Received: by 2002:a25:dc04:0:b0:d13:5ab9:827e with SMTP id
 y4-20020a25dc04000000b00d135ab9827emr9522737ybe.16.1692002528140; Mon, 14 Aug
 2023 01:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230802033737.9738-1-duoming@zju.edu.cn>
In-Reply-To: <20230802033737.9738-1-duoming@zju.edu.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Aug 2023 10:41:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWq4d7FJp6X_3=BQU-1=xvK1_jFJuq_7mTOaBJNXr1gEQ@mail.gmail.com>
Message-ID: <CAMuHMdWq4d7FJp6X_3=BQU-1=xvK1_jFJuq_7mTOaBJNXr1gEQ@mail.gmail.com>
Subject: Re: [PATCH] sh: push-switch: reorder cleanup operations to avoid UAF bug
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, kvalo@kernel.org, pavel@ucw.cz,
        pabeni@redhat.com, rostedt@goodmis.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 5:46 AM Duoming Zhou <duoming@zju.edu.cn> wrote:
> The original code puts flush_work() before timer_shutdown_sync()
> in switch_drv_remove(). Although we use flush_work() to stop
> the worker, it could be re-scheduled in switch_timer. As a result,
> the UAF bug will happen. The detail is shown below:
>
>       (cpu 0)                    |      (cpu 1)
> switch_drv_remove()              |
>  flush_work()                    |
>   ...                            |  switch_timer //timer
>                                  |   schedule_work(&psw->work)
>  timer_shutdown_sync()           |
>  ...                             |  switch_work_handler //worker
>  kfree(psw) //free               |
>                                  |   psw->state = 0 //use
>
> This patch puts timer_shutdown_sync() before flush_work() to
> mitigate the bugs. As a result, the worker and timer could
> be stopped safely before the deallocate operations.
>
> Fixes: 9f5e8eee5cfe ("sh: generic push-switch framework.")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
