Return-Path: <linux-kernel+bounces-31597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA2833097
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48271C23B88
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8F58AB2;
	Fri, 19 Jan 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FXP9BOi8"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1B58132
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701636; cv=none; b=hzwLHrX5zLB3uHJmWuNQ9VEQkN1A273j4nMm7yDyDNsT7CR1IR6ME42FccJftjKCXlM5b0mJUraZ/gbzd1It/RTzLrSlrfHl8PrCIZ/dUPiAh3hfUSt6/qKGTDg6s6/Y4QTWTDQQ8aY1Xwt4T0pdkafOtlbHn7gYFnWGXO3Ftqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701636; c=relaxed/simple;
	bh=Xqh2spPXg/36Nd5acHIcaHi1wPMckOnZCFfqASQrpgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Us0Uzd1wShPZu3JDgXi6YPupWj+PyaUMVg+GA8Atx/zQawy9zEENB9HIKTNZQACSkU6hbOaoQzvswD+8daUq4sLRllx7p/7H4F+w61W9emgBE5+TunK9WEp2uSjlWSMzPv/w9SKrC8/kBzG4Kw9fIh3/fNzoLREvc+VNMWy42mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FXP9BOi8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a02948940so1545509a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705701632; x=1706306432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/xlofjQtofHXFjo9khK5kC3pChLQbc+i5Psd0zeHygA=;
        b=FXP9BOi8lJxESl4aQoNDvBYdmNGftf8GHq4kmSUcVujGGSTLWLwMpmE2CcGvpgInhR
         8u014PV3juo9tNlK+V3DJ9BBPYTuvgwxBExSnRIZbiuLYh/yrU1teZ6KGJepiNrZUVW6
         EakghN4Rv4jwso9qObAvoFX4pF7R9H+87Ld/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705701632; x=1706306432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xlofjQtofHXFjo9khK5kC3pChLQbc+i5Psd0zeHygA=;
        b=VdBMxs8s2FRSQRuQZF8RHb1IWKz7GDwIgw6X5KXC96KMqbDGuwQFi/w6Yho57swfUB
         Tlz6EEIbd3aUmjo/LelZJIFf2GHOuZUY+3sF7rzYhkilkDDB8+PcHCpT10pu4QTTM83Q
         rUy+nlvaOvHMT/QfgImkBm+RUb1a3nn92IlPf/U6WL3Y2tTgGs1R5jFvYOnFTn8oh14+
         ZHIMhwg2Mr2lDTQinGkomhR5jDsElNGeYnC/33DuQWGMKrnT81h+zy9tkY2BtDn6IsID
         7DCgx6+99gqjT/EW2aC/6aAMl5v6dQhHhZPyGziNZzchEJNp6Wkl1lmsJNw7br/6kprR
         Jn7w==
X-Gm-Message-State: AOJu0Yy0M+JPwQeDAbXhZ5ESxHaunDLVqbsZloc2Q7O2taryQimsqk6i
	mEOdhT3GfDSjJun8WnWjQsfCLRW8cCg2jFZPs8McwPEvjmpv+Giyri61xJQi+SqhIdNOlyW8sda
	OXLE2AQ==
X-Google-Smtp-Source: AGHT+IE3bvtzxGQfh/lO2YMtW1Cv687sDo1zH5sECANYQ3QXn3RGHGr10LO7meadVZcZcfh/d06kvg==
X-Received: by 2002:a05:6402:3551:b0:559:9588:1bd4 with SMTP id f17-20020a056402355100b0055995881bd4mr283652edd.25.1705701632482;
        Fri, 19 Jan 2024 14:00:32 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id q35-20020a05640224a300b00558a4d01783sm11046952eda.60.2024.01.19.14.00.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 14:00:31 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so1477238a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:00:31 -0800 (PST)
X-Received: by 2002:a05:6402:28a2:b0:55a:590f:3464 with SMTP id
 eg34-20020a05640228a200b0055a590f3464mr186462edb.3.1705701630814; Fri, 19 Jan
 2024 14:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401191311.B6AA79D@keescook>
In-Reply-To: <202401191311.B6AA79D@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Jan 2024 14:00:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0j07B=n1Bt4EkDJpN5CBmxMuZhv+nnFdi0DxDVSiZAA@mail.gmail.com>
Message-ID: <CAHk-=wj0j07B=n1Bt4EkDJpN5CBmxMuZhv+nnFdi0DxDVSiZAA@mail.gmail.com>
Subject: Re: [GIT PULL] strlcpy removal for v6.8-rc1
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Whitcroft <apw@canonical.com>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Brian Foster <bfoster@redhat.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Joe Perches <joe@perches.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 13:14, Kees Cook <keescook@chromium.org> wrote:
>
> The kernel is now free of the strlcpy() API!

. still mentioned in docs and checkpatch. Maybe remove that too?

              Linus

