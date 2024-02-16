Return-Path: <linux-kernel+bounces-68157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC534857695
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8831F21ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C945175A9;
	Fri, 16 Feb 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tjpHtGnM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6265D17584
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067485; cv=none; b=Zb17pZvt2YMTSOIG+SHa3XmQSiOd6xtzKqPNI/QYiD+jBxfIQ1xjfocYVZkn0g7fQtnuWOOV8kSyYtq04v859qA2xtlHA1J7giWzdqeAKN9HvAPh4vC8QThsy/4EMHQw8X6vejNngtsjVQldjNVCQXIIM3rhRdtgDUaGJr3HYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067485; c=relaxed/simple;
	bh=pEXMrSDrMB2L14Hnzc+QPz99BJ3W/txQLDNNz0xomEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ396BEu1oqZpp5wuGkd1iXyLEyAtkIPwZVLo8Ioq7XdymCkRG5ud1BsrgJ+N3chQ7TqwzrgG2bLlbJeEBvmU0vYlTlqXKN9Q6oROF3hrVzhs/ZfooSfSX0HLYHsHr7uKVXR40TbJ6E+hTWAF8xC5N2cJkq6kyr3sKPnNIz/nUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tjpHtGnM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pEXMrSDrMB2L14Hnzc+QPz99BJ3W/txQLDNNz0xomEk=; b=tjpHtGnMOozEhaViR/mQ+feFTl
	5KLaIF7X9e/NtMinH/c0UZe1q5RywLgIv0Dj9HJk/u3US+/EAUPzBCJQVSBvs+woNlwp0I16E75Ud
	gmBY8L8U6hBlVNZRu1N+4CK+PiylsjR0TV558PUuhNgcy6UrBx+c4BCwdurGQsr01MqMQTj/ySmBM
	LDNWp0crJvkWDPczXAFl9EROdkZJ+hmbCRgRnpGJfYXFhZs0mMDtDI24opKx/cvM1lGGzm4cRTRRk
	atUPSfAHFSbXXekFeb2k6x7gPml+03j9CHCWSHxLa2oV9ClNuvjS4qMiWiuku8KCgf9DeFEz6ct9I
	ThJjFN3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rasNR-00000001L5S-15i1;
	Fri, 16 Feb 2024 07:11:17 +0000
Date: Thu, 15 Feb 2024 23:11:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	fuyuanli <fuyuanli@didiglobal.com>
Subject: Re: [PATCH] kernel/hung_task.c: export sysctl_hung_task_timeout_secs
Message-ID: <Zc8KlSGBbUF7JMbw@infradead.org>
References: <20240209070935.1529844-1-kent.overstreet@linux.dev>
 <Zc2giqMeZhxuDSU9@infradead.org>
 <20240215105509.b7b3c87c24ed35cdfb111f34@linux-foundation.org>
 <gbzf3rqo6edvan3lzdx7udc3hzfwfjh3c74lm6ruegu5cwg64q@lt4ghwp5y33f>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gbzf3rqo6edvan3lzdx7udc3hzfwfjh3c74lm6ruegu5cwg64q@lt4ghwp5y33f>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 15, 2024 at 06:26:59PM -0500, Kent Overstreet wrote:
> There's a few places in the block layer that are using the sysctl value;
> those will be easy to fix. There's definitely more places abusing
> TASK_INTERRUPTIBLE, but aside from the ones in my code I can't think of
> a way to search for them.

I think any kthread that is woken using wake_up_process or a wait queue
is a good candidate.


