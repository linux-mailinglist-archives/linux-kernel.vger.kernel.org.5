Return-Path: <linux-kernel+bounces-134784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005B089B6D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949E81F21AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4F211712;
	Mon,  8 Apr 2024 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Sp3Bdtn6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D61C2E3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712550310; cv=none; b=BD2fDELHWlmNY71GY14yZkCCLBzDL9STBUZUICgG81qXRRrSZb5zNH2f3HfLlDTbh06AsFPrCR4AAHhTkZflxlIp2qWMbllRc6U+6x02thO/AKLZOdAT3f2zs1WifCKdjDuqjigOd6dh0f10y1BYQrjB9OLz0nccBTj3Tn6YISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712550310; c=relaxed/simple;
	bh=pgLg7GUxxXMnTYvn05nNtKMQObwyusSFdPPrFMX71DA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m7i88snxxRlIHj6dCIMRze7oxPGd9E6SsTdMNuhuHaG5xQOpvx1V58LUe03QXVDsrBDJu+0zyiTMgV4FfPjB/m/+SX3Oz7VoaK+fT06zvdUOTRtVJxqjFx26h51CtjLdahTcF90qybRRx6hs6MKUkQIaQD+ZYpOtFxPvrRBRLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Sp3Bdtn6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712550306;
	bh=9IeDw0jg/iSTJmzT7tMO0PqrDYTpMdttta7G5B8J0DU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sp3Bdtn6OeC5sT0aJW+ARoTMwpGJXNh2PfiiwcMeknb0msWMDsNBeMvK3/N1panIm
	 w1id8AW0E/7VWJijXUeioUu4O03AoJN71R9c+Mj4GgYFLa8juXRm9/XFNs9LAHEL/r
	 8bo7i0xsE94Rek0Df80966YGFSRr+/i6DoZYiqSeXuRUG1TFp7ul+lwC5a8m+CT2Ic
	 MjUbVGviYLiGRRfAwzbfEYzPj4TGVXz9UDnit9OmSPSz5JueW/6Z0/k/MI9qTtkT+o
	 ko4XWCodSXIjmZZUjht05XmXt7EYbebVf3yjnF7+Hl2RdQNB7ab1bI/8I+5n05znZC
	 XorIO5MG1GpyQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCbbh6SRFz4wxt;
	Mon,  8 Apr 2024 14:25:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yang Li <yang.lee@linux.alibaba.com>, arnd@arndb.de, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yang Li
 <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next 1/3] powerpc: boot: Fix a typo in
 partial_decompress() comment
In-Reply-To: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
References: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
Date: Mon, 08 Apr 2024 14:25:04 +1000
Message-ID: <874jcccwgv.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yang Li <yang.lee@linux.alibaba.com> writes:
> This commit adds kernel-doc style comments with complete parameter
> descriptions for the function partial_decompress().

This change log doesn't match the subject or the patch.

cheers

> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/powerpc/boot/decompress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/decompress.c b/arch/powerpc/boot/decompress.c
> index 977eb15a6d17..6835cb53f034 100644
> --- a/arch/powerpc/boot/decompress.c
> +++ b/arch/powerpc/boot/decompress.c
> @@ -101,7 +101,7 @@ static void print_err(char *s)
>   * @input_size:  length of the input buffer
>   * @outbuf:      output buffer
>   * @output_size: length of the output buffer
> - * @skip         number of output bytes to ignore
> + * @_skip:       number of output bytes to ignore
>   *
>   * This function takes compressed data from inbuf, decompresses and write it to
>   * outbuf. Once output_size bytes are written to the output buffer, or the
> -- 
> 2.20.1.7.g153144c

