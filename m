Return-Path: <linux-kernel+bounces-72021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E785ADE9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D660B236D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367985476B;
	Mon, 19 Feb 2024 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PmJf+wkk"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6C54BE8;
	Mon, 19 Feb 2024 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378935; cv=none; b=lDb4zjy1OwjSCWnrnc22c3nzDVt3kH1Xx579DEccmqDn8lEqnSxXiHyqDMC7UK0vId1OrnEYowx+oMpPfLuKs060es5SWJDjabF+RgO/p9wKvsyHYvTaXNQRcVrHzwE24DMbCxR/0SOfsxR/LVyDE8t0U2Z9YB2JHUDbhH9cgOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378935; c=relaxed/simple;
	bh=lZvw3uCCRm+4mAqZE93DyID97E/alafM9ZroJwvfrrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UhV2AOYeoY7E1VhSfpeo21BhrCnAD8zuTvmBk8Huz+1xFMJr24IJuZseUcyBJa8xeEdYn8r7lMuH2mOt7Sc6+COj3xPKjYaEHvhDqcf2TdaHkoFj+fAnXkP5cilBw9xFtU5U+x/dSyJlWr1AzeQw/XLg1ONKuWN8wU0D/1PK5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PmJf+wkk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AE3A647A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708378921; bh=pe+dnDgry5hhr0l68V/DK290T6uYlt4qiIGGDU/CaQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PmJf+wkkxea+iBlvndaZKx554XJCwZ+rmtPYvZl6dOtnAn50xCDshkVXpoZL49v00
	 tPQQe/LZXK+mq2a5avLpfh6oQUIPJcFHJF3GN3dKi/+1NNS5/4cbzHPDOTZsP5wrgF
	 F6Fx7fV90U+sVxYibyHDmykZPmDFBeWIa2LYV9ObsGNCzPZEr5zLVg3EOHncH5lGRp
	 8BwqdFcA4dHNXryPqDhfXgcpRIF9WSTjCYIWrY669i82u81d2gWmynayf2bdtCpH79
	 tBfJYezICUplVAhkjdp9TyMxjKI+QrL2YM4r2PKYZ7TRmwQeIbLT/bfyNbgvKqz5rW
	 7MoGEtziDjZvw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AE3A647A99;
	Mon, 19 Feb 2024 21:42:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Juntong Deng <juntong.deng@outlook.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com
Cc: kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kasan: Add documentation for CONFIG_KASAN_EXTRA_INFO
In-Reply-To: <AM6PR03MB5848C52B871DA67455F0B2F2994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848C52B871DA67455F0B2F2994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Mon, 19 Feb 2024 14:42:01 -0700
Message-ID: <87v86km8ra.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Juntong Deng <juntong.deng@outlook.com> writes:

> This patch adds CONFIG_KASAN_EXTRA_INFO introduction information to
> KASAN documentation.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
> V1 -> V2: Fix run-on sentence.
>
>  Documentation/dev-tools/kasan.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied, thanks.

jon

