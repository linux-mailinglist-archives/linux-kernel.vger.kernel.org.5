Return-Path: <linux-kernel+bounces-102019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893A387ADA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE771C228E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AB651BE;
	Wed, 13 Mar 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCOqwPWn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6252F8C;
	Wed, 13 Mar 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348252; cv=none; b=Qb4MudgcWqP66Fa1BGEn3XT81rhu48mvR6d72cTXSl7kLIuapcd6x/b/+H/K+OQ63YwJZ5DndDiDk0IJXpGBHL/xY8OPSBO6OT8NtCqvnl6fpaa08xSfKoUFLuiqKSG6oubaVKf8moP3T6g3m3Y/RUtWq2k3RbEW/u5HFvHfdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348252; c=relaxed/simple;
	bh=VTTFzsvOky8Qg//+bu+HuHKwbeUvi/yDE2Nv0TmQXFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUIMC63b99fIqLKmDZcYTNePxxF3+ILwrYEW0Z16LHCet7HYdVARhwRU3LiESt5Bob61yMLic739coTzE10VUMQg9Z3SiQOg9FJU1UIqXXmg1bLKIiV6lz/GBQCulawuZFZoitg//vvWK/HJimMKl1TEc/p3kU1ilQJfsLIafQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCOqwPWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAADC433C7;
	Wed, 13 Mar 2024 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348252;
	bh=VTTFzsvOky8Qg//+bu+HuHKwbeUvi/yDE2Nv0TmQXFA=;
	h=From:To:Cc:Subject:Date:From;
	b=tCOqwPWnVDgFqUw57rmRyoo3rHLoHwfG3u55CePgkDiSmjYDbAx2fhiVZxkji1HC4
	 CYdEaDIRvXg1oaynhHYPzkG54TYgWvpHxOgaXYnzxN/NDmlPQs5LzPlWOfPx0zeVF4
	 kW/aaP6eVMI665RHYe+rlbiAY7zcw+cw8EpKw55H1Qn34yPAkt5UWz8mu8ygRI6mYS
	 sWMHnjAmL221X2fHAVCTs5yunVrHfwVKKQCeIT26y0KT1DcNYC19+Su3C+eVil/1Ec
	 +aAnqWlBAk0ZGZqOwwRkSrMzBWNtXKdbIA8Zq3Ow9Tu9LZvO0gFERwvPZ2m8/C26gx
	 C0C1BD5Xd3eEw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rkRiF-00000000629-17bo;
	Wed, 13 Mar 2024 17:44:19 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] drm/msm/dp: fix runtime PM leaks on hotplug
Date: Wed, 13 Mar 2024 17:43:04 +0100
Message-ID: <20240313164306.23133-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As I've reported elsewhere, I've been hitting runtime PM usage count
leaks when investigated a DisplayPort hotplug regression on the Lenovo
ThinkPad X13s. [1]

This series addresses two obvious leaks on disconnect and on connect
failures, respectively.

Johan


[1] https://lore.kernel.org/lkml/Ze8Ke_M2xHyPYCu-@hovoldconsulting.com/


Johan Hovold (2):
  drm/msm/dp: fix runtime PM leak on disconnect
  drm/msm/dp: fix runtime PM leak on connect failure

 drivers/gpu/drm/msm/dp/dp_display.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.43.2


