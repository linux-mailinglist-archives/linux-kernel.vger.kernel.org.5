Return-Path: <linux-kernel+bounces-134801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E40289B728
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76ECB2150E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8522579D2;
	Mon,  8 Apr 2024 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UsKnHN5d"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146F111A8;
	Mon,  8 Apr 2024 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712554199; cv=none; b=jGhLTzZA7aJAsoG2NIqaSO1Ntn4xeApQ6jHNE0N1XJKpdhmQ2/qZ7JT7/LKHLuWVtd79PHVy/DjaKf0hhvoH58hsMDyaUqMZfZcx7iM1Tlk2InWkv4SoiNwzAdV0LvDDz+dFVZaY+1nm4yGqBfQvOnQ/LzyPXc5XEQK48ahqOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712554199; c=relaxed/simple;
	bh=taPtZ4H9ZcND3oGrS9y6pAeVaLjbudmAuFy8q/qklMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AhcPJiOhqkknT2flLxT47252ybQxFq5G/eCzTDtAOoaxKlZ93vPxlMmYgrUwDCt40PCs7S0mAcus8I5tsuztoYsg78473wEw+J7y6NUbDMDfeFTPoW0KLvUqcvmdXuf104tRWMgH5kUtd6vcqBCg8p1u/VGbcKk3wrz+gZQOLKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UsKnHN5d; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712554197;
	bh=iMWIRrwu8jzlwq3GFwobpQXIdHqfklC2x5296qQNRHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UsKnHN5dUA5W0rjVFcwQj5HDYvEHusqogP0tHn2kalVa91OM2idgYC2m6oywCccHn
	 20FOcjzQeTxSX/TNcljO0PtQeHSikB6hwmGZLi9+pdBhaigjbzBmhfzSCowQyox1AB
	 M8ZC6Nl7a6+sbocmAHfxGj/Xlr1fxJqAzI6XPx5zHMntsMAgYheeHS13xKkMzmkym4
	 t0VtffZzOe60AjdZZOuo8CgV1vpgZWyrEhAKfjbc1xIOmg8wyIdPmQbyOubEnH1tHG
	 UDV589rMWSfeRpqkCEgEaUPYy9XmYedZWEuZI4rNpfpGoTdTsMJjIgT+i3tzqHjXuh
	 AYWYO2yb9DORA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCd2X6SD4z4wd3;
	Mon,  8 Apr 2024 15:29:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] serial/pmac_zilog: Remove flawed mitigation for rx
 irq flood
In-Reply-To: <2cb53463-897b-8f3f-7238-9fe87622b54d@linux-m68k.org>
References: <0df45bedded1249f6c6ec2c2fb0d9879da1841b7.1712273040.git.fthain@linux-m68k.org>
 <87v84w7be3.fsf@mail.lhotse>
 <2cb53463-897b-8f3f-7238-9fe87622b54d@linux-m68k.org>
Date: Mon, 08 Apr 2024 15:29:56 +1000
Message-ID: <87sezwbewb.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Finn Thain <fthain@linux-m68k.org> writes:
> On Fri, 5 Apr 2024, Michael Ellerman wrote:
>
>> I assume you have tested this on an actual pmac, as well as qemu?
>> 
>
> I tested the patched driver and its console functionality using Zilog SCC 
> hardware in a Mac IIci, as well as QEMU's q800 virtual machine.
>
> That should suffice from a code coverage point-of-view, since 
> pmz_receive_chars() is portable and independent of CONFIG_PPC_PMAC.
>
> Moreover, I don't know how to get my PowerMac G3 to execute the kludge 
> that's to be removed here. I can't prove it's impossible, though.

Thanks. That's good enough for me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

