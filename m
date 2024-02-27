Return-Path: <linux-kernel+bounces-83652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C61869CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DA71C23DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3CC208CE;
	Tue, 27 Feb 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6yII5JI"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650391DA4D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052679; cv=none; b=NMDKe1TlXRfG0b3b6/Tth8ARE5+7FgcZsmAHJxoD37tCbzg3vT9wZ0jNvWkHX4T1twmr9wylNwl1OP0ChG9fkGmcdAT0mU+ptD1FxS/GGNkPhqPhdiZpPv7PIYM7bBJKPMKzUoefmGQQeFNIbIkm3vLriZ8B8iRq5iVpM1N445A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052679; c=relaxed/simple;
	bh=OUt6CYZupNiEST0iA+DgEudMWAk4Tmq4OhXq/et4EQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dwm2XNgcfteqSTl8MQCgus7UqMtLKbMeT62StkgBdMyRNGKIt+v4TcRsTKCp/q3hJUuQSP4bOcEonU2VkRxWXaFT0lsfk5dwuJtKNGPWzJ9fguz5QRRdV7rgDuBbVQ//M7DYio6LRU3dSUlX6MbZUZfSR5K+mXCBbZlS53arZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6yII5JI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so3076801a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709052678; x=1709657478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUt6CYZupNiEST0iA+DgEudMWAk4Tmq4OhXq/et4EQw=;
        b=j6yII5JIgqiLHQaAtRGGwLjmtcNFyzZQNyS5ULy7mTXDjrXnLTAolaMA0H3S1kChAD
         5Nt1t64oKX1mx9zZsuFc9CiQlYTnPzLsKi43fYdkEk9gvBJJ8FPiOur4FeRG+4Dnvne8
         1az34K8t/pxq7GdRqfo+whW22iLjH7tHzW1siZW8XxRGt04xTKJO3l4CQqapp/jSayMJ
         D21nV4Jt9X09xdgtCITtsmXBQ4bZw+z2ZPtYf8WqP1tbyJA3IrpqQugs/b+ME/QpPcew
         v3AQ6bazqQ7t5RuxXrmqQz4hcBkzMZKNybh7UJIB7YJHneqfCiJv3MKMnI/LgDXZHZjQ
         /BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052678; x=1709657478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUt6CYZupNiEST0iA+DgEudMWAk4Tmq4OhXq/et4EQw=;
        b=Gz9J7C6IMkMF4SzL2wKOr9nr4afJIVQ+v1HvWdePTNaQp+AUB87+AvtlX1hIFdiCN2
         XYcjMwcjXfhI0f8+O7u4Y/GRGoogWRMvQg9u/yMytC6Lpu/MdAp7UQIIyDpOwXNJaM9w
         F7V7DBzqxpuybBNRB/cZ765tFQKPeYptkkjgDm8zDpepNozO9W+LgdBNm/9BvqE7UkCO
         ACnfazfVZamQYnwNACsrQTrq6CmU4zh9+zgnUukXyOs/XlFxVhEbMUV9F/Z0ORhT8Ax5
         V8RJo7s/gFzYxh/9UXX1wfjdIHdDeoRh6hYeggUTOQF2dLdejthNwUxpWjpcRmRHSJCL
         XebQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhT4rv4HNCsQLKQy21E5YUk1l1Oto1pGBP0GhaP5Ye9TJgmTP07Dct9POU34+7yNOzUqoP2LFDPiFOScAIthzow8TyUfw8U/teSFag
X-Gm-Message-State: AOJu0YyWZq/HQ9PLIq/MFtTS55BinYuPpVJYAbZ/jKnlvFmD6ptClkLR
	CgL3FATwDQaL/YmbvPFRv+U5KqcFEUsOQvFPNK8bbOtDBa5m2oCUc9/hMLDTLMhAhtsKArjXBSG
	h9bjLqr6QUyWKrifTQ87CUVltQVY=
X-Google-Smtp-Source: AGHT+IHGmk6+rXLPMR3cGR+KN3oHpSsuNkYvicHZWiyeZmHFsnZ45UBOqJWlavu5KkvgBCp3GBye1fgIbui93FLfwDA=
X-Received: by 2002:a05:6a20:ce4d:b0:1a0:ea67:ecb2 with SMTP id
 id13-20020a056a20ce4d00b001a0ea67ecb2mr3077170pzb.12.1709052677564; Tue, 27
 Feb 2024 08:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208002841.GA2601476@dev-arch.thelio-3990X>
 <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>
 <20240212234850.GB3221859@dev-arch.thelio-3990X> <20240213025303.GA4006766@dev-arch.thelio-3990X>
 <CANiq72npYCD-zKqcXPNOAxnKiUCCXGbFQaGo-8=0-171ni+ncQ@mail.gmail.com>
 <CANiq72kcQUuxcno00+QWrstrcfwC+2_Bvh+8dr5kgVkEtrWOEA@mail.gmail.com> <20240227153728.GA819789@dev-arch.thelio-3990X>
In-Reply-To: <20240227153728.GA819789@dev-arch.thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2024 17:51:04 +0100
Message-ID: <CANiq72mmDquTeoEVErwXH7bVhP0+UifCrK0n=-HD97noWLqryA@mail.gmail.com>
Subject: Re: Prebuilt LLVM 18.1.0-rc2 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Conor Dooley <Conor.Dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:37=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> How far back would you like it added? I don't necessarily mind
> rebuilding older releases but certain entities may notice the checksums
> change.
>
> https://gitlab.com/Linaro/tuxmake/-/merge_requests/364
>
> Not the end of the world though.

I think a reasonable set would be those versions matching the LLVM
that Rust bundles (for `rustc` versions we have since 6.1 LTS). That
is: 15, 16 and 17.

Conveniently, LLVM 15 also matches the minimum external LLVM supported
by `rustc` in 6.6 LTS.

If those are too much, LLVM 17 would already cover what 6.6 LTS' Rust bundl=
es.

Cheers,
Miguel

