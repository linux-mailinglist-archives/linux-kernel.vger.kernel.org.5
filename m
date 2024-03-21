Return-Path: <linux-kernel+bounces-110221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F184885B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074DAB22243
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746B86252;
	Thu, 21 Mar 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLq5z8wf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C51E879;
	Thu, 21 Mar 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034890; cv=none; b=hcuBMyNnmR8j2VOx57JQpbVFc51Vd78cScQGDRwyJxNZ+Mlck8zRFZrzBMpGVRhtk0PUR5uCOhhor8KA0VoOBihhp+aqsNKFXDWvYkMd4Y+3KNWL+LPPomU8wYx34HzdRx9d3PoiR+Ls6obiLSxsBGqtRQJVgvIwsUgf0GYpbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034890; c=relaxed/simple;
	bh=uDFfsk3vgPN/8cj/h+YlAvJXbZrXFKL6S457kdKJW+c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lfPip68YpQiBlwFVI0LJv8Tdw2elcwEMgJgzpXGugHXumuEBwcA2K81qSySBH7CH2TpAcalD2toTDJ/IwppgfWTgkVuvUngU3crULN6YdL7Bwm089Jn/4UclgCsVKvRmD9qesHf2oju6H1S9RO253UGW78f96iwMqaZUeAs+BLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLq5z8wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A41C433C7;
	Thu, 21 Mar 2024 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711034889;
	bh=uDFfsk3vgPN/8cj/h+YlAvJXbZrXFKL6S457kdKJW+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CLq5z8wfYykUrqZZoFQlnhW0BgzSYZrO38glLtRa/v/pS17IrOVNGO244lOyLgTjT
	 VhRsPgD2SirVcIWL1nbie7Lt/ybve06PHZP7cED2wvFOW91pCBr3yyiRkvmyKycbLM
	 9wNea0q92MZrBfuKIYUhf9MQUYSGxj/pL+6m6eQ2UFfp9SgBDwqlCDn/IEOp7XJh9X
	 vO3NtHTevPZdD0EIjt2ULwNfHY31jM8EB1slyB4ec7kipsSy32B3mOKsEznFkMHA1y
	 XyPe7HmYPwWO1dZv/Z7zA3+Y7SM/UwObx2Dh/CcE1a16AGESNVUylwwDBoFSwYQeH/
	 dq2X/T1EOqv0w==
Date: Fri, 22 Mar 2024 00:28:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ye Bin <yebin10@huawei.com>,
 <mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] tracing/probes: support '%pd' type for print
 struct dentry's name
Message-Id: <20240322002805.fbfe11e4f8f02e701d8d0c91@kernel.org>
In-Reply-To: <20240322000759.ec04bca3bb2afdfaef37a545@kernel.org>
References: <20240320132924.2802187-1-yebin10@huawei.com>
	<20240320132924.2802187-2-yebin10@huawei.com>
	<20240321101547.1f4e68ab@gandalf.local.home>
	<20240322000759.ec04bca3bb2afdfaef37a545@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 00:07:59 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > What would be really useful is if we had a way to expose BTF here. Something like:
> > 
> >  "%pB:<struct>:<field>"
> > 
> > The "%pB" would mean to look up the struct/field offsets and types via BTF,
> > and create the appropriate command to find and print it.
> 
> Would you mean casing the pointer to "<struct>"?

BTW, for this BTF type casting, I would like to make it more naturally, like
(<struct> *)$arg1-><field> as same as other BTF args.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

