Return-Path: <linux-kernel+bounces-45292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB13D842E23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A808A2856C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B2B71B56;
	Tue, 30 Jan 2024 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sMwovpyW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4299671B52;
	Tue, 30 Jan 2024 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647641; cv=none; b=nGvucdk+dpKTLonQlz+/2gtf5KB1vSGnCZkyJ6jSr0mKyrk7vsq38De5tntNJCHjIgMpDqFJttajji6rk/7C64AggdGQlt4a6yeJPVT1QHtlcA0pqZSdRO9s9xArPNBTPTueLCt2iFRDUi69OgrZeBAKOY474u3p9/3wLWUgVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647641; c=relaxed/simple;
	bh=cHPCGyt+KrZk5VCGXZ1+oIB0HxHmQMG2D925MBo7pRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM6/rlyGQ83xxKg1K8gUGavvNzNe+h7DrTNPChw4JFgu0Ssgag/hhlN6GeZLuCGdgtcxwspvM+OuEAWACYBKrcGBxQhWgo2Q1ZgmQ/oHDkVeO0L7dx+KMW2RvFpsy9omM8LrY+/RSRCwpL7m0iNHwH1lSu/JtvaVIBHU6fAkeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sMwovpyW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mcM6EuKiC3PBnN3pomFJtPETtxYW50FEofYHj2SjpCE=; b=sMwovpyWAef1DSNFeKhzCxMtZC
	DoseHGxVC5FLC8iUVL4fsLGlXIFuxcJNt4s09RpCiJ5fddfKScNsWQAlxPbF8xoadTRK8jWt6mqWi
	uz2cYy+U0UQevsFq2iUx/LNWzNXS1vHP+TCdo9bPItONjmc42bdOYGhaZCn8KRUmYhHVfskzm6f04
	kqq1frt2oQxIBm0MNLdr01IU50+ZzZaPs7n5iIT6PHtDOdV6G7kfIi7TmFauHo2qh+dZsXZfbBDUg
	BiC/306Kclpzvmo76haLYjBf5PZdSaEreUPIFIEmCnXBh7Y3wnU6IQ6i6LpxMuPuainWUfBSrNCVf
	qYlwCjbg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUv0p-00000000XL3-2vsS;
	Tue, 30 Jan 2024 20:47:19 +0000
Date: Tue, 30 Jan 2024 12:47:19 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Marco Pagani <marpagan@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kernel/module: add a safer implementation of
 try_module_get()
Message-ID: <ZblgV0ApD-9cQWwl@bombadil.infradead.org>
References: <20240130193614.49772-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130193614.49772-1-marpagan@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jan 30, 2024 at 08:36:14PM +0100, Marco Pagani wrote:
> The current implementation of try_module_get() requires the module to
> exist and be live as a precondition. While this may seem intuitive at
> first glance, enforcing the precondition can be tricky, considering that
> modules can be unloaded at any time if not previously taken. For
> instance, the caller could be preempted just before calling
> try_module_get(), and while preempted, the module could be unloaded and
> freed. More subtly, the module could also be unloaded at any point while
> executing try_module_get() before incrementing the refount with
> atomic_inc_not_zero().
> 
> Neglecting the precondition that the module must exist and be live can
> cause unexpected race conditions that can lead to crashes. However,
> ensuring that the precondition is met may require additional locking
> that increases the complexity of the code and can make it more
> error-prone.
> 
> This patch adds a slower yet safer implementation of try_module_get()
> that checks if the module is valid by looking into the mod_tree before
> taking the module's refcount. This new function can be safely called on
> stale and invalid module pointers, relieving developers from the burden
> of ensuring that the module exists and is live before attempting to take
> it.
> 
> The tree lookup and refcount increment are executed after taking the
> module_mutex to prevent the module from being unloaded after looking up
> the tree.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

It very much sounds like there is a desire to have this but without a
user, there is no justification.

> +bool try_module_get_safe(struct module *module)
> +{
> +	struct module *mod;
> +	bool ret = true;
> +
> +	if (!module)
> +		goto out;
> +
> +	mutex_lock(&module_mutex);

If a user comes around then this should be mutex_lock_interruptible(),
and add might_sleep()

> +
> +	/*
> +	 * Check if the address points to a valid live module and take
> +	 * the refcount only if it points to the module struct.
> +	 */
> +	mod = __module_address((unsigned long)module);
> +	if (mod && mod == module && module_is_live(mod))
> +		__module_get(mod);
> +	else
> +		ret = false;
> +
> +	mutex_unlock(&module_mutex);
> +
> +out:
> +	return ret;
> +}
> +EXPORT_SYMBOL(try_module_get_safe);

And EXPORT_SYMBOL_GPL() would need to be used.

I'd also expect selftests to be expanded for this case, but again,
without a user, this is just trying to resolve a problem which does not
exist.

  Luis

