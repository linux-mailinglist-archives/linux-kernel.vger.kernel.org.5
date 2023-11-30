Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBB57FE468
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjK3ABt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 19:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK3ABr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:01:47 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACA412F;
        Wed, 29 Nov 2023 16:01:53 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d001e4cf7cso3710995ad.2;
        Wed, 29 Nov 2023 16:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701302513; x=1701907313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3As+H3ba0cBEdpLgXC4M2L7j366iPfI/nKdLUEgmlU=;
        b=nqFU+2O5JNxryODpf7vQd8jhR9Y6zIDDY2XSXLdwVAt4jaQnuWwNQBxL2klplqarVW
         TdwW8s3ekyM6YVTNwxyGZd4a4b0iqUEjDhlo08IUqL92X5W9mCEx1nDrylTRDOIWJmHP
         59yfyTxRqTFVGGByHIVj38gQnGT1o1eA0m5a1TZrUt9CLa2HPwY2PzT1z/WyTBu0uiHr
         7B9Ks+/mSQAjGuPYX2vN04rCzodaFAnkBzhtlD77AGNyxJPPXYtqTeuz/+/CwmICT4yp
         lCZmsKzHuIWDgj54l5t2Tk+DhIR7SnDcVFvPKJe3+CUD4znqd9ZIoRln/EJFdd5CRy8j
         Wiig==
X-Gm-Message-State: AOJu0Yz/f8bRuoSa4CT/9/mSszO+k9KrkPsIwegz8Mil3Y4OdM9un+0a
        8LnBaGzY4eWqPCBbgji8y/4elS+Hq2fitlC5RSxEVta2Uwc=
X-Google-Smtp-Source: AGHT+IEc4tL3VRN6B47qi922MCt9p4QJOtKNJyJQi9ansNVakoZdDGjvhkxqK9FNDFb25GOPZrUzwv8Z4j4KTEY1NAk=
X-Received: by 2002:a17:902:ee95:b0:1cc:6dd5:59e8 with SMTP id
 a21-20020a170902ee9500b001cc6dd559e8mr17932368pld.26.1701302513109; Wed, 29
 Nov 2023 16:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <20231128175441.721579-7-namhyung@kernel.org>
 <CAP-5=fW3f_96=rWeYg-qpL2T9VjLKnqnmq8T4dvaixWEo-0NRA@mail.gmail.com>
In-Reply-To: <CAP-5=fW3f_96=rWeYg-qpL2T9VjLKnqnmq8T4dvaixWEo-0NRA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 16:01:41 -0800
Message-ID: <CAM9d7cgw+A1nxSqA+fcSiBH972gF-yRNTiadQwZDvJXTGre6=w@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf annotate: Ensure init/exit for global options
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 11:21 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Nov 28, 2023 at 9:54 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Now it only cares about the global options so it can just handle it
> > without the argument.
>
> If annotate_opts were accessed by a function then you could
> pthread_once the initialization on the first call to get
> annotate_opts. Removing annotation_options__init/exit would remove
> some potential for error.

Currently all call sites (perf annotate, report and top) initialize the
options and check if it has conflicting options before running the
commands.  So I'm not sure if it needs pthread_once() for that.

Thanks,
Namhyung
