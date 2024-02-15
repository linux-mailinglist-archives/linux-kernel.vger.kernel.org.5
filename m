Return-Path: <linux-kernel+bounces-67594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1E9856DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441581F220B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A613959D;
	Thu, 15 Feb 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="B98oXX2W"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B601386AE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025774; cv=none; b=dkfDxhxkaQU99kiUW4SidF8RIJL/HI5zWxeXVdOxkKDvwH1FLp6wKjrQOYLTxUdOjIUqYn1VzL3CHZlsEpYHkY7sqnGLT+SBXSXCjGjHsTzC1phiwFTF5wpdwnIHv1iRaAUhjFoKwMb2+ybynGgaCeaLH2IZ6UrZZzQLwtrczVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025774; c=relaxed/simple;
	bh=jPsjwpCsPFtie3aL5I4bnB621QVnfCINJSy3+00awoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Beql+2FjwaKhasHMGDIt/rCrWOxC/TxnyvVFm06XobuoLLebUOBq1sYh1lsBchobYhTFl4UEgaJTrCunamWjhX5dE9zi64mdcpb2rJ6CPGPKFBnbdgqawLODUs2xTj0ruYWotx084kOkEUlBI2yTLba3ulQ/3eRSemHd/+FIXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=B98oXX2W; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d11c55d7f2so18444221fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708025770; x=1708630570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5YGsYL4MexNc49XeQvb25R/CmGSgGiGGhpjv3r0dFM=;
        b=B98oXX2WpikdhgxRcBFknuVGuvcl4tit/ma4U3TEmOtn0h44NyNe65LuVSUJ5Or3Az
         nSneXl+C8evWyy2FPzHxpiX6SYK2Ys4sbz+gLHx4bZuddmV5zB9rnNqlj6CrkZxkxdVq
         tSeoaVNCLWkFyx/AEjg9HwIQCl9wXP9R+vGz7j6s9+BAjnwpT3PYIv8S2pYLk1LDfxm9
         F0EgHM1TqcEMNZNTEnw+9e+HCSTgpKWzIASyZhPRF/T/pYnJaNy/8PlJZK94YkonRE9q
         s2kfHImy7Kr7+GDq7Chp9kz32mSV23kFxMcOG9jCXy4LMxfLwO4C+UtzZR+9akQbCRau
         N7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025770; x=1708630570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5YGsYL4MexNc49XeQvb25R/CmGSgGiGGhpjv3r0dFM=;
        b=pd00kftpXCPhH5MTu1gOXAnDBHpuHG6iM6ZhrBXQAknLsW5hyEUdShGOSICMAIbWQQ
         Sro/pyqC+aoMmAZs15yN1i89FKjGNMO8BFdygR73JLwCIUHx2LzTMcfQ+bCB6ip9tB8S
         tuNUq2rOXuLy12d5TfQaQkSEiRX5RNW8zl4F92BuucU/oYAjINR3lVsvQTj7rTCL6qlr
         VYcCJQehPDGYtNuqw+Ud+sKNQr1sJZKg1/O2KRLMa80say2PNXQ8JWN1wVAXOJelP4bh
         iaZ7/9sG6JFIPZh0LOzrvMpajVHPBngd19CgpP2TOgGp3yFhe9B7dIL2+Q9r415bQHtE
         Gx7A==
X-Forwarded-Encrypted: i=1; AJvYcCUvybZ3I9rStP63JAB5VXTVT2jzwEvO6YooolCPGn/WMxo/+NscEm46rW7NZQ0Pwg4QLi0ufU0Q1nwXn7eNX6/Xvc2cSg1ATRWMkQ3X
X-Gm-Message-State: AOJu0YyIa6o0CcXFVpUr9gGicmBffMylHFQIaPWDdEFBoXjQDjjkLItg
	Abm5Htk0d6tjgN37oW5VRiQo2jt2YrghJ7A2Rfh+avHfOJO8J15OlW1I9OkRsuQI3tWZHo19kRq
	vqaoOOJXBLzliPtE2vRCG5lvD/rtY2yJD4igURA==
X-Google-Smtp-Source: AGHT+IE3fm9OGO/kR/idSF9H8ByFMb/mw9m08bcxZR9I435MatzVxuon1xBWUvPmSxShuXEB5wmZs22NzOP1a1LdWXw=
X-Received: by 2002:a2e:9e8a:0:b0:2d0:b025:f1ee with SMTP id
 f10-20020a2e9e8a000000b002d0b025f1eemr1854739ljk.21.1708025769727; Thu, 15
 Feb 2024 11:36:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215145602.1371274-1-max.kellermann@ionos.com>
 <20240215145602.1371274-7-max.kellermann@ionos.com> <Zc5lUbCU6xNXv6jC@casper.infradead.org>
In-Reply-To: <Zc5lUbCU6xNXv6jC@casper.infradead.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 15 Feb 2024 20:35:58 +0100
Message-ID: <CAKPOu+9z0T=dvXMA6YUkuaTnEHwz02jRWdCdAOJ+4spyknMJ0w@mail.gmail.com>
Subject: Re: [PATCH v1 06/14] linux/mm.h: move page_size() to mm/page_size.h
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 8:26=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> We're really close to eliminating page_size().  Just 23 callers left.
> As such, it would be a mistake to name the header after it.  I don't
> particularly like how you're splitting up mm.h; I think the real problem
> is all the code that says "Oh, I'm allocating memory, I should include
> mm.h" instead of including gfp.h or slab.h.

Yes, a lot of source files do that, but that mistake is not something
I'm addressing in this patch series; another patch series I posted two
weeks ago is about that.
This series is only about making sources lighter which currently
indeed need mm.h.

> But if you must split it like this, at least call it folio_size.h

Okay, I will rename it for v2.

