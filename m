Return-Path: <linux-kernel+bounces-167793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0957D8BAF3C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93492843C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA7046542;
	Fri,  3 May 2024 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="a9cbh5sD"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3942076
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747761; cv=none; b=HPCZ5P0x5L4ktO03qEIyQxEYufQIbFQF9b+D7c6hLvlN4Vo2PFltxPMzSqQbexpllVE4VHB/yWhugS5uA9gElWbqeO0EQhBeCbzJNGwKlJgUSxCCSDuNOssrkamew82n5ueCPPIHUS2BsF+6sWikeAANQfZNSsbp50LNoqtH944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747761; c=relaxed/simple;
	bh=sIkQv8FPBAXSI8J1xzgFSbGfjS0vfeSYsCzMMHqXQDY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BD7eY5X2cUKSMp/mellz7oCYYmElp1WjlnIL/aZVrUgbw4kIkIAJJLTVXyyMG/4kVS3KPXQ4rAhYG/V23KKdsRPzDlQZDJLO31gQdRvm9UrUT9Yc5KADTMnyHvr2BQX4MQVDCObDPF8thCifcz8Gzhjr6UaqQtno9vyo4EKUV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=a9cbh5sD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572babec735so2496732a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714747758; x=1715352558; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vue7AEGpbhQWdtlSVezRt8OjfVIEQ/ARZwW50j0jLhw=;
        b=a9cbh5sDSwJDQ8iBvEeC2mEr7o3XLcgZEp77KkqkfMD/3UzJEHgbQq7Hm6cExjhipe
         kqZvDUllA3z2CvPereKBM6mNgtndcAC6lFVXN2N2I8pOhw1duTt1tOCXP7W7uoD00u6G
         GiLTVsEZQOsIgpz4nR4JzY0IfXghYwZUps9U6nV9esOUO4r03GM7OMBJNOIPV6e6dq0C
         Knvt+85JChzyaULAFrVDdudikLCslfy+KdiaFpaV2CazUhwKvHbHFL7S/JeVgYXJfZrq
         YDtakTeuA0858mw/imalZX7AHmas00g5qJXkW8VdbsQ6Eope6mhRAfD4wjEo8f7Cw6WQ
         ntyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714747758; x=1715352558;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vue7AEGpbhQWdtlSVezRt8OjfVIEQ/ARZwW50j0jLhw=;
        b=MAxvfTBaeD7I20sFdZhFp6O2nxtRX+VnqK133EX1CeOKtunjM5HeFhukxjyuF1xlg/
         oFO3+j1Rm44gm5qJ+WDekywEncdN6rOI6Se7pYUN7a3w1PF8EvfG64/w7flsef33GlUX
         avesBv1U17rhOmYgTcc0HpJYmbeNHSIxoLPdJU0AbVvURfIMxGNgs8Nmqc67MWn4LkN+
         uPIGVRQA81UaX0C6c3FsB6u4r/rozvCvxcjYb1xSw2swddqBAe8EKyoPS6iCOr6K5Jcr
         lrZFnKFT1B4reRiPlS9tRbdvjd3/FgCaUT4m99hweZ1S99zeGmO6ZE3AI1R9zUaa/2vV
         UzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX32tURTts4q//vjBwL4FX5euWNoC//bzeAauW2mvrBYp9xc3f1gp4SvfQ3REiS6InQNWu59jHjSEBAXJfjbGAf84CqqwpSB3WgK5qv
X-Gm-Message-State: AOJu0YxhGjnv2ulAcZqyS6HIr/Nhs45nQNfQqZNcqPHfUI61HalqoTAZ
	kEB8QHUnR+qDHGBhtKay81AoHvxq9HmBErW5RMHc8PWpKRnyk4hELfEmIS0bOyI=
X-Google-Smtp-Source: AGHT+IHS2L8YhvIVed6CV2FoQZFS19uLuOGp4sfBdE1Ni9CdpttS1oQhwnJdmrpHyLiNBhnvgP/6Kw==
X-Received: by 2002:a50:9551:0:b0:572:aed3:a1b1 with SMTP id v17-20020a509551000000b00572aed3a1b1mr5220368eda.17.1714747758080;
        Fri, 03 May 2024 07:49:18 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:ad5a:d037:b2a5:befe])
        by smtp.gmail.com with ESMTPSA id ba17-20020a0564021ad100b00572ba362607sm1738666edb.51.2024.05.03.07.49.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2024 07:49:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] bitops: Change function return types from long to int
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <99B58F85-CC9C-49F6-9A34-B8A59CABE162@toblux.com>
Date: Fri, 3 May 2024 16:49:05 +0200
Cc: =?utf-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
 Xiao W Wang <xiao.w.wang@intel.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Youling Tang <tangyouling@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Jinyang He <hejinyang@loongson.cn>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F1D1D3D4-CFB0-47A8-87F0-E1D8A6B5904F@toblux.com>
References: <20240420223836.241472-1-thorsten.blum@toblux.com>
 <42e6a510-9000-44a4-b6bf-2bca9cf74d5e@linux.intel.com>
 <C0856D2E-53FF-45EB-B0F9-D4F836C7222C@toblux.com>
 <e7e4ff27-ebb3-4ed6-a7cc-36c36ab90a36@app.fastmail.com>
 <99B58F85-CC9C-49F6-9A34-B8A59CABE162@toblux.com>
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 22. Apr 2024, at 17:55, Arnd Bergmann <arnd@arndb.de> wrote:
>> 
>> I can generally merge such a series with architecture specific
>> changes through the asm-generic tree, with the appropriate Acks
>> from the maintainers.

What would it take for this patch (with only generic type changes) to be
applied?

I did some further investigations and disassembled my test kernel images.
The patch reduced the number of ARM instructions by 872 with GCC 13 and by
2,354 with GCC 14. Other architectures that rely on the generic bitops
functions will most likely also benefit from this patch.

Tests were done with base commit 9d1ddab261f3e2af7c384dc02238784ce0cf9f98.

Thanks,
Thorsten

