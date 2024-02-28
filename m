Return-Path: <linux-kernel+bounces-85059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053B786AFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7AFB22B23
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A606F149DE2;
	Wed, 28 Feb 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttpAR/AR"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E34149DE5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125485; cv=none; b=LZ1TgDhAPMJYqm/sManPzzVbnTw1V4Bb+IcQYd7THCudFPpPAtm+w1gABjXLGzBZP6rEa0Fb8gOCqdTAtiP8Pxx5hFUu/ik98d3o2UzlComc3Lwjionhx2fqpI0MoHsLsOe8W64vljRQ70jrCHAPSRRAu+0hsIkfKKk57xIgq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125485; c=relaxed/simple;
	bh=g5w1gGHFGXzzZmJpBKtp41q1p8eh1BbfF3BwNq/rhXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IskYv5wQrURIhGdN+i0RAjKGnCc0UDlcciJJNXR2fM/JoBO19CztnP/cH87hiz1Piij/5sw2yoPDMR4EiyPkTQxWFzr//b0pubMG+xlEZaU8A+pqpJ6L+Kh42jcnj5p/oZAL96Q6fBGrwZa6ncudpwPTppHTjlkgjTbwBqsrSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ttpAR/AR; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so5604934276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125482; x=1709730282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5k6h2ShXlgJ8U8BtYrte9gH1UhDVvYBcQOgkCuTu28=;
        b=ttpAR/ARviixgzkkCHBHR3KHtgkCERr/ruNIwtNQu2c5762egIs+QvywmkvNC84KOf
         zq35A0sbZHivGrbeCn/G2RYA8/3fYq7GxwpZ4YbGYBH/JvRPhDW0eQ8tG9dLTFh/uemY
         GzMjlagmmmOJn5O3QEuyRCec9DWjBl0lAF0bM7rkdtcIHEcduUBlGSFckpktzyKyJhB/
         /UnKo+oj0y9zFkToPzL6VSve5AKXwdyIcaK88dW1ewuUuVR9oPI9tCUpA//u2WiR1AC6
         mmZwacev8xntQSR45qL/7kVLsghGzz2VqyxakpIHR9kfbWJvNLPZIsntpg+xCniqaf2c
         A7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125482; x=1709730282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5k6h2ShXlgJ8U8BtYrte9gH1UhDVvYBcQOgkCuTu28=;
        b=C2vNa7I4dKkayjp/958AGt76n9laX51dTUr+UDQNUlqCLTgCoTv0DzFwDxxdiL/cit
         IalFzZIeXean3ITbSoPPdbvf1PtTZmkqMg+d68ES9+z6UoH83bYea/E64t/98G5o5ywt
         S+RQKAYRtDCedSbbWIsGmcpOB2oiQEJhdgJiGz6b1Yc/u0OV04I7ksTPjVbbPttNyCQI
         YsFM6AWDwdyBO4bnoPAwe3gzQD8cW9GMgrIA09O0Sp82qVl61XE/7XAvchiVUq8JO4on
         yRSWhE3ACzVCTBFCdkKLOh9x4BcENIqifHO7qzjnY/546VZyLdFtKyEJ1hsKlUdJqO7U
         K3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnwma5gfDqXW/xjss/6nRFPWNXXCarfKIxeNr87sbLZG/P00QMWRL+AND4l6yYCyVQD6J7yCw/pkoYwtcTN2L947W1cWVKj3YOCJkZ
X-Gm-Message-State: AOJu0Ywk/qyFKYqF3A5Q7LC2O8ACkcIaeUHg4ubwvS72JEZLz1V6Ygg3
	repuqRfrWMMIrS6G4K9j0OyEOG6ThQBhpJG2B+9s0riWOTECrInfyajuIpH+3ObwJIYIRx0Hq4k
	RLd2XlJyemu/keD7WHIIEeLUe2gXk0UPChBRzqr/HtJ+aliNS
X-Google-Smtp-Source: AGHT+IHVy/3/U+YFr3kDL8D7Mz6ygkKj0BjotcensF7V9yJpyKFtEeqWYvz9KPVlNZA2YO6O8H78qdPvaSlu5PUCWr4=
X-Received: by 2002:a25:4c89:0:b0:dc7:4951:5f8 with SMTP id
 z131-20020a254c89000000b00dc7495105f8mr2637726yba.22.1709125481162; Wed, 28
 Feb 2024 05:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222191714.1216470-1-enachman@marvell.com>
In-Reply-To: <20240222191714.1216470-1-enachman@marvell.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:04:05 +0100
Message-ID: <CAPDyKFrG2JwHMesMiLfHJBxmWTB7c0wSJzxH7hceUBgH4mKfng@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix PHY init timeout issues
To: Elad Nachman <enachman@marvell.com>
Cc: huziji@marvell.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 20:17, Elad Nachman <enachman@marvell.com> wrote:
>
> From: Elad Nachman <enachman@marvell.com>
>
> Fix PHY init timeout issues:
>
> 1. Clock Stability issue causing PHY timeout
>
> 2. Timeout taking longer than needed on AC5X.
>    Solve by constantly testing the PHY init bit
>    until it toggles, but up to 100X timeout factor.
>
> v2:
>     1) convert polling loop to read_poll_timeout()
>        for both patches.
>
> v3:
>     1) Add Acked-by, Fixes and CC for stable
>
> Elad Nachman (2):
>   mmc: xenon: fix PHY init clock stability
>   mmc: xenon: add timeout for PHY init complete
>
>  drivers/mmc/host/sdhci-xenon-phy.c | 48 ++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 9 deletions(-)
>

Applied for fixes, thanks!

Kind regards
Uffe

