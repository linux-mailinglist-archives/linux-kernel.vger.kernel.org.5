Return-Path: <linux-kernel+bounces-2504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D57815DFF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 09:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03ABF1C2174C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685B20E3;
	Sun, 17 Dec 2023 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeKtYiVP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73471FAD;
	Sun, 17 Dec 2023 08:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63056C433C7;
	Sun, 17 Dec 2023 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702800650;
	bh=Wiirgn3qwjpQfMRM2pz85BzmEPDW3beth3oqlsva2GY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OeKtYiVPHH0ZJBYmVGHNVHTZQlVASmncjQoYPil5k/POlw24BEvDTBF9b7nXIbXbz
	 Hrz04y1j7hlMNdiB2e8UKZUdS85WcOy52/+03Cp68fvMK7UlaOj6zx+Q3PytEMSDPw
	 5XCZATVXOqBbkWHe2d+ntmuB7lIzHz4RjKc9O+OI0F41XXzBr0J8tgpA/7YZETYjgJ
	 YnJ751ZpqAd2qJLo8lQz6jrXuH0h96LG/mgrdSGYJvW0Ck7bNw5sfIdVxVXXpOfFHI
	 V4GaY+J1KB+bA6WVk06xrBhlsTs0aIRBWG6uueyUs0mdOa3bCI15fodYEC/SUllANX
	 8bHmdNWUOnzww==
Date: Sun, 17 Dec 2023 17:10:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Add disable-filter-buf option
Message-Id: <20231217171045.21e0bd95c26f17f1f19f6733@kernel.org>
In-Reply-To: <368d36b2-e5ea-46d4-b214-6d04cf20685a@efficios.com>
References: <20231215102633.7a24cb77@rorschach.local.home>
	<21936075-3858-446a-9391-a38e8d8968e7@efficios.com>
	<20231215120417.567d5ea4@rorschach.local.home>
	<fbf8991a-ce83-462c-b87a-b60c6635d223@efficios.com>
	<20231215123458.63f57238@rorschach.local.home>
	<f1a75239-341e-4611-a48d-88e10407dcd4@efficios.com>
	<20231215134335.2388aba5@rorschach.local.home>
	<368d36b2-e5ea-46d4-b214-6d04cf20685a@efficios.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 14:08:40 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-15 13:43, Steven Rostedt wrote:
> > On Fri, 15 Dec 2023 13:25:07 -0500
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> I am not against exposing an ABI that allows userspace to alter the
> >> filter behavior. I disagree on the way you plan to expose the ABI.
> > 
> > These are no different than the knobs for sched_debug
> 
> These are very much different. The sched features are enabled at
> build-time by modifying kernel/sched/features.h. There is no userspace
> ABI involved.
> 
> > 
> >>
> >> Exposing this option as an ABI in this way exposes too much internal
> >> ring buffer implementation details to userspace.
> > 
> > There's already lots of exposure using options. The options are just
> > knobs, nothing more.
> > 
> >>
> >> It exposes the following details which IMHO should be hidden or
> >> configurable in a way that allows moving to a whole new mechanism
> >> which will have significantly different characteristics in the
> >> future:
> >>
> >> It exposes that:
> >>
> >> - filtering uses a copy to a temporary buffer, and
> >> - that this copy is enabled by default.
> >>
> >> Once exposed, those design constraints become immutable due to ABI.
> > 
> > No it is not. There is no such thing as "immutable ABI". The rule is
> > "don't break user space" If this functionality in the kernel goes away,
> > the knob could become a nop, and I doubt any user space will break
> > because of it.
> > 
> > That is, the only burden is keeping this option exposed. But it could
> > be just like that light switch that has nothing connected to it. It's
> > still there, but does nothing if you switch it. This knob can act the
> > same way. This does not in anyway prevent future innovation.
> 
> I am not comfortable with exposing internal ring buffer implementation
> details to userspace which may or may not be deprecated as no-ops
> in the future. This will lead to useless clutter.

Hmm, but this may change the ring buffer consumption rate if the filter
is enabled. The ring buffer may be filled quickly than the user expected.
Thus if user specifies the rare condition, most of the events on the ring
buffer is filled with garbage. And user will know the buffer size *seems*
smaller than the setting.
I think copying overhead will be a secondary effect, the biggest noticable
difference is how many events are recorded in the ring buffer. Thus, what
about naming the option as "filter-on-buffer"?

If we introduce filtering on input directly, at that point we will use
it if "filter-on-buffer = no", because this is also not noticable from
users.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

