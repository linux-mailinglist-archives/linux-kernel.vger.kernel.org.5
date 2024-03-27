Return-Path: <linux-kernel+bounces-121648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C288EB98
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEA21F251C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A515B14C5BA;
	Wed, 27 Mar 2024 16:48:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965C149E1F;
	Wed, 27 Mar 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558133; cv=none; b=JGMJdrc5oCiciV2ikNDqrqFJNj4jEqBOFROywKB1gcLUuWU+7hFFq74PQ+PxcffoDHVOwo/dp8Z/Ic2WC1d+/eCMNAT5h5R5ud1lFTPqj2T280FIvgZ4xoTE1V4MgTQG1evjTkdjkMTY4pBZ1no676qRmjmYeNAYgF3++BqIwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558133; c=relaxed/simple;
	bh=Vgk42pkU6NSfGsoKjytnv43dccze8i4vnE837j65Qf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMLSmnl5abmXPLuFFLaw0Tdp09en+eOK32AbADxlUhBYalzk+vCreRpzmzm3qlhGKU6vzuR9CW+rNHYmiqkxl1RnvrCbXYIa/nkrx47ihYE9s/U9bt+bcEzGIOn+77loVRRQYTDDIeVymK1WppGPZpu//lAjTpnBNWBMD8zfvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458F3C43390;
	Wed, 27 Mar 2024 16:48:51 +0000 (UTC)
Date: Wed, 27 Mar 2024 12:51:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] rcu-tasks: Update show_rcu_tasks_trace_gp_kthread
 buffer size
Message-ID: <20240327125132.600d62a3@gandalf.local.home>
In-Reply-To: <20240327163657.606414-1-kiryushin@ancud.ru>
References: <20240326152230.3e692d83@gandalf.local.home>
	<20240327163657.606414-1-kiryushin@ancud.ru>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 19:36:56 +0300
Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 147b5945d67a..963ecae3c8e6 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1994,7 +1994,7 @@ void show_rcu_tasks_trace_gp_kthread(void)
>  {
>  	char buf[64];
>  
> -	sprintf(buf, "N%lu h:%lu/%lu/%lu",
> +	snprintf(buf, ARRAY_SIZE(buf), "N%lu h:%lu/%lu/%lu",

Nit, but I would have used sizeof(buf) instead of ARRAY_SIZE(buf) as that's
more common practice for this type of code.

[ do a: git grep 'sizeof(buf)' ]

-- Steve

>  		data_race(n_trc_holdouts),
>  		data_race(n_heavy_reader_ofl_updates),
>  		data_race(n_heavy_reader_updates),

