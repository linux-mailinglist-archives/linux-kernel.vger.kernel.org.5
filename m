Return-Path: <linux-kernel+bounces-29965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018888315F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F931C24AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1471F93F;
	Thu, 18 Jan 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km7Q3hJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAA1D533;
	Thu, 18 Jan 2024 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570533; cv=none; b=L4wpLRtUPresaD4LNRSx6EbDZ6/GstCRgun9NJxDfUxLOAE41ifdmU92TBdefYJixbB1zAtD8o5oyyQMwIrG/0+xKP8dCkCR/GCL+En0DvhZ5RzwD3KWM57pqr7NOUsLQHC2QJLG+pHe28SWyW+DpPhgAYNqOUTyRd83aSz5O7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570533; c=relaxed/simple;
	bh=zmnWkUQ50YwnxBoRMyZDoe6MGpBLlZ0I0mlMYpE5XkE=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=NsnIHS1lsbVPLanZ4ccMkWGqumh5KAwv7+FaMHqoiVAbZcudG+HnrzEPuEOnysEnjcgwVycRR6onyMAe0tjvu/JA+Oq4bdMZtNg22H57WHnscKKzHu4L3d1KCPHrSi4L9nl5Tl6uUGpx6o+HpX6amThjs8qkCgEGuaUHRH6P5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km7Q3hJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38C2C433F1;
	Thu, 18 Jan 2024 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705570533;
	bh=zmnWkUQ50YwnxBoRMyZDoe6MGpBLlZ0I0mlMYpE5XkE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Km7Q3hJ2oL+04mplxZ759OS3TQMymc5LVSZBVFX5TPx1BJRfQtWPwEm5MjfV+VXr7
	 /YR0fQDpRAphhvGpQI6TgQlB8czrqba2bxGh29Dr9DbulpWyEjSEgvU83LGV3q3D50
	 rB5sTm/C98fBr+bRDvbSkg17ZRLfO0kOR829MC0oQVuT9N2r83RJRO+OQkGwuR1r93
	 3rE8/RsUHGQMSyiZA04Ov1kSIKD6YjqvuV3OuWKuuacQEIz+RaaZBo8zOhphrI0M1I
	 ZzKNEoWepe73CeyMpnfYnTCqZFhyAHnhcsmdsq51k33hv6PrV7zUZxbZptZd92mLrr
	 e6nPQewoEiNHw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/5] wifi: wilc1000: fix driver_handler when committing
 initial configuration
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240115-wilc_1000_fixes-v1-2-54d29463a738@bootlin.com>
References: <20240115-wilc_1000_fixes-v1-2-54d29463a738@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 David Mosberger-Tang <davidm@egauge.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557053011.2797779.17608692195405867430.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 09:35:31 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> During firmware initial configuration in wilc_init_fw_config, the special
> driver_handler 0 should be used instead of targeting a specific virtual
> interface (either 1 or 2)
> The issue does not seem to have real consequence (both virtual interfaces
> seems to answer correctly to a Add Block Ack request with the Immediate
> policy), but lets make everything homogeneous
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

4 patches applied to wireless-next.git, thanks.

52284952cbf3 wifi: wilc1000: fix driver_handler when committing initial configuration
328efda22af8 wifi: wilc1000: do not realloc workqueue everytime an interface is added
a4f1a05b832e wifi: wilc1000: fix incorrect power down sequence
12cfc9c8d3fa wifi: wilc1000: fix multi-vif management when deleting a vif

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240115-wilc_1000_fixes-v1-2-54d29463a738@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


