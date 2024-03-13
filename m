Return-Path: <linux-kernel+bounces-102474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6037287B299
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926691C2639F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6D4D135;
	Wed, 13 Mar 2024 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUv4aBLv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89544CB47;
	Wed, 13 Mar 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360661; cv=none; b=WYdDgnhO37C/NR8Sl8xu//NCxLrdnP6zl+avIR/92M9zTpW3by5yEM/WFgBd55+sucx1QErrd2NW4tAizi/UD6h001iJPkhYReJWOHF8YTUi/qLJN5f7bA1ZiFQftobyfPk6kGNJkOMnfv6f/yGaTHZG6g1H97/6fpaaxc3WChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360661; c=relaxed/simple;
	bh=Gbe78oPrZIjwxy4gU1xh5rmWojqg3p1VZPqzkmibQP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O01UHnGaDgbjsXY+L2W+nwzIp8FQb3MafQPjCxeGdS0Sa7yrUhadmkgsl5uz0/bccsVUUGPGqpmfC/fva6nGHFnB656WHsuEUW+dr35HITWb5x/hQ3cY3Mk/t1ZSlbRJV3l84JfJZCZ4O82DB6rfEAZy2DWtXtboGXoxUDrgrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUv4aBLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF4FC433F1;
	Wed, 13 Mar 2024 20:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710360660;
	bh=Gbe78oPrZIjwxy4gU1xh5rmWojqg3p1VZPqzkmibQP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUv4aBLvFp/QJhhBbuekWZP+DQDxFAxAqsGFZb3Ymp653rzPJkj/xRuF0MsPZFcrw
	 P74ez6hqNbAxoLJgX29uCKP7lzqCpmrYAufzw9zobb430XkdJcNb/pP0GfsJGxG5Cq
	 WpNiukMEZmjklUEE5mi+xsW1d5F9Ac0cZESX8uNGwWB9GcecjjVq7a7ACGpLb8Lytg
	 3gt1Xm/yPtx/y3FfF8TSKOUd1wyvzAyy/FlOoH4SFdzAmyNldZl+hU2DAxmmcaW54o
	 xJpksuhw9iWSHp1mTXZuDl1jD3B5ekJJ2JGIyRcxl9t04z5xMk3MhZ7qpewJfHuxpp
	 KJMIhaPO0cWJg==
Date: Wed, 13 Mar 2024 16:10:58 -0400
From: Sasha Levin <sashal@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.10 65/73] exit: wait_task_zombie: kill the no longer
 necessary spin_lock_irq(siglock)
Message-ID: <ZfIIUkJYIZ323Rkx@sashalap>
References: <20240313164640.616049-1-sashal@kernel.org>
 <20240313164640.616049-66-sashal@kernel.org>
 <20240313170324.GC25452@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240313170324.GC25452@redhat.com>

On Wed, Mar 13, 2024 at 06:03:24PM +0100, Oleg Nesterov wrote:
>I do not know what does 5.10 mean. Does this tree has all the changes
>this patch depends on? Say, 1df4bd83cdfdbd0720dd ("do_io_accounting:
>use sig->stats_lock") ?

I have no idea, the trees are up at https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git

>In any case please remove this patch from all your queues, it got the
>"stable" tag by mistake.

Sure, now dropped.

-- 
Thanks,
Sasha

