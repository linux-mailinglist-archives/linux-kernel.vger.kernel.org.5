Return-Path: <linux-kernel+bounces-105569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6670887E08D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D2C282229
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEFE21A0B;
	Sun, 17 Mar 2024 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgiMKTV9"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A721353;
	Sun, 17 Mar 2024 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710712418; cv=none; b=bwsg3Mp1DOmjPkaAz99QUN4JCdCrlAhJe3IhLqQuzkL+7YJkzfjFHy+jim6t07r08GqSpBIPzAVLbkBrSsxt4KzcxJot3h2sx2H/ZV96Yp4QlatoTzSWBB9E7IfPL9GyFwnLDcPS7EIwG4dMoAkpmlI+3eSAjiXctMxJoS/salg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710712418; c=relaxed/simple;
	bh=9hghy2cayv8TUs+RB7XP/7Zs/PgLO8mmUWFiDbdfKaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8E9UkQP0krp18G+1qOwO7yl41GqLmECGYx0fmkX+pOplBN97yZD4FS4XXcngIxE7CwBix1EZFd8MvcJkJid2Grqiyf0phP/Zrz7zTtSnnWs8hCEQGy/kohhRzIQa5ZY7b3azRb0dFXgHq9TYOA5WIUvwUMT16LUyXdpfooKry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgiMKTV9; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c3747e7f8cso1932237b6e.0;
        Sun, 17 Mar 2024 14:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710712416; x=1711317216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hghy2cayv8TUs+RB7XP/7Zs/PgLO8mmUWFiDbdfKaA=;
        b=TgiMKTV97LPnMzM+CzRsz0dzhcwNSWhtheLhbJcTbTnDKs4a/Wpdx+W84vIkhOmxF0
         crijatoBRDChbb88v0Mwh81GrL3HU74XV1gvj6HlD9GCiEk36KjGF193Ir2egY5+Epd8
         zzL+02J8/2uMJ8fYCh0jIYw+a2cucryWsdjoKoozTRrTxGy9wXFEGDYkIOUg28GdS4jc
         /nyehh98D6AbbLe1+OfogP8GfClfPZzYjaWS9XFBk/nsMEvtrgly4Fv1LvswPLMyoTOc
         8GrCLdL73Qom38FU7YNBNKdldVkZXibrejMjsdwcG9v/FPWmbVlKjWB/2YjxyZrgriDh
         LMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710712416; x=1711317216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hghy2cayv8TUs+RB7XP/7Zs/PgLO8mmUWFiDbdfKaA=;
        b=Wi6Mw7YVbD2otRaCYf9nsnjVCbzuXl/xdjUccWnQShgWOPJvo+6w4oeYc+NrE5bQLj
         h1ipK/Z2E++Ktc7g4Nuzbanv05GVNwLZJEvrGZPiRvQpr5t4c6D0gaxqfUeZ5bXbhdP0
         wVNIXKlvaiGMuW80Lk5OqUcTB4hMHHVAP616It7iV69SghK6i4OuRDYHj1e35vjjGE8h
         jot5QqngSoCo7gesAyb+XFJxnWqlrz9IGZjseljRVPU1SJGR+SdEQteZOirisbPr8q+E
         KUqQGmN2zofSb2R0FIp9mh1cNGyXv/ZpAvtNLSe/Tf0+QxmdIm/QDolcyQPkkCAE1y96
         T5xg==
X-Forwarded-Encrypted: i=1; AJvYcCU8eaTiq9mYlpQ2hoLGjBHOhEmQkEh1asea14FZRCTLrXiaunbRjljmQuD3fUuqnQMuePlXErFs3q+1WIc2WGh76fUnGwseJi6B/n+MDXRl1KbxPWf2yiJ2fYI82OTQWqv8SJg8vV2N3L60Wh0=
X-Gm-Message-State: AOJu0Yx/GuD7ChokUCth8Ist9/f1sO8iQrU8wX72luBFsEOsys/q7hDP
	ZzhpPZ7OeP6C3grCZvr9Z4xEukccUF8mOBb1guT1SFslCws2Kr32tdH9/dahKxCtvmwNLluv5Hw
	VqtYx71HCuspetWWO9KArrdR40IY=
X-Google-Smtp-Source: AGHT+IEmOoDTy7JXdmINjJNl7nOK2XSxmSAaTxfxxxXAKNF8Oi2WQPcrleXEZJyYTctSYgETkjO8ZWPla+Rew2yJNqg=
X-Received: by 2002:a05:6358:9497:b0:17e:4fc7:d95 with SMTP id
 i23-20020a056358949700b0017e4fc70d95mr11914523rwb.17.1710712416202; Sun, 17
 Mar 2024 14:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223163726.12397-1-dakr@redhat.com> <6ba16a74-6fa4-4051-8cc6-f0e53a68d8b4@redhat.com>
 <Ze73aPMEg-BUCE8W@hs01.dakr.org> <CANiq72kK5CF0RQathACD_=7K1Ye4eMVdUnRcvkDZx4ALtq46wg@mail.gmail.com>
 <d0159c8c-f5d8-4731-a820-012702841bfc@redhat.com>
In-Reply-To: <d0159c8c-f5d8-4731-a820-012702841bfc@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 17 Mar 2024 22:53:17 +0100
Message-ID: <CANiq72=CQ1EZGuGU2vJ-JuGh3J7J=p_xtpUdn0q2eaLmAvh-Hg@mail.gmail.com>
Subject: Re: [PATCH v5] rust: str: add {make,to}_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:08=E2=80=AFAM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> Thanks for sharing, that sounds all good. Just wanted to know if the
> patch was queued up.

My pleasure -- I took the chance to add it to our Contributing page
(which is our `P:` field, i.e. Maintainer Entry Profile):
https://rust-for-linux.com/contributing

Cheers,
Miguel

