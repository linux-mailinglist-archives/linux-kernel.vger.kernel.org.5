Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47396779652
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjHKRlM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbjHKRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:41:10 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2030D7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:41:07 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6bca018afe8so492041a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775667; x=1692380467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExTa7sddqKQ9PExE1g2tgQcWlqOuw7gNHFjjd2ZFHVE=;
        b=JH8RE2K0lsRJqdpis+1H0H3dVjdivajSR20lxXe7LHAkB3Q/C3AeHk2iCET2hJx5kr
         TGSNdpO7zw+HVMyLamfettsB/tXGcdKSszx6mSOsuTsbT44xU/O2mmZkL8LCn8qWPTRG
         1rz9D+ATRK9/0ZcUuWGKq1hHTDbL2jZWGUol5eN67+dIoHGLt7yUF2nqG6CWKNyVSMUR
         oc69Ilza8ETyX2WdMgJBKJDNul59t0LLKyzw22rtvdHrTYoO/xyV3XTxenKcbTsd+3ug
         il/IfcuqQ/CeIzpS0DwxKllObBe7DttjQ6TyBtvntG7wIYDoKKCZGyI1UBQQd5qcWhj8
         QXqw==
X-Gm-Message-State: AOJu0Yw9V6J3BPjyyrI5G8pze/1f7DQZLT+vpAfIJHyp8ha/ZCCSrUws
        PAufOO0z0EBWJ3oU81b6txocQ3OYzOAcviWANrs=
X-Google-Smtp-Source: AGHT+IE+0DF/3zHqNrNlZGcpu8g3kVYcOxZ9PfJ/vpGlQS7kPQ8DeKm5ipaW8Uw6JQ9lrMZWwpudq1QsyImac2xV4Sc=
X-Received: by 2002:a05:6820:2018:b0:56d:6bd4:4db5 with SMTP id
 by24-20020a056820201800b0056d6bd44db5mr2047769oob.0.1691775666997; Fri, 11
 Aug 2023 10:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230811170049.308866-1-frederic@kernel.org> <20230811170049.308866-9-frederic@kernel.org>
In-Reply-To: <20230811170049.308866-9-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 19:40:56 +0200
Message-ID: <CAJZ5v0gCHcm+BDSK_ih38thw9oim_1qkN5Z2YfUze-1wg6knAg@mail.gmail.com>
Subject: Re: [PATCH 08/10] x86: Remove __current_clr_polling() from mwait_idle()
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
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

On Fri, Aug 11, 2023 at 7:01 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> mwait_idle() is only ever called through by cpuidle, either from
> default_idle_call() or from cpuidle_enter(). In any case
> cpuidle_idle_call() sets again TIF_NR_POLLING after calling it so there
> is no point for this atomic operation upon idle exit.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  arch/x86/kernel/process.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 72015dba72ab..f1eb769770b1 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -918,7 +918,6 @@ static __cpuidle void mwait_idle(void)
>                         raw_local_irq_disable();
>                 }
>         }
> -       __current_clr_polling();
>  }
>
>  void select_idle_routine(const struct cpuinfo_x86 *c)
> --
> 2.34.1
>
