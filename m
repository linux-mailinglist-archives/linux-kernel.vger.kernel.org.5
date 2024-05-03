Return-Path: <linux-kernel+bounces-167392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B64EA8BA8E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6F0B212F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D3C14A0BB;
	Fri,  3 May 2024 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwFsK3Os"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C779CD
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725405; cv=none; b=Wb4EBhQK9nVgqolD1TsK6kxk3yD8G8lDHUOoUfLAWw/DIl3HXkpyZcjXV0y2dAv5gM43ismPgb7UxiozjIP2SVl4IEdgcG+Qme5QM51ldvkdheMYhrlqk+n4GYlHPXui3MuRuut6V6M5+todA0CyVkyK83v2C7SdBOweTJsSIOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725405; c=relaxed/simple;
	bh=wRbtQpzidtZ6kk4EqzDd8mAoHGj4dWVE6VSRYNfcIS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClMRE7QeF6JUmf1EXeStMvo63DBZ3ZzS3pP6X2BaCnQ4vNvSEkq7atlRuJKqT/gsE/oS08r/oE0KyGeoaAYiB31bp/NXQZlwe2RpMZYOWaudt8klHztaLwTaH8bBUzXcWCUXi9oYtos3LQwkQhdHU2SevOFF1EtjirNcakrfNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YwFsK3Os; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de54b28c41eso9883268276.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714725403; x=1715330203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRbtQpzidtZ6kk4EqzDd8mAoHGj4dWVE6VSRYNfcIS8=;
        b=YwFsK3OsyFJNiiRWD35T+XbEQsIRlZ2sWbDFr8feOOsRUWitqFIDCvrAaClR+pEoRX
         3k5pFP+9D8Kwi6vXVPTzU8wq76U7CTM4Dqi3zQ4QKUPcpRPCmWoIqcBDuveZx032c0kl
         k+5Gn/eAxGT0k9VHGL3VSx9J9u+a3H31f863oPFh/M2htRp5c4iIBaSomDe9O+VRILpu
         mYk8+qvK5UbQofeayrM4cV69zcYb3HhS9odpk6Zfg6CGfvuzLgu2be+LgEwkofjsVaBA
         vSualRZhWEK05BkjWqD7jUsguV4IvLDjhVh0ARdF5JFPmMrGGaMM2bKCTsscw/wo4HGp
         mMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725403; x=1715330203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRbtQpzidtZ6kk4EqzDd8mAoHGj4dWVE6VSRYNfcIS8=;
        b=WYRblUtZ1lgo8yxVRat4pvtf56QBiSuUNtbV1Apbw9awuo1xJBKyjdG/sF840ZSNeS
         0zQyomIb85HVOF/wYdfJXM8OUFUliYvupI/GLVL6P3Lt2X42PepCMjdewrEnMVFNPA3F
         js+SmPZZceg9HmX81tU9gEFb6C3r6ZkWtGcOPVWn2DE3MFO9CIWExd/cUMT1un61A5YI
         C/4iUQAjr4p7tVNW/nJRLoACkyTw2PxGv7GuQdQlvpAc2kOLVeAM0a1ykJxbhSBkiwOq
         BFKSh3/Ng5plzpAW/p+ceGJbcThkuefRnzPyWISkL03Wl9pT+nxrfC0h2MOHKpRG6E4x
         UODg==
X-Forwarded-Encrypted: i=1; AJvYcCVb/wIL8ZvZDvuFEMeJbu/uXLN8nnWU7y7M7D8TBKdN9Kn2Jl3HOEZ5JBQAEDFcoioimIpZ0LglAm8Ounpakj21cYP9O3WQKXuTmp1U
X-Gm-Message-State: AOJu0Yx/a0vEmcfvtAxXk/Y5NCn86JS8G9fM5VEmDrvTlfpyV+YLi94m
	mCFeQj4cb/jlP/ohzEchl+4cBE11xZ/zIvEO+7kyCxm1rzf7EmDDuNySCHDPQk+Z0LH4WEMM01w
	TOE2pN9bmqV036Phzni3m+nJocOj0cdSmbeqlLA==
X-Google-Smtp-Source: AGHT+IGrx5xrV1BdUb4LcSt8Vhx2IgFFsnaDepsJtNrcYl/dh8fPYD2t0JfZINRBOkX6EZ7ged0A0nKmz0jq9uBixZo=
X-Received: by 2002:a05:6902:2085:b0:de5:9c4b:dd5c with SMTP id
 di5-20020a056902208500b00de59c4bdd5cmr2425440ybb.23.1714725403114; Fri, 03
 May 2024 01:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429070523.3160248-1-JJLIU0@nuvoton.com>
In-Reply-To: <20240429070523.3160248-1-JJLIU0@nuvoton.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 10:36:32 +0200
Message-ID: <CACRpkdbaC9YR9f-q3fNjpH761VmLn2bhaaWpy-6Fhk3apOT8vg@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: nuvoton: Fix sgpio irq handle error
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, brgl@bgdev.pl, 
	dan.carpenter@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 9:05=E2=80=AFAM Jim Liu <jim.t90615@gmail.com> wrot=
e:

> The generic_handle_domain_irq() function calls irq_resolve_mapping()
> so calling irq_find_mapping() is duplicative and will lead to a stack
> trace and an RCU stall.
>
>
> Fixes: c4f8457d17ce ("gpio: nuvoton: Add Nuvoton NPCM sgpio driver")
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

