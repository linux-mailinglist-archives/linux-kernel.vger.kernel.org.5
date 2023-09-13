Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0AA79EBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbjIMPDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbjIMPDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:03:34 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66C0AF;
        Wed, 13 Sep 2023 08:03:29 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso233122266b.1;
        Wed, 13 Sep 2023 08:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694617408; x=1695222208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DGxdYRxvRjTabbtc+N83CBxI2VrA2GYiiG24Y1MUKg=;
        b=XiXgI2bw0RTJMAIkBOjL2F98tLqLSNDlK+3MJLXBjipB4naJIpzMrXc/VWHAhUoNin
         O1Acl1ZCzEc3L292Shhgks9sO1NHpqVPkk2G5+b/DihTakySvmT1PaUh0t6iKPccHg3J
         Sx7tcr5mESyBNd45ga4thDk9jTtLpt+b83dHETwTXWqya7aaUvByPQ1k8yT8+q7CpA4S
         PscxVGWstfFZ7Xs6nQzy8Jy0cn3ozNQJaIkSZ+QK7Xeusot1H8nQog261KutincXAy6R
         +qGLGlP4ZRu/zUXpJaFzGc0uasMgoyk0cekdu62/N/GZqmEf1Y/IPAa5oz/W8mPE2x/h
         P3ww==
X-Gm-Message-State: AOJu0YzeotRGnomGvLxG2Y5TFqSK0gdKKorwb5J29HxqZFFYdSr6EpH0
        0shpsbCp+XGxdXlvYAgxn/U=
X-Google-Smtp-Source: AGHT+IGdWvoiZcWMidvIVOOT5cAOV5q2s3hX3OOGyjq7jj8bmhx8ySzum/+Lt4pX4zNanURTFjsROA==
X-Received: by 2002:a17:906:8251:b0:9a2:2841:7904 with SMTP id f17-20020a170906825100b009a228417904mr2372447ejx.28.1694617408180;
        Wed, 13 Sep 2023 08:03:28 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906349500b00997e00e78e6sm8638137ejb.112.2023.09.13.08.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:03:27 -0700 (PDT)
Date:   Wed, 13 Sep 2023 08:03:25 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Jirka Hladky <jhladky@redhat.com>
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
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Message-ID: <ZQHPPfseA/k6tNd3@gmail.com>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZIxrxpYtffT0FtEx@gmail.com>
 <100041d0-f2fe-331b-13a7-ad09082aeb7d@gmail.com>
 <20230616153221.GI4253@hirez.programming.kicks-ass.net>
 <CAE4VaGBbKC+KgX-drhnc-nHsBo_DfcX4yZWBsNvrULiV3+Li1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE4VaGBbKC+KgX-drhnc-nHsBo_DfcX4yZWBsNvrULiV3+Li1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:30:44PM +0200, Jirka Hladky wrote:
> Hi Sandipan,
> 
> Is there any update on this issue?

I still think we want to have this patch in Linux, so, we protect the
kernel for whatever the hardware/firmware is doing.
