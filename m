Return-Path: <linux-kernel+bounces-153088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B08AC8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF962819B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB555C3B;
	Mon, 22 Apr 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twZsfRK3"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3AC5490A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777958; cv=none; b=SNNHjp45lAV3vlRsNJymp4YRE62z9z3kiflBf0VMOXv5yUwYGxtrzPxEguPo89aECN8i3dytrAO2mh1zqZt/xOx+DAfrvVeaGsBYR7QNJVoECfSP+uYyJ57Beyigaj6sEvSOrBDOfl1zrcbJ0Cuj9UfuFYZaXbA5uKnoFo5Ilag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777958; c=relaxed/simple;
	bh=ye+YDeypngJNVRNApH4ApNOV3asObjEsmLgFOfVV0AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tp2a5whQswCJ7cwj4bkK6MecgY5LAJOw6mjdcVQyrWMO5Gqqk8F8ezLH8NjyPurExr17voeLSKaPdQFj3RT1itI1w2sg0sjCKevjrHIhFC8bjwtJdo1rfaqeYdiuPAU5mVBXEy1W7eOyuIRNFridVPS6x/K0hwIh4fHFFyDUKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twZsfRK3; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7e7cf5cc1d0so3391207241.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713777956; x=1714382756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u02hciJF/25Uzt60NJ0xbu51k6rfBNzWcPBLcSlUo80=;
        b=twZsfRK3ziG0zUb1bCJXi8C9F56uvM1GjgJNPIFDkI+Z/QqUDW+ujcsdzCaqKqm6YL
         0mwFX8clbtzZmG6070BsZODiLVFyOvnD9XXXEFVhSNgbJa0vXnevR4Kz9VVs0QcAzSBB
         MTJdLjhLWgnrhN6kicMs/vxU2u9W+ompDL1GQFXLDh3IWDKiAlmn4fQzxPjv8J2WyOcR
         f1j3Q9UnrLDBTFGS/5EHfOQZiO8BfXIwB07OIpsnXNfGtRJrjuUzSR8rnLymI7Hq8I9C
         ibyqWof0mrDVQXnYgcspRBgnNYcU+HCmfE0doCBJq3F1rejFI/Mu28ItdnoSk0oF0N0T
         0hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777956; x=1714382756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u02hciJF/25Uzt60NJ0xbu51k6rfBNzWcPBLcSlUo80=;
        b=KOLwmmAwvVtpCsebWzIToPi+pzC1bs7eRnTDcyrJjUNGGlAREAoMA8t1OiffD9XN8C
         vixWtdkMCYKg0IX+0DECcsbuY6/w4jruNQSzXb2sFiQCtG+nji9g/44LRh0pVB+BOZui
         6qdawtxvrsFL6KV0KDEpV2QboU8sGxmEwKUQ/5b61d+HwvkEDpoz76F/mWz+yfw63lMY
         MBmkZ/c6Bg/FUVQd/ChMu5nwNwZvJnVFPuolzhzv7ffpKva5wNs2aucHgqabuejIjfQ/
         mR5uIl+IvcnOacz0UYoxva+JRN45uXnZ5rNf6IvhEdXuzUrllsUdm4xxQji1BVxrekKX
         QufA==
X-Forwarded-Encrypted: i=1; AJvYcCVpNxfBTqdRF9gsqHukhbzyMVoxOYuq8Kj6RnmblCvflAnV3KVEE1xZYVQR0lDAEYZm+jSvuzwA2PedGkBCC4kcdgNvXD508X2HPtyU
X-Gm-Message-State: AOJu0Yy2HlnRO3QVn2OhHpnVt2GvzBYp3lVBl7g6Cee+zVQfNVoQQQUe
	Ku+EayLxulXeKe9orAdcHD7Wk7l8GRreaC8tAO5GHT/9hbxNPqm69brpJwGxP2mcRZfPgtD994g
	LKSuJYCt7gQ/GL4eFayvEemkEdq8W4lNR4j8A
X-Google-Smtp-Source: AGHT+IFzbvs5nDCKVidubFmVhCqyTJZpX1MSVwcFBpjxWlOvQIwOZ8sgogJwUEo36R0OhEd8C3NQ+lrl6rjs+COe24c=
X-Received: by 2002:a05:6122:2008:b0:4d4:34b2:9a89 with SMTP id
 l8-20020a056122200800b004d434b29a89mr13136946vkd.8.1713777956098; Mon, 22 Apr
 2024 02:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091215.526688-1-ojeda@kernel.org>
In-Reply-To: <20240422091215.526688-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Apr 2024 11:25:45 +0200
Message-ID: <CAH5fLgg=v28bFJE1izZ-WF7uBLcr7D2o6Yr2ihdPAz205MiGGw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: remove unneeded `@rustc_cfg` to avoid ICE
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:13=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> When KUnit tests are enabled, under very big kernel configurations
> (e.g. `allyesconfig`), we can trigger a `rustdoc` ICE [1]:
>
>       RUSTDOC TK rust/kernel/lib.rs
>     error: the compiler unexpectedly panicked. this is a bug.
>
> The reason is that this build step has a duplicated `@rustc_cfg` argument=
,
> which contains the kernel configuration, and thus a lot of arguments. The
> factor 2 happens to be enough to reach the ICE.
>
> Thus remove the unneeded `@rustc_cfg`. By doing so, we clean up the
> command and workaround the ICE.
>
> The ICE has been fixed in the upcoming Rust 1.79 [2].
>
> Cc: stable@vger.kernel.org
> Fixes: a66d733da801 ("rust: support running Rust documentation tests as K=
Unit ones")
> Link: https://github.com/rust-lang/rust/issues/122722 [1]
> Link: https://github.com/rust-lang/rust/pull/122840 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

