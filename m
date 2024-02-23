Return-Path: <linux-kernel+bounces-77570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6E8607A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32651B2230D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81863399;
	Fri, 23 Feb 2024 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXy4ozfP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309F7F;
	Fri, 23 Feb 2024 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647978; cv=none; b=EThgnE8O2V7kJhHnp+Qxx5rMKPbJenp5jB3tFaio952e49t/QusbP5kB3uszqSAteeRjkzRfJ4ks3+u0VYssOdmFyLvuWPdC9mXhlzS62+0b62HLdijq/3yvHLYGvJEp5/ILQ8NAN0uBm4yOUr+nTn84f82a4K2J8KqnlKUmXsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647978; c=relaxed/simple;
	bh=TGAs5tijV86Bh0/zpNxrYr2pad3N4E7e0hYjM8ykr9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ptUesRQCxcZd8m0yFpnwvWMLR7Q0g4+q9mgw9l0QP7O4jZNOlGHtlY1N+6nQfKAVPn9kokkxHd0/0RDBZmXYy4/TlEENRgNUS9N2Cr9oveKpT0GLH0/e1iZIeeNvdNBUrjGasDQcUkyK9ckdh2mVf2TvQonCoH6yEKR69RhYBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXy4ozfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A085CC43390;
	Fri, 23 Feb 2024 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647978;
	bh=TGAs5tijV86Bh0/zpNxrYr2pad3N4E7e0hYjM8ykr9k=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=KXy4ozfPpXZ/Eixte90fdN8zPH+Km0ZxvoFm+1Svzhjr17BGIMuGEkmUp8HtnOcAO
	 UVxcDTkPmKvquz4ajimzLD2Yt7Mm1Z1dXobcJh2tdMBJfAfufYh1P2mFL8s9w1vNp/
	 n8JnASXAwYFqICpCJl9MHns8P8OOzGb8K59/eW1jzL4hZOd+ZKa0eMdMN479OQkWLH
	 t/ou2GVjxFP3A8dwq4USTnREZ8fp5K0zyyknDv8xqYToJm2ZPuYQrxnfx3xA2Or1lc
	 QELPM2C3GrQg0DXGnrLolxQFrnY3Cjf+HUdd/EX/ggHsQYb8PVwWVgHb4zQcngyNWX
	 +db5fVoxJHIbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46C75CE0B71; Thu, 22 Feb 2024 16:26:18 -0800 (PST)
Date: Thu, 22 Feb 2024 16:26:18 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	ankur.a.arora@oracle.com, tglx@linutronix.de, mark.rutland@arm.com
Subject: [PATCH rcu 0/4] Refactor TASKS_RCU for lazy preemption
Message-ID: <8c938bd5-6d62-4eff-9289-13b0d7ae8e17@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series refactors the NEED_TASKS_RCU option so that the conditional
processing is in one place in kernel/rcu/Kconfig.  This makes it easier
to make sure that Tasks RCU is enabled in PREEMPT_AUTO kernels, given
that such kernels are preemptible, even if only lazily so.  After all,
it takes only one lazy preemption from a trampoline to significantly
degrade your kernel's actuarial statistics.

1.	Create NEED_TASKS_RCU to factor out enablement logic.

2.	Select new NEED_TASKS_RCU Kconfig option.

3.	Select new NEED_TASKS_RCU Kconfig option.

4.	Select new NEED_TASKS_RCU Kconfig option.

						Thanx, Paul

------------------------------------------------------------------------

 arch/Kconfig         |    4 ++--
 kernel/bpf/Kconfig   |    2 +-
 kernel/rcu/Kconfig   |    6 +++++-
 kernel/trace/Kconfig |    4 ++--
 4 files changed, 10 insertions(+), 6 deletions(-)

