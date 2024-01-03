Return-Path: <linux-kernel+bounces-16009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B748236F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B19F287951
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED01D69D;
	Wed,  3 Jan 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="thrsfLlP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4141D687;
	Wed,  3 Jan 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B79B21C33;
	Wed,  3 Jan 2024 21:13:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B79B21C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704316416; bh=Z9wBUNkIgI1KjeMMPZc6rSKy4oBEXR9BlVUj6OtV9uI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=thrsfLlP77MOXmB2UFnPrAPvKi8nCbKhM4/jiA2DsSt1OzJWwxacP255IxO3RWr+h
	 BLeecooI+oUYzgNVAOLDxbVno4j0sTneuB3UJLAxSHrb3tgGQdg/vqNPRzPCz60+iE
	 PilAJa/NgU3fynrEBLA4496+Khl8sh/FEd+Ao6Uag2TmI53IRVEQBb8BHGGGajNmOb
	 tHD5ZQKbIC3wv3fDikABq3bRANZ6W+F67hqRxOAj4Whk8scDHDT38btyDIt2Rw10+3
	 ue68xJFNJmsN6k+bVyN7g1mS4LahLa6Q8Yrh5lgpak74Yf8oi34Drousj30aImLLTb
	 1L5YZsi+TO2kw==
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jani Nikula
 <jani.nikula@intel.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: handle a void function without producing a
 warning
In-Reply-To: <20231226065219.319-1-rdunlap@infradead.org>
References: <20231226065219.319-1-rdunlap@infradead.org>
Date: Wed, 03 Jan 2024 14:13:36 -0700
Message-ID: <87le9686in.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Currently a void function can produce a warning:
>   main.c:469: warning: contents before sections
>
> This one is from arch/x86/kernel/cpu/sgx/main.c (which is not included
> in any produced kernel documentation output).
>
> Handle this by setting $in_doc_sect to 1 whenever any recognized
> document section name is processed.
>
> Fixes: f624adef3d0b ("kernel-doc: limit the "section header:" detection to a select few")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  scripts/kernel-doc |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/scripts/kernel-doc b/scripts/kernel-doc
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -2126,6 +2126,7 @@ sub process_body($$) {
>      }
>  
>      if (/$doc_sect/i) { # case insensitive for supported section names
> +	$in_doc_sect = 1;
>  	$newsection = $1;

Applied, thanks.

jon

