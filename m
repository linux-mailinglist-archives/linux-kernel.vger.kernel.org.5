Return-Path: <linux-kernel+bounces-35520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F83F839264
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAE2295CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B48A5FDC8;
	Tue, 23 Jan 2024 15:15:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BAD5FDBA;
	Tue, 23 Jan 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022934; cv=none; b=ZqOZ4a9YcxBloknQVuO3sExSyVYB/WPoNhapWRZfWWOqwT0tSZEba1J6fYnn900nAVfYuG0wZlPD7sn+AccXaWB0p+DnlHQsBXNfjpl+mV5mXjWgvscCOdfzYXtCCAt2ADLxIgo+Chn+5mKr0HMCFIJjZF4jIsYsVrw8oZuMKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022934; c=relaxed/simple;
	bh=asrlpI/aHrBldL7i2NaK3WIVv9olZl7qV7m2eNZxP3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPLelMP+6VEPeIktiA0lv2OaRlD0yxb5XF1j+Ha0fhV4/CFYAn/FSHsloSPoV6TXGe6v1ZUIyDwkgns/y4rRD8ZLYah/XovKUue3xFgOSA1Bri72z23Lgywz0CsXDilxF9y+ABouw7Oii/9qFrMeMho3rf0GuaKoATA2TnA2oxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E071FB;
	Tue, 23 Jan 2024 07:16:16 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2981B3F5A1;
	Tue, 23 Jan 2024 07:15:30 -0800 (PST)
Date: Tue, 23 Jan 2024 15:15:27 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Message-ID: <Za/YD/0a5Mn4IOAk@e133380.arm.com>
References: <20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org>
 <Zaqj0V82LD8wu6g+@e133380.arm.com>
 <Zaq1y9XpmzTsXDp8@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zaq1y9XpmzTsXDp8@finisterre.sirena.org.uk>

On Fri, Jan 19, 2024 at 05:47:55PM +0000, Mark Brown wrote:
> On Fri, Jan 19, 2024 at 04:31:13PM +0000, Dave Martin wrote:
> > On Fri, Jan 19, 2024 at 12:29:13PM +0000, Mark Brown wrote:
> 
> > > When we are in a syscall we will only save the FPSIMD subset even though
> > > the task still has access to the full register set, and on context switch
> 
> > (Pedantic nit: "A even if B" (= "A applies even in that subset of cases
> > where B"), instead of "A even though B" (= "A applies notwithstanding
> > that it is always the case that B") (?)  If the SVE trapping were
> > ripped out altogether, it would be a different and rather simpler
> > story...)
> 
> I really can't follow what you're trying to say here.  I'm not sure I
> where the bit about "always" comes from here?

The sentence seemed to me to be lacking some context, but I still
haven't fully familiarised myself with the changes to the code...

If it's what you intended to write and nobody else is confused, it's
probably good.


> > If the historical meanings of TIF_SVE have been split up (which seems a
> > good idea), does that resolve all of the "bare"
> > test_thread_flag(TIF_SVE) that were still there?
> 
> There's a couple more, but this is all of them in the signal handling
> code - I should have one or two more patches.  Most of the usage is
> actually checking the trapping and therefore fine.

I see, I guess this area needs keeping an eye on generally, but if there
are no more cases considered urgent then I guess that's fine for now
(modulo other patches in flight).

Cheers
---Dave

