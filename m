Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA87A9B74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjIUTBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjIUTBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:01:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2886A7F37E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:35:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5031426b626so2049901e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695317734; x=1695922534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=asW3V0UfBRcaqJZf0dqMocPiGq1jVGiQw3a4sepePiw=;
        b=kRqjRoR6sabLPaxweF6dD0DwvFQxqg0LpZRsXKwZ+acivjv/s+cy5lwgN5dkAz9sVZ
         Gf1XUZjOTm4udusbTlWN3FZ0ZzIsKTGMX25CA065sgAjUQ1cYMliOpCPPLVI83eLT2/g
         c7GFySt9peEKsgtnkzgEyz1tp+PDyj9w+UgCuq2moyKZ7dQPHb+wPr7Xk6TWmIPob7gV
         W44xE032+WmFCPHDGT03G9UKx1HuHHevlJeljmarweZ8ZG1N0eZ503yOmkSRCrquVWav
         +UyzOZtPEKZ/4jPMl7RQBm7b+OFZDwOcAlhfm1k9hH1hurgCuPRXA+Z2uz4zgprCkE09
         3ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317734; x=1695922534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asW3V0UfBRcaqJZf0dqMocPiGq1jVGiQw3a4sepePiw=;
        b=ojWTrjmBkzbUGr8EGVIlT+0LEjxEfiWAGuy7s3sTGh8PRNG7YTS3ejy0mVLNAWPi9s
         eEQ+eR8EFiNjwZ4eQYmn67+bih/veYkwKLmHvVD2deHxdMacqkXfx0CegON9cdQdKoAw
         YMHoIODyVxb77glUNrSA+wOxZm/i8lGDa4uxaZCm5IiFSuG26Yh7Ms1ypqRpr1G57/88
         gaG21lL8fkcza2HD5bzy7Dhaxff/NaRTw/PSBYzv4RLVeorPL7YBa9yJiQZAIgs7AmRQ
         FDW5ntkokVcmc/CEASJeeoRuPOzB1zp0pAwPU5aNlVhqrZut5it8U0ycsjVZe2U7bnza
         RqeQ==
X-Gm-Message-State: AOJu0YxodH1/sxdNwAZC22Lrn93+1jJG/Jp1SDxXLHxUHdyrttCKxdHI
        cHeT03PuBEIDBV/stAUDJA5YS6el2WnusoeACcE0z51H4n2saPJzFfk=
X-Google-Smtp-Source: AGHT+IHKm6xOhbvVAKAE+SKogQZbnbEOCIh1XMXLgsfBvyvWuPOrr7N8DqDuN/nUXgGvHylRHerRg2cumFt/fm+7dMg=
X-Received: by 2002:a05:6512:3133:b0:4fd:d470:203b with SMTP id
 p19-20020a056512313300b004fdd470203bmr4350086lfd.69.1695306540696; Thu, 21
 Sep 2023 07:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org> <20230825112633.236607-4-ulf.hansson@linaro.org>
In-Reply-To: <20230825112633.236607-4-ulf.hansson@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 21 Sep 2023 16:28:43 +0200
Message-ID: <CAKohpo=qNen_D_8nKATwBJnN9frR3dmBtfajy3Gzw7QKfSRMjw@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] cpufreq: scmi: Prepare to move OF parsing of
 domain-id to cpufreq
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 at 13:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The OF parsing of the clock domain specifier seems to better belong in the
> scmi cpufreq driver, rather than being implemented behind the generic
> ->device_domain_id() perf protocol ops.
>
> To prepare to remove the ->device_domain_id() ops, let's implement the OF
> parsing in the scmi cpufreq driver instead.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - Re-based.
>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
