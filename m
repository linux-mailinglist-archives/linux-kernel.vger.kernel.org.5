Return-Path: <linux-kernel+bounces-102362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F4587B129
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AF21C274BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5674434;
	Wed, 13 Mar 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqV5KWO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB33605C9;
	Wed, 13 Mar 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354522; cv=none; b=ih+X2N1uMH1i16GzsdQwNOA7GVMFl3AEqo6vBy0VFsWrr6PD//j/KH5oo5DTr74RS7RyTRsopAmUJ1BQbxrznIc8C49NsbVeBIifl1w+9AcvVTWvYR5EhogPFZLIADXk/ocg0KXuDHk9HN8TSbNITg5N15g/nM6OzkcbP8WlDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354522; c=relaxed/simple;
	bh=8c46Ddm+M3G7HzCxiWUy4bEUiZ5m8S+IZPbMBMBuPJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cbKstgSrEYXZzrmcuLgD//DWAxbDDOWabCGNsPfnmGTcubIPbnn7/FG5wpWNH+YSNP4rg7ktuKxJqDg/VlXmJJMZ15kiS3VmcmwTAwbzIwkpFKt4CX2dXXyqPT6JgkEQrMtlQR1cEE76MZQamLChfVYg5eM8eMefmkA4mBfyKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqV5KWO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526EEC433C7;
	Wed, 13 Mar 2024 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710354521;
	bh=8c46Ddm+M3G7HzCxiWUy4bEUiZ5m8S+IZPbMBMBuPJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nqV5KWO65GQo3l2x/bNNfnDHZnbKxC1PYbVFOhCnnRwO/3xiwpd+9Bi32wL/8vS+N
	 coGhT/k6KIZDam72TcLx8zuyIwsVRGpy36wkLsFYURUCP3pTLJ9txpVNz7qy0SU5Wb
	 qUdXWwV8TtOjFWCKy8apIcBTxYiR5JkJM+UEggkcRfyBYFy9YtZiinU/lC0uzKIEvT
	 BnNXaFA3zfG7H+Uz/Di5Wf3S33sLVVsHVWUE6jt4RIOYcmnAC6ND8mzoucbR2eqPdY
	 y0MokxFyiAoOweSvytqG07GHefy8DBVvEMCH/1L/ioAt2mSL1o2EXUCmI6k8BM6sOb
	 K7e5JN8F1nNyA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Florian Fainelli" <florian.fainelli@broadcom.com>,
  <linux-spi@vger.kernel.org>,  "Mark Brown" <broonie@kernel.org>,  "Miquel
 Raynal" <miquel.raynal@bootlin.com>,  "Mika Westerberg"
 <mika.westerberg@linux.intel.com>,  "Chia-Lin Kao (AceLan)"
 <acelan.kao@canonical.com>,  "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Fix error code checking in spi_mem_exec_op()
In-Reply-To: <CZSSWP7A9UM7.1R20796VHLU0F@kernel.org> (Michael Walle's message
	of "Wed, 13 Mar 2024 18:33:43 +0100")
References: <20240313171050.3505620-1-florian.fainelli@broadcom.com>
	<CZSSWP7A9UM7.1R20796VHLU0F@kernel.org>
Date: Wed, 13 Mar 2024 19:28:39 +0100
Message-ID: <mafs0o7bic7fs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 13 2024, Michael Walle wrote:

> On Wed Mar 13, 2024 at 6:10 PM CET, Florian Fainelli wrote:
>> After commit cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with
>> -EOPNOTSUPP"), our SPI NOR flashes would stop probing with the following
>> visible in the kernel log:
>>
>> [    2.196300] brcmstb_qspi f0440920.qspi: using bspi-mspi mode
>> [    2.210295] spi-nor: probe of spi1.0 failed with error -95
>>
>> It turns out that the check in spi_mem_exec_op() was changed to check
>> for -ENOTSUPP (old error code) or -EOPNOTSUPP (new error code), but this
>> means that for drivers that were converted, the second condition is now
>> true, and we stop falling through like we used to. Fix the error to
>> check for neither error being neither -ENOTSUPP *nor* -EOPNOTSUPP.
>>
>> Fixes: cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP")
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> Change-Id: I4159811f6c582c4de2143382473d2000b8755872
>
> Ha, thank you!
>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
>
> FWIW in next, there is commit
> e63aef9c9121e ("spi: spi-mem: add statistics support to ->exec_op() calls")
> that probably will conflict with this one.
>
> Also, - not for this patch - but with that logic, spi_mem_exec_op()
> might return EOPNOTSUPP *or* ENOTSUPP, even for drivers which might
> still return ENOTSUPP, because there is one condition in
> spi_mem_exec_op() which will always return EOPNOTSUPP. That is
> somewhat confusing, no?

I agree. I suppose it would be better to do:

    if (!ret)
       return 0;

    if (ret == -ENOTSUPP || ret == -EOPNOTSUPP)
       return -EOPNOTSUPP;

-- 
Regards,
Pratyush Yadav

