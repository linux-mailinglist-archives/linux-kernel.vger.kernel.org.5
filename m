Return-Path: <linux-kernel+bounces-72118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C743E85AF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469E7B22B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449B54FA7;
	Mon, 19 Feb 2024 23:02:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B156B84;
	Mon, 19 Feb 2024 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708383725; cv=none; b=lDNu+DwadFzFuF+7cXdYCMwyuxzP3TKJ7MzzdP2NrNs5lvmEwHejVcbN/19Q+IGshSZ3g6LMp6lnc+H74TbiNd4STNIFkXdo0tFj2Vh2SeCu9xG99fvh3wjt8jNcAVz94n6edLW1SPvtjZScMqmYKnyr6bSySAV2Lg4sd/LTbs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708383725; c=relaxed/simple;
	bh=eRxm102A2CpKPYSfs5eS/cdiC/I1tkhSeri/+W3RVhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCaU1onDq0DIzmnqvLh4CgCOv/WqhwvIQfHsxFW5X689ha+BtbiU3jGHXnGRlvk68UxhYjxu46iJH1ZozXiSlh/cqZGahu3gZ/jWFD73+//eZohA7BGy+BGIWO/0ljOeuKIuSQvo+w8+NBc4ppgPH4gsP/j7NwTUY+nWwweNrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BA5C433F1;
	Mon, 19 Feb 2024 23:02:03 +0000 (UTC)
Date: Mon, 19 Feb 2024 18:03:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Message-ID: <20240219180347.115e04f4@gandalf.local.home>
In-Reply-To: <20240219173003.08339d54@gandalf.local.home>
References: <20240219173003.08339d54@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 17:30:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> - /*C*/	write = local_add_return(info->length, &tail_page->write);
> + /*C*/	if (!local_try_cmpxchg(&tail_page->write, &w, w + info->length)) {
> +		if (info.add_timestamp & (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND))
> +			info.length -= RB_LEN_TIME_EXTEND;
> +		goto again;
> +	}

Bah, I had my ktest config testing a different tree and this wasn't what I
was testing :-p

The above needs to be:

		if (info->add_timestamp & (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND))
			info->length -= RB_LEN_TIME_EXTEND;

Will send out a v3.

-- Steve

