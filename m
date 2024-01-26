Return-Path: <linux-kernel+bounces-39460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F683D182
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E12B26900
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBF64C;
	Fri, 26 Jan 2024 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIGDIChI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45328362;
	Fri, 26 Jan 2024 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706229182; cv=none; b=XLYEvP2DcrcNuBLRejGJy3Te1FE+q3Y19G3BmFR+AO/ayEZTTaLXjZ4gbBr45wpGnfC45yv6cq1i9KRyEJ++a0GnSslhwMBxN9fZBdP1z3G8AZdXKZS6BbYWWSTP8tzExNhfSBpbtJI5kCUGrtSqxP0/iAPAFRimxV4jc78ErOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706229182; c=relaxed/simple;
	bh=lSI0go3BG4ZdZbQTC+VyUNDK8V+IL0abc+hKz2wuQi4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bcdphEW2GvhskU7Doc1hZ9lYdEFtwHWY5WEO6UEuw7hY9AxDpS/wwmk35J+d9LGhxS08OcCvFxqr5eHdI/FhbxAi1bTwP/Gc4Quz1Qcgk7n0zGcCTRHWQEoZO29JwVHFkagsaSqFuKBL2kw9kC7IbBa6Rsbld8waTeUsvsUlamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIGDIChI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084EEC433C7;
	Fri, 26 Jan 2024 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706229181;
	bh=lSI0go3BG4ZdZbQTC+VyUNDK8V+IL0abc+hKz2wuQi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MIGDIChIXho+jx/227a2S0HfhSwDn43zM/Eb7pznDp2/kVkxMMgF4aYtG0ufm0AiY
	 BRyVjsDtO12/hsq0s02YFyVeypCwcK937y614dP+yF8CrMCNMr55qdjLeTxvg6CdXW
	 DjsE2auo/obcBA27ZFiDQbBH7nGBmxM3+YKjI5g3s/1gVnM0nBK+0JiOVMKNNSasz7
	 1E2CdoKLpEVubyNziuwTwSFGaJOa/jEcztdfXLSH8qKStWeo2iBWWNjk6Xn1Xm3FMp
	 C6MfH25NhF05fiNYU0GQxFlP8r+/6ACJAB6aqMPFvVdqZf+XibOdqtG2G1pr2vuwVO
	 dLwZrIvl3bKog==
Date: Fri, 26 Jan 2024 09:32:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v12 3/6] tracing: Add snapshot refcount
Message-Id: <20240126093257.b6059a4c4fa1b1d345132350@kernel.org>
In-Reply-To: <ZbJ19CF2Zv4d0R_Z@google.com>
References: <20240123110757.3657908-1-vdonnefort@google.com>
	<20240123110757.3657908-4-vdonnefort@google.com>
	<20240125001149.364c0b08237e8b7f0a69bd56@kernel.org>
	<ZbJ19CF2Zv4d0R_Z@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vincent,

On Thu, 25 Jan 2024 14:53:40 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > @@ -1470,12 +1483,20 @@ register_snapshot_trigger(char *glob,
> > >  			  struct event_trigger_data *data,
> > >  			  struct trace_event_file *file)
> > >  {
> > > -	if (tracing_alloc_snapshot_instance(file->tr) != 0)
> > > +	if (tracing_arm_snapshot(file->tr))
> > >  		return 0;
> > 
> > BTW, is this return value correct? It seems that the register_*_trigger()
> > will return error code when it fails.
> 
> It should indeed be 
> 
>  ret = tracing_arm_snapshot()
>  if (ret)
>      return ret;

OK, then there is a bug. We need to fix it before changing this
for backporting.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

