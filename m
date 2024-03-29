Return-Path: <linux-kernel+bounces-125353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B143689247B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC6A1F25BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5BC13A3E7;
	Fri, 29 Mar 2024 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwnQnyra"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA6320B;
	Fri, 29 Mar 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741724; cv=none; b=A4kJvNKa1M1dHk7VZTo0vZ8XCUVYhmhSuNETS91VVf7YbBZ25AActz9YACBIsXFzCRYrC1xRGsbJ81YtZlENclTXihmW9qSFqXpk1P11nrXGPy2skACMHTMn1Vg0MZs4RjD3VR7GauATRK1bKElYMAIl2p4VbQdIEu9lde57mzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741724; c=relaxed/simple;
	bh=SP0GlAdQvjK9+ItHq3VID9iHPh7Uhnl3AVCAfr0ACJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRYCdh5ZO7j+p5oL23P151yxlv76gkeMw/n6A9b9FLv3oDfyTlVUaBNkuD0bARTcGXBQnW4XVzHOkl8/3pjsxHR5OPx32ktEuZberRc91JPMPByn7BlMJceHho+cDIwC58sxxgtm175qOMpQZ7OdV/fSrv3hl0KenhLWy3zzSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwnQnyra; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1422404a12.1;
        Fri, 29 Mar 2024 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711741722; x=1712346522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP0GlAdQvjK9+ItHq3VID9iHPh7Uhnl3AVCAfr0ACJk=;
        b=AwnQnyraj/Lew0SxZnJZ50gE+KsoMRmIcneSh/cQns0u7Csyn6W02vxE8bdjvpfCGv
         3yyc8y54V7PYSw9Sj/A7lDC57rVGg+ljg6vIW6GY3xV7I+MzJdEhlv8V+uO0994vzT0H
         uOL0Vp6omG3Mmid4+VSgJlb+EYIM/cRIMx57AuxFY/i+pFuyhxFQj2W7DrsgnyjLa/4m
         w3aZm1ertwqSYNXLk7IsGaRxBu8B8dQOxu2fNSnUqS/cfsswJD1/W59hAtwCFkGRRcWY
         Y2frzGoTQH+ws6XEaCnHRiKI8yGZ8a19Z3qcEF+GzUos5cJEj3ha25Ufkxer/Le0sLOf
         dilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741722; x=1712346522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SP0GlAdQvjK9+ItHq3VID9iHPh7Uhnl3AVCAfr0ACJk=;
        b=vM+H4u6euFhShxPfPGy7vd91KpTFMQEnqwfIQoF7TP6t6eyyexTOsfSvl21qudj5uL
         HPX+55vXHhdiRZe7lywiomfL/h3rH/dfP25pc+avE7Z66CAfZNOkb6FRTz4uqFj6Fr2n
         T83w42YZtXRuN4J1Kxl4nVbSIoq6nSLWOHdmMzlrVuI7jo5Uc+Vo3Ty6VSCH9TTOS1W0
         UP6dv89JvLbd70/qsBVmYOR4SXKdv/ZcQ77yz3/O9OQVqP0tgayLdEVALxwPkrCudhj8
         V9gzv+1OsanqfF830maMjCmX92nYtxNDVUx8oAjKPmmhN19JHZdqi5/o412oK6F22XpW
         RlyA==
X-Forwarded-Encrypted: i=1; AJvYcCXMkeOSgkXYB3O4CEQCyUwFRLy18isJWEIELZG37j4P7dDOBR0wbq6pzqWRUcfSTpan4cloiEQovCvUoscbFLu8n/c5wb3s21Zy7XgOtG9MCAgFrI2o0x8eJoa0VcW+i3yyy1FDPkg3tfUi210=
X-Gm-Message-State: AOJu0YwkIsD+w0G67rBytxtdKtol5S4G3V1PX/+m4PI7rNcjma4Oj7X4
	WvALfwD9L22N4gTh7qU+sp0UdtU00mafnteLWBDpP8ijfY5MwOAgOUrjMTsdIKDqSDY6rgr0N4F
	vWD+HinVqrHGFq4CrTALRlHeIUbg=
X-Google-Smtp-Source: AGHT+IEkS6XIuTvbJ/3z+C8PWuNXB/i/m27t0Qys0QCqsGHGu77CWl4ZsbmPvqaOmybKv9tD0zNTn7vFI8fZ6x9KvCo=
X-Received: by 2002:a05:6a21:9102:b0:1a3:57b4:ed1c with SMTP id
 tn2-20020a056a21910200b001a357b4ed1cmr3435477pzb.25.1711741722169; Fri, 29
 Mar 2024 12:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217002717.57507-1-ojeda@kernel.org>
In-Reply-To: <20240217002717.57507-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 Mar 2024 20:48:08 +0100
Message-ID: <CANiq72mnbNxeO7EGR3trOrZLCTDeQWLP-UjKaq4ZrDpQRLxALQ@mail.gmail.com>
Subject: Re: [PATCH] rust: upgrade to Rust 1.77.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 1:27=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This is the next upgrade to the Rust toolchain, from 1.76.0 to 1.77.0
> (i.e. the latest) [1].

[ Upgraded to 1.77.1. Removed `allow(dead_code)` thanks to the
previous patch. Reworded accordingly. No changes to `alloc` during the
beta. ]

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

