Return-Path: <linux-kernel+bounces-99186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D85B58784A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7751F21F33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF22C68A;
	Mon, 11 Mar 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHtBFKnY"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83CB4503F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173311; cv=none; b=goPU07k2oheUS78KPKeeaLFva0gVSSH9P83qg4cXO9nUxciOpSvZmUVWyYaWNID4Res/KXlpd8R4OCmJieSTnSR9bATdRi/li01BC3RC7vnsp0SP7GP97WXzQqFX+1/9rxcT6t8cN6o5lcN2SVAz/mqWNu7dwOuemMmeQIXTuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173311; c=relaxed/simple;
	bh=ySoK6anYnEQuPQKErWeKswdt3wR5S4/LScNFn5Jtcz0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RXOOVg2+Wmk0LKCIvt8YZhJFls/Rh9XV0V2pQ3QMbDyKdQWTc7aZHo5fw5K6np9eV6RFlWUbuBpMwPuivYWiDHNol76YImSJdzm+UrYe41aPn7Krga1SiYAmgI24+l9pjlaUGpn1M5828ijRhnLHdja7+UABMCzt3OqQQ3qJ04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHtBFKnY; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-513b2e92c19so579024e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710173308; x=1710778108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=48CSeGdrVrcCZ1Y0plEuj0UXE3BzD77hafsgSY9QDC8=;
        b=wHtBFKnYDCVKyFWH+ImUbByNqlmtcrvDxFj+/K186avbh7xyjcac3GX28DpOWpNyth
         k+ZLiGWskC1JDP6Mr3A8ZCjeMXs2Lb8bbhs5LlALcA8Li0dxsoQA2ZDWMGEsPgTA/vaq
         tRmSePNYDB6w8UVviG8kXlaZBfVmHwnGoc7Su2SYibo1bwt4El3nM9O4qFrvHaPLZYmh
         u2T6umbDwUQJ9RiNQ7GmTXCFkfDlIzVelQ4pg8yst0jz9MIThSXGFfj9HBB7DzmSJcbA
         OTpn6OEZKIchZ00nBV0/PO5RPeR1CvnUTCGJ81Q8LkBnhm7MvrgUthm+qkGy0YcR/8qC
         B7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173308; x=1710778108;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48CSeGdrVrcCZ1Y0plEuj0UXE3BzD77hafsgSY9QDC8=;
        b=EdRUL/FTxJVDSVmhwK0eevwXtlwo4pCEWnpL/cZqvmvOqhg6tPIpm/0cYeoYzTdWgM
         ilKgBZpFeLEPplBGOm2QAkHFP2+x6O/+dezlL4L3riLGdF+NxN8D2z3dTyc+Y3lK1TjR
         56qetM1nJRJOuV7s0L4E+LFJEijlauOvsAHOTwNRpqRKmgfxJmDK6YFygN0XlRI1WQLz
         RlAQibtSN53eDfWQDE773+eEreLCiGS8ROpYTWX6WdV3wAre0BhtvIqFsv4IuGJGR1ij
         jLIAgH5QSD/nKCPz3q3iqwfxymnyXTNuIIaHnaRfM61IZB3RhY7Bv+PiYGwAGwwAHeX7
         zp0g==
X-Forwarded-Encrypted: i=1; AJvYcCUtTr2MWrGY3coTqgA+K5Sb0b4E2y/3iuqeLZRZbFysG4uVqMjou312iHxq/L4bQCbepvZlrMiBMLkl7QA3sUrm8rFVMgA3v+IIYpNJ
X-Gm-Message-State: AOJu0YyAGxqARDc9uHL2sKoDynqibmt2CE7WU9c86Pogb5JXoXrt+uVJ
	WwN5GQ1sOZMHX1C9O6tX4SBZ/WGXDkJKaGHKSeQIGkiGzq9Frjis1obFvGWi22sZtwWBso+Arn9
	/bg2bUqVAM0xT4g==
X-Google-Smtp-Source: AGHT+IH1ywloar1x2gwt4iiuSGCtyHQl1990db2h+pOSrqLRYARq10doFZh21+l9sdlyhYNPlpJ4jjL57OsMw84=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:252c:b0:513:b11d:63ae with SMTP
 id be44-20020a056512252c00b00513b11d63aemr1620lfb.11.1710173307466; Mon, 11
 Mar 2024 09:08:27 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:08:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHEs72UC/12MQQ6CMBBFr2Jm7Zh2QKSuvIdxUaYFmiA1rWk0h
 LtbiAtl+X7+exNEG5yNcN5NEGxy0fkxQ7HfAfd67Cw6kxlIUClIKNSBsfUBBxefqIklVUzaHBm
 y8gi2da81d71l7vPJh/daT3JZvyG5CSWJAo2q2SjiUyWaS+d9N9gD+zsspUQ/NtUbm7KtrSpIy JKqpvyz53n+AI07nQnnAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ySoK6anYnEQuPQKErWeKswdt3wR5S4/LScNFn5Jtcz0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl7yxzx5kfn5OqzhFAWXgk3np/4f3p0ll3GO6vk
 uRnyNnCB9uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZe8scwAKCRAEWL7uWMY5
 RtmHD/9ROGcjuXT5ha91PLGOMBdUn0Fs72Uv2D6C2mkyNgtHSy+fBcyTCJjIq85a9guizqtdnug
 EjYhaBvTEEOlf0wdTmpbiNSeh1ChbzaFpkHBlHlA7qmjIzSywPhZzN+hik5uW0oscUZ3dgOJQJs
 e0WWob1mySauWXYzAxdCV9j4WVue3imfYdLWluiyVa+E6FsUYz+uvtQJp5ZfHUwLzzP9vOeqScC
 7OshcBSmJqlH2zAhjyi/Oag/erEBT+fuHdf17DSdHSoKsJ3jo6Rv1KB10u84c4plwfdMOPrroPu
 guRADnHFRPAK7KqoT3Wodb36fRPFjt9VvopjNexDsg1tFdeyO1NKltU7QBW/9vnLEULYmgvczFj
 miVWcSQdyhC0kZ6Y/ky8tfy7BvqVsUJ/P6eUyB9uqHTX8eNJB9IIGeqXm3eqQH1F1EMFbJI4jn/
 uCeca9zrtIZ0xXsJHDDDIWRG5VzmTzarZmpRsXKs3RGq6DkT+dts5rze/awj+dJ7u4nC3kJjQME
 U/iIxjHeCNTKGRjTeXnNuWlCPM6ZmGWFzutF+nIci/KwB0eosk1aINXexGb/Ilhfqu9RX0Ug3HM
 uwssxz3K0DiJBQqPTJdG5garuzuwhVUp86bWQ2SZrtNQ1xncOxT1CzTxF4fC1zzXUwM1Fk5aesP ocMjDlG5ZSR2qvg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240311-arc-for-list-v3-0-cba1883c62eb@google.com>
Subject: [PATCH v3 0/2] Arc methods for linked list
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This patchset contains two useful methods for the Arc type. They will be
used in my Rust linked list implementation, which Rust Binder uses. See
the Rust Binder RFC [1] for more information. Both these commits and
the linked list that uses them are present in the branch referenced by
the RFC.

I will send the linked list to the mailing list soon.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v3:
- No changes to `ArcBorrow::from_raw`, or than adding a Reviewed-by.
- Update SAFETY comment on `refcount_dec_and_test` call.
- Simplify the creation of the `UniqueArc` in `into_unique_or_drop`.
- Link to v2: https://lore.kernel.org/r/20240228-arc-for-list-v2-0-ae93201426b4@google.com

Changes in v2:
- Move raw_to_inner_ptr to ArcInner and rename to container_of.
- Reword safety conditions for raw_to_inner_ptr to match its users.
- Link to v1: https://lore.kernel.org/r/20240219-arc-for-list-v1-0-d98cd92c760b@google.com

---
Alice Ryhl (2):
      rust: sync: add `ArcBorrow::from_raw`
      rust: sync: add `Arc::into_unique_or_drop`

 rust/kernel/sync/arc.rs | 106 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 18 deletions(-)
---
base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
change-id: 20240209-arc-for-list-a2c126c2ad5c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


