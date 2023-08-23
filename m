Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B932784EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjHWCiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjHWCit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:38:49 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F16BE4E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:38:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bdc27e00a1so520347a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692758326; x=1693363126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTuoNAPJjhEfJo2OfKuB84Fta+CXlvmq3TsH4v0Gc3g=;
        b=jyddBpA6JF26tJElQM9u56fmP7n8yWWcXgzfN5Thy8dDv+owhfZa1KkDLVu2fycyF0
         PEqSfqxoFUa8npK0jl2U0vF6NaC4rDusoXZFImuIw5m1S2EokaY38+a4LbpzYCEfD6w4
         arE2N/NQlSdBHW6P85jX8+G64byXCcHiMmI26IgemCS63nrpcIKKbg/dxxAgPWOK0H1y
         0GkSuc/UxgOuJRJGw0jH79dqqDmzESN8DSRTd+Tq5aFgdsUb6IhXaU5/Wsnq3qAIYY9d
         Y/RiI+iTfofSF44eT1866KFDqzwenU/5ervB/1czBJF0+WNnUku5eiMoR46vDIj7CQHX
         kn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692758326; x=1693363126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTuoNAPJjhEfJo2OfKuB84Fta+CXlvmq3TsH4v0Gc3g=;
        b=LGOjrvKdgkSgvncb+YpCMPCC9jQ33dLR0y8JwCsNc/Jw676AG/3BG7s1VZD62/iabc
         6sxhe2Ix9k7JoY/lh5XivtRpcjR1Zs2Ex4qPE8ABS+etslFy2f7zVCHosG+fgyC26uSJ
         ryAQSQCkJFM1eUfocGx7GcJaCm9vUhxwwl4LObjpPwSrDpCCn6eOr5C7ng8Kd8OtRcIZ
         OPO4a/Fcw+S63VKd2p6E5T+7i8CDr68xLKlE8xZbjFwvpmeioqdA8W0qsR7Cv+FphsBv
         tRmGizxaQkEaklh9wPp9kWMmioDyXZv82TyMEXPjEI2qO9W5OXpEP8K4EjhrHIb1s935
         si2w==
X-Gm-Message-State: AOJu0YwQAiRV0ebQZy78dC/i7HBEwBKsFAUnf2aYdRKrSNU4uzq/553m
        ahnjNB7k9yUi4gUhB3Q9j9fRrQ==
X-Google-Smtp-Source: AGHT+IGAdnKYLSqSf7A7lfSdx8pKYq98ovZ5cGgI4uVrvPU+aL9l1OQxSIoesF3LdJdnmRB5C0GKdQ==
X-Received: by 2002:a9d:694e:0:b0:6b9:5734:135f with SMTP id p14-20020a9d694e000000b006b95734135fmr12642626oto.28.1692758325869;
        Tue, 22 Aug 2023 19:38:45 -0700 (PDT)
Received: from leoy-huanghe.lan ([94.177.131.100])
        by smtp.gmail.com with ESMTPSA id y8-20020a63b508000000b0056a36ac322dsm5837038pge.4.2023.08.22.19.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 19:38:45 -0700 (PDT)
Date:   Wed, 23 Aug 2023 10:38:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6] Documentation: userspace-api: Document perf ring
 buffer mechanism
Message-ID: <20230823023838.GF57731@leoy-huanghe.lan>
References: <20230819093340.265817-1-leo.yan@linaro.org>
 <CAM9d7cj=ichFk4bVQSbyptqy9wo8GFm1Z1Q7QzfhMFLjewNF-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj=ichFk4bVQSbyptqy9wo8GFm1Z1Q7QzfhMFLjewNF-Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Tue, Aug 22, 2023 at 05:43:25PM -0700, Namhyung Kim wrote:

[...]

> > +2.3.2 Writing samples into buffer
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Ring buffers are mapped as read-write mode or read-only mode, which is
> > +used for a normal ring buffer and an overwritable ring buffer
> > +respectively.
> > +
> > +The ring buffer in the read-write mode is mapped with the property
> > +``PROT_READ | PROT_WRITE``.  With the write permission, the perf tool
> > +updates the ``data_tail`` to indicate the data start position.  Combining
> > +with the head pointer ``data_head``, which works as the end position of
> > +the current data, the perf tool can easily know where read out the data
> > +from.
> > +
> > +Alternatively, in the read-only mode, only the kernel keeps to update
> > +the ``data_head`` while the user space cannot access the ``data_tail`` due
> > +to the mapping property ``PROT_READ``.
> > +
> > +Why ring buffers are mapped with above two different modes?  Here the
> > +write direction matters.  The forward writing starts to save data from
> > +the beginning of the ring buffer and wrap around when overflow, which is
> > +used with the read-write mode in the normal ring buffer.  When the
> > +consumer doesn't keep up with the producer, it would lose some data, the
> > +kernel keeps how many records it lost and generates the
> > +``PERF_RECORD_LOST`` records in the next time when it finds a space in the
> > +ring buffer.
> 
> Thanks for the update.  It's unclear to me if all 4 combination of
> (rw, ro) x (fwd, bwd) are possible (yes!).  The rw mode and back-
> ward is also possible but just not used for perf tool.

I can add a matrix for the combinations:

  The combination is supported in perf tool:

  ---+------------+-----------
     |  Forward   | Backward
  ---+------------+-----------
  rw |  Yes       |   No
  ---+------------+-----------
  ro |  X         |   Yes
  ---+------------+-----------

  Yes: is supported
  No: is not supported
  X: is not feasible

> And I think the description below in this section shows kernel
> internals too much.  Name of kernel functions and data structure
> is not an API and can be changed any time.  You can describe
> the logic without the names.

Understand, I agree this will introduce maintenance efforts in later.

I will refine the description and send a new patch.

Thanks for reviewing!

Leo
