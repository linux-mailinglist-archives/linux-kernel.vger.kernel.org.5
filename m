Return-Path: <linux-kernel+bounces-44246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294AB841F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4CC1C24BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EAC59B7C;
	Tue, 30 Jan 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XiSz3zCO"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20659148
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606580; cv=none; b=a6+9aLqjz7gzh/PJsUF4+2upw6Y6DkpqVYY89E2k3fQebXUmI3MssWJ3TlGgGvBC7M6V3kypoljNGnSUnvroGBX2fUpwpsXwcgArcSYjMKStOFPkfwzI6/QkFXTuWMDRLl1P9nZN+Ftwqw91NMsfFW/96PpPUuwze3GLEDxE9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606580; c=relaxed/simple;
	bh=u8E/DAzdM4BDv+M4rE/6UY3tXIFTWYYORwwsXK8NW1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ii0S0uu0A6VF3b/9+tn+/YFDwDxAF8WH2qPYV9OeL6//8KJdNsLdwl+0wL6vFKPWASVEr7qzYf5wwSeh2/xduDcdazgKN/OSRUPAgIut9LVWgrlUokZ9UCt86Iqs7H427cZ4xEbrhsMZ3oMVit9T9gCOuwX6QvZHVlGO7uqIofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XiSz3zCO; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2cf3f998869so33128031fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706606576; x=1707211376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqLMO+WcsA+qHzDqK7CtF5QEfkhWOqOfu9v7+ZVhskE=;
        b=XiSz3zCOefqwkTmBq9+h/pKYiuDQ0oDreYkg4yBCyqFFPH75qp8Rj1i17gpjnW33uD
         9Y9G6Mn+ClJsYXQMWxVlGhjjoarsQgiTKM+7O6uOBPTKXQ7i/Hh8ejd0h257J/THo0aE
         nfhVRUHy+5Zyzhuu19vH+27txyM6fLmjqktikAYqiD3bHuVy+ZKUaMBkCbop34FeA8P3
         HJFfeE28XAK0BUWXR+VUajgSwYogu2eANY3O7OM5QvDw9cO8JN3nnrkOd45k8ZpWN7dA
         3TQlgsxUfShCe4ruqS/8KujqPmNkwqJIW/TbcdHW6rWwu2Tm9dZq1Qk8abMf8ay09UNk
         lOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606576; x=1707211376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqLMO+WcsA+qHzDqK7CtF5QEfkhWOqOfu9v7+ZVhskE=;
        b=VLRrvyqGpSs2d/JX2id46lCAY8I6aKK7B6PVV4kYVA8R4UWUv5jX7anhB3k/qWJYLg
         veBay3pg172wk7tpvDDlQ0j4bWNAmFzMkNj7HmhPO1ZdU1/Adtb7dvzMv71RhIPb3n2o
         B6mS2b0xED7bdF6xED+XYX/R194K7YWwJ5rgsTCUKBrZHr3y0MFmwMZY7aEES1RFERUF
         zgqDzdHmX7t+IsoWlkeJ0L3TVTw/JB3t73Y+IG7JYjbul2SapJIlPozHaTJHhY6Aw2C+
         CX9Sq9U+K58M2oFVm9l6tDqGRMEgKH8VYb+RxoVtPpfWhpOXyKGTMzg0T0CNvvQUD13z
         gxxg==
X-Gm-Message-State: AOJu0YyaQf18O+rPlfzAtDjesigTXnKi8hYReteEIxKdVSSxvGddpJPj
	1OyANTUiEjK98sswdsgeK3/HSRhnIDJr2iyqwacIOmZEFDn/q3+BgbMAwiBwt+F+1DpBDW544KH
	eZJ32m1BNy/PJJQ==
X-Google-Smtp-Source: AGHT+IF87NQ812vMFotO2i42XCkp9U2cUqOajgaKofrGlkuAmbQh0g7jvgwQO8Z70Yi76a7LPw7Yradv/DUgloU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:a370:0:b0:2cf:3298:3ddc with SMTP id
 i16-20020a2ea370000000b002cf32983ddcmr10644ljn.7.1706606576260; Tue, 30 Jan
 2024 01:22:56 -0800 (PST)
Date: Tue, 30 Jan 2024 09:22:52 +0000
In-Reply-To: <20240123150112.124084-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123150112.124084-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130092252.1610582-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 00/12] rust: kernel: documentation improvements
From: Alice Ryhl <aliceryhl@google.com>
To: kernel@valentinobst.de
Cc: alex.gaynor@gmail.com, fraunhofer@valentinobst.de, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Valentin Obst <kernel@valentinobst.de> writes:
> This patch set aims to make small improvements to the documentation of
> the kernel crate. It engages in a few different activities:
> - fixing trivial typos (commit #1),
> - updating code examples to better reflect an idiomatic coding style
>   (commits #2,6),
> - increasing the consistency within the crate's documentation as a whole
>   (commits #3,5,7,8,9,11,12),
> - adding more intra-doc links as well as srctree-relative links to C
>   header files (commits #4,10).

I left one comment [1] on the last patch. With that fixed, you may add:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

to all of the patches.

(I responded on v1 by accident, but it was v2 that I have reviewed.)

[1]: https://lore.kernel.org/rust-for-linux/CAH5fLghSaorRgDDuqNCN-BhQ86ysX96b=nKM_cZAN0_E6Ai04A@mail.gmail.com/

