Return-Path: <linux-kernel+bounces-132363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C211E899396
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18171C21E62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5B1CA9C;
	Fri,  5 Apr 2024 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nt7LyYr0"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3441BF54;
	Fri,  5 Apr 2024 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286400; cv=none; b=L6DmXJ0QauVf27VfeFPLWAIn0Q7MPp5TdfNjXk2jSRhlbARvdPJ8scIUDzvw1FS/VhkTN2B0ldPqauTbQ5sJ0jwQYxvds38UIXFsK/pn3RCD6S39MjoD9ViFDUN8jz+gLHvmwcsQkHn6Y+qGwqEVlG+k4YBZ2RCWIQ3J+69QDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286400; c=relaxed/simple;
	bh=rQll83np3ZgmfrTNhgz1E+J4NbFfxMVThydcSzQ/0Mk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AxqjQXvLZcuV45yCkfEDunCmcrOSjwfiPNNnazzaSbNgZH3TEdLIZ5mI68INCur91SZp+5jju8K8tDenxERBlj2VNGFYetdWe/8qRZwvAqgj9iW0lB/Y+vhEvbRAT1XAz7jWqSHLHL8XrqgpEcTUmaJV53fcDLeIKDkuNuytY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=nt7LyYr0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712286396;
	bh=rQll83np3ZgmfrTNhgz1E+J4NbFfxMVThydcSzQ/0Mk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nt7LyYr0VgKC2PN8Uh4OBsDE8MRTMWxElbEIkAPup4qXOCqn6AeSByhif9P5ytgiV
	 Y0b9YCVHe1603OzGz1CuS1UAonEljsDSUXb5aXtmNm2o9cF2iq4pQFZqtJIChURkSw
	 9Vt5EdU6CLx1RvuzF9z1OvCmkN9sZhtAHHCCj4sIWvoMK2OVCaJcbR1qBuG6pLcPbs
	 P8Cy/gvYiz9sm+Bzo2/y8VephuLdily3Dwf/bvYfJWL4L0jnQ6kLLqnzyvVClaF+3a
	 RSl6KVE7ivbi9liHBQ1OUQ5K6a71jyuPucAmq3YfgXcEbtZfpIPt3ZoJgTWSh7Y0kd
	 Qj08GU1zIAhJw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V9k0V5tFtz4wcb;
	Fri,  5 Apr 2024 14:06:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Finn Thain
 <fthain@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq
 flood
In-Reply-To: <CAHp75VcxLez_Nm0N8=gpWd7SKGd9JF2QXEOOB_gvX3ZtTzj6HQ@mail.gmail.com>
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org>
 <Zg3YZN-QupyVaTPm@surfacebook.localdomain>
 <8f234f26-d5e3-66ed-ab0c-86d3c9852b4a@linux-m68k.org>
 <CAHp75VcxLez_Nm0N8=gpWd7SKGd9JF2QXEOOB_gvX3ZtTzj6HQ@mail.gmail.com>
Date: Fri, 05 Apr 2024 14:06:33 +1100
Message-ID: <87y19s7bk6.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> On Thu, Apr 4, 2024 at 2:57=E2=80=AFAM Finn Thain <fthain@linux-m68k.org>=
 wrote:
>> On Thu, 4 Apr 2024, Andy Shevchenko wrote:
>
>> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
>> > > Cc: Nicholas Piggin <npiggin@gmail.com>
>> > > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
>> > > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
>> > > Cc: linux-m68k@lists.linux-m68k.org
>> >
>> > Second, please move these Cc to be after the '---' line
>>
>> I thought they were placed above the line for audit (and signing)
>> purposes.
>
> I didn't get this, sorry.
>
>> There are thousands of Cc lines in the mainline commit messages
>> since v6.8.
>
> Having thousands of mistaken cases does not prove it's a good thing to
> follow. I answered Jiri why it's better the way I suggested.
>
>> > > Link: https://github.com/vivier/qemu-m68k/issues/44
>> > > Link: https://lore.kernel.org/all/1078874617.9746.36.camel@gaston/
>> >
>> > Missed Fixes tag?
>>
>> Would this be ok: Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> I have to ask because some reviewers do not like to see a Fixes tag cite
>> that commit.
>
> Yes, or you even may dig into the history.git from history group (see
> git.kernel.org) for the real first patch that brought it.
>
>> > > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
>> > > ---
>> > (here is a good location for Cc:)
>>
>> Documentation/process/submitting-patches.rst indicats that it should be
>> above the "---" separator together with Acked-by etc. Has this convention
>> changed recently?

The docs don't really say where to put the Cc: tags, although they are
mentioned along with other tags which clearly are intended to go above
the separator.

> I see, I will prepare a patch to discuss this aspect.

FYI there was a discussion about this several years ago, where at least
some maintainers agreed that Cc: tags don't add much value and are
better placed below the --- separator.

Thread starts here: https://lore.kernel.org/all/87y31eov1l.fsf@concordia.el=
lerman.id.au/

cheers

