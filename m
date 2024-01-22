Return-Path: <linux-kernel+bounces-34035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDBF83722D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D43C1F321DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97887495D6;
	Mon, 22 Jan 2024 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2Dvifm+"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F0495CA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949885; cv=none; b=XnRdAYDNS2r8p3f1RkGRznMVAvJ4/001HeYKSkYj7WVhivOVKgZyUdJ8dwxVAoO3E0FtMmZaE582oJiConUZvwZoCqFva3vvq6l1jwNuhGtE2z+g+6giT0xbSzo05xhilcbPaBncf+hbM4i8GgHMnQl8goIkNTXGxkLLhMYzcOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949885; c=relaxed/simple;
	bh=VWOf8TrU3RfJgWEayn+bJz3W2oVeMtgyadg74e0TLO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoLOs1Uml3R7mKdieLN87ym+eSOY/UDmcKyJDVVQNguNVo+0ITgvyOQFGl+YEnRnLW4XGpKDIGHb0KmbctPYqYolyWBfmJbi+AJQPnaDt4n0qacxIdzqsx4NzIi3+tgFDHssHSJ1fl7L46ZZBH/XI5ZpdvSFeJgDT6aGhhimYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2Dvifm+; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d2e007751eso1056857241.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705949883; x=1706554683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWOf8TrU3RfJgWEayn+bJz3W2oVeMtgyadg74e0TLO8=;
        b=W2Dvifm+4/mh8atPmMbzY06l4rlAGkxKS+K46U8rUpotqjLrvweTfgv4qMtlxOA1vp
         p389uyFrAny1REMidvluyijHYFYYiGX0iaxWseaop9RUwCbujIrcADwX1aS+khrcDj9m
         uQgiXWeeGnCiAAeeqo8Bsy6YI/cRmQxqNjWF3vUICcdyA06G39w9TgVyiXTaGLy4x5op
         566MwrO9vyXgem/2N2KmiwsJpvpVi386mSUt+kVs8riFGuddf1qtPZddXLJJ6kTqcxMM
         /JbGG+B6n2maWCbQP/bmaXI5eiAnG6f7cA6J9SBv4bZWA2GVyflitaCWbN9kizUWz5gy
         Rqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949883; x=1706554683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWOf8TrU3RfJgWEayn+bJz3W2oVeMtgyadg74e0TLO8=;
        b=Di4f9lqKvXLK3xbP0E/vmBf4eSsG4L2RwwX+VC7zdZfsqfG9yFHzRrlZzQRJ3+EMhd
         RHtI5WKSuOUCmqw7y4KssCVHSfWOay0rA2eEcqFmxNOCuoTHphUWFxUtJcFBJxgzZB1I
         eJf9ug7D7D8lu+G79c5M1NIyGNfPkNcxtpaSJIiMCOgJ8XkXByBs7AKe98RlAqSYNW6L
         OGCbz0wgK9d2zDIOr4QwRbX7/m2/odnXOK0gQRV8F5vbleZYIgd6cvXeb0XlwlYT8oS7
         +xrL9rEAFed9x1z9r7hoOBP3FwRU0QMKlYsa/et4shhvGm23L41JYO0bFcEanBJk0Pf8
         os4Q==
X-Gm-Message-State: AOJu0YypyG3E6+boErClAg8EN8hSZp06PCQb0tfFBPJvLUy5AQj5urQc
	Kkc9YW1KFkTDLTA7BUOuvp2ATW6+nwJ7QW9X2zx/JOuH74cNYp8856dq/U1gxzt9bm9ksGyWLDi
	lm3LWnAyGKkBf6hP4K4RRM2QI2QpllMpxBEoZ
X-Google-Smtp-Source: AGHT+IFxOVGRaBVF6braH2NOqEnij3IhJvpLMlsmKgtebpat1xtlABWJoGhlUaqjDI7jeA6UJ2L7nOY5Wt1qvz6c1nc=
X-Received: by 2002:a05:6102:3a13:b0:469:93d3:9fed with SMTP id
 b19-20020a0561023a1300b0046993d39fedmr3292716vsu.15.1705949883381; Mon, 22
 Jan 2024 10:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122184608.11863-1-dakr@redhat.com>
In-Reply-To: <20240122184608.11863-1-dakr@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Jan 2024 19:57:52 +0100
Message-ID: <CAH5fLgjG5fJJQTsZF+ztT7E_mHAoct7p8BcERp2nkik1+LH+LQ@mail.gmail.com>
Subject: Re: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:46=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> Add functions to convert a CString to upper- / lowercase assuming all
> characters are ASCII encoded.
>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

What is this for?

Alice

