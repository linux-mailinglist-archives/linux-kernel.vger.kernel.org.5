Return-Path: <linux-kernel+bounces-122614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86888FA67
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD17291B40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7A454775;
	Thu, 28 Mar 2024 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4OWZmKZ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76F57885;
	Thu, 28 Mar 2024 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615940; cv=none; b=C++Wt4Nt5zugBFZ5osAQsH8Ajv8sx4slN6uwHhvo1clI1Cyke5+pU0Go5r5FqDoYpLyi2f5flEJRfC5Uu9scjaPexTlqxHAWGL+0sy/+yk036URK9hUiRoLiTnzrbUxviFLpkd8lkLQYPU8zb+BtqLEu7nOd+xZrfy+urzsBFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615940; c=relaxed/simple;
	bh=uRSq3PbyalaTRAGpYMw/AwJImnqaUQvuvimLCkGiocM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfMvslhv054AjYfT2iw1dq9A347wQyoMgGctDP92UTMvCXYTs7v/mDzuEYK6l/q7aKFtKDSpfg00zZsq48bVfzwlOdFYneZ7C917m2ScBO63InsWqQ/womZnO8KZAHkS5hnLCxEwNfFio01WXUT68BEFOakL0EVB6zRYCVsi80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4OWZmKZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso998381a12.2;
        Thu, 28 Mar 2024 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711615937; x=1712220737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRSq3PbyalaTRAGpYMw/AwJImnqaUQvuvimLCkGiocM=;
        b=h4OWZmKZB2SC2fCyJSXLX94lgiKjUtxgq9GV8R2kdsVpraDEVgmyoedKyoO3uoLhyn
         vo5buAzCjo0ffHMIOq3noT4UgsWK6kg5Qaxy6EERLoBV5HsZw9uDSBj0UfBB9JaE2rnx
         kI/EUUNPh1gV1E0I3mIsuWkhOEnkcV3FNCONTd+XtvPY9t+HKU33EGu/vOV3p/t9ARW9
         pgpa48Eu0r8sdpN8832d1xyF2AaFm/Tzxba0ncDB5udPja879Bu0BKL1aJD6fTiAMpqB
         dNixPBuziDxxXt+jhr3gqvRGnFve/GYV95oCBAS2dneULqh/5vMy/y3YLNuQ3dYjSgfV
         yE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615937; x=1712220737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRSq3PbyalaTRAGpYMw/AwJImnqaUQvuvimLCkGiocM=;
        b=fHqjTXWwAPK39N9cJkvZ7Omgti9FcxauWHI+OTSW7nDgT70w1J/GejdLs16lSrXGOA
         6rcqnJ4kg/L/jJIkLLb91xHCAdzj8zn2gSJjibZkWkceWo2+7sQPYDTBlqOzuEDsJvYo
         2NUUrGFtOnUazTGY8Isb8iRlP8WBmi51CjOy2jLCxPXXw0wFmLbgXk2/S8dOzxDOr+O9
         8IHkhDTjcpkp1tLVuAS5X+FMkt/wNpegZpkkP4JIBSWia/5aOmjb4pTDBQsR1PaOibKz
         M2Ufe8H+mZy64gUWyXNjklY/1XOgDQp8wDvkZYkUu2iDlWMGmNIheCG0FtkmsQnq/Raz
         wb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCxhgpLPj9u6DJ9eEjU81M4h/Q24Eg6HTSmRCErZXgkcEEiqWA2EzoOIJmGNlNtCg7jCrizh5WX97tSE+z6ETsbt2o33xkjEvA
X-Gm-Message-State: AOJu0YzheyF+EX7Ste7+XX9WOluYfj99YHTvGTC89jpz4wZIjdeozMZw
	854X8qwnWxtp6WX8zrmGpZpa8D18A3iukvOE7UC4+kbL/0YLnN8KXDzBE2S9TyK/+lFrZD8BHlb
	aal3fl9YqOady5LnksJEtcuIyb+U=
X-Google-Smtp-Source: AGHT+IFr/exgRid+KISKPp1ZiaO6K73n659l0UMEZy7HRh4PJu6XIFnywV6qsNDZyBakDlwIDQZngpp370BOOWbZqiU=
X-Received: by 2002:a17:906:fb12:b0:a4e:289c:6dae with SMTP id
 lz18-20020a170906fb1200b00a4e289c6daemr8828ejb.50.1711615936912; Thu, 28 Mar
 2024 01:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328043845.28882-1-rdunlap@infradead.org>
In-Reply-To: <20240328043845.28882-1-rdunlap@infradead.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 28 Mar 2024 10:51:40 +0200
Message-ID: <CAHp75VfuoYoAm-QcVhx3bJcvsGarU88ZdNGwz=mW8sq-mt5pmQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi.h: add missing kernel-doc for @last_cs_index_mask
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 6:38=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> kernel-doc complains about last_cs_index_mask not described, so add its
> decscription.

description

> spi.h:778: warning: Function parameter or struct member 'last_cs_index_ma=
sk' not described in 'spi_controller'

Do we need a Fixes tag?

--=20
With Best Regards,
Andy Shevchenko

