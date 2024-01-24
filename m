Return-Path: <linux-kernel+bounces-37654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706CC83B318
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2309928856A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD87134734;
	Wed, 24 Jan 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk7zXi2M"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA9134757;
	Wed, 24 Jan 2024 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128309; cv=none; b=KbNnpGXOsjLjRIdW+gLCOybKFI5V4XJkU7Rv3t/vI0FUu/viIShLl8QvWyA3i3d2w6wgpd6aJG/zEqlKSU3ffsH35azcMf0nHJWPvaYx5GavxbRGn+Pn3+wDnyoPClZyMitVJ5Az8mDsHkBt5q+9GJ+G4mIxnW8/9gJ3B4O7WK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128309; c=relaxed/simple;
	bh=8jgRx1Ebpfo3V8P6upG202YRHaUAoTVmSD8UvYQ4OPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5Ep8Er/5YuZBMqRJ5D+VHggUTmXQ+79I+OBGg05+jkufSb5iLpsGK5TMsVhaYbTwioJ1DtxOvRxCF7PyCGkXRIUTrf+nAlQkYKWOC3aIkBCCmeH60QdSPJ5QBPizOKLFSjxgRikwKnwha0bMRGteWOCll06gtI568zH5HWTFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk7zXi2M; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so7458671e87.0;
        Wed, 24 Jan 2024 12:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706128306; x=1706733106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jgRx1Ebpfo3V8P6upG202YRHaUAoTVmSD8UvYQ4OPw=;
        b=jk7zXi2MOjxjXpz8PSAIwBH2zRfDk1YtbHwGfOXjYkQAA8cg2AxmJL/IE97NlJs8zE
         QAcuowTYjLKPwYwENuEKws1so7AwCaTmzEeuRCPmIuhqOWnTZFer5AFf4VxqXLmgnaF8
         kyQvwcTJiN2xYJWa1o4q5Cm1e+DfJft1wdSG2uU+qpBIGGgNtLBEftpPsT3ZJ6Jj3/i7
         Hwa+G/W1yYZH0gBw1S4tzyr2IYCFvtXRrhz+7Ve5WdpoQGvnkPU2YqUW6mnXKrADbxb7
         Our++8VELuI+G0o+hMCJvdTnssxrDPbQXyR7z24h/YgjWiMi7U3Q78L/cZxy1e1jDoA4
         5seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706128306; x=1706733106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jgRx1Ebpfo3V8P6upG202YRHaUAoTVmSD8UvYQ4OPw=;
        b=HFLH7Ext9GJRZIzpvimu9NrLyndBxGU3Z7y0IptFqfMz3V9VB1FPsO0YGbqJlGL8+k
         P8lW1VckDICiflzzbKDk9ojmQEX4vZOqGMeXrD/jzzq6DIgEbroJQp1RUMTyN6JyCfK8
         L19bae95ToYOyfMYd54TvA9BuYuhO9YJzHiinSBtzwp9dD1plm+Y0RFtuAZhMvKN8Mfg
         aWH1CwbfoWOfZMr0G8x2Aw/MYV8soBFN6e3W/qe2mX9pA8UbCB1WKtyI9R7FbwCBzF9Y
         cV0PBH2v6kUbLZef01bF81RTgJQ6vS8+FLAqRL/VNl4uefI+QYlbr6eJVlV6N6tg+A2E
         xbwA==
X-Gm-Message-State: AOJu0YyxYgoqd4allCh7fhvL4BRltioJYpXzXuhPE8GRGFs1oyaolhz+
	wfrk5DnhnfFe/M8BGDo0jbExMnPpIzMgCLbG3a97NVhMbm6pNmhmEkz6dyepCgLuq3BU3nfxSFO
	DDjNaQEMS759pJqohdMQK74lAODBRlqqxdIk=
X-Google-Smtp-Source: AGHT+IEvshG7K8I4wt3i9BmnCXK/Qng+RZGZX7HoIcZS4rZRpDxHgjOg+KutOqFsoKKEZMeTiY1lLHcxvLkKAYKIwH4=
X-Received: by 2002:a19:e016:0:b0:510:16f3:8087 with SMTP id
 x22-20020a19e016000000b0051016f38087mr326122lfg.32.1706128306118; Wed, 24 Jan
 2024 12:31:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124151222.1448570-1-ckeepax@opensource.cirrus.com> <ZbEqpbwTOlWBHrL2@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZbEqpbwTOlWBHrL2@ediswmail9.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Jan 2024 22:31:09 +0200
Message-ID: <CAHp75Ve=iuDBKVLFNr--zVUnfASXWDUMoYoOzoM_6tsf0YkX1g@mail.gmail.com>
Subject: Re: [PATCH 1/6] mfd: cs42l43: Tidy up header includes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, broonie@kernel.org, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:20=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Jan 24, 2024 at 03:12:17PM +0000, Charles Keepax wrote:
> > Use more forward declarations, move header guards to cover other
> > includes, and rely less on including headers through other headers.

..

> Apologies Andy, I forgot to CC you on this series, hopefully you
> can pick up off the list, but let me know if you want me to
> resend.

Suggested-by automatically being converted to Cc, how do you send your seri=
es?

P.S> I saw that you sent a v2 already, am I right?

--=20
With Best Regards,
Andy Shevchenko

