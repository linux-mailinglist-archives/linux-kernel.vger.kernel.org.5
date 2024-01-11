Return-Path: <linux-kernel+bounces-22935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D582A5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3186E1F24060
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA0EA3;
	Thu, 11 Jan 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RcbXVhLx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468287E4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28a6cef709so523520366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704937658; x=1705542458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6u030KI6il12QBShR1lcsXxHEUIec68JdndFK14yRTA=;
        b=RcbXVhLxuTvndQgNP5zPdxsAgMaDGuIrCcY58ETZj24DXrGUjns5tAOIE10JNSbOtE
         tj0bK4y5NJLbW2AChovtzJRx7Wnxraziq1NhoxLSwX74PD910tmOpGvd6yeYhFaWTCTp
         +OQjUvQbkqV0fQNUcaAHRS1vEIStocxrTtvbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704937658; x=1705542458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u030KI6il12QBShR1lcsXxHEUIec68JdndFK14yRTA=;
        b=DG2rrx+cbtvfyAZuqdAaY1sSk4CpB4xRSfq9D2TDm2S5KwvrcgD/ie93MtAhMzGRkf
         Jdy8EwdlypvmYnLolXNlaZwmL+4g4kXhk9zJHxQdweQYd6fRr0zQ8AmclCGN7j3hETjZ
         UKrZ3DWLD2bOtzHRrdyT0PyARCoWePuU6UeL7NXPxi9w139wrpNBvbXgd/OvwJ1PapqY
         h8KwKF7Qg61tCaaVubh4yRQtzPTxHjCS6vrTQPYZpTRghadfzFGcAkqlNF1yG9jhOc0s
         /Vfwq43lnFuq3gQHZ+Um+dMqUvQK9XtbY/xmfoA1f8JCiJvxmfpC16nU9Cu3AWlQM1Yb
         NY8w==
X-Gm-Message-State: AOJu0YwaZeobvZU1Qs1SXedP1oExWHkGa0/fjTcAjYFShu2055pEfZvJ
	02rwqLsvCp+RiLNfvvThu1gojkunyYXNVkZP0wxHjjNr742l97/q
X-Google-Smtp-Source: AGHT+IHvoUM+vd3KYHD9sm5xm1zxm2Lbc7no81UXrpBm8+O40IbpcVfaBe8bj2bCZ4MYaA3V+VKkPw==
X-Received: by 2002:a17:907:741:b0:a2c:5336:ac53 with SMTP id xc1-20020a170907074100b00a2c5336ac53mr46067ejb.127.1704937658209;
        Wed, 10 Jan 2024 17:47:38 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id qk28-20020a170906d9dc00b00a28d1d73654sm9217ejb.207.2024.01.10.17.47.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 17:47:37 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a271a28aeb4so518674166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:47:37 -0800 (PST)
X-Received: by 2002:a17:906:abc3:b0:a26:8ee9:9b31 with SMTP id
 kq3-20020a170906abc300b00a268ee99b31mr175059ejb.4.1704937657031; Wed, 10 Jan
 2024 17:47:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook> <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook> <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
In-Reply-To: <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 17:47:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
Message-ID: <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 16:58, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> ...And how does that make any sense? "The warnings weren't getting
> cleaned up, so get rid of them - except not really, just move them off
> to the side so they'll be more annoying when they do come up"...

Honestly,the checkpatch warnings are often garbage too.

The whole deprecation warnings never worked. They don't work in
checkpatch either.

> Perhaps we could've just switched to deprecation warnings being on in a
> W=1 build?

No, because the whole idea of "let me mark something deprecated and
then not just remove it" is GARBAGE.

If somebody wants to deprecate something, it is up to *them* to finish
the job. Not annoy thousands of other developers with idiotic
warnings.

            Linus

