Return-Path: <linux-kernel+bounces-161409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69BD8B4BA3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F451C20C63
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CCE6A8A7;
	Sun, 28 Apr 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PfwehLZk"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2026.outbound.protection.outlook.com [40.92.40.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488B5F861;
	Sun, 28 Apr 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714306168; cv=fail; b=QKXsEVK8MGX6H0jUt2XC58pOCG83TJoknM2h5aJ/MWF+BadctdS/Hlh6pUmbD5Xi9CAF9hFe/pcAan2fk6uLJzIgasxX3JS0NrCryL6O0uVMkzTZ6vkPawrr/xD57AjYRJOwVHNFN6gX3dfbAx3JDylbYqnmCMcebiPAwb4EZFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714306168; c=relaxed/simple;
	bh=DpNkEdjg3twmzMbf8+GIxZPd7L2cvXAZbV/14fIa9HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kzGfCt54gFkART4Xm4aNlxD18PK1QUvcpDZdPSbH3Ee/ZQhKeW76SkKsHt7Y1kkkaF4PxTYqS9PLNiSE9o4l/JNhhtIToveWs8KHA7VeF5/9fQDtuPno66T+O2+jt7bBalqrMaxWKdr0CEkbQKCwcfKsvUhyZvsykECLRSR+iYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PfwehLZk; arc=fail smtp.client-ip=40.92.40.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay69aXJ2H6Fe5mLP74BNWPLF8IHY/djbydTrHmz1Nu5wLxc/UsfOiPxlyKdX14Ipl01ajXZDkykv91zPOT5a2bQDvzHPXh63cT4Di7qVlyuzoBLl+FY2b7Jd9i8XPfWq5ZcxLrDRr/eGsEoK2Vn2wtl0Usmx7m4YLOJDq0hzxxIxK3oKP48kOGaY4zO4ZZ0b3wU0ns+rw51MLjT7KSydzB3bm4mflih3KAaLklvlySuHc72q4lzDmapjobqFevx0m7MUvVEGbhGwvZQ3R/LVHUhnV4BV6StTxl28Y09b/1EPxRwBEco6chNsRa9KTuFwSSBGtXvHgWVta3JyEPyZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDgB5qtOOtf1XCaspKScuoVRrw9EoZPhrMFV1aA1lp8=;
 b=Gjbhgt4LR1b2pLDIwyrYzm9nQnje8plKuedR/5bt/SaTIo2e83mGSEzDwiK/6+uX3MtJ35OB5qAb4vim+DY4YCa4XWVFb4pPgAiEv7q2rYipQYAlRMceoCVm4U3Rqr8moYXsMTEUMFmOm4TO5s050vuCE10odML+EqaQDwuZwVje5gnFn8qhJDxx9GzU7RVoH7lOoUlN8HGfyBCI9eob9/uDFPnms3Dosj4E6uuCMMsrZtgUhR67FS46qaeji41iZUrwhE36y4djCRu7vG/bFPzxucet80U4JumQ2QboWBhVYnSwx1sep4uLuzuSWIo95jMFrEiwicl+j4yvldaNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDgB5qtOOtf1XCaspKScuoVRrw9EoZPhrMFV1aA1lp8=;
 b=PfwehLZkyJWENOv4txAgAueGn0pJMEgyIPz3655IhowZiM+6p9WDdOPwwI8Ml9LCpYs3CyqcXqpNRzWDJUoeoVqb+cYe1aYvuVZh+5NHDpn3MIOmeHSxbPnk5NVAC97V6PIrassPF3Meknc1Hd/VkD+P59O/IEGeVcvjzMJYXU9nRnjsY7RmnB+rbrDViwkt6HlgNoVbuA6BrO7BSlJz5WQK/9tHDE8Pb1qUrnhHqC9EVQm/bbOfV2C0VYw12545UTnqlQSrhfvD/rPIv900jaBIrAez6fyaHsyRMgiXVBvbCacBp/S+q3VaWAyEsvm3H7sdZ3++AqSbHMErkPzFxw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5644.namprd20.prod.outlook.com (2603:10b6:930:98::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 12:09:23 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 12:09:23 +0000
Date: Sun, 28 Apr 2024 20:09:48 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Guenter Roeck <linux@roeck-us.net>, 
	Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jean Delvare <jdelvare@suse.com>, Stephen Boyd <sboyd@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Wei Xu <xuwei5@hisilicon.com>, Huisong Li <lihuisong@huawei.com>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: soc: sophgo: Add SG2042 external hardware
 monitor support
Message-ID:
 <IA1PR20MB49532EAE5B31E2B45CCA9CC8BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49532A8A0C52FE5C599B6D13BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953A6EF6ED0CD082B60DD80BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
 <540cad62-db3d-4876-81a4-da396628e5ef@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <540cad62-db3d-4876-81a4-da396628e5ef@roeck-us.net>
X-TMN: [sFqlOrWNFCDs0kkaHoEvdD8leoAbzcH0JKns2g22UZQ=]
X-ClientProxiedBy: TYAPR01CA0198.jpnprd01.prod.outlook.com
 (2603:1096:404:29::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <6w7piz4z6q23m4ehdy5txosweludztownl2xxtz5ryqyjgrkqp@l2kl6r6qkbft>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 68babc01-1fce-46ea-c415-08dc677c0a73
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	1EIYjvef9/sNvv5xjjhbdiP57f7JAkIC/ihKLYXOhn5Fuq9hj7q/xnqgeiolibjQteiEOjs55xTsCd4i2FocXQWQIu2P680JNuV6q5fkl+3FlMZ3dkgWnyqfBnPRFwSC6yi4ddVq2B+yY1sP0sYK3cSdzSXj1BeTZAAD98Qm3TqlIXNVhk/W47ZRg32BmWgVySqkwR6TheB7M1YPavauc3I4kEUMHn6eebYkpBhS6H6ggLaspuroX9FY3SX9ojxa4v6msW1bOAhfj5mkdfZEP1FqlPQkYDVkbMUvp6HRBdtzK94GyEJQhjpHYWQy5vGSPdJKwkISjfhQSgp4NYZsRAIlUU39OgkGMEW161o1GpZfMxNI599KID7YEokN3fvSBu0ytrlcDEVL0H56S3DBH7i9Q59uQ/8A838vQ3qLz6/EJaGwkMkE2XSSdAJLZd8Hmw4CdEpi8PlqicoAYCDp5Re3Fq5IYt2YaZDC6PHeEL+9YbldVG4UEUGzHua6dtvqxrtHZb1pm/11Kz0RhGseZ4RiDTiAotOY2ilm3Yg3gQHASAYwCuFPwBhqD0Ae0h19bNFcqokGRgI8oAw1I8VjccEpC1JxLr7CVPtjTwEipskn9ShmSk14xGcLCz18dmX2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e8KlXN48L1pv2qJfB94S4fxbzWPbp6kv8OjvyI2YA0btm6ZB9dYDs+gAiFN7?=
 =?us-ascii?Q?pXfCNLsPcr9QEOf9LlHg3IGXPEm7KdyTXNXA9hgPLXkPNr+CQQby9gnzlTG6?=
 =?us-ascii?Q?XxYOTb/5t3rnA1Z0lHmN7rCxCwKORkbHhbfeNf1E7sF70kiK8Ktbj3Upri6y?=
 =?us-ascii?Q?9RPspreLPKNLpqWa3mEfZapQ5KcWCAZ1zl4QMTiPpH/lKTiH0zhPaLbwaHuG?=
 =?us-ascii?Q?QrMgNPczulVvaSwLMB77k5m1CWYXCJ/6tVJAWR4KAg132uaDtl9Nh1pItUsO?=
 =?us-ascii?Q?Svz8JXy0/VxWFErpKnz7jSNOMZU5YwG2CsHAho7YHx5LdbFRmxJSA/rbOQOZ?=
 =?us-ascii?Q?SPywoSkoKNdNjOPz8YrkgaFB/ahYt2Hh2CHlpes3RDf2gkr3KFmC9y+VT0r0?=
 =?us-ascii?Q?dZr6fsc4vvsJBAgCqhSHrq74sA1jYq62q6wLOWeKwlMIBx/ULfMI9BitxBO9?=
 =?us-ascii?Q?9ivFLGOwYyAIN7Qvn3jOCrXg5oXHnFHy+ocWPS+6DJ04mNRkVrVllie7G56n?=
 =?us-ascii?Q?Nmz6P75J2cfhpQuOAesiYaG1RY94qJQ9QU9NgrXa6i7n6kwNUETTOcC4dqeb?=
 =?us-ascii?Q?RkR0T+vLXaMuCuq6EJxaKOEs6i4wp/SYfo6DAlXGJ7C6rTA1VJoPL0UDGLE3?=
 =?us-ascii?Q?L3qHsV3LZU6QLFq/9HCcyes8kDHBImrT4aag5sXHYU+FHtewASW/gyEaBkyD?=
 =?us-ascii?Q?JbuG4d8ra5SHwQJj41QiLhlTsdpX75Z33+8c/FaLHECSOhrccIcMi+aZ1DzX?=
 =?us-ascii?Q?84VCcAzqZNcwRWCuxvVUS8biSy6UnzjjxXrYbIqqhgHMkyNYWS4ZX/vcRlow?=
 =?us-ascii?Q?Q6V+PBBhQxwpiMvf0DIFWW7NI3oV41/3JEeFL5i7ixkMmWvS8BUjDudN0sSV?=
 =?us-ascii?Q?qd/OSlHSXlzRgTHj3ltlBdFNjfjn7LvBgzAOYdoZfzgyJPK3cESQN5pYdeTm?=
 =?us-ascii?Q?wMcL0VU9El82SK43JA7A/c4AcSIJj+1c0AdOLTJ7siuyC07K8o9J1HrPL2m3?=
 =?us-ascii?Q?1XvRcWgJ7HpJ12LeVn3xkqQJZlMvcAF+121PEoqgiDq0MwRfm6YyeZr3ELaq?=
 =?us-ascii?Q?/+yl7xliIcu/nUT95p63X7Ge4t+9UyxsFS9uXpYyNySgEnqSErEhIbGf3PFK?=
 =?us-ascii?Q?rA//DEBmBKeRgAhFNm63wx5G50Jhxjv6K28A/OHf2uUEFxUPQuqgKQnjGCu2?=
 =?us-ascii?Q?oVcK1TqjlaSRw6vUvgd+MJLfkZrbTXxfhz6HvllK1N4A+U4u5nBbrHdsDXZB?=
 =?us-ascii?Q?UXJhdo2eVksgkwl4kusT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68babc01-1fce-46ea-c415-08dc677c0a73
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 12:09:23.2753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5644

On Sun, Apr 28, 2024 at 12:00:15AM GMT, Guenter Roeck wrote:
> On 4/27/24 18:30, Inochi Amaoto wrote:
> > SG2042 use an external MCU to provide basic hardware information
> > and thermal sensors.
> > 
> > Add driver support for the onboard MCU of SG2042.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> 
> Why does this driver reside in drivers/soc and not in drivers/hwmon ?
> 
> NACK from my perspective.
> 
> Guenter
> 

In fact, I am pretty unsure which one is better. This driver also provides
something rather than the hardware monitor. For example, this device also
acts as a reset controller (now only used in SBI). Is it even better to
move the driver into hwmon subsystem in this case?

Regards,
Inochi

> > ---
> >   drivers/soc/Kconfig                   |   1 +
> >   drivers/soc/Makefile                  |   1 +
> >   drivers/soc/sophgo/Kconfig            |  12 +
> >   drivers/soc/sophgo/Makefile           |   5 +
> >   drivers/soc/sophgo/sg2042-hwmon-mcu.c | 531 ++++++++++++++++++++++++++
> >   5 files changed, 550 insertions(+)
> >   create mode 100644 drivers/soc/sophgo/Kconfig
> >   create mode 100644 drivers/soc/sophgo/Makefile
> >   create mode 100644 drivers/soc/sophgo/sg2042-hwmon-mcu.c
> > 
> > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > index 5d924e946507..19050f094996 100644
> > --- a/drivers/soc/Kconfig
> > +++ b/drivers/soc/Kconfig
> > @@ -22,6 +22,7 @@ source "drivers/soc/qcom/Kconfig"
> >   source "drivers/soc/renesas/Kconfig"
> >   source "drivers/soc/rockchip/Kconfig"
> >   source "drivers/soc/samsung/Kconfig"
> > +source "drivers/soc/sophgo/Kconfig"
> >   source "drivers/soc/sunxi/Kconfig"
> >   source "drivers/soc/tegra/Kconfig"
> >   source "drivers/soc/ti/Kconfig"
> > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > index ba8f5b5460e1..6948e6617316 100644
> > --- a/drivers/soc/Makefile
> > +++ b/drivers/soc/Makefile
> > @@ -28,6 +28,7 @@ obj-y				+= qcom/
> >   obj-y				+= renesas/
> >   obj-y				+= rockchip/
> >   obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
> > +obj-y				+= sophgo/
> >   obj-y				+= sunxi/
> >   obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
> >   obj-y				+= ti/
> > diff --git a/drivers/soc/sophgo/Kconfig b/drivers/soc/sophgo/Kconfig
> > new file mode 100644
> > index 000000000000..de9842d1c287
> > --- /dev/null
> > +++ b/drivers/soc/sophgo/Kconfig
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Sophgo SoC drivers
> > +#
> > +
> > +config SG2042_HWMON_MCU
> > +	tristate "SG2042 onboard MCU support"
> > +	depends on RISCV
> > +	help
> > +	  Support for SG2042 onboard MCU. This mcu provides power
> > +	  control and some basic information for SG2042 chip.
> > +	  If unsure, say Y.
> > diff --git a/drivers/soc/sophgo/Makefile b/drivers/soc/sophgo/Makefile
> > new file mode 100644
> > index 000000000000..c72729ce61aa
> > --- /dev/null
> > +++ b/drivers/soc/sophgo/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Sophgo SoC drivers
> > +#
> > +obj-$(CONFIG_SG2042_HWMON_MCU)		+= sg2042-hwmon-mcu.o
> > diff --git a/drivers/soc/sophgo/sg2042-hwmon-mcu.c b/drivers/soc/sophgo/sg2042-hwmon-mcu.c
> > new file mode 100644
> > index 000000000000..3413b1a0f5e3
> > --- /dev/null
> > +++ b/drivers/soc/sophgo/sg2042-hwmon-mcu.c
> > @@ -0,0 +1,531 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
> > + *
> > + * Sophgo power control mcu for SG2042
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/time.h>
> > +
> > +/* fixed MCU registers */
> > +#define REG_BOARD_TYPE				0x00
> > +#define REG_MCU_FIRMWARE_VERSION		0x01
> > +#define REG_PCB_VERSION				0x02
> > +#define REG_PWR_CTRL				0x03
> > +#define REG_SOC_TEMP				0x04
> > +#define REG_BOARD_TEMP				0x05
> > +#define REG_RST_COUNT				0x0a
> > +#define REG_UPTIME				0x0b
> > +#define REG_RESET_REASON			0x0d
> > +#define REG_MCU_TYPE				0x18
> > +#define REG_CRITICAL_ACTIONS			0x65
> > +#define REG_CRITICAL_TEMP			0x66
> > +#define REG_REPOWER_TEMP			0x67
> > +
> > +#define CRITICAL_ACTION_REBOOT			0x1
> > +#define CRITICAL_ACTION_POWEROFF		0x2
> > +
> > +#define DEFAULT_REPOWER_TEMP			60
> > +#define MAX_REPOWER_TEMP			100
> > +
> > +#define sg2042_mcu_read_byte(client, reg)			\
> > +	i2c_smbus_read_byte_data(client, reg)
> > +#define sg2042_mcu_write_byte(client, reg, value)		\
> > +	i2c_smbus_write_byte_data(client, reg, value)
> > +#define sg2042_mcu_read_block(client, reg, array)		\
> > +	i2c_smbus_read_i2c_block_data(client, reg, sizeof(array), array)
> > +
> > +#define DEFINE_MCU_ATTR_READ_FUNC(_name, _type, _format)		\
> > +	static ssize_t _name##_show(struct device *dev,			\
> > +				    struct device_attribute *attr,	\
> > +				    char *buf)				\
> > +	{								\
> > +		struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);	\
> > +		_type ret;						\
> > +		ret = sg2042_mcu_get_##_name(mcu->client);		\
> > +		if (ret < 0)						\
> > +			return ret;					\
> > +		return sprintf(buf, _format "\n", ret);			\
> > +	}
> > +
> > +struct sg2042_mcu_board_data {
> > +	u8		id;
> > +	const char	*name;
> > +};
> > +
> > +struct sg2042_mcu_data {
> > +	struct i2c_client			*client;
> > +	const struct sg2042_mcu_board_data	*board_info;
> > +};
> > +
> > +static const struct sg2042_mcu_board_data sg2042_boards_data[] = {
> > +	{
> > +		.id = 0x80,
> > +		.name = "SG2042 evb x8",
> > +	},
> > +	{
> > +		.id = 0x81,
> > +		.name = "SG2042R evb",
> > +	},
> > +	{
> > +		.id = 0x83,
> > +		.name = "SG2042 evb x4",
> > +	},
> > +	{
> > +		.id = 0x90,
> > +		.name = "Milk-V Pioneer",
> > +	},
> > +};
> > +
> > +static const char *sg2042_mcu_reset_reason[8] = {
> > +	"Power supply overheat",
> > +	"Power supply failure",
> > +	"12V power supply failure",
> > +	"Reset commant",
> > +	"Unknown",
> > +	"Unknown",
> > +	"Unknown",
> > +	"SoC overheat",
> > +};
> > +
> > +static int sg2042_mcu_get_board_type(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_BOARD_TYPE);
> > +}
> > +
> > +static int sg2042_mcu_get_firmware_version(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_MCU_FIRMWARE_VERSION);
> > +}
> > +
> > +static int sg2042_mcu_get_pcb_version(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_PCB_VERSION);
> > +}
> > +
> > +static int sg2042_mcu_get_soc_temp(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_SOC_TEMP);
> > +}
> > +
> > +static int sg2042_mcu_get_board_temp(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_BOARD_TEMP);
> > +}
> > +
> > +static int sg2042_mcu_get_reset_count(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_RST_COUNT);
> > +}
> > +
> > +static s32 sg2042_mcu_get_uptime(struct i2c_client *client)
> > +{
> > +	int ret;
> > +	u8 time_val[2];
> > +
> > +	ret = sg2042_mcu_read_block(client, REG_UPTIME, time_val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return (s32)(time_val[0]) + ((s32)(time_val[1]) << 8);
> > +}
> > +
> > +static int sg2042_mcu_get_reset_reason(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_RESET_REASON);
> > +}
> > +
> > +static int sg2042_mcu_get_mcu_type(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_MCU_TYPE);
> > +}
> > +
> > +static int sg2042_mcu_get_critical_action(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_CRITICAL_ACTIONS);
> > +}
> > +
> > +static int sg2042_mcu_get_critical_temp(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_CRITICAL_TEMP);
> > +}
> > +
> > +static int sg2042_mcu_get_repower_temp(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_REPOWER_TEMP);
> > +}
> > +
> > +static int sg2042_mcu_set_critical_action(struct i2c_client *client,
> > +					  u8 value)
> > +{
> > +	return sg2042_mcu_write_byte(client, REG_CRITICAL_ACTIONS, value);
> > +}
> > +
> > +static int sg2042_mcu_set_critical_temp(struct i2c_client *client,
> > +					u8 value)
> > +{
> > +	return sg2042_mcu_write_byte(client, REG_CRITICAL_TEMP, value);
> > +}
> > +
> > +static int sg2042_mcu_set_repower_temp(struct i2c_client *client,
> > +				       u8 value)
> > +{
> > +	return sg2042_mcu_write_byte(client, REG_REPOWER_TEMP, value);
> > +}
> > +
> > +static ssize_t board_type_show(struct device *dev,
> > +			       struct device_attribute *attr,
> > +			       char *buf)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +
> > +	return sprintf(buf, "%s\n", mcu->board_info->name ?: "Unknown");
> > +}
> > +
> > +DEFINE_MCU_ATTR_READ_FUNC(firmware_version, int, "0x%02x");
> > +DEFINE_MCU_ATTR_READ_FUNC(pcb_version, int, "0x%02x");
> > +DEFINE_MCU_ATTR_READ_FUNC(reset_count, int, "%d");
> > +DEFINE_MCU_ATTR_READ_FUNC(uptime, s32, "%d");
> > +
> > +static ssize_t reset_reason_show(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 char *buf)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int ret, val, i;
> > +
> > +	val = sg2042_mcu_get_reset_reason(mcu->client);
> > +	if (val < 0)
> > +		return val;
> > +
> > +	ret = sprintf(buf, "Reason: 0x%02x\n", val);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(sg2042_mcu_reset_reason); i++) {
> > +		if (val & BIT(i))
> > +			ret += sprintf(buf + ret, "bit %d: %s\n", i,
> > +						  sg2042_mcu_reset_reason[i]);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t mcu_type_show(struct device *dev,
> > +			     struct device_attribute *attr,
> > +			     char *buf)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = sg2042_mcu_get_mcu_type(mcu->client);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return sprintf(buf, ret ? "GD32\n" : "STM32\n");
> > +}
> > +
> > +static ssize_t critical_action_show(struct device *dev,
> > +				    struct device_attribute *attr,
> > +				    char *buf)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int ret;
> > +	const char *action;
> > +
> > +	ret = sg2042_mcu_get_critical_action(mcu->client);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (ret == CRITICAL_ACTION_REBOOT)
> > +		action = "reboot";
> > +	else if (ret == CRITICAL_ACTION_POWEROFF)
> > +		action = "poweroff";
> > +	else
> > +		action = "unknown";
> > +
> > +	return sprintf(buf, "%s\n", action);
> > +}
> > +
> > +static ssize_t critical_action_store(struct device *dev,
> > +				     struct device_attribute *attr,
> > +				     const char *buf, size_t count)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int value;
> > +
> > +	if (sysfs_streq("reboot", buf))
> > +		value = CRITICAL_ACTION_REBOOT;
> > +	else if (sysfs_streq("poweroff", buf))
> > +		value = CRITICAL_ACTION_POWEROFF;
> > +	else
> > +		return -EINVAL;
> > +
> > +	return sg2042_mcu_set_critical_action(mcu->client, value);
> > +}
> > +
> > +DEFINE_MCU_ATTR_READ_FUNC(repower_temp, u32, "%u");
> > +
> > +static ssize_t repower_temp_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf, size_t count)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	u8 val;
> > +	int ret;
> > +
> > +	ret = kstrtou8(buf, 10, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (val == 0 || val > MAX_REPOWER_TEMP)
> > +		return -EINVAL;
> > +
> > +	return sg2042_mcu_set_repower_temp(mcu->client, val);
> > +}
> > +
> > +static DEVICE_ATTR_RO(board_type);
> > +static DEVICE_ATTR_RO(firmware_version);
> > +static DEVICE_ATTR_RO(pcb_version);
> > +static DEVICE_ATTR_RO(reset_count);
> > +static DEVICE_ATTR_RO(uptime);
> > +static DEVICE_ATTR_RO(reset_reason);
> > +static DEVICE_ATTR_RO(mcu_type);
> > +static DEVICE_ATTR_RW(critical_action);
> > +static DEVICE_ATTR_RW(repower_temp);
> > +
> > +static struct attribute *sg2042_mcu_attrs[] = {
> > +	&dev_attr_board_type.attr,
> > +	&dev_attr_firmware_version.attr,
> > +	&dev_attr_pcb_version.attr,
> > +	&dev_attr_reset_count.attr,
> > +	&dev_attr_uptime.attr,
> > +	&dev_attr_reset_reason.attr,
> > +	&dev_attr_mcu_type.attr,
> > +	&dev_attr_critical_action.attr,
> > +	&dev_attr_repower_temp.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group sg2042_mcu_attr_group = {
> > +	.attrs	= sg2042_mcu_attrs,
> > +};
> > +
> > +static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
> > +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
> > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT,
> > +				 HWMON_T_INPUT),
> > +	NULL
> > +};
> > +
> > +static int sg2042_mcu_read_temp(struct device *dev,
> > +				u32 attr, int channel,
> > +				long *val)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	long tmp;
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_input:
> > +		switch (channel) {
> > +		case 0:
> > +			tmp = sg2042_mcu_get_soc_temp(mcu->client);
> > +			if (tmp < 0)
> > +				return tmp;
> > +			*val = tmp * 1000;
> > +			break;
> > +		case 1:
> > +			tmp = sg2042_mcu_get_board_temp(mcu->client);
> > +			if (tmp < 0)
> > +				return tmp;
> > +			*val = tmp * 1000;
> > +			break;
> > +		default:
> > +			return -EOPNOTSUPP;
> > +		}
> > +		break;
> > +	case hwmon_temp_crit:
> > +		if (channel)
> > +			return -EOPNOTSUPP;
> > +
> > +		tmp = sg2042_mcu_get_critical_temp(mcu->client);
> > +		if (tmp < 0)
> > +			return tmp;
> > +		*val = tmp * 1000;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int sg2042_mcu_read(struct device *dev,
> > +			   enum hwmon_sensor_types type,
> > +			   u32 attr, int channel, long *val)
> > +{
> > +	switch (type) {
> > +	case hwmon_chip:
> > +		if (attr != hwmon_chip_update_interval)
> > +			return -EOPNOTSUPP;
> > +		*val = 1000;
> > +		break;
> > +	case hwmon_temp:
> > +		return sg2042_mcu_read_temp(dev, attr, channel, val);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int sg2042_mcu_write(struct device *dev,
> > +			    enum hwmon_sensor_types type,
> > +			    u32 attr, int channel, long val)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	u8 down_temp, repower_temp;
> > +	int ret;
> > +
> > +	if (type != hwmon_temp || attr != hwmon_temp_crit || !channel)
> > +		return -EOPNOTSUPP;
> > +
> > +	ret = sg2042_mcu_get_repower_temp(mcu->client);
> > +	if (ret < 0)
> > +		repower_temp = DEFAULT_REPOWER_TEMP;
> > +	else
> > +		repower_temp = ret;
> > +
> > +	down_temp = val / 1000;
> > +	if (down_temp < repower_temp)
> > +		return -EINVAL;
> > +
> > +	return sg2042_mcu_set_critical_temp(mcu->client, (u8)(val / 1000));
> > +}
> > +
> > +static umode_t sg2042_mcu_is_visible(const void *_data,
> > +				     enum hwmon_sensor_types type,
> > +				     u32 attr, int channel)
> > +{
> > +	switch (type) {
> > +	case hwmon_chip:
> > +		if (attr == hwmon_chip_update_interval)
> > +			return 0444;
> > +		break;
> > +	case hwmon_temp:
> > +		switch (attr) {
> > +		case hwmon_temp_input:
> > +			if (channel < 2)
> > +				return 0444;
> > +			break;
> > +		case hwmon_temp_crit:
> > +			if (channel == 0)
> > +				return 0664;
> > +			break;
> > +		default:
> > +			return 0;
> > +		}
> > +		break;
> > +	default:
> > +		return 0;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_ops sg2042_mcu_ops = {
> > +	.is_visible = sg2042_mcu_is_visible,
> > +	.read = sg2042_mcu_read,
> > +	.write = sg2042_mcu_write,
> > +};
> > +
> > +static const struct hwmon_chip_info sg2042_mcu_chip_info = {
> > +	.ops = &sg2042_mcu_ops,
> > +	.info = sg2042_mcu_info,
> > +};
> > +
> > +static int sg2042_mcu_check_board(u8 id)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(sg2042_boards_data); i++) {
> > +		if (sg2042_boards_data[i].id == id)
> > +			return i;
> > +	}
> > +
> > +	return -ENODEV;
> > +}
> > +
> > +static int sg2042_mcu_i2c_probe(struct i2c_client *client)
> > +{
> > +	int ret;
> > +	struct device *dev = &client->dev;
> > +	struct sg2042_mcu_data *mcu;
> > +	struct device *hwmon_dev;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> > +						I2C_FUNC_SMBUS_BLOCK_DATA))
> > +		return -EIO;
> > +
> > +	ret = sg2042_mcu_get_board_type(client);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = sg2042_mcu_check_board(ret);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
> > +	if (!mcu)
> > +		return -ENOMEM;
> > +
> > +	mcu->client = client;
> > +	mcu->board_info = &sg2042_boards_data[ret];
> > +
> > +	ret = sysfs_create_group(&dev->kobj, &sg2042_mcu_attr_group);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	i2c_set_clientdata(client, mcu);
> > +
> > +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> > +							 mcu,
> > +							 &sg2042_mcu_chip_info,
> > +							 NULL);
> > +
> > +	return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static void sg2042_mcu_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +
> > +	sysfs_remove_group(&dev->kobj, &sg2042_mcu_attr_group);
> > +}
> > +
> > +static const struct i2c_device_id sg2042_mcu_id[] = {
> > +	{ "sg2042-hwmon-mcu", 0 },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
> > +
> > +static const struct of_device_id sg2042_mcu_of_id[] = {
> > +	{ .compatible = "sophgo,sg2042-hwmon-mcu" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
> > +
> > +static struct i2c_driver sg2042_mcu_driver = {
> > +	.driver = {
> > +		.name = "sg2042-mcu",
> > +		.of_match_table = sg2042_mcu_of_id,
> > +	},
> > +	.probe = sg2042_mcu_i2c_probe,
> > +	.remove = sg2042_mcu_i2c_remove,
> > +	.id_table = sg2042_mcu_id,
> > +};
> > +
> > +module_i2c_driver(sg2042_mcu_driver);
> > +
> > +MODULE_DESCRIPTION("MCU I2C driver for bm16xx soc platform");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.44.0
> > 
> 

