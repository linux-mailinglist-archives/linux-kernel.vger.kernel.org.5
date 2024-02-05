Return-Path: <linux-kernel+bounces-53077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794BF84A066
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF9A1C217FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255D3A1BA;
	Mon,  5 Feb 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bf0n908+"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E844C7E;
	Mon,  5 Feb 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153405; cv=none; b=hGH8NvjgLk0zxagYGUxQmrSMs2+Hp3jN9GKJNvjEwQnSq5SuEC0yuE9RdEY8jQcpOCuwwOOaKhVo3Qay/R9lYBIOs4vEWoa8GQXcsxwHlYJU59jZ34ij0wcqh/HuGVLB4fHkpwtRJnH1U+C057hODbcudBj44DdJqJ7biri4iyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153405; c=relaxed/simple;
	bh=F8XI2DqjCgkrm9KbXW8tvjffoJfCHy8lt51+H+cZvd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mrui3TPMwVaewgI1oDd3Cg8VbpN116x7PbX+vdhqFNqWDI2AdZBXNzbQnLxrghedJleGmrt0jV8ag+9Uts4aed8UC1B1nw1oRwEk3F5oR52LbWg43uLyB3D4UlFSEF3Job3o3PS7o0VNNGvCiJ01dSj0OkB4N3Q8MGVsvzGmFwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bf0n908+; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6CFF147A9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707153394; bh=aOqO7Xk+LE5FlbU+iDPXbhTZnGtMGkyeoyB+ULkowsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bf0n908+iNil5mnyncMg8V14G+89f5WwaJ8RrsMSjr8mVBO84entk4I3uCZaYvlPP
	 GOUKsmOyTTIF0YwTJ5uXGsD+L7kngf58JrTW+BBjsgiP6FNXDsBKwiGlRmYIk0mxll
	 5Gk35iyxNhMirqRaDxMr9hQwxtZRBcx2NDD3RCWdUI5Ou+bqKT/1y9C56sQ3yAzdY+
	 r1oH3oEjSeXw/+osTZHWIk8lXPeb4m4rqEKmV7y1fnEO6m09Ac/0mAD9g33rO1qPEn
	 H93p7hzZCidGKsHPQg625l4gKlLNOSDGHnbPlkjla8ZgZ/d9KhODQtGaLZnbQewXXa
	 PsosSc12MXRlA==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6CFF147A9B;
	Mon,  5 Feb 2024 17:16:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>, Carlos Bilbao
 <carlos.bilbao@amd.com>, Avadhut Naik <avadhut.naik@amd.com>, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Hu Haowen
 <2023002089@link.tyut.edu.cn>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten Blum
 <thorsten.blum@toblux.com>
Subject: Re: [PATCH] Documentation: coding-style: Fix indentation in
 code-blocks
In-Reply-To: <20240202231316.7606-1-thorsten.blum@toblux.com>
References: <20240202231316.7606-1-thorsten.blum@toblux.com>
Date: Mon, 05 Feb 2024 10:16:33 -0700
Message-ID: <87le7yvnke.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@toblux.com> writes:

> - Remove spaces in C code-blocks to align error labels consistently
> - Replace tab characters with spaces in emacs-lisp code blocks
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  Documentation/process/coding-style.rst                    | 6 +++---
>  Documentation/translations/it_IT/process/coding-style.rst | 6 +++---
>  Documentation/translations/sp_SP/process/coding-style.rst | 6 +++---
>  Documentation/translations/zh_CN/process/coding-style.rst | 4 ++--
>  Documentation/translations/zh_TW/process/coding-style.rst | 4 ++--
>  5 files changed, 13 insertions(+), 13 deletions(-)

I have applied this, but I would really rather not see a lot of
white-space patches like this; there are so many ways in which our
documentation could use improvement, and this is pretty far down the
list.

Thanks,

jon

