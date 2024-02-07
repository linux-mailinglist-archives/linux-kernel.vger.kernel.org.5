Return-Path: <linux-kernel+bounces-56363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C5784C93F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A6828AD96
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7255D18AF6;
	Wed,  7 Feb 2024 11:09:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6925601;
	Wed,  7 Feb 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304170; cv=none; b=ICSCClr7k0wRfvnci9qab8ceDHfrR5v9y4zpLBlsvXfNWv0/3UIcLmEV0b5aiw5rD4/FhRRjvLnyjytzpbGoj5CFIxyAXsWN4h83ivRDMUDCnL8dFTearTj46Xvt/UTP5aQWaPOMxsPMm0YU1xODtEfNA/kXeO+OsjRGistjsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304170; c=relaxed/simple;
	bh=3d920/gg0NJob19M4Cyq7mli11h+3maiACOkvHgQw6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktjqs3QwqvYHsmw926cvaPkqRobGBO/LjcdHF/5GimeJ1NMw5KV43ojaQq94v4V58JQT9RqoaoYtwj9ncYMboV7IPlwWPjcs00CMuN64Yq77XBsikH5uUsmHcTSP3HW/5CaYpnrsof8x0q04RONyG92sujr8hX2j114Qm8U2mM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945EEC43390;
	Wed,  7 Feb 2024 11:09:28 +0000 (UTC)
Date: Wed, 7 Feb 2024 06:09:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
Message-ID: <20240207060923.182ecb55@rorschach.local.home>
In-Reply-To: <yt9deddovn3w.fsf@linux.ibm.com>
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
	<yt9djznj3vbl.fsf@linux.ibm.com>
	<20240205092353.523cc1ef@rorschach.local.home>
	<yt9d34u63xxz.fsf@linux.ibm.com>
	<yt9dsf262d2n.fsf@linux.ibm.com>
	<20240206060113.39c0f5bc@rorschach.local.home>
	<yt9deddovn3w.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 Feb 2024 06:50:59 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> Hi Steven,

> Not sure whether that is enough, have to test. However, it's not really
> a fix, it would just require a bit more load and the test would fail
> again. The fundamental problem is that even after disabling tracing
> there might be some tracing line added due to the lockless nature of
> the ringbuffer. This might then replace some existing cmdline entry.
> So maybe we should change the test to ignore the program name when
> calculating the checksums.

Have you figured out what caused the cmdlines to change when tracing is
off. It shouldn't be updated even with just 128 entries.

I'm also looking into a way to keep more of a LRU command lines around,
but nothing concrete yet.

-- Steve

