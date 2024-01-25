Return-Path: <linux-kernel+bounces-38663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE283C3D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2CCB239B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D355E40;
	Thu, 25 Jan 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WADMYyeU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2235024C;
	Thu, 25 Jan 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189866; cv=none; b=DxkAL7TpI5GlFvhDb99br2pI95rudlpAMonWBJ3prmPwwuca0W2BbfP4IWyvO9QjFgrviWQ5gUzxazWqcy08+s+ru/ItRuOpxUwJT0jxLJmENbf61geCrvukBWtxtyEfw3gQEzWEJGRFZamFW2G7VnJCFhDhkXgmWiONhE011Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189866; c=relaxed/simple;
	bh=jNeHxB1/TNScc4l5QNFn2aqXN7j7fedSGmNt5Q52kTw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L63evgeO+KlWBOuqykJLUI4weNskuVGj/LDRLZTdIgGvG0MqrcdJz3e/JziRyB274bYh/O32VeQY75vCPBAzItiLJ5N/HAlQGXqrlNNj/AYryNCOLbBuDgnoukwT2hXx1vHB0n+eAdnnq0nOOdO6VD1klhs5K94L1sURF2yZadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WADMYyeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2A3C433F1;
	Thu, 25 Jan 2024 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189866;
	bh=jNeHxB1/TNScc4l5QNFn2aqXN7j7fedSGmNt5Q52kTw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=WADMYyeUjmal1gUJQd7+KY5tmvG6xi8Fp9zcr2edry1qbj6agAGS0MGTrPQJjYcjg
	 1pLBQS4WVYfAyGYUi3UrIWOCnMTSJHETBE0CPVnNxOmNHlUSoo8/6/s46Jq97dKyS0
	 fUlffBgp2fFOCNrvf+O31KXUnbIOQ7Vhorj/fck1EqQmhuzSycfsvwz1k8z5SU2Kru
	 0uLr70kVPp0IlBIrz3dbtYkoeFfJbgqUIj7OSDtN07+91cP3Qxm9hxUmkg+ggfmnNA
	 nofRTNA4ITmVv7VQuzxbILO/0sNIpREyrrfYbdUnmrNSwMNYT3Gcq5XgFcZbdcJnIy
	 Gtve43sHH706A==
From: Lee Jones <lee@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, 
 Radoslaw Biernacki <biernacki@google.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, Lee Jones <lee@kernel.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Lukasz Majczak <lma@chromium.org>
In-Reply-To: <20240119084328.3135503-4-lma@chromium.org>
References: <20240119084328.3135503-1-lma@chromium.org>
 <20240119084328.3135503-4-lma@chromium.org>
Subject: Re: (subset) [PATCH v3 3/3] mfd: cros_ec: Register EC-based
 watchdog subdevice
Message-Id: <170618986350.1469172.17149163593213396683.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 13:37:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Fri, 19 Jan 2024 08:43:27 +0000, Lukasz Majczak wrote:
> Add ChromeOS EC-based watchdog as EC subdevice.
> 
> 

Applied, thanks!

[3/3] mfd: cros_ec: Register EC-based watchdog subdevice
      commit: a1958f84deb5cdba020af725fc5003a05af4819c

--
Lee Jones [李琼斯]


