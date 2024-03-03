Return-Path: <linux-kernel+bounces-89768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A886F53F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B18B1C21596
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259A55A4C9;
	Sun,  3 Mar 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1tYmTYS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51F5A11B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709474480; cv=none; b=PLK1Nggf7dRP336RyYgUa8jT6wMbvD8AaWLyoPTNNnrADEA4FS11zBq4gaWU7zEBiZKrS5Yo1ZRpR5VqKKg8WMVdEP9B1ajP7eK2gGlf5z/moHc/KDPCoQy/+UeR5QkWbtSL1ZHXCfHin2IvACqIDh2fIxY9ss6wOOULTLDsnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709474480; c=relaxed/simple;
	bh=j3VKp9c7J/45+77Ghwq5NjSO2ANNztfISOGtRk1wXBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PaCXLQ8OiKPuCpmR4Z9/fFyLFrAStvW5d6RRvAIwgYxjI2KMf+OEgzjFKxI8aMDuvkIP/yZXosfaYC2h9ItnEyJiuyLq7Alve8Z59LegTStp9RyAFvedaR7/ToPKxxDMQujBp1h7fIpgeLo7pObS2coiVss/9g4rEC/tUXhEeRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1tYmTYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CB3C433C7;
	Sun,  3 Mar 2024 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709474479;
	bh=j3VKp9c7J/45+77Ghwq5NjSO2ANNztfISOGtRk1wXBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n1tYmTYSegn+1bkfjyFV1OqxIrXKrk5S+W9kdIDzn2EPUo6a5bf3lECn6F3Aq+I09
	 DhkaYloAzBFK4R6TxBPXEpPq8reeOUetf/ygg7Kx+uUupW4WKl1zYeytb+XTRs7hz4
	 /yw1CLOppw037wySUUonJQq1Icq3vinoE+bFAe5rtk4dM/PtEA+gOGpV/DtmJI+HxJ
	 g8XuhJ8tjvS3iEtzTwzZh6IMT/d1TNnRH0HKFzx2yl97E6N1Pe3P/Aq/gwRgkkBgch
	 htRXyUmdcWnZnamUdiViU4Xa79mFJ3z2Z3+Gn+YnV+e+yiOkiGdEvOPWMyJ5gzWj4n
	 FECSQu9PIJ6Lw==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240219-device_cleanup-soundwire-v1-1-9edd51767611@marliere.net>
References: <20240219-device_cleanup-soundwire-v1-1-9edd51767611@marliere.net>
Subject: Re: [PATCH] soundwire: constify the struct device_type usage
Message-Id: <170947447688.763853.15642162619059844196.b4-ty@kernel.org>
Date: Sun, 03 Mar 2024 19:31:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 19 Feb 2024 09:14:36 -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> sdw_master_type and sdw_slave_type variables to be constant structures as
> well, placing it into read-only memory which can not be modified at
> runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] soundwire: constify the struct device_type usage
      commit: 99fea943d9dc2500227bced9acd671e5b39a1471

Best regards,
-- 
~Vinod



