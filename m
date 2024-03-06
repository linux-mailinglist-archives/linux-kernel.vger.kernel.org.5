Return-Path: <linux-kernel+bounces-93472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA120873047
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3651728618E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42205D499;
	Wed,  6 Mar 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W80DIZUS"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028A5CDD2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712628; cv=none; b=mNPA+bhB7Od7cjS0b3WqoUSOjxiFNZDWzbjD4To+Xn+pPau2wpt2uWiHuHDkrpAOvQU5yRK6z8HpsPCPHv4SGquth8HpYZLcvISA+PwZw+xQh6RB2GXYl7YSZx3hJMdLTsBKEPNDES90OBPFHVssS8r3tM5rsn3U1Q5ETRZTNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712628; c=relaxed/simple;
	bh=n1Tf9hxtEqu10nfm63QkA2qNS6z6lvtzt402PkuljUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYVC3ExTbjXS5b0Z5oy84RKfTKWjKl/QBwDnmei1kKOeEuXgVwUH6urxv0IJ2Dh1NbStH6ME2XDg77YPAIfkLelmreVdxGJcwroc5OBb7dXMkjAg3i/fhdMaw6aHY6iDyYln69DNNWigF5wND1RQWlxLJb8MPYIpnotg3OUp7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W80DIZUS; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60943ad307fso61247597b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709712625; x=1710317425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgBoqrOAgaLAPx7rydT1ctP3KqDR0Oo6bSo9imw7eG4=;
        b=W80DIZUSfRZ4eiwqDteSxRd57/lylfaBBWDRtbsK97oAmCTvBJcdz4oDnd14FPy8EZ
         drssEOQ1CgvTD1AH1nMz+HMqgOBRN1vDYs2xE8vCWBpV2VhOuIP2MjStlCitUBK+qaZa
         ku3M1JuEiEn9hUju9tNekENBJ2zP1kGLgcBFt4D2Aib4+ULDO98XGTZbwjoDYqkbFjvu
         q0rohf+r33etewZKgun7SH5MfFaMG9QHtkl4VmBtfCoCMjj+u/ycnZSKhGqLlgstsYt3
         JwDLe+PTDzGqJCbkwS9fqD4IMXH85N4rGOD9v9FVu6f6wTm1k69ZGGQd/isJT5o7l9Dz
         vkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709712625; x=1710317425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgBoqrOAgaLAPx7rydT1ctP3KqDR0Oo6bSo9imw7eG4=;
        b=SL5xGwRtmoieSnZ2DBUX0RIJgXl0bTraOLIsHi6tqOLCG4itlSyh2vDQmH0ytErMp1
         bAx28F6y7OVHoUP29xOkEvoYusyeT91LSICvTIxmTpcMWLMGrx6V4tzT8W2Und1axPzy
         389mnxneNgv0ARU1SEWoUSo3a2WN6JsFeV25LdJd/6RkA2PGQ5gEy2NDe9I89A65AOew
         N2S/22nMistAmTaDJG72W29zOVOACXWA+qIPw4TXIlkgvXtcmkrP2ZgCBJjQcMPZJu2Q
         QhkRQq1lpPEp5H1BFoDKCX3gxYFy0J7wYAMuvOGfAuDFJmMt7lWTbg+xbAqj3Hj5EHuw
         CmWA==
X-Forwarded-Encrypted: i=1; AJvYcCXzmaXcQOkGkQ3JkPvewaLa0GwYs39vIRynXK9/9AKaLYFBBkE7ZdNUGIwj1rMI/+seQsGkwq7Vo1cuz5fXwRq9lhR3yPf/puuR/OTd
X-Gm-Message-State: AOJu0Yw4stBz09Ww8g66+GEi+tM9BXwUXbCO3Of19NdQ/THtJwBwieNk
	lZpvpPb0UMRGfOlBycNr+NQBtE608N+ShvN10fFcGJXzSLzHP1TuhWWFNfw1qGbFTxK7FVh/7eN
	rL9D8ZSVXH1si/klZdP6z2Ro4Aok=
X-Google-Smtp-Source: AGHT+IGVq1zfcOq74/DXHH76wxegg0dwloHQshJNGoWrU1dFWyau1kRoYYEX+DYi2EtDlFpQV+30pS0NRefQHxnT+6c=
X-Received: by 2002:a0d:c7c5:0:b0:609:339a:b144 with SMTP id
 j188-20020a0dc7c5000000b00609339ab144mr13480009ywd.51.1709712625516; Wed, 06
 Mar 2024 00:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306041532.16985-1-kr.kim@skyhighmemory.com>
In-Reply-To: <20240306041532.16985-1-kr.kim@skyhighmemory.com>
From: Chuanhong Guo <gch981213@gmail.com>
Date: Wed, 6 Mar 2024 16:10:13 +0800
Message-ID: <CAJsYDVLHNODkL3zg-X6fP8N_FPFtReP_poFBua3kJHJ6m-a7Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] SPI Nand Patch code for SkyHigh Momory
To: KR Kim <kr.kim@skyhighmemory.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	mmkurbanov@salutedevices.com, ddrokosov@sberdevices.ru, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	moh.sardi@skyhighmemory.com, changsub.shim@skyhighmemory.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Wed, Mar 6, 2024 at 12:16=E2=80=AFPM KR Kim <kr.kim@skyhighmemory.com> w=
rote:
>
> ---
>  drivers/mtd/nand/spi/Makefile  |  2 +-
>  drivers/mtd/nand/spi/skyhigh.c | 57 ++++++----------------------------
>  2 files changed, 11 insertions(+), 48 deletions(-)

You should send an updated version of your original patch with
requested changes, not a new patch on top of your original one.
And your current patch is missing a proper title and commit message.

I believe there are multiple docs and tutorials online for submitting
patches to the Linux kernel, for example this one:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Read through the docs first before submitting your changes.

--=20
Regards,
Chuanhong Guo

