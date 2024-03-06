Return-Path: <linux-kernel+bounces-94165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD9873ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAB51C2530C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B88913BAD1;
	Wed,  6 Mar 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BYWJIlcd"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA4137933
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739334; cv=none; b=b6LrW0shgRvHrbuufbF6WU8xj/7XXUhmkfW8VHnbgO7+QdVFcxHtI76frxeDy/7ra4SXSyFGtytEEJAjSTkPBcIOUO5mPrz0lYmghWgqhC5EqS9apFt9OkVVYB1Zu/Fqdl8SMFX8ZhofpB+22w88lFEu07y2JAmp3UK8DtgALnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739334; c=relaxed/simple;
	bh=+VtCcHm5WT6i5E4oxIOVLZNWtaf/A5upYPdSnULaepg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e85/lzn0MgQ4gRBu6yc6t4MRTE+7ybTIDe+k4+nE1e00LeruHhPlcuwjOOEM6RRP40rEz9wLerX5lqeh+dteB53Kktj5S+Oot+dcU6YaZOHrfPyrudleIZVzHkocCC02a3pEz+fDhp1ZqD/iACxdGipuTPEEh894LSo+awXteCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BYWJIlcd; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-365b5050622so1989465ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739332; x=1710344132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ue7GdPLCaPX4RWMzrCRbKHMe+t/tuY4CrVTF3vFJ00w=;
        b=BYWJIlcdHUQEHe2Pbo0TgUtA78B5NCiDbZLUBteXS/rKZcsgH7sRIoZNQ4gCaGV9C1
         ucok7mcO1o3tCpyq6UwLUknnLCCYGWzc+roNHmvAVuaFgEGbRhIxOXdn6RYlKVDVWg2S
         pnaDWlHWHWU8G4SDPWITFUT8PcO7+qlBBxcoGx9E8uf3HXbPM/RML337pTWm4xMONqnJ
         bpSc3qKRrfADMu8egltnQRBfbU3qJivCZmf6mu+6GBTpzPiunzLHvC/17Kvm0e4rZwSI
         6lrPLDDsVhzsUNQfu3EStf3x357T8YyjXMWCiTg6kxMjr47WpWP8ISFIiZ7JgQm9ITmu
         J74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739332; x=1710344132;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ue7GdPLCaPX4RWMzrCRbKHMe+t/tuY4CrVTF3vFJ00w=;
        b=oVstT0Kdtnm+4EzDkufeVKxS1P039u35SnwzbdM8DmyreOMbq0i58XhzNoi9b/eUkV
         EvCQRcOP2YvYW17IZQJLdtPUnPjJmJxSrl4v/v/unaeUCBbaW5QyhjTYAlZmk9yOiccO
         ls3rZTBCB30CZC2pJWy02Knm56pDvpTvWTdQ6WdReDtJxuI0E01ZmrwcIa0ULktaZ8B+
         x5olAFnkPQFZgn2e8qiiwRgD2QZWmvninPBgbKeFmofKMMB7NlYDWksqECB4PfGHdKyc
         LNfQXgHut/qRJiaMXP/s2o7lxdom1lSrRECfC1c1BpR8OKoSyZAtfJOyj6KX5Buf9UwO
         y6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ohVtF/KCyP1mBlaVPlY2jaAWs5aqwsga7NXuM1LBjRLRvTO8L/aQrh8AwpajDZPZ98bRiRN9ggXmGU8RkbXqFmtddL4muY2dYWOC
X-Gm-Message-State: AOJu0Yy72GmhLw70GU7HmnEqPzmTpYvx1sizgbZMFcVrjb7Th3X77KU9
	txulan4C0OTToh6RkD9TmhJPtnrpzaiQn1d8qGiDTkSwLTNuOGexyCbL6Xf/c47xSR9BsH7xrAR
	Y
X-Google-Smtp-Source: AGHT+IGlsipbuJTOf3EZjI1UJoK4KgG+PqG+wVJKJhVloJQbpNGNFmSGRsxULUDbvQ2nkJIZnfxdqQ==
X-Received: by 2002:a05:6e02:1d05:b0:363:c82e:57d9 with SMTP id i5-20020a056e021d0500b00363c82e57d9mr3850245ila.3.1709739332451;
        Wed, 06 Mar 2024 07:35:32 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Karina Yankevich <k.yankevich@omp.ru>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20240305134509.23108-1-r.smirnov@omp.ru>
References: <20240305134509.23108-1-r.smirnov@omp.ru>
Subject: Re: [PATCH] block: prevent division by zero in blk_rq_stat_sum()
Message-Id: <170973933060.23995.4109030710526528242.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 05 Mar 2024 16:45:09 +0300, Roman Smirnov wrote:
> The expression dst->nr_samples + src->nr_samples may
> have zero value on overflow. It is necessary to add
> a check to avoid division by zero.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> 
> [...]

Applied, thanks!

[1/1] block: prevent division by zero in blk_rq_stat_sum()
      commit: 93f52fbeaf4b676b21acfe42a5152620e6770d02

Best regards,
-- 
Jens Axboe




