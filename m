Return-Path: <linux-kernel+bounces-123847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48578890ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC0CCB22782
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1162A935;
	Fri, 29 Mar 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBr2MLfh"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B27FB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670423; cv=none; b=GdYVXmbrMNk0oBZrnFHqpPAkh7bLCfeAsc3kRy45VP0lm5SBxJPdI8IfZiNCZ3afllt5QxT4oby11uWtHuS8+/gR8TI+e++5tD9Zm5SdWRM/j4EDtxBsUJyeI1wZ9uJTcb096EsW5gATKOJ3qKCbr9cwgifm6r2roSKIEojsFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670423; c=relaxed/simple;
	bh=T11tKOiumhan7/aJq4T1XnpxT0P/7w0lhoUT1uDz5xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFlZ9VBRZg3YqNfYSldFwMDrtLUSmAq/ADLSOmbIA76k2HzNPBEJtq0aLrLXUJqyVxVlEZ+JFzpYZTJhaJz2HKYwNGMBs7IghgAEGaRiV5iZNSgKRaQpz1oFWR7X/pnoGzFlI9qCPhmvP4lOy8DWpqjQNFHF5nFN2UNCPq/TZ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBr2MLfh; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso1596403276.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711670419; x=1712275219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T11tKOiumhan7/aJq4T1XnpxT0P/7w0lhoUT1uDz5xc=;
        b=pBr2MLfhvMUStzof151jmDBPoDuxmWoDcbB+JOWt1oxnRuZSBFjbVdLXYRnqzYw3nd
         P6OmUZnsiU+wtDW2xQ2LP8oHzEXw+7Y1jryQ40pT+ItZjCrWCNunIoVgN0MZ8qXMuSKd
         G3Gs/AHyZ37OuPIaxFdtFbFPY4MqRClMGvCEZCXctSfRKgHDRBJ3a9kc3DTGKwsoS3SC
         NycENPBJ2BpjVIlPs1yFECw+Wwk45l3G6kueZq72FiBG5A+qbNue05aQF4cckMsNjlxO
         mLj+l1TKP324ka/M6DOCfg/5Hh9qJpn79Dbf0s9cSz8Z5i5gugRGosrPrliq4pype/iB
         2GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711670419; x=1712275219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T11tKOiumhan7/aJq4T1XnpxT0P/7w0lhoUT1uDz5xc=;
        b=SXOKF8HMjhRotkCn80cIjj8zDwkMxsklD/aiKwFuF4QAxDSrErff7UN16kvtPB/HFm
         wOWBpMwkUR4MV4v0sXDX5Xy9NlrDpAnCk2797edMLBAGa+jf7IN+re80dmT6CYNZ7uJB
         c2kIpJYzvKtDPRgJ0apHRMBrLy/XVLQysWOmIdd5T0rKmFf/ADxZeV7bG/hPk0fmiqNs
         CCFlsEAM9xTXhFqLlBoZkdZ2huXR3AzLJZLdJqMzBKzshpER1D3U6Gzqq4ZT6eWmDkpr
         J0lF2/nXpYk+aeMpZ6FJpwyS3l7CjQEdq2gB3biQypc5UwVY9Qmbhc512nchp6XmKKv4
         wbMA==
X-Forwarded-Encrypted: i=1; AJvYcCXDm3f2RxqLBG8UJz+GoWBcwbgeS4ajo3Zgy2pDPT9Vsr5UFhkUBpuczDiIHm6OM7ymgNc519roxNe4FgKULzGKxmtgxugQyONxL5eM
X-Gm-Message-State: AOJu0Yy/NNqDz96vjX3XEclf/FmDPTzyk7x362O1Sbh0fakhDtlVVxXl
	jYLhOLeArq5vCVxK7cfaW3RhNLM5Dy12N1jQcFIgtUNaLRxDoHy5bVb79NRokZLgcVyLa7CBctA
	O2btxuugXxvPWVYWMcQeAJywpQ+8we71QHIyp
X-Google-Smtp-Source: AGHT+IGF3VENnshqQcApg+O/wjOuPYywblLF9c/PO9GX1CsUXA48nDaHFlPvXqTRUPIpQ75kg493PggsfmaoNGiJqu4=
X-Received: by 2002:a25:9b05:0:b0:dcd:2f89:6aac with SMTP id
 y5-20020a259b05000000b00dcd2f896aacmr820996ybn.10.1711670419054; Thu, 28 Mar
 2024 17:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328145323.68872-1-tursulin@igalia.com>
In-Reply-To: <20240328145323.68872-1-tursulin@igalia.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 28 Mar 2024 17:00:06 -0700
Message-ID: <CABdmKX3V3HGA4mNQvqHqhcLqyr-A5kJK8v9vmuDybRvV-KsiOg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Do not build debugfs related code when !CONFIG_DEBUG_FS
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:53=E2=80=AFAM Tvrtko Ursulin <tursulin@igalia.com=
> wrote:
>
> From: Tvrtko Ursulin <tursulin@ursulin.net>
>
> There is no point in compiling in the list and mutex operations which are
> only used from the dma-buf debugfs code, if debugfs is not compiled in.
>
> Put the code in questions behind some kconfig guards and so save some tex=
t
> and maybe even a pointer per object at runtime when not enabled.
>
> Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

