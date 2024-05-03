Return-Path: <linux-kernel+bounces-167871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E688BB092
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B347BB20E20
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E687B155337;
	Fri,  3 May 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QF/RAPgJ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062815531C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752490; cv=none; b=TaHSZopuYeYsK63FkZIVWJADiHNSwwHqXX8Cp0Tynge84dxSyV8R7KGKVkraXtDpQojORmQ4onZ352cvsyqcbJdJoiqAxQNMR+x+ZkXgkXERgX/dgl6WQ/xHLqmO/NaRPF7lV9NlSYP8qDSu4/pWCvIh0HgzdTxC72O2yMRekXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752490; c=relaxed/simple;
	bh=sZM2aaIMRxH4vyVLuwDYCONIXnYdMCnrbPqlQ3tLIBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIOBQm1o172dN9S/7vJmCJusKYOP6lOQHGkUsX8srzl6B97S45pXflsDPIrauPeFbHwh4oRnypDHomQcfk0bLS+b+0fCKdH011+pNA8dXcvsKGoxOdCcLZRd4/9vwLoZIO7pv4LUhVm/PHA5x3detxQFOWmn2bAbS8ZbzhKmuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QF/RAPgJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a599a298990so170044266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714752487; x=1715357287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WMaOhHAAnwImn/Mcwtmc1IDB+Tf65rtUNoBaGwd1lr8=;
        b=QF/RAPgJGsahy6pB5Bng+iX0tDKEVoMDbT//DTsIF3WRu/NAtsz5WV6aVmSvTmmhAV
         lt1cZMD36ekd8wlOxBg7fFFj83axTwfjV0AzzEY3PH3p9DZqi02kKBwZXajr2YiBQrjz
         PKO/SVWRY7qwJRXSvcOqYJaengG05HAONy+Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714752487; x=1715357287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMaOhHAAnwImn/Mcwtmc1IDB+Tf65rtUNoBaGwd1lr8=;
        b=RL2dyhhGDpPi0hKnWdn1hVKlO9inf0sRdt/2q8ma2pYoXJLjGCxN+Jjx+zLDHheOGT
         zJ00h7dGHfT46K2Koc9aTVjTUh0bvDW+VYxV7UJtKvJ/xRmSCtwz1nvQXhszrBAxS0yF
         WxEnegvJ9k2jH2uQMlaPrCzslFBH2jLy8dWMzkHI9+SqDLTaLyStCXHMGmEvbG83yNtp
         lVkvKVfke/FG89d7QKH9j9DdmiEs0RgJpAh6/ED/QyFARQMyxESDj2+VCDcLGiQpGRR+
         sSI5/GIMGgqU+EneQf2NbGMpHdm4hXXaL4yFQ5xISyZVmT6dvVs41glqEw/DqMOa4+NE
         305g==
X-Forwarded-Encrypted: i=1; AJvYcCVOgBGUZkTsRHR+szAcP35jZVUUK//31o/ZEBUWooWhtrhDaihX5z7QkeEmTtuTPzHjCK9WjzPNFdVG1GPCTTigXj7aLQV4UMbuSbt+
X-Gm-Message-State: AOJu0YzwOMLvbuuWwUO2Gwx0jExlJ+DXfLZH+F1h/tawpPX0KfOllPNM
	mzEojMCAQ9QTZnsjvgtCvdY9lULPCbBFMIau1P2zN+LApuvLPjc3vv+egsxgrMo1g+WDR2W4vMJ
	z8mXIjg==
X-Google-Smtp-Source: AGHT+IHuMndNm1dyfVIoCGwa5AgqJLLB9iDmLVL+7McWGn2ZanZHn1wCqxtTZ1agpYSZfJSvrMSbEA==
X-Received: by 2002:a17:906:af42:b0:a52:6e3a:87ac with SMTP id ly2-20020a170906af4200b00a526e3a87acmr1968676ejb.76.1714752486895;
        Fri, 03 May 2024 09:08:06 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709064f0e00b00a46aba003eesm1838603eju.215.2024.05.03.09.08.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 09:08:06 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a599a298990so170033666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:08:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUR4HVcrSjsqLCFWYSCpx5Q4H5B6tmgZJYm6TnZ+1DguQUDFpBL7InY0qFnPhYJm+yLDlmBCUv9prq2iyJnKTKBnYdyI8VN/3lul0KX
X-Received: by 2002:a17:906:60d4:b0:a55:5ba7:2889 with SMTP id
 f20-20020a17090660d400b00a555ba72889mr1639743ejk.42.1714752485577; Fri, 03
 May 2024 09:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503081125.67990-1-arnd@kernel.org> <20240503081125.67990-11-arnd@kernel.org>
In-Reply-To: <20240503081125.67990-11-arnd@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 09:07:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUDyvBNVna_vbYGfN0SUjt1jN6hUgRjoLFq_XTV_0gMQ@mail.gmail.com>
Message-ID: <CAHk-=whUDyvBNVna_vbYGfN0SUjt1jN6hUgRjoLFq_XTV_0gMQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] alpha: remove DECpc AXP150 (Jensen) support
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Marc Zyngier <maz@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 01:12, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is one of the hackiest Alpha machines, and the only one without
> PCI support. Removing this allows cleaning up code in eise and tty
> drivers in addition to the architecture code.

Oh well, The axp150 was the machine I used originally, so it's a bit
sad to see it go.

But yeah, good riddance. The lack of byte and word operations were a
fundamental mistake and made those early alphas very painful.

The design team obviously made other technical mistakes (sw fill tlb
etc, with memory ordering being the one that never got fixed), but the
byte were the killer for any sanity both on the IO side and the code
generation side.

                  Linus

