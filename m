Return-Path: <linux-kernel+bounces-102979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3271F87B96A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643E51C2145F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2E26BB46;
	Thu, 14 Mar 2024 08:39:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7F433D4;
	Thu, 14 Mar 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405593; cv=none; b=TX2A8ajYxbyf4oXP4RuL4BR0g4oFXSwQRpeDGy8CbJG293S9H92Pmmt88AncSe1WXKRyiut+77r9mYosNFdUG2gDe43J4VdvAO8q8t+fBA9L6hF29cbasb17vTEl45rx3xeI1o8G7DqUL3/PO6GOlXOYlCz4WjGKcZWqE7/wVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405593; c=relaxed/simple;
	bh=Pxk9h0+NJJSQGNZfBddW8VXxiAc/KVW3MLayKN9JI9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF4nqXJWX4BMXOlFTDmj3YBMBNmqPuVeD5bxLMEmsU6GlgfrjEyUTJ1uxQ/tHvc/hQUHJrecvI86SMy/14DCwhYGniiOS0EuYtjqo1yWNKPYtIQSqcya1gVB4HbuUoGjGPomzJte+9cAuZbIfXVJ/iWgMaqBC6ATUlCm3tUhq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F403C433F1;
	Thu, 14 Mar 2024 08:39:48 +0000 (UTC)
Date: Thu, 14 Mar 2024 08:39:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Christoph Lameter (Ampere)" <cl@linux.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	robin.murphy@arm.com, vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZfK30r8M6zx2aWU6@arm.com>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
 <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
 <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
 <Ze9TsQ-qVCZMazfI@arm.com>
 <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
 <bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com>
 <ZfCXJRJSMK4tt_Cm@arm.com>
 <ZfG5oyrgGOkpHYD6@bogus>
 <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com>
 <ZfHevcKpcb6i1fn5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfHevcKpcb6i1fn5@shell.armlinux.org.uk>

On Wed, Mar 13, 2024 at 05:13:33PM +0000, Russell King wrote:
> So, I wonder whether what you're seeing is a latent bug which is
> being tickled by the presence of the CPU masks being off-stack
> changing the kernel timing.
> 
> I would suggest the printk debug approach may help here to see when
> the OPPs are begun to be parsed, when they're created etc and their
> timing relationship to being used. Given the suspicion, it's possible
> that the mere addition of printk() may "fix" the problem, which again
> would be another semi-useful data point.

It might be an init order problem. Passing "initcall_debug" on the
cmdline might help a bit.

It would also be useful in dev_pm_opp_set_config(), in the WARN_ON
block, to print opp_table->opp_list.next to get an idea whether it looks
like a valid pointer or memory corruption.

-- 
Catalin

