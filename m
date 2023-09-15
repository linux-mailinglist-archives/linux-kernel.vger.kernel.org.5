Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B79D7A2993
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbjIOVgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbjIOVgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:36:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EBD1A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:36:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502153ae36cso4144345e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694813759; x=1695418559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WDnZUQg6QrMmZWNyQ05shWmIFnhPEIqKdi2uEPvsIoU=;
        b=C28tXEDhbiMB+dvVPJsGry41x5AOMt7AlEUY2VlbeEXkLAPAOFKuoCZowgKMNMsjT7
         f1C0gFrbHp+MYH7iPKpySH/9HUJzr9vIzK5MPJN2g7/Nppl6sUCEqDavra/9P7PKZuUJ
         xDcTbtVayR7d010FisOVPDQCQPF0H1kT4cGgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694813759; x=1695418559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDnZUQg6QrMmZWNyQ05shWmIFnhPEIqKdi2uEPvsIoU=;
        b=a9NvB79TdM4G3j4xW+N/jaZkqncIrAdgiZ9YCTQIvl/vx/l4y9JfVETipdtEIgyua4
         beNtnWgDKbjO7v4Kz20NxPnPs1+CQWWQOIS38Wd7PF+H3StsrV8hyf4q3B5dEOVCVza6
         7ZRCkns9vuk0sRYpXfT3J8uPWvLOL9KWtq3v+/dKqZIJ08vG1i/RoZ22725E/r3B3KRv
         H4aIUrd49vfUmTHBTi9A+6acATRW12hEf+RF45OTLqdKrsb+NBwp0w+aXKJg+3ZprO19
         GbNxpU0Jdonl0v7r+ANcs4xYX/T2b089CUPQUnZXNNrICTg/LF9IVXkNCVIikJPSXo4c
         h0yw==
X-Gm-Message-State: AOJu0YxyshzTIEC7/0aOl2uW37iPNJzbnzEO4t4g0Qw4RPC3rgGOYkfv
        g5nwKijiCe7rS/QP/jJVgjRH6CBdLMJYo9Lb2dquSTrK
X-Google-Smtp-Source: AGHT+IFoP/KxXi80qv4rttdaZ1adJ/SGf0WgV1iP8g3CvKatKlfjtmWZs/TvSL14EfcdVqrhvp0BZA==
X-Received: by 2002:a05:6512:20c2:b0:4ff:9efd:8a9e with SMTP id u2-20020a05651220c200b004ff9efd8a9emr2456935lfr.7.1694813759058;
        Fri, 15 Sep 2023 14:35:59 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id rl20-20020a1709076c1400b009adc81c0c7esm1733739ejc.107.2023.09.15.14.35.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 14:35:58 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31ff2ce9d4cso1070172f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:35:57 -0700 (PDT)
X-Received: by 2002:adf:f3c6:0:b0:31a:dc58:cdd9 with SMTP id
 g6-20020adff3c6000000b0031adc58cdd9mr2244081wrp.60.1694813757544; Fri, 15 Sep
 2023 14:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230913192905.0a92bcab@gandalf.local.home> <CAHk-=whAkgy10YVwjQGn1AO=1ZFc193ujvMXwmDOJAc=Jaeg5A@mail.gmail.com>
 <20230915163637.77c673a6@gandalf.local.home> <CAHk-=whNU3JaPMq_E7mwVGpTKxxeQxV=13o84u-tTeqfB_t05g@mail.gmail.com>
 <20230915171334.5c231ca7@gandalf.local.home> <CAHk-=whbDQb5VzJbn6qQswxfbcp67uzfwpJ+R1DxHk0dHdg4pQ@mail.gmail.com>
In-Reply-To: <CAHk-=whbDQb5VzJbn6qQswxfbcp67uzfwpJ+R1DxHk0dHdg4pQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 14:35:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiheWEbUfQy1JY_BQ6mJukOLa6hEdEzN1N_hgz1nxY9hQ@mail.gmail.com>
Message-ID: <CAHk-=wiheWEbUfQy1JY_BQ6mJukOLa6hEdEzN1N_hgz1nxY9hQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Add eventfs file to help with debugging any
 more issues
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 14:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And if you really think that people need to know what the events exist
> in eventfs, then dammit, make 'readdir()' see them. Not some stupid
> specialty debug interface. That's what filesystems *have* readdir for.

.. alternatively, if you have noticed that it's just a pain to not be
able to see the data, instead of introducing this completely separate
and illogical debug interface, just say "ok, it was a mistake, let's
go back to just keeping things in dentries since we can _see_ those".

Put another way: this is all self-inflicted damage, and you seem to
argue for this debug interface purely on "I can't see what's going on
any more, the old model was really nice because you could *see* the
events".

To me, if that's really a major issue, that just says "ok, this
eventfs abstraction was mis-designed, and hid data that the main
developer actually wants".

We don't add new debug interfaces just because you screwed up the
design. Fix it.

              Linus
