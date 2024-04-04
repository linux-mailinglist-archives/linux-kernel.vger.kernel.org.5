Return-Path: <linux-kernel+bounces-131460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9B89882E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360541C213E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02A184FCC;
	Thu,  4 Apr 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UL7h4T/O"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9A59157
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234831; cv=none; b=HBAQp0QOWu1oamsZAIAVaLni1GmYO/uiduCv3h3QmTD7r6U6I6ZQjJIBCV1ClUri52tmSqIl0aV8ZLvnrlNNvhn2nm5KAwmjDche0Mtrre8jf96m+DHrK3qL/7BuOz6ApUI5Zgadnf+7GFRUmB2F/S5jVJBTJzSpIELKE/iZNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234831; c=relaxed/simple;
	bh=LKX7vVNyqnnyjHXxmLAOtau0jOrACCVSiJJ7CZT6tc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0SqfG34b2SOTMqY4EvanscaTyKjvSuzvlB0FGWzhvyZ5+YMft4N4S4o983y8mFZ9tUaLgVTRG+HKTHreOd5gfA1UeoQwNeHVQvOQL4/GeZ4XjZnrILUDEk3C+dKi35BlT07WbzpWuUKSwNYgk5WzSyLWzeaVLqvPC2SEAJYhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UL7h4T/O; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4da702e48e0so428100e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712234828; x=1712839628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKX7vVNyqnnyjHXxmLAOtau0jOrACCVSiJJ7CZT6tc8=;
        b=UL7h4T/O0Lx41kWnx+2mfQhaonmBn+SgqIf7nMnevAvzKClKcdef4gze0prGteprf3
         OTlDWUk/Zwk3fyCHViWQYSCFShtvxFZQaCBvKvmCY8hftc8mg/TPvEj9wgyC+B7lzDNv
         rYx0BNBZR4CeOsVQ8lr3xhYoJLbgyBJhTYSkl7MfUBkD4qZlr5TesKsGky/TLQSYr3m1
         zOaxNcOBuEONg3sGreCHftyWQCQeQ1KotHgff1P+wLd4rFaqvVlHUDVoYMctY7Pqz86G
         tyzVhPHMlWLSA2fDKrb/w0ZDJPxyRB10NdCWMj9qb9g1t5bJySV9JRWvOVkNW8gKZbSJ
         pD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712234828; x=1712839628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKX7vVNyqnnyjHXxmLAOtau0jOrACCVSiJJ7CZT6tc8=;
        b=kt7eXLlFM+evnFyIdW2UFF8XdvcSN9E8LAT7HLE/0VE5NSAh2uc2+8kv8IGLKPD+Mq
         GHTXtGkboQssSuHcZDg/Cnoq2gRVli5q4rBsKgnVSPP6guTet17KwsDwZqZ2YbKJjf4L
         GlsRKdUuxaNgvinkUXgAeWTYX21mLvB6xHL9Zalv5pQOndEe6ilRH2gLUqVjpiId13DQ
         hu+lOXE5EXoBkhc+x2gKWdPgZ7DcemqYUkGTtcByyhX9B3cv8zqTVv1UjX5SzUqdUhzb
         u3MzoF3VuyD1G07ClqZV2x8ziSE0Jxwm3wZwh6+QR7tXZPJZVb+1NO6rm/NOC425ie8T
         7tdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdejteXPwddMLaGx4uR3/LzGE0wqtO+TzcL0eZLTVSN6X3Md7QV+FBBYSKz6XRJISKCnfmJOAAZP4eYhwH0Ae+WEBYWqhL1PsfpNrj
X-Gm-Message-State: AOJu0YwLbsJxixgj52Qg87g2yP+Mca7jg/LeFvQBjVDZ1bmnaAiDiFOo
	hm5DnojTuHE9sUcQVVZa8QjPJaUF58w5pkqOZ3xcZIOit6opucuVdcKcGOwZgJ4rZaZOtx3LM7l
	24BjMizapSSWWQKqa5+vOMOFQJwqLNmPdDo06
X-Google-Smtp-Source: AGHT+IFKwJu/g7BbPnYrYJB2WSSLAQgmbJ4c/CB4oOIccB6vlZA5jW33C9kcqZQFCvLNmqUBHzsgj92sT6oOOlwD0UM=
X-Received: by 2002:a1f:7c8f:0:b0:4da:9900:a547 with SMTP id
 x137-20020a1f7c8f000000b004da9900a547mr2081279vkc.1.1712234828230; Thu, 04
 Apr 2024 05:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328195457.225001-1-wedsonaf@gmail.com> <20240328195457.225001-2-wedsonaf@gmail.com>
In-Reply-To: <20240328195457.225001-2-wedsonaf@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Apr 2024 14:46:57 +0200
Message-ID: <CAH5fLgi7R0JX8sc-cCQ8eUgzXFx+6hBGZm_gMZ_RvHPKZeB2ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rust: phy: implement `Send` for `Registration`
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:55=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> In preparation for requiring `Send` for `Module` implementations in the
> next patch.
>
> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Cc: Trevor Gross <tmgross@umich.edu>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

