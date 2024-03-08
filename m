Return-Path: <linux-kernel+bounces-96754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FD8876105
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C7B1C227CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260FB2D05F;
	Fri,  8 Mar 2024 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gt1SFTqi"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB9524C3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890621; cv=none; b=uMtwW8enPYYuleVAjxcVQyNtI23KYwFCqP2NUtb/EUXrPYvLi44fojuO/dOFmS5wKuRtIG21oBIBOrqJeuZHqxRWpEEZnHOP0D+EiRjv3/qv5gheqXGWdGAhLjwo75fUERYwh8kbvlz6IaSjeYoCYi3MzBVF7Qp4iLWMpTNuIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890621; c=relaxed/simple;
	bh=ARgIYQHmcT3WDCT/C37sjRzjUfl+5mv5bdkO5HSlrZc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OZKh9/qQNTflZnKemmFvHbPjg6QgP63IhvElqH6yEVAocVrZexFebbV0Ur3ayiO1EkYFas4ZbWvl/3INC0LVvlUvp4yE7PN2QaiDF1H9nZ9AOYTnqQc0AT7S/iBxYJNQysQBmnKuxZ54sC9oZDe2pj2wOslHqGwrDrMJ1BnC7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gt1SFTqi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609ff5727f9so13425707b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709890619; x=1710495419; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k/FYxEuJJjfDejA1S3OfbTfejCKvINxrPLGNHovjOxc=;
        b=Gt1SFTqiGfL+hs4Aq7UxK8B8pqQPlLlJJxIPqKu4A4ExdvuLK4VtTTwO4lvFa9fxo9
         WYcE4NheSozoZ8ZgA04VOEINvQZYbL+I3NwOywoA0/c9zctlQimChQDv4EzibrN4qeFI
         O/4ReT9K1yw+ond9D84zO7aVUWu0w97ffsKIMx8VP2wnS0JrWPCLW0cqsIMuqIJPqh9i
         LzX3o6XjKZmeUGqY5edgSzN/c7NDIXY9mm+iOh4Z33fyBPORX8/XBrCS7fMbIP4HX+4w
         A4e8iQqSJjLVK8zREin8eM01DECFLcS5PAvY17gZGBy9oEiVP2Iio6xJ8uqMoBbYMe01
         FSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890619; x=1710495419;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/FYxEuJJjfDejA1S3OfbTfejCKvINxrPLGNHovjOxc=;
        b=okHVKkpVSdzFHb8nTzzqongqNQWyGODMV9sS/SCSAzw7+LeOQMj5CfUaSfuQA22feR
         fNY8y+d4RyWj2HP+i0ZwaXhnciDttbywi+8Cy5jxzSDNclLkRR3unilI7cF3kXwpTIgx
         bUhzp20vIYt5+zchQTc4NJ4lGvhpwWgWvJ3etTDYkuM4n7cEaMP8ZAkv8LYssBXj7Zse
         W7tusa+pCU9VtMIgf02wbepNEjnjNxgJIu5p36B2boILcw7dJwnWhNg6RtXBRmC86zIM
         SIhwW/DS00S6iqadyRTohDH4BvOvOGwrqRlJEESBdhiL1y8JHIZysLAsIk3DwhQc1GIP
         0L2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2ZRiHSLJn8Xs2TD7wNqGzCp4E3D4Hz445SVoxK2Tbu/S2E2T8ZPRXSkhjdfRYUW+pVslJwJXSfQ6rp+TRm447TJKIv0z//88caiq7
X-Gm-Message-State: AOJu0Yy8TFK0UoK4K5lP5H3FmqoIUyodLBW/lRiOzMs/FoU8eaQbShb5
	5QXSRwcxkwZ9PPjM/MYp7BE0BI/KL2cFJ2e54YeD/v9ziOD06orNsHPFkTMd/JKUUChR5jDeGys
	trEEEJtWc9+6Sug==
X-Google-Smtp-Source: AGHT+IGkL3Ui+SaRSxFgXSCHQwNmZqC+lN7Big70IIcB7TbtSHOU6BLY/t/HxrVy5cmGM1i0ujxLf/IvIE22Ngw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:4707:b0:609:fdaf:8d0a with SMTP
 id gz7-20020a05690c470700b00609fdaf8d0amr524280ywb.1.1709890618951; Fri, 08
 Mar 2024 01:36:58 -0800 (PST)
Date: Fri,  8 Mar 2024 09:36:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ARgIYQHmcT3WDCT/C37sjRzjUfl+5mv5bdkO5HSlrZc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl6ttfeicdGJCfsaczcFXNtWql+LSBl6Qc4+PnP
 ywKFtoIraSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZerbXwAKCRAEWL7uWMY5
 RnVUD/sHQH5VMR08yYy75nUq6fV+Yv5tkgOTsv2agrrP44YcVQqy7U/melDNm3n8nJYrXh2gOpa
 gOJQ91t+rxLwzIhod7YxtA4+ZXSOmc1MdtahuK7efuKiKgPbmw8Yg58mz5iTmwAkNWhKudF3QM5
 qMw4n2zKKLH2WlyW+y+inDtP0rfZiX82OPgH7fi05cl5dQYCOYWVL6OACSuUE6/gkumY2pCedgK
 Qbe3daRvucMgT/Nk5pumZPMrNXzjxL5yhdjDvL27+AOJDVGtcdAwWbts7TxNFA4yEgA8fmzIEPG
 nclXhKSU4urh3EWFS6qKnAkCOtypDOsGyuwD8Y0shJlBv/XO+CY8rzaSHmO1BJCvMrpax1p/VLa
 YvBi1/hBRo9nkh81dj2TewoATyV5qNCdIVQNKRjptd6/9kaAUslQyaMMK7iG0Z4dCZ48UZftlAj
 9o8SthHY/vY6v/dlm9o2JTm80kYnAA+ybghA38+AbhQUCS7BAJMNXSG8G+DnHB3Mu3SkRIimzi0
 wxNjQ6lWJ/3+wTnmwSXrxdOlnBdCJuolJUS/m0Wx9+5hHdmD47S4BcDyeO8xOJPU0Lu15pa6QpA
 icTa8W/M6KURPPJ3vAATosYGDv++n+tFkRqIHUtvcrSEWORaljgvxYA/9WA47zQK+r6FK6PT/to So5T60HPmXn+V6w==
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308-constructors-v1-1-4c811342391c@google.com>
Subject: [PATCH] rust: don't select CONSTRUCTORS
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

This was originally part of commit 4b9a68f2e59a0 ("rust: add support for
static synchronisation primitives") from the old Rust branch, which used
module constructors to initialize globals containing various
synchronisation primitives with pin-init. That commit has never been
upstreamed, but the `select CONSTRUCTORS` statement ended up being
included in the patch that initially added Rust support to the Linux
Kernel.

We are not using module constructors, so let's remove the select.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 init/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8426d59cc634..41f7fb195382 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1903,21 +1903,20 @@ config RUST
 config RUST
 	bool "Rust support"
 	depends on HAVE_RUST
 	depends on RUST_IS_AVAILABLE
 	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
-	select CONSTRUCTORS
 	help
 	  Enables Rust support in the kernel.
 
 	  This allows other Rust-related options, like drivers written in Rust,
 	  to be selected.
 
 	  It is also required to be able to load external kernel modules
 	  written in Rust.
 
 	  See Documentation/rust/ for more information.
 
 	  If unsure, say N.

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240307-constructors-07270b039e2c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


