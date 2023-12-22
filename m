Return-Path: <linux-kernel+bounces-9230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B181C29E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDBF1F2529D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B454A49;
	Fri, 22 Dec 2023 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JwEtyxzp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75931A23
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1703207799;
	bh=JIA//IHP0Me0Pc8sL62vOw+soEfxvkiZzbn5MDY7sf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JwEtyxzpQ+ESmsQSdls5sNEhaIBKEJGDLR5mLVnatIdIQZcyLA0dvqEHe5ggdIfbY
	 x9feYcF7iHsrdLw6CKnX6xKLrHHVdK+Qsm8aIiu+FZCUVnxz5whaSHTL+3hFTMAdv2
	 /WqpUlghwPJASF5fkbOo4QliRReFyPasydAKo6TwDxmkJpM56PkemApuxnwcY9Lr9S
	 +B6f3eg7szMNiusQ4qJwo8jazXEYJ1DB0M/Apn64pI/mgORZw9ESe+6F+bhmIy1Z2l
	 NMN5JpXEWaGr1EYxANsrTwCo5zSbcYMqBLDBwWK1yhk3/VucBz90yVH7riEa0Itq4O
	 gLBuyW9UtftUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sx8X66JrGz4wcX;
	Fri, 22 Dec 2023 12:16:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Cc: Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH] powerpc/6xx: set High BAT Enable flag on G2 cores
In-Reply-To: <20231221124538.159706-1-matthias.schiffer@ew.tq-group.com>
References: <20231221124538.159706-1-matthias.schiffer@ew.tq-group.com>
Date: Fri, 22 Dec 2023 12:16:38 +1100
Message-ID: <875y0rkpe1.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthias Schiffer <matthias.schiffer@ew.tq-group.com> writes:
> MMU_FTR_USE_HIGH_BATS is set for G2-based cores (G2_LE, e300cX), but the
> high BATs need to be enabled in HID2 to work. Add register definitions
> and introduce a G2 variant of __setup_cpu_603.
>
> This fixes boot on CPUs like the MPC5200B with STRICT_KERNEL_RWX enabled.

Nice find.

Minor nit on naming. The 32-bit code mostly uses the numeric names, eg.
603, 603e, 604 etc. Can we stick with that, rather than using "G2"?

Wikipedia says G2 == 603e. But looking at your patch you're not changing
all the 603e cores, so I guess it's not that clear cut?

If using "G2" makes the most sense then it would be nice to update
Documentation/arch/powerpc/cpu_families.rst to mention it (not asking
you to do it necessarily, more a note for us).

cheers

