Return-Path: <linux-kernel+bounces-39154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB8083CB9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F543290D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3287134724;
	Thu, 25 Jan 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjQZ2xL7"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6CA1350CB;
	Thu, 25 Jan 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208766; cv=none; b=lyquZBUwVZcDyKVVYvxcuNFkC9sMSmUU1stMlcUad1Dwm1Ir3/MOufNjEuJc1Z2QGFrajdUTBGCeGeF+W8nBD7H/WkEOsGnuv6CkBl4MA4vIBD9nf+jru+0ZqRf9YpWh+TQR3sIEaYu7sNxVpuwqRL07Y2boJesmfyxdk2pxJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208766; c=relaxed/simple;
	bh=9TC5L7SsGud9PoX5lqIO+z4dFzZhiDP4gcVIzf6t97E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWG+zTmPzzgvJRIlDduzImyJJBNNuWsFvRII3cApHmjoC1yq9X39syV/NLtiwmosZqI0cPMZc1kbaB6Slc2jlRSzRBdSbe3DW7jovBPXQ55JNJUxBqKpnHKVGZNoul5Uax17l40eR80ndvCCabiLWDyQJs91GoPkF21B1t0uxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjQZ2xL7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf2fdd518bso16827351fa.1;
        Thu, 25 Jan 2024 10:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208759; x=1706813559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=048d7izM4Yl6eTbb1eftwVJi71Uqd0w2n0Eu3Ykko+M=;
        b=IjQZ2xL7p/neU7UA9WKfha8mwFUXXTQe7+7keIBTvI39jhXpgLEyAilj1QwTwOtUwd
         VcMFBG7RXvk3wQnU8flEWu6RRT+1uFE74+qds852QJiqjqPbXrxZYovTQJjfCt/bEx2S
         5yI6/vqlwU+UFzODaVJWwl8xVewuFW0R5vek2FBoKy5jM5UOTiB2LnLXuCBiL7Ak86aw
         j34X+KbG0AMhPu4C4XctbyUmZlc9hEZuCRXUV7SWDWMgkovVITNqW9idENllNnFKJXJP
         uBCdhvsNLnDGbWtDGWCyaq/ePku+c0LyIW0b4KLR0aotsE2kyFi1BEhSPqlV3g2Vmed+
         qFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208759; x=1706813559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=048d7izM4Yl6eTbb1eftwVJi71Uqd0w2n0Eu3Ykko+M=;
        b=BInGTb5yACTOLvDMb13ISy5FZGBYzh+TMciqYVGSNexzboefNmZSr9oJ4no/Mvxs4/
         UxHC6+kpDvHq3sgU84myhbfa7FyLzSfg6uTK2rLEfbfReayQWGtFDqce8hH38Ex2IiuJ
         NtIV0pgftSGUPYn47yodWw2WTCImT0DHto2K/sCTaOv+36u7+O+aCRUAwZdlqApBxcCH
         aWrS8B0TCaQpbo6dCpWlDcXclRlBLUCe2zqBOOHZNLN9migPVbL3BM7ICSIu5mzxOKsr
         6KwVrFbhy8bXaj51CXKbrJ91b2rp81tq2SFVgXQl4+2DIq3uo1+IfZ+MNLrPejMDCWOY
         rD4A==
X-Gm-Message-State: AOJu0YwdI0rBMfs/vH4AZqz2/CsAYIlO0/5zgmsmltnB8Forfs0s2Ek7
	h8VxwAqAiZbYm6NS6i5DvzU3rR+scKs+2D4wJ+b6LhOnRkEGOETCqC0COmUnmB4xzE2AzFRNU3m
	CiOMNWs9F32wVrkP6ckbOkRhVFVpfvQnQtj4=
X-Google-Smtp-Source: AGHT+IEzQl2KNeCJdNE0dvb3B3KaO9UwIIZk774tMe3+opFEMKKxVdZZ4wTPLxcWN9noVwpW27jndvyjg8yaBHXNiZY=
X-Received: by 2002:a05:6512:3d21:b0:510:17b1:cfdd with SMTP id
 d33-20020a0565123d2100b0051017b1cfddmr118605lfv.67.1706208758682; Thu, 25 Jan
 2024 10:52:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com> <20240125102555.2621736-2-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240125102555.2621736-2-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 25 Jan 2024 20:52:02 +0200
Message-ID: <CAHp75VfL2n-zn=cSPULtu1_uRuTNrgtLnJCpSxbiN6xxKzc-JQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mfd: cs42l43: Tidy up header includes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:25=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> Use more forward declarations, move header guards to cover other
> includes, and rely less on including headers through other headers.

..

> Changes since v2:
>  - Added pm.h and regmap.h back into mfd/cs42l43.h

Btw, TIL that your v1 was fully correct as there is no use of the type
definitions. In case you are going to send v3, you can use v1 of this
patch if you want, this version is also okay (as we have some more
like this pattern, which probably needs to be amended in the future).

--=20
With Best Regards,
Andy Shevchenko

