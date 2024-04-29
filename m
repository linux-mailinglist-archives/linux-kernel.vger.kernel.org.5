Return-Path: <linux-kernel+bounces-162768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294E8B6049
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76A11F21A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155B1272AF;
	Mon, 29 Apr 2024 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxXzEjWF"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871B839FD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412450; cv=none; b=MvT2odPXZbfMknM+8vrgX81dmjIHaaUoo2xWAqGXKXvMsfRtzAM/r58iC2F25JMFySAH8W64YjHsLPwHqQg1L8jAf5DgHYlfStBRph3hMWViHdJc5xvfE96/yJYtU4E4InElJWtFOOkJyfGViqOnMhaazeFth+ASxswEJuyTEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412450; c=relaxed/simple;
	bh=AJe7hDA+FAhFKDxklHcSHgjXDvoB7jvUVi6rDdBGHxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJ4FEuVn8grdygsMpTUW8KimJEbl/i3SOYKi0z1sUDEgoT484eEWReCow5wb9ljsETLDzhxuRzbyV8IypzvmBSEA9mg8qCAgHuxYHmOh/UZSAv20h/MziP6/pnc2Dllwvjo9NxEyMRMiXYBu92xmLdZ3FHkzVb7oNo7ueKrxqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxXzEjWF; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51bd8d9f629so1241708e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714412446; x=1715017246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NME6IMdi2Oz5flUJ3rLIhaX1spcUgVHRV9oyuwgHAnE=;
        b=RxXzEjWFqrcUoq0WQL2DMgxJjYso+hC2R3Lwh/pYV4QuAN7TA4eD749DJTeDbtW25P
         ftoIqhwIOHjJwTfvJNWP5lMhBJMiEsrI1MCXeny/4xKU1Mskbng9/ltp2+S1Lj6c8M/A
         wmV4L9Y67eGfu/R2QfgvjhiD2CJBzMPsRVtGJZRDHSFFTZV6R1xt3B1NW4H4XyssueF6
         cqACGz2fJHmjjr73GY6e4U3QKRlkye624cDMwDsJ0FQBbFxU813hIodooR59w0b8062K
         HYDeURT+Y0BtcfVeWEJmJ7J0rwWqxqQ4t1nM4QOc17SAbx8AWzba6gklJqUAG0gGhc8H
         8u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412446; x=1715017246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NME6IMdi2Oz5flUJ3rLIhaX1spcUgVHRV9oyuwgHAnE=;
        b=gU5vGK2SC7RSPIGisEztWEJFUy0PPLZMYlnLNvYTC3+FFXpwu2QuGiI3hmPNGnEkc9
         4Q1BOvHic5MXWqJLZ0H6Rzb4pnCt9zn26u2cuetp6dAVJpM8euzhdJKtG6FmBDkMxlJE
         EW42QmX7choiojgktONw5CSEF2Sh6jQLYZRR6M2Sim57Fh96h7vi2W7aDRjM5pWVxN7T
         WlFzQR4wbIPgKY8E0jxOOPHs3aoPyBFRIJB6fUXD9dCkcWY1DigD4pPxVzLhq4mLdVKs
         6wRw387ADPT7JK4ztJoTcLEbGiqMuRD7oVkwlow6HT7SCtvdFMJcgyz6Ks4KJ4UqWfOZ
         LmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIgqjFrAfgIxcfMM6oyXnnfbX/Li1LNq4Cvi1zd3b5TFA+RbJQdhikw1LYjNvlPlFC7I0XWcWjvd+KKKzHfYh85kbjYXfStpezbbEw
X-Gm-Message-State: AOJu0Yz/bbuLCel2toY3Dytk5przKkQGGIbpqWHyPyIwsn2np3QkCwbZ
	Nq2k7H/WBIHZxTFF71pMBZ52Iaejas+31MFX5Sg19ym/IROE8lTa
X-Google-Smtp-Source: AGHT+IHWoLRyL9PlF7Vc0wXMfAlv/kDMjkYUxrE++vGREy/Adt/g7+bMzNgPiwZK2QodTS7C9PggiA==
X-Received: by 2002:a19:ca48:0:b0:519:2e3d:213 with SMTP id h8-20020a19ca48000000b005192e3d0213mr6413176lfj.5.1714412445860;
        Mon, 29 Apr 2024 10:40:45 -0700 (PDT)
Received: from [192.168.0.103] (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id fj17-20020a0564022b9100b0056fe8f3eec6sm13159245edb.62.2024.04.29.10.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 10:40:45 -0700 (PDT)
Message-ID: <3ed42990-29bc-4b2d-b8e1-eb3335207184@gmail.com>
Date: Mon, 29 Apr 2024 19:40:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Staging: rtl8192e: Rename variables in
 rtl819x_HTProc.c
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240428230106.6548-1-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240428230106.6548-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 01:00, Tree Davies wrote:
> This series renames 18 variables found in rtl819x_HTProc.c
> Thank you in advance to reviewers.
> ~Tree
> 
> Tree Davies (18):
>    Staging: rtl8192e: Rename variable CurSTAExtChnlOffset
>    Staging: rtl8192e: Rename variable CurrentAMPDUFactor
>    Staging: rtl8192e: Rename variable OptMode
>    Staging: rtl8192e: Rename variable LSigTxopProtect
>    Staging: rtl8192e: Rename variable ChlWidth
>    Staging: rtl8192e: Rename variable AdvCoding
>    Staging: rtl8192e: Rename variable MimoPwrSave
>    Staging: rtl8192e: Rename variable ShortGI40Mhz
>    Staging: rtl8192e: Rename variable ShortGI20Mhz
>    Staging: rtl8192e: Rename variable GreenField
>    Staging: rtl8192e: Rename variable TxSTBC
>    Staging: rtl8192e: Rename variable RxSTBC
>    Staging: rtl8192e: Rename variable DelayBA
>    Staging: rtl8192e: Rename variable MaxAMSDUSize
>    Staging: rtl8192e: Rename variable MaxRxAMPDUFactor
>    Staging: rtl8192e: Rename variable MPDUDensity
>    Staging: rtl8192e: Rename variable ExtHTCapInfo
>    Staging: rtl8192e: Rename variable DssCCk
> 
>   drivers/staging/rtl8192e/rtl819x_HT.h        | 36 ++++-----
>   drivers/staging/rtl8192e/rtl819x_HTProc.c    | 84 ++++++++++----------
>   drivers/staging/rtl8192e/rtllib_rx.c         |  2 +-
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c |  2 +-
>   drivers/staging/rtl8192e/rtllib_tx.c         |  2 +-
>   drivers/staging/rtl8192e/rtllib_wx.c         |  8 +-
>   6 files changed, 67 insertions(+), 67 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

