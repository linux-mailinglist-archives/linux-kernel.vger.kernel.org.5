Return-Path: <linux-kernel+bounces-85054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0D86AFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAF42895D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4641B148FFC;
	Wed, 28 Feb 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pw+6PQb4"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51D1474B8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125439; cv=none; b=kGChgxZ3J7ohvFVYnpkAPl9+jsZe96uevsi5FGUczYkYBmL3v9NoEMmhghoLxwMGpxSWelVj7CSREqB5z0INs4wnSx/zWBv8Vue7XH1lCqy2eZoQ5pGe4Z6gvz1bvn5andyQkRMALw2ZzEyzUnfqtG/S5bpr9YcHKUshtq3a6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125439; c=relaxed/simple;
	bh=3qgWyPf10iKebqhB2KICc7DLId+eIxc5dDrve2noQgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHHB3sYS42FMQLVNQgSYMwRsIwqMaTyp2czRJbMPVd1e2YQLaUk2CKKo8efq6UAUnp3Puc08AhKFsO6mZjACvTUEdACUVzi4LuJimMWqBM0nMfL+TaCXwpQ1AAuTjczxq+ekdBCeQDUF1Ua/YE2r5NP3ZjEgYfyOKrJetYfTnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pw+6PQb4; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso5696530276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125437; x=1709730237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VX2u2nL7Gqt0bJC0pWxjYsm9zcaPhxS427Aecf5U9kI=;
        b=Pw+6PQb4V6zNwJYfN9XvITTrrlfyb3FJHM16E4FA6XiaZh9A+yI++2JXTUTTfLJrms
         u6t9/8USpx5sKhX+2EpRenrezExwxzdhQURkeoK8pdpBSUfX5fEKNP4aUpAlmrI3FYBD
         gtcVXw1eEnE/Ar1MFhyV84YbUdDIbo2RFuDoLCk5gI2gPqAbn4MmIetAWtKxtqEUX5Kg
         0P3zqmXyMHGBkU7eh1OORFu4jvft58JlEF0e413qRQGv7Qy9tNQK0OqlRT1w3WpdlxGQ
         5yANQ8Zv4/z3vpWzNkRa1QA/y68Q7eLVPnxfee/IgWWPp9hFsjke+sL6VG4lCxCHNfTX
         1oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125437; x=1709730237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VX2u2nL7Gqt0bJC0pWxjYsm9zcaPhxS427Aecf5U9kI=;
        b=ZeTYbFatX/K7w2V9oORgufRTOSwCf+cCBEXftjsL/16WI8ToxMIkAogppBN+RV5a6L
         rtHJeYnmyVgkxqI9eK5dsdCQNzV+yuZx8Qw7+PlYxWd3M8GRcbasD7Wd3ZIjCk/LmEIL
         G9/Vwo/8CTX5zVByZK66sLfntMa15BhfQk9aESHeeEUjqPvFLYeiU1sXjB3T3C7IZLqh
         AZ2a4b6PEh+9JpiiII0B34kny3fEiQlrvIZtF1sdX10mmTc3dTXwUhZST3TIbZL+M84X
         JskBCkU6MTSe/GpgQPRlUb8M+CBu54kKP56WSbstRgG1139z3sBI89SRHFGQiuSNSz4D
         shXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGcvEyJOYchGLFqfbfwKvfVPFOL2zEUk8Mksi45drbkVtZoSLnw3+n4b4EJIsXyqPvgBVSnwerFB4wnDqDfnvjDMInk46opPUs2lBB
X-Gm-Message-State: AOJu0YxeZ61TvZzGajuKNh393BcRVelevvuE+W9MiLXLiZs1cVw6FSXr
	elhuMx1ENDpzyOMFTQIySnBySuPPCPVvwCobIxKfg/4VO1LrHsIA1jmwLQUaubyaaR4RjdTXO21
	kOPY34mzGpctGhc1yRLBJktEoDHEk45GhTf0ksOrrME0Stdzs
X-Google-Smtp-Source: AGHT+IGb0wKrNLfu+onaUcRz1WakEHJECK+0R1Q9sc80YpD8cv6nB87hp1e+C6g9lbDPslASPWL18AGsU0obol0veCI=
X-Received: by 2002:a05:6902:2486:b0:dc7:423c:b8aa with SMTP id
 ds6-20020a056902248600b00dc7423cb8aamr2408268ybb.12.1709125437091; Wed, 28
 Feb 2024 05:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217100200.1494980-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20240217100200.1494980-1-martin.blumenstingl@googlemail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:03:20 +0100
Message-ID: <CAPDyKFqGWm3pFr5KOEc6c_n+b+NJe9PV_T65bU5udRQPZX72QA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mmc: meson-mx-sdhc: two small cleanups
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 11:02, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello Ulf,
>
> here are two small cleanups for the meson-mx-sdhc driver.
>
> The first one is resolves a TODO comment from when the driver was
> originally introduced where devm_clk_hw_get_clk() was not available
> yet. Nowadays it is and we can and should use it.
>
> The second one removes an incorrect .card_hw_reset callback from the
> driver's mmc_host_ops. This part has never been correct as we're
> resetting the host controller, not the card. It didn't seem to cause
> any issues so far, which is why I don't think that it's -stable
> material.
>
>
>
> Martin Blumenstingl (2):
>   mmc: meson-mx-sdhc: Use devm_clk_hw_get_clk() for clock retrieval
>   mmc: meson-mx-sdhc: Remove .card_hw_reset callback
>
>  drivers/mmc/host/meson-mx-sdhc-clkc.c | 43 ++++++++++++++-------------
>  drivers/mmc/host/meson-mx-sdhc-mmc.c  | 13 ++++----
>  2 files changed, 28 insertions(+), 28 deletions(-)

Applied for next, thanks!

Kind regards
Uffe

