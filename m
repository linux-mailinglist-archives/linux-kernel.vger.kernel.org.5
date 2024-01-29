Return-Path: <linux-kernel+bounces-42552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD94C840301
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B37283BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA9D57865;
	Mon, 29 Jan 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Jv5qG8SS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1956B67;
	Mon, 29 Jan 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524920; cv=none; b=MzhhkOKKrTN4i8Cb4N6dYXtfiQb0ebQmngNjXfaOLnsXU9GUaPDhNok7WwLqscLIj2efRyePs6VxeTeQIgTB3V0VNrHgq2vktr2MmSwdWYnVOpCO3eTFqhzilu55Bat4faqj7cGdw3fexU7yopszL0amyk62Fi5SKt3DKZ91oZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524920; c=relaxed/simple;
	bh=GyZE3tofuMTrXIfTvVfxNMaOpNxg3EU4yJp5f+lxPTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9/tJdltmrjlhZYglVlVDkzq4jLhjD6cY/84nWTANQPD0EOPMajuHbPhLVCDaFxc+ATCtmKS5zJt6KiDfJRqAcs2X1lfuctoWakBbJ8CzXiqxkdNLAwGNp8AZnFP/nzMrXnH9JOlEu1spkMRy1ZQLmG5r4JP/s2EujMP69oP75k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Jv5qG8SS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706524917;
	bh=GyZE3tofuMTrXIfTvVfxNMaOpNxg3EU4yJp5f+lxPTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jv5qG8SSaQFqQ2xSK0SXYTy6LVvVgsPfp6OIEzPpRkTIwTOs4/dNOvgDgUNl+M9B+
	 bStNDVlaqmSOXAFt1z7OqW1e/Dv3c3INqiYXOVULXx0DTmflMRCGWP3IRrYI4gl8og
	 lbbVjUpSjsuyTAU4oRh9ub4QeXorFIY/7vbpxJfG/G6u7H6P4i5ci15ytnBfqg7uwD
	 CEphDztKKpK6Ws0A5rRiLjiR5hzuZjOcyu2iiqlv50zVhDa1Y996Os5kFOEyuslt9M
	 pvK5bQou7QRpVwAWMfaiz0279Tl1W1u7FqrdjZIbaYifyeKlWtCYwGxHOJx7tDmB+k
	 gKM901lqZbiLQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7440C3780C1F;
	Mon, 29 Jan 2024 10:41:56 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	matthias.bgg@gmail.com,
	linux-mediatek@lists.infradead.org,
	Eugen Hristev <eugen.hristev@collabora.com>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	bin.liu@mediatek.com
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v3 1/2] dt-bindings: media: mediatek-jpeg-encoder: change max iommus count
Date: Mon, 29 Jan 2024 11:41:43 +0100
Message-ID: <170652472373.127352.5854831299483160743.b4-ty@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127084258.68302-1-eugen.hristev@collabora.com>
References: <20240127084258.68302-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 27 Jan 2024 10:42:57 +0200, Eugen Hristev wrote:
> MT8186 has 4 iommus in the list, to cope with this situation, adjust
> the maxItems to 4 (instead of previous 2).
> Add also minItems as 2 to keep compatibility with current devices.
> 
> 

Applied to v6.4-next/dts64, thanks!

[1/2] dt-bindings: media: mediatek-jpeg-encoder: change max iommus count
      commit: b824b32dd5e98221cbe2e8bcccc6fb4134e35fc1
[2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
      commit: 4c5b46fbf52d52b0f392f0fc3913560bad438e49

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

