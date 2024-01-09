Return-Path: <linux-kernel+bounces-20887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD28286F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55DA1C23B16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B98538F94;
	Tue,  9 Jan 2024 13:20:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9926AF7;
	Tue,  9 Jan 2024 13:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8408FC433F1;
	Tue,  9 Jan 2024 13:19:59 +0000 (UTC)
Date: Tue, 9 Jan 2024 08:20:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v10 0/2] Introducing trace buffer mapping by user-space
Message-ID: <20240109082057.2bb6da70@gandalf.local.home>
In-Reply-To: <20240109220445.5683e4af0cea6b034945b2bb@kernel.org>
References: <20240105094729.2363579-1-vdonnefort@google.com>
	<20240109220445.5683e4af0cea6b034945b2bb@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Masami, thanks for looking at this.

On Tue, 9 Jan 2024 22:04:45 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > The tracing ring-buffers can be stored on disk or sent to network
> > without any copy via splice. However the later doesn't allow real time
> > processing of the traces. A solution is to give userspace direct access
> > to the ring-buffer pages via a mapping. An application can now become a
> > consumer of the ring-buffer, in a similar fashion to what trace_pipe
> > offers.  
> 
> I think this is very nice feature. But this series seems just a feature,
> no document and no example code. Can you add 2 patches to add those?
> I know libtracefs already provide a support code, but I think it is
> better to have a test code under tools/testing/selftests/ring_buffer.

Yeah, we should have sample code and a test.

> 
> I also wonder what happen if other operation (e.g. taking snapshot) happens
> while mmaping the ring buffer.

Hmm, good point. We should disable snapshots when mapped, and also prevent
mapping with latency tracer if we are not already doing that.

-- Steve

