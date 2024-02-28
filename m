Return-Path: <linux-kernel+bounces-85049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8588D86AFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14524B2123B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870F149E1E;
	Wed, 28 Feb 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBcpXY0u"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7773508
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125247; cv=none; b=SsE9+W8ohtG3wiWC1lwwX9OxFWyU58g6NL24OZ+Ooyc6hHV7T5dwfr5Z+lyuCrU1sRQ6Q0EosRyKkuSaurivuDG4CWZYKO5BpA2xlyOXlK7CQ8ldEjbC2F3+Sm7X9D3HYjw4ZEcRK+ajm7Mo+YZ85EDxGqP5BOBjnmi1hTY5MdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125247; c=relaxed/simple;
	bh=5eKyUMXaVKoGDR1LS8Xh6qVotw5zgKEUJmt6pSFL7jo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OAw9xpqWBOOT++W2rHjPMhoyYL5GIP95GaWJLFkbSvaMjBAw0pA2HLtWf1B0KWqcl9twYBuQ3RP4GyGAnQHCZJkUn18FKl31hGBRz1cGIx4b/GHPp/Mr/DvkHuybNFKtYKE+BoxDMD64f8kdMaFVSOnaRLMCj9OiFhcotHs1mPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBcpXY0u; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-5131496ad16so1301023e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709125243; x=1709730043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h06r0ujGHNkRnzrxW3wJz3Jl8jpVfkRZ0v6DvWovm5A=;
        b=rBcpXY0uV3sS3jzXNBJdOOnQSlxSn+aXb2kPYC2HuW3NqF/1M2UZ3CJ778LH68QYxQ
         QDzx04qtvSac/w5gfs3FSwHlxAbYUPYi9Y4Y+wFM5rL5n7j/YAGod4uk8vM1d5Vtkmtj
         ziIqqWPsjC+DOrCIQL0fuJ/cK7xG7NE/xB7gEDNy/ERsQu2EDNrAYJQq2JhTNbTyurfn
         W12uUab3e21OEV7UuHPt7877DjYjTOYAddidyGNyaqvkQ6Rz5tZmWvWlRs30UeeLAeV1
         AsaGELO7vvWyTI17+bxuKW4xipb8u0R09lCAXQmnWHdxgMsHIh4lsSve0l4DfGVX5Oyn
         Yh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125243; x=1709730043;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h06r0ujGHNkRnzrxW3wJz3Jl8jpVfkRZ0v6DvWovm5A=;
        b=vO8yFWPZZ9tnMSofIwmaGfeJPx9Jyaz+TXb9kvGQWq35UYATNP5qzO6y4vsq+m+14z
         8ynpjRU5E4h2WJe9otEHsDuJCcD//hkZsRNAO6Q72YHO3NxU2SEMFkdGKEYfTVO66nuQ
         GE8YK89iVxO3fwadqlNQeyDv7xHOMuSVGl4f0ZjSTn/3JtgpbRamv9AOuvUXljFM/kus
         iz6XZGF6q2mMWLPgh2ZSECAc4HB1T6ZcPfm/o1SeahNEjXZb+xLsCNxQYbyVzW0AF2SU
         zXgjwh+LBc7VhpzIejmDW8PvtVXpRnJhPhdWiCDb0wjC4SFqJZ8UhsYAyugBQcT20ltL
         UbDw==
X-Forwarded-Encrypted: i=1; AJvYcCValU0HxjhETZUVMvF9VlcY4UicrSTcEMknBTqjJD2PZss0tvrsdfK0rwOw6Usky3KZLUSuGlBMizlWwDmjemxYxqe+NCOVsYkXefHz
X-Gm-Message-State: AOJu0Yw/oZPdAOzSB6/aolJNRn+Nw8T2fPZtNbJnGTleeql+zXJUt4H+
	nJ92yq8cVuoGuuHT1oPqiQWVTOnEp+hmsJ16VfrDzlDGUuoSUYUm6xyDAWp6Yodx/Hq0IWAXB1/
	9CJsJDbk745fZww==
X-Google-Smtp-Source: AGHT+IHrFaP6tadcFcO659oRhr26GrYPgzfk5CpJkSGTddGcdOWBVO0785BbSFB+6X7PjaT2roC7auj+KYGCdvI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:5d4:b0:513:1ed6:fda0 with SMTP
 id o20-20020a05651205d400b005131ed6fda0mr488lfo.12.1709125243459; Wed, 28 Feb
 2024 05:00:43 -0800 (PST)
Date: Wed, 28 Feb 2024 13:00:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHEu32UC/13MwQrCMAzG8VcZORtpg07nyfeQHWqadYW5jlaKM
 vru1uHJ4z/k+62QJHpJcGlWiJJ98mGuQbsGeDSzE/S2NpCigyLVoYmMQ4g4+fREQ6ypZTL2yFA nS5TBvzbu1tce61OI703P+nv9QfoPyhoV2u7MtiM+tep+dSG4SfYcHtCXUj5bRRqWqQAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=5eKyUMXaVKoGDR1LS8Xh6qVotw5zgKEUJmt6pSFL7jo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl3y5yuv+52DxXqIdJX5uK8sHE9psCaXeBKlBHv
 I8zNx57MouJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZd8ucgAKCRAEWL7uWMY5
 RvICD/9CvqAzix1mcz6EHZdV75Dm00UMuf04pwwDvO0KjBVz6lZkWE0pYiJaNM8HEGSjExROVVz
 Z1iZIQduKxdPZUis4i16l6saaphR16US4FW4xjRxiGYfsqGOc8NqerKT6Sl+BT80jabm5JoNU1n
 8MbD/yaZlECu2DKPFc3gVt1tHKY6E/9H+1EZLZw3dAaqloBkguwM9w2hFAIVwMntr/7VCc0embX
 P8zkjDCp7HdgfEgNeGihuODbOpvLJRvhb3PmosVMTEoabKBdkNnvUwnkHIWEKkiRD/ehBfBDiEo
 Vqk+PLcx7rUMTlbtdADNB34HXTKoSZ3/LwXJLViRuXIsXFwvi6/Y3A++HRP/FM2rCrh3Kitcgdh
 Z4a3jLhqFACDs/QxX6HRaxeCXWokUktAMcpiuf7mj48HgbNrYGjpT03gWk2QwQ+DUabGuhD+fQA
 xzj/l7bW16i0C1wZtgxaP1Nr3zRK4gdJhiHqE8JPV4mWcsl3QqVxwnRNL8m8OEXSEal6EnjeFJm
 gAZITPrW4Rv/ITWv7Rpr1ELmNyv4C3R1lBQ5d40PFzhCSQ4T6OPOaLoFDMtT+iZkPbw4E4jC2xY
 ulmREotrVbYfOw2MseMm8ToQdGWOdXNynhKukJVdPvyyW3YF+ZRmHqmws/KN7bU3s031ncnHiZp DLHrdsXYZw20JIA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240228-arc-for-list-v2-0-ae93201426b4@google.com>
Subject: [PATCH v2 0/2] Arc methods for linked list
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

This patchset is based on rust-next and depends on [2].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://lore.kernel.org/all/20240215104601.1267763-1-aliceryhl@google.com/ [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Move raw_to_inner_ptr to ArcInner and rename to container_of.
- Reword safety conditions for raw_to_inner_ptr to match its users.
- Link to v1: https://lore.kernel.org/r/20240219-arc-for-list-v1-0-d98cd92c760b@google.com

---
Alice Ryhl (2):
      rust: sync: add `ArcBorrow::from_raw`
      rust: sync: add `Arc::into_unique_or_drop`

 rust/kernel/sync/arc.rs | 107 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 18 deletions(-)
---
base-commit: e944171070b65521c0513c01c56174ec8fd7d249
change-id: 20240209-arc-for-list-a2c126c2ad5c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


