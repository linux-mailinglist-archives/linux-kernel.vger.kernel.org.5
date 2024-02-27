Return-Path: <linux-kernel+bounces-83431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718086990E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72931F2335C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36B413B797;
	Tue, 27 Feb 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y2k7kKs4"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9313A89E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045482; cv=none; b=hR9GN+VoZUnBmbOy5gpx11ApNIX7BVU6iduiWcJUH0WWrUrNkyBNC+Y9q20UACGglrVkVg36yeEsJurW8DfFaBMpT6Uis1LfvWuQekkgapGuNLn/RyRYtWj1yMf3zNGGRdKLbWZffz0eG2NmWBz7Wjclik7z+Yp8rzPGLeoytJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045482; c=relaxed/simple;
	bh=i5VYPShLQ7DBuALAeVASEPVNFC0Vv1VA6Jm1u/KqDTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3babUsCnlnTavq/PLNxRhHuzpEiqtLWFAouH51IzMYvK0VrzAdov+JqR5yiwkv7dhJCsKf1WHSenPU8pIs/LqbkJ94PhbZtzQ678TW7wm4H6alMw8g8BGD9O+DwLDuFdkY4HyGtWH8rjCeMJ+31vQLUc+pr2tk2/3SbckCf8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y2k7kKs4; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4706feb17ccso524562137.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709045480; x=1709650280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5VYPShLQ7DBuALAeVASEPVNFC0Vv1VA6Jm1u/KqDTQ=;
        b=y2k7kKs4CAC1bWyDOTpQJWRaqLpKenKzG3ksauTO5G8NZTPyJo8mW1smdwJpVAlrVt
         lA6bwVYGcT3eafKR5ZMVepClWHy4BhaxD0fxEg2BZ9vQ+ll60T8XcbOAJviAag4htDCl
         p38U9j/dat60pTt86znjokUZZQU8A39yY/adXdB6gQkcrytMDPTEy9sme35gjCcUz2kE
         lWoPcotXDZjnjIcPR0/yzYy7FF5KOCqR8xIIfDFwk6Wg/f7eMHq7D4gHiXGEdQQ1vXrr
         go3EUIfuex3JnzsMtHqlfiLJCmWHR9P750wMwAZ2K0ZqDY0HBx4WePwLvKtatYjolmbL
         ty4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709045480; x=1709650280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5VYPShLQ7DBuALAeVASEPVNFC0Vv1VA6Jm1u/KqDTQ=;
        b=UyCv1/aTsyvY8+/lG48qMy/LK9W99dVA1+UYvnSXL00SNWa2xRZkgfyYXgnnX+7+Hw
         lGDHrx5Y9STh0Qkh8owrfC3d6EQQ3awnSR+5uyTvrnR7s4X9lOu+sIc3rS/EqxNB65Yc
         2OnkQJornf0JAY4lWzfZ9myZuQY0R2gCGGsCfYgB/5N39e2ixK25ZWr3GQ9Nxns87QLb
         oBjcUMcIql2rEpPiHmL7WrEfOUv0D0sR/ZqLHfo/qcueKqv6HiHiAd04Ol35Qj9V5nXT
         weolumpXehdac2bWRLQ6rCL9GNz2VGwXcc59z2214necMAxxduVqdD9Tyc7nuPDyT6BA
         jUvw==
X-Forwarded-Encrypted: i=1; AJvYcCUA7/xe5YSQ33Zd1VjGsCmvdXWsLbhBV9xPJUsXGRHi+7rRLSOQ5bt4yXSw7PNj8aWPG6afnawkdWKw1eEWMwH03S7ZSgtAirGD8RCW
X-Gm-Message-State: AOJu0YzBnapJZTvtuR0P9xMiBeoWL8mq34hfVLn7VyJGKFj/zIkMba3L
	IsCt2uSRbrvrteK5LF3ETHfCXKN4KI7Yei2zx41lIWpQxSKsT7NQq+/1A61TQ+geqldQg5EUmu2
	Yhbbwrj+Z7N7Y6gTfnatJ/P0vrjESktBVJ7/v
X-Google-Smtp-Source: AGHT+IFvGbDtFFtQoiJDa82ZB6Ep2q+oir3b0d7n9XuaQnvAWBrEWqFnAV3+O1JKEJsWZzQFG6T93La1ffVlTZUbJNs=
X-Received: by 2002:a05:6102:55a4:b0:470:3ade:af52 with SMTP id
 dc36-20020a05610255a400b004703adeaf52mr8740310vsb.6.1709045479638; Tue, 27
 Feb 2024 06:51:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226-rust-locks-get-mut-v4-1-24abf57707a8@gmail.com>
In-Reply-To: <20240226-rust-locks-get-mut-v4-1-24abf57707a8@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 27 Feb 2024 15:51:08 +0100
Message-ID: <CAH5fLggS6H+y6dBUkyecUyKHU5e_ueEmGEXh=DA00doqiVDEvA@mail.gmail.com>
Subject: Re: [PATCH v4] rust: locks: Add `get_mut` method to `Lock`
To: mathys35.gasnier@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 2:55=E2=80=AFPM Mathys-Gasnier via B4 Relay
<devnull+mathys35.gasnier.gmail.com@kernel.org> wrote:
>
> From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
>
> Having a mutable reference guarantees that no other threads have
> access to the lock, so we can take advantage of that to grant callers
> access to the protected data without the the cost of acquiring and
> releasing the locks. Since the lifetime of the data is tied to the
> mutable reference, the borrow checker guarantees that the usage is safe.
>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

