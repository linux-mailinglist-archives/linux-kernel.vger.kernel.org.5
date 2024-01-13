Return-Path: <linux-kernel+bounces-25334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE582CDBE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB29F1F21CDA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082FB4417;
	Sat, 13 Jan 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq1CvpJD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15A3FDB;
	Sat, 13 Jan 2024 16:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DF5C433C7;
	Sat, 13 Jan 2024 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705163176;
	bh=faSWsUlIKQgmxLiSOdVQbwBE0dKKRlGfgL2TWtQf0vY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mq1CvpJDlFCzPCgK+YICMMfHhsZfHYJLobqPZpeL7A3GPqHTa6JFh8Esnyw3Y7QrF
	 /NBIGQX/olpIXCtjI+Jhk73cSIvNe5kE1DqCivHYMT/Ti4N2qQvKTrQ2C30ikVqQaR
	 GMvOqyBgfcTlcICK5V+mwBtAiU1T4WxLll+CrWvtOIaPFbS2cvpmoSjURVmF2evwQL
	 n7CvPUuDusg9LWtmOSo8erAFZjK25vU5/tVNXDb5bGNCNgVR8lDbh1AVapFOe9aKRO
	 sXt9WmnS/bcYgjevYsOmotrY1zXV43Z3K4HxNMf9dXvTzvlo+qcmaYAB8FNtmA9lHd
	 ISmhTkmqCAJyg==
Date: Sat, 13 Jan 2024 16:26:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrea Merello <andrea.merello@iit.it>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: serdev requires REGMAP
Message-ID: <20240113162609.3e950ae8@jic23-huawei>
In-Reply-To: <20240110185611.19723-1-rdunlap@infradead.org>
References: <20240110185611.19723-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 10:56:11 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> There are a ton of build errors when REGMAP is not set, so select
> REGMAP to fix all of them.
> 
> Examples (not all of them):
> 
> ../drivers/iio/imu/bno055/bno055_ser_core.c:495:15: error: variable 'bno055_ser_regmap_bus' has initializer but incomplete type
>   495 | static struct regmap_bus bno055_ser_regmap_bus = {
> ../drivers/iio/imu/bno055/bno055_ser_core.c:496:10: error: 'struct regmap_bus' has no member named 'write'
>   496 |         .write = bno055_ser_write_reg,
> ../drivers/iio/imu/bno055/bno055_ser_core.c:497:10: error: 'struct regmap_bus' has no member named 'read'
>   497 |         .read = bno055_ser_read_reg,
> ../drivers/iio/imu/bno055/bno055_ser_core.c: In function 'bno055_ser_probe':
> ../drivers/iio/imu/bno055/bno055_ser_core.c:532:18: error: implicit declaration of function 'devm_regmap_init'; did you mean 'vmem_map_init'? [-Werror=implicit-function-declaration]
>   532 |         regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
> ../drivers/iio/imu/bno055/bno055_ser_core.c:532:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   532 |         regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
> ../drivers/iio/imu/bno055/bno055_ser_core.c: At top level:
> ../drivers/iio/imu/bno055/bno055_ser_core.c:495:26: error: storage size of 'bno055_ser_regmap_bus' isn't known
>   495 | static struct regmap_bus bno055_ser_regmap_bus = {
> 
> Fixes: 2eef5a9cc643 ("iio: imu: add BNO055 serdev driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrea Merello <andrea.merello@iit.it>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,
Jonathan

> ---
>  drivers/iio/imu/bno055/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> --- a/drivers/iio/imu/bno055/Kconfig
> +++ b/drivers/iio/imu/bno055/Kconfig
> @@ -8,6 +8,7 @@ config BOSCH_BNO055
>  config BOSCH_BNO055_SERIAL
>  	tristate "Bosch BNO055 attached via UART"
>  	depends on SERIAL_DEV_BUS
> +	select REGMAP
>  	select BOSCH_BNO055
>  	help
>  	  Enable this to support Bosch BNO055 IMUs attached via UART.


