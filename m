Return-Path: <linux-kernel+bounces-141429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022438A1E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B8F1F2624D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE9135414;
	Thu, 11 Apr 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeJI5LrT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946F135A56;
	Thu, 11 Apr 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857732; cv=none; b=OtE3Lxv53+Z1pONweQaBiROWsMa4wCs+A/MDUsr0vNibcKLoS60fATBMqTnKZse9Knx35wakq1yCGVQX7ElT5JTFym8OMd/bCTXN0N1YFIRATjLtdrP/+LjNLIrAK2EZdlTIlFt5DBIJiI+kEeCNOuMulT3MGJaRoc4SuFc9u1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857732; c=relaxed/simple;
	bh=6eSLUtNm9M4Z/mZ/K0KaGlIzRfKpMg5W9j78ncpXrYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B4HPEmaME7lB7dFo54Z239kUibFUJHmf00GAmI01288N9fF9KakfpcfpFP7lASH/L3ghGMVXY5WlnFBQPYo5uHkvSiUBbnQuWqJfJqi3/Nnlpng/JvoFx92VviVYVZiK4Othi21659CD5I7au6h8jxZN/Y+U7ukCtPib/5bJrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeJI5LrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9BFC113CD;
	Thu, 11 Apr 2024 17:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712857731;
	bh=6eSLUtNm9M4Z/mZ/K0KaGlIzRfKpMg5W9j78ncpXrYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YeJI5LrTm3Ii3eSL1BLtY9Uuao/h8dhAjL/+RgAHM9b+3Rrc3tw1VDIca2rzt0N5e
	 BBfZAZWv2AijyGwhW45PT9fk592G7AmjokKsqebJqnjWwHubneIVoPA54qOKtaKQxT
	 L1clb5mrfJoTY9KuYqUvXImY06LUCxUxtSQ39Hig/ZGGc6270N8etHnsa01DF+r2S5
	 Ax6B3fD+z/ItuohEtUC3MaO6ecG36A8vd/ZYdCLiZQvifhNhPzwu70Kmceyz2kj4a0
	 wLkuzGmbYfleiLLRcPGeUEdpCFwkXB397+QCEtlyAFzlMflMBtMCr3+lPnL8JjaDj6
	 iio/6sIRCWjWA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, broonie@kernel.org, tiwai@suse.de, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240410023438.487017-1-yung-chuan.liao@linux.intel.com>
References: <20240410023438.487017-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC/soundwire: fix race conditions on remove
Message-Id: <171285772921.544231.8836162611255754833.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 23:18:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 10 Apr 2024 02:34:34 +0000, Bard Liao wrote:
> There is a possible rate condition when removing the soundwire driver.
> When the manager becomes pm_runtime active in the remove procedure,
> peripherals will become attached, and do the initialization process.
> We have to wait until all the devices are fully resumed before the
> cleanup, otherwise there is a possible race condition where asynchronous
> workqueues initiate transfers on the bus that cannot complete. This
> patchset fixes the issue by ensuring all devices are fully resumed and
> SoundWire interrupt is disabled after all jobs are done.
> The change is mainly on SoundWire. It would be better to go through
> SoundWire tree.
> 
> [...]

Applied, thanks!

[1/4] ASoC: SOF: Intel: hda: disable SoundWire interrupt later
      commit: 62707b56b2b47dfdc94d4b079c9f9bfe5a923e33
[2/4] soundwire: intel_auxdevice: use pm_runtime_resume() instead of pm_request_resume()
      commit: 6f4867fa57604fc898a63ee73fe890786b9f4a72
[3/4] soundwire: intel: export intel_resume_child_device
      commit: f2fa6865566483582aed4511ef603b44239b227b
[4/4] soundwire: intel_init: resume all devices on exit.
      commit: 4cd5ea6de156850d555e1af8244a530812ae6ff6

Best regards,
-- 
~Vinod



