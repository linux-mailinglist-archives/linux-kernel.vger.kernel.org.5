Return-Path: <linux-kernel+bounces-7811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0911381AD87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F19B22C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BBA5247;
	Thu, 21 Dec 2023 03:32:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E36AD24;
	Thu, 21 Dec 2023 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2EA118068;
	Thu, 21 Dec 2023 11:32:26 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 11:32:26 +0800
Received: from localhost.localdomain (113.72.145.47) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 11:32:24 +0800
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>
CC: Walker Chen <walker.chen@starfivetech.com>, Xingyu Wu
	<xingyu.wu@starfivetech.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>
Subject: [PATCH v1 2/2] ASoC: starfive: Add drivers of Cadence Multi-Channel I2S Controller
Date: Thu, 21 Dec 2023 11:32:23 +0800
Message-ID: <20231221033223.73201-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add the drivers of Cadence Multi-Channel I2S Controller on the
StarFive JH8100 SoC.

The Cadence I2S Controller implements a function of the multi-channel
(up to 8-channel) bus. Each stereo channel combines functions of a
transmitter and a receiver. Each channel has independent gating, clock
and interruption control. It alos support some of these channels are
used as playback and others can also be used as record in the same time.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                              |   7 +
 sound/soc/starfive/Kconfig               |  18 +
 sound/soc/starfive/Makefile              |   4 +
 sound/soc/starfive/cdns-jh8100-i2s-pcm.c | 262 ++++++++
 sound/soc/starfive/cdns-jh8100-i2s.c     | 727 +++++++++++++++++++++++
 sound/soc/starfive/cdns-jh8100-i2s.h     | 171 ++++++
 6 files changed, 1189 insertions(+)
 create mode 100644 sound/soc/starfive/cdns-jh8100-i2s-pcm.c
 create mode 100644 sound/soc/starfive/cdns-jh8100-i2s.c
 create mode 100644 sound/soc/starfive/cdns-jh8100-i2s.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9104430e148e..f920297e1594 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20658,6 +20658,13 @@ F:	Documentation/devicetree/bindings/power/starf=
ive*
 F:	drivers/pmdomain/starfive/
 F:	include/dt-bindings/power/starfive,jh7110-pmu.h
=20
+STARFIVE JH8100 CDNS I2S CONTROLLER DRIVER
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+M:	Walker Chen <walker.chen@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/sound/cdns,jh8100-i2s.yaml
+F:	sound/soc/starfive/cdns-jh8100-i2s*
+
 STARFIVE SOC DRIVERS
 M:	Conor Dooley <conor@kernel.org>
 S:	Maintained
diff --git a/sound/soc/starfive/Kconfig b/sound/soc/starfive/Kconfig
index 279ac5c1d309..f2ee72e8536d 100644
--- a/sound/soc/starfive/Kconfig
+++ b/sound/soc/starfive/Kconfig
@@ -22,3 +22,21 @@ config SND_SOC_JH7110_TDM
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for StarFive TDM driver.
+
+config SND_SOC_JH8100_CADENCE_I2S
+        tristate "Cadence I2S Controller Device Driver for StarFive JH81=
00 SoC"
+	depends on HAVE_CLK && SND_SOC_STARFIVE
+        select SND_SOC_GENERIC_DMAENGINE_PCM
+        help
+         Say Y or M if you want to add support for I2S driver for the
+         StarFive JH8100 Cadence Multi-Channel I2S Controller device.
+
+
+config SND_SOC_JH8100_CADENCE_I2S_PCM
+        bool "PCM PIO extension for CDNS I2S driver on the StarFive JH81=
00 SoC"
+        depends on SND_SOC_JH8100_CADENCE_I2S
+        help
+         Say Y or N if you want to add a custom ALSA extension that regi=
sters
+         a PCM and uses PIO to transfer data.
+         This functionality is specially suited for I2S devices that don=
't have
+         DMA support.
diff --git a/sound/soc/starfive/Makefile b/sound/soc/starfive/Makefile
index 9e958f70ef51..9f8fd0ad6187 100644
--- a/sound/soc/starfive/Makefile
+++ b/sound/soc/starfive/Makefile
@@ -1,3 +1,7 @@
 # StarFive Platform Support
 obj-$(CONFIG_SND_SOC_JH7110_PWMDAC) +=3D jh7110_pwmdac.o
 obj-$(CONFIG_SND_SOC_JH7110_TDM) +=3D jh7110_tdm.o
+
+obj-$(CONFIG_SND_SOC_JH8100_CADENCE_I2S) +=3D jh8100-i2s.o
+jh8100-i2s-y :=3D cdns-jh8100-i2s.o
+jh8100-i2s-$(CONFIG_SND_SOC_JH8100_CADENCE_I2S_PCM) +=3D cdns-jh8100-i2s=
-pcm.o
diff --git a/sound/soc/starfive/cdns-jh8100-i2s-pcm.c b/sound/soc/starfiv=
e/cdns-jh8100-i2s-pcm.c
new file mode 100644
index 000000000000..e0172d109925
--- /dev/null
+++ b/sound/soc/starfive/cdns-jh8100-i2s-pcm.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence Multi-Channel I2S controller PCM driver
+ *
+ * Copyright (c) 2022-2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/io.h>
+#include <linux/rcupdate.h>
+#include <sound/pcm_params.h>
+#include "cdns-jh8100-i2s.h"
+
+#define PERIOD_BYTES_MIN	4096
+#define BUFFER_BYTES_MAX	(3 * 2 * 8 * PERIOD_BYTES_MIN)
+#define PERIODS_MIN		2
+
+static unsigned int cdns_jh8100_i2s_pcm_tx(struct cdns_jh8100_i2s_dev *d=
ev,
+					   struct snd_pcm_runtime *runtime,
+					   unsigned int tx_ptr, bool *period_elapsed,
+					   snd_pcm_format_t format)
+{
+	unsigned int period_pos =3D tx_ptr % runtime->period_size;
+	const u16 (*p16)[2] =3D (void *)runtime->dma_area;
+	const u32 (*p32)[2] =3D (void *)runtime->dma_area;
+	u32 data[2];
+	int i;
+
+	for (i =3D 0; i < CDNS_JH8100_I2S_FIFO_DEPTH; i++) {
+		if (format =3D=3D SNDRV_PCM_FORMAT_S16_LE) {
+			data[0] =3D p16[tx_ptr][0];
+			data[1] =3D p16[tx_ptr][1];
+		} else if (format =3D=3D SNDRV_PCM_FORMAT_S32_LE) {
+			data[0] =3D p32[tx_ptr][0];
+			data[1] =3D p32[tx_ptr][1];
+		}
+
+		iowrite32(data[0], dev->base + CDNS_JH8100_FIFO_MEM);
+		iowrite32(data[1], dev->base + CDNS_JH8100_FIFO_MEM);
+		period_pos++;
+		if (++tx_ptr >=3D runtime->buffer_size)
+			tx_ptr =3D 0;
+	}
+
+	*period_elapsed =3D period_pos >=3D runtime->period_size;
+	return tx_ptr;
+}
+
+static unsigned int cdns_jh8100_i2s_pcm_rx(struct cdns_jh8100_i2s_dev *d=
ev,
+					   struct snd_pcm_runtime *runtime,
+					   unsigned int rx_ptr, bool *period_elapsed,
+					   snd_pcm_format_t format)
+{
+	unsigned int period_pos =3D rx_ptr % runtime->period_size;
+	u16 (*p16)[2] =3D (void *)runtime->dma_area;
+	u32 (*p32)[2] =3D (void *)runtime->dma_area;
+	u32 data[2];
+	int i;
+
+	for (i =3D 0; i < CDNS_JH8100_I2S_FIFO_DEPTH; i++) {
+		data[0] =3D ioread32(dev->base + CDNS_JH8100_FIFO_MEM);
+		data[1] =3D ioread32(dev->base + CDNS_JH8100_FIFO_MEM);
+		if (format =3D=3D SNDRV_PCM_FORMAT_S16_LE) {
+			p16[rx_ptr][0] =3D data[0];
+			p16[rx_ptr][1] =3D data[1];
+		} else if (format =3D=3D SNDRV_PCM_FORMAT_S32_LE) {
+			p32[rx_ptr][0] =3D data[0];
+			p32[rx_ptr][1] =3D data[1];
+		}
+
+		period_pos++;
+		if (++rx_ptr >=3D runtime->buffer_size)
+			rx_ptr =3D 0;
+	}
+
+	*period_elapsed =3D period_pos >=3D runtime->period_size;
+	return rx_ptr;
+}
+
+static const struct snd_pcm_hardware cdns_jh8100_i2s_pcm_hardware =3D {
+	.info =3D SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_RESUME,
+	.rates =3D SNDRV_PCM_RATE_8000 |
+		SNDRV_PCM_RATE_11025 |
+		SNDRV_PCM_RATE_16000 |
+		SNDRV_PCM_RATE_22050 |
+		SNDRV_PCM_RATE_32000 |
+		SNDRV_PCM_RATE_44100 |
+		SNDRV_PCM_RATE_48000,
+	.rate_min =3D 8000,
+	.rate_max =3D 48000,
+	.formats =3D SNDRV_PCM_FMTBIT_S16_LE |
+		SNDRV_PCM_FMTBIT_S32_LE,
+	.channels_min =3D 2,
+	.channels_max =3D 2,
+	.buffer_bytes_max =3D BUFFER_BYTES_MAX,
+	.period_bytes_min =3D PERIOD_BYTES_MIN,
+	.period_bytes_max =3D BUFFER_BYTES_MAX / PERIODS_MIN,
+	.periods_min =3D PERIODS_MIN,
+	.periods_max =3D BUFFER_BYTES_MAX / PERIOD_BYTES_MIN,
+	.fifo_size =3D 16,
+};
+
+static void cdns_jh8100_i2s_pcm_transfer(struct cdns_jh8100_i2s_dev *dev=
, bool push)
+{
+	struct snd_pcm_substream *substream;
+	bool active, period_elapsed;
+
+	rcu_read_lock();
+	if (push)
+		substream =3D rcu_dereference(dev->tx_substream);
+	else
+		substream =3D rcu_dereference(dev->rx_substream);
+
+	active =3D substream && snd_pcm_running(substream);
+	if (active) {
+		unsigned int ptr;
+		unsigned int new_ptr;
+
+		if (push) {
+			ptr =3D READ_ONCE(dev->tx_ptr);
+			new_ptr =3D dev->tx_fn(dev, substream->runtime, ptr,
+					&period_elapsed, dev->format);
+			cmpxchg(&dev->tx_ptr, ptr, new_ptr);
+		} else {
+			ptr =3D READ_ONCE(dev->rx_ptr);
+			new_ptr =3D dev->rx_fn(dev, substream->runtime, ptr,
+					&period_elapsed, dev->format);
+			cmpxchg(&dev->rx_ptr, ptr, new_ptr);
+		}
+
+		if (period_elapsed)
+			snd_pcm_period_elapsed(substream);
+	}
+	rcu_read_unlock();
+}
+
+void cdns_jh8100_i2s_pcm_push_tx(struct cdns_jh8100_i2s_dev *dev)
+{
+	cdns_jh8100_i2s_pcm_transfer(dev, true);
+}
+
+void cdns_jh8100_i2s_pcm_pop_rx(struct cdns_jh8100_i2s_dev *dev)
+{
+	cdns_jh8100_i2s_pcm_transfer(dev, false);
+}
+
+static int cdns_jh8100_i2s_pcm_open(struct snd_soc_component *component,
+				    struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct snd_soc_pcm_runtime *rtd =3D snd_soc_substream_to_rtd(substream)=
;
+	struct cdns_jh8100_i2s_dev *dev =3D snd_soc_dai_get_drvdata(snd_soc_rtd=
_to_cpu(rtd, 0));
+
+	snd_soc_set_runtime_hwparams(substream, &cdns_jh8100_i2s_pcm_hardware);
+	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	runtime->private_data =3D dev;
+
+	return 0;
+}
+
+static int cdns_jh8100_i2s_pcm_close(struct snd_soc_component *component=
,
+				     struct snd_pcm_substream *substream)
+{
+	synchronize_rcu();
+	return 0;
+}
+
+static int cdns_jh8100_i2s_pcm_hw_params(struct snd_soc_component *compo=
nent,
+					 struct snd_pcm_substream *substream,
+					 struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct cdns_jh8100_i2s_dev *dev =3D runtime->private_data;
+
+	dev->format =3D params_format(hw_params);
+	dev->tx_fn =3D cdns_jh8100_i2s_pcm_tx;
+	dev->rx_fn =3D cdns_jh8100_i2s_pcm_rx;
+
+	return 0;
+}
+
+static int cdns_jh8100_i2s_pcm_trigger(struct snd_soc_component *compone=
nt,
+				       struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct cdns_jh8100_i2s_dev *dev =3D runtime->private_data;
+	int ret =3D 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+			WRITE_ONCE(dev->tx_ptr, 0);
+			rcu_assign_pointer(dev->tx_substream, substream);
+		} else {
+			WRITE_ONCE(dev->rx_ptr, 0);
+			rcu_assign_pointer(dev->rx_substream, substream);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+			rcu_assign_pointer(dev->tx_substream, NULL);
+		else
+			rcu_assign_pointer(dev->rx_substream, NULL);
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t cdns_jh8100_i2s_pcm_pointer(struct snd_soc_comp=
onent *component,
+						     struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct cdns_jh8100_i2s_dev *dev =3D runtime->private_data;
+	snd_pcm_uframes_t pos;
+
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+		pos =3D READ_ONCE(dev->tx_ptr);
+	else
+		pos =3D READ_ONCE(dev->rx_ptr);
+
+	return pos < runtime->buffer_size ? pos : 0;
+}
+
+static int cdns_jh8100_i2s_pcm_new(struct snd_soc_component *component,
+				   struct snd_soc_pcm_runtime *rtd)
+{
+	size_t size =3D cdns_jh8100_i2s_pcm_hardware.buffer_bytes_max;
+
+	snd_pcm_set_managed_buffer_all(rtd->pcm,
+				       SNDRV_DMA_TYPE_CONTINUOUS,
+				       NULL, size, size);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver cdns_jh8100_i2s_pcm_compone=
nt =3D {
+	.open		=3D cdns_jh8100_i2s_pcm_open,
+	.close		=3D cdns_jh8100_i2s_pcm_close,
+	.hw_params	=3D cdns_jh8100_i2s_pcm_hw_params,
+	.trigger	=3D cdns_jh8100_i2s_pcm_trigger,
+	.pointer	=3D cdns_jh8100_i2s_pcm_pointer,
+	.pcm_construct	=3D cdns_jh8100_i2s_pcm_new,
+};
+
+int cdns_jh8100_i2s_pcm_register(struct platform_device *pdev)
+{
+	return devm_snd_soc_register_component(&pdev->dev,
+					       &cdns_jh8100_i2s_pcm_component,
+					       NULL, 0);
+}
diff --git a/sound/soc/starfive/cdns-jh8100-i2s.c b/sound/soc/starfive/cd=
ns-jh8100-i2s.c
new file mode 100644
index 000000000000..924f12af9f3a
--- /dev/null
+++ b/sound/soc/starfive/cdns-jh8100-i2s.c
@@ -0,0 +1,727 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence Multi-Channel I2S controller driver on the StarFive JH8100 So=
C
+ *
+ * Copyright (c) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "cdns-jh8100-i2s.h"
+
+static void cdns_jh8100_i2s_set_fifo_mask(struct cdns_jh8100_i2s_dev *i2=
s, u32 type)
+{
+	unsigned int temp =3D readl(i2s->base + CDNS_JH8100_CID_CTRL);
+
+	temp &=3D ~CDNS_JH8100_I2S_IT_ALL;
+	temp |=3D type;
+	writel(temp, i2s->base + CDNS_JH8100_CID_CTRL);
+}
+
+static inline void cdns_jh8100_i2s_clear_int(struct cdns_jh8100_i2s_dev =
*i2s)
+{
+	writel(0, i2s->base + CDNS_JH8100_I2S_INTR_STAT);
+}
+
+static int cdns_jh8100_i2s_reset_mask(struct cdns_jh8100_i2s_dev *i2s, u=
32 mask)
+{
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_I2S_CTRL);
+
+	val &=3D ~mask;
+	writel(val, i2s->base + CDNS_JH8100_I2S_CTRL);
+
+	/* Wait for the reset bit to done and is set to 1 */
+	return readl_poll_timeout_atomic(i2s->base + CDNS_JH8100_I2S_CTRL, val,
+					 (val & mask), 0,
+					 CDNS_JH8100_FIFO_ACK_TIMEOUT_US);
+}
+
+/* Reset for TX and RX control unit  */
+static void cdns_jh8100_i2s_reset_txrx_unit(struct cdns_jh8100_i2s_dev *=
i2s)
+{
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_I2S_CTRL);
+
+	val |=3D CDNS_JH8100_I2S_CTRL_TXRX_RST;
+	writel(val, i2s->base + CDNS_JH8100_I2S_CTRL);
+}
+
+static void cdns_jh8100_i2s_set_ms_mode(struct cdns_jh8100_i2s_dev *i2s)
+{
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_I2S_CTRL);
+
+	val &=3D ~(CDNS_JH8100_I2S_CTRL_T_MS_MASK | CDNS_JH8100_I2S_CTRL_R_MS_M=
ASK);
+	val |=3D (FIELD_PREP(CDNS_JH8100_I2S_CTRL_T_MS_MASK, i2s->tx_sync_ms_mo=
de) |
+		FIELD_PREP(CDNS_JH8100_I2S_CTRL_R_MS_MASK, i2s->rx_sync_ms_mode));
+
+	writel(val, i2s->base + CDNS_JH8100_I2S_CTRL);
+}
+
+/* The threshold of almost empty & full config */
+static void cdns_jh8100_i2s_set_aempty_afull_th(struct cdns_jh8100_i2s_d=
ev *i2s,
+						unsigned int aempty,
+						unsigned int afull)
+{
+	unsigned int val =3D aempty | (afull << CDNS_TRFIFO_CTRL_AFULL_THRESHOL=
D_SHIFT);
+
+	writel(val, i2s->base + CDNS_JH8100_TFIFO_CTRL);
+	writel(val, i2s->base + CDNS_JH8100_RFIFO_CTRL);
+}
+
+static void cdns_jh8100_i2s_set_channel_strobes(struct cdns_jh8100_i2s_d=
ev *i2s,
+						u32 ch, bool strobe)
+{
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_CID_CTRL);
+
+	/* Active Low */
+	if (strobe)
+		val &=3D ~ch;
+	else
+		val |=3D ch;
+
+	writel(val, i2s->base + CDNS_JH8100_CID_CTRL);
+}
+
+/* Enable TX or RX clock */
+static void cdns_jh8100_i2s_enable_clock(struct cdns_jh8100_i2s_dev *i2s=
,
+					 bool is_rx)
+{
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_CID_CTRL);
+	unsigned int mask =3D (is_rx ? CDNS_JH8100_CID_CTRL_STROBE_TX :
+			     CDNS_JH8100_CID_CTRL_STROBE_RX);
+
+	/* Active Low */
+	val &=3D ~mask;
+	writel(val, i2s->base + CDNS_JH8100_CID_CTRL);
+}
+
+static void cdns_jh8100_i2s_set_transmitter_receiver(struct cdns_jh8100_=
i2s_dev *i2s,
+						     u32 ch, bool is_transmit)
+{
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_I2S_CTRL);
+
+	/* 1: Transmitter, 0: Receiver */
+	if (is_transmit)
+		val |=3D (ch << CDNS_JH8100_I2S_CTRL_TR_CFG_0_SHIFT);
+	else
+		val &=3D ~(ch << CDNS_JH8100_I2S_CTRL_TR_CFG_0_SHIFT);
+
+	writel(val, i2s->base + CDNS_JH8100_I2S_CTRL);
+}
+
+static irqreturn_t cdns_jh8100_i2s_irq_handler(int irq, void *data)
+{
+	struct cdns_jh8100_i2s_dev *i2s =3D data;
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_I2S_INTR_STAT);
+	irqreturn_t ret =3D IRQ_NONE;
+
+	cdns_jh8100_i2s_clear_int(i2s);
+
+	if (val & CDNS_JH8100_I2S_STAT_TX_UNDERRUN)
+		dev_err(i2s->dev, "TX underrun on channel %ld!\n",
+			FIELD_GET(CDNS_JH8100_I2S_STAT_UNDERR_CODE, val));
+
+	if (val & CDNS_JH8100_I2S_STAT_RX_OVERRUN)
+		dev_err(i2s->dev, "RX overrun on channel %ld!\n",
+			FIELD_GET(CDNS_JH8100_I2S_STAT_OVERR_CODE, val));
+
+	/* FIFO is empty when playback start and I2S also need to push the data=
. */
+	if (val & (CDNS_JH8100_I2S_STAT_TFIFO_AEMPTY | CDNS_JH8100_I2S_STAT_TFI=
FO_EMPTY)) {
+		cdns_jh8100_i2s_pcm_push_tx(i2s);
+		ret =3D IRQ_HANDLED;
+	}
+
+	if (val & CDNS_JH8100_I2S_STAT_RFIFO_AFULL) {
+		cdns_jh8100_i2s_pcm_pop_rx(i2s);
+		ret =3D IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static void cdns_jh8100_i2s_enable_channel(struct cdns_jh8100_i2s_dev *i=
2s,
+					   u32 ch, bool enable)
+{
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_I2S_CTRL);
+
+	/* Active High */
+	if (enable)
+		val |=3D ch;
+	else
+		val &=3D ~ch;
+
+	writel(val, i2s->base + CDNS_JH8100_I2S_CTRL);
+}
+
+/* Bit masking all interrupt requests */
+static void cdns_jh8100_i2s_set_all_irq_mask(struct cdns_jh8100_i2s_dev =
*i2s, bool mask)
+{
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_CID_CTRL);
+
+	/* Active Low: IRQ are masked */
+	if (mask)
+		val &=3D ~CDNS_JH8100_CID_CTRL_INTREQ_MASK;
+	else
+		val |=3D CDNS_JH8100_CID_CTRL_INTREQ_MASK;
+
+	writel(val, i2s->base + CDNS_JH8100_CID_CTRL);
+}
+
+static void cdns_jh8100_i2s_enable_channel_int(struct cdns_jh8100_i2s_de=
v *i2s,
+					       u32 ch, bool enable)
+{
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_CID_CTRL);
+
+	/* Active High */
+	if (enable)
+		val |=3D (ch << CDNS_JH8100_CID_CTRL_I2S_MASK_0_SHIFT);
+	else
+		val &=3D ~(ch << CDNS_JH8100_CID_CTRL_I2S_MASK_0_SHIFT);
+
+	writel(val, i2s->base + CDNS_JH8100_CID_CTRL);
+}
+
+static void cdns_jh8100_i2s_channel_start(struct cdns_jh8100_i2s_dev *i2=
s,
+					  u32 ch, bool is_transmit)
+{
+	cdns_jh8100_i2s_set_transmitter_receiver(i2s, ch, is_transmit);
+	cdns_jh8100_i2s_enable_channel(i2s, ch, true);
+	cdns_jh8100_i2s_set_channel_strobes(i2s, ch, true);
+	if (i2s->irq >=3D 0)
+		cdns_jh8100_i2s_enable_channel_int(i2s, ch, true);
+}
+
+static void cdns_jh8100_i2s_channel_stop(struct cdns_jh8100_i2s_dev *i2s=
, u32 ch)
+{
+	cdns_jh8100_i2s_enable_channel(i2s, ch, false);
+	if (i2s->irq >=3D 0)
+		cdns_jh8100_i2s_enable_channel_int(i2s, ch, false);
+}
+
+static int cdns_jh8100_i2s_start(struct cdns_jh8100_i2s_dev *i2s,
+				 struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	unsigned char max_ch =3D i2s->max_channels;
+	unsigned char i2s_ch;
+	int i;
+
+	/* Each channel is stereo */
+	i2s_ch =3D runtime->channels / 2;
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+		if ((i2s_ch + i2s->rx_using_channels) > max_ch) {
+			dev_err(i2s->dev,
+				"Max %d channels: using %d for RX, do not support %d for TX\n",
+				max_ch, i2s->rx_using_channels, i2s_ch);
+			return -ENOMEM;
+		}
+
+		i2s->tx_using_channels =3D i2s_ch;
+		/* Enable channels from 0 to 'max_ch' as tx */
+		for (i =3D 0; i < i2s_ch; i++)
+			cdns_jh8100_i2s_channel_start(i2s, CDNS_JH8100_I2S_CM_0 << i,
+						      CDNS_JH8100_I2S_TC_TRANSMITTER);
+
+	} else {
+		if ((i2s_ch + i2s->tx_using_channels) > max_ch) {
+			dev_err(i2s->dev,
+				"Max %d channels: using %d for TX, do not support %d for RX\n",
+				max_ch, i2s->tx_using_channels, i2s_ch);
+			return -ENOMEM;
+		}
+
+		i2s->rx_using_channels =3D i2s_ch;
+		/* Enable channels from 'max_ch' to 0 as rx */
+		for (i =3D (max_ch - 1); i > (max_ch - i2s_ch - 1); i--) {
+			if (i < 0)
+				return -EINVAL;
+
+			cdns_jh8100_i2s_channel_start(i2s, CDNS_JH8100_I2S_CM_0 << i,
+						      CDNS_JH8100_I2S_TC_RECEIVER);
+		}
+	}
+	cdns_jh8100_i2s_enable_clock(i2s, substream->stream);
+
+	if (i2s->irq >=3D 0)
+		cdns_jh8100_i2s_set_all_irq_mask(i2s, false);
+
+	cdns_jh8100_i2s_clear_int(i2s);
+
+	return 0;
+}
+
+static int cdns_jh8100_i2s_stop(struct cdns_jh8100_i2s_dev *i2s,
+				struct snd_pcm_substream *substream)
+{
+	unsigned char i2s_ch;
+	int i;
+
+	cdns_jh8100_i2s_clear_int(i2s);
+
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+		i2s_ch =3D i2s->tx_using_channels;
+		for (i =3D 0; i < i2s_ch; i++)
+			cdns_jh8100_i2s_channel_stop(i2s, (CDNS_JH8100_I2S_CM_0 << i));
+
+		i2s->tx_using_channels =3D 0;
+	} else {
+		unsigned char max_ch =3D i2s->max_channels;
+
+		i2s_ch =3D i2s->rx_using_channels;
+		for (i =3D (max_ch - 1); i > (max_ch - i2s_ch - 1); i--) {
+			if (i < 0)
+				return -EINVAL;
+
+			cdns_jh8100_i2s_channel_stop(i2s, (CDNS_JH8100_I2S_CM_0 << i));
+		}
+
+		i2s->rx_using_channels =3D 0;
+	}
+
+	if (i2s->irq >=3D 0 && !i2s->tx_using_channels && !i2s->rx_using_channe=
ls)
+		cdns_jh8100_i2s_set_all_irq_mask(i2s, true);
+
+	return 0;
+}
+
+static int cdns_jh8100_i2s_startup(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	struct cdns_jh8100_i2s_dev *i2s =3D snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_pcm_runtime *rtd =3D snd_soc_substream_to_rtd(substream)=
;
+	struct snd_soc_dai_link *dai_link =3D rtd->dai_link;
+
+	if (i2s->irq < 0)
+		dai_link->trigger_stop =3D SND_SOC_TRIGGER_ORDER_LDC;
+
+	return 0;
+}
+
+static void cdns_jh8100_i2s_config(struct cdns_jh8100_i2s_dev *i2s, int =
stream)
+{
+	unsigned int val =3D readl(i2s->base + CDNS_JH8100_I2S_SRR);
+
+	if (stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+		val &=3D ~(CDNS_JH8100_I2S_SRR_TRATE_MASK | CDNS_JH8100_I2S_SRR_TRESOL=
UTION_MASK);
+		val |=3D (FIELD_PREP(CDNS_JH8100_I2S_SRR_TRATE_MASK, i2s->sample_rate_=
param) |
+			FIELD_PREP(CDNS_JH8100_I2S_SRR_TRESOLUTION_MASK, (i2s->resolution - 1=
)));
+	} else {
+		val &=3D ~(CDNS_JH8100_I2S_SRR_RRATE_MASK | CDNS_JH8100_I2S_SRR_RRESOL=
UTION_MASK);
+		val |=3D (FIELD_PREP(CDNS_JH8100_I2S_SRR_RRATE_MASK, i2s->sample_rate_=
param) |
+			FIELD_PREP(CDNS_JH8100_I2S_SRR_RRESOLUTION_MASK, (i2s->resolution - 1=
)));
+	}
+
+	writel(val, i2s->base + CDNS_JH8100_I2S_SRR);
+}
+
+static int cdns_jh8100_i2s_hw_params(struct snd_pcm_substream *substream=
,
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai)
+{
+	struct cdns_jh8100_i2s_dev *i2s =3D snd_soc_dai_get_drvdata(dai);
+	unsigned int sample_rate =3D params_rate(params);
+	unsigned int channels =3D params_channels(params);
+	unsigned int fclk_hz =3D clk_get_rate(i2s->clks[2].clk); /* mclk_inner =
*/
+	unsigned int bclk_rate;
+	int ret;
+	struct snd_dmaengine_dai_dma_data *dma_data;
+
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+		dma_data =3D &i2s->tx_dma_data;
+	else
+		dma_data =3D &i2s->rx_dma_data;
+
+	switch (sample_rate) {
+	case 8000:
+		bclk_rate =3D 512000;
+		break;
+	case 11025:
+		bclk_rate =3D 705600;
+		break;
+	case 16000:
+		bclk_rate =3D 1024000;
+		break;
+	case 22050:
+		bclk_rate =3D 1411200;
+		break;
+	case 32000:
+		bclk_rate =3D 2048000;
+		break;
+	case 44100:
+		bclk_rate =3D 2822400;
+		break;
+	case 48000:
+		bclk_rate =3D 3072000;
+		break;
+	default:
+		dev_err(dai->dev, "%d rate not supported\n", sample_rate);
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dma_data->addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		dma_data->addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	default:
+		dev_err(i2s->dev, "unsupported PCM fmt\n");
+		return -EINVAL;
+	}
+
+	ret =3D clk_set_rate(i2s->clks[0].clk, bclk_rate); /* bclk */
+	if (ret < 0) {
+		dev_err(i2s->dev, "Can't set i2s bclk: %d\n", ret);
+		return ret;
+	}
+
+	i2s->resolution =3D params_width(params);
+	i2s->sample_rate_param =3D fclk_hz / (sample_rate * channels * 32);
+	cdns_jh8100_i2s_config(i2s, substream->stream);
+
+	if (i2s->irq < 0)
+		snd_soc_dai_set_dma_data(dai, substream, dma_data);
+
+	return 0;
+}
+
+static int cdns_jh8100_i2s_trigger(struct snd_pcm_substream *substream,
+				   int cmd, struct snd_soc_dai *dai)
+{
+	struct cdns_jh8100_i2s_dev *i2s =3D snd_soc_dai_get_drvdata(dai);
+	int ret =3D 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret =3D cdns_jh8100_i2s_start(i2s, substream);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ret =3D cdns_jh8100_i2s_stop(i2s, substream);
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int cdns_jh8100_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
+				   unsigned int fmt)
+{
+	struct cdns_jh8100_i2s_dev *i2s =3D snd_soc_dai_get_drvdata(cpu_dai);
+	int ret =3D 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		i2s->tx_sync_ms_mode =3D CDNS_JH8100_I2S_MASTER_MODE;
+		i2s->rx_sync_ms_mode =3D CDNS_JH8100_I2S_MASTER_MODE;
+		cdns_jh8100_i2s_set_ms_mode(i2s);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		i2s->tx_sync_ms_mode =3D CDNS_JH8100_I2S_SLAVE_MODE;
+		i2s->rx_sync_ms_mode =3D CDNS_JH8100_I2S_SLAVE_MODE;
+		cdns_jh8100_i2s_set_ms_mode(i2s);
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBS_CFM:
+		ret =3D -EINVAL;
+		break;
+	default:
+		dev_dbg(i2s->dev, "Invalid master/slave format\n");
+		ret =3D -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int cdns_jh8100_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct cdns_jh8100_i2s_dev *i2s =3D snd_soc_dai_get_drvdata(dai);
+	struct snd_dmaengine_dai_dma_data *tx =3D &i2s->tx_dma_data;
+	struct snd_dmaengine_dai_dma_data *rx =3D &i2s->rx_dma_data;
+
+	if (i2s->irq >=3D 0)
+		return 0;
+
+	/* Buswidth will be set by framework */
+	tx->addr_width =3D DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	tx->addr =3D i2s->phybase + CDNS_JH8100_FIFO_MEM;
+	tx->maxburst =3D 16;
+	tx->fifo_size =3D 16;
+
+	rx->addr_width =3D DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	rx->addr =3D i2s->phybase + CDNS_JH8100_FIFO_MEM;
+	rx->maxburst =3D 16;
+	rx->fifo_size =3D 16;
+
+	snd_soc_dai_init_dma_data(dai, tx, rx);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver cdns_jh8100_i2s_component =3D=
 {
+	.name =3D "cdns-jh8100-i2s",
+};
+
+static const struct snd_soc_dai_ops cdns_jh8100_i2s_dai_ops =3D {
+	.probe		=3D cdns_jh8100_i2s_dai_probe,
+	.startup	=3D cdns_jh8100_i2s_startup,
+	.hw_params	=3D cdns_jh8100_i2s_hw_params,
+	.trigger	=3D cdns_jh8100_i2s_trigger,
+	.set_fmt	=3D cdns_jh8100_i2s_set_fmt,
+};
+
+static struct snd_soc_dai_driver cdns_jh8100_i2s_dai =3D {
+	.name =3D "cdns-jh8100-i2s",
+	.id =3D 0,
+	.playback =3D {
+		.stream_name =3D "Playback",
+		.channels_min =3D 2,
+		.channels_max =3D 8,
+		.rates =3D SNDRV_PCM_RATE_8000_48000,
+		.formats =3D SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.capture =3D {
+		.stream_name =3D "Capture",
+		.channels_min =3D 2,
+		.channels_max =3D 8,
+		.rates =3D SNDRV_PCM_RATE_8000_48000,
+		.formats =3D SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.ops =3D &cdns_jh8100_i2s_dai_ops,
+	.symmetric_rate =3D 1,
+};
+
+static int cdns_jh8100_i2s_runtime_suspend(struct device *dev)
+{
+	struct cdns_jh8100_i2s_dev *i2s =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(i2s->clks[1].clk); /* ICG clock */
+	return 0;
+}
+
+static int cdns_jh8100_i2s_runtime_resume(struct device *dev)
+{
+	struct cdns_jh8100_i2s_dev *i2s =3D dev_get_drvdata(dev);
+
+	return clk_prepare_enable(i2s->clks[1].clk); /* ICG clock */
+}
+
+static int cdns_jh8100_i2s_crg_init(struct cdns_jh8100_i2s_dev *i2s)
+{
+	struct reset_control *reset =3D devm_reset_control_get_exclusive(i2s->d=
ev, NULL);
+	int ret;
+
+	if (IS_ERR(reset))
+		return dev_err_probe(i2s->dev, PTR_ERR(reset), "failed to get i2s rese=
ts\n");
+
+	i2s->clks[0].id =3D "bclk";
+	i2s->clks[1].id =3D "icg";
+	i2s->clks[2].id =3D "mclk_inner";
+
+	ret =3D devm_clk_bulk_get(i2s->dev, ARRAY_SIZE(i2s->clks), i2s->clks);
+	if (ret)
+		return dev_err_probe(i2s->dev, ret, "failed to get i2s clocks\n");
+
+	ret =3D clk_prepare_enable(i2s->clks[1].clk); /* ICG clock */
+	if (ret)
+		return dev_err_probe(i2s->dev, ret, "failed to enable icg clock\n");
+
+	ret =3D reset_control_deassert(reset);
+	if (ret)
+		goto rst_err;
+
+	return 0;
+
+rst_err:
+	clk_disable_unprepare(i2s->clks[1].clk);
+	return ret;
+}
+
+static int cdns_jh8100_i2s_init(struct cdns_jh8100_i2s_dev *i2s)
+{
+	int ret	=3D cdns_jh8100_i2s_crg_init(i2s);
+	unsigned int tmp;
+
+	if (ret)
+		return ret;
+
+	/* Software reset i2s controller */
+	ret =3D cdns_jh8100_i2s_reset_mask(i2s, CDNS_JH8100_I2S_CTRL_SFR_RST_MA=
SK);
+	if (ret) {
+		dev_err(i2s->dev, "Failed to reset I2S.\n");
+		return ret;
+	}
+
+	/* reset TX FIFO */
+	ret =3D cdns_jh8100_i2s_reset_mask(i2s, CDNS_JH8100_I2S_CTRL_TFIFO_RST_=
MASK);
+	if (ret) {
+		dev_err(i2s->dev, "Failed to reset tx fifo.\n");
+		return ret;
+	}
+
+	/* reset RX FIFO */
+	ret =3D cdns_jh8100_i2s_reset_mask(i2s, CDNS_JH8100_I2S_CTRL_RFIFO_RST_=
MASK);
+	if (ret) {
+		dev_err(i2s->dev, "Failed to reset rx fifo.\n");
+		return ret;
+	}
+
+	/* default master mode to init */
+	i2s->tx_sync_ms_mode =3D CDNS_JH8100_I2S_MASTER_MODE;
+	i2s->rx_sync_ms_mode =3D CDNS_JH8100_I2S_MASTER_MODE;
+	cdns_jh8100_i2s_set_ms_mode(i2s);
+
+	/* Should do it after setting Master/Slave mode */
+	cdns_jh8100_i2s_reset_txrx_unit(i2s);
+	cdns_jh8100_i2s_clear_int(i2s);
+
+	cdns_jh8100_i2s_set_aempty_afull_th(i2s, (CDNS_JH8100_I2S_FIFO_DEPTH / =
4),
+					    (CDNS_JH8100_I2S_FIFO_DEPTH / 4 * 3));
+	cdns_jh8100_i2s_set_fifo_mask(i2s, CDNS_JH8100_I2S_IT_TFIFO_AEMPTY |
+				      CDNS_JH8100_I2S_IT_RFIFO_AFULL);
+
+	i2s->rx_using_channels =3D 0;
+	i2s->tx_using_channels =3D 0;
+
+	/* cdns,i2s-max-channels is optional property and default 8 */
+	ret =3D device_property_read_u32(i2s->dev, "cdns,i2s-max-channels", &tm=
p);
+	if (ret) {
+		i2s->max_channels =3D CDNS_JH8100_I2S_CHANNEL_MAX;
+	} else {
+		if (tmp > CDNS_JH8100_I2S_CHANNEL_MAX) {
+			dev_err(i2s->dev,
+				"The number %d of max channels from DTS is out of range!\n",
+				tmp);
+			return -EINVAL;
+		}
+
+		i2s->max_channels =3D tmp;
+	}
+
+	return 0;
+}
+
+static int cdns_jh8100_i2s_probe(struct platform_device *pdev)
+{
+	struct cdns_jh8100_i2s_dev *i2s;
+	struct resource *res;
+	int ret;
+
+	i2s =3D devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
+	if (!i2s) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+	platform_set_drvdata(pdev, i2s);
+
+	i2s->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(i2s->base)) {
+		ret =3D PTR_ERR(i2s->base);
+		goto err;
+	}
+
+	i2s->dev =3D &pdev->dev;
+	i2s->phybase =3D res->start;
+
+	ret =3D cdns_jh8100_i2s_init(i2s);
+	if (ret)
+		goto err;
+
+	i2s->irq =3D platform_get_irq(pdev, 0);
+	if (i2s->irq >=3D 0) {
+		ret =3D devm_request_irq(&pdev->dev, i2s->irq, cdns_jh8100_i2s_irq_han=
dler,
+				       0, pdev->name, i2s);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "request_irq failed\n");
+			goto err;
+		}
+	}
+
+	ret =3D devm_snd_soc_register_component(&pdev->dev,
+					      &cdns_jh8100_i2s_component,
+					      &cdns_jh8100_i2s_dai, 1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "couldn't register component\n");
+		goto err;
+	}
+
+	if (i2s->irq >=3D 0)
+		ret =3D cdns_jh8100_i2s_pcm_register(pdev);
+	else
+		ret =3D devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+
+	if (ret) {
+		dev_err(&pdev->dev, "could not register pcm: %d\n", ret);
+		goto err;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	if (pm_runtime_enabled(&pdev->dev))
+		cdns_jh8100_i2s_runtime_suspend(&pdev->dev);
+
+	dev_info(&pdev->dev, "I2S supports %d stereo channels with %s.\n",
+		 i2s->max_channels, ((i2s->irq < 0) ? "dma" : "interrupt"));
+
+	return 0;
+
+err:
+	return ret;
+}
+
+static int cdns_jh8100_i2s_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		cdns_jh8100_i2s_runtime_suspend(&pdev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id cdns_jh8100_i2s_of_match[] =3D {
+	{ .compatible =3D "starfive,jh8100-i2s", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cdns_jh8100_i2s_of_match);
+#endif
+
+static const struct dev_pm_ops cdns_jh8100_i2s_pm_ops =3D {
+	SET_RUNTIME_PM_OPS(cdns_jh8100_i2s_runtime_suspend,
+			   cdns_jh8100_i2s_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static struct platform_driver cdns_jh8100_i2s_driver =3D {
+	.probe   =3D cdns_jh8100_i2s_probe,
+	.remove  =3D cdns_jh8100_i2s_remove,
+	.driver  =3D {
+		.name =3D "cdns-jh8100-i2s",
+		.of_match_table =3D of_match_ptr(cdns_jh8100_i2s_of_match),
+		.pm =3D &cdns_jh8100_i2s_pm_ops,
+	},
+};
+
+module_platform_driver(cdns_jh8100_i2s_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
+MODULE_DESCRIPTION("Cadence Multi-Channel I2S controller driver for Star=
Five JH8100 SoC");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/starfive/cdns-jh8100-i2s.h b/sound/soc/starfive/cd=
ns-jh8100-i2s.h
new file mode 100644
index 000000000000..d4e0350de7bf
--- /dev/null
+++ b/sound/soc/starfive/cdns-jh8100-i2s.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Cadence Multi-Channel I2S Controller driver header file for StarFive =
JH8100 SoC
+ *
+ * Copyright (c) 2023 StarFive Technology Co., Ltd.
+ * Author: Walker Chen <walker.chen@starfivetech.com>
+ *         Xingyu Wu <xingyu.wu@starfivetech.com>
+ */
+
+#ifndef __CDNS_JH8100_I2S_MC_H
+#define __CDNS_JH8100_I2S_MC_H
+
+#include <linux/clk.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm.h>
+
+#define CDNS_JH8100_I2S_FIFO_DEPTH		128
+#define CDNS_JH8100_FIFO_ACK_TIMEOUT_US		200
+#define CDNS_JH8100_I2S_CHANNEL_MAX		8
+
+/* I2S REGS */
+#define CDNS_JH8100_I2S_CTRL		0x00
+#define CDNS_JH8100_I2S_INTR_STAT	0x04
+#define CDNS_JH8100_I2S_SRR		0x08
+#define CDNS_JH8100_CID_CTRL		0x0c
+#define CDNS_JH8100_TFIFO_CTRL		0x18
+#define CDNS_JH8100_RFIFO_CTRL		0x1c
+#define CDNS_JH8100_FIFO_MEM		0x3c
+
+/*
+ * I2S_CTRL: I2S transceiver control register
+ */
+#define CDNS_JH8100_I2S_CTRL_TR_CFG_0_SHIFT	8
+#define CDNS_JH8100_I2S_CTRL_SFR_RST_MASK	BIT(20)
+#define CDNS_JH8100_I2S_CTRL_T_MS_MASK		BIT(21)
+#define CDNS_JH8100_I2S_CTRL_R_MS_MASK		BIT(22)
+#define CDNS_JH8100_I2S_CTRL_TFIFO_RST_MASK	BIT(23)
+#define CDNS_JH8100_I2S_CTRL_RFIFO_RST_MASK	BIT(24)
+#define CDNS_JH8100_I2S_CTRL_TXRX_RST		GENMASK(26, 25)
+
+/*
+ * I2S_INTR_STAT: I2S Interrupt status register
+ */
+#define CDNS_JH8100_I2S_STAT_TX_UNDERRUN	BIT(0)
+#define CDNS_JH8100_I2S_STAT_UNDERR_CODE	GENMASK(3, 1)
+#define CDNS_JH8100_I2S_STAT_RX_OVERRUN		BIT(4)
+#define CDNS_JH8100_I2S_STAT_OVERR_CODE		GENMASK(7, 5)
+#define CDNS_JH8100_I2S_STAT_TFIFO_EMPTY	BIT(8)
+#define CDNS_JH8100_I2S_STAT_TFIFO_AEMPTY	BIT(9)
+#define CDNS_JH8100_I2S_STAT_RFIFO_AFULL	BIT(15)
+
+/*
+ * CID_CTRL: Clock strobes and interrupt masks control register
+ */
+#define CDNS_JH8100_CID_CTRL_STROBE_TX			BIT(8)
+#define CDNS_JH8100_CID_CTRL_STROBE_RX			BIT(9)
+#define CDNS_JH8100_CID_CTRL_INTREQ_MASK		BIT(15)
+#define CDNS_JH8100_CID_CTRL_I2S_MASK_0_SHIFT		16
+
+/*
+ * I2S_SRR: Sample rate and resolution control register
+ */
+#define CDNS_JH8100_I2S_SRR_TRATE_MASK			GENMASK(9, 0)
+#define CDNS_JH8100_I2S_SRR_RRATE_MASK			GENMASK(25, 16)
+#define CDNS_JH8100_I2S_SRR_TRESOLUTION_MASK		GENMASK(15, 11)
+#define CDNS_JH8100_I2S_SRR_RRESOLUTION_MASK		GENMASK(31, 27)
+
+/*
+ * TFIFO_CTRL & RFIFO_CTRL: The FIFO thresholds control register
+ * AEMPTY: [15:0]
+ * AFULL: [31:16]
+ */
+#define CDNS_TRFIFO_CTRL_AFULL_THRESHOLD_SHIFT		16
+
+enum cdns_jh8100_i2s_channel_mask {
+	CDNS_JH8100_I2S_CM_0   =3D BIT(0),
+	CDNS_JH8100_I2S_CM_1   =3D BIT(1),
+	CDNS_JH8100_I2S_CM_2   =3D BIT(2),
+	CDNS_JH8100_I2S_CM_3   =3D BIT(3),
+	CDNS_JH8100_I2S_CM_4   =3D BIT(4),
+	CDNS_JH8100_I2S_CM_5   =3D BIT(5),
+	CDNS_JH8100_I2S_CM_6   =3D BIT(6),
+	CDNS_JH8100_I2S_CM_7   =3D BIT(7),
+	CDNS_JH8100_I2S_CM_ALL =3D GENMASK(7, 0),
+};
+
+enum i2s_int_type {
+	CDNS_JH8100_I2S_IT_TFIFO_EMPTY  =3D BIT(24),
+	CDNS_JH8100_I2S_IT_TFIFO_AEMPTY =3D BIT(25),
+	CDNS_JH8100_I2S_IT_TFIFO_FULL   =3D BIT(26),
+	CDNS_JH8100_I2S_IT_TFIFO_AFULL  =3D BIT(27),
+	CDNS_JH8100_I2S_IT_RFIFO_EMPTY  =3D BIT(28),
+	CDNS_JH8100_I2S_IT_RFIFO_AEMPTY =3D BIT(29),
+	CDNS_JH8100_I2S_IT_RFIFO_FULL   =3D BIT(30),
+	CDNS_JH8100_I2S_IT_RFIFO_AFULL  =3D BIT(31),
+	CDNS_JH8100_I2S_IT_ALL          =3D GENMASK(31, 24),
+};
+
+enum cdns_jh8100_i2s_master_slave_mode {
+	CDNS_JH8100_I2S_SLAVE_MODE =3D 0,
+	CDNS_JH8100_I2S_MASTER_MODE =3D 1,
+};
+
+enum cdns_jh8100_i2s_transmit_config {
+	CDNS_JH8100_I2S_TC_RECEIVER =3D 0,
+	CDNS_JH8100_I2S_TC_TRANSMITTER =3D 1,
+};
+
+struct cdns_jh8100_i2s_dev {
+	struct device *dev;
+	struct clk_bulk_data clks[3];
+	void __iomem *base;
+	resource_size_t	phybase; /* the physical memory */
+	int irq;
+	unsigned int sample_rate_param;
+	unsigned char resolution;
+	unsigned char max_channels /* up to CDNS_JH8100_I2S_CHANNEL_MAX */;
+	unsigned char tx_using_channels;
+	unsigned char rx_using_channels;
+
+	/*
+	 * Master (value '1') or slave (value '0') configuration bit
+	 * for unit synchronizing all transmitters(receivers) with I2S bus
+	 */
+	bool tx_sync_ms_mode;
+	bool rx_sync_ms_mode;
+
+#if IS_ENABLED(CONFIG_SND_SOC_JH8100_CADENCE_I2S_PCM)
+	/* current playback substream. NULL if not playing.
+	 *
+	 * Access to that field is synchronized between the interrupt handler
+	 * and userspace through RCU.
+	 *
+	 * Interrupt handler (threaded part) does PIO on substream data in RCU
+	 * read-side critical section. Trigger callback sets and clears the
+	 * pointer when the playback is started and stopped with
+	 * rcu_assign_pointer. When userspace is about to free the playback
+	 * stream in the pcm_close callback it synchronizes with the interrupt
+	 * handler by means of synchronize_rcu call.
+	 */
+	struct snd_pcm_substream __rcu *tx_substream;
+	struct snd_pcm_substream __rcu *rx_substream;
+	unsigned int (*tx_fn)(struct cdns_jh8100_i2s_dev *i2s,
+			      struct snd_pcm_runtime *runtime, unsigned int tx_ptr,
+			      bool *period_elapsed, snd_pcm_format_t format);
+	unsigned int (*rx_fn)(struct cdns_jh8100_i2s_dev *dev,
+			      struct snd_pcm_runtime *runtime, unsigned int rx_ptr,
+			      bool *period_elapsed, snd_pcm_format_t format);
+	snd_pcm_format_t format;
+	unsigned int tx_ptr; /* next frame index in the sample buffer */
+	unsigned int rx_ptr;
+#endif
+
+	struct snd_dmaengine_dai_dma_data tx_dma_data;
+	struct snd_dmaengine_dai_dma_data rx_dma_data;
+};
+
+#if IS_ENABLED(CONFIG_SND_SOC_JH8100_CADENCE_I2S_PCM)
+void cdns_jh8100_i2s_pcm_push_tx(struct cdns_jh8100_i2s_dev *dev);
+void cdns_jh8100_i2s_pcm_pop_rx(struct cdns_jh8100_i2s_dev *dev);
+int cdns_jh8100_i2s_pcm_register(struct platform_device *pdev);
+#else
+void cdns_jh8100_i2s_pcm_push_tx(struct cdns_jh8100_i2s_dev *dev) { }
+void cdns_jh8100_i2s_pcm_pop_rx(struct cdns_jh8100_i2s_dev *dev) { }
+int cdns_jh8100_i2s_pcm_register(struct platform_device *pdev)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif /* __CDNS_JH8100_I2S_MC_H */
--=20
2.25.1


