Return-Path: <linux-kernel+bounces-69054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D588583E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54CA1C22BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB83131E3D;
	Fri, 16 Feb 2024 17:14:37 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F350F130E2F;
	Fri, 16 Feb 2024 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103677; cv=none; b=GHKxYsDTqg/Y1r3r7i5ijqa7hi6VhGWg1q6ugIlsmoU1i2wrMV+R1AhVhHaXD6GcQzOJm8upEqQmhlBvgihJvXy+lC3quqTID5FqOTY8nCt+JOjNPdnnaCFPTiSLB8csUK3Ab5+k8HPf2wDuuwQV3Q7OLdUaNM7iHSct6Ko+AxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103677; c=relaxed/simple;
	bh=rmDRwiwblhwvtwuvm75M2GVP+g+7jtMynVV9YVddlKM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4YLo7lEewiCekvrjejuRDnIOrtTb12/9ei0KmALZ8n35/4qXGr/pMRQ4x48ZjvO0XC/MgE6T9urQmFONUmw39AixzG35+aOKnkgBRl+fpW6CTt2zykwRN0UspL1QmaXy2qNwm+ASBiKNMzwQdeE/bOpVZrhbkX++62Y4rp5lz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Tbynt0GgWz9yLtP;
	Sat, 17 Feb 2024 00:59:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id ECDE91407B0;
	Sat, 17 Feb 2024 01:14:20 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3Lxjal89lNL2hAg--.6264S2;
	Fri, 16 Feb 2024 18:14:20 +0100 (CET)
Message-ID: <c6d0c04a979e05b85acd55d574d56f368c7aa95e.camel@huaweicloud.com>
Subject: Re: [RFC 6/8] KEYS: PGP data parser
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <willy@infradead.org>, 
	Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Petr =?UTF-8?Q?Tesa=C5=99=C3=ADk?=
 <petr@tesarici.cz>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "maintainer:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Andy Lutomirski
 <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Xin Li <xin3.li@intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,  Kees Cook <keescook@chromium.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Pengfei Xu
 <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao
 <zegao2021@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>,  Kai Huang <kai.huang@intel.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Brian Gerst <brgerst@gmail.com>,  Jason
 Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Date: Fri, 16 Feb 2024 18:13:58 +0100
In-Reply-To: <EC53BCED-0D4C-4561-9041-584378326DD5@zytor.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
	 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
	 <20240216152435.1575-7-petrtesarik@huaweicloud.com>
	 <Zc-Q5pVHjngq9lpX@casper.infradead.org>
	 <5916fa3ac3d0ce2ade71e7ed1c9eb6923e374c1f.camel@huaweicloud.com>
	 <EC53BCED-0D4C-4561-9041-584378326DD5@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwA3Lxjal89lNL2hAg--.6264S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyUtw45JF1xArWDGF18AFb_yoW8XF4Dpr
	yxGa48tF4vqr4Fvr4qyw1fu34Svw4fJr1DXrn8JrWFyFn09r1akr1Ikr45WF9Fgr4xG3W2
	yw4qgryagw1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	Ud8n5UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5pt9QABs4

On Fri, 2024-02-16 at 09:08 -0800, H. Peter Anvin wrote:
> On February 16, 2024 8:53:01 AM PST, Roberto Sassu <roberto.sassu@huaweic=
loud.com> wrote:
> > On Fri, 2024-02-16 at 16:44 +0000, Matthew Wilcox wrote:
> > > On Fri, Feb 16, 2024 at 04:24:33PM +0100, Petr Tesarik wrote:
> > > > From: David Howells <dhowells@redhat.com>
> > > >=20
> > > > Implement a PGP data parser for the crypto key type to use when
> > > > instantiating a key.
> > > >=20
> > > > This parser attempts to parse the instantiation data as a PGP packe=
t
> > > > sequence (RFC 4880) and if it parses okay, attempts to extract a pu=
blic-key
> > > > algorithm key or subkey from it.
> > >=20
> > > I don't understand why we want to do this in-kernel instead of in
> > > userspace and then pass in the actual key.
> >=20
> > Sigh, this is a long discussion.
> >=20
> > PGP keys would be used as a system-wide trust anchor to verify RPM
> > package headers, which already contain file digests that can be used as
> > reference values for kernel-enforced integrity appraisal.
> >=20
> > With the assumptions that:
> >=20
> > - In a locked-down system the kernel has more privileges than root
> > - The kernel cannot offload this task to an user space process due to
> >  insufficient isolation
> >=20
> > the only available option is to do it in the kernel (that is what I got
> > as suggestion).
> >=20
> > Roberto
> >=20
> >=20
>=20
> Ok, at least one of those assumptions is false, and *definitely* this app=
roach seems to be a solution in search of a problem.

I'm looking for a solution to this for a long time. Could you please
explain?

Thanks

Roberto


