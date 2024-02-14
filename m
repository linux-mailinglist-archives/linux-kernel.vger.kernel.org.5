Return-Path: <linux-kernel+bounces-65683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6984F85505E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258F628E3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862B28528C;
	Wed, 14 Feb 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c0iUHQul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10F8526E;
	Wed, 14 Feb 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931839; cv=none; b=FkDnkqZnppEOyT1FNRV8P5QKAUndMKhhWm1UUm10vnp5q1N8P7u364ZEyA+xr2AxQxUvWsH77vZk3Hn21KOfJ4WODTkplsjxieblFlpSnfs00m0iYwq9QPuJXJYEvpb/y9RwSd2sd0dSDV6/B5g/3vtN4KaFPImNUSTztVRf9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931839; c=relaxed/simple;
	bh=beUUffneuudJkacRV0x7r7IuQSNqrKmc2NrDlT8aag4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WajeZMcH3DZIgtQA3Vl1FC4wqrTkopmPOHFFLxd3mn/6OcxU8J4qWrGrTHhriCvMClEx1TtTOlieWKu0YocwF6OAER9R1CCs1tN525iTxv6dHlRlZ/0mWK9QHY6CNOiBBGPypa99bmdh33BdGbqNWFAref8KvNHhGFwWc3yo7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=c0iUHQul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD322C433F1;
	Wed, 14 Feb 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c0iUHQul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1707931835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=beUUffneuudJkacRV0x7r7IuQSNqrKmc2NrDlT8aag4=;
	b=c0iUHQulPwcOVLCrAm9mAJdG8jKvao5q59BoHylqGh55fJNjjfaINH1+t5a+eTfmKU+TET
	pFIFPtgdPRi5zrH/8Nj+4mUv6h0IUH6OHZtacxYXWeCJwVPnHy1BizSRvSdCEqJT4Yev1i
	SCyyd+zj8yLuISQWCck1FW/fq9hEjYk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4ac7b6d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Feb 2024 17:30:35 +0000 (UTC)
Date: Wed, 14 Feb 2024 18:30:35 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <Zcz4u9NXtnn4RP4Q@zx2c4.com>
References: <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu>
 <Zb4RlTzq_LV7AzsH@zx2c4.com>
 <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
 <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>

On Mon, Feb 12, 2024 at 08:25:33AM +0000, Reshetova, Elena wrote:
> So the change would be around adding the notion of conditional entropy
> counting (we will always take input as we do now because it wont hurt),
> which would automatically give us a correct behavior in _credit_init_bits()
> for initial seeding of crng.

I basically have zero interest in this kind of highly complex addition,
and I think that'll lead us back toward how the RNG was in the past.
"Entropy counting" is mostly an illusion, at least in terms of doing so
from measurement. We've got some heuristics to mitigate "premature
first" but these things will mostly only ever be heuristic. If a
platform like CoCo knows nothing else will work, then a
platform-specific choice like the one in this patch is sufficient to
do the trick. And in general, this seems like a weird thing to design
around: if the CPU is actually just totally broken and defective, maybe
CoCo shouldn't continue executing anyway? So I'm pretty loathe to go in
this direction of highly complex policy frameworks and such.

Anyway, based on your last email (and my reply to it), it seems like
we're mostly in the clear anyway, and we can rely on RDRAND failure ==>
hardware failure.

Jason

