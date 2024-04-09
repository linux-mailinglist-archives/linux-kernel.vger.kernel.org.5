Return-Path: <linux-kernel+bounces-136156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E289D09A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B991C22379
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1DE54756;
	Tue,  9 Apr 2024 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bOeGMoWd"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3204EB33
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712631720; cv=none; b=CN9vr7tX0/gSMd8USy+3HtCAZB+eN6vmNZAg+S7MqmUlp2W1yy0JQhqupEpo9CdywRnrVU4maIMyUHCRzT7slAnHGivq3dTytS6xPcZlpPzXAdliG7A+to0SnijIcSpvO+wky83/3Wl/vF7zaztuzxxtuBYCXfzOTyIOLmN7jXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712631720; c=relaxed/simple;
	bh=mMhjxCCXtqewYhIaOMBsuZj2va2Oyrp6d//G8WU88iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBS1EdMo+cr6gH5sT62nBEbaFapUwPSVZ9kMIslH6EpkESjPHQF/ZDfalEweceBBStlfMkWmNxySmvztJcFNt5abKQWDq0YCf4Dt7g6kv0OE/wcK1UuATAqebzAK+ILiEYKm8YmIARzdemyjoyq8PI0cOaRwm1AK5/Arq7vqIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bOeGMoWd; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-617d25b2bc4so37873207b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712631717; x=1713236517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMhjxCCXtqewYhIaOMBsuZj2va2Oyrp6d//G8WU88iY=;
        b=bOeGMoWd3P+QV7H6RTRSVoZuylpQUOicI7k4+Wxhx/P8Rtrp063aQ5Ob2Ymyp1UuVN
         90b6acp+ZetHvStVAtUWvKEhCEw04JOHkcmznG8TGfGzU56D9z+R1pJcmTsPRcyOyUYj
         1rz/G1qaFXCXag5ABZD/WBdPlBf5U0ngbnlpw6UW86lU+kKovbKnIp7TcE8RX00jZ6/J
         ouQR0Gu6bTQdWvf3FAeSgEVTl1py2MzmPzvJmaeEueyb8Ax7M8XRMkWmlTjtJH4Kksgh
         TH2qY2xvb9cItHQpgbx0+2AzZZU7/3W41NpxzGtQNtI/KMQ+Mvm8XXI/hHoyOJFmq3Sj
         6XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712631717; x=1713236517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMhjxCCXtqewYhIaOMBsuZj2va2Oyrp6d//G8WU88iY=;
        b=FnnEbkbD0xY8dmLsseNJ7fEK/Sbw/o/P+Ymp+eBSa4Vl4GChVM1EoxCKdNEQgf2HyK
         bJ9fdJxYYLSViEffRsaGGZFhhorjBH9PTPqQbKVSU6ADo6UxIkiIoRvgfcqczPiIobtJ
         RFgFJJPlEaIahxZ6rcMtWKK1iMuRUjoNmm+qpq4saQVVRHHd2scBomIkXfXMwk2FME0P
         wAQdIAoGVjlnizADGdHhamRQKwDJpWnbuhsCrLS+i9K+Ayksj/Syj6CTjX5ezqcKkLZF
         vj8734BVWLfgw03qGbMzEqdiEGObUFrvi3WopUdewU7t7OZQ2i9kwvEr3Ep7wI5/7RrV
         qFqw==
X-Forwarded-Encrypted: i=1; AJvYcCVhUqhFx1WA5ar9iecfI+74zc1bxlSqk2A2VmrkPLhgwD15pVoX3hQ5eXOK60oMVWamPCcRhhyS4Klcj6GDUN9rEVfwqNC2rWfsC/xL
X-Gm-Message-State: AOJu0YxS8tgSRbXzzlwgtvIQJyKeOwQhoSsvhvPRq8c5qsXg22zJBgTw
	baLbGzRPVoB9eFEYxu4tH5Jy+RiCQJZzvQ35QveOjr4zT6oxYEyJ5wfaOdMGgxEPhV71F4bitlA
	oMSaxMxDBDLY2CrwXnYzMDSKxTPJNrG0aI9GohQ==
X-Google-Smtp-Source: AGHT+IGlMfC7YmTw0Qwgs8NfQmPIC72Qt4+rc4wZc+lexO5+feXuB2iXYRklLy5rm87lMCCLYeUbAGlgnX6g1UFvvus=
X-Received: by 2002:a25:eb0a:0:b0:dc7:497e:cddf with SMTP id
 d10-20020a25eb0a000000b00dc7497ecddfmr7972914ybs.33.1712631717011; Mon, 08
 Apr 2024 20:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com> <87bk6pof1t.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87bk6pof1t.fsf@all.your.base.are.belong.to.us>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Tue, 9 Apr 2024 11:01:46 +0800
Message-ID: <CABgGipUQ4nQSpKFEbpXvcf5n7Zkbh-HQnky1H5GeEvKw5OxSfg@mail.gmail.com>
Subject: Re: [PATCH] riscv: selftests: Add signal handling vector tests
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Vineet Gupta <vineetg@rivosinc.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:47=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Charlie Jenkins <charlie@rivosinc.com> writes:
>
> > Add two tests to check vector save/restore when a signal is received
> > during a vector routine. One test ensures that a value is not clobbered
> > during signal handling. The other verifies that vector registers
> > modified in the signal handler are properly reflected when the signal
> > handling is complete.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>
> Nice!
>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Thanks!

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
Tested-by: Andy Chiu <andy.chiu@sifive.com>

