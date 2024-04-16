Return-Path: <linux-kernel+bounces-146867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 863678A6C12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1072CB215EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF17612C489;
	Tue, 16 Apr 2024 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oauJhRl1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E112C46F;
	Tue, 16 Apr 2024 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273732; cv=none; b=MACaickG5J54CddLfFOEN7UTyq+dYtNsV3fZwh2Y800ghG5bZYii8QQYMuga2tNwGxVAevFak5LvsFFr/d0K4m03A/9LyjjDMVvf+VtUHC0A0XQ4K9V/kTCMU41o3c3cZpawaVq7gXyuUl2UGaQx+xA6cx4+wpbw+8snQO8UXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273732; c=relaxed/simple;
	bh=BFQljuMVTClNVjDMuw/IrsqPjuJUXCtl5zc7GQU7tpc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQq7ANhppeWgpvF2/WAbcAQeNe7u2NKSyNjDHjemrs1B/YaPA8cTPJy0+C+ilZmCYg8SYiSVCsZolvnO6rWbNphFHXSNQo/59bg8VbEuOiS9nY9rFWDC6GcGN40m8ZIK+/RF1wpnOvAULikLBDin4QhXcZFi53eK4cx4EeHF70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oauJhRl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71870C113CE;
	Tue, 16 Apr 2024 13:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713273731;
	bh=BFQljuMVTClNVjDMuw/IrsqPjuJUXCtl5zc7GQU7tpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oauJhRl1Ng77wYskusi1RAwDUu9MXz1hjLryHTHiIjNl+n07VIKjCIKuf5Rln5CyE
	 2gA4nJVd0uzIKIzITAsuRNX6paoUyGBTKJaDjh6G8WokgClf66H6t0Fr7L9Fa7/pio
	 /unsiVNAqhRLIH6Av0WwQ5DFAjaH/a6qJlNCpjVbepAdLHj2MoLEaCqPlgtLvj9kys
	 BX33QuZ9EE61exWHDkJSmNN3FM8066NUaRkWbqi+WHAXDI4+xEfI2B0q8kPEc2DBAQ
	 IVh4+44AzezZ4+AufuewqjR2IY48LH7b0S0TZieuvLhjtA947mb52eL5YFdfkmDlL3
	 vRYdts8WbjeHg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rwilF-0051lu-82;
	Tue, 16 Apr 2024 14:22:09 +0100
Date: Tue, 16 Apr 2024 14:22:07 +0100
Message-ID: <86y19dqw74.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	Yihuang Yu <yihyu@redhat.com>,
	Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
In-Reply-To: <CA+G9fYu-AjRm-BBA=8fWS8oCbBJ5W443JHPh3uddD7ea7MY-YA@mail.gmail.com>
References: <20240415141953.365222063@linuxfoundation.org>
	<Zh5UJh31PlBkpZWd@finisterre.sirena.org.uk>
	<CA+G9fYu-AjRm-BBA=8fWS8oCbBJ5W443JHPh3uddD7ea7MY-YA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: naresh.kamboju@linaro.org, gregkh@linuxfoundation.org, broonie@kernel.org, stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, yihyu@redhat.com, gshan@redhat.com, catalin.marinas@arm.com, ryan.roberts@arm.com, anshuman.khandual@arm.com, shahuang@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, anders.roxell@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 16 Apr 2024 14:07:30 +0100,
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> 
> On Tue, 16 Apr 2024 at 16:04, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Mon, Apr 15, 2024 at 04:19:25PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.6.28 release.
> > > There are 122 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> >
> > The bisect of the boot issue that's affecting the FVP in v6.6 (only)
> > landed on c9ad150ed8dd988 (arm64: tlb: Fix TLBI RANGE operand),
> > e3ba51ab24fdd in mainline, as being the first bad commit - it's also in
> > the -rc for v6.8 but that seems fine.  I've done no investigation beyond
> > the bisect and looking at the commit log to pull out people to CC and
> > note that the fix was explicitly targeted at v6.6.
> 
> Anders investigated this reported issues and bisected and also found
> the missing commit for stable-rc 6.6 is
> e2768b798a19 ("arm64/mm: Modify range-based tlbi to decrement scale")

Which is definitely *not* stable candidate. We need to understand why
the invalidation goes south when the scale go up instead of down.

	M.

-- 
Without deviation from the norm, progress is not possible.

