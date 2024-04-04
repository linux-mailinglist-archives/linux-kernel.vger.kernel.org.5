Return-Path: <linux-kernel+bounces-131901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A73F898D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B7D283E63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73812DDBD;
	Thu,  4 Apr 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMCx4h3l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EB2127B7D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252644; cv=none; b=lMfzsQZQeSQB17SWnQOHlaTAITKqVV2l2ZfVE8ITvqg9d8x35Qn4kq9H1b4vmIYeu3j9ctQ2eVXYyzz8+M1L9G0gVN49yqfZmDWUGBikiX6evYQn+9RhSM3NGwUoLcPDGiqq23yYkit67LOlv1xWZIe5uAmtnQmvuAMfnMHvsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252644; c=relaxed/simple;
	bh=jsxm3c5fH+voURQZevBABOuKLHgU1Ha8HPGSkYB31EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apcGlGwK7js5bF7bsMu4hc4xXgNWCOJ4fiae5OgnHtq/QQy6h1nDZpLPXUmgTBbVoeQjD7tnCbmKmTu/uoJ4PO+OnSXqblpFWz+zm9PIwDWFw5GHDYz9OIP9IPzIzCJkwRkskbfRKVdAcAWl6Q4W/MSQey5ktKKP3al7bELyFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMCx4h3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A797AC433C7;
	Thu,  4 Apr 2024 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712252643;
	bh=jsxm3c5fH+voURQZevBABOuKLHgU1Ha8HPGSkYB31EU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rMCx4h3lxz5XgkmJLn531xCpjVM9v5q5c4lVZJV4altkmdSuUkgbDNxHx89mx42va
	 k+1djetWBsJceboMHMdC1PWFe90DkZYKRfyeB5ZxvW2H8ZN1fj4wxBwBSrw68cojKf
	 3Ce2JGXNnxo91vOLNgZlM3x2ODEW/jI7NPb1yjpoGNNt1JxDqBEAU3G2m+N4k53/dq
	 HrM1Axx2cULKl+rreUev4fKo3wsiQhG7iX4v5hnQQG/fgNjL7lp80H+iVlYA1DOGJW
	 VotaUj/Hu8X13uVwHLab82pLfR2fPdCQ2EWl29U18cSXNo5llqzjSc3jKQlAogAEYF
	 M/Sgx49hqkV6A==
Message-ID: <578bf1c5-4102-4048-b5f3-6961963a119f@kernel.org>
Date: Thu, 4 Apr 2024 19:43:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Content-Language: en-US, pt-BR, it-IT
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>, youssefesmat@google.com,
 Joel Fernandes <joel@joelfernandes.org>
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <8cbf4bcd-431b-466f-b62d-ee03932e97f5@joelfernandes.org>
 <091ca2ea-202d-4685-92ea-529186a94f0a@kernel.org>
 <a4af4bac-92bd-44e9-93d2-dc22dc9a81ad@joelfernandes.org>
 <07b1844a-a9d4-47fb-aea0-c0722b2a8001@kernel.org>
 <b3e053bf-c9f5-492d-baff-8f251fb00279@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <b3e053bf-c9f5-492d-baff-8f251fb00279@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/15/24 18:41, Joel Fernandes wrote:
>> Thanks for taking a look. My colleague Suleiman hit the issue too. He's able to
>> not set 45ms/50ms for instance.
> I isolated the problem. It is not an interface problem.
> 
> Long story short, the servers are initialized at the defrootdomain, but
> the dl_bw info is not being carried over to the new domain because the
> servers are not a task.

Fixed on v6. When an rq is attached to a new rd, at rq_attach_root(), the bw of
from fair server is being added to the new rd.

Without this, the RD has no bandwidth registered (no-dl task) and so the
admission control becomes broken.

-- Daniel

