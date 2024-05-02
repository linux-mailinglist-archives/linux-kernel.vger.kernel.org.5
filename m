Return-Path: <linux-kernel+bounces-165901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258438B9323
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C39B1C20E76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C617571;
	Thu,  2 May 2024 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SReLSI+J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5262134B2;
	Thu,  2 May 2024 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714613881; cv=none; b=MAbt5No6aMoxQHTEaCVuCFCkqQacaH4fUWcj20mBef8yudkD2j7L7kyTZWfPqcqUGnaXcVq4KYY2HO7zExMwR1mysU72Rah6SldmvK7iFFCPWl7Mpgqq4dZxk8y2fV6eATSHEIq2QVn6TY3dOCkMVGNa7ZYWpJ3M9dU8IASZpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714613881; c=relaxed/simple;
	bh=ZidUTk9IjA5PczGiPEgm5WSMoqCnYRRlVV5rFpP1XS4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hXO6ng6bd/oZX27I4f2MoZSOFN1CwS393M508alC3NVcsYG4lT0bn3Yo4L0FkB4LuO5+B2juG3Yh9g3tU9cmlZHshunAaU+d0crjVhYuFbO+pLs5WH0UQbq98NPvtZwV4Cb0YeTLAVWGPmh82Y43ykgY56pOVlU1bH7SpfdGi6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SReLSI+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239B5C072AA;
	Thu,  2 May 2024 01:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714613881;
	bh=ZidUTk9IjA5PczGiPEgm5WSMoqCnYRRlVV5rFpP1XS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SReLSI+J6ZvT3abCJn3YrMT7Rp6vLEeLeO8cb+YhleL+V2/swmQiNV2EHNv/08B7P
	 4odR5zx7HTd1SpmrtpFRFjEdWAInE650wDUPngLXNwGBCOjGVH3+gbn+/jfm0NPusX
	 GHpcSC5kaLoC6vme2Yo9RM4RP+m1EsyAaDgB1q38QEL3aLRSIN0s4ZoF1cxjnGEh8X
	 4ghxA2HCQ5J5JBjdQPrmX4gDSkqaAffwckF3JsQ9QipvrarubcU2YtkjvURtdGPGW+
	 tGCTvCyPUfiJntllYzfcZblpXfM/KGUfmdIS2aAwuuwR4ZMAkvnyY+ViMxIjgOYYDT
	 yZ5SZguL40HnA==
Date: Thu, 2 May 2024 10:37:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LuMingYin <lumingyindetect@126.com>, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [v3] tracing/probes: Fix memory leak in
 traceprobe_parse_probe_arg_body()
Message-Id: <20240502103756.934f487af05dc7e232f0f06e@kernel.org>
In-Reply-To: <909dde28-019e-4f53-b5d5-a5fe9956dfc4@web.de>
References: <20240429222941.12d3b774bebef484e605d095@kernel.org>
	<909dde28-019e-4f53-b5d5-a5fe9956dfc4@web.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 29 Apr 2024 15:55:09 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> …
> > > it jumps to the label 'out' instead of 'fail' by mistake.In the result,
> …
> >
> > Looks good to me.
> 
> * Do you care for a typo in this change description?
> 
> * Would you like to read any improved (patch) version descriptions (or changelogs)?

Thanks, but those are nitpicks and I don't mind it.

Thank you,

> 
> Regards,
> Markus


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

