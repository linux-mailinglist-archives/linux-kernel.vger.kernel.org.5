Return-Path: <linux-kernel+bounces-159545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A22118B3004
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F7C1F228DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8213A40B;
	Fri, 26 Apr 2024 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="nLeRzSY3"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4543ADC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714111330; cv=none; b=CPs+OpYOcNEaY2F5ZVCHS8zFHJKAWmMOz+bMTuXNQbx7WNH6TM6hUJcg9CCiHMW3jnWH63pIuh5N6YOmT4YWEOn2BM2E2399LzxyPafNepRMuUUfdBPtOM8vTn6yeiWlLQRsjwgo4xH/ESdRRfrUlGg5zXCzlQsQE2NhlKBnljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714111330; c=relaxed/simple;
	bh=3fagGxrg2kRluE5PpRIDkgUUaRTsE7xofY0NLRaL75A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5bRoZcFpmrqUHjENCh5zMhSvlmodHbPiD201alhb5kF3a25qxRAV3hn4yPMJQBQDmDJR3RRAKHrF5vPAMWhwQkJn1LmqqWQB/YhUNngUYJjCA3khMUMqsEZ5jsBJBJOMZy1WuGnXsqn+pN5Pdjrr8WfCIkMEIJ9aVLPcVxcqsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=nLeRzSY3; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1714110803;
	bh=3fagGxrg2kRluE5PpRIDkgUUaRTsE7xofY0NLRaL75A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nLeRzSY3go+34A4lqIcsPe8yV4jdgTo1yaQyfaOGcjkd3/Hu9cReMDgE+1taZ5iQu
	 K/ZZQEozsHVIZLzemDuzgWolgHHl3XY7yPZk64Wtgaa/jHDqcvkOUIgv3Gz76V4hCs
	 BlA7UCgyfLkSXrLBpsFR+NSLTs9gE9yhJZYOPuoY=
Received: from [IPv6:240e:358:1105:4a00:dc73:854d:832e:3] (unknown [IPv6:240e:358:1105:4a00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id DD9E666C6B;
	Fri, 26 Apr 2024 01:53:19 -0400 (EDT)
Message-ID: <ca10b9c005361e87dbebfd71c004f3aaf07e42ba.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Fri, 26 Apr 2024 13:53:12 +0800
In-Reply-To: <CAAhV-H5EZ=7OF7CSiYyZ8_+wWuenpo=K2WT8-6mAT4CvzUC_4g@mail.gmail.com>
References: <20240327171737.27622-1-xry111@xry111.site>
	 <CAAhV-H5EZ=7OF7CSiYyZ8_+wWuenpo=K2WT8-6mAT4CvzUC_4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 12:00 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> If enable CONFIG_DEBUG_INFO_BTF, we get:
>=20
> loongarch64-unknown-linux-gnu-ld: kernel/sched/fair.o: in function
> `mul_u64_u32_shr':
> /home/chenhuacai/linux-test.git/./include/linux/math64.h:161:(.text+0x5e4=
):
> undefined reference to `__lshrti3'
>=20
> So, could you please implement _ashlti3(), __ashrti3(), and
> __lshrti3() as commit fbac266f095de92b93e7 ("s390: select
> ARCH_SUPPORTS_INT128") does?

It seems not related to DEBUG_INFO_BTF, but related to
CC_OPTIMIZE_FOR_SIZE.

I'm making a patch.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

