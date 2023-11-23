Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A197F5679
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjKWCeW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 21:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjKWCeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:34:21 -0500
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2F191;
        Wed, 22 Nov 2023 18:34:27 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so287647a12.0;
        Wed, 22 Nov 2023 18:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700706867; x=1701311667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rMU5W4ernHWUIZiexvcWy6RAkAMVf7g6JwK9DSvkq8=;
        b=IgGAG7dQT2eHdQzWe9gL4lkpPVtzUZhGx1rnDn1v2E71lN7a7sMQHNrzjHM1oesraP
         LZHd97UqPWsDIxBT9XdKIE6GdUIjJEQLFDWYdWDmRmik4DjW1p7+52W2wSYptYUz1XP6
         3uSG+CT8jVNsNvlLVk2y3wwSpa+OKl21dci2XItYkWlua3T3zE+A+mz8k4AR1xJObKFN
         H/mt8SwD+boYKTbziovKW3BHC6Sj9nvp/uNkhNigXLCTQRVMKyE+s9dj1a77WOpP0lmO
         2zKTEcLaTEEA/BEo+Wzi1q70PyuBjq2IsvoCJJer5UaSt5HEL4tT/ohqZ+qffubC0NbL
         oANw==
X-Gm-Message-State: AOJu0Yz+a5OX8zDztCtl1zRpMHVetDoEx5Q6XVzsyKABnO/mpKtLDKPE
        Q40VDkQAmbmYFae41t2Hnp4m3fIeebjb51U32Ns=
X-Google-Smtp-Source: AGHT+IHrecamqJieCNDa+tP1BGplPdjr+BA56TwTZFtRCjEOuU3hvaQmduwk7ziIMJu6iGK1hTdkXMfHJ8XAHNuUL5o=
X-Received: by 2002:a05:6a20:1596:b0:18b:9b41:eb90 with SMTP id
 h22-20020a056a20159600b0018b9b41eb90mr376147pzj.10.1700706867104; Wed, 22 Nov
 2023 18:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20231122092703.3163191-1-tmricht@linux.ibm.com>
In-Reply-To: <20231122092703.3163191-1-tmricht@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Nov 2023 18:34:14 -0800
Message-ID: <CAM9d7cjoniVhpb=xK8WSN1C80y4D25Tjedax9AmwPf1w2FsKrA@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf report: remove warning on missing raw
 data for s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 22, 2023 at 1:27 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> Command
>  # ./perf report -i /tmp/111 -D > /dev/null
> emits an error message when a sample for event CRYPTO_ALL in the
> perf.data file does not contain any raw data. This is ok.
> Do not trigger this warning when the sample in the perf.data files
> does not contain any raw data at all.
> Check for availability of raw data for all events and return if
> none is available.
>
> Output before:
>  # ./perf report -i /tmp/111 -D > /dev/null
>  Invalid CRYPTO_ALL raw data encountered
>  Invalid CRYPTO_ALL raw data encountered
>  Invalid CRYPTO_ALL raw data encountered
>  #
>
> Output after:
>  # ./perf report -i /tmp/111 -D > /dev/null
>  #
>
> Fixes: b539deafbadb ("perf report: Add s390 raw data interpretation for PAI counters")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

> ---
>  tools/perf/util/s390-sample-raw.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
> index 29a744eeb71e..53383e97ec9d 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -51,8 +51,6 @@ static bool s390_cpumcfdg_testctr(struct perf_sample *sample)
>         struct cf_trailer_entry *te;
>         struct cf_ctrset_entry *cep, ce;
>
> -       if (!len)
> -               return false;
>         while (offset < len) {
>                 cep = (struct cf_ctrset_entry *)(buf + offset);
>                 ce.def = be16_to_cpu(cep->def);
> @@ -234,10 +232,9 @@ struct pai_data {          /* Event number and value */
>   */
>  static bool s390_pai_all_test(struct perf_sample *sample)
>  {
> -       unsigned char *buf = sample->raw_data;
>         size_t len = sample->raw_size;
>
> -       if (len < 0xa || !buf)
> +       if (len < 0xa)
>                 return false;
>         return true;
>  }
> @@ -299,6 +296,10 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
>         if (!evsel)
>                 return;
>
> +       /* Check for raw data in sample */
> +       if (!sample->raw_size || !sample->raw_data)
> +               return;

I was thinking it should check if evsel->attr.sample_type has
PERF_SAMPLE_RAW.  But evsel__parse_sample() sets the
sample->raw_data and ->raw_size only if it has the flag.
So I think it's fine.

Thanks,
Namhyung


> +
>         /* Display raw data on screen */
>         if (evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
>                 if (!evsel->pmu)
> --
> 2.41.0
>
>
