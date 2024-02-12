Return-Path: <linux-kernel+bounces-62158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D9851C73
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04691C214CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4133FB10;
	Mon, 12 Feb 2024 18:08:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C93C6A6;
	Mon, 12 Feb 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761287; cv=none; b=DHCyMA0Gc6VVqG3rIgKOg6VbvQ9z704a1xLBFfBYUX9LBVwZNVBh053/oNAKMZAWLcuVBEBgEoPhJKK1NoNGgHNMLRs32H/x2CSHcLxDQQTUyoyUk7iMySt/ckabF+GDEpiSna0iHtWFtrJOyqbleN4N65WfPRGu8vykH0f6cdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761287; c=relaxed/simple;
	bh=qdqtg6TWGB8jo2x9G2cj2uu942FZJ3zVJy+wRCbux+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCfBNTnzB3FLoDPN8XEpPYfkdNpBbWywcV3OpowJ/fUde+441IThcYinSUXZmMFDJI+yi+qmsKfbI/dggYJaPt0X2BrVf3IgcQeF4mFi2Zme0kOx8Atuq7MTb8q+hj03eNILQdJwJNigVjAFoTKon1aDFw15uoZZYuZpLtiC1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF940C433F1;
	Mon, 12 Feb 2024 18:08:05 +0000 (UTC)
Date: Mon, 12 Feb 2024 13:08:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Manivannan
 Sadhasivam <mani@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
 quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
 quic_parass@quicinc.com
Subject: Re: [PATCH v11] bus: mhi: host: Add tracing support
Message-ID: <20240212130848.7415b87f@gandalf.local.home>
In-Reply-To: <20240206093110.GC8333@thinkpad>
References: <20240206-ftrace_support-v11-1-3f71dc187544@quicinc.com>
	<20240206062636.GA8333@thinkpad>
	<eded3ffe-882d-9514-9c9a-9c49d3a7a9a6@quicinc.com>
	<20240206090312.GB8333@thinkpad>
	<20240206093110.GC8333@thinkpad>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 15:01:10 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> > Bot will check sparse warnings/errors mostly. But these checkpatch issues can be
> > fixed easily. If you don't do it now, then someone will send a patch for it
> > later.
> >   
> 
> Hmm, seems like we should ignore these checkpatch issues due to the way the
> macros are used by trace headers. Ignore my above comment, patch looks fine.

Yes please ignore checkpatch on any TRACE_EVENT() and related macros. It
doesn't understand them, and reports errors and asks for fixes that break
the default way of using TRACE_EVENT().

Someday I hope someone teaches checkpatch to know the TRACE_EVENT() default
format which is:

TRACE_EVENT(event,

	TP_PROTO(<proto>),

	TP_ARGS(<args>),

	TP_STRUCT__entry(
		__field(	<type>,		<field>			)
		__array(	<type>,		<field>,	<len>	)
	),

	TP_fast_assign(
		<code-block>
	),

	TP_printk("format", <print-args>)
);

But checkpatch will error all over the above. :-(

-- Steve

