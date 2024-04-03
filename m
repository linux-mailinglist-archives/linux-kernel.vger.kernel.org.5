Return-Path: <linux-kernel+bounces-129557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCFE896C87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5881C2717D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D02146004;
	Wed,  3 Apr 2024 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j/22ch7o"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328314533D;
	Wed,  3 Apr 2024 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140283; cv=none; b=sv2dYfbpq2hewbm0i6Rg0sORr206neLcU8LHKIcodBBsqbp6iKPoaJF0twmWoqdQfOvEA/7cy6Q9OYgK4TGKo4sQ7yGvUBajHRCREEfw3tiFHmSpYWVxebR1AuTF5uxxp28ubEHL/Wsrs6UXPHxSmmiYvipZl5JWS5hJompOdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140283; c=relaxed/simple;
	bh=G81Bl2oY80KerS9z0ERkAhQGQ8vpcQZcKpbMP8LjyI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsPbEgqHmzOMltrBWb+OsurFzlF1ijQgx6mj7ES5rMWMgOwMEwJ/BJ8CiJZITkafqP2/VEGOhcVsDHoPJbACgBBdoCEZu8Kv4kTlXkx9ZLT8rrPhfEijICk7HbsdbBOSIHaDxt76kqZMGE/bwvCi9CZ0RdXCedpYgr3ZNklB000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j/22ch7o; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712140280;
	bh=G81Bl2oY80KerS9z0ERkAhQGQ8vpcQZcKpbMP8LjyI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/22ch7okC3mvb511TMrUp7Sbl+iWAGaoF15F49bQdbl3x9+8q6IzjrBOi4cNpKwn
	 XXu3pAuv4Wu01+py073+ZW0aZCDxrNGzumrAUAxaqAj0YwLKUD42AjMbrpcu1R7o29
	 y/0yH4fcD0HMZBwyQm1ZAcIyMBk/qA4DfRkBbHJTI16DjM/cVUIzdCuwwiEvXItVa9
	 YA+cxHE85m2j9SnOyWmh9YKtuGuOgG0DdhkEp32VBCVMye52LY0irc7Pt6F6t65EOP
	 FNjg4185qvgHuMoEL5cpHEgn5Stij508xyCqcwTE31BYohY8mYuiyngPsnSgdP5urG
	 jxz7EJARfjw6A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E7AC137820EF;
	Wed,  3 Apr 2024 10:31:18 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Pin-yen Lin <treapking@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	"Nancy.Lin" <nancy.lin@mediatek.com>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] Update Vgpu minimum voltage for MT8183, MT8186, MT8192, MT8195
Date: Wed,  3 Apr 2024 12:30:56 +0200
Message-ID: <171213179799.60933.15666408119514400881.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315111621.2263159-1-treapking@chromium.org>
References: <20240315111621.2263159-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Mar 2024 19:16:01 +0800, Pin-yen Lin wrote:
> Use the minimum voltage listed on the Vgpu regulator datasheets instead
> of the minimum value on GPU OPP table. This is because the requested
> voltage could be lower when the MTK Smart Voltage Scaling (SVS) driver
> is enabled.
> 
> Also update the incorrect MT6315 regulator usages on MT8192 and MT8195.
> 
> [...]

Applied to v6.9-fixes/dts64, thanks!

[1/4] arm64: dts: mediatek: mt8192-asurada: Update min voltage constraint for MT6315
      commit: 374a7c6400e314458178255a63c37d6347845092
[2/4] arm64: dts: mediatek: mt8195-cherry: Update min voltage constraint for MT6315
      commit: e9a6b8b5c61350535c7eb5ea9b2dde0d5745bd1b
[3/4] arm64: dts: mediatek: mt8183-kukui: Use default min voltage for MT6358
      commit: 296118a8dc297de47d9b3a364b9743f8446bd612
[4/4] arm64: dts: mediatek: mt8186-corsola: Update min voltage constraint for Vgpu
      commit: 366940c860bc27cc1cc92061e6626a4fa56bab3c

Cheers,
Angelo


