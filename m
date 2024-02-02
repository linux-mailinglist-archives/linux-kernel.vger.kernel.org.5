Return-Path: <linux-kernel+bounces-49038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB3846520
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4658E1C244A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4F86AAB;
	Fri,  2 Feb 2024 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rv70nKob"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDFD6123
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706834610; cv=none; b=BRVuVEM0bsRF15t9XL0M3v4mEF8ZD5KbAd6pmCpqXoD7+JUG8PNWn5fqG9ERz3HSPf/wHfNaHsNsuvfJjNHsxYY41iji0PKjkCtwlSySYx8XpKA9qTZjW7G1acBoTdHFw5UvrDMDXZBjNEQNM03lxz0cDBwVliU1QDUlTjc2Kl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706834610; c=relaxed/simple;
	bh=Oynm7sfNLrQLM0SoccN9kTL6l+3C1N0AOI3Ym9MXl1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+jaQVpLLCpcUgorlqsuc2nHhE5wfIoXtaa5dCcK2mKFu3Jp7cwoMFQDtDH2D4fLwa+vdTulueoRULQhVdXOZu6BJyrpXitrbakSJUK3F9wgYlQNiYPwFGcDTcaT5U9aqrj35HTe6dhuJ13C8FuMCBNiHjgJ85TVUnpwMKcLhb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rv70nKob; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso5179663a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 16:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706834606; x=1707439406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lRP9qwe+sUPjtBWfJ3OqdoHfDLUo/SRZ2WJ6sssDb3g=;
        b=Rv70nKob561Z1DFt6ZDF+pM+f2Ri9JlWWOzAzJPGuzdabeKpZRPcgObBqrqXURLyV/
         epvzEWzEH7WassrGNZDfEa8XSv0Vq6gHqEF8kjizTREXSQvqqoSd5HOmUTsjnDm+JogX
         6DpaFeEeKx/3+8g2FT0i9RHUewfp4VkgiQ4s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706834606; x=1707439406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRP9qwe+sUPjtBWfJ3OqdoHfDLUo/SRZ2WJ6sssDb3g=;
        b=PKL45c3a3yoFpGS8WH7+2gUtVbCqeD5ObzTUKidqKi+kcGmOIMW9fE0g3CgKT+G+8G
         bv+MbuPkQQx/Bo+DPNM9IurNOtQbyjd3nwARM6eJFYdNUm/e1MJpKH6pGPIIxwHNftbt
         O7ZL5lM9rwvJ921k2UF3aJPwcfKrIlLtZcAXqcnyf1cqdNdX3N7D4slCiBOuWDuB9ZIK
         I62amFOR0aZp4gVrZVkXQ5xgMiVpq85bHo4LXba2GHlORe3WjPiSWtAKn4pwBmqWUp06
         PGtUAaJHsR6mu7K4QnotlFgVC6S+U2a2MTzkVxLYLWr848Z+3FZD4h7RrWicb1rh88Rt
         QkOA==
X-Gm-Message-State: AOJu0Yx1rkpJv/iBPzsIMARaV9KuVEXMpGLnANIftcTwh+xEcLTET+Rj
	ScAL2Gc1UTzPyoB1LCaw9oQSQin86RvdVb9w4r8TYmpgDImKkvV70RBoulKnJ2pXotBByF4jwwD
	Y/DetRA==
X-Google-Smtp-Source: AGHT+IH32eT7mqtniUASVZbKPhQNB7lX9dgY7DdoDgszb4UhaS5nT9sUQrLgGiJyirm8GqZ+9PEjng==
X-Received: by 2002:a17:906:c35a:b0:a35:bd6a:60bf with SMTP id ci26-20020a170906c35a00b00a35bd6a60bfmr460781ejb.17.1706834606206;
        Thu, 01 Feb 2024 16:43:26 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id x8-20020a1709064a8800b00a3542a13eb3sm304515eju.138.2024.02.01.16.43.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 16:43:25 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55fec3f2f9cso304176a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 16:43:25 -0800 (PST)
X-Received: by 2002:aa7:c690:0:b0:55f:a38:a4f5 with SMTP id
 n16-20020aa7c690000000b0055f0a38a4f5mr530483edq.11.1706834605114; Thu, 01 Feb
 2024 16:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
 <CAHk-=whJKZNZWsa-VNDKafS_VfY4a5dAjG-r8BZgWk_a-xSepw@mail.gmail.com> <CAK7LNARzZ07TX2obHSpCgsC=FPTbLx5J+kPBFUECT+N7V42i5g@mail.gmail.com>
In-Reply-To: <CAK7LNARzZ07TX2obHSpCgsC=FPTbLx5J+kPBFUECT+N7V42i5g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 16:43:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+3J8L4C7dcsZZNPEr3CJ49wKtJC0taVDBwGo9ZGot+Q@mail.gmail.com>
Message-ID: <CAHk-=wg+3J8L4C7dcsZZNPEr3CJ49wKtJC0taVDBwGo9ZGot+Q@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild fixes for v6.8-rc3
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 15:57, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Is this your expectation?

Commit 82175d1f9430 touched *only* the nested 'if' indentations.

Your attached changed other indentations too, which I am not sure
makes any sense.

But honestly, that whole make rule wrt whitespace makes no sense to
begin with, and I don't know why the conditional statement is so
special to begin with, and why GNU make would then suddenly start
messing with an insane rule with bad historical reasons.

End result: all of this just reinforces how bad the Make rules for
whitespace is, but I would suggest doing the *minimal* changes to make
it work.

Which commit 82175d1f9430 did, but your attached patch then does not.

IOW, if the whole crazy makefile whitespace change was only about
conditionals, let's keep all the stupid whitespace fixups as purely
about conditionals too.

             Linus

