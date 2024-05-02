Return-Path: <linux-kernel+bounces-166635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F918B9D57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0EB1F247A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56771598E9;
	Thu,  2 May 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Sjz2gSx2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266515B10E;
	Thu,  2 May 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663448; cv=none; b=XyurQMTb7cGaFSo/GQn4EiIhEqBDgoYTo2GqC9+eqeNx/PxA89ZyrhAFpIcDbGcw93I91celnqI5CucDfy1BZqdsj+o3IQnV1d37/fNLz+OYR3PwjTdZg2nW4/Ao6tak57CVwTtp8KMzldX1t+Ba+k4GINas+wQ0zRTHA993NxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663448; c=relaxed/simple;
	bh=a+soNMe5USE1GQBlDsV+4YZguHdogyVWApppvQ4TJrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJ52JI7N1R9h4SqpMQQQcL4xlG5tFl1PMgJWvhP6/ya9Drn2EQF7qZoTgQC81+2S59mPMoMtHwgcQuJgbEWA3BsY3moCQ/AfIzdaJO23du4yO+cNyzPkvEorJOuBeqZ8FKRmtA2PcJHuECyVIpmqlmxMRdPKqvjH2ZI1xnSd1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Sjz2gSx2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714663444;
	bh=a+soNMe5USE1GQBlDsV+4YZguHdogyVWApppvQ4TJrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sjz2gSx2OQjAOH/LqLEJfS7R7htORJpiw4njKWt2DQHU9kB+y9JmGDKmbVdJVy2+d
	 qW/qENKrytt+rE3a7KTfehkzcGE1EsnNGXrvPCh5fHqUfftqVxe6tW2TT3Z3PyeL3i
	 Q7t0ENCo4gBZqTTlFBe7AqdKkZx/ADUV++QVzYVmC/rC0gTa74gJD8d/oIqbMf/ycJ
	 kolMoqpGITSG4OLU9fa0DNNOA6FBmAgbQEW/GinMMDrknd/9byWwiErAV+Bg0LLm8y
	 4Q1qr2P/44JXUczSfwv+mWqBvuaesLEBIWuVdvm1ZsSaNcBNkjWwFbG5Adh/TJRWoz
	 IOaylIvw8+2NA==
Received: from apertis.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 745C93782113;
	Thu,  2 May 2024 15:24:01 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
Date: Thu, 02 May 2024 17:22:21 +0200
Subject: [PATCH 1/2] media: v4l: async: Add
 v4l2_async_nf_unregister_cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-master-v1-1-8bd109c6a3ba@collabora.com>
References: <20240502-master-v1-0-8bd109c6a3ba@collabora.com>
In-Reply-To: <20240502-master-v1-0-8bd109c6a3ba@collabora.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Jacopo Mondi <jacopo+renesas@jmondi.org>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
 Dan Scally <djrscally@gmail.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Ripard <mripard@kernel.org>, Rui Miguel Silva <rmfrfs@gmail.com>, 
 Martin Kepplinger <martink@posteo.de>, Purism Kernel Team <kernel@puri.sm>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Dafna Hirschfeld <dafna@fastmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Yong Deng <yong.deng@magewell.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Benoit Parrot <bparrot@ti.com>, Jai Luthra <j-luthra@ti.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Michal Simek <michal.simek@amd.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
 linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org, 
 Julien Massot <julien.massot@collabora.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.13.0

Many drivers are calling v4l2_async_nf_unregister, and
v4l2_async_nf_cleanup, add a function to do it.

Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 include/media/v4l2-async.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index f26c323e9c96..cdbe63c26779 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -304,6 +304,23 @@ void v4l2_async_nf_unregister(struct v4l2_async_notifier *notifier);
  */
 void v4l2_async_nf_cleanup(struct v4l2_async_notifier *notifier);
 
+/**
+ * v4l2_async_nf_unregister_cleanup - unregister and clean up notifier resources
+ * @notifier: the notifier  the notifier to unregister and for which
+ *            the resources are to be cleaned up
+ *
+ * Unregister a subdevice asynchronous device and release memory resources
+ * related to a notifier.
+ * Convenient function to call v4l2_async_nf_unregister() and
+ * v4l2_async_nf_cleanup().
+ */
+static inline void
+v4l2_async_nf_unregister_cleanup(struct v4l2_async_notifier *notifier)
+{
+	v4l2_async_nf_unregister(notifier);
+	v4l2_async_nf_cleanup(notifier);
+};
+
 /**
  * v4l2_async_register_subdev - registers a sub-device to the asynchronous
  *	subdevice framework

-- 
2.44.0


