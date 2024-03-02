Return-Path: <linux-kernel+bounces-89304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B786EE03
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E136B218A1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D53B7464;
	Sat,  2 Mar 2024 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peNcYxBZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9916FB2;
	Sat,  2 Mar 2024 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344467; cv=none; b=pwrjpBJaSFM+e845hW2R+UhtcsYB6J3Bwp+eR8wWREEfMDb2avwgx8G2Lp7s5JiHP40bMNkPoZPCfj63KtqeK4BhUW4sKev5jB3OulNxpHa5blNPVFy1HmhTDXuClnEtKF3Ybcw+IhCxFIq4vpeFzN3xpYdapC6KnX3aOX7J1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344467; c=relaxed/simple;
	bh=NNqJwKuUnh2IIdOSAX9YLdozM9t2NsrCRBt0KGDMBuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMucNbL02LzXn02SOVelWhxIse+sgVYaiqnmozBI3nf/r4QK1zOZLOdEsaAqNp8j9SPcFj5pf8mzz4Lb/9frralH6ULCXmKH6v6vnAbusPOEUtnNh63wX2mIvhqAolOCLJLWFkxYs6ZJ87JC94ValO00uizZFGSHR3baR8zuVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peNcYxBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEA5C433C7;
	Sat,  2 Mar 2024 01:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709344467;
	bh=NNqJwKuUnh2IIdOSAX9YLdozM9t2NsrCRBt0KGDMBuw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=peNcYxBZmH2tgW84RJHZLdPc0IeTSpwL0AuIUd3ofh15xsHkz73QPJfq1ItY8ifQS
	 FtfWMVLmbthmuhCPtYGX2XF9VPhIrVplAjFEtEb80loUENgfX1ubTLjSsIavzZcQvk
	 9aKXDUerLZkhALiYlS4S1PzdMIoYt4kBOk20Q087Qyu/G2dT+UZYDTxnV3uRzvyOv0
	 +YRJQ5+i31g9Fn+3rjLFRz2LyDDUJEihvNHmVktmj3YUuxlaK4/nkMuteJC+wbc/ON
	 p+uHIqxD5q5+/CTkHdp0kFgCkJfrCgOd0vX2e40acpgVZzurAGb9GtCmFrpo6GtqDB
	 L0VJEMzq886WA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B1303CE140C; Fri,  1 Mar 2024 17:54:26 -0800 (PST)
Date: Fri, 1 Mar 2024 17:54:26 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@meta.com
Subject: Re: [PATCH RFC ftrace] Chose RCU Tasks based on TASKS_RCU rather
 than PREEMPTION
Message-ID: <fc59eb57-774a-417d-a818-afb5431b8e56@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f6507b10-5bb5-4407-bd4d-c547193a5a28@paulmck-laptop>
 <20240228152236.7a4c9eec@gandalf.local.home>
 <b5acdc28-0441-49ca-9e8d-50d6ac40c395@paulmck-laptop>
 <2835d5ea-0396-49f6-88fb-be49cb998cc5@paulmck-laptop>
 <20240301153001.0d544f9c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301153001.0d544f9c@gandalf.local.home>

On Fri, Mar 01, 2024 at 03:30:01PM -0500, Steven Rostedt wrote:
> On Fri, 1 Mar 2024 12:25:10 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > That would work for me.  If there are no objections, I will make this
> > > change.  
> > 
> > But I did check the latency of synchronize_rcu_tasks_rude() (about 100ms)
> > and synchronize_rcu() (about 20ms).  This is on a 80-hardware-thread
> > x86 system that is being flooded with calls to one or the other of
> > these two functions, but is otherwise idle.  So adding that unnecessary
> > synchronize_rcu() adds about 20% to that synchronization delay.
> > 
> > Which might still be OK, but...  In the immortal words of MS-DOS,
> > "Are you sure?".  ;-)
> 
> It's just safe to keep it. It's definitely not a fast path.

OK, you got it!  ;-)

							Thanx, Paul

