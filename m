Return-Path: <linux-kernel+bounces-71519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63985A692
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9A4281BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5E39850;
	Mon, 19 Feb 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuzLJ8lF"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C07383A2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354490; cv=none; b=q5IQmlg2PpHA5R/j/ZEcCOlkiTuWTG69gf8/CZIOUUa85MRMOo8IpSKNQ39N/xTRkS7YE727UHqqCHg3glJE/HolATK6Fb7pu10ZiAP51uc4/W99Uhpr9jqmyuiWgaLe20lAF3zsRdK2dW/ijPrGpuaMNPgHC5L+6EtbnbJ8KSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354490; c=relaxed/simple;
	bh=15JPHIrorMlgdQXuhKDILATvg4uizYLJqa6kmHDr6Tg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q/p6XOPtTSdcbJfnthI5mJ1gyp4+LOZ6zzmjntaQ5EE1AVk9qjc4SUNXl1FF9XnDPMdUPNZccxqYSK6pkHvpE7ryZ1pDvJJpi0PLNFvrGu8w3A7b/VgDrAqjtbUvAA8WxI23VBZjS6oY2q/1N9c234Cvegxt31KN5NpLPYSaXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YuzLJ8lF; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-512bde6ba39so450939e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708354487; x=1708959287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=76f34A8OXIicg1B0/YeiOgJWMiNyXgOoZwGxC6DKwRY=;
        b=YuzLJ8lFgs4bmvni2IuB1S29XbMj7NpEOLy5YWgXv5CyFYNXhcPdqsfMAVw29tbl/o
         LdrBAKyL6PGJrRinOmaaT8Jdxlf/V621kCZIHTe0FTuILjifp1mZ7IU6VUYoCccDliit
         SENu/EWlHLcIHepWD14pB22YR/MH6ni2sjwI0Vfju8gW1Yi1cQ1O1nmjM9gjyK68/dKi
         iYUCF9SZZE8bDj/oq9vWvprCmUOWBxBdZtiwsrYE8S8XJDXjAx9I93dQGUlJqHZ+8s8H
         M6oMgEub6ulB3M3tZ6k5L8mv4h0pKsV6SZVOxt9WsRmNO9X57YiAO4bxXax4AIb+1qUs
         S7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354487; x=1708959287;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76f34A8OXIicg1B0/YeiOgJWMiNyXgOoZwGxC6DKwRY=;
        b=izZGl7oMmfLzISF14hAE/KfaXpokmFVQMooz24dfR8xrJh6wJuyE3+Z00BTqPI2YC+
         vvASLPtECyF2SSEGE3KNIlPrbqdvnc+3DjLmWKFJa9VWjcTftnucaKBZoFAjP7guPym0
         VQ4aj1B73YC641KzARAVb5vc6oYcvAKQ9V6Ge95DTn/XOFfbjc8ytCyNwwJ7TjYUVnup
         voOcQXdv/QbsZyUpxTYumzeFmJ1IvQ5yqCSKIZsOy5otff7CaCSM7AvMGRrxJUij4AiD
         Z2Q7wkiRO4AWKm9iUES1J6bqZJMK5ZhU3F3onB35y/Y+/gBLmGKSmzuZp4GXocyoA3Ou
         qiyw==
X-Forwarded-Encrypted: i=1; AJvYcCWwS20ekefFNwkSMs/umqwTxtuJDjhEilaCtAK9LK5nwnF2DW5OYm/Ac36lOIJk9cCDmTcAzcAcCp3nPqrQh/iSdd8XIhKf2+SAovti
X-Gm-Message-State: AOJu0YxOlswAwEEEkrqY2aWZWDqFPHN9nufjxhQCoE2A2/A2HnKzy8g0
	YtoFlxFw3/6XLZzn5ryqK+IAiYTqQmb0JUWW2JngpwjP5X5PfIbehSqeM78erfrZQh4Sn/2nIDi
	gEC6tRwcx9/6RRw==
X-Google-Smtp-Source: AGHT+IGG1wBXBuBWg0mMxt9cSy1SbbYxDT/b5NogCGjgfi1j0aJHczhxq+AF4FKCEPa9y3ziei+Ku1koclmVre8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a19:6458:0:b0:512:b774:465 with SMTP id
 b24-20020a196458000000b00512b7740465mr2131lfj.6.1708354487063; Mon, 19 Feb
 2024 06:54:47 -0800 (PST)
Date: Mon, 19 Feb 2024 14:54:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJJr02UC/x3MMQqAMAxA0atIZgM1qKBXEYcSowaklVREkN7d4
 viG/19IYioJxuoFk1uTxlDQ1BXw7sMmqEsxkKPWkRvQG+MaDQ9NF3rihnomv3QMJTlNVn3+3TT n/AGWkBmHXgAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=15JPHIrorMlgdQXuhKDILATvg4uizYLJqa6kmHDr6Tg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl02ucROTYJaRl2cIJHtjqC1TduuiTCk5U6Ir39
 QgbSr3gCSiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZdNrnAAKCRAEWL7uWMY5
 Rq9rEACCODPLh/2VRIOF5ckCtn27MlMzMb557UgzZmhS9WaqCnz1wBXOfCRw4p4QSx9AOMkFfoS
 WqiYDFWYXSYahBwoNyrpFHAH7RYOaW7NOnp4ThDcPWv06lJNnmmtQwxQNFRal8dU7/HG4wLWQGA
 JX89lUMAdfGuLrRhcAtmGs9cJyryQIG+Gk+sV+YiAHahin0cwZKObJLeyTQMHvLa/3NanPnTH0b
 EQKzPNfkfPwqD2hliZyd94l1iq0d+jKHSDG2I+E0jw40SOmOoOKpk7z4JhTuYsCXjKq5cDSOISv
 oDRYfCG1g5rPPjGMMxLiHLOD1SJG920t5p5MEaKC7Ui22K9ViZbOQgDlGSn5djqFhtwjC4Gj8sf
 CNWX6M/7F9pSdlrk0MAa0DM3V8FYwzT3DjvSljjXzxMsy2001V7GGTmP1kvJhQfzm5e9cLGYApD
 s3B9jjK1HbrkQpwlGNTe1NbU+cc99NlyG6Ra+P36KvE2rR41xCallRHc/YT0R7WzN0Xki3682kx
 fqL6WRzclnLji26xdzNY3bVn0i9Qkl6YBG4kYb/rU0+HjuzWtI9MFebdF9fv5YRrn3UbvMihq7e
 rJn+Sopokjw8csww31m+QSxlHy0vbmOBZzOZoJVC4B5HVmNgrnyFfcyFhlxlpINV2qMOHpfyenu ZPyyq1OVIJEbqWw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240219-arc-for-list-v1-0-d98cd92c760b@google.com>
Subject: [PATCH 0/2] Arc methods for linked list
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
Alice Ryhl (2):
      rust: sync: add `ArcBorrow::from_raw`
      rust: sync: add `Arc::into_unique_or_drop`

 rust/kernel/sync/arc.rs | 103 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 85 insertions(+), 18 deletions(-)
---
base-commit: e3c3d34507c7a146de1c5ce01bd0b2c0018b2609
change-id: 20240209-arc-for-list-a2c126c2ad5c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


