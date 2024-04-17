Return-Path: <linux-kernel+bounces-148103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0D48A7DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A191F24BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A807D07E;
	Wed, 17 Apr 2024 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP6lFwJb"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E76A037;
	Wed, 17 Apr 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341283; cv=none; b=bWCicc6pDnDF2eFfCyBabFZMGGrMgbjf7QUXayk/jdT1Ugow3d2QjkH8feWdweieZFoGnqnBAumrh4HRwZyZhB2nUvFeEH4fg0X/n89HSTa1R2A7MmUxr0PyGfRhAK8I79/NwYSp4n33n0VPlYnvrisy+1Z1hIOJ91DQYzFHqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341283; c=relaxed/simple;
	bh=DHm8Ps55G9Fj9QrWrNjR73du8vQp5pj8qoxp4e93/lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IInerFekIqBJNUnysbHwV739Bb5YgcrNHEtolPOwAYdaoWW76YpcRiB4jDuqYg5+IEjhAgYGBhzc0YV+OdpLQ6F2j2OYVGu+ggat/ZI8aWzVh33dyJFfzDpZfjS+uaJct4jmouOtv0ew2UVl1UY7Tr2N3cL323kuQrWhJYQ85Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP6lFwJb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a55630378b1so6433066b.2;
        Wed, 17 Apr 2024 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713341279; x=1713946079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHm8Ps55G9Fj9QrWrNjR73du8vQp5pj8qoxp4e93/lA=;
        b=AP6lFwJbxgSFebDZiZ7DDfK0cYIVFTO3B4ja1ITF7GwnOS9Bedy+KbJqKuW2GxQIWt
         7CXEdA1cmIX5tYlQ0l9Kun6/wQuoBTlSfLq/ZB3ZTD+5OK6DG6cSSlO/gJlrLSfZOYvH
         XhSMf2wQAmY0LYFCS7gURPjd/KyudHde+fWqrg7ObWIaMSSlZTyuWtCxWx3IPrdbzL5n
         Q3CWV7SFNk1AeFuasldh7bqBIWxpZmAjGoiZ9MOtGjSMH73XSVnJvFD2kjbXOK9ZNTo3
         aYk8hIrTZrpWRfGU2PCI1LY3qV9wM7BQNbFuzsffAAomPZc55J+TxvlkZT4DXTeP+u93
         bK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713341279; x=1713946079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHm8Ps55G9Fj9QrWrNjR73du8vQp5pj8qoxp4e93/lA=;
        b=VdpwczBjnbCi54F7mnw35iJSX7TIAU5F441PhR68dMeX+Pc0apordeIQrd1cPWE8aB
         4L29x/iKLmk4JSw37ln7SW6sTfawOzYNC2IjWiVeF2rN7df/4urcgVA3FF0jnbozJvb/
         RrQYOMPiW8HMNhd6jLE+A35LyCTEnU7xcrSF3RQr+/i1GtrCshvdmAsr1+EFIdvJTBIs
         6PL0U+LJMpwjMvh3obWT0lL8YU2++zkEqoLoJ3fjEGwrgEIIEFq/pZHtTuBH52XUmWHW
         06QMWCbp/5nWUPmpcwRaSIdYBX5/EzPRM5o5dsd+4C1+WcrODWwGYVCo8X71uXjZWeGU
         2k2A==
X-Forwarded-Encrypted: i=1; AJvYcCUBcuQHCUN6KfFxXXwwAlnh+A1by0bWeNdWUdsQSJ0FYxwMBeWDb5kxxslCC0jf0qnztOiePP5fN4L9Mtx+ocnkccy3bGh1V4jhuLHNdce+rAIeaGH+ZqZ6PnPi/Qb4uZ8KPsdSvnDM7MQ=
X-Gm-Message-State: AOJu0YwyJElyihXW9MZ0+gQQ1ZUVXeR3yVD2D1aQYVYnkqhnimqHOuJ6
	U0ug/SjqNqQRvOqaHJJLPBLP5FwPQs/frI6Yx8uHZ4VnRt7bkr61tkhaaVkyCQhN2vajTsM2rNX
	fA69+r3Kv3XayXAYJzUlnA8Nq26g=
X-Google-Smtp-Source: AGHT+IEynMUl5J9HloIF7Lmmtb9Np+ui5Xjtf47XvRiYkRJSWfelm64saMncMNCznjQRG+iBvCfWr77dG8JoXMd7AzU=
X-Received: by 2002:a17:906:b358:b0:a53:4cae:e40 with SMTP id
 cd24-20020a170906b35800b00a534cae0e40mr4590024ejb.25.1713341279014; Wed, 17
 Apr 2024 01:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416212247.9949-1-tony.luck@intel.com>
In-Reply-To: <20240416212247.9949-1-tony.luck@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Apr 2024 11:07:23 +0300
Message-ID: <CAHp75VcQvNqaTj6GTNmhoMbTj-qbn=WX7OSuRwiPaFO5pzPd9g@mail.gmail.com>
Subject: Re: [PATCH v3 68/74] x86/cpu/vfm: Update drivers/staging/media/atomisp/include/linux/atomisp_platform.h
To: Tony Luck <tony.luck@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:22=E2=80=AFAM Tony Luck <tony.luck@intel.com> wr=
ote:
>
> New CPU #defines encode vendor and family as well as model.

Thanks, but I would rather see this using the following
https://elixir.bootlin.com/linux/v6.9-rc4/source/include/linux/platform_dat=
a/x86/soc.h


--=20
With Best Regards,
Andy Shevchenko

