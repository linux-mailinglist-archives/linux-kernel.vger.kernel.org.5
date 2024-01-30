Return-Path: <linux-kernel+bounces-45252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DCE842DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFDF1C23CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D648671B51;
	Tue, 30 Jan 2024 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Tw+U0PmP"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556071B3B;
	Tue, 30 Jan 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645998; cv=none; b=NE5gWu35KtmmcMzKgirCxyIg4Nrk/YL1y+mJQ1j57XnzUNUEHId0EIhLZ8Gt32Vwjp3sccA1gJ5PnxjYT8rye26Aab8tQNK5PdkdCwpD+LsPX/6u0c1KSDnujXZpTg2gUvOTo099Tf6ycZKAuKVfnyUhmiS3Bqz+lCkzhaZAIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645998; c=relaxed/simple;
	bh=c4Zn2fPM9nlKOdP7NYS6LCsExp/U5CB3n2huSaT6234=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cwJt1Y7TpsrszAleTj5tt4CWUPo4ykVA+melhPQZAqR3fr3ep6CjFsiO7sdaOIHctrvGlaVXkPME0RnH3LRfs3ctKg3mXgWk0KXz9zbDDWGvG2pL9vqJ+15E7iDBWY1aXUYAIQR391DeUJyF7ohEKxlI4It7BjuaDsWKFzeKpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Tw+U0PmP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0A9B35A272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706645996; bh=XxMlfKWWi9hCnxPW7oMQi87Q7yXv4M/LYZAS6n45AVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Tw+U0PmPTpG/68LTDYlXqKyPGjHeyUnwNc2LJqyYviv+4cZv74T98L4/2DHZDtBdq
	 1M2xqZ+bslQ1CKj1E9W4efGbseA/Cgfwv6qNkxPCtPYvpuqqMH6+HyPaIMVnD4a3mx
	 xGse/IVaZ5EUeSeROMWykByqv0F5R16fGUaIgWx87V6mVyrR6VbHxTCJvOBhekwA7B
	 L94QcuuClEP2KZJSCdF6rphfmgF2kllOqdv+2wF62bJEqQ8AaHGkxwKNFMsIMaIUu9
	 iHFF4yHPOqLT1O0iMwyzGsThwfyh+uEg9Z4akRvkb4vMdpqJTaqinoXiKdtZeYBigt
	 Tm7vb5FSHdtTg==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0A9B35A272;
	Tue, 30 Jan 2024 20:19:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: drop looking for "MACDOC"
In-Reply-To: <20240108003700.13418-1-rdunlap@infradead.org>
References: <20240108003700.13418-1-rdunlap@infradead.org>
Date: Tue, 30 Jan 2024 13:19:55 -0700
Message-ID: <87eddybml0.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Linux kernel does not use "MACDOC" in any documenation or any
> source files, so stop searching for it.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  scripts/kernel-doc |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/scripts/kernel-doc b/scripts/kernel-doc
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1907,7 +1907,7 @@ sub process_proto_function($$) {
>  
>      $x =~ s@\/\/.*$@@gos; # strip C99-style comments to end of line
>  
> -    if ($x =~ m#\s*/\*\s+MACDOC\s*#io || ($x =~ /^#/ && $x !~ /^#\s*define/)) {
> +    if ($x =~ /^#/ && $x !~ /^#\s*define/) {
>  	# do nothing
>      }

Applied, thanks.

jon

