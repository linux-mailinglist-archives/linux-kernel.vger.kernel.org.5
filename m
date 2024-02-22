Return-Path: <linux-kernel+bounces-76882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B248785FE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F501F25506
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6371534E7;
	Thu, 22 Feb 2024 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTy1IJJU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7415098C;
	Thu, 22 Feb 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619543; cv=none; b=K8tk1QwrfbW9ZjqJ3lgIFPMoaWVbrwzdPIbOS+QGP9N2unRLFFOexV3HF0RnkaB4fV8vERKJ/w98p7X1f0vA6fQDHu1m4fI8y3NLMWboeaVbgLSzUm2T9j8sxaOoOfQmAXiHHNx868x9Ab7WkDHzrFnYddUEf0x+o3owhVqKA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619543; c=relaxed/simple;
	bh=Y1FDu3e58sxUyX8c6bWspuaBUksa3HEve/jDnxW6r8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNbgrHoyd+2vbSZKnTkS2wzbFs7EeHwPJN2Y9bU/JDqf54E4QF7mSKba1GpTi5gTVhpiCQtnWRB6PIsQ83Y4BUCU06HUywGLO5tNtJkNv1fsT4niqpAR+yykrBLGvB2ZvOeUNP5+mNPG2LoB1jd07tzEAKAgD/u9SwZSSz4xJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTy1IJJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E8AC43394;
	Thu, 22 Feb 2024 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708619542;
	bh=Y1FDu3e58sxUyX8c6bWspuaBUksa3HEve/jDnxW6r8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTy1IJJUsGcYsAeG8Mqmk6hxjnqgj/nruqyRszQxId27I9/pmujOHPHbCLEkvp+Nc
	 yO4TgmzUu/yGf2fgSM6CLOTFBmhnq62q8SrtaGwozA2pMvwFwJcqvAP3Sk5DJuJJMg
	 JRYLoQ3zBuaqZc69W8LqV3P98Mp3Pmd85gzs6qjG3dIhS6bGGhZjgULIeyeHgG1lO/
	 ZpMkk+jOiGMBAxS2OEOx2D3LAsYqlOFTNmx0FivPNcN/Yvg9N3RvFyeQzheBVBxYT7
	 ApVItRxjyOZTuSpR5mTiODtERKiyH2YUOCO5CU6QBthrdkBo3qYMKOD1s31ueoBh2Q
	 F5fJrwClEl2Qw==
Date: Thu, 22 Feb 2024 17:32:20 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 4/6] rcu-tasks: Maintain lists to eliminate
 RCU-tasks/do_exit() deadlocks
Message-ID: <Zdd3FEWVnxaqdgHR@localhost.localdomain>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-5-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217012745.3446231-5-boqun.feng@gmail.com>

Le Fri, Feb 16, 2024 at 05:27:39PM -0800, Boqun Feng a écrit :
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit continues the elimination of deadlocks involving do_exit()
> and RCU tasks by causing exit_tasks_rcu_start() to add the current
> task to a per-CPU list and causing exit_tasks_rcu_stop() to remove the
> current task from whatever list it is on.  These lists will be used to
> track tasks that are exiting, while still accounting for any RCU-tasks
> quiescent states that these tasks pass though.
> 
> [ paulmck: Apply Frederic Weisbecker feedback. ]
> 
> Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> 
> Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Reported-by: Yang Jihong <yangjihong1@huawei.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Yang Jihong <yangjihong1@huawei.com>
> Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

