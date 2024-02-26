Return-Path: <linux-kernel+bounces-82175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2AA868042
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E461C2346E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDC112FB28;
	Mon, 26 Feb 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDFXOhLp"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF0130E36
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974063; cv=none; b=j5tVFwMH77CVjGIk+7hUdKGw7toD/tnNpL3j8FRqSZc1UQcoFB8fMCkZWiVr/U6nSCBV9qJYpb4R4CG2Mbi9i/veAVDblg/n8sku2uUbebQwnOasBX3rC55nySY7YQjTZMoQy83SHpxSgf1nSmxK4sRh+qjox8+aS+e3j/km04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974063; c=relaxed/simple;
	bh=1hhaUbGDzpMTF3MfHDymHJddqqLuwyjf1WQHTAbVkck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0mBQSAqYeoRkc14pXIjymS8lA+Yh10KlXg7VXPA5F0HtEbizmYIOP0sCuV1zi5jalkva9M/hos2IsZtGrTpcNga3pB9VjZHfT2YQamX5d0UNguBC5sOR8e8BxKgyBMDt+3d6p4v3aCejMYmJI7sx3OZvcXqmzPrprE0C9QMRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDFXOhLp; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so6043449a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708974052; x=1709578852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgDeNYPtaHXphy9wZiqDQWIOOTL9WIsvd8TA8aH6k08=;
        b=GDFXOhLpSRJtkXp8BG70DYc6UN8/M6ILr++DotwmgivH1OBbQzjKrPsjuvorEIa4u6
         lZjuoatIzuhAjbOjFYw3tCFzFE7jdoNOkGBsogpueDkOLLQf1sNv/YtXLbC7hnrlAxat
         1hOzYFbVgW4mGlYnEPrwJcqSbsJwtrBUqtGIW4YtwxQZe2evIbeyfaOtrT6BzlEHirrj
         OCPHzyNlJn9fDDnOeQU2+A25aXfMTX2fXO5gy6uSHC86gPpS4/K5ztPTb0Uv1mO9M3S+
         JBffA+RtEZl8k/RBnlz3muNxJ5CwRxUnkuYzawAvWz4wfJ6g8wbe5OBLwoZnB5DxfwkW
         Esyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974052; x=1709578852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgDeNYPtaHXphy9wZiqDQWIOOTL9WIsvd8TA8aH6k08=;
        b=wvTIuPRtAMzT9v8/Jao0X/3/Ne7i6mowPVauDQ87Hw6Vjk5OCo1bFKouNu3hAcJtuG
         8kII1eS+VPobEIo50yz/YFJ10NlPut/8C41Nf1wa3gzcf9NkwGuBRXlIhnB5kY5BaQRk
         ntC0wS48TMxC7n92uT8/5KlN1QibEZGeBPGZz7SfHE7AdDgLAXJiQhDPER3HN+4dcX8D
         0CkyATWicnW3MFzaTOHlv1LRuQvNwZ5jntxGg2iryKEuuu3BRss87RMkqNKpX/2hLeZX
         HPeFgydkvehLli6CwHv9et99qvmiWk8MRO70HZPu+iIcHw1LSsUYT3+iiPJwZXX+vvDC
         B+ag==
X-Forwarded-Encrypted: i=1; AJvYcCWS+xy6nm+Lcu9hNUqR8z3G0nPNIWPXs1bVJ6VkciszjyIGJPmer/svx0qYWdAP+VpCTgsjyaU0XckUrT70pEsPqx3qgvZ2UttzV8hg
X-Gm-Message-State: AOJu0Yzl8FEPCItKmKsAMgUa0yrYYhXJgrywmLw1Pff1O4971OrtPH1R
	LbGKNpDimmyA6h9NRhWWgM1rpdVj7pzMtGx5FEyvxOCYQuI1qRPqKDLf7Zr1Wvls211jeIX4Kyr
	j6FaC9P7qVnjXBDruI8x7rvHy3J0=
X-Google-Smtp-Source: AGHT+IHzYNxDydGBNJcaanZENATz7wB4GJZT7IKZLQRNXyQ6ccmzVglFnGQNNFHku9P4xpXkWuF94YaxqF93GFs3rGQ=
X-Received: by 2002:a50:fc0b:0:b0:565:66df:b25a with SMTP id
 i11-20020a50fc0b000000b0056566dfb25amr7139438edr.17.1708974052421; Mon, 26
 Feb 2024 11:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226140649.293254-1-cleger@rivosinc.com> <40dee2c1-ff24-40b2-a13c-6934139ba869@sifive.com>
 <ea356036-5a0b-47ea-aafb-f9813cc6ec9b@rivosinc.com> <20240226-pajamas-okay-51e16426b0f5@spud>
In-Reply-To: <20240226-pajamas-okay-51e16426b0f5@spud>
From: Charles Lohr <lohr85@gmail.com>
Date: Mon, 26 Feb 2024 11:00:41 -0800
Message-ID: <CAGu26P_v9FjYq9Bncvfd-dBhdHQevvN3HpO1nqjA2hYFCpG7hg@mail.gmail.com>
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Damien Le Moal <dlemoal@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

WOAH! Please DO NOT deprecate NOMMU. I use the NOMMU build constantly
and NOMMU Linux on RISC-V is the avenue used by many FPGA soft cores
for Linux, as well as some limited systems.

I get new copies of the kernel when there are releases and test them
frequently to make sure everything is still working as expected.

For us we just don't care about XIP. I mean if someone did push it
through to fruition, I'd also test and use it, but I urge you please
do not deprecate this.  While it's sometimes needed a bit of a
creative build to get everything working, I've never needed to patch
anything in the kernel beyond patching in a custom console for serial
output.

I am happy to discuss the possibility of me and or one of the other
RISC-V soft (FPGA) core people stepping up to try to be more active,
but so far we've just been very well serviced by the current NOMMU
Linux setup.

Charles


On Mon, Feb 26, 2024 at 8:03=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Feb 26, 2024 at 04:25:24PM +0100, Cl=C3=A9ment L=C3=A9ger wrote:
> > I guess I could also mark XIP as deprecated.
>
> I'm not so sure, people recently added XIP support to QEMU (and sent
> kernel fixes in December). XIP is also not nearly as much of a problem
> to support, there's far less that it does differently, the main barrier
> was the inability to test it which is no longer the case.
> That said, XIP is gonna kill itself off I feel as it does not support
> runtime patching and therefore is extremely limited on extensions, given
> we use alternatives for all of that (although I suppose if someone has a
> usecase they could make nasty macros worse and implement a compiletime
> switch in the alternatives too).
>
> Cheers,
> Conor.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

