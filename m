Return-Path: <linux-kernel+bounces-98562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D1D877C05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960921C20DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5915E9C;
	Mon, 11 Mar 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZ4Cn7Na"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB911400A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147499; cv=none; b=D6NZPqaUwj+aLT3imZb3XmrYK3zmHGJOTqoJmFZYPN14odylewD5UM7eCDrOxZGMOqcRLECKD7Da8gxVds0F8oc42ZmTEnbVqbG79aBAtK9YRpjxl1imel3FyCof/4xd8uZonhjxcqghNVMM8yaCybnTJmv+fmJa+AoZfd9SiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147499; c=relaxed/simple;
	bh=nmwCd6oE+Z8Sz0paNTI/cpUPNTE2UPvOTA85Lr3hxlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUl+k6uctvnCRb5WFQcZTiQlpgEgRwH2ErI1qThiP6poO3HuYUcPEd/OQbuFJPX2pSrA3FdmDUhtq5eRNX6+vrGSOSEK/elYdh0vyRPGhJBpUvZEcSK5KeSr9nAQwDO2FLS53DB5wiwSMiG3/HER85KxBGEky+LbdRv/AK/Ytfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZ4Cn7Na; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7dba8bc7d7cso1558875241.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710147497; x=1710752297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83LHccGVHbfUBfKOspQNihL8xbh5xYWLuxJMeB/7Vbg=;
        b=LZ4Cn7Na/7gVWqi+uIu89Rag9CZCaVHBumyyC689jTsDnxMOOelgfEPYRm8VY3/dJB
         w+K3mSJIPPHcZBXw5TMatP7X9S9Vs1AX9Pj+K+XFpXlnCpq+x1lTFYcgDMv87TBjaEEW
         srzs6/TKjOtCnHsHeZU/xcEb7GKpRU71XeE1ItyXuEtceMirQxeaLncGrvCGDFoOjFQz
         kduVDe32xnuMpn1MeEPihKSxQRN3zTnE4O2/4D6+kVsZMsCM5vBbEDss5Pz4ouqxIbkv
         qiTXUg1psNdju34Xw0v0+TISuWpQcdut6cDyuNxVAqn1GjRArmUienV5y7P/DlbOhjN6
         qsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710147497; x=1710752297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83LHccGVHbfUBfKOspQNihL8xbh5xYWLuxJMeB/7Vbg=;
        b=XBVyvCdSBHaEL00by3y/eRIC+hRsUbgAcu3BKGuS9H1uD5qyfzNRxAmdX7ZO248eZQ
         Q5aDGcD4bMX+1mbat4zglOcVp6/dEeqlo2c7LHtt0nVdTX6ZyftW5qhXuTHKeOMUI0D3
         D3jvpbGdUUiI/D56/5+XKB6PCyDGNWNQSIVtuvcZ5p45CmPBNs/ZYqONmo1vntb+B3GQ
         XTSbuE1DabJ9enbLL7vbG2wVMUnr2WUlj3l/4roKTh0VRH0ikPClz5pUmY4yHO7nhIIE
         8iULNXMceJGQtJDejQKuAscWHxGzaM6tpJudd1ZYMnVfejZagzarsCrCdrFk6CCyWZM8
         N7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUdEgdhhyGTXAvu8TA415PDv/THcdJv8koxha1Q8aR8JZuXeumMGakqXV6i57RF3sHkXZOQ/rzqM6YYN0KMH54Hrv8S0iooBL/xIoAi
X-Gm-Message-State: AOJu0Ywl66YLeTp2gDZCe10nnWdKMaIk+cESsALsv1NkEN7Wimrm1GjB
	bKqkXlyArf6hb+jorxQm+awaxAVq6QTy/Dpjz3GtSmBiT5kWczCL3FERkCwc4WUM7wXr5eMKnCj
	HLJxtPhkyRZz1NY/z93kWEEAWct2akfE1/Z4U
X-Google-Smtp-Source: AGHT+IHr5dSY0omrZBiIUNXcAvVnpqWlW0t/hT6ZoNUGLielnh2CK+N9PUKfQgh6cwvynZjTrk7MftnuyPMaXYjPwZc=
X-Received: by 2002:a67:c58d:0:b0:473:1a67:5af8 with SMTP id
 h13-20020a67c58d000000b004731a675af8mr3827778vsk.13.1710147496816; Mon, 11
 Mar 2024 01:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-arc-for-list-v2-0-ae93201426b4@google.com>
 <20240228-arc-for-list-v2-1-ae93201426b4@google.com> <e09ed8fc-d305-4740-8c6e-7308a634b822@proton.me>
In-Reply-To: <e09ed8fc-d305-4740-8c6e-7308a634b822@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Mar 2024 09:58:05 +0100
Message-ID: <CAH5fLggWwOLR0c-MR_p=Tw4vS8RHAEhJZsMLyx9rhYo=eVu+9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: sync: add `ArcBorrow::from_raw`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 1:56=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
> > +    /// Creates an [`ArcBorrow`] to an [`Arc`] that has previously bee=
n deconstructed with
> > +    /// [`Arc::into_raw`].
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * The provided pointer must originate from a call to [`Arc::in=
to_raw`].
> > +    /// * For the duration of the lifetime annotated on this `ArcBorro=
w`, the reference count must
> > +    ///   not hit zero.
> > +    /// * For the duration of the lifetime annotated on this `ArcBorro=
w`, there must not be a
> > +    ///   [`UniqueArc`] reference to this value.
>
> I am a bit confused, this feels to me like it should be guaranteed by
> `UniqueArc` and not by this function. Currently there is not even a way
> of getting a `*const T` from a `UniqueArc`.
> So I think we can remove this requirement and instead have the
> requirement for creating `UniqueArc` that not only the refcount is
> exactly 1, but also that no `ArcBorrow` exists.

If you combine this with `into_unique_or_drop` that is introduced in
the next patch of this series, then you could perform these
operations:

* Arc::into_raw
* ArcBorrow::from_raw
* Arc::from_raw
* Arc::into_unique_or_drop
* And then use the ArcBorrow

If we drop the final safety requirement from `ArcBorrow::from_raw`,
then the above would be allowed. The refcount does not hit zero at any
point during these operations. The only unsafe functions are
Arc::into_raw, Arc::from_raw, and ArcBorrow::from_raw, so this safety
requirement must go on one of them. It seems to me that, out of these,
ArcBorrow::from_raw is the most appropriate choice.

Thoughts?

Alice

