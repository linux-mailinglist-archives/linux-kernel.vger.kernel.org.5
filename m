Return-Path: <linux-kernel+bounces-60946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2A1850B72
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E667E1F216A5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228FA5EE67;
	Sun, 11 Feb 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGde9uU+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901B5E22B
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707683135; cv=none; b=pHKGhaLnge8ghVyGMumD15fkEMJtgWezdEdBMBoRPF1NsowCA+eevgGVRwL0zLRwX2MZmRTM8rXrMbFZEbDApZqZYnmtqY/DBCkr6bMplJczSb2QuQHYEhgm4/uAppHhetEbeWcEiCotFh3c6cLvvl/N5Fgf1g+F0lUfG0209Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707683135; c=relaxed/simple;
	bh=cKsT+yo9bDIWuQHdZCWubZ0yLxA1O8F71YQR2vqtekY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmjxiB5BLlUH5vO9/nu2OXG1MZ5z9eaTFVpLWV3KB3fRgyKC/+jzU+w2lEJQfwPRcwrlRc+jtOcJT3qGAulnJzTezEg8vE41MSWamH5w5YOvvxmiIQEoPQ0GDpRABh2XyUcPutwDFp4gE2te5tW3rntJysnrrRCIrkL7a2eOBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGde9uU+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4101d4c5772so14417725e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707683131; x=1708287931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzUk6QWHUEzr9XBpn7ygytCnVDBjeS7SWKBm+yuB2yQ=;
        b=RGde9uU+cdmbIcPIe/JiPc3yCKAC3mDL2QWW5oRcJ188CgTrF/b3TAEqTVnVGMnt9C
         2L+6xA1VZY1+qr5I8Z38lRobZ3e4SfOEX6H4HXkYszbwDzlMJ2Jexa6ClZPUQnZfxn0e
         Alga4OiMXbpJ2f593cnyz2LMzliP4dtfWenhEXof0m5DNnXOjRN7BjVUkbZs3XO2gPJ0
         6Wfiz6G9m7XrCOB+hk2nBKfKS2kSVmmPhnF8pM5WqKAZegqQjUiaAMPG0D7Axn98c/pn
         IBbhrJeBfe1w/ttu/l1SsUAB3KhHNKshaw2A+yx09sAElyV4GfUNHJhKEmReIGk3pOdP
         cJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707683131; x=1708287931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzUk6QWHUEzr9XBpn7ygytCnVDBjeS7SWKBm+yuB2yQ=;
        b=t65TtO1k9+f4zgpZk2DzXeSk7B88QHEbqLTYVVOvpNhNgBIin7nkNINdqlVNvJCTdQ
         8REAs1IThFeqEXgUHWokSHLsnw2yloyU+uBX7UveWM9KyrXAAXjJBuVzwItq/+5+cbIM
         LUG5YoauDPKJASLp0LkUnOArb/1UsIkSi31N3zrKBOLxSNO947wRmVz1gPtJdq3dAZJb
         fqcZ7afWWJvNh4u260hr9akrBBbyiwKgkplKbpuGveM2DuoQCgJG5P9sOwHFgVZJSkYp
         IAsiwe85UTrioQ7hl5HoK+4jIIbfri+iMimADeizxKLQ0OAtAHWw+UomiC1RABqKuPYz
         zFPA==
X-Forwarded-Encrypted: i=1; AJvYcCWClNThTzHbh2Nmu9Ezfu54LECbNvsPvdIBr4vVELjCG7LOfzJpMgfDCZbfKes8MIzw5UYkm7IOFYDo7VFxb5YjG0tNae9tJoJP8mW2
X-Gm-Message-State: AOJu0YzU4PKoFxN6DqCjl7UT1n/i0Hd7VjLd96agzXGG/g7mgluip4ns
	+klHamqBvNPSwqJ3SxCGI3yGpW5sTGE6lwmVYS7zRFB8sUDzf1de
X-Google-Smtp-Source: AGHT+IEaVY5znKfVD9XsjVN7CS3SzQpOfjYumpoKGVzWl2vafk0TCZAz6Aaob8H5VxlKW41qHi6dsg==
X-Received: by 2002:a05:600c:470e:b0:410:78fb:bed2 with SMTP id v14-20020a05600c470e00b0041078fbbed2mr3903287wmo.19.1707683130727;
        Sun, 11 Feb 2024 12:25:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9JeN7YH2YmPav6AR+rfZAFuoB4MkJCOUsK1ExYPdg6dJ7JTHnFzbklfWa5rySkjhgSGHutvSccaXACHWTMYPTVY/p7anscul9ZRUHWkYqW6CWNGKpyJq3EUC1/hFy3ZgN0TOUxz36gO7Vi/gREGUHB7zJthRRYkCLotxmuryenthSW16nZFjgWGilTughQ6jQ0n/whIEgCJnDvClKgwgHrq1CDbu9iGfH/4Q4WoZgMA==
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id c24-20020a05600c0ad800b004107dfa6aebsm6457721wmr.28.2024.02.11.12.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:25:30 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>
Subject: Re: [PATCH] bus: sunxi-rsb: make sunxi_rsb_bus const
Date: Sun, 11 Feb 2024 21:25:29 +0100
Message-ID: <9236043.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20240204-bus_cleanup-bus-v1-1-bda309c4b829@marliere.net>
References: <20240204-bus_cleanup-bus-v1-1-bda309c4b829@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne nedelja, 04. februar 2024 ob 16:56:44 CET je Ricardo B. Marliere napisal(a):
> Now that the driver core can properly handle constant struct bus_type,
> move the sunxi_rsb_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied, thanks!

Best regards,
Jernej



