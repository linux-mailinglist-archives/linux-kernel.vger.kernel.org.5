Return-Path: <linux-kernel+bounces-127998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F598954B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024531F25E19
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647EE13175A;
	Tue,  2 Apr 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWkwVce6"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504901304B9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063274; cv=none; b=mNVrH4kt6tOG8j794eVYyU/tPqAvhbwa5ceRTqY2+n5ezUT5VYbasVTJd+C5m1K15LvMIPgSqhIilXAg0pc330S4oZGJ3KcHpV7opvkbsb6QXyCMuCd92IqomDtta6vhxIQT7tGJeD72kARbICGUEuSCGuNEs4lxCACmcYxaJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063274; c=relaxed/simple;
	bh=lyj9rQgplD+L52AIH4//Rop9h+61rr6z+GVA4WWRqDk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OLDxbhgD7xi9Ke/pDWvsr+uihTmHUmCg8+xrO30SVLH48GKrrgfcAaGeY56RNfgYt1jpkS/n3VFc8HTODQwfPraiiyB3mX2b8JFas6d3xR+Dc8chHFCE0cLvzgiedGcVR791iaFL2rx6McGWxFIeqCeLc11hZByviOCrlQnuSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWkwVce6; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-513e45ab9a8so4030228e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712063270; x=1712668070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Opxy4mF0J6kZG6tL42Jk92+MjrMyqgpiq33iCQEXdz8=;
        b=TWkwVce6JJlX4QCBhisuQJzI9cPnRlF7tEPTy2Z0thw/D+h/E4TsnJTubU+T5aSr3g
         qPZuTEGFSdvtXJveIae8cUGsxiYho1ngGlPuqFN57pjI2Rpa+YhEwM5FGAcyee0MXlo7
         Wah67Ce3wU7ibchgODBgxsp71vCVo+QMsrFdJRWCGLT7bHxx7y+KNh1bFIT/EdXoOsOo
         sAB+S3JxDh5LQ0GdZT7pxkhhQtQtl/pNcLm2GXXczmifUXMStt0prH5a+S4dj6HUlC78
         xXGTtl0KM/TR+hAeVH3Hdt7iVbrclkAwWhEhSr1d4GOzf1brVRq8jBl0Kp2WndkBtWaj
         7viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063270; x=1712668070;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Opxy4mF0J6kZG6tL42Jk92+MjrMyqgpiq33iCQEXdz8=;
        b=P5P79L86xOSsmJisBJ5rydn7cKLEYk8OvnB+VQwbup1DvAPHWdPow3v54kKlVX0Xre
         4+gFRQNuQguGT10LS/ngjYWrkAzijVGJSiqKbIdMVWeQy1/iSexFfRtq7ARZz6MixQjY
         dQJeYXX5N2bn2+3MoVC/dHZcge31GZIOA13zJwwldCGStoC89jUq+OsjEuZexeELtbFg
         wBDmSBCs7p6faTV9X5LdeHBZ2tGLTA/JHmitSa2kCH5xXTfYiKq/iD3O1Yv+g94lintj
         rYOy+Xt+atzdGn7YQn8PVm8xMWO9ZJj4tyjqaE14+hB3v69av3FLoj2fHHJjzF+LaKst
         5CtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/cVSi66xMAUMm6Vr3I1PMvY9NR/y6eprxQbnIoAdeX2GPURj/+T2yNVybd6u3RlYu+5N9AkFKqwBl8hZ4a4CfeGWBDPFvPdYJ+9y/
X-Gm-Message-State: AOJu0Yy/YCRa+1cCqXpVCAU7IAQFdsWZZuI/V9hgqhANWvP894KTWMhh
	eer2hPvGvhA24kUflYhkPTsZug2PNnt3Y28/klhu9sve4JxuRW8ws3l3Nq4Ztfyu/w44UapmmCu
	ZQ5JuQ/6b9a+4bA==
X-Google-Smtp-Source: AGHT+IGCfml/ws+Ix/yq7ne790NhdAwdZ6g6baAUadHXRTJOlSweA2VffEenHi2FnM8I9sQdwzfaYZ7jy7hmUDk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:ba6:b0:516:a8c2:af64 with SMTP
 id b38-20020a0565120ba600b00516a8c2af64mr6219lfv.0.1712063269960; Tue, 02 Apr
 2024 06:07:49 -0700 (PDT)
Date: Tue, 02 Apr 2024 13:07:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB0DDGYC/2XN0QrCIBTG8VcJrzP0aOa66j2iC3d0m7BmaEgx9
 u65EVTr8jv4+zuS5KJ3iRw3I4ku++TDUIbcbgh2Zmgd9bZsAgwkA1ZRE5E2IdLepzs1gBwUgrF
 7JIXcomv8Y8mdL2V35VGIz6We+Xx9h/gqlDll1FYabQV4UKw+tSG0vdthuJK5lOFLg15pKNq4S gDjElQt/7T4aMH5SouisTZca4EK3O/f0zS9AEe9yA4lAQAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=lyj9rQgplD+L52AIH4//Rop9h+61rr6z+GVA4WWRqDk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmDAMhcMJg4WIxZUn1iUD5xTR6V4w1nBvl5uTmC
 /L9DSYuInOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgwDIQAKCRAEWL7uWMY5
 RsL5D/9SsK0KWpa3czLrFPN2OpewDpKcMQi4frManaixbiNVCREJasPh+SibIBBMRBEDbUFNWT1
 h3idLFa/ULaNz80MigFrolvVYsP8p3zmT98aJQsNwxKYKniz81XI/MMGB8B0uE2dodIwAZMpDf9
 ENVH17+AW/54fFSTx+Ez1TmswQkkgp3IJCeHV6BD/REtGflE5+VEKYS7dtGkYABhTAQivFM9CNs
 fUEzusL+0+W67UWjQZrZMFwdoCxhberFwuC8P6gc4yl6d7CbIg5hw+C8J8Ez3LkvHQ8M3OYSVP9
 /npvjMlVRDI7hD9ECR0+IaO1+3GlCc7BSKf6kk9J6JYZ1HRQioSi7c6hlRMf2G5LsRJYwRYDhx2
 wU6hslDvM25nS7fZ4xXO3I++UBd+blIEjN6Ovht4KvINV6r57jDICn3BaD8AZYnLDCIdyaBc4MZ
 J9l8U38NEenk8jeSItsD47ETW16gK2+jgNtsprlyC7voBzie4T1ViGr3YAppZhPhjl2RHhsEGQR
 3avwdYyhn1pSRj62iS8odyK74RaFZnklLnSAWAe4s8X6CYXruBLsDvf55/g9jm2HRmI/iy4AbLw
 MY5tE6PKMDLFNbeHElEEgjP45JaZ231+uquXP4XpkUU6lz9jg2rKLlMjp0KtVysh2+Gocyqv4mJ vo6uRbC4OEnAkCw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-arc-for-list-v4-0-54db6440a9a9@google.com>
Subject: [PATCH v4 0/2] Arc methods for linked list
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This patchset contains two useful methods for the Arc type. They will be
used in my Rust linked list implementation [1], which Rust Binder uses. See
the Rust Binder RFC [2] for more information.

Link: https://lore.kernel.org/rust-for-linux/20240402-linked-list-v1-0-b1c59ba7ae3b@google.com/ [1]
Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Add Boqun's example.
- Fix rustfmt issue.
- Add Reviewed-by tags.
- Link to v3: https://lore.kernel.org/r/20240311-arc-for-list-v3-0-cba1883c62eb@google.com

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

 rust/kernel/sync/arc.rs | 138 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 120 insertions(+), 18 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240209-arc-for-list-a2c126c2ad5c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


