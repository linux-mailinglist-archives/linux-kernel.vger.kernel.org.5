Return-Path: <linux-kernel+bounces-10814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F18C81DC37
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 20:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200C8B21033
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C3A10783;
	Sun, 24 Dec 2023 19:54:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001AFDDA6;
	Sun, 24 Dec 2023 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193c.versanet.de ([94.134.25.60] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rHUYk-0006HY-20; Sun, 24 Dec 2023 20:54:50 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Sam Edwards <cfsworks@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Sam Edwards <CFSworks@gmail.com>,
	linux-rockchip@lists.infradead.org,
	Joshua Riek <jjriek@verizon.net>,
	linux-arm-kernel@lists.infradead.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sven Rademakers <sven.rademakers@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk3588: Fix USB PD clocks
Date: Sun, 24 Dec 2023 20:54:45 +0100
Message-Id: <170344745824.2405994.11750508038108170854.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231216021019.1543811-1-CFSworks@gmail.com>
References: <20231216021019.1543811-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Dec 2023 19:10:19 -0700, Sam Edwards wrote:
> The QoS blocks saved/restored when toggling the PD_USB power domain are
> clocked by ACLK_USB. Attempting to access these memory regions without
> that clock running will result in an indefinite CPU stall.
> 
> The PD_USB node wasn't specifying this clock dependency, resulting in
> hangs when trying to toggle the power domain (either on or off), unless
> we get "lucky" and have ACLK_USB running for another reason at the time.
> This "luck" can result from the bootloader leaving USB powered/clocked,
> and if no built-in driver wants USB, Linux will disable the unused
> PD+CLK on boot when {pd,clk}_ignore_unused aren't given. This can also
> be unlucky because the two cleanup tasks run in parallel and race: if
> the CLK is disabled first, the PD deactivation stalls the boot. In any
> case, the PD cannot then be reenabled (if e.g. the driver loads later)
> once the clock has been stopped.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3588: Fix USB PD clocks
      commit: 44de8996ed5a10f08f2fe947182da6535edcfae5

I've changed the patch to only add the ACLK_USB.
For the HCLK_* type, Rockchip added both the root as well as the
actual controller clocks, so I guess it should be the same
for the ACLK-type. Powerdomains are strange with their clock-
synchronization, so I'm opting for better save than sorry ;-)

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

