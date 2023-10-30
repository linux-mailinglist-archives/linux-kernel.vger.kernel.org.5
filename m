Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9B17DB4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjJ3ICz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJ3ICy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:02:54 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2E8A2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:02:52 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3580b94ac2eso14864495ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698652971; x=1699257771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBLQaO2WMbtm/heOlZQXC4I4OJH/epBfW9GD5VTLDEE=;
        b=S27nNnTm7ETgdvw9/GPHaTggpPaXW8SVsKkU2Gjzd7p0UJjnLW0fOo1tTV4tMkQF6A
         UUPZBLLQg7GoTIKgR4QmZNivFivq7G09wj2pdIp6J/btuFgwJi+oC8Vn3V0v3JEy/9Mn
         uFVEu/ouUbmjiHB4unKCQIqr8KlhHxxFQMPHMC5LPxlFIK5GiY2jG9LwwqxhAvzHqTCC
         A6LprgW3UcKl3ehGM98dELNc2u5npZ+hjbcC+4dzv8IDPYBEXkGXQ1i+R4jodd+OPCGF
         FyoMMMwMOBcP15RyhoHWVL74tBWwfPwf8y/4zGeoYDhxwpgbneFRtLRANLFAV1Jm3TWP
         qD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698652971; x=1699257771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBLQaO2WMbtm/heOlZQXC4I4OJH/epBfW9GD5VTLDEE=;
        b=CKioWv7rs1jotrq4VzxhkxuxWuxGX+4Y529m9fWmCFBT/a674jRFTwGwW17Pji4WMa
         eqDzv6fg+ctrnSczXcplw0dynwD2ZCfjJVRf9M/4BnRXr7pmoF9SDtnVuLG3ja1i2weh
         Y69qYY/Ax2/MUaiUVnv0O0R4mZF9ZSDIs/ayqVcpb3u1i04nQS35KgWbs+OWISxxDkvZ
         5ZFNXOZ2lNF/SvlU/SyBeJCDn+duWrTL+nDtrX4vs6Jmrqxsgz7fN1IZfX/ysjf0i8BX
         vpuMlJ5l36L1exc5g7wNLN/jgijRRiNbByonkaTbgIASYqLEEIAvG//7SuqS+DehGtyH
         J+Rg==
X-Gm-Message-State: AOJu0YxxqvdPCFI3hjs2NfDswGwqleBWPWuMtefUMs0e8k6facSvIEdj
        X4HL5gOARF8v9cHwU4z0c7EfrDxdF05XO/3/KcRAoQ==
X-Google-Smtp-Source: AGHT+IE+AfzotCmVymmnDxcJLx9BR8wa5o7XZYmzZxFCAzoqoKrwHiJrP8cLSv4LBgt7d6nceM9jJLcRW8aE3HnxWXY=
X-Received: by 2002:a05:6e02:156a:b0:357:9f55:ec41 with SMTP id
 k10-20020a056e02156a00b003579f55ec41mr12409466ilu.31.1698652971658; Mon, 30
 Oct 2023 01:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231027171742.1426070-1-keisuke.nishimura@inria.fr>
In-Reply-To: <20231027171742.1426070-1-keisuke.nishimura@inria.fr>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 Oct 2023 09:02:40 +0100
Message-ID: <CAKfTPtCsmR13LO9T1ApdyxvXyFSq78RNEC+xmbakK+GNQUVXsA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix the decision for load balance
To:     Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 at 19:25, Keisuke Nishimura
<keisuke.nishimura@inria.fr> wrote:
>
> should_we_balance is called for the decision to do load-balancing.
> When sched ticks invoke this function, only one CPU should return
> true. However, in the current code, two CPUs can return true. The
> following situation, where b means busy and i means idle, is an
> example because CPU 0 and CPU 2 return true.
>
>         [0, 1] [2, 3]
>          b  b   i  b
>
> This fix checks if there exists an idle CPU with busy sibling(s)
> after looking for a CPU on an idle core. If some idle CPUs with busy
> siblings are found, just the first one should do load-balancing.
>
> Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> ---
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2048138ce54b..eff0316d6c7d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11083,8 +11083,9 @@ static int should_we_balance(struct lb_env *env)
>                 return cpu == env->dst_cpu;
>         }
>
> -       if (idle_smt == env->dst_cpu)
> -               return true;
> +       /* Is there an idle CPU with busy siblings? */

Nit. I agree with Shrikanth that we should keep using similar comment :

/* Are we the first idle CPU with busy siblings */

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> +       if (idle_smt != -1)
> +               return idle_smt == env->dst_cpu;
>
>         /* Are we the first CPU of this group ? */
>         return group_balance_cpu(sg) == env->dst_cpu;
> --
> 2.34.1
>
