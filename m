Return-Path: <linux-kernel+bounces-59017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFF584EFD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB23228A139
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B956B7F;
	Fri,  9 Feb 2024 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ql12PmRr"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F974F88F;
	Fri,  9 Feb 2024 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455722; cv=none; b=CXu0SSF0RuK2A91bNq+CX0b1OxdGO3K01C1e/hravbFFIA53g/E4hLB7BItfYbx+qlAJvVAOzOYJDppaW3xzz50u9LPLHiE6arK9ubiJ5XohTwlsfRxfgY4SDMmFUXfZYugQNQK5nxya7+WYlqJ4Kdtcg0Rr7e2ggozabHB5RYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455722; c=relaxed/simple;
	bh=JVP7+dHngWW5QqFjEB3Li2tXHIk33S+0+gwI4qejE7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4bL0OOpz90en1GWHKNNezERPfCymLFc8wPKQMwpn7BfhLhlBJbtBMDGN8tPumwg4ivzLYrBYEcIsNI6iZE2p+T7CmbEPyRVmpXPAmA5GrAodLpLnDCvZygeOZzUVRTsdMk9Qv6wKbpKjUaYjd43FXaPQF3NzHc3/lgkPD/yD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ql12PmRr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1707455717;
	bh=JVP7+dHngWW5QqFjEB3Li2tXHIk33S+0+gwI4qejE7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ql12PmRrPeN6w15lje0jOXjYkyY4Zd3bn4cGc9CmK5XAkHEd2zUxKooodVCroXa45
	 kQV1oAv/jc19j1oapUa9U1naSax2L39VnHTlJ4XWJ+5o+x0q5doggVed4SEmfx16AR
	 47Va7RWrUaEWrCijh4RGdaIOgfgCLjBCJ6uN/a7zaJODkKr80vu3wIYPLweb4b97OM
	 IzMTkga+Mpg34Ji2O3+9htpWgzzL087MgTWe/OWyxTcafRRpWZAWpqZ6ibmmHv5KnB
	 KQl4189OKresii4X6aw1xpo50zNSuDxE+Ly/sLi6jGwt2h0avLb4qRNLwgQFeqscv4
	 TJxv47moU5mVA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TWMVr4k82z4wcD;
	Fri,  9 Feb 2024 16:15:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Zimmermann <tzimmermann@suse.de>, Randy Dunlap
 <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drivers/ps3: select VIDEO to provide cmdline functions
In-Reply-To: <e0893d21-606e-429e-a554-c9ee60fd0ae4@suse.de>
References: <20240207161322.8073-1-rdunlap@infradead.org>
 <e0893d21-606e-429e-a554-c9ee60fd0ae4@suse.de>
Date: Fri, 09 Feb 2024 16:15:15 +1100
Message-ID: <8734u28bh8.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:
> Am 07.02.24 um 17:13 schrieb Randy Dunlap:
>> When VIDEO is not set, there is a build error. Fix that by selecting
>> VIDEO for PS3_PS3AV.
>>
>> ERROR: modpost: ".video_get_options" [drivers/ps3/ps3av_mod.ko] undefined!
>>
>> Fixes: dae7fbf43fd0 ("driver/ps3: Include <video/cmdline.h> for mode parsing")
>> Fixes: a3b6792e990d ("video/cmdline: Introduce CONFIG_VIDEO for video= parameter")
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Geoff Levand <geoff@infradead.org>
>> Acked-by: Geoff Levand <geoff@infradead.org>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Can you take it via whatever tree the CONFIG_VIDEO patch is in?

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

