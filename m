Return-Path: <linux-kernel+bounces-37086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB49A83AB55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D50290AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE287A707;
	Wed, 24 Jan 2024 14:04:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3959F7A701;
	Wed, 24 Jan 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105093; cv=none; b=riB4QXUz6HTOBlGGTrmCesq3lrb7y45H3URHPnVueigAsumbjFdqLghrQb5tbQ9wOJoUFGQ/zXYP8Z2JOScPaBNexj96NTwBD8XkYhDb3zZjNM/1lnqY4KP+0JtvUrBafVAXSxRnWegINGe/WDj5xPUySt+9FHsr0Yi2dt++WCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105093; c=relaxed/simple;
	bh=GgyKihouqlIoqQ51JN3lEJ59Za58IW34ydt615YzQ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mohvs05fhO+vb0zbH8boOYN6EDgFwLXJ0wd7U/DP8U42bUgxBd18G30s//SkmhYOFrPRPElJpat26dqtD8Vn/+jXddXsE8rDjVyi2+LRdewNdH6SZLDIgNZ0SV3NBhGYrgOxQpkFeEQUknG2gKrp66oMg4Dn3tX8US40OB8Kupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 822B81FB;
	Wed, 24 Jan 2024 06:05:35 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44E503F5A1;
	Wed, 24 Jan 2024 06:04:49 -0800 (PST)
Date: Wed, 24 Jan 2024 14:04:42 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH 1/4] arm64/sve: Remove bitrotted comment about syscall
 behaviour
Message-ID: <ZbEY+n11M9lQGsWA@e133380.arm.com>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
 <20240122-arm64-sve-sme-doc-v1-1-3d492e45265b@kernel.org>
 <Za/e15zUOEaa1b7d@e133380.arm.com>
 <991d84b4-e184-4fd6-900f-601f8c31d518@sirena.org.uk>
 <Za/9SawqwXmlG/9B@e133380.arm.com>
 <ede05e2d-0cde-4de1-b2db-d40df19d7075@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ede05e2d-0cde-4de1-b2db-d40df19d7075@sirena.org.uk>

On Tue, Jan 23, 2024 at 06:11:52PM +0000, Mark Brown wrote:
> On Tue, Jan 23, 2024 at 05:54:17PM +0000, Dave Martin wrote:
> 
> > I still feel that it is iffy practice for userspace to rely on the
> > extra bits being zeroed -- I think the architecture hides this
> > guarantee anyway whenever you go through a function call confirming to
> > the regular procedure call standard (including the syscall wrappers).
> > But there may not be a lot of point trying to put people off if we
> > can't force them not to rely on it.
> 
> I do tend to agree that the requirement to zero is excessively zealous
> and that the risk from relaxing it is minor (it's stricter than the
> function call ABI), I did leave a sysctl as a mechanism for restoring
> compatibility in the case where we did run into issues in my original
> series but I didn't expect to need it.  If you convince everyone else
> I'd be happy to relax things but I don't super care either way.

[...]

I don't feel that strongly about it.

Ideally we'd have gone for the fully relaxed approach from the start,
but it's hard to test whether "unspecified" registers aren't leaking
data from somewhere they shouldn't.

Given that the decision has been made anyway, the documentation should
not send mixed messages, so:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>


