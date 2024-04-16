Return-Path: <linux-kernel+bounces-146837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A458A6B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC54B225CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F412CD96;
	Tue, 16 Apr 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="aNM5L+Vc"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F5129A7B;
	Tue, 16 Apr 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272217; cv=none; b=IUr/EV1Mts8iBWhobb8b+Yt1Jb4U1fzJXiA0r5WkoOR8My8HOIgtGH1OZfqUD2dikevHkjM/e9TZ/i/PSSsoWK1+Djw5UK2lqSzcv4vWhFUP3INSFYV/l82YdZp11c5jnjeyHxKP7QJ6IUAL6x1xX+fHmQgZJFhFczks4lGSsh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272217; c=relaxed/simple;
	bh=SE7iXRSRUv3LNcIGi2TykYUAc4S8x29BhFlqFfsK0/Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iUNnjmzs9V0VwJE9+5vGrEuMUjd0gqMmWtp8v6yC1tUuBUlUvjG8x34TlU3TBfyuETVMYpr8+h49/EG84aotaZF+gnsxfVuj23bE7g2lgCTAOr6IwBpPsPQZPsAg4PygURariEKB6SutWnP8wPQIBideMQwhfgy+elu2ETtuVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=aNM5L+Vc; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=H21fvQtQ7WtagqXZixGpBpqK/Mf2KBTn3BMn7sI6Xwo=;
  b=aNM5L+VcxO66+rnB0hrRLAaQ7ltle4u+tjVsgiIcGM/6+KSsIiVloa8h
   6T5/bjbuUhkdmon2C/f4fRUxnH/0MxnwhPqEEHqJrqp5Pz9sASMNsGN47
   eaViXdS0DYtY1iFSc2drIjE5rWOAbjxAEf3P5NybCbo0e6bzoSQz4uMLB
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="84954712"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:56:51 +0200
Date: Tue, 16 Apr 2024 14:56:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
cc: Markus Elfring <Markus.Elfring@web.de>, 
    Michael Ellerman <mpe@ellerman.id.au>, 
    "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
    "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
    Nicholas Piggin <npiggin@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
    "cocci@inria.fr" <cocci@inria.fr>
Subject: Re: [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
In-Reply-To: <3711cad3-a627-4a6e-8769-ce916c1919ee@csgroup.eu>
Message-ID: <3f22920-9543-efd1-a32a-477ae18a2b2a@inria.fr>
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de> <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse> <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu> <33a38d7e-26da-46e0-90d4-7137f9ec0c90@web.de>
 <3711cad3-a627-4a6e-8769-ce916c1919ee@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-563611295-1713272210=:3643"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-563611295-1713272210=:3643
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 16 Apr 2024, Christophe Leroy wrote:

>
>
> Le 16/04/2024 à 14:14, Markus Elfring a écrit :
> >> This is explicit in Kernel documentation:
> >>
> >> /**
> >>    * kfree - free previously allocated memory
> >>    * @object: pointer returned by kmalloc() or kmem_cache_alloc()
> >>    *
> >>    * If @object is NULL, no operation is performed.
> >>    */
> >>
> >> That's exactly the same behaviour as free() in libc.
> >>
> >> So Coccinelle should be fixed if it reports an error for that.
> >
> > Redundant function calls can occasionally be avoided accordingly,
> > can't they?
>
> Sure they can, but is that worth it here ?

Coccinelle does what the developer of the semantic patch tells it to do.
It doesn't spontaneously report errors for anything.

julia
--8323329-563611295-1713272210=:3643--

