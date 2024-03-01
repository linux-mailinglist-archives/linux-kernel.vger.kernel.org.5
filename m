Return-Path: <linux-kernel+bounces-89053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BBA86E9FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0361F2591A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B10C3BB2F;
	Fri,  1 Mar 2024 19:59:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AF3C063;
	Fri,  1 Mar 2024 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323186; cv=none; b=uvE4nrAKdclb2ZsoM3i0bHUZ5AMmjERxgrC483jAZ5Ll+nB7kByL7YpUhIq6E1c0W886JrdrfF4sK0kwxGYFIFlmT85Ax+scl9NG2+yvkDmAhwkwPXmvMop2E6OnhZp06Fvwn4OKaBQrR1rEtgLMi8xcsrj+8057wVOk71mOwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323186; c=relaxed/simple;
	bh=/cpGRNtcNz+xHHZjD6FZ8xUm92lTGPma31xcu87bynA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/Pf6e71xtEXPZc7m2xpBuP8zS04mieG5KGICx7Zn6fvS4xfe7Px15WqBj+No2yWaJxVRLBE5eM+Cy5lfXsNouk8DPsiiF84MFr010uFJUSM8BI4w8HBN3YxbF7c9I0YAOEMb/FyXQvW1SLEmx7+26iCfrXddr6ApqM46BSzJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D4AC433C7;
	Fri,  1 Mar 2024 19:59:43 +0000 (UTC)
Date: Fri, 1 Mar 2024 15:01:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 vaclav.zindulka@tlapnet.cz, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Coco Li
 <lixiaoyan@google.com>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH] tracing/net_sched: Fix tracepoints that save
 qdisc_dev() as a string
Message-ID: <20240301150153.36e5bf60@gandalf.local.home>
In-Reply-To: <CAM0EoMkOgTezVLnN7f1GoXTURQ73LmXjHnBjQBSBRPnv58K-VQ@mail.gmail.com>
References: <20240229143432.273b4871@gandalf.local.home>
	<CAM0EoMkOgTezVLnN7f1GoXTURQ73LmXjHnBjQBSBRPnv58K-VQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 14:24:17 -0500
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> > Fixes: a34dac0b90552 ("net_sched: add tracepoints for qdisc_reset() and qdisc_destroy()")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Should this be targeting the net tree?

I was going to say that I need this for my work, but my work is aimed at
the next merge window, but this should go into the kernel now and be marked
for stable. So yes, it probably should go through the net tree.

Do I need to resubmit it?

> Otherwise, LGTM. Just wondering - this worked before because "name"
> was the first field?

Looks like it. See commit 43a71cd66b9c0 ("net-device: reorganize net_device
fast path variables")

I wonder if there's anything else that uses a pointer to struct net_device
thinking it can just be switched to find the name?

> 
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Thanks,

-- Steve

