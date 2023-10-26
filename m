Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171977D81BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbjJZLWR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 07:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344799AbjJZLWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:22:16 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E995C1B3;
        Thu, 26 Oct 2023 04:22:13 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-57f137dffa5so125015eaf.1;
        Thu, 26 Oct 2023 04:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698319333; x=1698924133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZnbvMK9HIuGTN1h7lEDqvF75KbGWgtR8jRiUFqocC8=;
        b=ftu06cPjXWTHLrx2v5bmKtfZBSt/mWKlpQsAjZXtcyzo7xZqYi6tagdsEpxWr6AUdU
         N0hB5fqoFlss89a4NJQHw3VnltH+i43tRaZ3ZYYycVd1MQqlEcJ7IENwxU5Y7uaymkKn
         i0RFtLzR/pQn//g13RwrjzBGDTfQv7luToooQoqOikmGM6Sp0AcgpNoPPgju2sKrDgOT
         jBJ9lq3hROK8gNoNrPJioJnSctiLUH4NW/+ncyS4LNkgea6L/dAVu7dv95wGfe9ytM8t
         xNlygQWHXfJdAKYYc7qAi5nHHlrr69w+YtvPhpjlt1Qv+vdk28wp/TmYp8UX526dsmvH
         ziwQ==
X-Gm-Message-State: AOJu0YyIJn+cwhsaP4gvyphSoPDOa52Xtn4bWTP06TfSyDv7DVsLa+Fm
        wpDMWNMzowHPVuVkFrN6bPBxTPuaJyGtr0uRzcw=
X-Google-Smtp-Source: AGHT+IEhqrIW1khjvKdbr/1gJOkkek1GTqqAqzEnKkzfTeWzjted4PqUG+fexpsmyUrUVVf6napRvXPIOAX3QRKMzpI=
X-Received: by 2002:a4a:ea91:0:b0:584:17d0:de3d with SMTP id
 r17-20020a4aea91000000b0058417d0de3dmr19034787ooh.1.1698319333161; Thu, 26
 Oct 2023 04:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231024183016.14648-1-ansuelsmth@gmail.com> <CAJZ5v0gzV+nX+dSEShAopkcvx1Zx2Rc2=pjcdH07U9nQhHRe4Q@mail.gmail.com>
 <653a4540.050a0220.1e832.01c8@mx.google.com>
In-Reply-To: <653a4540.050a0220.1e832.01c8@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Oct 2023 13:22:01 +0200
Message-ID: <CAJZ5v0jXAnZx=EtVSHQAUPChGUwgL0eGBrztXNJ99XzOXPH4TA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:54 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Tue, Oct 24, 2023 at 10:03:35PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 24, 2023 at 8:30 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > Commit 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential
> > > buffer overflow") switched from snprintf to the more secure scnprintf
> > > but never updated the exit condition for PAGE_SIZE.
> > >
> > > As the commit say and as scnprintf document, what scnprintf returns what
> > > is actually written not counting the '\0' end char. This results in the
> > > case of len exceeding the size, len set to PAGE_SIZE - 1, as it can be
> > > written at max PAGESIZE - 1 (as '\0' is not counted)
> > >
> > > Because of len is never set to PAGE_SIZE, the function never break early,
> > > never print the warning and never return -EFBIG.
> > >
> > > Fix this by fixing the condition to PAGE_SIZE -1 to correctly trigger
> > > the error condition.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential buffer overflow")
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/cpufreq/cpufreq_stats.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > > index a33df3c66c88..40a9ff18da06 100644
> > > --- a/drivers/cpufreq/cpufreq_stats.c
> > > +++ b/drivers/cpufreq/cpufreq_stats.c
> > > @@ -131,23 +131,23 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> > >         len += sysfs_emit_at(buf, len, "   From  :    To\n");
> > >         len += sysfs_emit_at(buf, len, "         : ");
> > >         for (i = 0; i < stats->state_num; i++) {
> > > -               if (len >= PAGE_SIZE)
> > > +               if (len >= PAGE_SIZE - 1)
> > >                         break;
> > >                 len += sysfs_emit_at(buf, len, "%9u ", stats->freq_table[i]);
> > >         }
> > > -       if (len >= PAGE_SIZE)
> > > -               return PAGE_SIZE;
> > > +       if (len >= PAGE_SIZE - 1)
> > > +               return PAGE_SIZE - 1;
> > >
> > >         len += sysfs_emit_at(buf, len, "\n");
> > >
> > >         for (i = 0; i < stats->state_num; i++) {
> > > -               if (len >= PAGE_SIZE)
> > > +               if (len >= PAGE_SIZE - 1)
> > >                         break;
> > >
> > >                 len += sysfs_emit_at(buf, len, "%9u: ", stats->freq_table[i]);
> > >
> > >                 for (j = 0; j < stats->state_num; j++) {
> > > -                       if (len >= PAGE_SIZE)
> > > +                       if (len >= PAGE_SIZE - 1)
> > >                                 break;
> > >
> > >                         if (pending)
> > > @@ -157,12 +157,12 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> > >
> > >                         len += sysfs_emit_at(buf, len, "%9u ", count);
> > >                 }
> > > -               if (len >= PAGE_SIZE)
> > > +               if (len >= PAGE_SIZE - 1)
> > >                         break;
> > >                 len += sysfs_emit_at(buf, len, "\n");
> > >         }
> > >
> > > -       if (len >= PAGE_SIZE) {
> > > +       if (len >= PAGE_SIZE - 1) {
> > >                 pr_warn_once("cpufreq transition table exceeds PAGE_SIZE. Disabling\n");
> > >                 return -EFBIG;
> > >         }
> > > --
> >
> > Applied (with some edits in the subject and changelog) as 6.7 material, thanks!
>
> Hi, I just notice this landed in linux-next but I can't find the devfreq
> change. Only the cpufreq patch has been taken and the devfreq ones are
> still pending?

That's correct AFAICS.  I've only picked up the cpufreq change.
