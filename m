Return-Path: <linux-kernel+bounces-125362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A9892494
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC72B21B60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6C913AD0E;
	Fri, 29 Mar 2024 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbwknhVb"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFEC13A271;
	Fri, 29 Mar 2024 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741779; cv=none; b=KSPkdzTVHB6JY/NxpuwcQjRMDsu3yUJvLfmBy0cK9/TAPRIO5njYPgG8T3d1ghnGbo8K36VeMI3I743KlCJyIWxsWx6P6jSBTKzOAtDxc+JY1fOvNHLbcd3wcPqu6/+9oycsgh2kGml/FPeL3aRYntqYk+KDdRRVpRz4nKSs4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741779; c=relaxed/simple;
	bh=o5qud3mWtVnrjDckKIcSTvp7DMPARKTVibRuo3L7bxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAT6xi3dHxD5ZNz3fLUkkUN0NPFX7igvMiJoI03K9q31e3nZ737lJzg9r7h9yXnfRK7PclSAuIcQmCxmEqn1jqQh2qxuKUNkEf3ItE8VRhbmSWjqftx+Scn1OozQ43+G1Kh62Q/FuVKDS6QFPl70tmNBjnQ2b2Zkqe6lV9sbbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbwknhVb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29c7512e3b8so1814714a91.1;
        Fri, 29 Mar 2024 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711741778; x=1712346578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5qud3mWtVnrjDckKIcSTvp7DMPARKTVibRuo3L7bxI=;
        b=DbwknhVb3Y3oUlDmGykq02i5950MyOGyRLGxbl2d8VZlITU1Z48HV913kiPokFqJcq
         gXzJapwBBEUsJVka1qet+uCNQ7Z6J1oEYrfW+FwefI2QyXZ5IEKHrBQEtuIxoqOGzqTZ
         e0rWzWMaPXOJzcZClsRhRgKsHJBawYg9M5bFJ9ewbnXZ9M/LxYAuDCTj0JWQHNiiZTo2
         SJzjS1jrpLChnN69KlTPhgiHziWPzpZTRRT3J9auCPDaJg6EnDeyKPQmomm+XJDTrK/T
         GS++h3ZNCwhMhzCzAP/8ylKp6llBvlAd0s4QHttM4yHzMfEiP4HyPmHMhQfkQLDtYI7I
         71hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741778; x=1712346578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5qud3mWtVnrjDckKIcSTvp7DMPARKTVibRuo3L7bxI=;
        b=CGpDh/BB+n8lrFYDqycJmV6B59vm3MSMYOe0S5412eAb0ImquRxMzo+gIawv69gq8v
         ++3ywJNxHSdHQBx9kJzfi6JpSGUFA5fYeC9qi1zHWi8KRp6j3W4ef3LpUDmp6Mb77EnC
         yNgbtDdeXuElM4qIFnRLq2EbCfTTH9CjqDPby/j5nSMR2u4G0JROO6I5yttAyq/GdfeS
         E0B2Al8WX0upIPcUiLJsWDdX1X7V8SwcnO0CS/ccKV+7S7vJZWGUNBK87fwSIRQNRhvj
         uoUdLCbQuvC58axJ9ScsaSvR4eN5pdc0XXnEdbdcxT7O9UEg66dOxBJt6aVkSO24FULC
         cmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC5kfGFdA2xw2tzAhjRfZgzAGmxMmkio5aALIvEhep2ouFLdj569yJoptwNBTBZzIrlKjhBvqVZNBjk5xp6VWgAImFbZjbjU9AoNHLmWUsu50i5TawGnhBeHLkZQBtjn1vkypgQaIJwk2r3dA=
X-Gm-Message-State: AOJu0YzDSKhZmABqPN8W1dfUY8jtnmt9iRx19on6MVRzsdVQ/mAeRlMu
	X6d7mPsvipevQZ8f3E1MQyswleQ4Ec9LGshwD9nd9RZE2aUOsTzxHmcNwS6XIbYHxyc3sUZiN21
	eGSPWDszzwnBaIv0CBS89hKiwk9s=
X-Google-Smtp-Source: AGHT+IFoq+BVUHSzqFryA4cVhLIETCieI3IbD9cO96joglRL4zZ7C0UiAyzLd6XtsNqtVNNOe/v1DWUBb+uzDL5RYLo=
X-Received: by 2002:a17:90a:8b15:b0:2a0:86b6:2e9 with SMTP id
 y21-20020a17090a8b1500b002a086b602e9mr2955844pjn.12.1711741777884; Fri, 29
 Mar 2024 12:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223163726.12397-1-dakr@redhat.com>
In-Reply-To: <20240223163726.12397-1-dakr@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 Mar 2024 20:49:03 +0100
Message-ID: <CANiq72=AVdw0gHfRug2cKfEXHnTJvU92SPt7YYZNnpBy19zvaw@mail.gmail.com>
Subject: Re: [PATCH v5] rust: str: add {make,to}_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 5:37=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> Add functions to convert a CString to upper- / lowercase, either
> in-place or by creating a copy of the original CString.
>
> Naming followes the one from the Rust stdlib, where functions starting
> with 'to' create a copy and functions starting with 'make' perform an
> in-place conversion.
>
> This is required by the Nova project (GSP only Rust successor of
> Nouveau) to convert stringified enum values (representing different GPU
> chipsets) to strings in order to generate the corresponding firmware
> paths. See also [1].
>
> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/to=
pic/String.20manipulation.20in.20kernel.20Rust
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

[ Reworded to fix typo and to make the link use the `Link:` tag. ]

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

