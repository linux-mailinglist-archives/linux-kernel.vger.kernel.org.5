Return-Path: <linux-kernel+bounces-86180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA286C0BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2EE1F23215
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB04439F;
	Thu, 29 Feb 2024 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WAcKx9BD"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6638388
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188503; cv=none; b=YCv0pycM791Be4f9Jm85tyyAvD3wRXRBUYIHPaLIvGZ21P2/zLs6WpObThTVy0SXJ6yjZr5uaSk4l5VdBVvbpRppvkhbz8qgU0o/kSv9/9c7ddhiz8vQ/dYfr1p6asvKTK3K84E1W2FtIXRplJnw6gT0tSe4sqmhJeIuku7KEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188503; c=relaxed/simple;
	bh=swc6S+6Yo6A0fPMSHvrIlHvikCcbyQH5FEQv0jRzSdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiOPJPutoPKoBWnEeg63+xjaUS9gntZaNd4sa/rCD8CrB+1F+DAoXPwuIljUznwRKzqxjohMLyOkpOAbB/UmgOvOk0aSxdJpMacj/cX0P0pUSq3ZxwrAyIchs5JR0ht7b3NpaXnZwedWgghLNxUiVYld2p+tA7UnQ9Kyd/J3DyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WAcKx9BD; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 06:34:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709188499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTjPglRVl0w4hyzMuzLiZwXuKasvFFVk+iNhHkjufl4=;
	b=WAcKx9BDUlNys6P6xwDTTnNX85oOId7KD1Mp6WYwv3ie1zNnkbYXqlhh+/PlOw8KJpr7S7
	tyKniqORvtv2F5hUQBbtBFRvvi5nLW+NUUUIIOh/NBdIZ2+l+QSFfFZjAmmb46lRX4BCcB
	MBzSPAV4YqFUIUnakHFZP6j/pkbZlHY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Mark Brown <broonie@kernel.org>, Thomas Huth <thuth@redhat.com>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Shaoqin Huang <shahuang@redhat.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Move setting a vCPU's entry point
 to a dedicated API
Message-ID: <ZeAlj14TCnpR-G15@linux.dev>
References: <20240208204844.119326-1-thuth@redhat.com>
 <20240208204844.119326-4-thuth@redhat.com>
 <501ac94d-11ab-4765-a25d-75013c021be6@sirena.org.uk>
 <Zd-JjBNCpFG5iDul@google.com>
 <Zd-jdAtI_C_d_fp4@google.com>
 <Zd-lzwQb0APsBFjM@linux.dev>
 <CAJHc60xqbrH5cgSm5URhxF1j-+X7PVD1WkqEBRKENo-GeQnsnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHc60xqbrH5cgSm5URhxF1j-+X7PVD1WkqEBRKENo-GeQnsnQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 28, 2024 at 03:00:03PM -0800, Raghavendra Rao Ananta wrote:

[...]

> I sent out a patch in the past to get rid of them [1], but Shaoqin is
> currently making an effort to (fix and) use them in their tests [2].
> While we are still reviewing the series, we can apply [1] to unblock
> enabling -Werror and Shaqoqin can re-introduce the functions as
> needed. But, it's your call.

Thanks for the brief, now I remember :) Agreed, let's just delete these
upstream. These accessors are simple anyway, and easy to re-review in
Shaoqin's tests.

Sean -- I'm going to pick up [1] and throw it on the branch with your
cleanup.

-- 
Thanks,
Oliver

