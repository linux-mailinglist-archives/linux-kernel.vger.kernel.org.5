Return-Path: <linux-kernel+bounces-32273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B91E83594F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8EB2822E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E157EBB;
	Mon, 22 Jan 2024 02:22:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E87FF;
	Mon, 22 Jan 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890160; cv=none; b=BDGMDYm9BhN60a8xDSBJfQJqXv8T80C02n9rfgsErp2/sXxCOkkB64afaMObM/JE3dcoW4V1VJ7ngMG9uVbXrls7wF/lsbDg3wApkzIGVdsOiv1XzpigrtaT0PVksa4Ehk79cdnzB66eu4b9VZ83N2ULiumxOoG9bJOcQrde5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890160; c=relaxed/simple;
	bh=XtDTghB3E5GNSYHyxWKsmlCfD8jRqRd6/mZgbu0lni0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUdTQtRPPH0rpOU7mEqTQplRqpXbgnKAwNhIzbhVi5fHn5tk1m4erIMoKje6qyPevnPaVVbpWnbO0DaiocYbMu4Q0jVEBAcn528hrWhjry2XlzvEnkHUNU4RiikFtotUGt5geQTr7tbugvSbgSyMjut9RUEqQqf3oNIR74nI8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EF4C433F1;
	Mon, 22 Jan 2024 02:22:37 +0000 (UTC)
Date: Sun, 21 Jan 2024 21:22:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Glaser <tg@debian.org>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
 alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
Message-ID: <20240121212236.02331f4c@rorschach.local.home>
In-Reply-To: <020a1803-25c4-4365-8c53-291becd94632@zytor.com>
References: <20210312113253.305040674@infradead.org>
	<20210312115749.065275711@infradead.org>
	<Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
	<CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
	<Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org>
	<d23e1b70-7ac3-49cd-8d5f-1dedc0108603@zytor.com>
	<Pine.BSM.4.64L.2401212356390.999@herc.mirbsd.org>
	<20B57BDC-9A3F-4B02-9BA9-41477088A6CE@zytor.com>
	<20240121195649.7355e1d5@rorschach.local.home>
	<020a1803-25c4-4365-8c53-291becd94632@zytor.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jan 2024 18:15:39 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On 1/21/24 16:56, Steven Rostedt wrote:
> >>
> >> Yes, but it is a matter of where we optimize for performance as opposed to correctness.  
> > 
> > There is no such thing as "optimize for correctness", it is either
> > correct or it is not. Correctness should always come before performance
> > (at least that is what Thomas has pounded into me ;-)
> > 
> > If a kernel use to work on a machine but a newer version no longer
> > works, I call that a regression.
> >   
> 
> There absolutely is such a thing as "optimize for correctness." It means 
> to keep the code clean, easily testable, and with a minimal number of 
> distinct code paths so that regressions and *especially* uncaught 
> regressions get caught quickly.

I call that maintainability, not correctness. It is either correct and
works, or is incorrect and does not work.

You can change code to be more maintainable and still make it incorrect.

-- Steve

