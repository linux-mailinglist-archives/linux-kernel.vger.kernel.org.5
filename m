Return-Path: <linux-kernel+bounces-125476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1368926B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247421F22F96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BE513D252;
	Fri, 29 Mar 2024 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWiOIBla"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597D79DF;
	Fri, 29 Mar 2024 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750865; cv=none; b=O+xt8/kircBU1baeD28yr8PknPi8CvnK3nXPqFn7y+7MwZFAvCgLwSbwC8IPZbbmGStt1mjW+6TliPK4VQbVRYRfKtiLpJxmh0GfpTl9NHFNCOHp4mt35/i/EuZ5kwgHmBIWe6Xvo8HeCN3cTW10Fs2b24IEWoR/F/6MMMsqYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750865; c=relaxed/simple;
	bh=/i0HXnhYBVObZiCX4pKS7aDYvx+uI5OD0a8v2q/VBh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VioDGK1jWrAzcOzoI+GC2c9toUWQWchUefgMcbs01mgxURXnTPcZy/YLBwUUqfUUPc+C0Pex7YYvGAXAMlKA7mjEaY2oYuQL4mCd3dvE+UjJ7FHealB+0GWVuEdAZogWbdAgCYZ4m8DgswlEx65Y9sjTAc09L6g3aquL9O8Hj7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWiOIBla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945BAC433F1;
	Fri, 29 Mar 2024 22:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711750865;
	bh=/i0HXnhYBVObZiCX4pKS7aDYvx+uI5OD0a8v2q/VBh8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dWiOIBlap43aT2z5Oks1llWwMzD0WZ2fiA6xgQLisx3AxFxwGUayqLBX5UWjqnUmP
	 PU/xeLF7SO/kGcYbPfW8mfUQYu1Nq6bqn4sjywuvQd3bQVtJF5BqttMjECO7LdKz4H
	 5XFAjd9Pb/T/XcXXk0t2BQjQA8I4N4fGxT5+IgEyOqtb73qGgm44YyrXT3onF24gY/
	 cmypHORSVouPJiBDahh6rm28GNmCKLlhqr4r+nAN1DfbQ/4EdgIKIhaXhwuOpLBCTm
	 X/UU6UkRy0/cV74+lUpSt0puamDGeQFLsBm06ahmStlvA1AALwavnXCAHjnE6A23/Q
	 LtOn+BggtL4Vg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2E21BCE120B; Fri, 29 Mar 2024 15:21:05 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:21:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] rcu: Fix buffer overlow in print_cpu_stall_info()
Message-ID: <5a629a8e-5a70-4c7d-ab6a-f4a09e8c574c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240328181914.869332-1-kiryushin@ancud.ru>
 <e3d3a612-4751-48ac-82c1-8bf61e8f3cd1@paulmck-laptop>
 <a6e236f3-60a4-48da-840f-c38d7ba02475@ancud.ru>
 <20240329143205.66c35f5f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329143205.66c35f5f@gandalf.local.home>

On Fri, Mar 29, 2024 at 02:32:05PM -0400, Steven Rostedt wrote:
> On Fri, 29 Mar 2024 20:56:16 +0300
> Nikita Kiryushin <kiryushin@ancud.ru> wrote:
> 
> > Maybe, it would be a good idea for me to add a comment with intent
> > clarification, to reduce possibility of the same confusion in the future,
> 
> Yes please do.
> 
> > while I am at it? If so, should I do it in the same patch, or make a separate one?
> 
> I would keep it the same patch, but it really is Paul's decision.

I am with Steve on both questions.

								Thanx, Paul

