Return-Path: <linux-kernel+bounces-105330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AC487DC54
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 06:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612432819D7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 05:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DBF79E3;
	Sun, 17 Mar 2024 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIpHN0P/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097C611E;
	Sun, 17 Mar 2024 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710651835; cv=none; b=HhfFrk4HwphgUs5Q/5GMYOuqP5m8QoBlRK6hEkxZF/rlKmOLmwvVXF6TmrEr1PcBzDT5Evi6NBseA8nHZZ+kCa+84X7CT0Ldi9w9pIznemMFCrYtn/EOXB/Vyr80YouZtro0y6X+ixSBwaT8fxivxeZ8F5becwA20c2Ma2OEPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710651835; c=relaxed/simple;
	bh=HUHKSgRBoGhegRNWAfxP9MiGwkvOvQYw4a0D+Rip5IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSMIbdEmoPEVjVpnZbfB3dk07rbNGHmNmWtpsx4XTCzHU0cZzFfx89Onkslo3ZmJIwoLywIONrdCeqgnOMxDrzheRAICHfXyED9OrPVBWnyBdTKV+TlrjCWHeVwxPs3SqSvrQmX1JWlHPcoxf89MQCmX4x4XCPWWwtNGaZvhR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIpHN0P/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BB8C433F1;
	Sun, 17 Mar 2024 05:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710651835;
	bh=HUHKSgRBoGhegRNWAfxP9MiGwkvOvQYw4a0D+Rip5IE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mIpHN0P/PZMSxI1yTgDQEPRTHhNBGPFIbiWot806tu30sn+VuzU29tUyaXpAdUwuZ
	 zPu9wgOiINrqt7iDD+h7iklzGpNfPXeY1kWPHnVmho1TQRBcc2GKztkNEoUeANFAuW
	 k5N6OMvrk/U+/wc4Q++e4eSErPiKiy4Q/Uk2UGtMABZZlf3h7p5yLmmMYlctEFQp+U
	 DyALN3hCBksGU7Gxul+DZYU474MfzZWMHl7FfINXIgq7eEw+JxdItPakYtq7X53OO/
	 HTIKwZkSrjL2FHumrwtJ2jW6T3MQ0MLeNp2CD0ykIu5Svf+mfWk5jSIdDlII5yAm27
	 0+8+NkAKJRHCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 68685CE0D85; Sat, 16 Mar 2024 22:03:51 -0700 (PDT)
Date: Sat, 16 Mar 2024 22:03:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Use the gp_kthread_dbg operation specified
 by cur_ops
Message-ID: <36f02d85-77bb-42a3-aa31-f7d3ac57aad6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240315071710.8575-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315071710.8575-1-qiang.zhang1211@gmail.com>

On Fri, Mar 15, 2024 at 03:17:10PM +0800, Zqiang wrote:
> Currently, for different types of rcutorture tests, when dumping
> gp_kthread because of slow gp, always invoke show_rcu_gp_kthreads().
> this commit therefore changes show_rcu_gp_kthreads() to
> cur_ops->gp_kthread_dbg() to dump the correct information in
> rcu_torture_writer().
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Good eyes, queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 51eebc523f08..9d269682256a 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1617,7 +1617,8 @@ rcu_torture_writer(void *arg)
>  				if (list_empty(&rcu_tortures[i].rtort_free) &&
>  				    rcu_access_pointer(rcu_torture_current) != &rcu_tortures[i]) {
>  					tracing_off();
> -					show_rcu_gp_kthreads();
> +					if (cur_ops->gp_kthread_dbg)
> +						cur_ops->gp_kthread_dbg();
>  					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
>  					rcu_ftrace_dump(DUMP_ALL);
>  				}
> -- 
> 2.17.1
> 

