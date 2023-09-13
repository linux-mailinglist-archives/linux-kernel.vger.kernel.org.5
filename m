Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2FD79F545
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjIMXBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMXBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:01:19 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35661BCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:01:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d7b91422da8so351329276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694646075; x=1695250875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19r5Py/LpEY+FFEQKG3+Tw+Ix+6vrZU5cch3Re00Pt4=;
        b=Zmv2Oj5x40igof7p1JIc6t3/DqOyYFZAKNGs10aZMIjle0Akq4qwiG8rZ3GcD+3JBD
         h6IYBpVG5SxjSlFFtb20YlCqOmzPedeDc5Yv1+b0+je++kEsGz6H8wRdaO4bz6CfdoTo
         9Qpk/bO6kexrtqI+LCqn355HAm8bLUAsK4FUagjxUjAv4FpQlA+HP8X2oqheaoiiz7Hx
         n/IQUSKNAYtKf8iCtJMD42urmlduv7UjLuyI5wYEwIS5GGMO045Vfsq4INBKZEIZpqjl
         IdzwB6vyghCOB/+99e0VDMlVNnLJep4xqAIoH+kbc9Y8OLWXKMYCB4HfJj+X8EAzTagP
         vlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694646075; x=1695250875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19r5Py/LpEY+FFEQKG3+Tw+Ix+6vrZU5cch3Re00Pt4=;
        b=e8nZTvTsgfjk45WkO0P7FD73ZTsufz1TWV26hMihFoyTyktCVpNxkWLF8Xe4WUvseC
         1TXmZuDLpucdks9yQN2KaWeQY6qlWmYAd31gjrX4nc3ckUgTXYKjSBh68LqEKGdrNeIx
         oqU9O7fI7cYAjtK2VO5p8Xfxs2S7s/oCVZhHWmjSA3IG8Z1cJSdaCxbcjHjLheTLEFn0
         gymhBh/TBiUOa+rs0XYonYYJnDnCEF/k/gT9ySMdpL9fOlwNCNSPWuI5wAvpRIcu2C9l
         iqU+Yn+/YWdbJClwcLTnluuS8BBQX1r0sSXnTsJDUYyDumjgA3cXDphtAasIQYyHNr30
         hUfQ==
X-Gm-Message-State: AOJu0YwNqts/x3BudbtpzMvybxCzXsHUnbUIvWKCIjMt34ilLdzVexeC
        JZO+OJ/vJErcB61PQZiV+KNf9HCnawALBNRKG3C1LQ==
X-Google-Smtp-Source: AGHT+IEhqVDZ4nLq7RvXZNqanuZvBb17fHdCf33L9k4YIEa5olFftn1mJlMQm1wcNmwpoas5JBl/6GYYwUiD8skad28=
X-Received: by 2002:a25:9707:0:b0:d80:4c9b:bf72 with SMTP id
 d7-20020a259707000000b00d804c9bbf72mr3558257ybo.21.1694646074606; Wed, 13 Sep
 2023 16:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <202309132044261713252@zte.com.cn>
In-Reply-To: <202309132044261713252@zte.com.cn>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 13 Sep 2023 23:01:01 +0000
Message-ID: <CAJuCfpF_gSdfk_csny-6p661gfGy41w0V2QwoCSY02KdeXMLEA@mail.gmail.com>
Subject: Re: [PATCH linux-next] sched/psi: Avoid update triggers and
 rtpoll_total when it is unnecessary
To:     yang.yang29@zte.com.cn
Cc:     hannes@cmpxchg.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:44=E2=80=AFPM <yang.yang29@zte.com.cn> wrote:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> When psimon wakes up and there are no state changes for rtpoll_states,
> it's unnecessary to update triggers and rtpoll_total because the pressure=
s
> being monitored by user have not changed.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 81fca77397f6..e4463bb267c3 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -701,7 +701,7 @@ static void psi_rtpoll_work(struct psi_group *group)
>                 goto out;
>         }
>
> -       if (now >=3D group->rtpoll_next_update) {
> +       if ((changed_states & group->rtpoll_states) && (now >=3D group->r=
tpoll_next_update)) {

With this additional condition group->rtpoll_next_update will not be
updated if states do not change and later on we will have a call to
psi_schedule_rtpoll_work() with the delay calculated as
"nsecs_to_jiffies(group->rtpoll_next_update - now) + 1". With
group->rtpoll_next_update not updated, we can end up with a negative
delay. I don't think that's your intention here, it is?

>                 group->rtpoll_next_update =3D update_triggers(group, now,=
 &update_total, PSI_POLL);
>                 if (update_total)
>                         memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
> --
> 2.25.1
