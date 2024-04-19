Return-Path: <linux-kernel+bounces-151988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB778AB70C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F492830A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722EF13D283;
	Fri, 19 Apr 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HFMjNHqJ"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF713D25B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564321; cv=none; b=QOEqLuAeviCOy6O6Wma9QRMMlwn5c/QrBTm3xOzNvEVTRe+M8yRvApVyY674bXr9soNS6UKu0Je8gl+MAFQ9jZ2nY3fqKdY5WYZhNAj18MuqqcUGzxhF7HeOw0FCMc4772Y3SkgJXxVnoZKsg9fZraZdWTRblEEAUokv9ih492Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564321; c=relaxed/simple;
	bh=96ww+1eg6Mocde2XsvwCltzM9kg8YXha7d3RQyiV9kI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+tAKUqentR88se+D6xytHJOCDJtMnAEOarh4jIrFRQMGmEfMLrMVhEh79HbYOvcaHMmZEWkO4jZpSu2lCEJqxV/b544j4qLF0vbpNuO9mT1998AHOawHrDZck4eToCBSp37Kr1Di+HviKJXq1agGuV4S09yePJJtY/TmXKvOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HFMjNHqJ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9ACB43F4BE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713564318;
	bh=96ww+1eg6Mocde2XsvwCltzM9kg8YXha7d3RQyiV9kI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HFMjNHqJvSMXU9Sdg4DCViY1CBMM+wJNUCes2wNNGKuRf8CLVcAU2yzmKkd31uXt2
	 5kgZQmGJ7ttPgAjETE8BrA3Ckso6F2uC4dXgQsr6oDLoP3IKQ60XYnEXsZkXOKv0Od
	 dquXZU2/uQ3jjB8FXpKBkY5NIxwXZfocK5Klnq6CWDVal23aIYxEy6A+2N6Ylb9X5K
	 B9jwuJNDSckStKCIc/Jwgwm2g7Xh4Mleuk9gvrCbaTEnX57eOi1sHp/UcU5dxZBREw
	 K0woRnIh9aiLWSWcg0tXASWi2HN1R9nMOuM/i5mZ+zSypXX+dvcXS5p6X9SlLsEh4V
	 Ep0wX64s/QylA==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4386bcfd788so14116771cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564317; x=1714169117;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96ww+1eg6Mocde2XsvwCltzM9kg8YXha7d3RQyiV9kI=;
        b=uZXqbJi1/ZEBL0VAOCcevq2O5csZWg4nbfvLqVUHs5JpZBw+bT9Sp/Jgx7vdZzE/l5
         CPxXBGh+x3yupCBj+DgZfc9Ucc0Yr52J4bgSSeI+l5H2pBR1jmh5PoUoD5YzUy5YVufg
         fRRtvZ593PWaNyIcz3H4AYbi+exq7HCo4gRMdRxBkErtJzWLuycwixFwG8Rtu3FCeiHP
         yahRP8x3QBowCmJOlHZDdXUGgTrD3CtPEaIkE+l+f/uHlDjwbRbyPEUkc3Ox9S3SBjOt
         Fs3ZfgByruHJsacvh4HiBkAYpQ3G6WzeP8eJe4SrHLofph9qoUy+oyFEVXfftAM/NQOf
         Rx3g==
X-Forwarded-Encrypted: i=1; AJvYcCUnb4K2R8HrMWEW8Hc5RQldZB7n4WFIBducZChughZFNOxWJxY8P4bHrBJiTVBuKXtNTKrJbSrQM/+d7AQz1VHYy96ZihNZEEsdEmxd
X-Gm-Message-State: AOJu0Yxtu4B51jO/s2AWoZrmbqxT9mGFdw3fwTMB9dI+SE78BA5EK4ef
	raRd3xSB+190b6qQVPw6x74eW+iOPjn7cBwEwoNy/2SygRMvCrh1WPoXeXc5ga0adxHj8IyLvI2
	mgFHajud5BLUJEoMScBa0zZM+0retXeaxE1DwkeoU/s8h7JFWVe+9v5GDGCmQhtjKXFzO6MnMjs
	DgOSnuzFAz6sgTWq23idYflRNMuSjo73D1DSM8S5Q1ufmomE+JDqiK
X-Received: by 2002:ac8:5f0a:0:b0:436:b948:7e6f with SMTP id x10-20020ac85f0a000000b00436b9487e6fmr3530265qta.17.1713564317702;
        Fri, 19 Apr 2024 15:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzf6EeFMjLFuwkceej16oYU6yBNN8gBYeTtzna5Skfq40Dl3SYzgE3yG5YPh2n/K1Biu2V9RqhlB/kUHxNFH4=
X-Received: by 2002:ac8:5f0a:0:b0:436:b948:7e6f with SMTP id
 x10-20020ac85f0a000000b00436b9487e6fmr3530240qta.17.1713564317355; Fri, 19
 Apr 2024 15:05:17 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Apr 2024 15:05:17 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240131132600.4067-4-jszhang@kernel.org>
References: <20240131132600.4067-1-jszhang@kernel.org> <20240131132600.4067-4-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 15:05:17 -0700
Message-ID: <CAJM55Z-nnJkvJ49hyz45+eqMGNSjR+adA8345oVO2uHvgqZsxQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] riscv: dts: starfive: visionfive 2: update sound
 and codec dt node name
To: Jisheng Zhang <jszhang@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Jisheng Zhang wrote:
> Use "audio-codec" as the codec dt node name, and "sound" as the simple
> audio card dt name.
>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

