Return-Path: <linux-kernel+bounces-83319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DFF869201
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A055293D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E92145B3C;
	Tue, 27 Feb 2024 13:30:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567B13DBBC;
	Tue, 27 Feb 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040631; cv=none; b=W9rn7XBM7stMxmdiXZnuSZkZwAi4tF/JZqIyswJ6a0qShoAMVWFWcZ/wSEVT0pDny+FzhgJ8RU4m2FQ+u2sjDhcC/sAieMlN3t2FW+/T9zVBSLBBKrZbmI4t8BCgM+BtmjBnSkIbk72XVfs++USsefpOlqhaHQzaCITEdOzGaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040631; c=relaxed/simple;
	bh=mlRi5Nka0wpfL8qQXqULqBQQwVLaXT/zfxT4lXhHpz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RayC5tAsdALIRiyyHjYjrC60CfWXMIfE/fj3If4Zr0OFtFwO3PHtYhyGv+pfYZW98Z7LWPQNx8+z6WHLzIwoIW6TsXQDU1KYTMFP1CysEsKgj4mQy/q4Ks3wENNlQt09CDCvagpiybe69gA15lhzvAWDcJGK+Y9R/zCT8AQBgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDC5C43390;
	Tue, 27 Feb 2024 13:30:28 +0000 (UTC)
Date: Tue, 27 Feb 2024 13:30:26 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Jinyang He <hejinyang@loongson.cn>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Youling Tang <tangyouling@loongson.cn>
Subject: Re: linux-next: manual merge of the loongarch tree with the arm64
 tree
Message-ID: <Zd3j8g-eE02M3XCJ@arm.com>
References: <20240227100337.4e9b64c1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227100337.4e9b64c1@canb.auug.org.au>

On Tue, Feb 27, 2024 at 10:03:37AM +1100, Stephen Rothwell wrote:
> diff --cc arch/loongarch/Makefile
> index fa4fb09909ae,e3bc02fb7fdc..000000000000
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@@ -82,7 -92,15 +92,16 @@@ KBUILD_AFLAGS_MODULE		+= -Wa,-mla-globa
>   KBUILD_CFLAGS_MODULE		+= -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
>   endif
>   
> + KBUILD_AFLAGS			+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno-relax)
> + KBUILD_CFLAGS			+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno-relax)
> + KBUILD_AFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
> + KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
> + 
> + ifdef CONFIG_OBJTOOL
> + KBUILD_CFLAGS			+= -fno-jump-tables
> + endif
> + 
>  +KBUILD_RUSTFLAGS			+= --target=$(objtree)/scripts/target.json
>   KBUILD_RUSTFLAGS_MODULE		+= -Crelocation-model=pic
>   
>   ifeq ($(CONFIG_RELOCATABLE),y)

Thanks Stephen, it looks fine.

-- 
Catalin

