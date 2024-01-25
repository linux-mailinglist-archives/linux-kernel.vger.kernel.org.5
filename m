Return-Path: <linux-kernel+bounces-38236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F292C83BCEA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E74F292570
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16EA1CA85;
	Thu, 25 Jan 2024 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYEZMrn/"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D01CA88
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173729; cv=none; b=OvR5WGRrzyhJO5RNkFv49neE/kDQjp6+ZE4LU0nwq3aYUSISPsIn89/jdcebseStZZNgrBYAZI6Bguj3KHdmjlLNFNJWYAj/oYCmcojtaeV301QiCCJMsx5tILo0dkiAtr3x6hobQWukvcYC+EDB9zysBd4TcU9lQzhwK1CNZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173729; c=relaxed/simple;
	bh=DaaeOBTj4cHWJG3k51yGq2TD3ACFmgQSxId2jEXJNmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2J+H4T+Sz54PXp+tRP+sjcVC9YDV5PUc72ggoehIaXH5cEzSH7AQ4dpic81pX1sR+3OnYrC9qXG54L8/JcCXxUksu1Wx5PJGpNhiqoF86l1pXkIcGLvFmxP90c1Q4ArlGv3kmzXYC68eR3lqztPhso+1wtXX4RmWyEoCo3rPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYEZMrn/; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7ce603b9051so2098092241.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706173727; x=1706778527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tM1J8tB5KHoGKyoGMxs1iTWky7jMmTAuWrPlK6yjZI=;
        b=VYEZMrn/w1Y+q+tII5Ztg+rUP6CgPvjD4KSAXL+fjScAa9oF1WPVmFBqncscFjW53o
         68jPvmgdShEzV0g5M2BVRPyiBi3aITrNB/0UBOt7limLRThrk+mduI1NaGAREYIN86QO
         YZQXjpwh/36pgvDH7GhQbf3rJV24sOPptHhXMXMUgnhQMFFsv8hpMFBBgtRXS8T/noDW
         1GwTJUP6loW3Er52eB4kJpYd76oIuhzSMv7ta2tLFOYZXHSUB4cNKOKVAa//veXEKfUo
         cc2KFzql0/dpdtatp9OaZtOdRi+T5P8AijeW3WVPkPwVwQ9b1Bo/lkdfDywR7tibK43z
         0fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173727; x=1706778527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tM1J8tB5KHoGKyoGMxs1iTWky7jMmTAuWrPlK6yjZI=;
        b=H8FrW2RpzLiOp7yXaaY1EKU/ri2mwUuwXC+Upc8+8uwC9m3wMUZXoA5UHBcCFAygXr
         s4Qpf3AU+sFQGMeGI6pXpKA37G3hhVNDgv05QzNy9HCNItKN8vzCJIK/b4Zce2o77IoK
         hRuJVQvxIZA2IUZev5anvaFswYHGiiUT/tdnfPPznFHUTvSQa90gLu3j+pjVpZL88RB6
         wRUd4FcM86Nfj8QsJ3bgIu2rxDHoJBCfbOogljIGqNZInHZ8JO+4jQARWRaTGqOmkCiS
         t/q0j23roHRbgyaLriNrNyPcwOrkYVR9pBp7oxMGge6mN8gENWmrhEYvtGlyL6ztqSUW
         BQIw==
X-Gm-Message-State: AOJu0Yw1s5qlppFNg53AprmjYY1f3wxdn2u7MAUdc4cZGjwzADtC7vni
	63wh0uWmXN7ruY4NUxWoCKlE9hGNB2a6OLEcjcDZn8QnQoSQ23N8dzGmtABBmdu9/TTQefV7Y0H
	QqRIJz3aPEQH55/Hxv0RgF5XKw+p15Q4OfT/S
X-Google-Smtp-Source: AGHT+IGoivSgrVAUX+nyt4dYy58T+ARTSwUUH4QXRl+s5E1AKpYQyYWAi8S3TfHsuXa8DFxFUmruioIfLZcGmtI4GWg=
X-Received: by 2002:a05:6122:380f:b0:4b7:8e5f:7782 with SMTP id
 em15-20020a056122380f00b004b78e5f7782mr413172vkb.8.1706173727304; Thu, 25 Jan
 2024 01:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122184608.11863-1-dakr@redhat.com>
In-Reply-To: <20240122184608.11863-1-dakr@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 25 Jan 2024 10:08:35 +0100
Message-ID: <CAH5fLgiwRDcyaxbcUNY8M1c_w11vkCWyRfqVVrN9Sgc7XYT0xw@mail.gmail.com>
Subject: Re: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:46=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
> +    /// Converts the whole CString to lowercase.
> +    pub fn to_ascii_lowercase(&mut self) {
> +        self.buf.make_ascii_lowercase();
> +    }
> +
> +    /// Converts the whole CString to uppercase.
> +    pub fn to_ascii_uppercase(&mut self) {
> +        self.buf.make_ascii_uppercase();
> +    }
>  }

It looks like these methods are defined on `CString`. However, there's
no requirement that you need *ownership* of the c string to change its
contents - you just need mutable access.

I think it would make more sense to introduce an `impl DerefMut for
CString` that returns a `&mut CStr`, and then define these methods on
`CStr` as `&mut self`. That way, you can still call them on `CString`,
but you can also call it on other mutable c strings.

Alice

