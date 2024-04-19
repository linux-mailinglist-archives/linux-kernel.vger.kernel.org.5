Return-Path: <linux-kernel+bounces-151327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76DA8AACFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FC5282908
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ECA7F47C;
	Fri, 19 Apr 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WeC3+ENv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661B7C0A9;
	Fri, 19 Apr 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523239; cv=none; b=IHTT7AZ/3HTo06/GtO6DFjC84MUcWDckjC6jG1VSTXRj1EZVchZDvrgER0CihxSB9rCmdP09gM1PQRIvPyP1bg7z7uoBn9DKRTbp3gsCJK2m6DcJMS60X1iiQVUUsU0Lov+ZMUOsEcbkxM0heNmYOZ25URezoS7JH+eLrFjVj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523239; c=relaxed/simple;
	bh=ri/VNF8+x+uUhczJHngVNn6oFRLkfNLj0bwKqlWZIzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dncCYMYTyPuCtDrJmIR/VghQF/HIGNVOT0VOZCXi9qIAGxs3/mI5i3zI8N5dJ0qKuC6Xl2EcIf2Vj6IrquiLIu26oqeZ+lsdCubGQkuaBxWYqrIwoP8/qkryVbxbFsDhNv1uHB9EAF9uir40pMr4z4z79DhU9LSY/tVAClNkVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WeC3+ENv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEF6C072AA;
	Fri, 19 Apr 2024 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713523238;
	bh=ri/VNF8+x+uUhczJHngVNn6oFRLkfNLj0bwKqlWZIzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WeC3+ENvz+TN27Esdm/RbWH+MG+s52+P+bjha7fh95m1E0R3zZqhRs5qy7O1L7AoZ
	 WH+9c+FL/fcXE9NtLidlL68LN3n4sZwxNLAm981tf8xB0NB0z5p7RQ3D9KibYOSWSi
	 XbSt5h9BofkxGJLzcOEQfHvCt42ap4UBvBJKKhb0=
Date: Fri, 19 Apr 2024 12:40:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, Yihuang Yu <yihyu@redhat.com>,
	Gavin Shan <gshan@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shaoqin Huang <shahuang@redhat.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
Message-ID: <2024041921-drown-dizzy-7481@gregkh>
References: <20240415141953.365222063@linuxfoundation.org>
 <Zh5UJh31PlBkpZWd@finisterre.sirena.org.uk>
 <CA+G9fYu-AjRm-BBA=8fWS8oCbBJ5W443JHPh3uddD7ea7MY-YA@mail.gmail.com>
 <86y19dqw74.wl-maz@kernel.org>
 <Zh61KobDt_y1O46-@arm.com>
 <86sezjq688.wl-maz@kernel.org>
 <ZiECLaXHce05DSM6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiECLaXHce05DSM6@arm.com>

On Thu, Apr 18, 2024 at 12:21:17PM +0100, Catalin Marinas wrote:
> On Thu, Apr 18, 2024 at 12:07:35PM +0100, Marc Zyngier wrote:
> > On Tue, 16 Apr 2024 18:28:10 +0100,
> > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Tue, Apr 16, 2024 at 02:22:07PM +0100, Marc Zyngier wrote:
> > > > On Tue, 16 Apr 2024 14:07:30 +0100,
> > > > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > > On Tue, 16 Apr 2024 at 16:04, Mark Brown <broonie@kernel.org> wrote:
> > > > > > On Mon, Apr 15, 2024 at 04:19:25PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > This is the start of the stable review cycle for the 6.6.28 release.
> > > > > > > There are 122 patches in this series, all will be posted as a response
> > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > let me know.
> > > > > >
> > > > > > The bisect of the boot issue that's affecting the FVP in v6.6 (only)
> > > > > > landed on c9ad150ed8dd988 (arm64: tlb: Fix TLBI RANGE operand),
> > > > > > e3ba51ab24fdd in mainline, as being the first bad commit - it's also in
> > > > > > the -rc for v6.8 but that seems fine.  I've done no investigation beyond
> > > > > > the bisect and looking at the commit log to pull out people to CC and
> > > > > > note that the fix was explicitly targeted at v6.6.
> > > > > 
> > > > > Anders investigated this reported issues and bisected and also found
> > > > > the missing commit for stable-rc 6.6 is
> > > > > e2768b798a19 ("arm64/mm: Modify range-based tlbi to decrement scale")
> > > > 
> > > > Which is definitely *not* stable candidate. We need to understand why
> > > > the invalidation goes south when the scale go up instead of down.
> > > 
> > > If you backport e3ba51ab24fd ("arm64: tlb: Fix TLBI RANGE operand")
> > > which fixes 117940aa6e5f ("KVM: arm64: Define
> > > kvm_tlb_flush_vmid_range()") but without the newer e2768b798a19
> > > ("arm64/mm: Modify range-based tlbi to decrement scale"), it looks like
> > > "scale" in __flush_tlb_range_op() goes out of range to 4. Tested on my
> > > CBMC model, not on the actual kernel. It may be worth adding some
> > > WARN_ONs in __flush_tlb_range_op() if scale is outside the 0..3 range or
> > > num greater than 31.
> > > 
> > > I haven't investigated properly (and I'm off tomorrow, back on Thu) but
> > > it's likely the original code was not very friendly to the maximum
> > > range, never tested. Anyway, if one figures out why it goes out of
> > > range, I think the solution is to also backport e2768b798a19 to stable.
> > 
> > I looked into this, and I came to the conclusion that this patch is
> > pretty much incompatible with the increasing scale (even if you cap
> > num to 30).
> 
> Thanks Marc for digging into this.
> 
> > So despite my earlier comment, it looks like picking e2768b798a19 is
> > the right thing to do *if* we're taking e3ba51ab24fd into 6.6-stable.
> > 
> > Otherwise, we need a separate fix, which Ryan initially advocating for
> > initially.
> 
> My preference would be to cherry-pick the two upstream commits than
> coming up with an alternative fix for 6.6.

To be specific, which 2 commits, and what order?

thanks,

greg k-h

