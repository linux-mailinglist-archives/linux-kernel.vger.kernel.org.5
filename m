Return-Path: <linux-kernel+bounces-102437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7383687B1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4691F29316
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A245675F;
	Wed, 13 Mar 2024 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7Y0Qzrf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333A5644B;
	Wed, 13 Mar 2024 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358149; cv=none; b=PtdU+qi+2LYCD2xh5ZxwoEF8k2ZDewsWfFZpE0VPJMs5rVjabWXO5Xa0mwUBnykI1oKQdWh2t5WE07TSxGln/X1/cS5oV+066cZRaiQ1UykLw0FB4EPe9tIqzmIFXayIYPZQtm79T6ecfOGggnMAZ1hMR4LEtTKbCMgHjfol5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358149; c=relaxed/simple;
	bh=h9h9UxoZjbTVUIm/ZWHss0y6ukTkc84GVGIvZ6PPHrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PpMLcgAnUy1lisS255IY6tHimL1fMb+ZFrlnwpFmZmlURfSEQ75URUki0TdjwdWveWB082ECbpbjUSb39IxA+FYhyYVi0J6AfqPmGmJ4deyHM2LVu2KMsERgSun2jLSKjLg5DrAYqlUvpS2UJ22uv/WuSRk2oLh1YykDbAfwWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7Y0Qzrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363BBC433C7;
	Wed, 13 Mar 2024 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358148;
	bh=h9h9UxoZjbTVUIm/ZWHss0y6ukTkc84GVGIvZ6PPHrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=P7Y0Qzrf1TVhSoMmtjUoO2rEIAXU4hs6xy3VoTi3WM1UkJuXd0L1vl3KxzsQbPPm7
	 /CcBUCR0Neg9vKZwiYyZKPIeiUaO8C3jJj2uFi2PPp4KIPGXBPPyceHTgSyPCM9Qob
	 3Ph84uN5yf8zhttNIn2M55IZKvLnvsK4CoNWw5z/e0Xja7mChQCdgFQVm0OGu2iU4X
	 jlBfT0/J63XD1hvAwp9u7nj/q6jsVZgs7YxCmNBjwbnxHq5uKh+Ajlb53p0EFW7Wgw
	 637MMPVO/PVhxudXtLI0EOwXsAhVj7fRsEJVh4kkugw5LCFS0/nmr1KIWv+KnGLSpP
	 fYCYCv6aKrKIA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  linux-spi@vger.kernel.org,  Mark Brown
 <broonie@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,  Mika
 Westerberg <mika.westerberg@linux.intel.com>,  "Chia-Lin Kao (AceLan)"
 <acelan.kao@canonical.com>,  open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Fix error code checking in spi_mem_exec_op()
In-Reply-To: <9420b802-5361-4f47-a069-52c43f5fd253@broadcom.com> (Florian
	Fainelli's message of "Wed, 13 Mar 2024 11:37:45 -0700")
References: <20240313171050.3505620-1-florian.fainelli@broadcom.com>
	<CZSSWP7A9UM7.1R20796VHLU0F@kernel.org> <mafs0o7bic7fs.fsf@kernel.org>
	<9420b802-5361-4f47-a069-52c43f5fd253@broadcom.com>
Date: Wed, 13 Mar 2024 20:29:05 +0100
Message-ID: <mafs0il1qc4n2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 13 2024, Florian Fainelli wrote:

> On 3/13/24 11:28, Pratyush Yadav wrote:
>> On Wed, Mar 13 2024, Michael Walle wrote:
>>
>>> On Wed Mar 13, 2024 at 6:10 PM CET, Florian Fainelli wrote:
>>>> After commit cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with
>>>> -EOPNOTSUPP"), our SPI NOR flashes would stop probing with the following
>>>> visible in the kernel log:
>>>>
>>>> [    2.196300] brcmstb_qspi f0440920.qspi: using bspi-mspi mode
>>>> [    2.210295] spi-nor: probe of spi1.0 failed with error -95
>>>>
>>>> It turns out that the check in spi_mem_exec_op() was changed to check
>>>> for -ENOTSUPP (old error code) or -EOPNOTSUPP (new error code), but this
>>>> means that for drivers that were converted, the second condition is now
>>>> true, and we stop falling through like we used to. Fix the error to
>>>> check for neither error being neither -ENOTSUPP *nor* -EOPNOTSUPP.
>>>>
>>>> Fixes: cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP")
>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>> Change-Id: I4159811f6c582c4de2143382473d2000b8755872
>>>
>>> Ha, thank you!
>>>
>>> Reviewed-by: Michael Walle <mwalle@kernel.org>
>>>
>>> FWIW in next, there is commit
>>> e63aef9c9121e ("spi: spi-mem: add statistics support to ->exec_op() calls")
>>> that probably will conflict with this one.
>>>
>>> Also, - not for this patch - but with that logic, spi_mem_exec_op()
>>> might return EOPNOTSUPP *or* ENOTSUPP, even for drivers which might
>>> still return ENOTSUPP, because there is one condition in
>>> spi_mem_exec_op() which will always return EOPNOTSUPP. That is
>>> somewhat confusing, no?
>> I agree. I suppose it would be better to do:
>>      if (!ret)
>>         return 0;
>>      if (ret == -ENOTSUPP || ret == -EOPNOTSUPP)
>>         return -EOPNOTSUPP;
>>
>
> But with e63aef9c9121e ("spi: spi-mem: add statistics support to ->exec_op()
> calls") applied, would not that mean duplicating the statistics gathering, or
> were the statistics gathering only intended for when ret == 0?

Hmm, I didn't properly understand this. Ignore my suggestion. Your patch
does the right thing.

In this case we should return ret when:

    ret is 0
    OR
    when ret is not -EOPNOTSUPP or -ENOTSUPP.

So if we get either of the two we _won't_ return and continue forward.

From looking at just this, spi_mem_exec_op() only returns -EOPNOTSUPP so
far since it has:

	if (!spi_mem_internal_supports_op(mem, op))
		return -EOPNOTSUPP;

But then looking further, it has:

	ret = spi_sync(mem->spi, &msg);

	if (ret)
		return ret;

spi_sync() can return -ENOTSUPP if it goes via __spi_async(). I suppose
we would need to fix that if we want consistent return codes. But that
isn't a problem this patch should fix. So with the merge conflict fixed
up,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

