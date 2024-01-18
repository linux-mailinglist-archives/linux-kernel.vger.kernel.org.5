Return-Path: <linux-kernel+bounces-29595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AE831094
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455C81F22C90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D65390;
	Thu, 18 Jan 2024 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="QyxP+96F"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FC4688
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538354; cv=none; b=GrPgenk6sebuHfQ1AEK8dGJnk8IcmplDmpuu+VKEnmmte+q9fK4FukGBlDG9OU2/eO1tQAuNcL3pVhep9s5CVS/Yd0NYuklT1s8oD5wVw+Rgsj5lOq4LrJqO0w06SJ9kPtzbXXXqxdf4huXeBuNmPq0wVlfGQcHpOWn7JOkBD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538354; c=relaxed/simple;
	bh=5fXV9S1qwrCatcOcOXlqtb1FDKpbGPqat6Ll3hI4ZLw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ijmKQDlQ1Kv2n5UzmsyZUxC9xzPfor4Dkvv3MmoUtUW8kyMnKn8L2BG8K5eRlTBlqwst0fr7Kwdk5JQNTxslXwTATtoYBiNnciVwbf2IrFWSAzfeeyHWSIWNyP7aEQN9XfUsX+fwGQ+RfkaVLgzhKoK59pBsLsm0+T6O6BqMq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=QyxP+96F; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc226dca91aso2330364276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705538352; x=1706143152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itoC00wDDFSYZ+IvU/UOh2nE1+jPP3Ry+100SfdsSDE=;
        b=QyxP+96F//A7C4z89yIL3JfDiTa6cyj7ugiHrpJNUy8IckfoROMHpEWxfN6UAejejw
         bdVMyb3f7wpfVjvoubU9iRbbckbjUfAZ3Sg439wZ5tZKGHwdeL0Uqm/H1mdIskMMW4iS
         5lKEQWJZpE3rVMFyvFH2VeSM/lzGbOGiEcNmz2Bw8n7p0gIbYNltmb/qEiZLCoqIZmAx
         c340tSHt/cK2/aCwLgubuVZSllrpN4jyCCVm0YTWl+PBQVWNfebh7BFPboSUlMkJJOZJ
         GcdYIByL4TNDVB6ryVmzfGCPXK8ObIpaPMUCwHNthZiOI/NfzGRezOTogJexJ/A/Apym
         ebLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538352; x=1706143152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itoC00wDDFSYZ+IvU/UOh2nE1+jPP3Ry+100SfdsSDE=;
        b=obfBvjjmKvRki7fmHwUALGeQjEOUSvjI2GVVO8BBY6yBCOJgiIv4GwEbNINCKpPwX2
         zIGLnyHDGnuP4V0ZJNSxWNehRFnfJwvzcu9mq2ei2WhCgyLh+jq9PYd5NpSryXO3FRdB
         xCxIVeWl4NVfq4o/BxYU8h2pGeZQsaHwg31mUD7t9Dr8KCgVumvOgwAnP9KkVjeFh2fg
         oR3cIz3MoLQwil1pDLNXKvoIyyrY081uyov9VOYK7VWu3VfNornz7Ay1/L9Xe/tQVjsj
         AefeUE1Pjk1cvQsjG03uoVYP+qsV3s9DdbtnGvWNqegEAIbzY7x8PKTEpQSZcbGwNLa4
         cWdg==
X-Gm-Message-State: AOJu0YxpRy6yTSu9Ku9+gjVhLAJGV58i45fkUmNHipMPzQuPDYopjRPj
	QH2SdYRTCZ2ko22xo4JvYwVtBY56U5dDfUS4gzX/oT3oAHcFu6LZyb3aRKWecypQm9FQyT+L7wV
	scAdQ1VXTAu4JDqdBTBY44Y25u9R3JGrqdYdkTQ==
X-Google-Smtp-Source: AGHT+IGe/Pdfl5chOnwpbeCDqa36Ba4aMYe964LFknfE0Ogax3r9al3t19//MxguiJ1gEQCjcpdvRYjgKV/D/y3YIC8=
X-Received: by 2002:a25:aaf2:0:b0:dc2:3e59:4e32 with SMTP id
 t105-20020a25aaf2000000b00dc23e594e32mr30935ybi.38.1705538351977; Wed, 17 Jan
 2024 16:39:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116220537.168057-1-kernel@valentinobst.de>
In-Reply-To: <20240116220537.168057-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 19:39:00 -0500
Message-ID: <CALNs47vyZWExuCy3t9MM5Yxbw19XQB8iem5Ga6O8usGPuZumNg@mail.gmail.com>
Subject: Re: [PATCH 05/13] rust: str: use `NUL` instead of 0 in doc comments
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 5:36=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> Throughout the module, bytes with the value zero are referred to as
> `NUL` bytes. Adapt the only two outliers.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/str.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 0a8569594fc3..843ffeec9b3e 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -149,13 +149,13 @@ pub const fn as_char_ptr(&self) -> *const core::ffi=
::c_char {
>          self.0.as_ptr() as _
>      }
>
> -    /// Convert the string to a byte slice without the trailing 0 byte.
> +    /// Convert the string to a byte slice without the trailing `NUL` by=
te.
>      #[inline]
>      pub fn as_bytes(&self) -> &[u8] {
>          &self.0[..self.len()]
>      }
>
> -    /// Convert the string to a byte slice containing the trailing 0 byt=
e.
> +    /// Convert the string to a byte slice containing the trailing `NUL`=
 byte.
>      #[inline]
>      pub const fn as_bytes_with_nul(&self) -> &[u8] {
>          &self.0
> --
> 2.43.0
>
>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

