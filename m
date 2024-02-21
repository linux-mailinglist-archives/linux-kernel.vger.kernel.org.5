Return-Path: <linux-kernel+bounces-75301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0ED85E618
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6336E284D41
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FBB85647;
	Wed, 21 Feb 2024 18:33:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868B42A8B;
	Wed, 21 Feb 2024 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540403; cv=none; b=l3WUpSr6AtWwkxkqoo9cLvXQ9KEgimD1spL5bT5RHYbbhJVBtbjSbrBn6vlnHRtRYlBkK6zSVMgeaDYLwW6dppDEV1TuKWv59xZ181+6ZBH23CeMA0BdJeYi+tQRNEPDKhugIdGXCSK/lue0p8SKKEjwrWb/3f8jQVdSQnW7wrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540403; c=relaxed/simple;
	bh=ptBTLo3fWfIuf3+j4XFusTed1gyYa8nMDrNfXKxPHfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lV2QIK2DdJbBDQPbyi2+O15l3fv3vW/hyAU8A1IeTTK0qNbVmnITnrB3S2AQo4T7IS6Yva+93v+5nGjPnhvZb2NPSEwzzYNWWXeBxBCexqWcMqSrIDi73DvDIyZFLqyu4lCGtrqRxdUFETo0iNmDsmDqO0B2Fp84Food1nyl9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E856C433C7;
	Wed, 21 Feb 2024 18:33:22 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:35:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vilas Bhat <vilasbhat@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Saravana Kannan
 <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM: runtime: add tracepoint for runtime_status
 changes
Message-ID: <20240221133510.70b9c205@gandalf.local.home>
In-Reply-To: <CAJNZHTTeFJvCjxUX_e_RVtJWcXW=1cjdF8EqvojnObm7jiyLKg@mail.gmail.com>
References: <20240221164112.846409-1-vilasbhat@google.com>
	<20240221121420.2e32fd00@gandalf.local.home>
	<CAJNZHTTeFJvCjxUX_e_RVtJWcXW=1cjdF8EqvojnObm7jiyLKg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 09:57:03 -0800
Vilas Bhat <vilasbhat@google.com> wrote:

> > You could do what everyone else does:
> >
> > #define RPM_STATUS_STRINGS                      \
> >         EM( RPM_INVALID, "RPM_INVALID" )        \
> >         EM( RPM_ACTIVE, "RPM_ACTIVE" )          \
> >         EM( RPM_RESUMING, "RPM_RESUMING" )      \
> >         EM( RPM_SUSPENDED, "RPM_SUSPENDED" )    \
> >         EMe( RPM_SUSPENDING, "RPM_SUSPENDING" )
> >
> > #undef EM
> > #undef EMe
> > #define EM(a, b)        TRACE_DEFINE_ENUM(a);
> > #define EMe(a, b)       TRACE_DEFINE_ENUM(a);
> >
> > RPM_STATUS_STRINGS
> >
> > #undef EM
> > #undef EMe
> > #define EM(a, b)        { a, b },
> > #define EMe(a, b)       { a, b }
> >  
> 
> Thanks for the comment, Steven. I did notice both methods of defining
> enum values for tracepoints and chose this method because it felt
> clearer. Could you clarify on why the method you suggested is
> preferred?
> 

Sure. One big reason: It removes duplication.

If you add another enum to the list, you only need to update it in one
place. And it prevents the two from getting out of sync.

-- Steve

