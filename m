Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B8381155E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442004AbjLMO5E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 09:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442027AbjLMO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:57:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A04F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:57:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E630C433C8;
        Wed, 13 Dec 2023 14:57:06 +0000 (UTC)
Date:   Wed, 13 Dec 2023 09:57:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] tracing/selftests: Add test to test the trace_marker
Message-ID: <20231213095749.5ff64569@gandalf.local.home>
In-Reply-To: <CAJ1xhMXuxGHfD8oRfbna_drpHmNv0RUXFrvuVv6rtt-KeCM9fQ@mail.gmail.com>
References: <20231212192317.0fb6b101@gandalf.local.home>
        <CAJ1xhMXuxGHfD8oRfbna_drpHmNv0RUXFrvuVv6rtt-KeCM9fQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 10:09:50 +0200
Alexander Kapshuk <alexander.kapshuk@gmail.com> wrote:

> The REs used in the sed commands below may be simplified as shown if desired.
> 
> On Wed, Dec 13, 2023 at 2:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > Add a test that writes longs strings, some over the size of the sub buffer
> > and make sure that the entire content is there.
> >
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > Changes since v2: https://lore.kernel.org/linux-trace-kernel/20231212151632.25c9b67d@gandalf.local.home
> >
> > - Realized with the upcoming change of the dynamic subbuffer sizes, that
> >   this test will fail if the subbuffer is bigger than what the trace_seq
> >   can hold. Now the trace_marker does not always utilize the full subbuffer
> >   but the size of the trace_seq instead. As that size isn't available to
> >   user space, we can only just make sure all content is there.
> >
> >  .../ftrace/test.d/00basic/trace_marker.tc     | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >  create mode 100755 tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> > new file mode 100755
> > index 000000000000..b24aff5807df
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> > @@ -0,0 +1,82 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: Basic tests on writing to trace_marker
> > +# requires: trace_marker
> > +# flags: instance
> > +
> > +get_buffer_data_size() {
> > +       sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page  
>             sed -n 's!.*data.*size:\([^;]*\).*!\1!p' events/header_page

Not sure the above change can be considered simpler, but it also loses out
showing what exactly is being done.

With the original, I have:

       sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page

Which is obvious that I'm grabbing a number for the size field.

       sed -n 's!.*data.*size:\([^;]*\).*!\1!p' events/header_page

Shows that I'm grabbing something after size.



> > +}
> > +
> > +get_buffer_data_offset() {
> > +       sed -ne 's/^.*data.*offset:\([0-9][0-9]*\).*/\1/p' events/header_page  
>             sed -n 's!.*data.*offset:\([^;]*\).*!\1!p' events/header_page

Same here.

> > +}
> > +
> > +get_event_header_size() {
> > +       type_len=`sed -ne 's/^.*type_len.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`  
>             type_len=`sed -n '/type_len.*bits/s![^0-9]*!!gp'
> events/header_event`

Honestly, the above may be "simplier" but I can't make out what exactly
that line is doing without going back and looking at the text that's in the
format field.

> 
> > +       time_len=`sed -ne 's/^.*time_delta.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`  
>             time_len=`sed -n '/time_delta/s![^0-9]*!!gp' events/header_event`
> 
> > +       array_len=`sed -ne 's/^.*array.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`  
>             array_len=`sed -n '/array/s![^0-9]*!!gp' events/header_event`
> 
> > +       total_bits=$((type_len+time_len+array_len))
> > +       total_bits=$((total_bits+7))
> > +       echo $((total_bits/8))
> > +}
> > +
> > +get_print_event_buf_offset() {
> > +       sed -ne 's/^.*buf.*offset:\([0-9][0-9]*\).*/\1/p' events/ftrace/print/format  
>             sed -n 's!.*buf.*offset:\([^;]*\).*!\1!p' events/ftrace/print/format
> > +}
> > +

Yeah, thanks for the suggestions, but I rather have it be more readable
than "simplified". I write perl code the same way. I do not write it like
any perl developer would, because I write it like C code. I want my code to
be easily understandable.

RE can become extremely obfuscated. So, even though my REs are not the
simplest, they tend to be rather easy to understand what they are doing,
and why.

Cheers,

-- Steve
