Return-Path: <linux-kernel+bounces-154213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2ED8AD95E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7AF1F22BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B848847773;
	Mon, 22 Apr 2024 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="luwKqjTh"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27F46522
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829961; cv=none; b=mN8u+eBDGU7kdAmYPjdME8DSgurjaA+tdSq3aAnrWe0xFihseI2e0148ii3Ctkns1AhO8UziC8B3rZZRzGxVMhL3SmaVeMYBuEfHbr02gM7525EfINz/y73wi+XvMXt141XjOsrZjCrZoeO89fWTWscIBu5+qIx0rRePTQDtMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829961; c=relaxed/simple;
	bh=HCos0K+i+5RXb5PiJarcva8R8QtYBJwW3vScJm07fZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POb7u40DgmLXPwUGHBUVFUtdUpNJnrYWZLNocWUhaWdNTyT7B+809PA+oQ4XG9DeqmbhNrTn+WbgMkD6tRRU7ES4G5/q3uGwYjgDlZ/eQjWPR7dRdTlVg7WhBUp82hSbr8lsRSJ3DCOz7k/kWFbIThBr1tU0oF/2eIQXxKgtsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=luwKqjTh; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c730f599abso2953415b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829958; x=1714434758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK1IULy+gt9h3QAWRMC7n0H7pNm41l4ocPRhnJtOinw=;
        b=luwKqjThq2dVPhNvaRCx/r0V+7xp1DtacYT6fwgXZOpoZCaYuk+ME3UC4+0XQsJUVL
         VyGpEwwryqU9A+VTw36bKegk8KC+4+ZiuUJxekUKlaWUIzIsQ/xXI3V8Sz2g7YFhfH6+
         OrYR+Uo3wszyup/WJSCzNBQY0/RA6yNlIpZ04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829958; x=1714434758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YK1IULy+gt9h3QAWRMC7n0H7pNm41l4ocPRhnJtOinw=;
        b=q6QJkdT9nnX+09CH3r/HWz343DFvBrPRkkUk6p6sSbp84vyAvCauyL7nt29rTZF50Z
         /ZS0QSrPMPunxIqt7En+H9r13XipTkN46iec1EPFBPtQAfnlr+y//fz8TEJAkV0Y9fSX
         LRH/fKY5PGHrn8yJ1buyj4DQPMSjfvKadD5RtBMu0Rs/6m0WvV00zAUriNJtA6WqPmxx
         P2ds9NY/mq1ielJQOeyVLR84OmMTdV/fT5LaMPkkazO80OVlfLZLBR/Xk7QXVAmmNpBP
         NPYB3aGp8iElb233bFHMUfsMNPFK/bYF3IyxhHB9RLGcbCPxDf0xbW0SKiRyMJ/QKwBe
         Xu9A==
X-Forwarded-Encrypted: i=1; AJvYcCUGYEY0h2e+Jivtmi4mrnYXZG9cf+Q+8D5puFvhhZaf8V340ySse8kUKDQ7HlRQdFVJ8bq5JkpsuZi41YBsDgXuNwpF2WEVI7iOxtCg
X-Gm-Message-State: AOJu0YwPjHO3SuUkuWQVXshAf7tLhu/T4dw/+8ZgR5XBP2a/VtnSsBCJ
	mKEaWkvVg2D2N1o4BBED7ODFT7Qxa58wBcm3mXTu7juYOSCuJ7zjP+HOlzFMqfa35k7HUZzrQQe
	XjI9q
X-Google-Smtp-Source: AGHT+IEQ/CB8uzSzhoVHMP5DfUMoawpyNkdt8sc+ZEHsH20f1qVcmKqRAGVwgD9zRhxyFCX0kApqTw==
X-Received: by 2002:a05:6808:298f:b0:3c8:297d:ede9 with SMTP id ex15-20020a056808298f00b003c8297dede9mr7417411oib.23.1713829958239;
        Mon, 22 Apr 2024 16:52:38 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id de28-20020a05620a371c00b0078d6b2b6fdbsm4708260qkb.133.2024.04.22.16.52.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:37 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-436ed871225so71731cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0P7Ms9BYDNbghzWfxMob0TL6/yvSz3i1e5IHtLAKx/mZ1UIMwWy8s0xPjbb1ZPjXBP7UEe43VGBi7OS1XgC3a1J6oMDIZwcD6/whK
X-Received: by 2002:a05:622a:810b:b0:437:74fd:bd26 with SMTP id
 jx11-20020a05622a810b00b0043774fdbd26mr119139qtb.14.1713829957071; Mon, 22
 Apr 2024 16:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-4-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-4-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:52:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UnvAxOmbM50yADmzE7qgCZXW-Y+-jAQ3ngO=01=m1fsA@mail.gmail.com>
Message-ID: <CAD=FV=UnvAxOmbM50yADmzE7qgCZXW-Y+-jAQ3ngO=01=m1fsA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] kdb: Merge identical case statements in kdb_read()
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:38=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> The code that handles case 14 (down) and case 16 (up) has been copy and
> pasted despite being byte-for-byte identical. Combine them.
>
> Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug=
 fixes
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

