Return-Path: <linux-kernel+bounces-30549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D43832059
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D1D1C23614
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8B2E642;
	Thu, 18 Jan 2024 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b="ikbQtqcS"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80452E62A;
	Thu, 18 Jan 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608811; cv=none; b=AX8LpUOjJYC7S2avyQt/C60GbBuNDho6DmIJXyvsiMWOrjE1gcjKGVGdwS2eyLyZA50Scng50FI58gwbvsWkHo6rJj3qEc+uvXB6X0g+pfku274rPjt9/r+cTCVKngewZVGKRwkhMAGeAkrldRCzYEEdGAsTp3PUg9u1GzEV/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608811; c=relaxed/simple;
	bh=KlVgFlKm98l/5i5gn0H/DQsaMi9NC15ym6z5PKe/ndc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rG68KkRQeTencZoJ2Qsc4aLB4l6GSWWSwU42UQcz6j5mN9YScN3ND2GyXXOGAtlFE40zeEfK5JHq0IZQmkPWs7SwboQFzVHdzmU1DCf/V6rWQGSaeiRJK7jV2orew7/Q0IrZI07O8Hmo1kQ2YkVACH5ixj+wgjElbsKd2JYkQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b=ikbQtqcS; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705608782; x=1706213582; i=svenjoac@gmx.de;
	bh=KlVgFlKm98l/5i5gn0H/DQsaMi9NC15ym6z5PKe/ndc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:References:
	 Date;
	b=ikbQtqcSXwBR/F/SlG1vq96ZtsvVakTcazt2VN4dnbdAlVHCKrVZGQusMG4Nv6Az
	 M28SdHXtrTTW0fSd8wBmFbV+VkRGJAQN5u5VZFBau2RTJMLoj8EmB+emP0ywS0ZEg
	 oSOrbLZ4HdQF5SbME+5eHaH1PZwyxva7Q4s0Cf3o49vpgKgTINSlPJ9eLxNnvalh0
	 enCmdBZilcC9BVtvd2bMyCrAWtJtpudA9J6aV8CkHQpYtU7xWkmlARQznDS9GgANY
	 g+60eIIc5bOwlrhDDZJqc1kUyj3yZyIj8a1+cYfvR/gIVxtISPCb9ufJb0hwvuA58
	 DNfFOXIDR6oPEPJNFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.203.86.131]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M9Wys-1rW4XS2Z6a-005VE0; Thu, 18 Jan 2024 21:13:02 +0100
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 801C38009A; Thu, 18 Jan 2024 21:13:00 +0100 (CET)
From: Sven Joachim <svenjoac@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,  patches@lists.linux.dev,
  linux-kernel@vger.kernel.org,  torvalds@linux-foundation.org,
  akpm@linux-foundation.org,  linux@roeck-us.net,  shuah@kernel.org,
  patches@kernelci.org,  lkft-triage@lists.linaro.org,  pavel@denx.de,
  jonathanh@nvidia.com,  f.fainelli@gmail.com,  sudipm.mukherjee@gmail.com,
  srw@sladewatkins.net,  rwarsow@gmx.de,  conor@kernel.org,
  allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
In-Reply-To: <20240118104310.892180084@linuxfoundation.org> (Greg
	Kroah-Hartman's message of "Thu, 18 Jan 2024 11:48:08 +0100")
References: <20240118104310.892180084@linuxfoundation.org>
Date: Thu, 18 Jan 2024 21:13:00 +0100
Message-ID: <875xzqmmcz.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:/BOJ6PS7z6Sfbe0L8CDk6zClpX0HxqwXLTdoIQwDRiilxhFr5Bt
 eprXDr06ZbzSiYxbhvaSFHnEAiHuBnJFEJ8YBHuDPbRAKdnexPem0K+agyT+AGUfK945Pow
 1OpFCegCXf9+WvLWSOP+BP41VGIl55n2ZP8ITgRKBkcsE+gBJ7BvGhzLK10QVNJJFWgG7PE
 lAivgvsGvxx2TGjQXXzqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3X9OjRY/J78=;InbGyvvnaD8oXU8ve/pkc3+5VMI
 qI+DJDy54duvjC3TjrEMkn7oLR2NaStJ83CtPrC16lZY59UQ7bcgPZ/Hr57DQFMNEm8Y7IA5i
 HK+Dd1qNzAYcL1BLQpMW8d+RpQRQfBqoB7gmSr2xai80t75CxeLLfqFfD7CBmjpxlbYCiSRji
 NYt6CX9em3iLcKobbPuVBG66LmCoSlH+7ITXt8Q0OjYfHzMGkA9BwVnx8g73j2wCCWiHfE1tX
 GljLgc/pwvW/u+kTsBsNZnUvwZbvqQdAkIs83kjiN8sNUkzrpHxN2Fot7QDHN8ll6dYqRH9hJ
 z05rT5AjTy7k4QPf182zeSqjWrfWxIsvpJqWW2ZZ30F/KdfGKHN8GSND6V81/87ag6w5a7ugL
 fN9uJA6KpAQGw4s5D7yB9X1nxdOqZ2Zx9iFyZNN7b7akLXK769lruMRvY3fvUSJstJCLi+n4L
 TiOpEfBVTUqdVhVfZM8WUQRpOiXqkynXwM3ZNB+JWWQVjQzDewKflm/uJNEWEc0pkSLYlzpwX
 Z/h4xUGwmNYBNTijjGgKw9Oz0oMFdGbAXj4JgaeaYMP95VsHKy/SSTaQAd07WKyNJkigpEVJ9
 2K8eaeETdSZsjv6NtisgNrZXVEpL5QRhwrG8DQ2XUoktylYo9xnATc1aH3zCGXp6eTEiOco4f
 5zy/z5h+NYoxG6/kffmbdQITKnSQwKSpNhUwYwjD0WjAehQrbsdWs0gSHHophNBEznCG79W/r
 8PW7Q44LRmwJ22LtLs3thzGhD/2DxMCvI9sMDqOQK4S5d0m7x13AltTRYgHO5awWYvHqfN7WA
 bGqWDqkvE9CPTPBc0rslMks4k8t+2c8L2grmBYPEF3AnQPwHUtVL/yLiz6mMYwBpmS++lb3tQ
 AjhQYq4Vzpd3fHXGPUQKwoUoOsQIc94S+tQPJ47bXjoo0GoN6Oa1/0CGxBx6c8Rg+oFtAgdfb
 mceR3Q==

On 2024-01-18 11:48 +0100, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 6.1.74 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds and works fine for me on x86_64.

Tested-by: Sven Joachim <svenjoac@gmx.de>

Cheers,
       Sven

