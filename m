Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61F27830CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjHUTBm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 15:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjHUTBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:01:41 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552802B75;
        Mon, 21 Aug 2023 12:01:15 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-570c1364e5eso201159eaf.0;
        Mon, 21 Aug 2023 12:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692644435; x=1693249235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNp3AUDBDmRP8zOuyU6wAmgsOeKZml27ZjzCAYtUuro=;
        b=G2NE8y241AY1fLP+iUjzKWRhVHCrkBSzPsK0SsI/y6dLAvHtnHPy7pKt5GRt7s6zqk
         zfBBEhV0IcbxP0CHmggzNISRaVt4i8Evi++P/xFL68sWK/ac7gdehLgXeTRYG/Dmu4Oj
         8TvzOvnSmx8zk38efUzIe0vx40uzqhDy0dzA6qPeuZmanM6ozalexpJq2lzUD8ZlIo7o
         j0qqVpZJAFFvr7tSt+heID9iTb2NNyyYlFFxpn0kBkNA/fOMFx6yEDl0VC7Txf+0a7Jg
         9M294wkJdC87S0M1uMXnOwUbCIeLzfUknkQvV1nDzKZCxWc0Kj99apw6JWbTg+jqoLpk
         w8TQ==
X-Gm-Message-State: AOJu0YwN+Q+8KHXXgq9HrR8cfvuM7G/j7AB9wrsZKmn1/AlDECiWyRUu
        6IGdIUkFUK1MZw0Iuguk1sXmSFPQzkOuDsv8h/U=
X-Google-Smtp-Source: AGHT+IET7xDFhw0lhmuvHU7xZKLn/zR3KZrVO90fcqOdlfl5V5xtYbQUcJEQH5/vcBfsF0a5M20ZpVvtfknl+97axAw=
X-Received: by 2002:a4a:37c3:0:b0:570:cad0:fce9 with SMTP id
 r186-20020a4a37c3000000b00570cad0fce9mr3687062oor.1.1692644435445; Mon, 21
 Aug 2023 12:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230818095000.937633-1-liaochang1@huawei.com> <20230821091336.w4wcbvuarzxrvlkk@dhruva>
In-Reply-To: <20230821091336.w4wcbvuarzxrvlkk@dhruva>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 21:00:24 +0200
Message-ID: <CAJZ5v0iyLmT=V1rSehkSaO7Yzn0RG53vdBQ-+R0tM-HZg1xE-Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: stats: Improve the performance of cpufreq_stats_create_table()
To:     Dhruva Gole <d-gole@ti.com>, Liao Chang <liaochang1@huawei.com>
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
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

On Mon, Aug 21, 2023 at 11:14 AM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Aug 18, 2023 at 09:50:00 +0000, Liao Chang wrote:
> > In the worst case, the freq_table of policy data is not sorted and
> > contains duplicate frequencies, this means that it needs to iterate
> > through the entire freq_table of policy to ensure each frequency is
> > unique in the freq_table of stats data, this has a time complexity of
> > O(N^2), where N is the number of frequencies in the freq_table of
> > policy.
> >
> > However, if the policy.freq_table is already sorted and contains no
> > duplicate frequencices, it can reduce the time complexity of creating
>
> s/frequencices/frequencies?

I've fixed this when applying the patch.

> > stats.freq_table to O(N), the 'freq_table_sorted' field of policy data
> > can be used to indicate whether the policy.freq_table is sorted.
> >
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq_stats.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index 55c7ffd37d1c..fcb74050711a 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -243,7 +243,8 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
> >
> >       /* Find valid-unique entries */
> >       cpufreq_for_each_valid_entry(pos, policy->freq_table)
> > -             if (freq_table_get_index(stats, pos->frequency) == -1)
> > +             if ((policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) ||

I've also removed the redundant parens from this check.

>
> [...]
>
> Otherwise looks okay to me,
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Applied as 6.6 material (with the changes mentioned above), thanks!
