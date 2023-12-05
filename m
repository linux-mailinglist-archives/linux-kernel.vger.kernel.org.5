Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE99805DC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346149AbjLES0V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 13:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjLES0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:26:19 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B32AC;
        Tue,  5 Dec 2023 10:26:25 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2865742e256so3025338a91.0;
        Tue, 05 Dec 2023 10:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800785; x=1702405585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuC/v2sY9q+7BmsyoScER9HwtOgHqYFm9Mniu3xB+pE=;
        b=fI9RD+FN0ICx4LcM11uwEZK1rGLh5sWcJ4vomNNsxa9ghppC2lbzmrPnmeC/kV+AJW
         Y+uZ8sIsWJxt4CRpDwZ5N1AFvfg4AIZum1cyxYzpMMAroAhZYlCp3xHLqxEy8qEV40Zt
         nQjIHfovTUPwyzrVv753QWstyEJCmdN5fX+f0KXC4AoLE8b+w3XxjvhajGVzZSNIJ2kE
         6d9WjghYkXTtjjaCGVTgIFj4m680uNtUMrBWP556CXfXyM6TS5Oj7bVt8a1qNtM+JPS8
         VdnxIxT89Gq9jpD8yeqMvNtecL0l5zwcXvUiwgSzVo0pwZ6Wn9AoGNoQkOjODbxR9SG4
         cWtQ==
X-Gm-Message-State: AOJu0YwqCVry7a1F52YE6KiZEVp1ye807te7osJD7/zsgO55GppzfDL+
        rqhyhOzKPsepkOi4EAno4bSm27KTQqO7akRpUyI=
X-Google-Smtp-Source: AGHT+IGrutZXRZv9L+agGBJqSnJOcf+zoLdBUHMRmb18uXLyloUI+FGetLkmF9lx07o0sotKkRTw69XbKGEnKo0y6Vo=
X-Received: by 2002:a17:90b:17d2:b0:286:8672:51e4 with SMTP id
 me18-20020a17090b17d200b00286867251e4mr1264633pjb.16.1701800785123; Tue, 05
 Dec 2023 10:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-2-khuey@kylehuey.com>
 <CAEf4BzYtSXtgdO9C2w9OOKni68H-7UOExFJRBEij3HG2Qwn1Rg@mail.gmail.com>
 <ZW8Gi2QI5ceAJfab@krava> <CAM9d7chztaCfDsxfyJ2q_UmD=y20BFikCUQhs=LR8wsNV6pMjg@mail.gmail.com>
 <CANpmjNPfoLX=HPy0MhbGqMmGT4jE0Ky29cx5QP_8tJ2u=1ju_Q@mail.gmail.com>
In-Reply-To: <CANpmjNPfoLX=HPy0MhbGqMmGT4jE0Ky29cx5QP_8tJ2u=1ju_Q@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 5 Dec 2023 10:26:14 -0800
Message-ID: <CAM9d7cgDOUbSS1NLO8C13+hi0KBZwQxh7jvz9p=i0gNf0N0zrg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O signals.
To:     Marco Elver <elver@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kyle Huey <me@kylehuey.com>, Kyle Huey <khuey@kylehuey.com>,
        linux-kernel@vger.kernel.org,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 10:17 AM Marco Elver <elver@google.com> wrote:
>
> On Tue, 5 Dec 2023 at 19:07, Namhyung Kim <namhyung@kernel.org> wrote:
> > If we want to handle returning 0 from bpf as if the event didn't
> > happen, I think SIGTRAP and event_limit logic should be done
> > after the overflow handler depending on pending_kill or something.
>
> I'm not sure which kernel version this is for, but in recent kernels,
> the SIGTRAP logic was changed to no longer "abuse" event_limit, and
> uses its own "pending_sigtrap" + "pending_work" (on reschedule
> transitions).

Oh, I didn't mean SIGTRAP and event_limit together.
Maybe they have an issue separately.

Thanks,
Namhyung
