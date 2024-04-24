Return-Path: <linux-kernel+bounces-157128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3318B0D31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB436287B42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C702F15ECF7;
	Wed, 24 Apr 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PsLWA4oe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB2D15EFDF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970313; cv=none; b=eUiZEs7pyv3m8DBbtkznnlTPC06OV2d4H3Sul5t6YoIPVNz7YW/ssTVzVkPJ6vOHjZPqFYttE/rwVwedrGMmwqkwYbpZ60/mRvnj+6NMDxoXFi/8jknPlaIt7Q0SzR6E9pPFHWhXaDsxNswgnaWvgLOqojuwn28DxBpn7v1WvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970313; c=relaxed/simple;
	bh=LhsJcsPYkmC1C8NWMoV9t3a0TrX/fu9kJZuNQtERuRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaDlr82iRRv5iattVBAlNQbgd03+o+1p5td7cdKkpEG8eJVs6s0hjSVJOXGxqn9T24Y3Vfv8ddaB4OwKwXL9SN0+k/RtMzvc+PyHi8op7+g4IW2K3oXIJiQLhev2WBID0TQFE+n30ypsDxTK/rPfvBHhV2qtCPKQyAfFr0UOrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PsLWA4oe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1EA2E40E0177;
	Wed, 24 Apr 2024 14:51:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FLV5n242awhg; Wed, 24 Apr 2024 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713970305; bh=hAzgTdW20PH8p2TSvQDh/sf526Oq7pqMUYP84FyR6+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsLWA4oeHhE1aKts/WuRjHM5YGSItzza5+A7EtRPfUalEAza7A4eT/wCqKrkjtVAJ
	 Bu+paApzhfU8mIQx+T15513wLpMsBfcVD+xGPv3HCtrVVEaASwj7ujZtjLKjatglhF
	 TYtEo76RZCbRHZHlpaTacn/gbT/CzLrzimhUpRZ91nYkXIiCdJ1zKvbec3b8cYUVwu
	 uAkXyQO6JI3LpCIn831pSy8UZocD4hLsM9zBASEoh5cHPPzjbHmJcdYFsKo8FYwL+b
	 IpLLslb9O/yhwD+HOPEdOvrzPykVBVbMV3Anb3vKoa8nam13um74MPbOdJgYAmFlbH
	 mgI+MMopUxh1af0NFhU7FkKIeZDHDVCZnDwtq48QwD06iYxVb0Ndfh+PvH4j4D3t06
	 93+vso7mtQ27ZjEO9FZ246qrt/YdLRhkqGz8lrMUT28Sb/TG5WpvCLYJ5LxxgQA45D
	 7o8W1mDGYtfg6pqRaFokPSNMJrkVg6BmbcT78sL0U6O8n04wAuodP8gmaPg0izFtGE
	 mscySG9g3QOxGHk+c+0Kr8QiiHFCk2jiNxuAV0vCtPFNe+JUnLQ/KJ/O87zsxrRfJh
	 TfylnRkDMqu/zghw53T1O3Piq07mo6c3qKwDpidI1yfdyiS7+1nhR5czcTu1mnGwyQ
	 ahGVBjRQJnbFzikoFk0c4eJI=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4031C40E00C7;
	Wed, 24 Apr 2024 14:51:23 +0000 (UTC)
Date: Wed, 24 Apr 2024 16:51:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 04/18] cpu/hotplug, x86/acpi: Disable CPU offlining
 for ACPI MADT wakeup
Message-ID: <20240424145122.GEZikcaiqFT_eG1KDo@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
 <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
 <k4t62qfiyapfh2hjp4bpnaa4bmtlajpm5q4an3qs4jimhldcwv@wtrp63ofrfk6>
 <20240424135052.GDZikOPIOeGxtQRBBc@fat_crate.local>
 <svpuqhoglv7s2wtu754i4oicowueen47vq6eobjbznsromb4m3@4h7vy346n4ak>
 <e1a71955-5228-47fe-9241-dd0197d4a552@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1a71955-5228-47fe-9241-dd0197d4a552@intel.com>

On Wed, Apr 24, 2024 at 07:40:26AM -0700, Dave Hansen wrote:
> On 4/24/24 07:35, Kirill A. Shutemov wrote:
> >> Also, does this need to go to stable although it is kinda big for
> >> stable. If stable, do we need a smaller fix first which is backportable?
> > Correct me, if I am wrong, but I believe TDX guest is the only user of
> > ACPI MADT wake up method. At least it was added into kernel for TDX guest.
> > So it wouldn't fix anything user-visible. It might affect a future
> > platform that uses this wake up method, but it is a guessing game.
> 
> Yeah, the MADT wakeup is pretty funky, highly TDX specific, and not in
> use or planned to be _put_ into use anywhere else.

Then please make sure all that info is in the commit messages in the
next revision. Because as they are now, they're not even beginning to
explain what exactly is this fixing. /me thinking that this is some
generic fix needed in stable is case-in-point.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

