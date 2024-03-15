Return-Path: <linux-kernel+bounces-104552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6487CFB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B0C1F2362F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6B32577C;
	Fri, 15 Mar 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="kEzOciAj"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089F288DB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515009; cv=none; b=djwFXzw7ASO+pu3P5iYDlyLGQKNylcBelXmtdfoErncjAIeBydVyh5FRW25631yCtfpA60RqCnhqFzlxwpn82FRXZwYrU29/iDHEtaIG4Oqqu9rEtFmCVia2b/RNj5HzWNegsokTVmaTRZ7U/Sk1MVcGJsu6i1Xdr6tDFYdZfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515009; c=relaxed/simple;
	bh=X2wT/BzxQKN1MciyzH4oQdmRg/MDDXfK0mOlDaA3dS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4GNUF/l3JBQUXlAlYj4GTGS7glsfpECLbub6qJg6NIsugAyNlLmN+E2HuJY1p9VB7K5Yzg4pOT64EfMORfAbgFPkGK+oMMTeHYl0xg6OdZmPU7WacMQTrOg7iiA9HlAsIw20TpvHLlh7IWC6LDQ8nflXlEIiJJuEVqmf2j3Opk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=kEzOciAj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a467322d52eso246386166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710515006; x=1711119806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2wT/BzxQKN1MciyzH4oQdmRg/MDDXfK0mOlDaA3dS8=;
        b=kEzOciAjMA5phAV/00wPYG5sZcTzbhJyA9Yo2E82IIOMsTSH2p7d4JDKqicRbudlGY
         g4wWMPRzq/lvF25JBhalwacac20xpAEuIVEq9I3T9yhUNNs5Rsj7WvOwmzN4fuYgzOdH
         veJ4op9RJEK6qhSJvLmpNiGp50NzIQF/Ryfy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710515006; x=1711119806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2wT/BzxQKN1MciyzH4oQdmRg/MDDXfK0mOlDaA3dS8=;
        b=ElRkgjYTvZ7x+6KW7FMexKCTlIQanuLVJen8UZPH2NGyhbF/1gu9QI8JhAopOQ7HUd
         n0100E6RQ87wu12Bk6ijvWOFUtWG1UZW18xfHlN94434dVeEV8OrhINnFXDfXxhweYCZ
         eTPfZ5mVO/RADwcajapmXwhAA9ssm2n4eqLqPix3XU++vFNGw8BtAWI3HymxEAuO7hY+
         jgmB+wXyQ6t980w35QVbsz6jzi9OZd45cIWsSx8ZlOGITv9k5yBumui6NKgxUqXwfprx
         MvTdnErdr8AN4ho3RTCocMjVt1qlcjERkVzZPOdWp9mLfegPsaVqflqWlSePwJFUnxUp
         EDUw==
X-Forwarded-Encrypted: i=1; AJvYcCVP/0Te1xYMetF9SYiutP1TDlKb4ZZMq8+0IrlLpQ2r0vEKy6pVb4h+h8n9TtWVClTBtdx4OBjRxZXxTy813dkoLjpqgS14o8lMDShy
X-Gm-Message-State: AOJu0YzycpWukVMFZAyXXwRa+Of9TMNlrtvFQ/fUujuMl5fZLSFir6dC
	KKgpQn2RP2S0PEGKO6QW/eb01BIB+spNQOHWlxLuMxnoDz8ewizZoEnWCZi6vkDBkMiWgaegxSH
	mU6jOT4FEOyR3VT14Sx1DC6aDzlkVvtzQMr7o+Q==
X-Google-Smtp-Source: AGHT+IGWgmfkja/H4b5nneN2aa04dXN3RKuMZKfXyBOXRkigwPhRJyr2zzT1SFedI9QSjahv9+IVHf26dBfqo5+priM=
X-Received: by 2002:a17:906:b899:b0:a3f:5ad2:1ff0 with SMTP id
 hb25-20020a170906b89900b00a3f5ad21ff0mr3527043ejb.46.1710515006228; Fri, 15
 Mar 2024 08:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com> <20240315113828.258005-7-cgzones@googlemail.com>
In-Reply-To: <20240315113828.258005-7-cgzones@googlemail.com>
From: Tycho Andersen <tandersen@netflix.com>
Date: Fri, 15 Mar 2024 09:03:14 -0600
Message-ID: <CABp92JBZXcfNgh=0Np0uH-XtxioqHXL2SeTQQ=Fc7ZeGNuFQjg@mail.gmail.com>
Subject: Re: [PATCH 07/10] kernel: use new capable_any functionality
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Peng Zhang <zhangpeng.00@bytedance.com>, 
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 5:39=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>


Reviewed-by: Tycho Andersen <tandersen@netflix.com>

