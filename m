Return-Path: <linux-kernel+bounces-101302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F16787A541
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7125F1C211CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D8E36135;
	Wed, 13 Mar 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B33RN2S6"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7942C689
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323467; cv=none; b=Ze1Xs7COANHmqvz0j0rFXYzops/pU9QKEkLRQwgYsHf0MjhdtBUOBzwhXqeuY6ya4nJKR5VV0SCqEifUIfVsuKUChXF09+tp6fQK444SZ/U+WIaPQJfdenTQswjAJa9BMYxlIK1+GruHOsX/c+4ktEsxz1O91wEuhwUjM2WbDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323467; c=relaxed/simple;
	bh=VALqgjTPnatoPxcvD7oU1/NWjcytUzXnQ7aea0zfd7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NT3/B0ZeMtqvCQUUVnYiNkIX2KovkkK2EVgu3LfSQqTWKI+UuvumzfIiNOu1nVgtrdz/qhSHcWFSIvtOiFpUYlFnGEmHlsmI7XUo2yTDpYhqkvcK9YKHyIWBPhLBErBkze59+WOeF8Rki6Jxup0dZ55m7kY0waOLw7TX67XeS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B33RN2S6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a6051556dso20835507b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710323465; x=1710928265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRJfQxahYGAkNrqo7I2PmE92A0G8ANlJPrSGDn6Zu48=;
        b=B33RN2S6UPtn4nbljYXOGlyGZtZrF1eHxck7ZmwxZHmT4XKoLcO8kOzgyOKriI38jz
         dB4yKxutVHtmTBgM0UzKzqw0MOlDlEZV3JYi+Gwill/nOfFq252DVeAhMdGrFdwY/KhU
         tFaX9oqnuVoOUjDls4yTXhcpZaTQIx+w8EzoKkvT4rAJXmNX8sVBP7XtuyaD25w7m+qe
         91ftt27nlLMvKdWOu/YJEzBHhTTZiNd5IgiwSaqqKd8kt3lp3qAbKjufNz+Ytr0QMxou
         up+5kIL8YHpjOuRoTUQSF11HZjmPzNj9VM68HcoxXZUIRZJRDa6g4DZ8f1mejOJ3t5tX
         Fq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710323465; x=1710928265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRJfQxahYGAkNrqo7I2PmE92A0G8ANlJPrSGDn6Zu48=;
        b=kxIeYYxHkt5vdMFsIXq2/hpB0WeK0YMy/K7KCyM/YXNwEi7JeSEUk1iyf33zj3LdQB
         Z7hxXOsu74w5T2UfB8hkb1Y2DOeJBg+mw6faGIvBgyeuTpgffyvVmIUh+zNgq9BCSMhZ
         YLFRu5NI3CZTGpGY5ClkTEeMVRvqj0kvM/i0t1f7uH+Mx2iCFECTRh/pbTinhHk5s7nz
         6eRSzsiulZ3p9V4ZXDeqloIjKl4mbdzXH41ok2u5C0dgjp8l8UCPCaYvpa5lAn//n51Y
         8z0TB5rv5jhgXU0fRtdquLSTI0SCnLhupUMpA7E3bLKWwr1rGDoG93blg/YyxRCH3OfN
         eWeA==
X-Forwarded-Encrypted: i=1; AJvYcCWZv4rbt2IAN8/lQYk0znwX4G6tdsLePPz8oAvanWjTtfdvfSWKJ2/jwplTqi5Ho4RHbKb4wxaB99Vb16NlYog5l84d0KC2S9qF/7OP
X-Gm-Message-State: AOJu0Yw5NG436wCgKB/RUJ0kdbDsSLyddR2QMQdqWcUABfZ7thnY4jUL
	kww3Mva8hWsvtZ6DYLMXOmjm2lFmGkB6h9Id/m5X/u0mzbnjhwZZ+jh3ymVkf3qLikYZGvXb+VF
	8cvkkCoj1gi9lUQ==
X-Google-Smtp-Source: AGHT+IEJpiShMQsaleNGTKsdQI82HF3B6Dh14JeDghGydl0QX1ub+75M2xBZWQMzwcI/zPkgrssHsW93gsXcgGI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:188c:b0:dcc:6bf0:2eb6 with SMTP
 id cj12-20020a056902188c00b00dcc6bf02eb6mr61977ybb.6.1710323464848; Wed, 13
 Mar 2024 02:51:04 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:50:59 +0000
In-Reply-To: <ZfCQuh-JrplKtbco@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZfCQuh-JrplKtbco@boqun-archlinux>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240313095059.844387-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 2/2] rust: sync: add `Arc::into_unique_or_drop`
From: Alice Ryhl <aliceryhl@google.com>
To: boqun.feng@gmail.com
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, gary@garyguo.net, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

Boqun Feng <boqun.feng@gmail.com> writes:
> The code looks good, and FWIW, I added the Examples section for the
> function since I at least need something to run when queuing it to
> rust-dev branch ;-) And I think it's overall good to have examples for
> every `pub` function. If there is a next version (which is unlikely),
> feel free to fold it. I can also send it alone once Miguel put your
> patches into the rust-next branch.

Thanks! If you have reviewed it, could I have your Reviewed-by tag?

> From 7d26d1177a2788ba96c607fd9dc45baf469fb439 Mon Sep 17 00:00:00 2001
> From: Boqun Feng <boqun.feng@gmail.com>
> Date: Tue, 12 Mar 2024 10:03:39 -0700
> Subject: [PATCH] kernel: sync: Add "Examples" section for
>  Arc::into_unique_or_drop()
> 
> These examples provide better documentation and can serve as unit tests
> as well, so add them.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

