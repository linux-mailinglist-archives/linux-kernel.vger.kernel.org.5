Return-Path: <linux-kernel+bounces-104150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD92887C9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763D3B2255F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44ED1643A;
	Fri, 15 Mar 2024 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="JqQvmBGC"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDD15E88
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490604; cv=none; b=PUrhzd/ni5kAvslSRnTfT2OGHCo1WywEBS1NkfEuMaMPgrgbPL0rMFwsSu6Q5zh4sYMxntLrLlZ93LrPn9SoVlfeQmUCyPPTsmMJzdVqmLmAsPt4XSz4QLOpmwwW5YyNm3z3//nS+qezx/WSx4pcbLoy93msz+bYigCGdD/gBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490604; c=relaxed/simple;
	bh=G3LXo/8SAPK1qMap7q7cDulVLMuCk5g6x5WEmLjyGwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgQmcGt+EaJka2pTiOkjNJZsQ3ukCfGx/B6n+aysOH9mjfQSNR4v5X+Cf01ietyIstir59agKi8OvjkpL62ZNArCtOCKpRYjwElMKLDHcZD4/SmP6j53perNqSsbbwaLbhfLVLWo0LZk46iOJ+6i/hibVfbYBRbb/QzF7GXt6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=JqQvmBGC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5687feeb1feso2069936a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710490600; x=1711095400; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3LXo/8SAPK1qMap7q7cDulVLMuCk5g6x5WEmLjyGwA=;
        b=JqQvmBGC84yhzO7ANXvhDbUV9lL95F4ySMxh/FXyCOv/UB5QBIBL1QmNLi+KEUbev4
         XJ0QbmSeYaBDhCA+nfqAtH8xt5Y7m3TmelTJ01pQQX79KhzHOurXWs34y0d4Xk0cReZc
         nQV3MYyrhEik/+r1dN9BhZNY1Q4bXH0ktIbT/QruxnULyCrPb9NEFVz+PL6TzcQFERUC
         zbwGNhoFaiPeRseTBN5z5Q5ttUTCFH3ODM3E/G+kjzFVrS/yATQKSp2JblBmZeyntgsJ
         TeCIO1fnah58GaoSPFGoDBL1W3WUQmXiy3WLzTTNhMnrv9zSz33ONI8pSO/QRxy96kDK
         gD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710490600; x=1711095400;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3LXo/8SAPK1qMap7q7cDulVLMuCk5g6x5WEmLjyGwA=;
        b=In+6dWGFUUJhhKMVQ91b22JF2NxRaLCmpvW86sN/G2ABui2ZpAbCxchGtX/VEKN+rU
         DOEAUr0rRfcygfn4t+vlXx/1qD5qnqwyE0DwitxFn84fJe+2zPsp2Pa1A0oKNolUkdMs
         3g5pzlV0WqVeQhL130g/VER0J52W2MCLk+VljJMrLbX7tmvnLGBG0VD6ayYlA1wDknIj
         cQp6QJF3EbY6a8toycMwExyznLMkbeo6oNYrwHqJVpeDe0zGtiel+Ulmux4CcJYp5q8b
         +8tL0aviI257KrG9hXY3nN6InyYg28AF0kgHg03EM1TrBFPaFdSTQ1TgWgtXLta0Eo7/
         /15A==
X-Forwarded-Encrypted: i=1; AJvYcCVp3h3RGDZlerg3A+Z8NYFXzHG6E0qFVNK+VnIQEYDxcPVjcqx30DgCU3Ln00ZnIu+ArG84xNUaYBF5oL5xiL/oKSKQKZrTLZD9xPYW
X-Gm-Message-State: AOJu0YxE1ZOx+suRAVgFXRaY3pr3WRe1/Jo03W44p8jbHeUEJWIB40cn
	12bD0kbWU+KHb+bV7YM/t4uyGkQJFWI9sEFcZvscDJd88wEMIAoCRVn9uS/Q+3o=
X-Google-Smtp-Source: AGHT+IG7Iq8e4QX5tNKzGQjmTkOhzLhVMQZNEC1/svRFC11/pvZWvj4VBzkScAqS1k2USSm5kMesMQ==
X-Received: by 2002:a05:6402:28c9:b0:568:9e92:2847 with SMTP id ef9-20020a05640228c900b005689e922847mr2213502edb.40.1710490599758;
        Fri, 15 Mar 2024 01:16:39 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id q12-20020a056402248c00b005676dc74568sm1451876eda.92.2024.03.15.01.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 01:16:39 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,  Andreas Hindborg
 <a.hindborg@samsung.com>,  akpm@linux-foundation.org,
  alex.gaynor@gmail.com,  arnd@arndb.de,  arve@android.com,
  benno.lossin@proton.me,  bjorn3_gh@protonmail.com,  boqun.feng@gmail.com,
  brauner@kernel.org,  cmllamas@google.com,  gary@garyguo.net,
  gregkh@linuxfoundation.org,  joel@joelfernandes.org,
  keescook@chromium.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  maco@android.com,  ojeda@kernel.org,
  rust-for-linux@vger.kernel.org,  surenb@google.com,  tkjos@android.com,
  viro@zeniv.linux.org.uk,  wedsonaf@gmail.com
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
In-Reply-To: <20240311105056.122734-1-aliceryhl@google.com> (Alice Ryhl's
	message of "Mon, 11 Mar 2024 10:50:56 +0000")
References: <20240311-alice-mm-v3-4-cdf7b3a2049c@google.com>
	<20240311105056.122734-1-aliceryhl@google.com>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Fri, 15 Mar 2024 09:16:32 +0100
Message-ID: <87ttl7rjtr.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> Alice Ryhl <aliceryhl@google.com> writes:
>
> Andreas Hindborg: I recall you mentioning that you also needed an
> abstraction for pages. To what extent do these abstractions fit your
> needs? Which gfp flags do you need?
>

I based the block device driver API and null block driver series on v1
of this patch and v3 should still be good for that. The null block
driver uses `Page` indirectly through `UniqueFolio` with `GFP_KERNEL`
alloc flags. I do not need to customize the flags outside of that.

As an aside, I added methods to safely operate on the page contents [1].
`kernel::block::vec::Segment` indirectly uses this to move data to and
from pages [2].

Best regards,
Andreas


[1] https://github.com/metaspace/linux/commit/e88f4dc928233fcedcb0afec40be9bc2f8f74e3b
[2] https://lore.kernel.org/rust-for-linux/87y1akso83.fsf@metaspace.dk/T/#me6497ec69544efd21908f1acc6b3a1ab8b148ba0

