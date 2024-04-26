Return-Path: <linux-kernel+bounces-159488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB7D8B2F40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92E1B237D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3837EEE3;
	Fri, 26 Apr 2024 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwY5ltnj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52D7EF0C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714104026; cv=none; b=tEJDXfl0Etrd3trHN2Aby05rHI2GoeQWQl/bB9sA/LSzOCJrlAPwc1sq/IsEChDfw0c/Qkp0n7SaLgSkXp6/1ci4+01w43K9JVuckUcFM2tcfNPgtyYNhTdiJpzICOQ332+XJxYzf/Z8DHPYFQT+PzIPNzFbs3bBoB0+HJnSvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714104026; c=relaxed/simple;
	bh=6IC3mHpeeZPSEwcTPiOjDlzU/H1EDBwij4FYzlBTHYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2DGoUQxWWUDW//Rr8eoetTEXNur43MKAOplun7qOUt86YNSd6H96yb6FuTaVJwxD9xlwgCPRKIWtYq5WBT7gY7goT6ua9c8QqSHvgLp+cMeesmWvCtg+0ZH12cnbawyohHWbZ1neuVwpohTTx/72Y32FeabCERPlRKFnGVzrJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwY5ltnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0E3C2BD11
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714104025;
	bh=6IC3mHpeeZPSEwcTPiOjDlzU/H1EDBwij4FYzlBTHYY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RwY5ltnjfloxnxt6e7hDwlYSn8WjhG8w44bQYv8c9N+gcEewrbLodw4s9gI+rXHGT
	 B5Bztdw3RCcNVMQUAGRKskKnpscfN1H0uMB9Eg4i+3lubnbD4WJAt+vUTOnTFgzni0
	 USDQAemTk25si6z3cTmyn8gaWPni6MxC3yoCZACn2a55Q3fg9HqtWBSlcpP8kq0A71
	 IK9aHAZcxt5iv14oIGV5zFpehthh2kQwydzl5kNrGrJsq8qULkrEANrYuE0i/JtigD
	 +hA2ZkjlwAQ2KXRNfAmpkrH7oiPoxobPs4subGQUfT0oIzI/JWdJFbrMeiL4BO3tzy
	 jtN/yxSq98sTg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so1991326a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:00:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWB27eWVuskdOC9u/9Gpu+SEfEyriGxouvGftqFdAywpnWPCwg9Ho5wBD4CaUdYX4i4BLpaoAo+AxHhS5fekGu7/VcaqrTRLkDozawQ
X-Gm-Message-State: AOJu0Yy5/pTZervxUzynZhgNNeV2Lw4oJb/qr8JXoriRXWBRuNjUT0H9
	/XAj/AvTN0wuEeNsqyK3lCADE+2zpViw8xztQ/i8fpFKXYdiPhbv4x095R6qPT/p2BsqJKoXfmv
	iQPK3UERLaU2C6983iy/ST6TCJbI=
X-Google-Smtp-Source: AGHT+IGlV1fQ4e/01Fk7drH6BYjUSOd026QEWYqg7bGv4EhojS5MCTGIlnINl+VGCsn/MVXlgOIXvi/wnOTiZT+QjHc=
X-Received: by 2002:a17:906:27c9:b0:a58:828b:a4a6 with SMTP id
 k9-20020a17090627c900b00a58828ba4a6mr1478943ejc.73.1714104024323; Thu, 25 Apr
 2024 21:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327171737.27622-1-xry111@xry111.site>
In-Reply-To: <20240327171737.27622-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 26 Apr 2024 12:00:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5EZ=7OF7CSiYyZ8_+wWuenpo=K2WT8-6mAT4CvzUC_4g@mail.gmail.com>
Message-ID: <CAAhV-H5EZ=7OF7CSiYyZ8_+wWuenpo=K2WT8-6mAT4CvzUC_4g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

If enable CONFIG_DEBUG_INFO_BTF, we get:

loongarch64-unknown-linux-gnu-ld: kernel/sched/fair.o: in function
`mul_u64_u32_shr':
/home/chenhuacai/linux-test.git/./include/linux/math64.h:161:(.text+0x5e4):
undefined reference to `__lshrti3'

So, could you please implement _ashlti3(), __ashrti3(), and
__lshrti3() as commit fbac266f095de92b93e7 ("s390: select
ARCH_SUPPORTS_INT128") does?

Huacai

On Thu, Mar 28, 2024 at 1:18=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> This allows compiling a full 128-bit product of two 64-bit integers as
> a mul/mulh pair, instead of a nasty long sequence of 20+ instructions.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index a5f300ec6f28..5a769bb92d7c 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -56,6 +56,7 @@ config LOONGARCH
>         select ARCH_SUPPORTS_ACPI
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_SUPPORTS_HUGETLBFS
> +       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>         select ARCH_SUPPORTS_LTO_CLANG
>         select ARCH_SUPPORTS_LTO_CLANG_THIN
>         select ARCH_SUPPORTS_NUMA_BALANCING
> --
> 2.44.0
>
>

