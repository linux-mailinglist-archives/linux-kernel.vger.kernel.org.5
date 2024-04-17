Return-Path: <linux-kernel+bounces-149280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68A78A8ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633FB1F2244D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9291411F6;
	Wed, 17 Apr 2024 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uBNrum6n"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2036.outbound.protection.outlook.com [40.92.18.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8D8F4A;
	Wed, 17 Apr 2024 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713392939; cv=fail; b=D/dplvw9ESUI9X6fkW6phOiBJPNg/I98PRyMMd3FG5jtlPeQN9vZZrhGxQZ0ZGl/fGPPF8HI414GrtBzfsxtRGetSLVZiXFYCtIErWWQshBl5RkexYidt+8VNZAZUlHsWKC5FBPzJHEzgpAlmiTVB4wyOpFTO4J+gme4DXLpvbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713392939; c=relaxed/simple;
	bh=LMuvjp6CxXVHERsJXJ3UNNl+KXuuAJ0Cz2GliXt5Wm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DyLrJqzSD+dJbNi0eFNZp6xTOXFh7u8p2cN9kpRPvtdEVYzGiqik8HC09yquu/ovwk83xBd385IqCCY+PbC4WYV/5yb2UfpGse+tYbPgdL76gHVZlvAgIKjO53AnlSKwddGLznDzFm4V4tcpOdJ4AXuABlIYJQn/XNYvEJfyZQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uBNrum6n; arc=fail smtp.client-ip=40.92.18.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I768qC8cUHSoUZD2pTLB4Olrz4/R5TUSmNfLwXTo6WGHagiQmNjbmP3PD0GOB1++CpTunxpHnV5aUkQQeSWH/0Kl1nWwSekHHI483yfg/8nalqWZtKLP3R4eexBDYgcv6ASK3SuZKraR2zZoJSMe6h6Ws5fV3ndIQyFaCmQlgW9eAKhadQsLbsFf/OrK369GzDQyVDS8GDE78XV1nRBLda565vCX8utB0McDMFdjcioza6ODnMywT5Tk6DNKV7XbHWEtdsm7SJeKsoOEQJLaS74e/B0/fAs0VWzKb14+eQaTsPzbxuydhMeTwXYg1gi9hQe0svSr7al4mOfc0TVEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzyG2uHRdsnYhdcDUAj8JY4GaxDcM/bsGJDKzqcfzhM=;
 b=Fx1HhNmU9elK0WDn2ggFHD6BkwzjgkpVwJlyjj7fytQ+eBOz/8GhDrJhBpj0/zjuo7g1Rkvk+UXIjFq6CQOGyNFKdNAQ4I7hSxhzGgV6ldencxz4esSGnEvs6GRVoNbz4C9zc8h2rcnzLur6qXariVhP80CUCkyFWH7qLZhwuNgW2rbN6bKGTdsBJvXV9Qf6TXRP3+21REuSEc5om7LrAHHxzGr8nJ4JjMEiXLWayh+9L8+1lH2+HQmKp2+B2X7z+UB/JTd3crTfom0ZY4P+/QeJsI/FOIBejeEfmjTMZnlIUPsOdtiS93k1/U3GZxfQOfmlWmuUxCnKYyK8SUkAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzyG2uHRdsnYhdcDUAj8JY4GaxDcM/bsGJDKzqcfzhM=;
 b=uBNrum6noyRU41ZFjaSuLszze2LB0rT4HjWNOh4TOxRzwwvAynd4cv0STdt1nnYuW5Mfd60FdqlBYVgWSiCkMvRF+ZRvTTpLAH7UYd5oLaNLhziHtkH7i3JrnZMupTXZerOu5gtz1LTEjpFc/TE0eXGDjoSl1+M1ZSQdrq7XbxqEmR9G1vBwvureYRpm4THFAkp4jg7Zdt1lGy+7IXm7XLGornIdS9G03gimPUddJmSkXSxc48eKtud7yMNGo4dP2ghmEDMZaLMt95OqSp4Jwd6nQt4q5M1p0ofHD9iqw7tObutvUz8n2DZlhsdwcd11g67QeyuuxPzsfopkqtUgDQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB4594.namprd20.prod.outlook.com (2603:10b6:208:371::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 22:28:55 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 22:28:55 +0000
Date: Thu, 18 Apr 2024 06:29:19 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: michael.opdenacker@bootlin.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: dts: sophgo: add initial Milk-V Duo S
 board support
Message-ID:
 <IA1PR20MB4953FA341C571D223FA1D06CBB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
 <20240417065311.3881023-3-michael.opdenacker@bootlin.com>
 <IA1PR20MB49539A380E44459ACE19DEB6BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240417-guts-overture-b04cd1b8565a@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417-guts-overture-b04cd1b8565a@spud>
X-TMN: [aLigmzrHHiImNYwobp+7qYu/5EuPxjLMElKOrKHgaXg=]
X-ClientProxiedBy: TYCP286CA0218.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <z6qciaptclrjlv7yagrey3ozgq2rlmxexjlcabom7hcviqaq23@dtgi2wiuq62k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: 368fd23f-5b6c-4d82-2ac6-08dc5f2dc448
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KNO9rFDh79BCQr5uKiwgDoiUtJzo9Jq8VqBH5FRCiB43Sv6cEyCA+2sRK+7aS2RS/YAL10q4GLDbeNxZacDK80YbZ7RZJHfnTjnxWDdAU/uN0qGiWczaawfbdkZY8LK5/yv1F7s5e5vhrLHOT/uSAgIolDiv12A7qnXr0lCaQ1hXili5n/p8P+VImagQ4IUNsAodqZjIKwZsNck7tnbK6s1HEopZlXjvOXgVX4IgsxYlKvH4RHyvPM0Jj5Itd5jU4MrvkiRR2PPFsiFld+Pq1WA+F84gsy8dzJAOW9pyKkHAKF4XJ95b3LIuTWPPCjSM1wW5Q0gz61JRUqZB0oApcE+9ARETP8XQrxTSC2bBNqybV56MK2EHG03yoLqWefv+I4WB8Vz4QzRJ19fSEwf46kTLSdFk6aMdYpLZXJAtdfcgjIai5W3hzsW8R39mvt1c1u443027e3ZcOfUPCslOkUyJdelbgRVqE3fHPIedVlVLD42h4JFB4RN6aOQQ1u6LgSo2lUiSG6ripB/Z6VadKYSw9P0AAdLn3lJcNHNu70m/jYxxowzb7udK1YZgJmiY7y4egVu6Z8NQARhpRkvNSOAT2McN4lm75DR8giZW06Ra0CovTi986S7n6JFs2Fa9W1L7E1ru/IJrc+5WU9d9JyI/KMDuYjVkrK30FvUfSM5HZN0OAcykmHf+v0n+lKd8ybIee07cIGQOVyqTPqFYcg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3M1sW3gXE9evQDpC/H/Gln+OR964z9AbpATjG6iCw9o6L040CjK16wTxmXh?=
 =?us-ascii?Q?yz7Kq98OAUYN7cPVsgBrYUw2fWcucnKqq5MnlY4KirVrD7RMMTChu7t75m0K?=
 =?us-ascii?Q?wth/i7dkx62AE4rF6/HB06v83Qrn6y4kxNzeMPysqdbOk03VldZz4SggmwJR?=
 =?us-ascii?Q?4CI3eQWNPyMvrY1px191bmQxeIeUTU50HUz3Re92W0ZdLd76oA/ABBu2Sa71?=
 =?us-ascii?Q?eQpCRGiD6AGfVvwBeOIQkGdfzno6XIgnrAMoyKAFTd1aC2i2Q7nwXf12g1Hi?=
 =?us-ascii?Q?/QYS3I4iidZ5/ev+emQKuIjkNPtZT8X1pNBuHxxZ6F/ETlDwAGFR13kJ16gF?=
 =?us-ascii?Q?TtH61uKs2LaKA8U0qg0snLFCgSoUt05hSJfnYB8dRjuE8KFEI6XaK/JJP3U9?=
 =?us-ascii?Q?y0jF3GP5IDGARtLGCwgxoZDD2GJsOMXu2w4gnqqXBKZyY6CTgE38jiCcz5hy?=
 =?us-ascii?Q?/tR8ABHDKzluvQ5aRrYBI5SU258FpjMWfjpCHZGhENZAQWxtn5HbH4/XNLnc?=
 =?us-ascii?Q?D/uORExYHN5lOKh/Bcj3N5wnVtA8V8VP53gJsBDFTqbh9aPs/bFd96rAz/SV?=
 =?us-ascii?Q?qi9OMuyGM/MeAterH7FT9EoSf99pEwmoAKsp+NuC9Q/d5BTEQozN4qaw07Dx?=
 =?us-ascii?Q?G6wqPCCPbfN4N+X0AhfshXTOYIKl20xbOr3sf2AUuVsVAOCs1pU5Rh4rV2VT?=
 =?us-ascii?Q?npQ4d3A+lQ57zJyiUo+gCKMdGfr3PN/UWknPyxmTgEsrLfGMYbw551uWJ4Jd?=
 =?us-ascii?Q?W8joYzuRUOvck/x1Wpnm7JSI+p5+290smXyWoGTISiWy7yoEN+gx8Z0oKiea?=
 =?us-ascii?Q?8vf3ravYAGtkAWArBrm7tPewZt2wApDyUfKyB0dfWcllTQTDeLMt/9uZh1D9?=
 =?us-ascii?Q?XoyhD4FWX/gkEOwnDDAPSGM/rQCYGUSM7RqetM6HHL4QcxHKLv6VUqFjYiq/?=
 =?us-ascii?Q?ereiFCnHRxEBPPf5Fs3Xy0V7Ro8CIUHI020ZSSvJsWcfgENgtdfcHX3Y3lCG?=
 =?us-ascii?Q?lec7PAA+GWcAPXXJZoooP12/qs661+wahcBla64fvudXQ4Iyd+1pyTcUsPUt?=
 =?us-ascii?Q?jgJyoWIzvp4M9CU/FyKRE3p7Fgp0hZIWKlgUjwH01xmN9PcSGKj9bZ7dp0BT?=
 =?us-ascii?Q?sQMTjAhfbmgMhEohZG3w/ybXhDlOD4gxm4NtX3IaNBZGwo4gl1YGWjZl3bvo?=
 =?us-ascii?Q?xFZM3vOsfKMGzSNS2AAsZcjblv7vZ4QKOxQbu6A+HjiMCWsaAZ7AhIcffxUY?=
 =?us-ascii?Q?TCGndZ1hHILQjWzOEgUz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368fd23f-5b6c-4d82-2ac6-08dc5f2dc448
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 22:28:55.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4594

On Wed, Apr 17, 2024 at 04:06:29PM GMT, Conor Dooley wrote:
> On Wed, Apr 17, 2024 at 05:34:44PM +0800, Inochi Amaoto wrote:
> > On Wed, Apr 17, 2024 at 08:53:11AM GMT, michael.opdenacker@bootlin.com wrote:
> > > From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > 
> > > This adds initial support for the Milk-V Duo S board
> > > (https://milkv.io/duo-s), enabling the serial port,
> > > making it possible to boot Linux to the command line.
> > > 
> > > Link: https://lore.kernel.org/linux-riscv/171266958507.1032617.9460749136730849811.robh@kernel.org/T/#t
> > > 
> > > Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > ---
> > >  arch/riscv/boot/dts/sophgo/Makefile           |  1 +
> > >  .../boot/dts/sophgo/sg2000-milkv-duos.dts     | 34 +++++++++++++++++++
> > >  2 files changed, 35 insertions(+)
> > >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> > > 
> > > diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> > > index 57ad82a61ea6..e008acb5240f 100644
> > > --- a/arch/riscv/boot/dts/sophgo/Makefile
> > > +++ b/arch/riscv/boot/dts/sophgo/Makefile
> > > @@ -1,4 +1,5 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
> > >  dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
> > > +dtb-$(CONFIG_ARCH_SOPHGO) += sg2000-milkv-duos.dtb
> > >  dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> > > diff --git a/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> > > new file mode 100644
> > > index 000000000000..c1ecf97d5e93
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> > > @@ -0,0 +1,34 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > +/*
> > > + * Copyright (C) 2024 Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "cv1812h.dtsi"
> > > +
> > > +/ {
> > > +	model = "Milk-V Duo S";
> > > +	compatible = "milkv,duos", "sophgo,cv1812h";
> > > +
> > > +	aliases {
> > > +		serial0 = &uart0;
> > > +	};
> > > +
> > > +	chosen {
> > > +		stdout-path = "serial0:115200n8";
> > > +	};
> > > +
> > > +	memory@80000000 {
> > > +		device_type = "memory";
> > > +		reg = <0x80000000 0x20000000>;
> > > +	};
> > 
> > Add a cpu specific file, and move this to it.
> 
> I take it that the memory is integrated into the package then?

Yes, of course.

