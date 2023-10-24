Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45C07D5C16
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbjJXUDv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbjJXUDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:03:50 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB6AA2;
        Tue, 24 Oct 2023 13:03:47 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-582a82e6d10so836835eaf.0;
        Tue, 24 Oct 2023 13:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177827; x=1698782627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+qX/4n2NMuSfs1CHSaW2MKgjMcRj85iCWbWik77oW8=;
        b=bTjT2pcYbn3TkG+fAsbQvPv9mK8U8HMGNb8kMeKQzMuH73pbQC34pBB3RFsSSmdHQ5
         8Ip43ec5kfGdf826HlaHRAwMCX+DyUmMb5sO9etmTA4f+VECtBBtNCm2cZcw3chNGpvd
         7jDVF3Ee3wjFN2BpOpyZ1yagXwCuEalL7fW9DdYRcirVCstUWRQxLzb32uVXiloaLZrs
         oTm4iylPBClwIodhNO/A/vKVc0nm2DBQCV1zrCF1TFSdMkq9zbdJeMlk/4TAd2I1iiKe
         EUpq6i1pTF2OFYDGU1lYHAYMSVt7NS8dbb6OAkIDtm42kwrOooLCsAEnINayN0k+mjX8
         8wwg==
X-Gm-Message-State: AOJu0YzWgMY+9TUSX7SFuYUxN++0QJ/3dVl8ZLmvFatp4Ve1MGyZ50iC
        spp0sPeQeZLRUehfGbjtGR74vLk93dyKYjlPY0E=
X-Google-Smtp-Source: AGHT+IGTJ4XYA9RffuYHKgZVvyF9k3cGpUTxYtE8tnD7+wkdDSCNSvdFhjEC2GY4hzYMdrWdiHBy9WXDvTsqeH01AEw=
X-Received: by 2002:a05:6870:9d98:b0:1e9:a8ff:67e3 with SMTP id
 pv24-20020a0568709d9800b001e9a8ff67e3mr16125655oab.4.1698177827121; Tue, 24
 Oct 2023 13:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231024183016.14648-1-ansuelsmth@gmail.com>
In-Reply-To: <20231024183016.14648-1-ansuelsmth@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Oct 2023 22:03:35 +0200
Message-ID: <CAJZ5v0gzV+nX+dSEShAopkcvx1Zx2Rc2=pjcdH07U9nQhHRe4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: fix broken buffer overflow detection in trans_stats
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Takashi Iwai <tiwai@suse.de>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 8:30 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Commit 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential
> buffer overflow") switched from snprintf to the more secure scnprintf
> but never updated the exit condition for PAGE_SIZE.
>
> As the commit say and as scnprintf document, what scnprintf returns what
> is actually written not counting the '\0' end char. This results in the
> case of len exceeding the size, len set to PAGE_SIZE - 1, as it can be
> written at max PAGESIZE - 1 (as '\0' is not counted)
>
> Because of len is never set to PAGE_SIZE, the function never break early,
> never print the warning and never return -EFBIG.
>
> Fix this by fixing the condition to PAGE_SIZE -1 to correctly trigger
> the error condition.
>
> Cc: stable@vger.kernel.org
> Fixes: 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential buffer overflow")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index a33df3c66c88..40a9ff18da06 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -131,23 +131,23 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>         len += sysfs_emit_at(buf, len, "   From  :    To\n");
>         len += sysfs_emit_at(buf, len, "         : ");
>         for (i = 0; i < stats->state_num; i++) {
> -               if (len >= PAGE_SIZE)
> +               if (len >= PAGE_SIZE - 1)
>                         break;
>                 len += sysfs_emit_at(buf, len, "%9u ", stats->freq_table[i]);
>         }
> -       if (len >= PAGE_SIZE)
> -               return PAGE_SIZE;
> +       if (len >= PAGE_SIZE - 1)
> +               return PAGE_SIZE - 1;
>
>         len += sysfs_emit_at(buf, len, "\n");
>
>         for (i = 0; i < stats->state_num; i++) {
> -               if (len >= PAGE_SIZE)
> +               if (len >= PAGE_SIZE - 1)
>                         break;
>
>                 len += sysfs_emit_at(buf, len, "%9u: ", stats->freq_table[i]);
>
>                 for (j = 0; j < stats->state_num; j++) {
> -                       if (len >= PAGE_SIZE)
> +                       if (len >= PAGE_SIZE - 1)
>                                 break;
>
>                         if (pending)
> @@ -157,12 +157,12 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>
>                         len += sysfs_emit_at(buf, len, "%9u ", count);
>                 }
> -               if (len >= PAGE_SIZE)
> +               if (len >= PAGE_SIZE - 1)
>                         break;
>                 len += sysfs_emit_at(buf, len, "\n");
>         }
>
> -       if (len >= PAGE_SIZE) {
> +       if (len >= PAGE_SIZE - 1) {
>                 pr_warn_once("cpufreq transition table exceeds PAGE_SIZE. Disabling\n");
>                 return -EFBIG;
>         }
> --

Applied (with some edits in the subject and changelog) as 6.7 material, thanks!
