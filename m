Return-Path: <linux-kernel+bounces-111280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D781886A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282742851C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AB3374F6;
	Fri, 22 Mar 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3GbQ6/4N"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6521A0A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102687; cv=none; b=FA0f/k4/DJjZQ+sfGRvvM1JtvjYK6AbRYEVzjv9/7Ezbe6j7c9rAirtCoDF9+7DLrvYm3FXEMRINaTOV0/qn4vPw3EBTY2RTzX0ywLDjBn7YqCQ+GQrBhmpawlgnShl9C2KVfETmlJ35c4NIgDnQ83i8OrJqrBhywn7jFKtqoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102687; c=relaxed/simple;
	bh=Pvx75pjUmfAFix8YdtVQOmsT9EGDVWYx2bvbS3+FwfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i+9jerEE2Eq5PHvY/J24BY97nx1uxJuUx93+VerTITSUJRyrN51IzBA78Y4srxfbqIkQb0+5EFOH4aQEc/D6eJnPZuR9rktEvnMBcjLYroDCQobN/ocPM6WDZw40rvU7O9zHMgSZbg/dyurmmY96iqTTXrRmvysJsBisPeeYEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3GbQ6/4N; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd041665bso37289537b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711102685; x=1711707485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ACnQs7aBrEZBi3RLGYrxwrSPV2Zrt2coy5sWl3wY0QA=;
        b=3GbQ6/4Nq2m7q1fQ0gCoFAI0DNi3i+lJLYXtQoG9ik7oPnl8UtnD6PovuQLITi6JfM
         hOMdwyh2BdUbczT10C4LaE8S7Iv82eOW+dDHSFru6ZtUHcSIMdjJZCCeQI2lTpRpRZ+A
         0rHltXTFW1DAoJ5yjaMuej6n8KvzgThx2arFJV2ACvFanaG8/tJwbW0JqIwyOuKzJ7Yq
         lB6+133f1JzaANO2+PUKBkQM4LEjbBCgONYzqM+bi8EarADottlKAhOWjOHrb+UUjpim
         J+TgG/N+51FkcpFg6QTcHxzRBBOdxt+/2E6Z8uwLk4Vt85PFXvXAGXP1NOIzQo+phZ/C
         a5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711102685; x=1711707485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACnQs7aBrEZBi3RLGYrxwrSPV2Zrt2coy5sWl3wY0QA=;
        b=i57BOQLpk7RLrRS98Ec4alRwe7QN/MauufYsjzzniASXzCbotm2teJGxLa5eVXUO5h
         NDeeHnr4zP8M+2uMSTs+SJBCMZ4sQGv+xsM9AVn520k86KwueaMgCKM++JKzpUnVGaH2
         TNmkxsLy1ujYYWOtPfP+XkX9liWWQSmlHhJC0dJfG+SORuqN4698wPreJWHiLvt44mD7
         lHdpmSJ2P646sH32Rjz8ixTtq3QB9PLc7tSz36IVF2hkvmGJhpd2T0WdbKQTsMTm3TIq
         HzVfLQ3MUwRxmxnF1iqtUKJq7HLKeTJy4hd4OxmaXDKpdpfB2Om3jNPsh54wgASIVpSF
         U+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9pJ69bN/HWfhPjq/iMHPa7r0vTBrVVybVy47cEQ00Omhj9K363mZbYO5BNUfh/RumVeaPIV111jqvvjQMrdK/pc7yqa2uLmyYI7g/
X-Gm-Message-State: AOJu0YwhA9vC0KgguLspyY8Qw/rGnVywdlMrydN3o4ezVo1cdBVUhU6Z
	dvsBYzb3R6RnSinyQSdDeZJV0BwrL8S61tdSaX1G4rjA1DA2AayXfwXADD7n4exWS1jjiqLwz41
	P3xZ1XK8VyzCuXg==
X-Google-Smtp-Source: AGHT+IFFpd2y4r17dMtANQ7EJXXpErok7tREHxgAjPnoff6hqLaJf+G18lXV1ORhcR/6TZaKCbZ+5IgRff5HgU4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1009:b0:dd9:20d9:d010 with SMTP
 id w9-20020a056902100900b00dd920d9d010mr595720ybt.3.1711102685532; Fri, 22
 Mar 2024 03:18:05 -0700 (PDT)
Date: Fri, 22 Mar 2024 10:18:02 +0000
In-Reply-To: <2ecf6529-5408-4621-becc-2f30e1039079@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2ecf6529-5408-4621-becc-2f30e1039079@proton.me>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322101803.400735-1-aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: time: add Ktime
From: Alice Ryhl <aliceryhl@google.com>
To: benno.lossin@proton.me
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	jstultz@google.com, linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

Benno Lossin <benno.lossin@proton.me> wrote:
> On 3/22/24 09:59, Alice Ryhl wrote:
>> +/// Returns the number of milliseconds between two ktimes.
>> +#[inline]
>> +pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
>> +    (later - earlier).to_ms()
>> +}
> 
> Is there a reason for this function being standalone?

I think for a Rust time API, we should make one of two choices:

* Match the C ktime_t API as closely as possible.
* Match the Rust standard library std::time API as closely as possible.

This patchset has made the former choice, and that is why I went with
this design.

In the future it could make sense to add a more "Rusty" API, but even
then I think it could make sense to have both and implement the latter
in terms of the former. That way, only the API that closely matches the
C ktime_t API needs to concern itself with unsafely calling into C.

Alice

