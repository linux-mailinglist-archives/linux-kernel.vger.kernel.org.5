Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F379EB28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbjIMObx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjIMObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2324CDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694615459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESzwCydIFjiNRdd0bOfzMWA1mjRG44ZNgNm8U9oO6+4=;
        b=LDRZG8+TH4Ngbz8dbxkI/7rQnlRDEyUfy9FxMfQ5/8AtYdh5Q9hnnMOdPAc4Vld44oRcpI
        FxMVUvykDgmFoNCh0SGpiI3acOWe6gKb3J9Bos98eGVXTl9deETmpuQ4OCfsv99cXuzZZe
        oCz/0HJ92nBQQ5/aMGarxequ58r4i7c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-lsqqA3udN5W6toLGO8Y12A-1; Wed, 13 Sep 2023 10:30:57 -0400
X-MC-Unique: lsqqA3udN5W6toLGO8Y12A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bcb47970eeso79015141fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694615456; x=1695220256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESzwCydIFjiNRdd0bOfzMWA1mjRG44ZNgNm8U9oO6+4=;
        b=GNwHyh1zDh3Nohh57u0D1twa5b2COLS+uLrMQFcJax/1TfQSM4ZgnLmzpQ1CifWu64
         Nc9kDuPpHNIIadFOhbHGL7FKdOE9Yf9dVjzpwXVDzWmP7rLioGX9p8eShwBjD4BM4G1X
         IUwe+GW/Xe1oVTsZZZXy0kQ/ZKJ+cX+k7QZJbeyXTIs9wYbFguhmybwd4kkTCYlHWao/
         9dbDqHYM84SX4gS7NNJsN+A/jPdvktZmDanJ6B8lkbQbDznq1EOuCPVdBz4AwPiz8xRu
         gnvxrLuGs158o/NUxy9BERKFrdFDwc8SjUbZxIbka65zzsCFqvP77ep40mZVuh52MkYg
         o8cg==
X-Gm-Message-State: AOJu0YzgGFk3wXEvygGzmNI5KTYAvt+wrhlfjfK69rR+4sleNJVR5i5o
        RTpUYOH4SBi4y5v28sM92s0i8rPRHfy5UuZFbQ8mGzSytO2GP/PFqb3NnCuHm95ze8qoyLffElb
        r+mk06MkqnmP5DUR6MIRYNBuydnwxZ2s6AaZUKZfX
X-Received: by 2002:a2e:300e:0:b0:2bc:de8d:4ab1 with SMTP id w14-20020a2e300e000000b002bcde8d4ab1mr2533698ljw.6.1694615456179;
        Wed, 13 Sep 2023 07:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErEehaSCj9lJQoT+HMjalVIqxubrWB6pY7sRstDZKBMzLj3mGIls8tvir2e0ztzoI4M3hyBwKMiouF83Ab2R8=
X-Received: by 2002:a2e:300e:0:b0:2bc:de8d:4ab1 with SMTP id
 w14-20020a2e300e000000b002bcde8d4ab1mr2533658ljw.6.1694615455860; Wed, 13 Sep
 2023 07:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230616115316.3652155-1-leitao@debian.org> <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZIxrxpYtffT0FtEx@gmail.com> <100041d0-f2fe-331b-13a7-ad09082aeb7d@gmail.com> <20230616153221.GI4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230616153221.GI4253@hirez.programming.kicks-ass.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Wed, 13 Sep 2023 16:30:44 +0200
Message-ID: <CAE4VaGBbKC+KgX-drhnc-nHsBo_DfcX4yZWBsNvrULiV3+Li1A@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Sandipan Das (AMD)" <sandipandas1990@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sandipan Das <sandipan.das@amd.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>, ananth.narayan@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandipan,

Is there any update on this issue? We have hit the issue, and it makes
the server pretty unusable due to the thousands of Call Traces being
logged.

Thanks a lot!
Jirka


On Fri, Jun 16, 2023 at 5:34=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Jun 16, 2023 at 08:13:22PM +0530, Sandipan Das (AMD) wrote:
> > The reserved bits should never be set. The purpose of the WARN_ON() is =
to catch such anomalies.
> > I am working out the details with Breno and will report back with a res=
olution.
>
> Thanks!
>


--=20
-Jirka

