Return-Path: <linux-kernel+bounces-75471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FA085E926
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EFC1F24E21
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3D45C10;
	Wed, 21 Feb 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKEjKieV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42E42A8E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547893; cv=none; b=tbgtMjM1mbXnQAug9HWDhj9upATTlZqDPuNtXZHQDwlosD1KIDQipsjrmpZZpoQKlJmeTJw+p/kBWvP1zPs7Po8mNgT0glc7Z8opOIgcz5wBQVhYmaKd/eZJPVUCG4iIyLWAyxIbzaT3ajaI/ZVZGDQX/g7xkJ2YrojN4oSb5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547893; c=relaxed/simple;
	bh=NGyaURh4r9Zx9kSUoZd+AwfsWUAs4mYTOTN47/5bQLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9sAaTw3YWeAIW+eG0MfbgzBa7Wo1Fjfb1+o30A9il6DWxNeoxBafwOnvvTN3DTONpcvgZ3WEg08C9IJnMyduz37U5zkuB4yyAJMtE08N0R4xvee0nomIYtu+EIW7m3Qc0576+28MmJJ4pSoTHyBaAwVhspdQM+iz1yNz8NC/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKEjKieV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dbe7e51f91so37075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708547891; x=1709152691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+JpCP8R5SCl4MExppAiV+dYGLFKd6cCpdy0KaCUGD4=;
        b=jKEjKieVLV4zFGEg7WAy0n0dAlOEcCdmrA1UkTBKxLBL3/qbHM48x9LUDD/OQrKEtX
         vU3IGJRPNITscmh3hCuATLpycDRddHAKmlFadlsdKKMBWj4rRyGTTnq+IHuM1A6+DP8X
         mrN2dZeiA10uUpk18xVKNyd4LZSgYKu1MbG6BTvu2YATLORdtPXCf3OTAqSazCZQqdkk
         mGx5PSywSEWRhHJNTmIT2pdmr36qR1ymI2HN5KQRmXK3YF/92NDCfP1Roplwyr9dwTyU
         drEBOMKQB1RsFKfEVqW2kP0fpSqrM4v0QEmWJMpPzbLbU0kvSEAe6inCTw6suaQZPznP
         RUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547891; x=1709152691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+JpCP8R5SCl4MExppAiV+dYGLFKd6cCpdy0KaCUGD4=;
        b=cO0+Pqud1cI6NrxsI4khJ6rGM/tEjImZSfVONfEdjBSTrLHxILBETfJ7gUcRo35Zey
         k0wn0bStfAHMJVbWu+QJWKQZv60Ufb2KZavPm9GYJ18llT7EjA49fnvDJAxJmnUYem/S
         W6nScpgRLQ5e2sMnYkO18+XSYQvxUvUk7ARQ9maIlDfme4ucXwEhDzCbeUvTAe5gvjdu
         42KfRYfnwPqhc1345qo3sAxT5eS7Jw0fG1p76n2zsVFCYZKGmuHHhRp/K1h0hXfV1F3v
         yV873q7H2JPTrfDea0jY6J5NNMV+Pil8CT/+sLh826fk2RmIl1u4+pOu87qKhYSeW81n
         wZNA==
X-Gm-Message-State: AOJu0YxDD2C0xRWHN3qqi2TbX27S8/TYLMVU+PZJekqYyp03x+KpI1Os
	IlwjLPuydlqzyN8m6KKNZ7qKCyzRVd3QU1j0+IGT+DSkfU6CapY023veUk/yMpq/Iu1izVWcNAa
	bk5XEn5LgFWwpQQcHqdatM14gr3E3tLhAyFWd
X-Google-Smtp-Source: AGHT+IF8wpfBeD0iwu5k1t/0ihImHCcnx0Qsyu7YGzKtxdq4u2YfYtqbW18oCCAwNNQi46SFqxBO/QJep42mFRsQJYk=
X-Received: by 2002:a17:902:bc45:b0:1db:e5e3:f7ac with SMTP id
 t5-20020a170902bc4500b001dbe5e3f7acmr283043plz.7.1708547890791; Wed, 21 Feb
 2024 12:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221091908.1759083-1-tmricht@linux.ibm.com>
In-Reply-To: <20240221091908.1759083-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Feb 2024 12:37:59 -0800
Message-ID: <CAP-5=fVY0f4SkQ-F0KC2JXuayZyPHwXvsdS8dbMEvF8zg0vdwA@mail.gmail.com>
Subject: Re: [PATCH] perf list: fix short description for some cache events
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, krebbel@linux.ibm.com, svens@linux.ibm.com, 
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:20=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Correct the short description of the following events:
> DCW_REQ, DCW_REQ_CHIP_HIT, DCW_REQ_DRAWER_HIT, DCW_REQ_IV,
> DCW_ON_CHIP, DCW_ON_CHIP_IV, DCW_ON_CHIP_CHIP_HIT,
> DCW_ON_CHIP_DRAWER_HIT, CW_ON_MODULE, DCW_ON_DRAWER,
> DCW_OFF_DRAWER, IDCW_ON_MODULE_IV, IDCW_ON_MODULE_CHIP_HIT,
> IDCW_ON_MODULE_DRAWER_HIT, IDCW_ON_DRAWER_IV, IDCW_ON_DRAWER_CHIP_HIT,
> IDCW_ON_DRAWER_DRAWER_HIT, IDCW_OFF_DRAWER_IV, IDCW_OFF_DRAWER_CHIP_HIT,
> IDCW_OFF_DRAWER_DRAWER_HIT, ICW_REQ, ICW_REQ_IV, CW_REQ_CHIP_HIT,
> ICW_REQ_DRAWER_HIT, ICW_ON_CHIP, ICW_ON_CHIP_IV, ICW_ON_CHIP_CHIP_HIT,
> ICW_ON_CHIP_DRAWER_HIT, ICW_ON_MODULE and ICW_OFF_DRAWER.
>
> The second Cache should be L2-Cache.
>
> Output before (display diff of the first four events)
>   # perf list -d
>   DCW_REQ
>        [Directory Write Level 1 Data Cache from Cache. Unit: cpum_cf]
>   DCW_REQ_CHIP_HIT
>        [Directory Write Level 1 Data Cache from Cache with Chip HP \
>                Hit. Unit: cpum_cf]
>   DCW_REQ_DRAWER_HIT
>        [Directory Write Level 1 Data Cache from Cache with Drawer \
>                HP Hit. Unit: cpum_cf]
>   DCW_REQ_IV
>        [Directory Write Level 1 Data Cache from Cache with Intervention. =
\
>                Unit: cpum_cf]
>
> Output after:
>   # perf list -d
>   DCW_REQ
>        [Directory Write Level 1 Data Cache from L2-Cache. Unit: cpum_cf]
>   DCW_REQ_CHIP_HIT
>        [Directory Write Level 1 Data Cache from L2-Cache with Chip HP \
>                Hit. Unit: cpum_cf]
>   DCW_REQ_DRAWER_HIT
>        [Directory Write Level 1 Data Cache from L2-Cache with Drawer \
>                HP Hit. Unit: cpum_cf]
>   DCW_REQ_IV
>        [Directory Write Level 1 Data Cache from L2-Cache with \
>                Intervention. Unit: cpum_cf]
>
> Fixes: 7f76b3113068 ("perf list: Add IBM z16 event description for s390")
> Reported-by: Andreas Krebbel <krebbel@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Andreas Krebbel <krebbel@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

