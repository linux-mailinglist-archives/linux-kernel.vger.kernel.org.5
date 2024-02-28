Return-Path: <linux-kernel+bounces-85490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D233486B696
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742BC1F24DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427DD4087A;
	Wed, 28 Feb 2024 17:59:11 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A340848;
	Wed, 28 Feb 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143150; cv=none; b=XMMy1fNGmho45hODFqMP6I4iO6cCqChvEBLoUDlnl2FNxgRUitKx7GsBG8YhjhJ68gNRjv1rl7pGsSJi40uD+Ofy2IvF9CVjHtCP6O+hB+BO0xgRZ0lMBz2NfVEJij4t11a35XV1clIM0uezwGKzM+iMvmsFD5oACgFWwfFb4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143150; c=relaxed/simple;
	bh=27q+sAVMCpGXyOO7+Xz/rmsZjZDRkPVkgGNbIybUR0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlN7AbxzKEtGJkF+WP42vRGdsAcXYPRa38EW5kaGCZ/Hmd0kAT/Lk8Dtbt/zj/TKtRAB3HYt0N470B7c/JH/h8cLcsWjQgfvNUBb1/ziiXF9/qD21FTxrrHouo4eOXawSWHlzpSAYdzjNJpbMpZinnhomjVgycOAKo77OHCcb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlMCR6PYXz9y4yV;
	Thu, 29 Feb 2024 01:43:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 522CC1407C8;
	Thu, 29 Feb 2024 01:58:55 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBnXxhJdN9li+FkAw--.41826S2;
	Wed, 28 Feb 2024 18:58:54 +0100 (CET)
Message-ID: <d1b88a1d2affbfb89ccd9131357d84580f107360.camel@huaweicloud.com>
Subject: Re: [RFC 6/8] KEYS: PGP data parser
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Dave Hansen
 <dave.hansen@intel.com>, Petr =?UTF-8?Q?Tesa=C5=99=C3=ADk?=
 <petr@tesarici.cz>,  Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "maintainer:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,  Oleg Nesterov
 <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Xin Li
 <xin3.li@intel.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton
 <akpm@linux-foundation.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kees Cook <keescook@chromium.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Brian Gerst <brgerst@gmail.com>, Jason
 Gunthorpe <jgg@ziepe.ca>,  Joerg Roedel <jroedel@suse.de>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Tina Zhang <tina.zhang@intel.com>,  Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>,  open list <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Date: Wed, 28 Feb 2024 18:58:30 +0100
In-Reply-To: <5b0ce7ef-3f4e-4c1b-a0b7-bf48e8169c4e@huaweicloud.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
	 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
	 <20240216152435.1575-7-petrtesarik@huaweicloud.com>
	 <Zc-Q5pVHjngq9lpX@casper.infradead.org>
	 <5916fa3ac3d0ce2ade71e7ed1c9eb6923e374c1f.camel@huaweicloud.com>
	 <Zc-s-42WoZhW_2c8@casper.infradead.org>
	 <5b0ce7ef-3f4e-4c1b-a0b7-bf48e8169c4e@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBnXxhJdN9li+FkAw--.41826S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyfuFyrGFWDKF48Zw15CFg_yoW7Jr4DpF
	WSka4YkF4qqr1Sk3Wqyw4xuFyFvrs3tF15W3s5JryfA3Z0gF12yryIka1jgF9rCr4kK3W2
	yr4jyF9xCa4kA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIE
	c7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6rWY6r4UJwCIccxYrVCFb41lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
	WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUUtCzDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj5bMogABsJ

On Fri, 2024-02-16 at 20:54 +0100, Roberto Sassu wrote:
> On 2/16/2024 7:44 PM, Matthew Wilcox wrote:
> > On Fri, Feb 16, 2024 at 05:53:01PM +0100, Roberto Sassu wrote:
> > > On Fri, 2024-02-16 at 16:44 +0000, Matthew Wilcox wrote:
> > > > On Fri, Feb 16, 2024 at 04:24:33PM +0100, Petr Tesarik wrote:
> > > > > From: David Howells <dhowells@redhat.com>
> > > > >=20
> > > > > Implement a PGP data parser for the crypto key type to use when
> > > > > instantiating a key.
> > > > >=20
> > > > > This parser attempts to parse the instantiation data as a PGP pac=
ket
> > > > > sequence (RFC 4880) and if it parses okay, attempts to extract a =
public-key
> > > > > algorithm key or subkey from it.
> > > >=20
> > > > I don't understand why we want to do this in-kernel instead of in
> > > > userspace and then pass in the actual key.
> > >=20
> > > Sigh, this is a long discussion.
> >=20
> > Well, yes.  When you don't lay out why this is of value, it turns into =
a
> > long discussion.  This isn't fun for me either.
> >=20
> > > PGP keys would be used as a system-wide trust anchor to verify RPM
> > > package headers, which already contain file digests that can be used =
as
> > > reference values for kernel-enforced integrity appraisal.
> >=20
> > The one example we have of usage comes in patch 7 of this series and is=
:
> >=20
> > gpg --dearmor < <PGP key> | keyctl padd asymmetric "" @u
> >=20
> > And you're already using two userspace programs there.  Why not a third=
?
>=20
> I think this is very easy to answer. Why not extracting the public key=
=20
> from an x509 certificate in user space, sending it to the kernel, and=20
> using it for kernel module verification?
>=20
> > gpg --dearmor < <PGP key> | ./scripts/parse-pgp-packets | keyctl padd a=
symmetric "" @u
> >=20
> > > With the assumptions that:
> > >=20
> > > - In a locked-down system the kernel has more privileges than root
> > > - The kernel cannot offload this task to an user space process due to
> > >    insufficient isolation
> > >=20
> > > the only available option is to do it in the kernel (that is what I g=
ot
> > > as suggestion).
> >=20
> > This sounds like there's some other way of getting the key into the
> > kernel which doesn't rely on userspace.  Or are you assuming that nobod=
y
> > bothered to trojan 'cat'?
>=20
> Apologies for not providing the full information at once. I'm worried=20
> that would be too long, and pieces can be lost in the way. If it is not=
=20
> a problem, I'm going to clarify on request.
>=20
> Ok, so, I'm not going to use cat to upload the PGP keys. These will be=
=20
> embedded in the kernel image, when the Linux distribution vendors build=
=20
> their kernel.
>=20
> This works for both secure boot and trusted boot, since the kernel image=
=20
> can be measured/verified by the boot loader.
>=20
> Another source for keys is the MOK database, since users might want the=
=20
> ability to verify their own software, which does not come from the Linux=
=20
> distribution.
>=20
> I briefly anticipated the full picture, but I will tell it more explicitl=
y.
>=20
> The kernel, with the embedded PGP keys, will be able to verify the=20
> signature of the RPM package headers.
>=20
> A component that I recently developed, the digest_cache LSM, has the=20
> ability to extract file digests from RPM headers and provide a simple=20
> interface for IMA, IPE, BPF LSM and any other component to query the=20
> calculated digest of files being accessed, and allow/deny access to them=
=20
> depending on whether the query is successful or not.

Not the proper thread, but since we talked about it...

I finally put together the PGP key and signature parser, the
digest_cache LSM and the IMA integration patch sets, and built three
openSUSE Tumbleweed packages (kernel, digest-cache-tools, dracut),
which basically enable the integrity features that the kernel (IMA)
supports:

- IMA measurement list with RPM headers and (eventually) unknown files=20
  that are not from Tumbleweed;

- Ability to obtain a deterministic TPM PCR value, suitable for sealing
  of TPM keys

- Out of the box integrity enforcement on executable code, based on the
  provenance from openSUSE Tumbleweed; nothing else is required other
  than those three packages

An introduction and a guide with configuration steps can be found at:

https://github.com/linux-integrity/digest-cache-tools

I would also appreciate your comments.

Thanks

Roberto

> I already anticipate the question, if you have the problem parsing PGP=
=20
> keys, why don't you have the problem parsing RPM package headers?
>=20
> I started finding a solution before this became available, and the only=
=20
> alternative I found was to formally verify my code. So, I took Frama-C,=
=20
> wrote the assertions, and verified that not only the code is=20
> functionally correct for correct sequences of bytes, but that there is=
=20
> no illegal memory access for any arbitrary sequence (unfortunately, I=20
> can prove for a small buffer size).
>=20
> So, I'm probably going to do the same for the PGP parser, if this does=
=20
> not fly. But, we were very optimistic that this could be a valid=20
> alternative!
>=20
> Roberto


