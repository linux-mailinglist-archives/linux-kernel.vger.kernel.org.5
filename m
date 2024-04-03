Return-Path: <linux-kernel+bounces-130013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60B897338
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FA21F217EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA47214A0AF;
	Wed,  3 Apr 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j4gKhmc9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A21149DE5;
	Wed,  3 Apr 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156327; cv=none; b=gaYxdXwV/Gy2jgIDH5ixLtQL6f9uLRl4uU39dvM7G36WFGoYHsa+XpekHlAcwTICrQ3n1g63JEmElJR6O1uX/iuo9HoywA2PGEeNROrU63+zIAKPHGPCQJEmEUu9swLPZlxwVH+ViJQx1lJQ0FPA8cu+xYh5RJ5kkXi37ATtB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156327; c=relaxed/simple;
	bh=GQ7pDnvmg+PvtqACCV2lrfhSSMsK6+Y0rU6DNq6vKu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkJHSvWnLXltjRc6FMWDpOOWgXnl5ROQan+v+7sAZwMRJe9yg+kz0WKRWO85lBwKm3V4FJ9SIzTen0WVrDDqi5RIueG7WLeeZIUwydEwoCMrs0jXysjc4TjDq2Ft1/+nLIAjT7Xt7q7v1ovNQmQbycV0uHggo6RIDcy8VsNfOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j4gKhmc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADE7C433C7;
	Wed,  3 Apr 2024 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712156327;
	bh=GQ7pDnvmg+PvtqACCV2lrfhSSMsK6+Y0rU6DNq6vKu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4gKhmc9DltNw940mtp073tuxdiE4epv20nU2ixS9o+M+jcILElJ/XSRdVq3QfW6x
	 k3qlLQhLNAa3ebzEc9ZOaz+RL7RaSReonLkM58/ltHq74B1ODcX1pEMdBwo/4ZZ3Ii
	 nYWylkJT61kuGizapQvAlOlDU+luXzPsjRIMN2vk=
Date: Wed, 3 Apr 2024 16:57:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org,
	duncan.sands@free.fr, stern@rowland.harvard.edu,
	mathias.nyman@intel.com, oneukum@suse.com,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] USB: Convert from tasklet to BH workqueue
Message-ID: <2024040314-unbuckled-botanist-1afc@gregkh>
References: <20240403143852.13175-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403143852.13175-1-apais@linux.microsoft.com>

On Wed, Apr 03, 2024 at 02:38:52PM +0000, Allen Pais wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/usb/* from tasklet to BH workqueue.
> 
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
> 
> Changes in v2:
>  - Update code comments and commit message.
> 	Suggested by Greg K h
>  - Retain local variable name(hcd.c).
> 	Suggested by Alan Stern
> 
> Link to v1:https://lore.kernel.org/all/20240327160314.9982-1
> -apais@linux.microsoft.com/T/#m2ec7868fbf102f1551ebe4c92d200848b94af3b1

Why the line-wrap?

And v2 info should all go below the --- line, right?

v3 perhaps?

thanks,

greg k-h

