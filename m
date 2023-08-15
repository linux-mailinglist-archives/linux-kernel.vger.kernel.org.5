Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DED77C82D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjHOG5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjHOG5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:57:02 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C2C10C0;
        Mon, 14 Aug 2023 23:57:01 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56c711a889dso3592589eaf.0;
        Mon, 14 Aug 2023 23:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692082620; x=1692687420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUF7+zEwFhnnxO0YUzrV1ZAOv1FqyPAGYAalPW9tUBE=;
        b=IIiMuHsVnAlCIxFfXYA2IZ3IwE5c9M3UboDhuUYimh7CaDhdCMr0CscYJSTEb8n3rS
         249+hMUP8she9bC3BXRxvgFlxKrpWOyzxEDi6S9EnkmO/ZuexFH1un2cHVO7lG1rfIFJ
         lWxhMG5PPIkPlsIpoPW11d5+ZiaGhps7X0CHwvAjt6LAzT2um3A++OwpcjKdwNjs1VnZ
         hzYpFOvh1R+5NCYs6iN4lpZ68C+pIjjSVX+HsfxGCRL2xPeuvyjni+IFS02KwQ3VI3s0
         wUCuhUr0LJwjm3VLng7WXF/nUYZeudxEzh7vt+pCqLmQLZq1VxsNjom4m/xPXcX1tTGY
         8Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692082620; x=1692687420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUF7+zEwFhnnxO0YUzrV1ZAOv1FqyPAGYAalPW9tUBE=;
        b=OErGh9uomnbaAoZcQ6Cmt2z3eXv7YkU0Lv758phHaxmfswR7vzxnmm8a3eL0qf2Se5
         f71IEzksiQwIvlB23eOye6N6uaAbaqP7Y5s3er2tcNM1WfAaEXgc9RYkn8hTneCYcG6n
         4VFWqJTvZPYOILRAOPCOWWGpeL/5z8eXt/e89IYxWt9nqDJl7l8+A5RBGwXrNzpKgNUo
         a1j6BlxtvZqPxI3ZN4HTbcI/u4bD3MExosV2sXkzeM+3kzvwfLUrwzy1DYGxNgSXI0S8
         yjTREAWuGN56+c3BW2t1nRby4ZeEdzYKdH4MDveIaMfWsepdJgtwEx/faQIaN5hjtcuv
         niJQ==
X-Gm-Message-State: AOJu0YwpnB+qRb8I86XtHOvdjh59WJfdzeaysbDDEctbi6cWAZ1rSdj/
        ALN0ChjVotMTLx/RGAXaDah0FsuEFPobU+NwnZA=
X-Google-Smtp-Source: AGHT+IF9wHpQbz6RjsFYq8asdD4gmXQL8tAld3WVXDlp4tr4KWfme3FVlS7l/mjFiuvLMcN8VLs04uIMXrcfGkSNZyA=
X-Received: by 2002:a05:6871:28e:b0:1b0:3ffc:97e9 with SMTP id
 i14-20020a056871028e00b001b03ffc97e9mr13997249oae.0.1692082620445; Mon, 14
 Aug 2023 23:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230807062345.490-1-xuewen.yan@unisoc.com>
In-Reply-To: <20230807062345.490-1-xuewen.yan@unisoc.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 15 Aug 2023 14:56:49 +0800
Message-ID: <CAB8ipk9wJ-VDHrLMgEoVcdquWptkLnXZ15xFvugC8+WXOf6_Og@mail.gmail.com>
Subject: Re: [PATCH] PM: QOS: Always use "kstrtos32_from_user()" in cpu_latency_qos_write()
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        qyousef@layalina.io, guohua.yan@unisoc.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi rafael

What do you think of this patch=EF=BC=9F

 # echo 500 > /dev/cpu_dma_latency
[T4893] write: qos value=3D170930229
[T4893] write: count value=3D4

the value is 170930229 is because it's hex is 0x0A303035,  It is
exactly the "500\0"

 # echo 200> /dev/cpu_dma_latency
[T4893] write: qos value=3D170930226
[T4893] write: count value=3D4

the value is 170930226 is because it's hex is 0x0A303032,  It is
exactly the "200\0"

Thanks!

On Mon, Aug 7, 2023 at 3:17=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com> w=
rote:
>
> In cpu_latency_qos_write, there is a judgment on whether the count
> value is equal to sizeof(s32). This means that when user write 100~999,
> it would get error value because it would call the "copy_from_user()"
> instead of "kstrtos32".
> Just like:
>
>  # echo 500 > /dev/cpu_dma_latency
> [T4893] write: qos value=3D170930229
> [T4893] write: count value=3D4
>
> [T4893] write: qos value=3D170930226
> [T4893] write: count value=3D4
>
> To prevent this happening, delete the "copy_from_user()" and
> always use "kstrtos32_from_user()".
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/power/qos.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 782d3b41c1f3..21a2f873e921 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -379,17 +379,11 @@ static ssize_t cpu_latency_qos_write(struct file *f=
ilp, const char __user *buf,
>                                      size_t count, loff_t *f_pos)
>  {
>         s32 value;
> +       int ret;
>
> -       if (count =3D=3D sizeof(s32)) {
> -               if (copy_from_user(&value, buf, sizeof(s32)))
> -                       return -EFAULT;
> -       } else {
> -               int ret;
> -
> -               ret =3D kstrtos32_from_user(buf, count, 16, &value);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret =3D kstrtos32_from_user(buf, count, 16, &value);
> +       if (ret)
> +               return ret;
>
>         cpu_latency_qos_update_request(filp->private_data, value);
>
> --
> 2.25.1
>
