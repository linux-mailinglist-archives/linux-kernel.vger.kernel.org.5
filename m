Return-Path: <linux-kernel+bounces-40700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5478083E452
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BCF1F214CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25E24B3C;
	Fri, 26 Jan 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KBBEz4pD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFF25564;
	Fri, 26 Jan 2024 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305989; cv=none; b=g4dVSGjuol/oIgHIA5VGg0h1cY8di51y8BncfL6ERaCTii8TTHOSN/4H/NtCSVGXz+rrAh/9ndBqt/E4Ef0snnKqNFaN/5h0ua3wAkWLLzTUCG4Sz72H7TmmmQmHV/RSNVuOz0kN5+zrov+VKgqt+zAIvN4JLsFrwFt4Cwv+fEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305989; c=relaxed/simple;
	bh=9k327QQG2HDaydtLeLEutpv3jMVdPncjoLezfwkNtxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUv7fhGYhTygPZDK99wio6p1mbcaNbLou+iE2o2ZTaUVyejSqwKygQBFIGszxpEbT2B5WpBV1RQVYkAHjtlqmUxtLSZZOBtgc2ULmqggI7jWXR0tg9+4lBp3QCDdt+OE2PqmXpB40Kx+0TkFwz2Y952vdlMm92NrO4KFk2Rvml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KBBEz4pD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CE5C433F1;
	Fri, 26 Jan 2024 21:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706305988;
	bh=9k327QQG2HDaydtLeLEutpv3jMVdPncjoLezfwkNtxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBBEz4pDjK8Em+U7V0cPVZIaOjSvnn8488GxJ5KRT+UaF52KrXLR6EXKXK5s5AFYc
	 kl6XvCtFwtVFe1gJmInfVUB0vPRt1/nyb0R153woM3uhSxW6aYoaBtzrw0jk8IObyV
	 B1/MpptV3aJuv0I34a6gNLXXGf1fH+gZtnQK6F3w=
Date: Fri, 26 Jan 2024 13:53:07 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Nathan Chancellor <nathan@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, llvm@lists.linux.dev, keescook@chromium.org
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Message-ID: <2024012655-poet-pruning-76d6@gregkh>
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
 <2024012636-clubbed-radial-1997@gregkh>
 <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>
 <20240126203436.GA913905@dev-arch.thelio-3990X>
 <0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net>

On Fri, Jan 26, 2024 at 01:01:15PM -0800, Guenter Roeck wrote:
> On 1/26/24 12:34, Nathan Chancellor wrote:
> > On Fri, Jan 26, 2024 at 10:17:23AM -0800, Guenter Roeck wrote:
> > > On 1/26/24 09:51, Greg Kroah-Hartman wrote:
> > > > On Fri, Jan 26, 2024 at 08:46:42AM -0800, Guenter Roeck wrote:
> > > > > On 1/22/24 15:55, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 5.10.209 release.
> > > > > > There are 286 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > > 
> > > > > [ ... ]
> > > > > 
> > > > > > zhenwei pi <pizhenwei@bytedance.com>
> > > > > >        virtio-crypto: implement RSA algorithm
> > > > > > 
> > > > > 
> > > > > Curious: Why was this (and its subsequent fixes) backported to v5.10.y ?
> > > > > It is quite beyond a bug fix. Also, unless I am really missing something,
> > > > > the series (or at least this patch) was not applied to v5.15.y, so we now
> > > > > have functionality in v5.10.y which is not in v5.15.y.
> > > > 
> > > > See the commit text, it was a dependency of a later fix and documented
> > > > as such.
> > > > 
> > > > Having it in 5.10 and not 5.15 is a bit odd, I agree, so patches are
> > > > gladly accepted :)
> > > > 
> > > 
> > > We reverted the entire series from the merge because it results in a build
> > > failure for us.
> > > 
> > > In file included from /home/groeck/src/linux-chromeos/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:10:
> > > In file included from /home/groeck/src/linux-chromeos/include/linux/mpi.h:21:
> > > In file included from /home/groeck/src/linux-chromeos/include/linux/scatterlist.h:5:
> > > In file included from /home/groeck/src/linux-chromeos/include/linux/string.h:293:
> > > /home/groeck/src/linux-chromeos/include/linux/fortify-string.h:512:4: error: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> > >                          __read_overflow2_field(q_size_field, size);
> > 
> > For what it's worth, this is likely self inflicted for chromeos-5.10,
> > which carries a revert of commit eaafc590053b ("fortify: Explicitly
> > disable Clang support") as commit c19861d34c003 ("CHROMIUM: Revert
> > "fortify: Explicitly disable Clang support""). I don't see the series
> > that added proper support for clang to fortify in 5.18 that ended with
> > commit 281d0c962752 ("fortify: Add Clang support") in that ChromeOS
> > branch, so this seems somewhat expected.
> > 
> 
> That explains that ;-). I don't mind if the patches stay in v5.10.y,
> we have them reverted anyway.

Ok, I'll leave them as-is for now, thanks.

greg k-h

