Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9005379ECBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbjIMPZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbjIMPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 716FC1BCF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694618626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6btF7jJHvJ5nazNvFazgRuPuQkHoGVsIsn58np1PaQ=;
        b=F0IeCOvJ6DQM4P00TFMPm4rCp6BB20pCAO1ohr1Kb+Y+1FM4SfW0Wv2za0hli1O7Y0ZHp5
        hTXkfZLTxUCFFR/ZuQMXfz7ZWiWH87vzH6lmF3G6Ylqc7DpAsT98NJ6XlI2Ce3cjOqU2cS
        KtTbzYu5yy/IHo65uWfdiGTgEKH8b+E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-9mPfTZ6zNbaSDbrp5PCffw-1; Wed, 13 Sep 2023 11:23:45 -0400
X-MC-Unique: 9mPfTZ6zNbaSDbrp5PCffw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bcc4347d48so78674321fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618623; x=1695223423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6btF7jJHvJ5nazNvFazgRuPuQkHoGVsIsn58np1PaQ=;
        b=dEGYDCIZ5VjlPKQcXGv72UW/kBC/kgG6pttw4uEXfeA/g9csaqOThmSEScgfdegPon
         gdZ0h7beTQx/LlE0z6xC4YsiOIIocQTKGBQjHtEHE54eur5OysMmrinhCAJFN0yKrPGY
         zQkeVDsJ/t0NVTUwjshlFOCnaXjU0rKldcQwVXV65EXUooe0dSakGv41XzL43eizgDK+
         odP6ztgOFc7B+37avi4VHakiZ2utXEYVc+Lucs9D9ftYCl4LceTvjjquuatjzxUpT8nq
         XMHIu+hL9OVVvAtE3LIvGIB/OUIPktH1TCR3n6u6DkL1Dxo95F8N1rg2RmJbuY8khCJi
         c84Q==
X-Gm-Message-State: AOJu0Yx6EOtghZZUL3x/su25/jBfMDXcT72JG6qC/mz6ABpW+Martx5p
        p5xXkHiyq/0F5gcK5P9zPSPhmkcKbJx/CKwlQD4GPOJx23Ten22Eow2PbN3Owe3gASYhI1kgjcH
        fGF5NydV6R9sGHls9VbP/ftL2QrgaGwLHwdxQJBaJ
X-Received: by 2002:a2e:9048:0:b0:2b6:de52:357 with SMTP id n8-20020a2e9048000000b002b6de520357mr2364211ljg.40.1694618623773;
        Wed, 13 Sep 2023 08:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGYQUc8YHKBZJHT0iIfp2zCCzZ5ZiAzmvsWYDqpHQfY88hTo6Yz4Iv5TjnN7ArDS5Ep0EYTMhi6JwPWPsW274=
X-Received: by 2002:a2e:9048:0:b0:2b6:de52:357 with SMTP id
 n8-20020a2e9048000000b002b6de520357mr2364199ljg.40.1694618623461; Wed, 13 Sep
 2023 08:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230616115316.3652155-1-leitao@debian.org> <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZIxrxpYtffT0FtEx@gmail.com> <100041d0-f2fe-331b-13a7-ad09082aeb7d@gmail.com>
 <20230616153221.GI4253@hirez.programming.kicks-ass.net> <CAE4VaGBbKC+KgX-drhnc-nHsBo_DfcX4yZWBsNvrULiV3+Li1A@mail.gmail.com>
 <ZQHPPfseA/k6tNd3@gmail.com>
In-Reply-To: <ZQHPPfseA/k6tNd3@gmail.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Wed, 13 Sep 2023 17:23:32 +0200
Message-ID: <CAE4VaGCDVBRgsgv8VbOscD=AqsBGK+tRQG5_3roWz3-gYaZX9Q@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
To:     Breno Leitao <leitao@debian.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Sandipan Das (AMD)" <sandipandas1990@gmail.com>,
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

I agree.

Are you planning v2 of the patch, addressing the points raised by
Peter Zijlstra?

On Wed, Sep 13, 2023 at 5:03=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Wed, Sep 13, 2023 at 04:30:44PM +0200, Jirka Hladky wrote:
> > Hi Sandipan,
> >
> > Is there any update on this issue?
>
> I still think we want to have this patch in Linux, so, we protect the
> kernel for whatever the hardware/firmware is doing.
>


--=20
-Jirka

