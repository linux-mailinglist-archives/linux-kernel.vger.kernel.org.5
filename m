Return-Path: <linux-kernel+bounces-102572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF2087B403
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4277DB21FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603EB56777;
	Wed, 13 Mar 2024 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cn0HghnJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7255C35
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367142; cv=none; b=ef/tCqBdsVV3Hu/u/iwM/c2oBQJPn+MhTLQpdq6PyGaU4aHAlLUdnAvcmBvWcZUoxtpWzTOsfbkbCm955LLOplGU9wgJiWtXhnDq+FnZJ6h2ICzFSfFkE2QyMtuf+ovqrx2aGHpTEvzVWr5MPjMQkBjFOZdGgKa7S5icsmSsA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367142; c=relaxed/simple;
	bh=BQE9IeP/GP6C8PyCF/yXxGtUG2zp1kdGEXtMSFTIE9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k7xxTM2bnFLpHEYu7bmaujCEoWs2ooVp0bHnK9bGcoCBR2Vt5zAt7pTnKYvNo0CUomU290L5IAq9JRv9cFuStAv0FTuxgK8sA0Gbyq8RpYUtXjfpAqq7YuyYnM/iIORVVMSL9Dna6yqddanpny2CtlWPxqQlhqrYypi1KEjGwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=cn0HghnJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710367138;
	bh=58KkESeDPsHRbNx3kntj2Fa/IfuLFOWCJOevvMZ9NFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cn0HghnJvMFZRPw0P+io9IjHeIgs6/QwC17HjQ//7evaFzP0W027PIs3ksjlNuQnB
	 IrxQzIhnirVJEDKFqzyEVZx2ks8IgXp/hXzSxt1/Oo+gVyJXAQV5LADKb2cM1O92vF
	 +znXkkQfMZbhU6dgXerpdVtxOxQG48d3s6KnzMdtBBPxLJx2J0rvJ5aUec7qPhN5vs
	 R+91taN3agDZx4IHHDUjCSgbdf2g5bzsgrzIZj80sx63HrjYuB5neBs37PG2wvclMC
	 AtGZcEJWaklW4UoakfhPHYA/Ck2yFNVgEazJeZgHDKfSBWupH5oJKAoew2e6UMO+3V
	 GZ0bZjpuJIF8w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tw4Cg2VH3z4wcg;
	Thu, 14 Mar 2024 08:58:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "debug@rivosinc.com"
 <debug@rivosinc.com>, "luto@kernel.org" <luto@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "Liam.Howlett@oracle.com"
 <Liam.Howlett@oracle.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "peterz@infradead.org" <peterz@infradead.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "naveen.n.rao@linux.ibm.com"
 <naveen.n.rao@linux.ibm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v3 07/12] powerpc: Use initializer for struct
 vm_unmapped_area_info
In-Reply-To: <e9b5b322b451dfe2dde8da2b1240cf51f74b0541.camel@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-8-rick.p.edgecombe@intel.com>
 <dad7735d-dc57-4c89-a2b2-29d971f3cf69@csgroup.eu>
 <e9b5b322b451dfe2dde8da2b1240cf51f74b0541.camel@intel.com>
Date: Thu, 14 Mar 2024 08:58:51 +1100
Message-ID: <87wmq53ias.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:
> On Wed, 2024-03-13 at 06:44 +0000, Christophe Leroy wrote:
>> I understand from this text that, as agreed, this patch removes the 
>> pointless/redundant zero-init of individual members. But it is not
>> what 
>> is done, see below ?
>
> Err, right. I think I decided to leave it because it was already acked
> and there wasn't enough discussion on the ack to be sure. I will update
> it.

That's fine by me, you can keep my ack.

cheers

