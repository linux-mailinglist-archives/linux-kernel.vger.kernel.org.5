Return-Path: <linux-kernel+bounces-112113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D68875E0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E1A284CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7710E82C76;
	Fri, 22 Mar 2024 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gB0g/n1f"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D654D82877
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150991; cv=none; b=L5o+IyQU/cyE1Gp7N0+AXvDIMFGiApjErBnYBI03gDx6eI05zaMRaxyj/q3WsueC2T/EB0CF0P1o4/YybaTMSztAORG4bFrvXbaXjx9mvYbtacZD6KfcA/VdeIfUq7u3561zu6Fdl0wm03w4rRdWkavStrTJ4OoAxKWcyWFdtnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150991; c=relaxed/simple;
	bh=qv8aRawdQ6LCLH6RsJCtG2XeAHlJMlFTehACCccBvUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gezyf2cw+EdFCyHrfPeSWR4AhLiTobhlVKj8HV5bzFP1VV08Cr4wlRpvS4WuJc6F4T9//iatZMaAbiuOKI3REHtBKvsF1bi0/E2XgkX8IFMCZ3WuFuswMuONWovScDs56uIUVeWmHjF5HLyXgmCnknd8Da8lvHUZyjBTil6bVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gB0g/n1f; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5101cd91017so3103139e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711150988; x=1711755788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3wTH/TzF3hdRrcmsJ2UF7R/xyErYsBP+Qut8pJJOygI=;
        b=gB0g/n1f24RHXzAJ9osVgqEsnviXm0zCY5fSXSWW37wqs32+NfzWz1w4Xj/khjiu/H
         vAh8uGP8/qrS1UjNBgCdtSer4NkAOrGqHOecuIy6md0vUMUnvcjt91BtqfjjLHk4vnpr
         y+gci9JosOlG99fDM7o+ppZvxCqX1ndEDyfh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711150988; x=1711755788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wTH/TzF3hdRrcmsJ2UF7R/xyErYsBP+Qut8pJJOygI=;
        b=n972v9oLD9oE29xhw4Cs2Ew38ZPPlHlH48YRbpnhR3u4e886pDvpZkHS6N93k+Ughn
         xjiUj/J57fyFptMqtXsTz+mwUKFY4pOagIgRibsEy40tXJzP9K2Xe8AD51kz4bWn9uI/
         GAx7PyU1gdgUP7qz+b3yw2u5eqLIUA8lCjM+pkOvovFzXO4DwubKaZ1bq1AI43wQonMn
         my9fe5xFLQRxRM5kt4D4No9AE8NVYNl7SIHj+ZJWgRM4LYK702MwFdIyxXlRTyyziXpF
         kZ1Er/HJLRpsNEX5mQnDto8Og85pvUYOI7DdYMa03+f9NyOaU3OLRt8+tfBkW4Pt9ZfK
         wK6Q==
X-Gm-Message-State: AOJu0YxzSszIWvsIQmpaqW5U+inBdWej5skzw337CU8l3GnpoC+XWXmc
	rIB99b6A3xeVt0H3f3b1w9auNKuurf8bAKizAosW200Q+LBmarDcl5Gb4qWqe9ucpFx1SPISWiM
	SX98=
X-Google-Smtp-Source: AGHT+IH4xXXNZWNfWd1Byimth8q+bzVmSYygAVmCybJlc9EfBZoHwNQq0qrStE8NCiN67KPQRZdhmA==
X-Received: by 2002:a19:c50c:0:b0:513:d79b:d10d with SMTP id w12-20020a19c50c000000b00513d79bd10dmr532079lfe.26.1711150987675;
        Fri, 22 Mar 2024 16:43:07 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id ch12-20020a170906c2cc00b00a44180ab871sm324563ejb.50.2024.03.22.16.43.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 16:43:07 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a450bedffdfso318114266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:43:06 -0700 (PDT)
X-Received: by 2002:a17:906:408b:b0:a45:c99d:3625 with SMTP id
 u11-20020a170906408b00b00a45c99d3625mr882537ejj.23.1711150986670; Fri, 22 Mar
 2024 16:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2> <CAHk-=wjCD994KKNL7LGTNpF4B6-E2_A13J2hjP-ufnYt0KJdCA@mail.gmail.com>
 <Zf4TXtFMURWnSvxh@liuwe-devbox-debian-v2>
In-Reply-To: <Zf4TXtFMURWnSvxh@liuwe-devbox-debian-v2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2024 16:42:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfVQyT49aTbgY3_Z4iVxEwvxkj12YiW+WD_HrM_8V3cQ@mail.gmail.com>
Message-ID: <CAHk-=wgfVQyT49aTbgY3_Z4iVxEwvxkj12YiW+WD_HrM_8V3cQ@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V commits for 6.9
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 16:25, Wei Liu <wei.liu@kernel.org> wrote:
>
> Hmm... I thought I refreshed it right before the expiration date. I
> pushed it to Ubuntu's keyserver.

Ok, I can find it there.

> I will check if something's wrong.
>
> Do you have a keyserver that you prefer?

The problem with keyservers is that there's so many of them, and
everybody uses different keyservers, and the propagation of pgp keys
across keyservers hasn't really worked for over a decade by now.

Maybe keys eventually propagate, but I have my doubts.

My default keyserver appears to be hkps://keys.openpgp.org, but the
pgp key git tree on kernel.org is the one I then look at when some key
isn't there (or is there, but hasn't been updated).

            Linus

