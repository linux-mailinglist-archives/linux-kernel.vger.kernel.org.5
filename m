Return-Path: <linux-kernel+bounces-89899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FB986F70B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5A51C20C4F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7777B79DBF;
	Sun,  3 Mar 2024 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioFQoWLe"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723C1CA8F;
	Sun,  3 Mar 2024 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709498143; cv=none; b=L+Hgr+BMBPvWgvrruhU+JER/QkBu2coC0yMDpIIGi24r7a8Q/YZ3xhrQY2XrBv+o/betu1MyvidLLLexddvFvtqvVs6DHpx6SgEz0rdqrLMTZ0eywFs5bmr29OJ24q9ZzjiD9ahmsKQOfvBba0ShkT6fRg3tC5zNoGv+wkaiPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709498143; c=relaxed/simple;
	bh=3JSSjog6jBOBL7hZXfVIVhSsNnMEs8ziN/0JhQc+SPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHrxK8nYgc6I6qqqynUT4ApGGrAPulD5O+8l4+rAC94aAx0n4cBWI6RgX8kjloVukjK/uhTjLzQjRDR8GCQolSYaw9IRx12knPhznCnk/V3wY5KdMZTp/0f0A5AEu2W993nq2ObirpTdy91/XltpVhl9e2O/Lo/gujmUOw8SiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioFQoWLe; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d220e39907so56946421fa.1;
        Sun, 03 Mar 2024 12:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709498140; x=1710102940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJT+ndc9v3o7JNksRMDBSTHwWjvyd4VEGK50LzG93ko=;
        b=ioFQoWLeuSSzWAMZu9tCodzr7h8hytHlxcP/cc9Ztpp6/KNr+5FXua+Aa/PtSq6Sg6
         w+To+KlrG+Sauo1bsBYh/6ysLojp1A4EGUW2lk/Sx/lDaMxIwiahJYIBxob84xZRDE4j
         mFvz9XoyYFKslffY0Zyx5HqoE7m2qeYCjlJfQF+Bx5HguGdZqR/7uxep4O/j5ZXRO3GW
         uCRNQoFC10Apbb4WrYgLpSGYL96sc3pM6ePXeQw0ncqQ0bMJgsb5/tRKOWmby0Fzp6gC
         NijIBfFBKfKOp34VrJHsSngcjkhaU8kHAPxNd9IN/rGAt+9DbHSPTuP77msyz2Y1J5K9
         9vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709498140; x=1710102940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJT+ndc9v3o7JNksRMDBSTHwWjvyd4VEGK50LzG93ko=;
        b=r0Dm0iLvseWYb+4SBRbKPkZu738Ms+vD6AhvTCm/OGh1Yp4I+UD/aO0MTnD6GNKnM9
         lh2sPdavR4E2O+M8SJoKhzC9bZ4gQYpUKtjU9U6VZcl+KAQAOLMilWFUY32UcIzl2I0s
         3iyfajlalQSm2V0j9hXyHI5HB0gAyQQLqNUfBZFc3zVT0Myv++s3A7m0TOG8IQ3PHZih
         JFr0xuqLkO097lLAEFYwUJPrvVtbgfUTqQmrFSOLswrd1lEkT623nPuojitzxBplWzHB
         BrIRfOSQOJUD6JBfZGDEldmtquwasplYARS3AK+l0kvvOrqF4WSIERn8YrUpTk3W5jU7
         cNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbde4e2nDMiVR/6JuyppENW+vZUzRNSc5qZCF3RjWswecnNtWUhbUA5v4TUoo73jbcsPouQVpM9hp8OkHnn3WFc6wlUbB/Lji00QgcHk/vYH7FxY3RW97IQZSdx9YeADE4G78Lfky+OeypG5EZr6K8v0C8E0syAl9Ixg3WirfMFJk/OuU=
X-Gm-Message-State: AOJu0YwRqt+e1j5LTlFOrQnOFzc38bFTb7OhriiftFBxOspgZWGZXx+O
	caMxk7jPKKVJC0fjdENIa/4ORPY2q7zdO7b1xW5KRpM49ZgVFtdDif+AEUpOMlMq1wAFwCd0XI9
	CUViUykJ9JAapPXC/47w0kAKjQcM=
X-Google-Smtp-Source: AGHT+IHdip0bMcGfrUzeOctsLHBe+1ZQGMbRVpTiB4xYGUOZDEagXHtxZSV/hUCwXypipzTmKtnoEw0/JDLcV9xeuP0=
X-Received: by 2002:ac2:4a9e:0:b0:513:1acc:bf3 with SMTP id
 l30-20020ac24a9e000000b005131acc0bf3mr4763282lfp.29.1709498139839; Sun, 03
 Mar 2024 12:35:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-2-chris.packham@alliedtelesis.co.nz>
 <ZeIb_TaKK1DE6l6U@smile.fi.intel.com> <f17adc70-be85-4be2-bbe2-336866907d68@alliedtelesis.co.nz>
In-Reply-To: <f17adc70-be85-4be2-bbe2-336866907d68@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Mar 2024 22:35:03 +0200
Message-ID: <CAHp75VfCt-3wOKykUNE8MnV9nHKvkbDY9vs25j559+cX-OudzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] auxdisplay: Add 7-segment LED display driver
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, 
	"robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>, 
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>, "pavel@ucw.cz" <pavel@ucw.cz>, 
	"lee@kernel.org" <lee@kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Cc: Rasmus, Yury

On Sun, Mar 3, 2024 at 9:58=E2=80=AFPM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On 2/03/24 07:18, Andy Shevchenko wrote:

..

> >> +    DECLARE_BITMAP(values, 8);
> >> +    bitmap_zero(values, 8);
> > Why do you need this zeroing?
> >
> >> +    bitmap_set_value8(values, map_to_seg7(&map->map.seg7, linedisp->b=
uf[0]), 0);

> Without the zeroing above GCC complains about use  of a potentially
> uninitialized variable here. I think because bitmap_set_value8() does &=
=3D
> and |=3D.

Hmm... Rasmus, Yury, do we have any ideas how to get rid of this redundancy=
?

--=20
With Best Regards,
Andy Shevchenko

