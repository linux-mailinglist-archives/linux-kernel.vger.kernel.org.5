Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0376D5D9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjHBRqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjHBRqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:46:16 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A67198B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:46:00 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so25531cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690998360; x=1691603160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRnB3SQFPEO+lQ4tIkO8yJNmnXET3SUA7+GoOMMOJYE=;
        b=Q5jhLbhtUDjUgTY4iJro3YZPZZK3Qk6PnsZp1zN+y+IwuLp9nygqAr2FWHqQkFZQhp
         Pu5q+Q7Co+7sjMDJXgn75YwWSnrWKeZlEKC6FnQrDffgi/Vc4sfReC/z7CpcB/ySHRK6
         AQYR9+Pe7EaZAhx3EWPHAApcZ9plHHpM9LT3vWTdZQAN7GQ2RpqJKriagf/e/U6OCay3
         SxFaVPLMCr79/eQFRmYCuFQL55PjGt3C51DhouaVfxNq9mbjV3pmY+c2vGIK5ptwpO+U
         MCMB5jL8kKQurKGoO3PVTySgqRFKDc7YgpJiyDSHwPqPuCiIH1AAFYOPRI0hQCzbvERr
         R2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690998360; x=1691603160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRnB3SQFPEO+lQ4tIkO8yJNmnXET3SUA7+GoOMMOJYE=;
        b=OnuvhbIkOcSMwIYOp4m3nOPqqwUzLKXMJSKd8Fq9JkV9vNvA0eh7nFTKuWdY4uQcVD
         MX5e/M910FUUKSRImdoYLWqB8eh1V73gCEf8+4pVcWtuwezAFfLQm9E7TTQHXo8CgwPH
         Dxu7Op3Td6mGI2gaXhV+5pmqhrk8oRr+FeV+FDNbBlskhEOKxH9uDGScguA8sQBPDFsA
         5Lotc7cVBNcjtTib4UtUZbupQnrkY4yEKuppB6YjM0FbJw6ZLMD4mPymGLnjP9dM9x52
         wAJy1yD6T4Sl6ZTIa0vG0aE/963MMdzty6FK2VrVwADcFfDK0q2/sf8UbihRBfwei/so
         NENQ==
X-Gm-Message-State: ABy/qLbVIXYqb2MknDTb7h+zmOBCTtXqcWNaLNC/VWC8L/mxqKTxlMUW
        NLDzWL5Cdhv5weJjXAVZBdwb42TQAWE1JRpSuVEK2w==
X-Google-Smtp-Source: APBJJlHSAEAPCDqvxmmhWFmFCxIZY73VuHevIxhoFQ8dCGTGp8WvT1cxhcp/eFUAyfWZzDrzlPle8NxzLMDkEI8Y8XE=
X-Received: by 2002:a05:622a:3c6:b0:403:aa88:cf7e with SMTP id
 k6-20020a05622a03c600b00403aa88cf7emr1227934qtx.29.1690998359911; Wed, 02 Aug
 2023 10:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <F762DED397BFDFD1+20230802040315.106038-2-ye@kaige.org>
In-Reply-To: <F762DED397BFDFD1+20230802040315.106038-2-ye@kaige.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Aug 2023 10:45:47 -0700
Message-ID: <CAP-5=fVTra0onRPsVq2guBkGhvuw7yvXNtjFJ5Eom9wrFZtsxA@mail.gmail.com>
Subject: Re: [PATCH] perf stat-display: Check if snprintf()'s fmt argument is NULL
To:     Kaige Ye <ye@kaige.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 9:04=E2=80=AFPM Kaige Ye <ye@kaige.org> wrote:
>
> It is undefined behavior to pass NULL as snprintf()'s fmt argument.
> Here is an example to trigger the problem:
>
>   $ perf stat --metric-only -x, -e instructions -- sleep 1
>   insn per cycle,
>   Segmentation fault (core dumped)
>
> With this patch:
>
>   $ perf stat --metric-only -x, -e instructions -- sleep 1
>   insn per cycle,
>   ,
>
> Signed-off-by: Kaige Ye <ye@kaige.org>
> ---
>  tools/perf/util/stat-display.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 7329b3340..e8936cffd 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -438,7 +438,7 @@ static void print_metric_csv(struct perf_stat_config =
*config __maybe_unused,
>                 fprintf(out, "%s%s", config->csv_sep, config->csv_sep);
>                 return;
>         }
> -       snprintf(buf, sizeof(buf), fmt, val);
> +       snprintf(buf, sizeof(buf), fmt ?: "", val);

Hi,

I couldn't reproduce this error and the code immediately above here
does null check fmt:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat-display.c?h=3Dperf-tools-next#n437
Perhaps this is an older version of the perf tool? You can run "perf
version" to determine this.

Thanks,
Ian


>         ends =3D vals =3D skip_spaces(buf);
>         while (isdigit(*ends) || *ends =3D=3D '.')
>                 ends++;
> @@ -578,7 +578,7 @@ static void print_metric_only_csv(struct perf_stat_co=
nfig *config __maybe_unused
>         if (!valid_only_metric(unit))
>                 return;
>         unit =3D fixunit(tbuf, os->evsel, unit);
> -       snprintf(buf, sizeof buf, fmt, val);
> +       snprintf(buf, sizeof(buf), fmt ?: "", val);
>         ends =3D vals =3D skip_spaces(buf);
>         while (isdigit(*ends) || *ends =3D=3D '.')
>                 ends++;
> @@ -600,7 +600,7 @@ static void print_metric_only_json(struct perf_stat_c=
onfig *config __maybe_unuse
>         if (!valid_only_metric(unit))
>                 return;
>         unit =3D fixunit(tbuf, os->evsel, unit);
> -       snprintf(buf, sizeof(buf), fmt, val);
> +       snprintf(buf, sizeof(buf), fmt ?: "", val);
>         ends =3D vals =3D skip_spaces(buf);
>         while (isdigit(*ends) || *ends =3D=3D '.')
>                 ends++;
> --
> 2.41.0
>
