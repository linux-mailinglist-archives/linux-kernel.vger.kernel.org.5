Return-Path: <linux-kernel+bounces-133396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3454389A33C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9701C20C95
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1BA172772;
	Fri,  5 Apr 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay1MDXUH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ECA172791
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336934; cv=none; b=q3yKpjnksmxr5oYlBfkQMBHIxU4grJMGfMDLIboWMIRp3x2BCjmmiC5AotvzVIvFtx0OFGxTgeZKEa3KuvIEEgUx56u5xaWwpbEsufv8bNN4in36d5Y+DXTsIxZbfqlQpXaPdtSUH+VGvQJSdXzoF9cCloQcyfAv0eG1DX851Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336934; c=relaxed/simple;
	bh=bB7oNyHkvKT4PfIsWvGWCvvkKlXK/RSEvYSvcEJjJfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o0PRjJKxKF8H/VNnNUaq3sdJbBXdn4paJ/2wGYwt2pYz/eD++O3IqPX0SqKamxuMnfiwCirwID/QSG5Rt3QTXUcLfcTLs1nUDLG3S17pbdYutoXU6EPxvurukgrW8aFMuMsN4afBij3UBwQI6FUgTRM4knlYuY1eXjxmTrHdQ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay1MDXUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B902C433F1;
	Fri,  5 Apr 2024 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336934;
	bh=bB7oNyHkvKT4PfIsWvGWCvvkKlXK/RSEvYSvcEJjJfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ay1MDXUHeyoL2K1xDhZWBsWIUVMBcaAGr2K2jSP9JH6ic1P7ACdeFX+Fte5sKg+zj
	 M0c5jJ6857NywjXp+pn75VCXzC/jJzud3T3OUCP6S3MYjIj6rgvBKLsL92dfj82bIZ
	 jXMRVawTulIc2m7YFJ+f1H/5D5p7uw1H2hbOBuhppMMTgmOgWblR6uNKKOx5YuTdaL
	 zSS0tDBpAFZD3A/LKyaErC1mj437J6C02z2imsAeYjIuLSgtw4jm2MIWJHY+sj3PQw
	 97vMXwy+Y8jranp+ljzPsGTi5aaPNWk6GCUJglNJzhYBuEaq0jCJVufRNIiFrSatTz
	 cTnyEPXjk+Giw==
From: Vinod Koul <vkoul@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Mikhail Kobuk <m.kobuk@ispras.ru>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
In-Reply-To: <20240321164734.49273-1-m.kobuk@ispras.ru>
References: <20240321164734.49273-1-m.kobuk@ispras.ru>
Subject: Re: [PATCH 1/2] phy: marvell: a3700-comphy: Fix out of bounds read
Message-Id: <171233693092.304466.7167467366245404657.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 22:38:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 21 Mar 2024 19:47:30 +0300, Mikhail Kobuk wrote:
> There is an out of bounds read access of 'gbe_phy_init_fix[fix_idx].addr'
> every iteration after 'fix_idx' reaches 'ARRAY_SIZE(gbe_phy_init_fix)'.
> 
> Make sure 'gbe_phy_init[addr]' is used when all elements of
> 'gbe_phy_init_fix' array are handled.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied, thanks!

[1/2] phy: marvell: a3700-comphy: Fix out of bounds read
      commit: e4308bc22b9d46cf33165c9dfaeebcf29cd56f04
[2/2] phy: marvell: a3700-comphy: Fix hardcoded array size
      commit: 627207703b73615653eea5ab7a841d5b478d961e

Best regards,
-- 
~Vinod



