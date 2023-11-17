Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C527E7EECAE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjKQHdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:33:37 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC4109;
        Thu, 16 Nov 2023 23:33:33 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso2124010b3a.1;
        Thu, 16 Nov 2023 23:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700206412; x=1700811212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NGlGNctGDlanhrEHu2JUTOFi1+KtX2xOYnzLURQZaU=;
        b=dFPoIwuqgL5JL7Ya+2iWMuujwfjNI3Yknc0/TGsJ2+cKr1oitdKiaxyJRxKw+hVG53
         I2mINxYXt20KuuGauDxa/rQuHrIOUEaSD/JEEF4+LfjrdAqAskxMfChCAHgQSNgMITAE
         B6OuhZKu1GfP/wIt9D2oAOTZSYOHchYSU/8pU1hj2THKH6uSrk4Bi/gk+tLm3fCCzEjI
         xDQZfk0pMBEut6zdLs9GQOaBFEqN8abRNC8tsUAj4j3jhoyNz+0md+eLDgDjW0bWfJyN
         fGAXDyVWBI6B28WgqPmzsbhWvEW4ojHIuMOFTOD3xQ80HKyHNrEPBuE/NpH3KFHWVnWp
         md1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700206412; x=1700811212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NGlGNctGDlanhrEHu2JUTOFi1+KtX2xOYnzLURQZaU=;
        b=UeJQ0waOpPJa5YbC6wrxfTwrbvxj+o9KixmUXuaaokNHOYXcX3cOQoA+yA2tBSX9Rp
         SRSpUT2ob+JFUhCXk7HMxakJ3q7p1SyBoVrxWv7Uh4AnYjMaKS0RWZPKelocmN92flPu
         CVYeOVyPzVCAuW2GSXxe5JkAc8VfUQZQrUQ3Jcab6784N3vjKl2rXujhq4pekexz100W
         5cebf4j9+/XTiAxo02FKTaVVDM72uMeOY0gIgE4FNA5acoo1hvfG9BX4FMHxMOMcUA7H
         Gdz85QAlQhRA/iKrE5XRj799F3JlzVVmvO0CoOXIyzA1wPWRw1fIfAB/GW1y2hNn4uJL
         2DkA==
X-Gm-Message-State: AOJu0YwbSi5mAzQHKcfFY73geJTZGt2wcsGpOi+bwVxHOQe46mHotIiu
        8hVtMa4k9Q7dO+qG8O713f8II4ivvdEK2On5
X-Google-Smtp-Source: AGHT+IELcbxSGA2pKYWFsXT9O+cG5iALQpD9vj8Wr/lhr/eWUXju5DlXU7X/ywFCGTtjnH0IPQ493Q==
X-Received: by 2002:a05:6a20:3941:b0:15e:7323:5bf3 with SMTP id r1-20020a056a20394100b0015e73235bf3mr6267381pzg.26.1700206412414;
        Thu, 16 Nov 2023 23:33:32 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id s11-20020a65644b000000b005bcebc93d7asm705106pgv.47.2023.11.16.23.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 23:33:31 -0800 (PST)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 2/2] iio: dac: driver for MCP4821
Date:   Fri, 17 Nov 2023 13:00:38 +0530
Message-ID: <20231117073040.685860-2-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231117073040.685860-1-anshulusr@gmail.com>
References: <20231117073040.685860-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds driver for the MCP48xx series of DACs.

Device uses a simplex SPI channel.
To set the value of an output channel, a 16-bit
data of following format must be written:

Bit field | Description
15 [MSB]  | Channel selection bit
            0 -> Channel A
            1 -> Channel B
13        | Output Gain Selection bit
            0 -> 2x Gain (Vref = 4.096V)
            1 -> 1x Gain (Vref = 2.048V)
12        | Output Shutdown Control bit
            0 -> Shutdown the selected channel
            1 -> Active mode operation
11-0 [LSB]| DAC Input Data bits
            Value's big endian representation is
            taken as input for the selected DAC
            channel.
            For devices with a resolution of less
            than 12-bits, only the x most
            significant bits are considered where
            x is the resolution of the device.
Reference: Page#22 [MCP48x2 Datasheet]

Supported devices:
  +---------+--------------+-------------+
  | Device  |  Resolution  |   Channels  |
  |---------|--------------|-------------|
  | MCP4801 |     8-bit    |      1      |
  | MCP4811 |    10-bit    |      1      |
  | MCP4821 |    12-bit    |      1      |
  | MCP4802 |     8-bit    |      2      |
  | MCP4812 |    10-bit    |      2      |
  | MCP4822 |    12-bit    |      2      |
  +---------+--------------+-------------+

Devices tested:
  MCP4821 [12-bit single channel]
  MCP4802 [8-bit dual channel]

Tested on Raspberry Pi Zero 2W

Datasheet:
  [MCP48x1] https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
  [MCP48x2] https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---
 MAINTAINERS               |   7 ++
 drivers/iio/dac/Kconfig   |  10 ++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/mcp4821.c | 207 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 225 insertions(+)
 create mode 100644 drivers/iio/dac/mcp4821.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 81d5fc0bba68..8d9274c33c6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13029,6 +13029,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
 F:	drivers/iio/potentiometer/mcp4018.c
 F:	drivers/iio/potentiometer/mcp4531.c
 
+MCP4821 DAC DRIVER
+M:	Anshul Dalal <anshulusr@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
+F:	drivers/iio/dac/mcp4821.c
+
 MCR20A IEEE-802.15.4 RADIO DRIVER
 M:	Stefan Schmidt <stefan@datenfreihafen.org>
 L:	linux-wpan@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 93b8be183de6..f5adc364de30 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -400,6 +400,16 @@ config MCP4728
 	  To compile this driver as a module, choose M here: the module
 	  will be called mcp4728.
 
+config MCP4821
+	tristate "MCP4801/11/21/02/12/22 DAC driver"
+	depends on SPI
+	help
+	  Say yes here to build the driver for the Microchip MCP4801
+	  MCP4811, MCP4821, MCP4802, MCP4812 and MCP4822 DAC devices.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mcp4821.
+
 config MCP4922
 	tristate "MCP4902, MCP4912, MCP4922 DAC driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 5b2bac900d5a..55bf89739d14 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_MAX5522) += max5522.o
 obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4728) += mcp4728.o
+obj-$(CONFIG_MCP4821) += mcp4821.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
 obj-$(CONFIG_STM32_DAC) += stm32-dac.o
diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
new file mode 100644
index 000000000000..d08acf6b8993
--- /dev/null
+++ b/drivers/iio/dac/mcp4821.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
+ *
+ * Driver for Microchip MCP4801, MCP4811, MCP4821, MCP4802, MCP4812 and MCP4822
+ *
+ * Based on the work of:
+ *	Michael Welling (MCP4922 Driver)
+ *
+ * Datasheet:
+ *	MCP48x1: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
+ *	MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
+ *
+ * TODO:
+ *	- Configurable gain
+ *	- Regulator control
+ */
+
+#include <asm/unaligned.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spi/spi.h>
+
+#define MCP4821_ACTIVE_MODE BIT(12)
+#define MCP4802_SECOND_CHAN BIT(15)
+#define MCP4821_CHAN_NUM    1
+
+/* DAC uses an internal Voltage reference of 4.096V at a gain of 2x */
+#define MCP4821_2X_GAIN_VREF_MV 4096
+
+enum mcp4821_supported_drvice_ids {
+	ID_MCP4801,
+	ID_MCP4811,
+	ID_MCP4821,
+	ID_MCP4802,
+	ID_MCP4812,
+	ID_MCP4822,
+};
+
+static int mcp4821_chan_count(enum mcp4821_supported_drvice_ids device_id)
+{
+	switch (device_id) {
+	case ID_MCP4801:
+	case ID_MCP4811:
+	case ID_MCP4821:
+		return 1;
+	default:
+		return 2;
+	}
+}
+
+struct mcp4821_state {
+	struct spi_device *spi;
+	struct mutex lock;
+	u16 dac_value[2];
+};
+
+#define MCP4821_CHAN(channel_id, resolution)				\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.output = 1,						\
+		.indexed = 1,						\
+		.channel = (channel_id),				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_type = {						\
+			.sign = 'u',					\
+			.realbits = (resolution),			\
+			.storagebits = 16,				\
+			.shift = 12 - (resolution),			\
+		},							\
+	}
+
+static const struct iio_chan_spec mcp4821_channels[6][2] = {
+	[ID_MCP4801] = { MCP4821_CHAN(0, 8), {} },
+	[ID_MCP4811] = { MCP4821_CHAN(0, 10), {} },
+	[ID_MCP4821] = { MCP4821_CHAN(0, 12), {} },
+	[ID_MCP4802] = { MCP4821_CHAN(0, 8), MCP4821_CHAN(1, 8) },
+	[ID_MCP4812] = { MCP4821_CHAN(0, 10), MCP4821_CHAN(1, 10) },
+	[ID_MCP4822] = { MCP4821_CHAN(0, 12), MCP4821_CHAN(1, 12) },
+};
+
+static int mcp4821_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mcp4821_state *state;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		state = iio_priv(indio_dev);
+		mutex_lock(&state->lock);
+		*val = state->dac_value[chan->channel];
+		mutex_unlock(&state->lock);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = MCP4821_2X_GAIN_VREF_MV;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp4821_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct mcp4821_state *state;
+	__be16 write_val;
+	u8 write_buffer[2];
+	int ret;
+	bool is_value_valid = val >= 0 && val < BIT(chan->scan_type.realbits) &&
+			      val2 == 0;
+	if (mask == IIO_CHAN_INFO_RAW && is_value_valid) {
+		state = iio_priv(indio_dev);
+
+		write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
+		if (chan->channel)
+			write_val |= MCP4802_SECOND_CHAN;
+		put_unaligned_be16(write_val, write_buffer);
+		ret = spi_write(state->spi, write_buffer, sizeof(write_buffer));
+		if (ret) {
+			dev_err(&state->spi->dev,
+				"Failed to write to device: %d", ret);
+			return ret;
+		}
+
+		mutex_lock(&state->lock);
+		state->dac_value[chan->channel] = val;
+		mutex_unlock(&state->lock);
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mcp4821_info = {
+	.read_raw = &mcp4821_read_raw,
+	.write_raw = &mcp4821_write_raw,
+};
+
+static int mcp4821_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct mcp4821_state *state;
+	const struct spi_device_id *id;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
+	if (indio_dev == NULL) {
+		dev_err(&spi->dev, "Failed to allocate iio device\n");
+		return -ENOMEM;
+	}
+
+	state = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+	id = spi_get_device_id(spi);
+
+	state->spi = spi;
+	mutex_init(&state->lock);
+
+	indio_dev->name = id->name;
+	indio_dev->info = &mcp4821_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mcp4821_channels[id->driver_data];
+	indio_dev->num_channels = mcp4821_chan_count(id->driver_data);
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id mcp4821_id_table[] = {
+	{ "mcp4801", ID_MCP4801},
+	{ "mcp4811", ID_MCP4811},
+	{ "mcp4821", ID_MCP4821},
+	{ "mcp4802", ID_MCP4802},
+	{ "mcp4812", ID_MCP4812},
+	{ "mcp4822", ID_MCP4822},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, mcp4821_id_table);
+
+static const struct of_device_id mcp4821_of_table[] = {
+	{ .compatible = "microchip,mcp4801"},
+	{ .compatible = "microchip,mcp4811"},
+	{ .compatible = "microchip,mcp4821"},
+	{ .compatible = "microchip,mcp4802"},
+	{ .compatible = "microchip,mcp4812"},
+	{ .compatible = "microchip,mcp4822"},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mcp4821_of_table);
+
+static struct spi_driver mcp4821_driver = {
+	.driver = {
+		.name = "mcp4821",
+		.of_match_table = mcp4821_of_table,
+	},
+	.probe = mcp4821_probe,
+	.id_table = mcp4821_id_table,
+};
+
+module_spi_driver(mcp4821_driver);
+
+MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
+MODULE_DESCRIPTION("Microchip MCP4821 DAC Driver");
+MODULE_LICENSE("GPL");
-- 
2.42.1

