Return-Path: <linux-kernel+bounces-53965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFC84A884
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD221C2A3A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAE148CF0;
	Mon,  5 Feb 2024 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/BfspfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB0487B8;
	Mon,  5 Feb 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167840; cv=none; b=dfpLy2rcOEPH5dMkCOVEV7N/M9WX2s9RHPSS7fB7R2AaOkY5K9dy6pQW6FH3qXq1ZDHuHBQDf4M06yPdm7cjkNvuXsJZ3dmCNL+SizmY2oLL366AKflddDInQXKN5EP9RVgurwkidY/0OV069G07X3jcc7+ekg5Jb27wobDwgGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167840; c=relaxed/simple;
	bh=qyP/thMR0THGNL+eGpiX2kDnh5yo8acL5uRu2NaGRYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGUeT+kPMEzqgGE4AaHDR1u4cbxm2SJEDSa3/ZQt/MPWQ8J2OHrA7NU4Z5pYHFvmhkRfAj7zKrzkLqk0FBFVoeugm+mzUzuCCfItoJDW+4Mg6DDBQ7uo3zpoIBQ06HuLjLqF1M+DzbLfxVaCssHAqoqHHvqKsHmMFrMNHRjtSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/BfspfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438C6C433C7;
	Mon,  5 Feb 2024 21:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707167839;
	bh=qyP/thMR0THGNL+eGpiX2kDnh5yo8acL5uRu2NaGRYU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=r/BfspfSjfbLdQ1zwd9Gk3L6/NC/Dcl65nkjf4DyjbgvJQ56Vc3aWCp+y0dqvVVoc
	 6eJmzQqRLdegU3bfpvW5luD7HLRJvfAFh+RdWMsLJuQ7guVkFh7WRhD1yStWb9goUo
	 zstvMcv61xhH07eDzvM+EMRE0X0pYN6rhYUFTW8PjNwhmKGY6XWTSbIM0HDyck6IK1
	 uNQMjIpJUq9pQ+48ZkC9WERByKI1k8Aj5uJ7BWwS7iq6HG0hl7J6BygzST0YeySlsO
	 u8pRsamE8LMgO0lE9DTo7fz1VM/CuhBA4cjRAwl7r+mKEBcrCnLWBxGxowuMjF12lp
	 y/grT1WafetGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84606CE1C10; Mon,  5 Feb 2024 13:17:17 -0800 (PST)
Date: Mon, 5 Feb 2024 13:17:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <08baa5cd-943b-47cc-832d-1cf6520bef1b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
 <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>
 <Zb0evDquygkDI_8P@slm.duckdns.org>
 <c5d5ad66-da86-447b-8014-820d2c67382d@paulmck-laptop>
 <ZcDdlRzpofn2cAuO@alley>
 <20240205132515.GF69174@google.com>
 <a6762ad5-62f2-41d4-bba7-c2d9dcb12498@paulmck-laptop>
 <ZcEfCM160K5cnzHx@slm.duckdns.org>
 <a8386e9d-39f6-4bd5-8329-30550fb2745a@paulmck-laptop>
 <ZcFFYR-JOrfp7kvn@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcFFYR-JOrfp7kvn@slm.duckdns.org>

On Mon, Feb 05, 2024 at 10:30:25AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Feb 05, 2024 at 11:41:10AM -0800, Paul E. McKenney wrote:
> > [    0.316453] ==================================================================
> > [    0.317646] BUG: KASAN: use-after-free in wq_update_node_max_active+0x123/0x810
> > [    0.318851] Read of size 8 at addr ffff88802109d788 by task swapper/0/0
> 
> Ah, that one is fixed by 15930da42f89 ("workqueue: Don't call
> cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()"). I have a
> hard time imagining that having anything to do with console being quiet tho.
> It's a cpumask bit test targeting cpu -1 and the result gets overwritten
> later during boot.

Thank you for confirming!

If the silent console comes up again, I will beat up on that more.

							Thanx, Paul

