Return-Path: <linux-kernel+bounces-142843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30408A30BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3A8B22A38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80913DDAE;
	Fri, 12 Apr 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XXY4vSI2"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A613CF97
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932387; cv=none; b=abwkfNxnbNYhRWpiyT3rDMZX9yv0MIGmRUaDGS6QTWcl2vedUqeXs2KMpBboX1HvsDIvXGgtj33td3sWfAV6DhMRQbX8RhCnCUWTzA6JCt7cbBtUIck/a36FM/TaT/KrTraqmRLRykIvln7K3qUqFdZyxF5/YiMRJ6HwK+oVyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932387; c=relaxed/simple;
	bh=VVOpT9HwxORdHB2frWGih1hsKfYhPqfrT8OpAak0vH4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KR32ri0pGHcVvZplX6IhjHPQv2BQVGBCi4mMQ+1e0lGi4FNLRUfiKSz8B+20fwEVCL5ONTtQ6DLiCVS7EOBqdYa3wGA52OIr6nj+I/1LLZqUnftz2ox7+OTzo2xnVmGSlfLZRd9ParttxBF8SdIjnk5Gnn1c/SpHqPaU907bbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XXY4vSI2; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36b00f8fbedso1397895ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712932383; x=1713537183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEvIA01ccEiylf2OqXaKsMDULTARVvUOpRx4F7QaXDY=;
        b=XXY4vSI22POPx2le/puLBftnv+ghML4JIEzhK6mYRM68xsfxmlQ1Nd8DiDrL4gg83j
         RuNefdcpRuFXmAS65uv3XSV0A6brP339zPkwLgab10V7nlqe+b3NOLYPmeXCEkb3tsPi
         N2xxKH+TYNiRgAcQvW/JA1t+0yM7C6+XPA7oiM6eQfqDTtsw11a5ESLVnhBTXvpsJ5O8
         BBQGQWDr/HNOtd/SfybaJZoX7f2uU51TREFcBU2j7NgBVsn2HUsAr69OpjiO5uaeb4pw
         B6v4EHSQvrE0JhJmeOkaf65H3/qlDL92/pilgwkAMrHMhcdjNSLoKN7Pd9QZOpTNgXMh
         HqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932383; x=1713537183;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEvIA01ccEiylf2OqXaKsMDULTARVvUOpRx4F7QaXDY=;
        b=TAJ92GhuLEKs4KO2TbkS9G1A+kE0/01WshA3wh41a0XI+LhUQYzhGw0aPFj3n6YzFb
         +Q5g3BBeLR/7rFGPTlOl+kwNABhbe4P1tOEq34f4iGaqNw4t3FKi6w2I85VeCojvt6Cu
         PyQOBjnRg3QfXCCgWygM+aZoBhPiWDvK/oubvEKCSq8xS2yjHWaHYCygLlUZ118C0Dq/
         QWJooU2SqR6CBa5DW37ny0I6WbCpY+bpnSNfaV7518ka5TM4xeum74FH1JeiMak5t6Jb
         UdQslhBjXbHXifK3nM++v62y3v5GmN3BgDUwNEnn7b5xBY8IlHOXHLIan8v2kL/IRxpg
         m34w==
X-Forwarded-Encrypted: i=1; AJvYcCVMjcc72G65x0C0dUC3gJbQd3JkcCKgWvmehnA+725GR+siW0XiZ/zh51AT8ER+Dibt7ZZJsLbJpDsHmgFvcGNTCTbh8srsv2kvklQg
X-Gm-Message-State: AOJu0Yx3cmF0afFXrZVvpUIjOiLpw3wO62s8U5S6gFKiEaykRJIA7DQ2
	j8of/y2egm21o3Qjqc5EgM79Woup3wqtKWTHJPA6ks+AbGBGiLtXZoLO5eJCz43S1d6mzvKH6ZC
	y
X-Google-Smtp-Source: AGHT+IFuOwMs94z+EWLqxi54BMVGSTglNGLYHzzX4pMeSJ5gWr1AHUM/fCT7qyUTcJbydYEGfuo6lw==
X-Received: by 2002:a92:db46:0:b0:368:974b:f7c7 with SMTP id w6-20020a92db46000000b00368974bf7c7mr2877286ilq.0.1712932382948;
        Fri, 12 Apr 2024 07:33:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b17-20020a920b11000000b0036a19d1e733sm1002825ilf.35.2024.04.12.07.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:33:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: johannes.thumshirn@wdc.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
References: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
Subject: Re: (subset) [PATCH -next 0/2] block: fix cached time in plug
Message-Id: <171293238229.82435.5231159966660263187.b4-ty@kernel.dk>
Date: Fri, 12 Apr 2024 08:33:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 11 Apr 2024 11:23:47 +0800, Yu Kuai wrote:
> Yu Kuai (2):
>   block: fix that blk_time_get_ns() doesn't update time after schedule
>   block: add plug while submitting IO
> 
> block/blk-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> [...]

Applied, thanks!

[1/2] block: fix that blk_time_get_ns() doesn't update time after schedule
      commit: 3ec4848913d695245716ea45ca4872d9dff097a5

Best regards,
-- 
Jens Axboe




