Return-Path: <linux-kernel+bounces-78712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010C8617B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164FF1F22B44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E68526B;
	Fri, 23 Feb 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bY3wAw5C"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06D18AF4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705288; cv=none; b=IgQQKFe2GF39jp9qRnBOfr5t+btkWLlIwloEVHmKm15fYtU4v9omQQbsjLycxocQJ8ahcDBPsNbIhDI9BhRmSOU5MaYlPsyU9sIPpkeKDnWqS74tM9XUNBtqFpBTILy6Gjzrun6TUonaDncFmOBUUeRXtzlwAiMW8gj65CUqx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705288; c=relaxed/simple;
	bh=I5QFyxdVzWASuFrJaWSyJOfTumcmKNivw74+YM7+w4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICsOG2c6Lb+ZLSDOt17f2T1cjZWWQAfMjNvtmy1B60aZdv5S0ju/TZId1fMFJv970eZpAJ2DtmIA9qOnHiVa5nnEaAzY0I+vOQ1U45FodIye2SNS5i9yaqfylvX83zT21bMzEEPeL+7YrsUJA7Z3DF19AlY+xsOzj2sNTS4X6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bY3wAw5C; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso397295276.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708705285; x=1709310085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=531p65ZfbJ3tCm0in//zgzyoYtsDn2UJBD0qfAVVOaI=;
        b=bY3wAw5CywfIZWtYS/ttvkZuwMfm8zGaqmO0OYsezaUOs0D7AkBMWDNmeqvy0SWMzs
         7lzXzP7L8turbXca64iRA7WEAkHluZG3dcCm3v+wUFqN33tOCfyJ6WCHEeB4ksuMB2OE
         Ny2LQoz1hTLK0WDAzVEHL4V7/ipZ+DBPzJ5SZWchvfSZqV0xFJLprjvJpZkG799yLjCb
         C9bPkdaoe46LT81afsTH2gm7t0xQbvJ5PClSflv01cctaZPymnbv0uwj9BL5AUcEG+ug
         9ZX4gO3TvSsFOTQj6wlbTFkQJog/mhQTNutZ2HtvTFZ6lbu4cWUFyqLJcYKvz5C9gIOP
         IrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708705285; x=1709310085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=531p65ZfbJ3tCm0in//zgzyoYtsDn2UJBD0qfAVVOaI=;
        b=bD52wyGizGIGfvAw8F9g/oCRW+Ml0KvXHmbYU+AffxRr1pusqqj8uNIA5GNiPswq/q
         H6rtqBG6AYngSe4mRO4Wqdq06SVh8Mvne5il2lgZ1lIJFDp40wioXmOeaIuXnnQOuzi4
         qGP6HWo2eK3KaHcyw2p5RCiAQQybvu3snB5PwmLzcINfLW+RUOtTHdRfgR85hIcJqh9V
         mzUVwTJ2qInB55GujoOmVsLHLCTOqsrOliUy8Ey2PEEOF8hXnYUGhIGxZZlHRjgyASPa
         5YwHM4o1bxnNPLZ3yJV1TBWOY9FE3jgr6YHCRqi9IGsZNN8HkUAlA8SpgcgC1eLmFivb
         F4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrMx1wGaiF5Qzojdk0WdV326Di1pN14rPZhmELvCNLB3n4l/Xf4BkB7IsmA/gRZKkMg2eZ05ii3mm2wiTXw9BEz4uWqTb7XlnjT3Ad
X-Gm-Message-State: AOJu0Yxeue0GRJRVgDOwfRwbWsIPyH7ZscGrRDm7loJxOX/ei3EkZtmU
	XGKl+DNSQ3BWszxDssHqAyOhlxsjlkGz3EZ5brWmdK9QOoZGUExdAyQBClFSC52sII15vqf9LlU
	lPMjDT/Jfl/VFHk/A1/92SS5Jxgq7ieVtzCTF
X-Google-Smtp-Source: AGHT+IE4FvTSxbuO+ftuRzsiGCOPBSf8+pLd8oVyNiCVjjjdg7HtSUr/AB6gZpwpMPigIzKnGNoZrdrwimEyPJkfzXo=
X-Received: by 2002:a25:6a86:0:b0:dcf:309d:cc2b with SMTP id
 f128-20020a256a86000000b00dcf309dcc2bmr245419ybc.18.1708705285629; Fri, 23
 Feb 2024 08:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223125027.1c9f4f07@canb.auug.org.au>
In-Reply-To: <20240223125027.1c9f4f07@canb.auug.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 11:21:14 -0500
Message-ID: <CAHC9VhRP4bKeBYcEe-xkdsXKa9XJLPxObkorTSbmE85WxT0AoA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the security tree with the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 8:50=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the security tree got a conflict in:
>
>   security/security.c
>
> between commits:
>
>   1b67772e4e3f ("bpf,lsm: Refactor bpf_prog_alloc/bpf_prog_free LSM hooks=
")
>   a2431c7eabcf ("bpf,lsm: Refactor bpf_map_alloc/bpf_map_free LSM hooks")
>   f568a3d49af9 ("bpf,lsm: Add BPF token LSM hooks")
>
> from the net-next tree and commit:
>
>   260017f31a8c ("lsm: use default hook return value in call_int_hook()")
>
> from the security tree.
>
> I fixed it up (I think, see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks Stephen, this looks correct.

--=20
paul-moore.com

