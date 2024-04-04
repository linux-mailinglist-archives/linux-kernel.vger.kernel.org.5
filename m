Return-Path: <linux-kernel+bounces-131466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CC0898839
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C6B1C2150D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F6576041;
	Thu,  4 Apr 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnk1VaCs"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9342072
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234939; cv=none; b=o0uwfrU8ptc5J4kzTUVcaWjossx0YNKbI6IsDvEVhRCJi3QYynYNWPLLYPLWAVcFiu8DIa6QiihmgCVxn5/Pbi7/G37c+CAIIsZsBOwr1EEHAsDnPJlCHPhJnXU7t4no1CXyxx4VS9CZX7jEEkJhebruI8hVY52JJG9DIuau+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234939; c=relaxed/simple;
	bh=CDW+rWUwlBs2jr/h4xTTDqP5Pco98DLtx7p8J/ZzVus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIgCcdvrDiC/6fDTE+ygxtsz3cTGk0dcCfzaB3ject720kYYQmQ2t/yTEbq7jzQ11mYfSJB/BdAfSAJFOxhKIeftq6PnAWcibz9Mslhd8eCtpFjvpCLiTdpQmMZSlWOOpGk3+ZU2Mwbxex9Ckal5GVwr/ucxegQQwocOq9FAD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnk1VaCs; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4daa69dfc27so155156e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712234935; x=1712839735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDW+rWUwlBs2jr/h4xTTDqP5Pco98DLtx7p8J/ZzVus=;
        b=mnk1VaCsT+DrkDCFAbjnInE8cA7VV/Vt4fcDnK3yTuQ4nPh3fSKkCVtzNnK3Cf3JjQ
         2RnykLQu1BpiTn6Wv+aUmmLed9AWuXDWxdww5ZLD5yExMm415sPePkyrVEAgMzIfdbr/
         Mk7K7huVgTdq7XZ2LoK0tO5y6L5MAqy9QApxsnCMg+FhSqeSfLe8C7Vs/qZXhUiOY83C
         wXOUe+SM/zpAtgcBacRNL9TEWDOoyTBSWJ+srzQl/JchDJ3EGvpwiS1IljIzl4LkXyq/
         A6uZJ0hSFmOrZgwHYBPY0VJC8BEYvrFIdcYNyuKRDGaaCLsa1x6qtlT0uLDsEqGrXhVR
         KcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712234935; x=1712839735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDW+rWUwlBs2jr/h4xTTDqP5Pco98DLtx7p8J/ZzVus=;
        b=tQzOoIMS4d7PGkbMYVjLAaPoX0W5LqdRC6tpiqC2IV6hbZwiUjnFpreVBRAX+TdrhG
         JvFu/Lz1LSmCXwnD7R5l25Yb5a4rF6dStwKCjs4cl17YFwGMTFyfbu0rG4K8L+oVZ/QL
         47cZ8+/r0v0J5W7aDs6UEQyNo0IHB2IF4odpXbGEaxwYj9x1XCY+A8U/pFZ7S+18+kUY
         7Zz1B38UwiJx2tueP9AniJ/mEY//FpMV8WDpF8vCfpR0Mf9XSy8RMZ9rO3BF2v9rg54r
         Dyy09mv7+bggIniwwVMnzeaPh03UUF8Drz4KVOupIIAqG5rrdUdgu9XMR3vxSx+4mHZz
         ukFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFXSQdArXxO4FftGA0H3tnAa2+7eHvj94Opk8vuvFa3TwTyUsmIm7UX75p3VBZR8nOJGiKiBRfWLHYD7t+39AgYVGcWW9DTxl4VUBg
X-Gm-Message-State: AOJu0Yz1opzuuK3ig6qWauX/8+6uHmCixsg5tsSkaFsk+rINOVHAdKDf
	5q5EiTZwAWXP906YL+sVBNvvN2kwMLnte9/Ljv/Ww4ZZ/dSGMvCvLHcJlX7n7Ozgcd/Jhrdwioo
	WlsInlodA6okNAl7/VMMteVaqtiqBt/p2RVCq
X-Google-Smtp-Source: AGHT+IHBt43zs+C9TqoUJqSvnZSsuN94K72cszgVwXZ/P+H9S6ThVSgqdaK2Haea8KCJbJ1OgGJTRLLQtqcb+3X0JuY=
X-Received: by 2002:a05:6122:468c:b0:4da:9aa1:dd5e with SMTP id
 di12-20020a056122468c00b004da9aa1dd5emr2612931vkb.10.1712234935216; Thu, 04
 Apr 2024 05:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328195457.225001-1-wedsonaf@gmail.com> <20240328195457.225001-6-wedsonaf@gmail.com>
In-Reply-To: <20240328195457.225001-6-wedsonaf@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Apr 2024 14:48:44 +0200
Message-ID: <CAH5fLgjCQNxnZgSP_fx0NKq9TRi-byRTSb4qL3n45yMS1zrtHg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] samples: rust: add in-place initialisation sample
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:55=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This is a modified version of rust_minimal that is initialised in-place
> and has a mutex.
>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

