Return-Path: <linux-kernel+bounces-127669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57788894F37
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F7E281D76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFB55914D;
	Tue,  2 Apr 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsvBWpxz"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCEA59148
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051747; cv=none; b=X5EsJAfGe+bEoUobgutTS/iLEk1WvLeFCcXa7QurmwkU6wlXhAa66R7KvJlYl9k7/bQVHCfYPQbF/CF7krBQBc6KTWFzitCAHjxEV56JpcLVZAePK2q8ZIlGBTV+CJxK0Im6sP1CXjyAIDmtKojIexskwDCZ5YQY3q3Wu/dlw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051747; c=relaxed/simple;
	bh=a+YljDVrbcAwyR/tcUOKBAwbhaSbQeo8lJMXH+opy20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+0EcCJDeMzjjQGOryQsEcXWKLZKXuxzesHfahkBoxnRypzBBznDZPQMQi63qxE2ukZjXfB/5fZWVMXVcu2fvT+CuLOAnTP6ibq7wu3DlVhF5pyt8Bh6gyJcB8+GGs08iPv72zH0TY9dr0Q084uPzkjk8MbP5myHgBmQSWE76KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsvBWpxz; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4788b354e67so261222137.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712051744; x=1712656544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+YljDVrbcAwyR/tcUOKBAwbhaSbQeo8lJMXH+opy20=;
        b=KsvBWpxzvxZIGoUiZxoyoVLoBnnOQr5jJFGAmVj6Bcex884PDy5mjSF17mTEouKYav
         YL8DKHYIb1th5ZQ15mYwGhM0GdCx1U8+dc8SjF5ao7dkQUfmENfVzzEkPSdMpSTS1RVS
         yhHVhvePqYceW4HzwvFWhAFk2tJUbyr/wDLgJQuzTrrz5kicjj/bl/icy4SxmOsPN+Un
         /J+JdCRrjw1HeEGRKtjjiAMfgYQ79JVj53+/GkX6Aonx54orFhtm3Z/z7icotcunvbnH
         vpg8IY1kSrXtrC+ecIrcYqXkXOcgDuX27ppYT07j0VSq5vnRvCv4oYodj1EkK+r/fIsn
         sEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051744; x=1712656544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+YljDVrbcAwyR/tcUOKBAwbhaSbQeo8lJMXH+opy20=;
        b=dnfmcld2AMu7LTR+SJ9BLtvwRePYJPkfeBtjC7dQmAIOImybV9AsrNZqt2nM6vFxlW
         PWdC8gNu5y0DLYNMpqMxJMWe8qlOE/d0ZYP0/xqK5AsZWL277feTxztXwoIcR0p4h4O9
         fXrNpGwAdhwiFCKupeMn7t/xiP9+5vqaONyh0arcc/ZHhSS6uzno3crffpoGzz+vf58e
         gIusnU+2l4mtGun8JhiGPDnwKMgTOfWKkbkzWFqdu6mSBzZW1zOLrcCdO7wOUp8skwIO
         jjF0ePM3SBXtEcqyKdSf5MmbJ46WSqKLahnKOhDkelaJ/UE6ziR/OGls6eXojbGPtpTd
         R+6w==
X-Forwarded-Encrypted: i=1; AJvYcCVSNmm87IAScfjUPPud+1CNzVQRA6yUc8jCFnwtGCa1jirrYf3bdM+gxLipyViKAvWB8v9cwKSRHwtqXNeuLd69liT8EK87j/7GIXWR
X-Gm-Message-State: AOJu0YwwN5mz+yztqBUsfyTQSL3QxuyPNbbih2+0Zun7BaQghWFbyD0Z
	bIU8/PfiBj0UW73GSk/dvTwxkpVYr0LhQpp7b6kV7oy02cpKckZRqcsJtifKBH0czwUW5Co4fld
	pvq8k5J662sGRe+Y6EuFmigbSpx1aEf9hWNna
X-Google-Smtp-Source: AGHT+IGv3VAH51GyjjtjsnXbb/DrFswdNA8szNO89cktWs1ewiqSuc3VC/AWKEjqHLDt3jRpmLOWygntlWniMVRckAo=
X-Received: by 2002:a05:6102:378:b0:475:fe59:f33 with SMTP id
 f24-20020a056102037800b00475fe590f33mr6501047vsa.29.1712051744314; Tue, 02
 Apr 2024 02:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217002602.57270-1-ojeda@kernel.org>
In-Reply-To: <20240217002602.57270-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 2 Apr 2024 11:55:33 +0200
Message-ID: <CAH5fLggb8jr2yaQwcQFmrP935_h+SRPT=xH+tRQe7dngiLB2fA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: use `-Zdwarf-version` to support DWARFv5
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 1:26=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust 1.64.0 introduced (unstable) support for the `-Zdwarf-version`
> flag, which allows to select DWARFv5, thus use it.
>
> Link: https://github.com/rust-lang/rust/issues/103057
> Link: https://github.com/rust-lang/rust/pull/98350
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

