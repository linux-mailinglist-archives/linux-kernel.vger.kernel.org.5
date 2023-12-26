Return-Path: <linux-kernel+bounces-11489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6814F81E720
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF23282D22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F924E1D1;
	Tue, 26 Dec 2023 11:36:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB874E1C6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4Szszj2lrmz4x94y
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 12:31:29 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:9b4b:afc4:afcc:abac])
	by andre.telenet-ops.be with bizsmtp
	id SzXL2B0092KswmB01zXLCU; Tue, 26 Dec 2023 12:31:22 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rI5ea-00DRWR-Fl;
	Tue, 26 Dec 2023 12:31:20 +0100
Date: Tue, 26 Dec 2023 12:31:20 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jie Wang <jie.wang@intel.com>
cc: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
    qat-linux@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] crypto: qat - add support for 420xx devices
In-Reply-To: <20231215100147.1703641-6-jie.wang@intel.com>
Message-ID: <c6662ee1-9c2a-49fb-917f-2a3586f636b4@linux-m68k.org>
References: <20231215100147.1703641-1-jie.wang@intel.com> <20231215100147.1703641-6-jie.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-447575269-1703590280=:3203928"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-447575269-1703590280=:3203928
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

 	Hi Jie,

On Fri, 15 Dec 2023, Jie Wang wrote:
> Add support for 420xx devices by including a new device driver that
> supports such devices, updates to the firmware loader and capabilities.
>
> Compared to 4xxx devices, 420xx devices have more acceleration engines
> (16 service engines and 1 admin) and support the wireless cipher
> algorithms ZUC and Snow 3G.
>
> Signed-off-by: Jie Wang <jie.wang@intel.com>
> Co-developed-by: Dong Xie <dong.xie@intel.com>
> Signed-off-by: Dong Xie <dong.xie@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Thanks for your patch, which is now commit fcf60f4bcf54952c ("crypto:
qat - add support for 420xx devices") in crypto/master

> --- a/drivers/crypto/intel/qat/Kconfig
> +++ b/drivers/crypto/intel/qat/Kconfig
> @@ -59,6 +59,17 @@ config CRYPTO_DEV_QAT_4XXX
> 	  To compile this as a module, choose M here: the module
> 	  will be called qat_4xxx.
>
> +config CRYPTO_DEV_QAT_420XX
> +	tristate "Support for Intel(R) QAT_420XX"
> +	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)

These dependencies suggest that the QAT_420XX device can be present and
used on any little-endian system that supports PCIe (arm64, MIPS,
PowerPC, RISC-V, ...).

However, [1] says QAT is only present on intel Atom® C5000, P5300, and
P5700 processors, implying the dependency should rather be

     depends on PCI && (X86_64 || COMPILE_TEST)

Which one is correct?

[1] https://www.intel.com/content/www/us/en/architecture-and-technology/intel-quick-assist-technology-overview.html

> +	select CRYPTO_DEV_QAT
> +	help
> +	  Support for Intel(R) QuickAssist Technology QAT_420xx
> +	  for accelerating crypto and compression workloads.
> +
> +	  To compile this as a module, choose M here: the module
> +	  will be called qat_420xx.
> +
> config CRYPTO_DEV_QAT_DH895xCCVF
> 	tristate "Support for Intel(R) DH895xCC Virtual Function"
> 	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-447575269-1703590280=:3203928--

