Return-Path: <linux-kernel+bounces-5491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5340B818B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6339C1C2439A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C85E1CAA5;
	Tue, 19 Dec 2023 15:35:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D11CA95;
	Tue, 19 Dec 2023 15:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63200C433C8;
	Tue, 19 Dec 2023 15:35:15 +0000 (UTC)
Date: Tue, 19 Dec 2023 10:36:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Fix slowpath of interrupted event
Message-ID: <20231219103613.787bef51@gandalf.local.home>
In-Reply-To: <20231219101027.349b7d19@gandalf.local.home>
References: <20231218230712.3a76b081@gandalf.local.home>
	<20231219233710.21b48850676e65da2a37fe22@kernel.org>
	<20231219101027.349b7d19@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 10:10:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>  1000 - interrupt event
>  2000 - normal context event
>  2100 - next normal context event
> 
> Where we see the delta between the interrupt event and the normal context
> event was 1000. But if we just had it be delta = 0, it would be:
> 
>  1000 - interrupt event
>  1000 - normal context event
>  2100 - next normal context event
> 

Also, let me show the rare case of where we do have delta=0. That would be
an interrupt event coming in before *and* after the normal context event
was allocated. That is, we have:

 |-- interrupt event --|-- normal context event --|-- interrupt event --|

And that could look like:

  1000 - interrupt event
  1000 - normal context event
  2100 - next interrupt event

It may look like the normal context ran for 1000 before the next interrupt
event, but in reality it happened sometime between the two.

Hmm, in this case, what we could possibly do is to read the absolute
timestamp *after* the interrupted event!

That is, we detected we are here:

 |-- interrupt event --|-- normal context event --|-- interrupt event --|

                       ^
                       |
                       |


And we know that the write pointer is past this event. We can look at the
next event and see what its timestamp is. It is either a delta or a
absolute timestamp. It is a delta if the previous interrupt came in between
B and C, as that event would have made before_stamp == write_stamp. Or it
is an absolute delta if this event updated the before_stamp making it no
longer match the write_stamp of the previous event.

If it is an absolute timestamp, it means the interrupt came in before our
update of the before stamp, and we could make our delta:

	absolute value of next timestamp - this event before_stamp

As we have:

 |-- interrupt event --|-- normal context event --|-- interrupt event --|

         ^                            ^                     ^
         |                            |                     |
    ts is before before_stamp         |                     |
                               our before_stamp             |
                                                    absolute value

We just need to make our delta not go beyond the absolute value. So:

  ts of first event + (absolute value - our before_stamp)

Should not be greater than the absolute value.

If the next event has a delta, we could make this event delta equal to it,
and then update the next event to have a delta of zero, which would give us:

  1000 - interrupt event
  2100 - normal context event
  2100 - next interrupt event

Which is much more realistic to what happened.

But all this is for another time ;-)

-- Steve

