Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242A97E6308
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjKIFGF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Nov 2023 00:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjKIFGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:06:02 -0500
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74742258E;
        Wed,  8 Nov 2023 21:06:00 -0800 (PST)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso350403a12.3;
        Wed, 08 Nov 2023 21:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699506360; x=1700111160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWWRdVAc8SjGrbGqga92U04nOwyYRnr7pVoBOO57/0A=;
        b=hAcYvFAMghLQW0mNzncvzOe0SE8A944yWIpHcArZzKNpsDgHh526Z2D+50XXRjy8Zp
         TcaP6MKdfbUjlzGawkjgibismlADx9lZbQnY43QgHn2lhXx4qgGC+L/CYx09NwckWdbY
         eatXKi6I8SK6wG9q28i2Bx0w1yAaXfq2J+46IlWtQeqDV8nMt0Rj8lvKjTzmbWYbF512
         dVW4/fyKZCPJ7VY5xkUF7StYoMo4kJ8laxttpwX0LDIYXcBVuDhHIDvQcV+i8zOlb4us
         N3LMl7U0UMHFNhHhTBlA/9FxVFEo4xJOGxMoZR8lLgVJ6poqoTlJcuKP8gccRA7gIBO2
         WKZA==
X-Gm-Message-State: AOJu0YzNfd8K+cCCOmeIGW5XDoTNnhuxuuVWKl/K6w3OlJ55SeSfx1IY
        GmUDjzzK9yfUbSaxfansgkpqL071tzkFJbHi5C0N1Nv8
X-Google-Smtp-Source: AGHT+IHiNAvUdtYNNZLO+N6/KY7pswgNZn9bkyscxx3hPcT8SWCDih9IAR1zoliENLy98Ypv+a4wpzzg7ws7qVCJ3MY=
X-Received: by 2002:a05:6a20:734f:b0:180:def9:20d4 with SMTP id
 v15-20020a056a20734f00b00180def920d4mr4450968pzc.62.1699506359766; Wed, 08
 Nov 2023 21:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <20231012035111.676789-35-namhyung@kernel.org>
 <20231108195204.a3ddfe5965e9c33661460ff4@kernel.org>
In-Reply-To: <20231108195204.a3ddfe5965e9c33661460ff4@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 8 Nov 2023 21:05:48 -0800
Message-ID: <CAM9d7chRcGaEBZid+HJ3sn7vmDEh9tsQ5uT-18UrXKC2Tcy5oA@mail.gmail.com>
Subject: Re: [PATCH 34/48] perf dwarf-aux: Add die_collect_vars()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 2:52 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Wed, 11 Oct 2023 20:50:57 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > The die_collect_vars() is to find all variable information in the scope
> > including function parameters.  The struct die_var_type is to save the
> > type of the variable with the location (reg and offset) as well as where
> > it's defined in the code (addr).
> >
>
> This looks good to me.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

>
> BTW, I did similar thing in collect_variables_cb()@probe-finder.c, maybe
> this can simplify that too.

Ok, I'll take a look later.

Thanks,
Namhyung
