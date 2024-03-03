Return-Path: <linux-kernel+bounces-89769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A549786F540
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456BA1F21399
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5E95A118;
	Sun,  3 Mar 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScUlgv/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12325A787;
	Sun,  3 Mar 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709474485; cv=none; b=QNJD2Jm7q5kxoV1zxlo0V4FKYXKIizuBJT4127LMvUSNDQ7M8p648/jBOQU3fV/W4WsOGRQhj0s2zRA+92vOApNt6EFcV90hVwHkUrWUhbHzm7c6YbrNnE16RMOBq1e0XimoJiUjVRucCIOZBGbD2b1dmTGLlfvluHWWDi/qgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709474485; c=relaxed/simple;
	bh=D4QlXce0c91s/ffFvETgwwOIaFxWa6yMBjLyBctvMOo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ikgzNOD7bxCMFifUJK0MTo+/oLeDFdg7TB5gjp+vl8A9qFlcT5fxa+MCe1SnmC8GmEkS6k0X0SyYLRuxDIIpHPAFv+bi0IK7mMIedSbb3kxptB7qdw4v3IbI49sqYZGoBOvp3tLDgwN9amS7hjyVUEtWQ0Mlzu25ARmrPmujvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScUlgv/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C821C43394;
	Sun,  3 Mar 2024 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709474483;
	bh=D4QlXce0c91s/ffFvETgwwOIaFxWa6yMBjLyBctvMOo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ScUlgv/8P7vVsi/iIa0rTXlTkk7w2dsZL1Erbny1qdbbCnbX/YAn2Xrnf7oEdqU+b
	 5exRWZJfDUukjgcah+Z5d4fkPLlGOrCS7DvDnnGHs7cZ+fvdCXz6C+OTfcVwkyXRxL
	 ArCRacqborrmxvMVq6EpnHR6RrU9C/SsX68LM3HprxfT68HVGCCisnYcvVqLS1FN0P
	 CZ2K4EL/60oa5QTITKsZP+b2yahPa3JmlHK6iGE/a7ZlMHCHacK2f9EhbWyX+WVwGm
	 Od6iwNLOVmpWN/+2YKSzY2Viv0rmdpXmlWJOADvkB5xPUdhetwPgUwKnuk9TO/xZFQ
	 OBQH9isk6eNWw==
From: Vinod Koul <vkoul@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, broonie@kernel.org, 
 pierre-louis.bossart@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 amadeuszx.slawinski@linux.intel.com
In-Reply-To: <20240219105206.335738-1-cezary.rojewski@intel.com>
References: <20240219105206.335738-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH] soundwire: Use snd_soc_substream_to_rtd() to obtain
 rtd
Message-Id: <170947448017.763853.3989657204347502636.b4-ty@kernel.org>
Date: Sun, 03 Mar 2024 19:31:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 19 Feb 2024 11:52:06 +0100, Cezary Rojewski wrote:
> Utilize the helper function instead of casting from ->private_data
> directly.
> 
> 

Applied, thanks!

[1/1] soundwire: Use snd_soc_substream_to_rtd() to obtain rtd
      commit: e17aae16acf53938deb4b7702aa4f6cee2c4a073

Best regards,
-- 
~Vinod



