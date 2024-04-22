Return-Path: <linux-kernel+bounces-153224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD88ACB18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C261BB23F36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E614A097;
	Mon, 22 Apr 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTEtvMCU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F114601A;
	Mon, 22 Apr 2024 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782471; cv=none; b=hQRrq8QZ9QUqiLCV6YkZmgd6ZJ/sO4f+H6DmKcxy324Y5mP3MIOwXSTXAGnMXXDYJ3/i7Jyup9MoiCEdybdykcPoEcB88p8clIJpOcfSk+/pdZ35z5vcFETJxYnDQ6Yx7BTI0sKCgnguOY8pClkBhDXHGY3DE1JAiBxbNhpHyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782471; c=relaxed/simple;
	bh=UMMhTPVp5+n0u8R/1MYYZbZJH5bo2RsgLFP6+90kcZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3plsA8kqh6m4zHd39PnCS6ebRJhtY/dQTs5umiNTKmYQHeiJFlQ1NH/qhNJzj9PYZvAAU2jcT8SgLrPNtQ8lnQjXreMmIm8KcKakQv4fDyNA0IfUYDV3U2m+kwFTx88+FFdhddkXuXKoDFI70jFqgwtmXZi6qlwdpulpgKNuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTEtvMCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76096C113CC;
	Mon, 22 Apr 2024 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713782470;
	bh=UMMhTPVp5+n0u8R/1MYYZbZJH5bo2RsgLFP6+90kcZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eTEtvMCU2BrK3aMpIPMeiBUYghzL1ra+t5NpqdGPTHw3P6pla/D5r3u4bAP4kDl6N
	 IKchv3pOL4ENZKUgH1XtVi7NZXNaKLLluh+kb+i0q+8y4QdFtA3zQt/GNjB74Vr990
	 9dLfz5cQ7zuPgjzu7LWsas8TCmcP/FwnryKEdRYfqpkhwl8ginFjS5oi1BFhYOls7X
	 1pd6sgALzOkRjk4LVQypL97PIIBLjc5YOTj2aN9n5b1q5tb0uJa2bXUJJzpupB+fo7
	 kIQ3SdTtzO2PK/519YQEotYdH2gMy0uYvogdskoRuunTcweFSie8gtH5ibYgLDXAct
	 a9hoscm3JEYsg==
Date: Mon, 22 Apr 2024 12:41:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 08/10] rcu: Implement PCPU_RCU_PREEMPT_COUNT framework
Message-ID: <ZiY-xItV0IMrGDQH@localhost.localdomain>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
 <20240328075318.83039-9-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328075318.83039-9-jiangshanlai@gmail.com>

Le Thu, Mar 28, 2024 at 03:53:16PM +0800, Lai Jiangshan a écrit :
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> When the arch code provides HAVE_PCPU_RCU_PREEMPT_COUNT and the
> corresponding functions, rcu_preempt core uses the functions to
> implement rcu_read_[un]lock, rcu_preempt_depth(), special bits,
> switching and so on.

The changelogs don't explain the reason for all of that. I'm guessing
from the cover letter that the purpose is to save some instructions on
calls to rcu_read_unlock() due to inline calls and per CPU optimized
instructions but it's hard to guess from the actual individual patches,
which are meants to be the actual git records.

Thanks.

