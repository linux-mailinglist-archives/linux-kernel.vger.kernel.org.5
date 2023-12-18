Return-Path: <linux-kernel+bounces-4407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8458E817C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6921C21D10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ED8740A3;
	Mon, 18 Dec 2023 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcggSP88"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADE442361;
	Mon, 18 Dec 2023 21:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25C0C433C7;
	Mon, 18 Dec 2023 21:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702934924;
	bh=5X6kIjhcDaJpywrSbw/1s+grFMz5MMTXnJ6HQWnvrTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcggSP88tbCZDD+aMr7Zlx+CEYBraFkF3bI5JI0sgjmNS5XMQnPjSvbEIsB9bu1KF
	 YFw7Pl9vVH99qGnaHu7dnc0xaeFMAeipALqojwiTzhNK0FyuTJVX6Rce02AaPrLw+0
	 S1N2dO+oTBCEdfnXN5aF4r7XZHemphinURTC+wG4F2vZSnn4ruPfg72BHPZOzfNfV+
	 823kj9SH0BHgPPr9Cm6KFVAZujI215fjLzRqa4ZEpCSBq9xzF0jSSICaJ9VmFuRoQD
	 6xwaY7csFL7R5MhpuV6pLb8K+dgzgBj5jYJKWP7EBtUuU4ds/n/A8/HxyEKZ6gAnNR
	 Zk4NZu3B7jzKA==
Date: Mon, 18 Dec 2023 22:28:40 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] srcu: Improve comments about acceleration leak
Message-ID: <ZYC5iAds0sJuDYzd@localhost.localdomain>
References: <20231211015717.1067822-1-joel@joelfernandes.org>
 <ZX4T4E02hbsgnGBY@localhost.localdomain>
 <CAEXW_YQK_ct=kMKSO6XnW1NpSjSAVMiMevL-om_i-au9mpUEyw@mail.gmail.com>
 <ZYA3aiWbgzBNH3fZ@localhost.localdomain>
 <CAEXW_YS-p9G=fLO+-vYx9RQS9oovHbVs48aPDfGcQrNWUdXwWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YS-p9G=fLO+-vYx9RQS9oovHbVs48aPDfGcQrNWUdXwWA@mail.gmail.com>

Le Mon, Dec 18, 2023 at 10:27:56AM -0500, Joel Fernandes a écrit :
> On Mon, Dec 18, 2023 at 7:13 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Le Sun, Dec 17, 2023 at 09:00:15PM -0500, Joel Fernandes a écrit :
> > > "Acceleration can never fail because the state of gp_seq value used
> > > for acceleration is <= the state of gp_seq used for advancing."
> > >
> > > Does that sound correct now?
> >
> > That can be confusing since acceleration relies on rcu_seq_snap() while
> > advance relies on rcu_seq_current(). And rcu_seq_snap() returns a snapshot
> > that may be above the subsequent rcu_seq_current() return value.
> >
> > So it should rather be something like:
> >
> > "The base current gp_seq value used to produce the snapshot has to
> > be <= the gp_seq used for advancing."
> 
> Yeah "base current gp_seq" though probably equally confusing sounds a
> bit better, so I'll just use that instead of "state of gp_seq".
> 
> With that can I add your Review tag?

Sure, sounds good!

Thanks.

> 
>  - Joel
> 

