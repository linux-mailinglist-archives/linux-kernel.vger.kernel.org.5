Return-Path: <linux-kernel+bounces-78523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE6861475
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F33D1C216ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09944224E8;
	Fri, 23 Feb 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G9eBRSqI"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61839225DE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699611; cv=none; b=Tqfb7iLvBwrQNVAIpz/Po7eN8c+NL8qanA3c0sqQfiZiliMarLHcVvft76cLokfznPbukROqKpUfWBUqSdB6XiTJq5SpXcFCE8kdQyq0WpypbiguJ7Eyr6JviCsb7/aqxlZ2++L/O50NGyoZwFUTuyQXLlYVPfVZr0wI1CBj5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699611; c=relaxed/simple;
	bh=Mt1B9Ji47lzCrOOPWA7S+MJtKTeUuc/gx8Y/yssgYr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q1s2PiM6f++ajuLzpxMMY38BhRiELh3DASywX5V7tddFG02xGLq0418X8sIDkQ0SgxWLGkqNca4liZsNipRwEra7Gv7FVgcflT1KAzf5z4kMX2VjWi44bdQpaKEz/hEBETseF9DqzuMYMYtxHPTuxY34JfbtPOeBZcv/PFfNCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=G9eBRSqI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e45c698090so175249b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708699607; x=1709304407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1MeBTQpUH7LY28h3Y8eqPCZpbMXd0Gt2ZHaY0D3V48=;
        b=G9eBRSqI9Coalqi+vdZINYU6WUS27LFE4ub3BFGaCxVAqsO1aQyh1OTtXtL6jjcOUe
         8pg75STt9vHs+9OLKvtY9J+vjQMKBq6HIgz4Kxfxu/lrjQ9SGQVZtArAMJavCNq+oIBo
         mb//ZjbTOYv2G3vVjRKBTVe8PNKa7MLpafyMLzvJ+VZabAf8WHZUOIHKGtvW/YkzXK6H
         +7PABVyqkWCXwokDQUS7uZmYorpy1P9jU4sg4KIoENbicAjDRlL3VhmOKYJdUnVJDYeK
         Gs6qwzPhxyPvEY1YdTrjIzqxQx5QgJT47mzuj6bYw1yPRbroMH3v9vsyNzk7aLeF7YGF
         e9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699607; x=1709304407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1MeBTQpUH7LY28h3Y8eqPCZpbMXd0Gt2ZHaY0D3V48=;
        b=MyKkdvWa1vbhk0W2XrWontY4Dw4k/qz+KDyBdR4crXnh46DHuDRRom1DnoGM1st0zQ
         wzFo4zpM3/f8MQP7TeI4RlagYHwmWXeOux2S/41NLGSdkTntVAleR15eVcWKbjtyA22r
         2eIv+AshFx0fdGNG3Mfaqdp2SrZz30+0at7tZ7l9oiV5rQV0R7Okcnc3xawuqNQ+s7YX
         7I6qmjC1i0bnTn728d6UJDtEX3xlFaPejAlRfZ+xKHnq9fZhYG+PBk+UbJItqtRftriD
         Ax74J9G+2eDBKVSweZMUoEM7xFsnGTFGzlWEEsKLfeTopJxFo0EJmgaWYzH6plecpo5S
         QUGg==
X-Forwarded-Encrypted: i=1; AJvYcCW5KYCQVQyMk6dFfNXG58ZIcQ4TmCP6mNf9ra0MrbChGyJj+SB5gavLFBBF3dsgl4YX9nTKt840IPC1fBpta44afw69skgWtfML7439
X-Gm-Message-State: AOJu0Yy2LGeWub+PekkRb0KH1YRFG2x7YDR1rXFLs6KhO/vW3m9nCjvP
	ybPjqEGPDNdMMYzBmAQxpfUIvTPrcmiDwumeRoXwM3598P7z/jp81Eqvu4oTyJY=
X-Google-Smtp-Source: AGHT+IEtp3zS8kcrVaMAPfEaY3vM26FdkfQGqjIjERKuZq8/CcH61Rby2r+bAd13RdEhMxoqmwq8jA==
X-Received: by 2002:a05:6a20:3d01:b0:1a0:debb:f150 with SMTP id y1-20020a056a203d0100b001a0debbf150mr85090pzi.2.1708699607496;
        Fri, 23 Feb 2024 06:46:47 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:7649:34b6:d6ed:9c67:70ee:2f8f])
        by smtp.gmail.com with ESMTPSA id v13-20020aa7808d000000b006e46df9f1b1sm9127924pff.9.2024.02.23.06.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:46:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: song@kernel.org, yukuai3@huawei.com, linan666@huaweicloud.com
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240221090122.1281868-1-linan666@huaweicloud.com>
References: <20240221090122.1281868-1-linan666@huaweicloud.com>
Subject: Re: [PATCH v2] block: fix deadlock between bd_link_disk_holder and
 partition scan
Message-Id: <170869960618.48825.8696438313079266889.b4-ty@kernel.dk>
Date: Fri, 23 Feb 2024 07:46:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 21 Feb 2024 17:01:22 +0800, linan666@huaweicloud.com wrote:
> 'open_mutex' of gendisk is used to protect open/close block devices. But
> in bd_link_disk_holder(), it is used to protect the creation of symlink
> between holding disk and slave bdev, which introduces some issues.
> 
> When bd_link_disk_holder() is called, the driver is usually in the process
> of initialization/modification and may suspend submitting io. At this
> time, any io hold 'open_mutex', such as scanning partitions, can cause
> deadlocks. For example, in raid:
> 
> [...]

Applied, thanks!

[1/1] block: fix deadlock between bd_link_disk_holder and partition scan
      commit: 03f12122b20b6e6028e9ed69030a49f9cffcbb75

Best regards,
-- 
Jens Axboe




