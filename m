Return-Path: <linux-kernel+bounces-157593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968028B1353
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5351C284070
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7E65D8E0;
	Wed, 24 Apr 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SPQOwYvO"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF92BAEA;
	Wed, 24 Apr 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986059; cv=none; b=qh7zqtUf2MPSjHEBvnUOYoCSD0QgimzpGvad0fTDasioDMmC0HjHLg5ePKAbMrBdKAhU9UyAfeTZVq8d4C33GlM8JhaJNfoXA6GHGaLfrcgSDnpm98+xgDfuAkbgeO5E3oC5vXRA6oftTztGoNkOPTunqqBa8RiVxXKwmv3uPmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986059; c=relaxed/simple;
	bh=fdEbYLrtcWl1FgMAQs7JnV1rLjSsBQCpDnddVCpPQ2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KrVBhYONwdHwR+7G1ukAlhUQ6ukS2cC7B8SMsXNrCZJese+3kqsoSEz7eVMXlsUL9m2AcZUR+8fmU7TKBc8jPXxrWTDLximD3S+EQMG6pVkJvWhIkxoWibBp4z+xrMmy4JgcTH+5zCv9xRE7Ds86/ae/KlpxCjKItUUOrqiamtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SPQOwYvO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 663E347C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1713986057; bh=j/2MTvt0hIeZI6CjSpRDHOh2XvsYMacO5cXDo9YNG2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SPQOwYvOuoTBv4ko6CuoQ5Rtddm8mB69Q1tN3GlqxwvtN4d1t8q0edV/VQaPFIXm4
	 rvlvKRNhWgfmUbgVPkMNarJWAQTiGgN3ssPjjDOF+mESGha1M7Edd9IQr0rkluriPf
	 EXyeMRT93JUDZjGsq0sSihxd0iAp8fO4OtXhjF3+aXtXFk1biQWGnkxDMdydrn24gd
	 ICaYlIuutFIMMvQclwy+Gk3bhmOyLmLkHN4113vBECMPFkwXFyAmM0Rv6QCRQAUKB2
	 GIzVdmiSW5tA5VZxkFQyzvBDNrTbs39Ln6yeQ5wSDedFdDWcBFj0cQjsZO7AZfEidL
	 mtwnB/csLJZ7Q==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 663E347C41;
	Wed, 24 Apr 2024 19:14:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Haoyang Liu <tttturtleruss@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, Haoyang Liu
 <tttturtleruss@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] docs/zh_CN: Add dev-tools/kcov Chinese translation
In-Reply-To: <20240421142021.19504-1-tttturtleruss@hust.edu.cn>
References: <20240421142021.19504-1-tttturtleruss@hust.edu.cn>
Date: Wed, 24 Apr 2024 13:14:16 -0600
Message-ID: <87zftishdj.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Haoyang Liu <tttturtleruss@hust.edu.cn> writes:

> Translate dev-tools/kcov into Chinese and add it in
> dev-tools/zh_CN/index.rst.
>
> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> ---
>  .../translations/zh_CN/dev-tools/index.rst    |   2 +-
>  .../translations/zh_CN/dev-tools/kcov.rst     | 359 ++++++++++++++++++
>  2 files changed, 360 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/kcov.rst

Applied, thanks.

jon

