Return-Path: <linux-kernel+bounces-122311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2EC88F4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF7A1C294B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE732554B;
	Thu, 28 Mar 2024 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX7zyqJg"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E98465;
	Thu, 28 Mar 2024 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591083; cv=none; b=LIl7ic2C5yyzC8N6uqL51dW9qJtOpbny7gtMDVBlWP5aPeiev/q+uZlzS96fWxgHipwysqEsiKa1O/vcDnPCQ3rm1ZZPMIcQCO/KjWXUZ8Sx3UE/Qyh90X1BF4oAHCvw/oOcHue4xohvHdBZNq36cbiWUw49FWrviJalL88IXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591083; c=relaxed/simple;
	bh=17frHZKHa4HTS0M444Swz4V9jidjHHSAtk9DQb/zVs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCwsCHJYB2KLGY0CXZhBUvWEueqtUAdCpcEwgUBww1zPWCdfgvcvWl5++lbb43WzoF302jA4KDzgBrTA4gi/8T9c6CHF/FYNEdexW1PztDa7LdxuwATv/4NPDTzZ31HXX32XbTfJ3ZvTSa8qAoV5mt1tVzZM1ZyDmA6qsua7ZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX7zyqJg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so241524f8f.2;
        Wed, 27 Mar 2024 18:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711591079; x=1712195879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tosp/xHwhQFOv14TlgTnZk/pGUufTB1z88IENWTkKck=;
        b=KX7zyqJgBoyUxD9psSlG4exqFfRjo/QdJ2GFaaq15bCl+5jHJbB/s3TwKXWfc14bqb
         +wYMZP6+fKJZxwhKn9J4UpwgZXuc6DiPNs3G2NgHFTm455CRaiLA30rE3hmrg5GkZFI2
         YCG6jFSyMcIOIQOydDQaD9Z5URKbbeKCXFqGxjefwGI2BUHvERHtGrm607Y/cNoB4x8W
         0gVJP2cedfe/CkSgWprQGNa3oLulvYB9ZHm1CW0xMMNazpMeHlF3ElqhXIr7QU59PTgd
         8jbGDlLBJxQqaumIUqrEUtgWPuC1xRAoqJemt0B+PHGx8XBNChSdzqNp+fiGr7ikpik2
         HGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711591079; x=1712195879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tosp/xHwhQFOv14TlgTnZk/pGUufTB1z88IENWTkKck=;
        b=eCunpIlnN7xz04k09abi7b5nkxNYDUAkwCH1w+qjTadSC9/SPya75aUiaTIX/694Fd
         7BDt/rzeqs5LT/ZtkEl5ysS89WoenNCQ8XiiFGdsTREkGmeDqez3jm/d2y6WT3BBPcHn
         Eo5gr+L4IP39k04jDFzKf/0OxrF9sX/FuOXUSnugAq9j3Tio7B7WdqsIXJJzfy3ZMjhC
         gTJ17p2w6954n3y7U3ihBHinhowSUv+iSQJ2szx8b+1vU00e6dFK94xQWzchlT8SWNE6
         ruNxYnFLavnGlcMa6fHKL8Vzrpd+rJY3xMEt/Id5o4rXaB8JyUIF7RJaVRtR3mdI+Ngt
         xrFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDyC0/Z2TvBh0wkZRp5667OAI49Pe0ToLxFAWqkSHwH7Bwr/WRUGPHmdMwo7nSYLz9C3PYV+NPmnjXxLZPw75M9LW5A3xNGwEdMVW2SlszTV/CW/OScoUNp8RqpAaTtR8P91W+Ugx2BastKtGJUwzT/5EhJANMPo6xLiAMcJyyKOdqbLWp9abHVNvty/15Zy3k+pmj5Q==
X-Gm-Message-State: AOJu0YwrZNLtkXYXl18o1pih5tqn5zV/FdnIPAWJ4dZLAb4g/K9mUMjR
	y14pAF9h2gBR4O8xDpwig0DNpSFg2o0GpdYzohtyhFra9jUBQODg4rNsxdymy4tU7HhqUFdI3Os
	xNECOMak8632yo/Lz8LZjVJQUvoA=
X-Google-Smtp-Source: AGHT+IHsz6xL8bOK7aBf8BF761yTQJSarhpeyqPNrxEeiReNWPZGeG4ZKWWYpHZ4dezNtkqzoqFjScaO3BflrBK3mSs=
X-Received: by 2002:a5d:5486:0:b0:341:c775:68b8 with SMTP id
 h6-20020a5d5486000000b00341c77568b8mr1135611wrv.57.1711591079229; Wed, 27 Mar
 2024 18:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328125500.2582492e@canb.auug.org.au>
In-Reply-To: <20240328125500.2582492e@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 18:57:47 -0700
Message-ID: <CAADnVQJ3S2DpCTe6m2xxjwgmUO5wLknDdV68Y5S7Lit+jZy51Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the net tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Haiyue Wang <haiyue.wang@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 6:55=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/arena.c
>
> between commit:
>
>   ee498a38f317 ("bpf: Clarify bpf_arena comments.")
>
> from the net tree and commit:
>
>   45a683b2d815 ("bpf,arena: Use helper sizeof_field in struct accessors")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for headsup.
We'll fix it up when bpf-next gets ffwded in a day or two.

