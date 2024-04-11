Return-Path: <linux-kernel+bounces-140471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCD38A1514
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE78C1C2083E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA8E145FE6;
	Thu, 11 Apr 2024 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLgV9YGx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DF3D556;
	Thu, 11 Apr 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839854; cv=none; b=bZ07dA8Mirj74RDynmwTTspHnBE0Us/ZTo6NzXloUVvepKFS3Arc4BiCHthiRY3PTHZJ2mMWry+B17Q/zLEtmEDqoMN6TLJNK7Z1y7lZIZMU0uZrL077qT9vIQS9MA34OdCwnlOf2UmETipNSBhJCt1T+WVRTv8C4s3oVFY942o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839854; c=relaxed/simple;
	bh=KFmGrFmdn3lcoh2YD9pX55yYfPAhnPK1vR7i66oVoec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BKSHieKKkkkgPbyGZzh/7X7WaypokKz5a83h35mVnG0XB90WsKQ/PFWO8/CuIQUPhYoyAF8oMxsGJrF8AqYIqmaRK5Cn8tOmSYueT0c7d4jXdBJB9tzf4vTQEesdR5er4ArC5YGDsVns/tdvppN7B3xbsBZ+oCY0y16V1LlTG1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLgV9YGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F9EC433F1;
	Thu, 11 Apr 2024 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712839853;
	bh=KFmGrFmdn3lcoh2YD9pX55yYfPAhnPK1vR7i66oVoec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sLgV9YGx9yDtIPyi2grMj1nPTa7JwRWoJZrFBvw60M1I5w+q9TCO1T1kUv55LGgtW
	 94YqXzrfJdcj24/zf2uW66cBuxiJOzbbmBC6ZydhmTAnKd4vV9k8Q88edmShczgSjS
	 OejDApPTosswUurUwYH+k+0YcboZvAhVFCLPW452GsKaX9PxaLULHgjnuS/8jXQ3R9
	 Tfu4dMpPZrb6qUZsf/UhRwbhTokkI8KAxWqXNNZRb+BQUyqkdwvmNSbHcr0yZVel0m
	 lNSxOiZSykHhfQpHn4ndKIoVo9/zurOttAJ6yZqx0VEJql3lu30uLimGe6TJYNy3lL
	 6If6iHPuuyGAw==
From: Lee Jones <lee@kernel.org>
To: Colin Foster <colin.foster@in-advantage.com>, 
 Lee Jones <lee@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <7af920eb686b719cb7eb39c832e3ad414e0e1e1a.1712258667.git.christophe.jaillet@wanadoo.fr>
References: <7af920eb686b719cb7eb39c832e3ad414e0e1e1a.1712258667.git.christophe.jaillet@wanadoo.fr>
Subject: Re: (subset) [PATCH] mfd: ocelot-spi: Use spi_sync_transfer()
Message-Id: <171283985247.2355641.18193123658485241015.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 13:50:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 04 Apr 2024 21:25:09 +0200, Christophe JAILLET wrote:
> Use spi_sync_transfer() instead of hand-writing it.
> It is less verbose.
> 
> 

Applied, thanks!

[1/1] mfd: ocelot-spi: Use spi_sync_transfer()
      commit: 1947c079bb1b78d3c2784ce99133fc046de6dbf6

--
Lee Jones [李琼斯]


