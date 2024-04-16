Return-Path: <linux-kernel+bounces-146691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C006D8A696C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6042823E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA712882D;
	Tue, 16 Apr 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="LTB6+F04"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E84127B7A;
	Tue, 16 Apr 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265881; cv=none; b=c7QedGkXgNWoV/OyGVXDGkhdD3VMVhoGFfs81LOwjH3BVhYXCvQVKbAXl3/qIxcSt2gmYbaI3gOBtOcugguavUqfjKIn5+P8QC+ZISQyMkRztd8i7Dx6tOcqgWCxIrwT52dvoVTHsPsK9YN1HXQV5AZL+fo5g09pC/LB4wb8rEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265881; c=relaxed/simple;
	bh=qIhE4yT8vpU5aN3430H16P3kuNMvbZO8L7M2CXp/yKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sCSdkqqo60FuYmeaDBmDZ/vCBJRdsQFyrLFYPAQkJyg0KnpCIdqr0pVhUQmiRrSpv/tHRRltuaEuLg2XodCMNCyB7qHjiaS2QopisgVMsQJjQI67R53HBv5W7Sb1yt4G4z0+lCFIsLSFwxrFhgdkJi+e7+0ml1S9N0Iegkd8SO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=LTB6+F04; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713265877;
	bh=ZM/Kn+8UkuIqH7dSUrgkALqX2sFZu1tAf9iAD/x7XuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LTB6+F04dq0c2A9vGjdft01NvBtN7BE1s7hBFglEQeOgGLMZ8lhGSvwhgamz3zdUw
	 3LOFOGAE8/69f5wjWDrFwFeywpUpkxUOsNTUPdSBqDxlizHom70fy+HGtKeWzbOmZE
	 8ubI3+yDLj3N/2MnNLCuoA4+Aq8ZuD2XB8lHJavB2F/v4AgKxIuU7J4aUnkE/18pi5
	 y2cVry8DRgTrqzpXW05YnuQ2MoPsb+3UECVYNA3zp20sf3yGFp6RARvbtTBUET+zd4
	 8qw/x/HqneNONDno8GHtmrjjMlSabWz9T+pHjLGZ/DGvvazDUjzYg3oKs5SvnFWbUD
	 T9duxh5ZTeljA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJhDg5c14z4wd3;
	Tue, 16 Apr 2024 21:11:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
In-Reply-To: <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de>
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de>
Date: Tue, 16 Apr 2024 21:11:15 +1000
Message-ID: <87plupbm0c.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Elfring <Markus.Elfring@web.de> writes:
>> A few update suggestions were taken into account
>> from static source code analysis.
>>
>> Markus Elfring (2):
>
> I would appreciate a bit more information about the reasons
> why this patch series was rejected.
>
>
>>   One function call less in vas_window_alloc() after error detection
>
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1f1c21cf-c34c-418c-b00c-8e6474f12612@web.de/

It introduced a new goto and label to avoid a kfree(NULL) call, but
kfree() explicitly accepts NULL and handles it. So it complicates the
source code for no gain.

>>   Return directly after a failed kasprintf() in map_paste_region()
>
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/f46f04bc-613c-4e98-b602-4c5120556b09@web.de/

Basically the same reasoning. And it also changes the function from
having two return paths (success and error), to three.

cheers

