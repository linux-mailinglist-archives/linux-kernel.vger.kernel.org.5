Return-Path: <linux-kernel+bounces-156451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6ED8B02EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45965B2149E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFED157A6F;
	Wed, 24 Apr 2024 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="BQ3uTDcf"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C4360;
	Wed, 24 Apr 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942897; cv=none; b=u7vGm02CIksJxPYOwczwbjavxLDSZsBjQJO0wwBTMrj0sRHjHomZP5yBVxRp0AjwzoTonb1OYHVraGhbZ1Euu62B6vA/JLS02vUc7pDPFSoiVxW0NH/t40i3HpwYE4mCvNC0DKBysnUMyEEM+BqsQEMHN73eE2UkyG2HqNlCN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942897; c=relaxed/simple;
	bh=lSFEXMnhEo7j9drnPeUDWoBZJzWn5yTK8JeBm/s0IEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DnNBiRvmdXrjkcA1IvOErnGnmBBVTQ1H2uozFKOEgqgpauFVckHrNG8LfJuzh58XQoVAGO0OXJ6cvHYhcD+Hlbk1LerIeEbnISa51n1wnTyzZBr/EjBfQbU8C+RRlaenvoQGQpswxhIdhL2R8xlKwgzC6C63adGgR8RyTjNJKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=BQ3uTDcf; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G+nS6LoUVV/Wx11MVxdB0i8/m0ScdizLTX8VaAUSH4c=; t=1713942894; x=1714547694; 
	b=BQ3uTDcfTVZqoixDbcFQQgwJdiHjACDyZNTOWUWqJJ6zmg7j7dNB7B4RTiroFRQgxjEoqlAFA+5
	Cp0sseNM0pY6rHcYIauHh/ieOrvxU1h98VO7Ayriw3YpJIbRwLU/aLW3ytXFZdhg3p7/NcnOUOVIg
	DI6uvb3yv1XxaW8azWMTlGTAmCA4Ga+9uFMayslmrDjtWNF9LEMUjA7q8kzkvERSVbbx1YLNrqYw/
	ZCZUQUdu9IS5wCCxs9U2I1FMAkqFn0YUfG2uaHg7SAE6CQuRWUDAXSwjdJ2rfbbdOZaT7cXclnwQX
	fLcX8Q9tkGHjNcF/6O+651xdWGY6ykz/C2Pg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rzWqC-00000002w2y-0VKd; Wed, 24 Apr 2024 09:14:52 +0200
Received: from [80.95.105.245] (helo=[172.16.2.143])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rzWqB-000000019ip-3ef6; Wed, 24 Apr 2024 09:14:52 +0200
Message-ID: <be6369645dc8eaa6b38c6aa9aafd872443f8f1f5.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 1/2] sh: Convert the last use of 'optional' property
 in Kconfig
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org
Date: Wed, 24 Apr 2024 09:14:51 +0200
In-Reply-To: <20240422164104.2869507-2-masahiroy@kernel.org>
References: <20240422164104.2869507-1-masahiroy@kernel.org>
	 <20240422164104.2869507-2-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Tue, 2024-04-23 at 01:41 +0900, Masahiro Yamada wrote:
> The 'choice' statement is primarily used to exclusively select one
> option, but the 'optional' property allows all entries to be disabled.
>=20
> This feature is rarely used. In fact, it is only used in arch/sh/Kconfig
> because the equivalent outcome can be achieved by inserting one more
> entry as a place-holder.
>=20
> The 'optional' property support will be removed from Kconfig.
>=20
> This commit replaces the 'optional' property with a dummy option,
> CMDLINE_FROM_BOOTLOADER, as seen in some other architectures.
>=20
> Note:
>  The 'default CMDLINE_OVERWRITE' statement does not work as intended
>  in combination with 'optional'. If neither CONFIG_CMDLINE_OVERWRITE
>  nor CONFIG_CMDLINE_EXTEND is specified in a defconfig file, both of
>  them are disabled. This is a bug. To maintain the current behavior,
>  I added CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy to those defconfig files.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> Changes in v2:
>  - Rename CONFIG_CMDLINE_NO_MODIFY to CONFIG_CMDLINE_FROM_BOOTLOADER
>  - Capitalize the first work of the subject
>=20
>  arch/sh/Kconfig                           | 6 +++++-
>  arch/sh/configs/apsh4a3a_defconfig        | 1 +
>  arch/sh/configs/apsh4ad0a_defconfig       | 1 +
>  arch/sh/configs/edosk7705_defconfig       | 1 +
>  arch/sh/configs/hp6xx_defconfig           | 1 +
>  arch/sh/configs/landisk_defconfig         | 1 +
>  arch/sh/configs/magicpanelr2_defconfig    | 1 +
>  arch/sh/configs/rsk7264_defconfig         | 1 +
>  arch/sh/configs/rsk7269_defconfig         | 1 +
>  arch/sh/configs/se7619_defconfig          | 1 +
>  arch/sh/configs/se7705_defconfig          | 1 +
>  arch/sh/configs/se7722_defconfig          | 1 +
>  arch/sh/configs/se7750_defconfig          | 1 +
>  arch/sh/configs/secureedge5410_defconfig  | 1 +
>  arch/sh/configs/sh7710voipgw_defconfig    | 1 +
>  arch/sh/configs/sh7724_generic_defconfig  | 1 +
>  arch/sh/configs/sh7770_generic_defconfig  | 1 +
>  arch/sh/configs/sh7785lcr_32bit_defconfig | 1 +
>  arch/sh/configs/sh7785lcr_defconfig       | 1 +
>  arch/sh/configs/urquell_defconfig         | 1 +
>  20 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 2ad3e29f0ebe..8b64ca76aa4b 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -709,7 +709,6 @@ config ROMIMAGE_MMCIF
> =20
>  choice
>  	prompt "Kernel command line"
> -	optional
>  	default CMDLINE_OVERWRITE
>  	help
>  	  Setting this option allows the kernel command line arguments
> @@ -727,6 +726,11 @@ config CMDLINE_EXTEND
>  	  Given string will be concatenated with arguments passed in
>  	  by a bootloader.
> =20
> +config CMDLINE_FROM_BOOTLOADER
> +	bool "Use bootloader kernel arguments"
> +	help
> +	  Uses the command-line options passed by the boot loader.
> +
>  endchoice
> =20
>  config CMDLINE
> diff --git a/arch/sh/configs/apsh4a3a_defconfig b/arch/sh/configs/apsh4a3=
a_defconfig
> index cc909f347877..9c2644443c4d 100644
> --- a/arch/sh/configs/apsh4a3a_defconfig
> +++ b/arch/sh/configs/apsh4a3a_defconfig
> @@ -15,6 +15,7 @@ CONFIG_MEMORY_START=3D0x0C000000
>  CONFIG_FLATMEM_MANUAL=3Dy
>  CONFIG_SH_STORE_QUEUES=3Dy
>  CONFIG_SH_APSH4A3A=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_HIGH_RES_TIMERS=3Dy
>  CONFIG_KEXEC=3Dy
>  CONFIG_PREEMPT=3Dy
> diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4a=
d0a_defconfig
> index 64558bf60e10..05d21d91f41d 100644
> --- a/arch/sh/configs/apsh4ad0a_defconfig
> +++ b/arch/sh/configs/apsh4ad0a_defconfig
> @@ -42,6 +42,7 @@ CONFIG_SECCOMP=3Dy
>  CONFIG_PREEMPT=3Dy
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  CONFIG_BINFMT_MISC=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_PM=3Dy
>  CONFIG_PM_DEBUG=3Dy
>  CONFIG_PM=3Dy
> diff --git a/arch/sh/configs/edosk7705_defconfig b/arch/sh/configs/edosk7=
705_defconfig
> index 9ee35269bee2..57c79da1ff8e 100644
> --- a/arch/sh/configs/edosk7705_defconfig
> +++ b/arch/sh/configs/edosk7705_defconfig
> @@ -19,6 +19,7 @@
>  CONFIG_CPU_SUBTYPE_SH7705=3Dy
>  CONFIG_SH_EDOSK7705=3Dy
>  CONFIG_SH_PCLK_FREQ=3D31250000
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  # CONFIG_INPUT is not set
>  # CONFIG_SERIO is not set
> diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defc=
onfig
> index 0c45f2a0f9bd..77e3185f63e4 100644
> --- a/arch/sh/configs/hp6xx_defconfig
> +++ b/arch/sh/configs/hp6xx_defconfig
> @@ -15,6 +15,7 @@ CONFIG_SH_DMA_API=3Dy
>  CONFIG_HD64461_ENABLER=3Dy
>  CONFIG_PCCARD=3Dy
>  CONFIG_PM=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_APM_EMULATION=3Dy
>  # CONFIG_STANDALONE is not set
>  CONFIG_BLK_DEV_SD=3Dy
> diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_=
defconfig
> index 541082090918..0311380160f4 100644
> --- a/arch/sh/configs/landisk_defconfig
> +++ b/arch/sh/configs/landisk_defconfig
> @@ -15,6 +15,7 @@ CONFIG_KEXEC=3Dy
>  CONFIG_PCI=3Dy
>  CONFIG_PCCARD=3Dy
>  CONFIG_YENTA=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
>  CONFIG_UNIX=3Dy
> diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/mag=
icpanelr2_defconfig
> index 52937f9cc2ab..8d443749550e 100644
> --- a/arch/sh/configs/magicpanelr2_defconfig
> +++ b/arch/sh/configs/magicpanelr2_defconfig
> @@ -22,6 +22,7 @@ CONFIG_SH_PCLK_FREQ=3D24000000
>  CONFIG_SH_DMA=3Dy
>  CONFIG_SH_DMA_API=3Dy
>  CONFIG_HEARTBEAT=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
>  CONFIG_UNIX=3Dy
> diff --git a/arch/sh/configs/rsk7264_defconfig b/arch/sh/configs/rsk7264_=
defconfig
> index a88cb3b77957..e4ef259425c4 100644
> --- a/arch/sh/configs/rsk7264_defconfig
> +++ b/arch/sh/configs/rsk7264_defconfig
> @@ -21,6 +21,7 @@ CONFIG_MEMORY_START=3D0x0c000000
>  CONFIG_FLATMEM_MANUAL=3Dy
>  CONFIG_CPU_BIG_ENDIAN=3Dy
>  CONFIG_SH_RSK=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  # CONFIG_SH_TIMER_MTU2 is not set
>  CONFIG_BINFMT_FLAT=3Dy
>  CONFIG_NET=3Dy
> diff --git a/arch/sh/configs/rsk7269_defconfig b/arch/sh/configs/rsk7269_=
defconfig
> index d9a7ce783c9b..e0d1560b2bfd 100644
> --- a/arch/sh/configs/rsk7269_defconfig
> +++ b/arch/sh/configs/rsk7269_defconfig
> @@ -10,6 +10,7 @@ CONFIG_MEMORY_SIZE=3D0x02000000
>  CONFIG_FLATMEM_MANUAL=3Dy
>  CONFIG_CPU_BIG_ENDIAN=3Dy
>  CONFIG_SH_RSK=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  # CONFIG_SH_TIMER_MTU2 is not set
>  CONFIG_SH_PCLK_FREQ=3D66700000
>  CONFIG_BINFMT_FLAT=3Dy
> diff --git a/arch/sh/configs/se7619_defconfig b/arch/sh/configs/se7619_de=
fconfig
> index 14d0f5ead502..6b25e9713e77 100644
> --- a/arch/sh/configs/se7619_defconfig
> +++ b/arch/sh/configs/se7619_defconfig
> @@ -14,6 +14,7 @@ CONFIG_FLATMEM_MANUAL=3Dy
>  CONFIG_CPU_BIG_ENDIAN=3Dy
>  CONFIG_SH_7619_SOLUTION_ENGINE=3Dy
>  CONFIG_HZ_100=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_BINFMT_FLAT=3Dy
>  CONFIG_BINFMT_ZFLAT=3Dy
>  # CONFIG_STANDALONE is not set
> diff --git a/arch/sh/configs/se7705_defconfig b/arch/sh/configs/se7705_de=
fconfig
> index 16a0f72f0822..1752ddc2694a 100644
> --- a/arch/sh/configs/se7705_defconfig
> +++ b/arch/sh/configs/se7705_defconfig
> @@ -13,6 +13,7 @@ CONFIG_FLATMEM_MANUAL=3Dy
>  # CONFIG_SH_ADC is not set
>  CONFIG_SH_SOLUTION_ENGINE=3Dy
>  CONFIG_HEARTBEAT=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_PREEMPT=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
> diff --git a/arch/sh/configs/se7722_defconfig b/arch/sh/configs/se7722_de=
fconfig
> index 09e455817447..5327a2f70980 100644
> --- a/arch/sh/configs/se7722_defconfig
> +++ b/arch/sh/configs/se7722_defconfig
> @@ -17,6 +17,7 @@ CONFIG_SH_7722_SOLUTION_ENGINE=3Dy
>  CONFIG_NO_HZ=3Dy
>  CONFIG_HIGH_RES_TIMERS=3Dy
>  CONFIG_HEARTBEAT=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_KEXEC=3Dy
>  CONFIG_PREEMPT=3Dy
>  CONFIG_NET=3Dy
> diff --git a/arch/sh/configs/se7750_defconfig b/arch/sh/configs/se7750_de=
fconfig
> index 5fa6239ae4ea..a1e25d7de8a6 100644
> --- a/arch/sh/configs/se7750_defconfig
> +++ b/arch/sh/configs/se7750_defconfig
> @@ -15,6 +15,7 @@ CONFIG_FLATMEM_MANUAL=3Dy
>  CONFIG_SH_SOLUTION_ENGINE=3Dy
>  CONFIG_SH_PCLK_FREQ=3D33333333
>  CONFIG_HEARTBEAT=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
>  CONFIG_UNIX=3Dy
> diff --git a/arch/sh/configs/secureedge5410_defconfig b/arch/sh/configs/s=
ecureedge5410_defconfig
> index 120176afe3f6..2f77b60e9540 100644
> --- a/arch/sh/configs/secureedge5410_defconfig
> +++ b/arch/sh/configs/secureedge5410_defconfig
> @@ -10,6 +10,7 @@ CONFIG_SH_SECUREEDGE5410=3Dy
>  CONFIG_SH_DMA=3Dy
>  CONFIG_SH_DMA_API=3Dy
>  CONFIG_PCI=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_INET=3Dy
>  # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> diff --git a/arch/sh/configs/sh7710voipgw_defconfig b/arch/sh/configs/sh7=
710voipgw_defconfig
> index 7f742729df69..99a5d0760532 100644
> --- a/arch/sh/configs/sh7710voipgw_defconfig
> +++ b/arch/sh/configs/sh7710voipgw_defconfig
> @@ -15,6 +15,7 @@ CONFIG_MEMORY_SIZE=3D0x00800000
>  CONFIG_FLATMEM_MANUAL=3Dy
>  # CONFIG_SH_ADC is not set
>  CONFIG_SH_PCLK_FREQ=3D32768000
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
>  CONFIG_UNIX=3Dy
> diff --git a/arch/sh/configs/sh7724_generic_defconfig b/arch/sh/configs/s=
h7724_generic_defconfig
> index cbc9389a89a8..5440bd0ca4ed 100644
> --- a/arch/sh/configs/sh7724_generic_defconfig
> +++ b/arch/sh/configs/sh7724_generic_defconfig
> @@ -12,6 +12,7 @@ CONFIG_CPU_FREQ=3Dy
>  CONFIG_SH_CPU_FREQ=3Dy
>  CONFIG_KEXEC=3Dy
>  CONFIG_KEXEC_JUMP=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_HIBERNATION=3Dy
>  CONFIG_CPU_IDLE=3Dy
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> diff --git a/arch/sh/configs/sh7770_generic_defconfig b/arch/sh/configs/s=
h7770_generic_defconfig
> index ee2357deba0f..4338af8d02d0 100644
> --- a/arch/sh/configs/sh7770_generic_defconfig
> +++ b/arch/sh/configs/sh7770_generic_defconfig
> @@ -14,6 +14,7 @@ CONFIG_SH_CPU_FREQ=3Dy
>  CONFIG_KEXEC=3Dy
>  CONFIG_KEXEC_JUMP=3Dy
>  CONFIG_PM=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_HIBERNATION=3Dy
>  CONFIG_CPU_IDLE=3Dy
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/=
sh7785lcr_32bit_defconfig
> index 59262f42abe6..44f9b2317f09 100644
> --- a/arch/sh/configs/sh7785lcr_32bit_defconfig
> +++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
> @@ -32,6 +32,7 @@ CONFIG_PREEMPT=3Dy
>  CONFIG_INTC_USERIMASK=3Dy
>  CONFIG_PCI=3Dy
>  CONFIG_PCI_DEBUG=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_PM=3Dy
>  CONFIG_CPU_IDLE=3Dy
>  CONFIG_NET=3Dy
> diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785=
lcr_defconfig
> index 94381f8268ff..aec74b0e7003 100644
> --- a/arch/sh/configs/sh7785lcr_defconfig
> +++ b/arch/sh/configs/sh7785lcr_defconfig
> @@ -17,6 +17,7 @@ CONFIG_HEARTBEAT=3Dy
>  CONFIG_KEXEC=3Dy
>  CONFIG_PREEMPT=3Dy
>  CONFIG_PCI=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
>  CONFIG_UNIX=3Dy
> diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_=
defconfig
> index 445bb451a5ec..00ef62133b04 100644
> --- a/arch/sh/configs/urquell_defconfig
> +++ b/arch/sh/configs/urquell_defconfig
> @@ -34,6 +34,7 @@ CONFIG_PCIEPORTBUS=3Dy
>  CONFIG_PCIEASPM_DEBUG=3Dy
>  CONFIG_PCI_DEBUG=3Dy
>  CONFIG_BINFMT_MISC=3Dy
> +CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>  CONFIG_PM=3Dy
>  CONFIG_CPU_IDLE=3Dy
>  CONFIG_NET=3Dy

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

