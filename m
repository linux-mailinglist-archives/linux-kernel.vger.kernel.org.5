Return-Path: <linux-kernel+bounces-37603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532583B26B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00BC1F25490
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B3613340F;
	Wed, 24 Jan 2024 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V5ub+sov"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EC132C31
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125317; cv=none; b=QLfqeXmirrxJFwGxuoPq35u103o0sYB1+k7qgmt6oZXpwZ5s1GNcWYWJOSBavQR7xUyxMeMnnwuNzJLyTlKDSc6CxF8Q2SvQYoS8vRVyxqWyzB/ktTgWOGdtYkwobhmHSt6J4UFUmVLqUkf15Ys0bdZZZfuntfuKufW3CAz+B7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125317; c=relaxed/simple;
	bh=ouJwYHRa4mmcxxGDuONLqBrc9eGAB9TSx7zyDOPpuZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlUsLRDLIuNtFv9o2Qh/0EpM/360X6NInAaWE/3QelFTW2McYNO39+Be0cVkmf7KfiyUd8YJXOcEm2804qxsOJZ2DrIJ9S4htxKfHs5lHpgfSiTK0fCabKv1/dK0krBDtcIPCqIvhT6jbWnh6pRtwJggwiDeQdTghyOPmu16J78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V5ub+sov; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28a6cef709so612190266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706125313; x=1706730113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uH4xyu20AZv2y9FxRkejBz/ztRhAIrUHK2zRol0B+1g=;
        b=V5ub+sovq3NZYBptrCECOob6x6h6EcgEA1e6g5WOaLPBI9iqsrCgVgofP4D2t6yM6R
         kPfHxOdo+oVd5T73X0pRpKil1nrBTLgZYlCuwDRo3ZMM0mnec+Fk8yFvqaFTE/VJ41Mw
         riBfoWBgIayi0koYFdAt8Z8MffXbA8AAp7qEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125313; x=1706730113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uH4xyu20AZv2y9FxRkejBz/ztRhAIrUHK2zRol0B+1g=;
        b=RUyYONEZwLUvL90Z0S0Gp9ZzE8nKO41+mdKtjJNSUG9MDnmuerl9hAG3qQ2b3s443x
         YKS8JveFs0JRf3DUTOfx7ouVZ2mOxol+VLNdNcT7UJAsNphIuLpvi3qFD8uUWI8J6Gq6
         hCES0fn5FIPyPrn/FuLROnHuyK2GtXcxC+b84uoR22PpTNmvIOQAfwx/toS4Pou6hKkA
         4ys2NYjfcL2QoL9zU6iP6HMjdlYgvhRFNMeqbVSmcb0fORL02Ok3zu6FPXkSALceR6pi
         vZ5HXOrN0Af+ksgpaWN5C8+gDRxtzUrhShnBuC6CB/UbgrEWbKO+pEx9pYo60TXna9Df
         7HzA==
X-Gm-Message-State: AOJu0Yz5YW5CVswjneCculyv+H/arCmaUo5Xsd+mIu0NkR+YVoA+AWHD
	9uYLJGpraOqt7BoJCQFCak4wWQAFx6queuEqvyryGFICv/jORXjBQ1eqriZX93oCzOp77sppdrm
	zAEfQnw==
X-Google-Smtp-Source: AGHT+IGANGpyVSmLrMJPYB1tDFnY1URvbqeR+SzRSairWOgjL5SuGVSiuIcZsn8N+OqwPlZ+XfgRrA==
X-Received: by 2002:a17:906:3bc4:b0:a30:df55:ef8d with SMTP id v4-20020a1709063bc400b00a30df55ef8dmr1120752ejf.116.1706125313303;
        Wed, 24 Jan 2024 11:41:53 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id ka15-20020a170907920f00b00a2a0212cfe1sm201079ejb.50.2024.01.24.11.41.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 11:41:52 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a8fb31fc2so5471034a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:41:52 -0800 (PST)
X-Received: by 2002:aa7:c853:0:b0:55a:6f4b:27cc with SMTP id
 g19-20020aa7c853000000b0055a6f4b27ccmr1999900edt.44.1706125311944; Wed, 24
 Jan 2024 11:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook> <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com> <202401241058.16E3140@keescook>
In-Reply-To: <202401241058.16E3140@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 11:41:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgEXx0m_eaeN5-DoZQxStF0pOLU9s3GkFbhBt-2ro3Ofg@mail.gmail.com>
Message-ID: <CAHk-=wgEXx0m_eaeN5-DoZQxStF0pOLU9s3GkFbhBt-2ro3Ofg@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	Kevin Locke <kevin@kevinlocke.name>, Josh Triplett <josh@joshtriplett.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 11:02, Kees Cook <keescook@chromium.org> wrote:
>
> Yup. Should I post a formal patch, or do you want to commit what you've
> got (with the "file" -> "f" fix)?

I took your formal patch. Thanks,

               Linus

