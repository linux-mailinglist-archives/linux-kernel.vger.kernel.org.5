Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404CA7EA3A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjKMTSZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 14:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjKMTSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:18:13 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C28419BA;
        Mon, 13 Nov 2023 11:17:11 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3731344a12.3;
        Mon, 13 Nov 2023 11:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903031; x=1700507831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXzAwGJ5tDGIurIQYKfvq5W6aU1IangDfDujnxdN0Dw=;
        b=hHfdqDsNG2mk+C8Tdbqxt+qafK6FHLcPxc2McESw8KklTEcj5yw5FWenTpYpfYlS6I
         AiWAUSBsjmlc4PelndvJ73L9SH+0X+U+H7+O02bvcNqEI6kO2BuQYQr7q/+pp+OCJVQI
         UF0ltkxT89PgkfxuxsGLPl08c87MUO5V+xS2+u/isAtmDLJNXL9DiDJ4Luxu3S6ijOCq
         7/5EuBgSk11akXVqwpqyYbKneJzwxZnE8FwC81Qc8ofK/IGr6XL64wmz4D7QEOxIZ1Rh
         j+KAahLx6lb7iwevOlp8ZIIt2qNKfsfsRpX3rnMo3IxCVaXsHZScKz/RtnG1KWm+u94Y
         ywUQ==
X-Gm-Message-State: AOJu0YwIeFDBKfd9zQGmLBhtZlUMNM7LA4dJ6aoCSXbWx/TfeVM7w5HI
        /Amo2AZDSNHAvtB9ggVe/FbHpnWCqORWj3zWAzo=
X-Google-Smtp-Source: AGHT+IErDETuasXxpR+zj+IofcwoKV2s5HhnTzRkftG7HUhXz5J9lvYVR2AGVuZAU9EpU37ulFYCCxQPBByCaWzsHJU=
X-Received: by 2002:a17:90b:38c1:b0:280:5e66:a1e2 with SMTP id
 nn1-20020a17090b38c100b002805e66a1e2mr8361844pjb.22.1699903030698; Mon, 13
 Nov 2023 11:17:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699487758.git.jpoimboe@kernel.org> <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble> <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
 <20231113172106.GA12501@noisy.programming.kicks-ass.net> <CAM9d7chg8c4yftXgAyZZyLuYJQaWYDTa9YY5x-S+Mb-8SM8K-A@mail.gmail.com>
 <20231113184958.GA7901@noisy.programming.kicks-ass.net>
In-Reply-To: <20231113184958.GA7901@noisy.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Nov 2023 11:16:58 -0800
Message-ID: <CAM9d7cgMvjy458N4_wjgvQN+cPCc4TtjG7VjChxPqVdVZJX3=g@mail.gmail.com>
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 10:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 13, 2023 at 09:48:32AM -0800, Namhyung Kim wrote:
>
> > Yeah, I thought something like this first, but then I thought
> > "can we just use PID for this?"
>
> TID, and assuming things are otherwise time ordered, yes.

Right, I meant that, not TGID.

At least, the perf tools handle events in time ordered.

Thanks,
Namhyung
