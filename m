Return-Path: <linux-kernel+bounces-44259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED457841F86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A899C282BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D958229;
	Tue, 30 Jan 2024 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="xO1x1Kok"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591E8339AD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606982; cv=none; b=WeG/PbdOnfOVDY2dsWwd7BCnA+7k7QxzhJldoUVhommxA+EG8AfT5CAUztxzLPraVRyIxEVtrojf5zkMVNb8+BIiZVrZl+5XivwP2e2Tfd2trLAOC1m2OxPxnDlMLAZM/2pVwpjdpOPGBE64H21xHTtijWhkZaa8MZsSlwx6ZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606982; c=relaxed/simple;
	bh=huiu7FiS6Ka98PX9AGRHOYZr8LDkTZM/ajgwBoH9zqA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=dMeO8Ewm8vo6PiFvf7lll6A/KYWduPyfOjvjp9eycXb/pY2Cl+fexhpaQ+agvqYV+01zwr7s16wfnP11Lh+qFSCml5BbilbZN5yyd4q9QsT/hEai3Rz6xuv/HVuZ/BVHjdwtxzCyaG8ElRyXx52Dh1CR1O8kRxmlRIAv7ay/TwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=xO1x1Kok; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so4328702a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1706606977; x=1707211777; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=9tz7+Pj2sphUK5zlEcIBtuji5ko1j4GrxA9tCxYfuyg=;
        b=xO1x1KokQyiG7e4TC25rR+enVqZFtk4ZLafdQotlTlU/iZcZjwqX0BB1QTpjVPJ75N
         0KueI3E3HKsBmk8EcjSp7kfRkn0s2vfl5Vj1xdeQtIqTjBlxjImM86Hy2qOaA+vmAfaP
         4bAkmbXqG1Jd39+TFTC302o3fJrA3VxHnVk6wDDYk0oSpxrXPB8I9xxlfQ7tQKL81H+D
         uz6SMI9b+9SvR1uGtNu3uU78IDpVK4qeGB0Fi5B+7J5yyqViLUVaiCD3ZJqj7TX2hWd7
         B/ycUcfQtH6datBvdg6TMNatmYBcoXG3DDvmGoyUUPC7w/ONkUE1ZHyBL9Tmz64ouhYW
         QFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606977; x=1707211777;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tz7+Pj2sphUK5zlEcIBtuji5ko1j4GrxA9tCxYfuyg=;
        b=kXlMhi986nWFTHrddz924InDD00OG3KMEs7xHJ0ygvs9arjTm8+zejwp40DdTDDi61
         ZTov232MmGXAB4TgvaaOHFRFj99lACjQ/YoYS7Q6NSPzJfb1uJyYQy+awF7D07Cgpt1H
         /WKNjnBqun2m8c7J2r6XGp3VIBjX+tveURsaZzfFRAi/UVXtstOJV20SOl+3Qbnc7xiL
         vw/LBm4mPH+blF55qBnBvzsr0ZOwZNSwcPokcpOkO5LchWPiv4x2T+XBuFps/wYvNRDv
         U51V93cXlP9hIYEg2r8vTCSePQBUfsWEjLXYxwI78hvT9a9e+p6kDfCQl9DK6HLVOkw4
         RFbg==
X-Gm-Message-State: AOJu0Ywz8PR1s8ZQpYnIXTbuKi1E4F40pmyaYmWyTROvIGoptHqF4xqE
	rDD0cVf6qGwSlk67smWd+GWQqpBERaeX8D6Lz0sadNbdJIKm88OaFhwi3d1p+Y4=
X-Google-Smtp-Source: AGHT+IGxPhyxEY7oiLslsel5OsK965iXiA1cfRttHEQb5I5451oB7+uVOkgXsRheMgrVk0aWgZ2K6A==
X-Received: by 2002:aa7:da84:0:b0:55f:3cb:d02e with SMTP id q4-20020aa7da84000000b0055f03cbd02emr3451599eds.16.1706606976900;
        Tue, 30 Jan 2024 01:29:36 -0800 (PST)
Received: from localhost ([194.62.217.3])
        by smtp.gmail.com with ESMTPSA id n17-20020a05640205d100b0055f05342a41sm1802687edx.44.2024.01.30.01.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:29:36 -0800 (PST)
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com>
 <ZbMA1yiM6Bqv9Sqg@boqun-archlinux>
User-agent: mu4e 1.10.8; emacs 29.2
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Kees Cook <keescook@chromium.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=
 <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren
 Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
Date: Tue, 30 Jan 2024 10:15:11 +0100
In-reply-to: <ZbMA1yiM6Bqv9Sqg@boqun-archlinux>
Message-ID: <87il3bgoee.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Boqun Feng <boqun.feng@gmail.com> writes:

> On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:

>> +
>> +    /// Maps the page and writes into it from the given buffer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that `src` is valid for reading `len` bytes.
>> +    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usize) -> Result {
>
> Use a slice like type as `src` maybe? Then the function can be safe:
>
> 	pub fn write<S: AsRef<[u8]>>(&self, src: S, offset: usize) -> Result
>
> Besides, since `Page` impl `Sync`, shouldn't this `write` and the
> `fill_zero` be a `&mut self` function? Or make them both `unsafe`
> because of potential race and add some safety requirement?

We can add a safe version that takes a slice later, as here [1]. Same
for the with_* that take a closure.

It would be nice to model ownership of pages that are only mapped in
kernel with `&mut`.

BR Andreas

[1] https://github.com/metaspace/linux/blob/702026e6645193fc89b7d55e00dac75fd492bfb8/rust/kernel/pages.rs#L178

