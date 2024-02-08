Return-Path: <linux-kernel+bounces-58798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904184EBE9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA80F285907
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7750A7E;
	Thu,  8 Feb 2024 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="S4HagbGH"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69950A64;
	Thu,  8 Feb 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432771; cv=none; b=Rd0yVtRjlCjceme7rpO6b8kVJmV7Lr4pnf5MgS07B2vrwvGtzuhWUS68QbyVpz5lQQ7m8JumJOukKEWeQRd1mg7CSkyIQAuBA7PIPeKYw5RYbBaTy7uh4bCGBMd5fQuZVHcGOvI49DDDc/zI44iPcpdf2P9QDu312W8DBbb0dPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432771; c=relaxed/simple;
	bh=mqKz9UdrCWD0siMN6R/WTdn8G5HPdq8nskbk8NZQKvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gCjfOBLSEcWj7ceZpjGG1ClM18IsgFm1UDXns8lJjWw4PiVPcLWCcR5ivnL3lZzo43SCot4REsWFKGtuN6Uc/EtohNaUoIZbMZLJ76Ww4q1mVd2yJ+1l4+lLELEdDOZ9sOiHLIN2ZJuljOMfPGUdI9HjRWoKwKdlAK1aOrPsI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=S4HagbGH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AA88E45917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707432769; bh=MQxKubxOLKPrJhN7VhuwbhRjppHStGai3J0aDbHtlEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=S4HagbGH1Lmso61nWZdGoDCZgp3c50KwwXzEMusmXkDdNONXk0e+EY9Q/Fh1k7+lM
	 +G8U6uCju81b2ytrCpZ55PgoZlZMmtBvyLK1TLM6IebFi3PgCX4X8tZxPytTkhlHTI
	 WK68Q/BarXPy2wGINFNEaV12xGX+sPsQAi2E1oEtUbgVNOx8wd/XOy4Z6mQutDoZaS
	 ifgvvoe6XaLwxqwI92dUeVfXyZCLTztwqMN1F41XXaSCGGjQv9XOKI83a1EKLW1Z9f
	 B46Eo6w6XBeP1A5K8RJyVvr56K2fTB8clWSscIaH93ddFUiRfeISWyougac0NkTlsj
	 0xBF5D94OySzA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AA88E45917;
	Thu,  8 Feb 2024 22:52:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@toblux.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches <joe@perches.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten Blum
 <thorsten.blum@toblux.com>
Subject: Re: [PATCH] docs: dev-tools: checkpatch.rst: Fix grammar
In-Reply-To: <20240208152039.65293-1-thorsten.blum@toblux.com>
References: <20240208152039.65293-1-thorsten.blum@toblux.com>
Date: Thu, 08 Feb 2024 15:52:49 -0700
Message-ID: <875xyyfu0u.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@toblux.com> writes:

> - s/exists/exist/
> - s/maybe/may be/
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  Documentation/dev-tools/checkpatch.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index c3389c6f3838..127968995847 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -168,7 +168,7 @@ Available options:
>  
>   - --fix
>  
> -   This is an EXPERIMENTAL feature.  If correctable errors exists, a file
> +   This is an EXPERIMENTAL feature.  If correctable errors exist, a file
>     <inputfile>.EXPERIMENTAL-checkpatch-fixes is created which has the

Applied, thanks.

jon

