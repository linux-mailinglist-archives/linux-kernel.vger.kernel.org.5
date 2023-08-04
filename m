Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C348876FCF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjHDJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:13:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906F36A7E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:10:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686b879f605so1330356b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691140233; x=1691745033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIgVcI/DAV+syZCzOifgnr1978K5ZgzsoAA4MZTsdr8=;
        b=gfsJb+lP9iAhBqFb5nmJR6SFpsVvn9z6Qoa51edQoEd6CqKZdUnmyFX+sXP7iaW0Wn
         aTqtp/hlkscVLQGHgh7Rou5pcYN3z9T1dJ8USTpCMhj1hSAKSiM2x1bFdiu9T90IiwHi
         a/8ABoUc/gyiOntvYldRd82s9cLH4+JwXGlce7bknV93L0ruhwipZLpRuA3W5AP02aj4
         0FuH1qObKYzEc0IBBqas8YjEBr1BtU6+dc170qqINX5kJhlP5wggAjyDbggxK3b8gG/7
         aUebgtHN7zEKzom7WkL45iuRRh//yiq6zJzjR+zg64QQB211uhgWG6Z1oC17YUkIwUBS
         6AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140233; x=1691745033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIgVcI/DAV+syZCzOifgnr1978K5ZgzsoAA4MZTsdr8=;
        b=UeDYZ5OEVG4ougAzUaLvor2QShTCZOAE2tn6FYWSr9firrYOU3d9s2bQgcZabFrDk2
         MqSBiIdD6iZ1JHa/n2cXGnWQ/iAAuS94Q0MsbBj66aQrPWr+5ryLynDPJohOaTafgDN3
         m9IEuiGd4N+EUxRVCQQOmD3v4YDx246ULMdhBCQKQI68dMIyHuZ5SmZs/zlZLlSjJAIE
         xiV/04qT/DXJnjUsuTi6d+uxS8k5pd59mMdSFk877EBjXjSHbrU4cUTKqM0IU+ml2wVr
         IEKMgZI9HpVrGwLL1UEramhvda2k7OCneP6deSHaeBuG9MdQe10B0ePK7wX499lqSPsO
         JF6w==
X-Gm-Message-State: AOJu0YwWuRyJbWqIfJBNKRuRP+5vbTPwKJLRMNwq9XqYK63+esP4IEMV
        efTp8a3sC+VFnAkvpg62h0FowQ==
X-Google-Smtp-Source: AGHT+IGQTzI2vosQeS/05F0bAnTIYQcz2dkP7E+eYl2x2kSGbAeqf2u97F51YVcj5qeB9WSEEZid6Q==
X-Received: by 2002:a05:6a20:3d82:b0:12b:1686:3012 with SMTP id s2-20020a056a203d8200b0012b16863012mr986031pzi.3.1691140233508;
        Fri, 04 Aug 2023 02:10:33 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902ea9300b001b1c4d875f5sm1254478plb.44.2023.08.04.02.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:10:33 -0700 (PDT)
Date:   Fri, 4 Aug 2023 17:10:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf doc: Document ring buffer mechanism
Message-ID: <20230804091027.GC589820@leoy-yangtze.lan>
References: <20230803035037.1750340-1-leo.yan@linaro.org>
 <87v8dw6vp1.fsf@meer.lwn.net>
 <20230803165636.GB1783639@leoy-huanghe.lan>
 <ZMwTyVKPn0cRewEc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMwTyVKPn0cRewEc@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 05:53:29PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 04, 2023 at 12:56:36AM +0800, Leo Yan escreveu:
> > Hi Jon,
> > 
> > On Thu, Aug 03, 2023 at 08:34:50AM -0600, Jonathan Corbet wrote:
> > > Leo Yan <leo.yan@linaro.org> writes:
> > > 
> > > > In the Linux perf tool, the ring buffer serves not only as a medium for
> > > > transferring PMU event data but also as a vital mechanism for hardware
> > > > tracing using technologies like Intel PT and Arm CoreSight, etc.
> > > >
> > > > Consequently, the ring buffer mechanism plays a crucial role by ensuring
> > > > high throughput for data transfer between the kernel and user space
> > > > while avoiding excessive overhead caused by the ring buffer itself.
> > > >
> > > > This commit documents the ring buffer mechanism in detail.  It provides
> > > > an in-depth explanation of the implementation of both the generic ring
> > > > buffer and the AUX ring buffer.  Additionally, it covers how these ring
> > > > buffers support various tracing modes and explains the synchronization
> > > > with memory barriers.
> > > >
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > ---
> > > 
> > > So this seems like good material from a very brief scan.  I do have to
> > > ask, though: why is it not in RST, and why not put it into the
> > > user-space API book?
> > 
> > This documentation is Perf related topic, so my instinct is to place
> > it into the folder tools/perf/Documentation/.
> > 
> > Strictly to say, the doc doesn't give formal introduction for the
> > user-space APIs.  Given perf ring buffer is a mechanism for exchanging
> > data between the kernel and user space, I am open for placing it in the
> > folder Documentation/userspace-api/.
> > 
> > I would like get opinions from the perf maintainers if possible, if we
> > have agreenment I am glad to convert it to RST format.
> 
> Yeah, I agree with Jon.

Okay, I will spin a new patch based on this discussion.

Thanks for confirmation.

Leo
