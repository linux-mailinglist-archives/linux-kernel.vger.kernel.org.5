Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E337D7E7F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjKJR4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjKJRzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED54A27B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 00:53:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so24281a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 00:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699606393; x=1700211193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo3Gaef76iZdXuhsx+7+Om1O4tE/oq1eo+uule+ERTE=;
        b=w60jJm1zzPUQBH2LMtpUKvckPCnvCMcuxB74Phs/oJS4nUVUdnADfZXrvUXrJe5XVB
         Z/pBPSzhy2tqqTIjukQcldaqEt/KkOKn8sxzWpw+TF5HziW7IMNZxuhY+taBsAdaUlbN
         n64s0bwc9c27WY4akZjQR7n05xPM5Hfi0w1VGyvIkWB2ho9kOKblmtv39QbVfSYdg91N
         xdBCyiTEzwuJ0AwtvlmbxDXST3bwlrmxC8ZwE1jl3Jk+LnaFSuuH6oWt2GacZ4yVrsTr
         pfKVwI8vwZWH6NqtwhHk+YB13RirZtfybVGSmcTRSt1tQgpwIfh3OACZZhQZNC/GIV9Y
         0sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699606393; x=1700211193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bo3Gaef76iZdXuhsx+7+Om1O4tE/oq1eo+uule+ERTE=;
        b=LnJ3tqxLIWcoRlUfBbKHtVc1dytXXXKsCmD1PaH3ND86tgDVz0EGytq95zDDosSUsa
         3My5OBkAedgbC0VxmvBtet4MuQiPVskr7zTnRsyexUqgLRHdbNU1kFwFgdxdY429QGsS
         iM/eiLdfSEqCcOT+0SihyF9f7vJBcXeiwQJQt7YYDOwQca4TL5jwSkhitfjp1m75Fy1y
         1Yir0GiBFNLMji5948UR+gfsMeGybsA6moh9A6x/90u7Bk7vdiZRjtBwJcE+qstIrB0f
         wDtNWoa1n9Lfv7JMRLqIkmYgUmBCSvz3nkEbMVOTCrr2zlJzox8BrHE2a8YqDW4tZvVF
         La2A==
X-Gm-Message-State: AOJu0YxgSICrCxxDrVVVwKdbxYhggkT30hkJbLV48VibVEHHbJZxHJYi
        ItdfhsMDgsT4hO0yjA4UQkzeg0CWWcuaIJm/u9moyA==
X-Google-Smtp-Source: AGHT+IHNVwWCLTN6LjcqqqgM7vGdwZcOOORDqp35sP4CzTDGxBSeVzCT91zZD4uIiqV2QAN4HgA7DtSL0ihyPu880ts=
X-Received: by 2002:a05:6402:497:b0:544:24a8:ebd with SMTP id
 k23-20020a056402049700b0054424a80ebdmr327482edv.4.1699606393272; Fri, 10 Nov
 2023 00:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20231110084425.2123-1-kdipendra88@gmail.com>
In-Reply-To: <20231110084425.2123-1-kdipendra88@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 10 Nov 2023 09:52:59 +0100
Message-ID: <CANn89iL34Yiuas__P5WbtVM-mN5=ga-RhZV7Kdqo4a6KDxTv1g@mail.gmail.com>
Subject: Re: [PATCH] Fixes the null pointer deferences in nsim_bpf
To:     Dipendra Khadka <kdipendra88@gmail.com>
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 9:45=E2=80=AFAM Dipendra Khadka <kdipendra88@gmail.=
com> wrote:
>
> Syzkaller found a null pointer dereference in nsim_bpf
> originating from the lack of a null check for state.
>
> This patch fixes the issue by adding a check for state
> in two functions nsim_prog_set_loaded and nsim_setup_prog_hw_checks
>
> Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com./bug?extid=3D44c2416196b7c607f226

Please add a Fixes: tag, and remove this empty line, thanks.

>
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
>  drivers/net/netdevsim/bpf.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
> index f60eb97e3a62..e407efb0e3de 100644
> --- a/drivers/net/netdevsim/bpf.c
> +++ b/drivers/net/netdevsim/bpf.c
> @@ -97,7 +97,8 @@ static void nsim_prog_set_loaded(struct bpf_prog *prog,=
 bool loaded)
>                 return;
>
>         state =3D prog->aux->offload->dev_priv;
> -       state->is_loaded =3D loaded;
> +       if (state)
> +               state->is_loaded =3D loaded;
>  }
>
>  static int
> @@ -317,10 +318,12 @@ nsim_setup_prog_hw_checks(struct netdevsim *ns, str=
uct netdev_bpf *bpf)
>         }
>
>         state =3D bpf->prog->aux->offload->dev_priv;
> -       if (WARN_ON(strcmp(state->state, "xlated"))) {
> -               NSIM_EA(bpf->extack, "offloading program in bad state");
> -               return -EINVAL;
> -       }
> +       if (state) {
> +               if (WARN_ON(strcmp(state->state, "xlated"))) {
> +                       NSIM_EA(bpf->extack, "offloading program in bad s=
tate");
> +                       return -EINVAL;
> +               }
> +       }
>         return 0;
>  }
>
> --
> 2.34.1
>
