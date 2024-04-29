Return-Path: <linux-kernel+bounces-162055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 082EF8B555A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB42B23023
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF89D3771E;
	Mon, 29 Apr 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY1jqojp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B137169
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386539; cv=none; b=kAoB/ZHWlwfWbPoyPDC3qtL1JxwEMkcPCCJquLIrk8Zuw8C1FJScVm1QWy+dGOAbPk1BKXCjcOhdonLn/3mjiOSgwyjycfKOvsCuWuklVOuyXLP7esqtTv+Qet/IGkejTGscsxQh4YCKW3Rsj5LawNC4OPXurFVGWjSejyxvv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386539; c=relaxed/simple;
	bh=2IDhjsMhb5aYhiqCE9TtV8L5uKIoVLzCbnj3R6GZewg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dJO8sV4QmI8KegNCwsXCvgS2bfg6iEVu06fKGtpk1UdrmCcE5Clm3DiCnU4KTPb9N/fHFVaKRu9SRWTQBG5Q2Tk2lxBvJJDzxkMlCYyr2sgtcKNugNrLip+eVws8Hv9ZiPeLeqn3ESenZkWJYdgBHLQ2Is5ENhC50wCB5icVVRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY1jqojp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622B0C113CD;
	Mon, 29 Apr 2024 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714386538;
	bh=2IDhjsMhb5aYhiqCE9TtV8L5uKIoVLzCbnj3R6GZewg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sY1jqojp/kNqy2FM9Lm1z573PZOVnyeHLmzSq7ogYyxtBy0m5ixrh6NysQ1yFBrUB
	 /jdEGixdLOyQWB7C9Do0QQm7v56/9D+yZdwKEmu4C4uvou35VlRccRXsd3QlEqY7Ml
	 aBT5zlzXIJZUFwQd2WAT3dl3778e1U9/W5oc7KiiCML25nYNtp1RRxK/0vbzFk+RFA
	 GNeNXwqK+7lGdRIMCf10rbq0goSC1K1awPNqDdE3qojDmPzm5oGARRWS1yYCLWdGFh
	 OHlSD7m2WsbeEU9lDex4S2zEoZi209QeB9EBSp5/3HRrlLZpEjU4Iv37TO5ZQ7SJsA
	 L/k9+oZIm4ezw==
From: Robert Foss <rfoss@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>, David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>, Daniel Vetter <daniel@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, Maxime Ripard <mripard@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20240426122259.46808-1-luca.ceresoli@bootlin.com>
References: <20240426122259.46808-1-luca.ceresoli@bootlin.com>
Subject: Re: [PATCH RESEND] Revert "drm/bridge: ti-sn65dsi83: Fix enable error path"
Message-Id: <171438653511.2566805.2252397252665472830.b4-ty@kernel.org>
Date: Mon, 29 Apr 2024 12:28:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Fri, 26 Apr 2024 14:22:59 +0200, Luca Ceresoli wrote:
> This reverts commit 8a91b29f1f50ce7742cdbe5cf11d17f128511f3f.
> 
> The regulator_disable() added by the original commit solves one kind of
> regulator imbalance but adds another one as it allows the regulator to be
> disabled one more time than it is enabled in the following scenario:
> 
>  1. Start video pipeline -> sn65dsi83_atomic_pre_enable -> regulator_enable
>  2. PLL lock fails -> regulator_disable
>  3. Stop video pipeline -> sn65dsi83_atomic_disable -> regulator_disable
> 
> [...]

Applied, thanks!

[1/1] Revert "drm/bridge: ti-sn65dsi83: Fix enable error path"
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=2940ee03b232



Rob


