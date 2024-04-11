Return-Path: <linux-kernel+bounces-141664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4FF8A219E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CACD1C23E36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F0C3DBBE;
	Thu, 11 Apr 2024 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hV9ArLQ6"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF843D3A7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873473; cv=none; b=m/ZccQ15xfgWiqY0Up3o3OpOSLjB3KMrEpSErsDlfOTebnNJhsA0bJpU/V28MWHWGOwyUwmQiQQYhatGWzI6yLALHhktiDqCZ1LzJSigeOdYRMZxjWYVMwyn0+d9apTPSL2uJ+FIg0fsFXA2MtkVC/qvh2VTfnxSO0zbww+UB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873473; c=relaxed/simple;
	bh=FnX+ZaQMdazXyHUwAjsyIFZPxYO2MesLkHCsNTULegc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGJ08h3vZcB9MOV8M5b7mAug0/DxveZXxNYEBUq06hZKXVan3bhJO/bh7AajQsC9I5mpMXVXMTy1wVuI4HaE8JQ9d75mb9S+fmceP2EnejOdjhPlu72bsjt29TRNdDC9xuJQE57jNjmhO43cgK0bje2oqTsGs2XfajD/OZeC/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hV9ArLQ6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so247116a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712873470; x=1713478270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUxBq2p2MKqbSqHmXHdBK5t4v0sVp/NvWw9a6yoJVzk=;
        b=hV9ArLQ699yd/MVMzqdAOJBU4Oc373vlizyuYBxJqNSUXGxBAC4OkE8mDwmpWFjZim
         vpj50P07xYqbHvfumkS1nLdRMoulMWIsyrWC7USzS5fyu532DoUUOPO7CDOG/rhpGZFh
         1wG2179F1/X9Tzm6ThbmToVAVco6Gy/y0FMnoQeWLAb6eDSohJlBhdoKYggAqHpfcE3S
         sfgapOFRfkNYkr4mSS1Voo5BAhIc3Db8Ge2qRCcdWwCeOTq9sY/D/2j3DUnfVEsbzH3O
         PfvOJm5geoJojkRkHQwFdb+Zug91KgF5tSjt80qbiYmpyHpZD0aglFNI3XtuSWD/fe2f
         B2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712873470; x=1713478270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUxBq2p2MKqbSqHmXHdBK5t4v0sVp/NvWw9a6yoJVzk=;
        b=RIYqoq1dtPLax00xYE7kSrSs0AcwrezI3PM6V+Pm6f4UBBUzM6Jcyuou9xly6n3bnW
         q/2qO9gqqpTtmhDoAsuqtTMBy03UOQGg1GFWYLxTRbMnhmn0ec/GdChPqEhh3VmVyI/3
         6OG46iIbI5uLLQ1EC0kJJ0svCsIHl6HsZJpDQey4bXfw1rRKpD1Q6wtF6DgNxOWfnBv3
         DCcnGBethpA42OEBwTgnKeqCHsfqooA6z9GribEZEIPfv/gDr+rrcFCqEQuoWR7MP7fi
         dTod6i40UtO4M31u7tiO2sMG9XED2LBjbbZStR/lNNM+2Nxlng8vfNiHsaTFGfEMWDLX
         hIrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwJDr50HQryTIzMaM+heZQPBitrWQP+8bvc04c+XVBw229ma9UCD92ISckiKcpb+NylL0Q5HfUSnwZQI5tqRtWB1hFphZ5dzXQDrbh
X-Gm-Message-State: AOJu0YxRPvB0FxTCgd5gZQsikAi802B1UOfxmY5JnT1S2v/4Vwiazh5d
	oXlX5yX0dAUP0TBRSci8Cecmf6S+RnqpWSSCu7+mb7woaG4XPDDkRuWjzIz6Av2YPDK3ODKguCx
	BLeSjcCWFuAkX6lPahVjsfFhCPBwSejoMhOz7GVLrXgohfrmCOhsY2lk=
X-Google-Smtp-Source: AGHT+IFcZE6KZQ1GV1rCkfDRhHT+vuUZl1UyV0Sl62k7UOGuHiFip8l/8N57jxJEiT3IbnTfUjgTrxuelM1Oq3eVXLg=
X-Received: by 2002:a50:8acf:0:b0:56b:fd17:3522 with SMTP id
 k15-20020a508acf000000b0056bfd173522mr606015edk.14.1712873470089; Thu, 11 Apr
 2024 15:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
 <48d593c1-c706-4af3-aacf-d1329a8b0d4b@wanadoo.fr> <1a4554d39229c790c98bebb213bc9f2423cd32de.camel@perches.com>
In-Reply-To: <1a4554d39229c790c98bebb213bc9f2423cd32de.camel@perches.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 11 Apr 2024 15:10:57 -0700
Message-ID: <CAFhGd8rUz_wG+jkW=+17RpG2BQxaRMmZVk=g=G1FogMSeAD7jA@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: add check for snprintf to scnprintf
To: Joe Perches <joe@perches.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Andy Whitcroft <apw@canonical.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:56=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
> It could.
>
> # {v}snprintf uses that should likely be {v}scnprintf
>                 if ($line =3D~ /\b((v?)snprintf)\s*\(/) {
>                         WARN("SNPRINTF",
>                              "Prefer ${2}scnprintf over $1 - see: https:/=
/github.com/KSPP/linux/issues/105\n" . $herecurr);
>                 }
>
>
>
> Though I also think it's better to use lore rather than github

I am fine with making the UX change in v5 regarding using ${2} and $1
but I wish someone could have said something about the Github links
earlier, we already have a pattern going with these string api
changes:

     "Prefer strscpy over strcpy - see:
https://github.com/KSPP/linux/issues/88\n" . $herecurr);
}

..
# strlcpy uses that should likely be strscpy
if ($line =3D~ /\bstrlcpy\s*\(/) {
WARN("STRLCPY",
     "Prefer strscpy over strlcpy - see:
https://github.com/KSPP/linux/issues/89\n" . $herecurr);
}

# strncpy uses that should likely be strscpy or strscpy_pad
if ($line =3D~ /\bstrncpy\s*\(/) {
WARN("STRNCPY",
     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see:
https://github.com/KSPP/linux/issues/90\n" . $herecurr);
}

# {v}snprintf uses that should likely be {v}scnprintf
if ($line =3D~ /\b(v|)snprintf\s*\(/) {
WARN("SNPRINTF",
     "Prefer ${2}scnprintf over $1 - see:
https://github.com/KSPP/linux/issues/105\n" . $herecurr);
..


It should be noted that nowhere else is a lore link or github link
provided during a warning, so there really is no precedence. Joe what
should we do?

>

