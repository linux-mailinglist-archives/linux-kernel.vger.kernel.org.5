Return-Path: <linux-kernel+bounces-3552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB369816DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E74284CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2F4E610;
	Mon, 18 Dec 2023 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYx0UbpZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0554CB55;
	Mon, 18 Dec 2023 12:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B4C433C7;
	Mon, 18 Dec 2023 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702901614;
	bh=oaXgI7dJkeiZfCTEDfLM6KyDpHdVpvV5X2NG0vSmxzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYx0UbpZ1dmkadeAse1gwsLTMEfb6tPdbqU7QkLpHwCQOCRal5ZRHbqut8jKlZ8vv
	 TrnbsG/FkdTdqfOcyCwDV4bryAySzjNTT06O+YbaU6kLuQWkRt6bQxvKsk/v8aZtlq
	 gs3bczcofn0YzORUB5JgNqFy71iu54qfhEIKPRcNF7HfEdLscpG23JJyEALVgjC/Ka
	 BQj29bO9rbcUdsidj0yXq0FzHB+UOo3BdTfDMQL1f2zioMh92+dyBjZLzkIsaUw/NH
	 XiJZRQUhMT8CQHUx7ghOY2wzUYWjQL3i1wRUovSFwcZRu9lZmx23MhDlIg9X9OyJIr
	 XM9GOtBZGN4QQ==
Date: Mon, 18 Dec 2023 13:13:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] srcu: Improve comments about acceleration leak
Message-ID: <ZYA3aiWbgzBNH3fZ@localhost.localdomain>
References: <20231211015717.1067822-1-joel@joelfernandes.org>
 <ZX4T4E02hbsgnGBY@localhost.localdomain>
 <CAEXW_YQK_ct=kMKSO6XnW1NpSjSAVMiMevL-om_i-au9mpUEyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQK_ct=kMKSO6XnW1NpSjSAVMiMevL-om_i-au9mpUEyw@mail.gmail.com>

Le Sun, Dec 17, 2023 at 09:00:15PM -0500, Joel Fernandes a écrit :
> "Acceleration can never fail because the state of gp_seq value used
> for acceleration is <= the state of gp_seq used for advancing."
> 
> Does that sound correct now?

That can be confusing since acceleration relies on rcu_seq_snap() while
advance relies on rcu_seq_current(). And rcu_seq_snap() returns a snapshot
that may be above the subsequent rcu_seq_current() return value.

So it should rather be something like:

"The base current gp_seq value used to produce the snapshot has to
be <= the gp_seq used for advancing."

Thanks.

