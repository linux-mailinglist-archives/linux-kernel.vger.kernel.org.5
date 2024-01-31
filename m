Return-Path: <linux-kernel+bounces-45776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D90384361F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA4D28AE64
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE43F3DBA1;
	Wed, 31 Jan 2024 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SprPIEde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189513D964
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679494; cv=none; b=hURfWT/GU8d9tmszqHcCTXFesULAcgaynsSrxm5owB8lvz4j2/PK/ShSEbHqlLGsIdS62kGoQWhipFZAnbstcJR+zieyEMapwnZT4aXuuBqqMOujnBwV6PkjQ8TnFzJJSod8oX5BUjXLwwuE7xh+991xwxNv26RPR5AjjUiU3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679494; c=relaxed/simple;
	bh=22Krx4btf00/8e1ZZBBu8MzhsLLX45dV/yNclvUWUag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPO7kBClBPSga/yw1USJQrMW4bYqTmgrjJg1NbZ4lqLj5K644hwea8XuNlS18qO48UFny230BxuiVbDR7RslhbqRH5wn0Y8ulNutlLVg6nzP5LEF+5iKyNN0lDUutzDhaFaHTRVI6+Yu138+B4JiVtOOPYcC2k2siP4A9no2f3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SprPIEde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB433C43390;
	Wed, 31 Jan 2024 05:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706679493;
	bh=22Krx4btf00/8e1ZZBBu8MzhsLLX45dV/yNclvUWUag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SprPIEdeeiOm1uug0/HcOCQDu8xShAIOqfy+Lr8SVYVikVDl3aI9ONVCm1PDroLb1
	 /BBHiEG3trPAcQac98allr6kqurTPWi3T/1CU/PDwPa5WreOBblJ06FFQG63/iXQK8
	 c1pDO19/jRPVQ2ZTmkW4gLUv20otv3aiF+NVanjiOKc1j95D4q0k0APJIt0a7JLLw/
	 VvaqDj03CMt0Z19iCHhUPPiRIZp5JLNPh4DEVmUjvSJtsDDzHIOE/gen0ZBU8Z+FCC
	 iLPTFwl638xcT/bFSayT0AriKuzt6aMpfFNTa6R6FJXhcleU9ee3OTpMF8Of7QEF19
	 rsNbZ5uKJN0Zg==
Date: Wed, 31 Jan 2024 13:25:10 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Nick Kossifidis <mick@ics.forth.gr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Matteo Croce <mcroce@microsoft.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] riscv: optimized memmove
Message-ID: <ZbnZthTjiUArHIvq@xhacker>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-3-jszhang@kernel.org>
 <fa36b871-43d7-413c-82a2-0ecc0ebce9b4@ics.forth.gr>
 <Zbj1o6VAsk8Tn2ab@xhacker>
 <c6066469-7bc9-4232-b600-0b167193f13f@ics.forth.gr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6066469-7bc9-4232-b600-0b167193f13f@ics.forth.gr>

On Tue, Jan 30, 2024 at 06:52:24PM +0200, Nick Kossifidis wrote:
> On 1/30/24 15:12, Jisheng Zhang wrote:
> > On Tue, Jan 30, 2024 at 01:39:10PM +0200, Nick Kossifidis wrote:
> > > On 1/28/24 13:10, Jisheng Zhang wrote:
> > > > From: Matteo Croce <mcroce@microsoft.com>
> > > > 
> > > > When the destination buffer is before the source one, or when the
> > > > buffers doesn't overlap, it's safe to use memcpy() instead, which is
> > > > optimized to use a bigger data size possible.
> > > > 
> > > > Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > 
> > > I'd expect to have memmove handle both fw/bw copying and then memcpy being
> > > an alias to memmove, to also take care when regions overlap and avoid
> > > undefined behavior.
> > 
> > Hi Nick,
> > 
> > Here is somthing from man memcpy:
> > 
> > "void *memcpy(void dest[restrict .n], const void src[restrict .n],
> >                      size_t n);
> > 
> > The  memcpy()  function copies n bytes from memory area src to memory area dest.
> > The memory areas must not overlap.  Use memmove(3) if the memory areas do  over‐
> > lap."
> > 
> > IMHO, the "restrict" implies that there's no overlap. If overlap
> > happens, the manual doesn't say what will happen.
> > 
> >  From another side, I have a concern: currently, other arch don't have
> > this alias behavior, IIUC(at least, per my understanding of arm and arm64
> > memcpy implementations)they just copy forward. I want to keep similar behavior
> > for riscv.
> > 
> > So I want to hear more before going towards alias-memcpy-to-memmove direction.
> > 
> > Thanks
> 

Hi Nick,

> If you read Matteo's original post that was also his suggestion, and Linus

I did read all discussions in Matteo's v1 ~ v5 before this renew. Per my
understanding, Matteo also concerned no such memcpy-alias-memmove behavior
in other arch's implementations.

> has also commented on that. In general it's better to handle the case where

Linus commented on https://bugzilla.redhat.com/show_bug.cgi?id=638477#c132
about glibc alias memcpy to memove rather than the patch series.

> the regions provided to memcpy() overlap than to resort to "undefined
> behavior", I provided a backwards copy example that you can use so that we
> can have both fw and bw copying for memmove(), and use memmove() in any
> case. The [restrict .n] in the prototype is just there to say that the size
> of src is restricted by n (the next argument). If someone uses memcpy() with

I didn't have c99 spec in hand, but I found gcc explanations about
restrict keyword from [1]:

"the restrict declaration promises that the code will not access that
object in any other way--only through p."

So if there's overlap in memcpy, then it contradicts the restrict
implication.

[1] https://www.gnu.org/software/c-intro-and-ref/manual/html_node/restrict-Pointers.html

And from the manual, if the memcpy users must ensure "The memory areas
must not overlap." So I think all linux kernel's memcpy implementations(only copy
fw and don't take overlap into consideration) are right.

I did see the alias-memcpy-as-memmove in some libc implementations, but
this is not the style in current kernel's implementations.

Given current riscv asm implementation also doesn't do the alias and
copy-fw only, and this series improves performance and doesn't introduce the
Is it better to divide this into two steps: Firstly, merge this series
if there's no obvious bug; secondly, do the alias as you suggested,
since you have a basic implementation, you could even submit your patch
;) What do you think about this two steps solution?

Thanks
> overlapping regions, which is always a possibility, in your case it'll
> result corrupted data, we won't even get a warning (still counts as
> undefined behavior) about it.
> 
> Regards,
> Nick
> 

