Return-Path: <linux-kernel+bounces-104844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0987D46F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A661EB214DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32AB51C56;
	Fri, 15 Mar 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="doEV8+le"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0362252F67
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710530576; cv=none; b=CtATVT54jnH3+IXDPZ46lkeHs3ySYOxORA+VOR/BKZ3opdTgBfNwwBKhIXXDGrUdpmvkGgDi7FEFzXYeT2Brx6ntADZM7mleystSOjEhi27oCzNpyOWAAp3Wn8hzW8pnUuILr1ZWTeGtg+SxPGibXRYpQivbjsIZM1nTNSXjlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710530576; c=relaxed/simple;
	bh=SgCWcbPsMSH/iRhv0fwpCduLDzUg6oMxGopmCOe0wDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkcdceqSz0iIrB50Mcr2HpHTP2eZfIEUCX4nEn3qfKp/JBTeljj7BLPiQ7/wukZxFM9fG/SbVt7/Xnln+8UJOWMW1XcbfmdGN8ritWK1XOjsry9TioFrUZchRzLmAxIpep1m1rL/ViF2M5fNfMxRlL8rYBkuRXvuNG2srtUwpuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=doEV8+le; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-568b7350397so875581a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710530572; x=1711135372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ0DQdg1Ud17/D6FESIXny+BjQvPu5PkKMv41lEQ+DY=;
        b=doEV8+leg1DKcspIidU9BQvdNWGPAXH2380b7mnztnfoFfVesSOnvkyYH9BhCOOykh
         RUek8PfMzSbIdr0LhLP59OM/mxMgts08Yd78NZAVDAsfnZ9RNVa7HLoFVjKBmDTUXmwr
         CL4PHmA0CvO5DLrAEoV19Q174JIrbmbrHbVn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710530572; x=1711135372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZ0DQdg1Ud17/D6FESIXny+BjQvPu5PkKMv41lEQ+DY=;
        b=CCxM3Gz7W6syX3qgJDjeVUZh5Yq23SBgzJYnuhzYNcmvA6Ztvb8yDkHG5guAE/gHKB
         tpCZVqUnvVExUDehYZkWmQe7ZCSuhWYXMr0b0OLj2hm+g12GH/DcNbYDhDQ0dIbG/5bg
         sjcdJXbIeMJtAzQ2Jrz4868jDXEdD6nDDAzT+tFTJudNJAJtOUewGM04lnHttgcvrjBB
         5OlM4n3qTvyiR/+dD7V6F79CngsDAysimbHuUKRpP65Zdi8Tb8lretOEBtCnvR3Ud08Y
         uC6839+lORtkPRTnIUkpu/tna+DxjqOvkPeAU8cdXoq2J5Jc0+5v5cBSdMpzyEWqsOI7
         rRLQ==
X-Gm-Message-State: AOJu0Yz1aivjsPW6NH4RvK17kPGuKug5dJ4N12thBXQTlKyC3olDdxLj
	rPB0DidJJvSZ7tN73eUUqBZYJTYyApXsCOJ7RNuM2ArcLNyL5hjHpnFarJSFix/Lc5CibvnTUly
	wmZNdfA==
X-Google-Smtp-Source: AGHT+IEYfIymxmZ/pgyfa6CogCviVmhwvYd0LieRgFB8DRYh1SfPYpGhZYGDRLMsnqDAq6D4xoXlZQ==
X-Received: by 2002:a05:6402:5485:b0:566:aa2:8433 with SMTP id fg5-20020a056402548500b005660aa28433mr3456170edb.36.1710530572026;
        Fri, 15 Mar 2024 12:22:52 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id ek19-20020a056402371300b00568a6c25ef3sm1300720edb.60.2024.03.15.12.22.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 12:22:51 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44ad785a44so293859466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:22:50 -0700 (PDT)
X-Received: by 2002:a17:906:cb88:b0:a46:6faa:64c6 with SMTP id
 mf8-20020a170906cb8800b00a466faa64c6mr3067834ejb.19.1710530570617; Fri, 15
 Mar 2024 12:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfQrAdJodRKKXeBj@matsya>
In-Reply-To: <ZfQrAdJodRKKXeBj@matsya>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Mar 2024 12:22:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1DTEQpOokQRXeKoAhSgyFJbs3jDKV9r0rc0M7aHDO0g@mail.gmail.com>
Message-ID: <CAHk-=wi1DTEQpOokQRXeKoAhSgyFJbs3jDKV9r0rc0M7aHDO0g@mail.gmail.com>
Subject: Re: [GIT PULL]: Generic phy updates for v6.9
To: Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 04:03, Vinod Koul <vkoul@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git next

That is not a valid signed tag, and I can't find one in that repo.

I know you know how to do this right, so please send me a proper pull
request with a signed tag like you usually do...

            Linus

