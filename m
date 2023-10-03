Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F887B6018
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbjJCEsa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 00:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJCEs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:48:29 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAFDA4;
        Mon,  2 Oct 2023 21:48:26 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-27752a1e184so357257a91.3;
        Mon, 02 Oct 2023 21:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696308505; x=1696913305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHjgW31Cb5JX+I43pXyDF3Bh+g0Rd3vo+Stu0+l1IzE=;
        b=vyDby3qmsaQugR9NXzsvtOo8haQgnyz0tjdKGeuugANVoGnvz6G2crObx8WnrkclHN
         bvR1CdMZ+7Tpk72ryr6mNyIxkxQFubvgCQAJgbhJ7/5u1zi26mJr9apOa9QY0pXYuPP0
         Ow/37Z01TQwBga455GGUnwAXRf5xu9JNptSB5z+MWAvLOk1qrcS35m8WB05nED/af/Dj
         oTJE1J+1h5r2QdrYir8c0/kLeSmABn1vzZFjs6KVK1Vkz5mu14heJdP1ULOiviYNwDNc
         GHQPTBys02UjkCvlE2+oCsCV4eM3tIGQ+m0OdRtA1FO+HxENBF/hbNcjfVifBuK0cIuD
         1dkA==
X-Gm-Message-State: AOJu0Yx1Rrz9BqoxRQkHfIQyAj/ACRYEv3EUDaSczu3nZ0pDxb8cKj0q
        QGJ/xhu3nxJW24ix/gJQ9yS/EXUZRUTRt6dxKnM=
X-Google-Smtp-Source: AGHT+IEV4t6wvfg22C/Cso+AWQw5qEu1JJCBuW+otkjfmIJCi4YdUqo3IdZaxvCHUAEuE7sA1po+pHhgXxotpSYaSOA=
X-Received: by 2002:a17:90a:68ce:b0:25e:a8ab:9157 with SMTP id
 q14-20020a17090a68ce00b0025ea8ab9157mr11756381pjj.22.1696308505450; Mon, 02
 Oct 2023 21:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230930072719.1267784-1-visitorckw@gmail.com>
In-Reply-To: <20230930072719.1267784-1-visitorckw@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 2 Oct 2023 21:48:14 -0700
Message-ID: <CAM9d7ciJZsCaVo6m_VtJ=QKNGAtBkAncidQjHzwexd3H8+3Usw@mail.gmail.com>
Subject: Re: [PATCH] perf hisi-ptt: Fix memory leak in lseek failure handling
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Hello,

On Sat, Sep 30, 2023 at 12:27 AM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> In the previous code, there was a memory leak issue where the previously
> allocated memory was not freed upon a failed lseek operation. This patch
> addresses the problem by releasing the old memory before returning -errno
> in case of a lseek failure. This ensures that memory is properly managed
> and avoids potential memory leaks.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/hisi-ptt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> index 45b614bb73bf..43bd1ca62d58 100644
> --- a/tools/perf/util/hisi-ptt.c
> +++ b/tools/perf/util/hisi-ptt.c
> @@ -108,8 +108,10 @@ static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
>                 data_offset = 0;
>         } else {
>                 data_offset = lseek(fd, 0, SEEK_CUR);
> -               if (data_offset == -1)
> +               if (data_offset == -1) {
> +                       free(data);
>                         return -errno;
> +               }
>         }
>
>         err = readn(fd, data, size);
> --
> 2.25.1
>
