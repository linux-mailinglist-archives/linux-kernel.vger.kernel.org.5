Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6578A867
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjH1I7V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 04:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjH1I6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:58:48 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00C3102;
        Mon, 28 Aug 2023 01:58:45 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-57328758a72so828336eaf.1;
        Mon, 28 Aug 2023 01:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693213125; x=1693817925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3FZcTZH37FUS4WWZ6lFpJNi4D7JTyraivRiz2TeBYU=;
        b=U1ipCtiNFyWzWpBocewkjMS3ZFazqtgVu3IcByP4H9gWeqPXtCD1dHNWMJtSqXXDKT
         IYrxc9FCyauNT0jyt8BV1n8o9GqgnU8hGJK5xEDPtDCiqZxGckk7k6DsCc9DAb6I397h
         Jql5oVNR3PKKTGvfJ6pe/F8cv/OTDvR4L+EFVff4UURbyKdIVwZO8ZbVVIqZSxGL/BaX
         Qzkw5uPJ+vRnOlHd+Ks0z80tKClDl6+rSF15D0NShrBvh+jV4FNf+xCzzem3/igx4b3u
         vTefdAN6z/PEyjAHWYzBrZ+p/zXvRS1XCkceKA9GWd731uAr62AmIGUyb3BQT8pYkEDY
         FeGg==
X-Gm-Message-State: AOJu0YzDEeTfftdiYwYMdBbraGNh3xdLLox8z7BlX8y3j5ONvAlPKlrG
        WDTuFjl0Jqrvrsrny0LQoHgGSw3jqG9gnQ9jJlo=
X-Google-Smtp-Source: AGHT+IE8sxryy1AJOeaiDLv29IhQTJIUO6CF9gxlFEOQ8Jnp8t4887JIJavWAtb+nBh00Y3kU4BtKeDE0l7/d49Q8gI=
X-Received: by 2002:a4a:d137:0:b0:571:1906:47f0 with SMTP id
 n23-20020a4ad137000000b00571190647f0mr13319897oor.1.1693213125014; Mon, 28
 Aug 2023 01:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230826095836.1138608-1-liaochang1@huawei.com>
 <20230828072347.ly23mbptu3yw4zkv@vireshk-i7> <bcac1b3c-a2f7-7f18-4c2f-5cf27f4e89b5@huawei.com>
 <20230828085248.sz6aljr5aln7j435@vireshk-i7>
In-Reply-To: <20230828085248.sz6aljr5aln7j435@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Aug 2023 10:58:30 +0200
Message-ID: <CAJZ5v0iGikZ=JSA5Nyx5Dc4QunSC5BObNO5yzQh44UYjrtRKYg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix the race condition while updating the
 transition_task of policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Liao, Chang" <liaochang1@huawei.com>, rafael@kernel.org,
        srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28-08-23, 16:29, Liao, Chang wrote:
> > Task B does not necessarily go to sleep when it calls wait_event(), it depends on
> > the condition to wait for evaluate false or not. So there is a small race window
> > where Task A already set 'transition_ongoing' to false and Task B can cross wait_event()
> > immediately.
> >
> > wait_event:
> > do {
> >       might_sleep();
> >       if (condition) // !transition_ongoing
> >               break;
> >       __wait_event();
> > };
> >
> > I hope I do not miss something important in the code above.
>
> > Yes, if the CPU uses weak memroy model, it is possible for the instructions to be reordered.
> > therefore, it is a good idea to insert an smb() between these two lines if there is race here.
>
> Maybe it would be better to do this instead ?
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6b52ebe5a890..f11b01b25e8d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -455,8 +455,10 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>                             policy->cur,
>                             policy->cpuinfo.max_freq);
>
> +       spin_lock(&policy->transition_lock);
>         policy->transition_ongoing = false;
>         policy->transition_task = NULL;
> +       spin_unlock(&policy->transition_lock);
>
>         wake_up(&policy->transition_wait);
>  }
>
> --

I was about to suggest the same thing.

wake_up() is a full memory barrier only if it actually wakes up a task
and if it doesn't do that, without the locking the other task may see
a state in which transition_ongoing is false already and
transition_task is still NULL regardless of the relative ordering of
the statements before the wake_up() call.
