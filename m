Return-Path: <linux-kernel+bounces-29111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8BF8308CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810871F25ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD1219F9;
	Wed, 17 Jan 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEaoM5zA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD2820B38;
	Wed, 17 Jan 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503139; cv=none; b=JsdBGG+t1G+DctDEipGoY1S8MMYFfnJAUt5ZqFtoTh8Kl+hc73MG9ebpHURuAX1y8Vny5kVmRPO0LhO4/qsCEsQMFDWs4YhsV1hfCbSrUycKkh8xJecm7dkVw8/Qb0Wvrc9tqwZn75gzUuPIS2YlfJPwfKVBUZiFemriWWyGnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503139; c=relaxed/simple;
	bh=2fMFVmmLcybgOzonSAH/hVLVnteRTXL5AUOqv3OZBKA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=PSWcgrEOQw7cmfz0S8U4ypeqNLMSp6/pqE/UoecK8jSaYkGDLseLMGdRnOgDcBxC78kGkqwo66M8/fZbu50WTrWDQHs8HevxP8nPE3axr116QNj2LdYOVrfAq1XBY+sj91DjHfYwTruK7AP3x2oKPeyPjVERJy7yJzgtStdyqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEaoM5zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7098C433C7;
	Wed, 17 Jan 2024 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705503138;
	bh=2fMFVmmLcybgOzonSAH/hVLVnteRTXL5AUOqv3OZBKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEaoM5zAmPOxyG/9s5w4W0YKD/idcpTs77OU8rQ7lwa8es5pCsvPmquvOvbGahx+d
	 kKohTXG5rwx5Z+7iEFZiEaQeCwltEY0qdjUdJ5du3iXy92JqZ+NyZN/oIwGZrzw+6b
	 EzOpQxs7tY3EubXzIUHXu4lCSexXrhNOlbh39AzjPE2IOHuozyBFummBKx1ryl6kSg
	 kNK0pyzqTKGh0BL4om28Tx3BWAA+JLl/5KTelq+dBHRWS+y0U1E8eq1VUhQrzgWHem
	 o734PeQOZhScEx6nsxG/EqKZQwuF3oxWn9yvbHxbHXPtRk2dmTEPNfsVviAneY8cKy
	 3bwk/8C9ervmg==
Date: Wed, 17 Jan 2024 08:52:16 -0600
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
	Simon Glass <sjg@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] kbuild: simplify dtbs_install by reading the list of
 compiled DTBs
Message-ID: <20240117145216.GA2296118-robh@kernel.org>
References: <20240109120738.346061-1-masahiroy@kernel.org>
 <20240109120738.346061-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109120738.346061-3-masahiroy@kernel.org>

On Tue, Jan 09, 2024 at 09:07:35PM +0900, Masahiro Yamada wrote:
> Retrieve the list of *.dtb(o) files from arch/*/boot/dts/dtbs-list
> instead of traversing the directory tree again.

Don't you need dtbs-list in .gitignore?

> 
> Please note that 'make dtbs_install' installs *.dtb(o) files directly
> added to dtb-y because scripts/Makefile.dtbinst installs $(dtb-y)
> without expanding the -dtbs suffix.
> 
> This commit preserves this behavior.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Makefile                 |  2 +-
>  scripts/Kbuild.include   |  6 ------
>  scripts/Makefile.dtbinst | 32 ++++++++++++++++++--------------
>  3 files changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index db7f9e34a24e..dae6825b8082 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1407,7 +1407,7 @@ endif
>  dtbs_check: dtbs
>  
>  dtbs_install:
> -	$(Q)$(MAKE) $(dtbinst)=$(dtstree) dst=$(INSTALL_DTBS_PATH)
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.dtbinst obj=$(dtstree)
>  
>  ifdef CONFIG_OF_EARLY_FLATTREE
>  all: dtbs
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 7778cc97a4e0..2f331879816b 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -113,12 +113,6 @@ endef
>  # $(Q)$(MAKE) $(build)=dir
>  build := -f $(srctree)/scripts/Makefile.build obj
>  
> -###
> -# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
> -# Usage:
> -# $(Q)$(MAKE) $(dtbinst)=dir
> -dtbinst := -f $(srctree)/scripts/Makefile.dtbinst obj
> -
>  ###
>  # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.clean obj=
>  # Usage:
> diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
> index 4405d5b67578..67956f6496a5 100644
> --- a/scripts/Makefile.dtbinst
> +++ b/scripts/Makefile.dtbinst
> @@ -8,32 +8,36 @@
>  #   $INSTALL_PATH/dtbs/$KERNELRELEASE
>  # ==========================================================================
>  
> -src := $(obj)
> -
>  PHONY := __dtbs_install
>  __dtbs_install:
>  
>  include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
> -include $(kbuild-file)
>  
> -dtbs    := $(addprefix $(dst)/, $(dtb-y) $(if $(CONFIG_OF_ALL_DTBS),$(dtb-)))
> -subdirs := $(addprefix $(obj)/, $(subdir-y) $(subdir-m))
> -
> -__dtbs_install: $(dtbs) $(subdirs)
> -	@:
> +dst := $(INSTALL_DTBS_PATH)
>  
>  quiet_cmd_dtb_install = INSTALL $@
>        cmd_dtb_install = install -D $< $@
>  
> -$(dst)/%.dtb: $(obj)/%.dtb
> +$(dst)/%: $(obj)/%
>  	$(call cmd,dtb_install)
>  
> -$(dst)/%.dtbo: $(obj)/%.dtbo
> -	$(call cmd,dtb_install)
> +dtbs := $(patsubst $(obj)/%,%,$(call read-file, $(obj)/dtbs-list))
>  
> -PHONY += $(subdirs)
> -$(subdirs):
> -	$(Q)$(MAKE) $(dtbinst)=$@ dst=$(if $(CONFIG_ARCH_WANT_FLAT_DTB_INSTALL),$(dst),$(patsubst $(obj)/%,$(dst)/%,$@))
> +ifdef CONFIG_ARCH_WANT_FLAT_DTB_INSTALL
> +
> +define gen_install_rules
> +$(dst)/%: $(obj)/$(1)%
> +	$$(call cmd,dtb_install)
> +endef
> +
> +$(foreach d, $(sort $(dir $(dtbs))), $(eval $(call gen_install_rules,$(d))))
> +
> +dtbs := $(notdir $(dtbs))
> +
> +endif # CONFIG_ARCH_WANT_FLAT_DTB_INSTALL
> +
> +__dtbs_install: $(addprefix $(dst)/, $(dtbs))
> +	@:
>  
>  .PHONY: $(PHONY)
> -- 
> 2.40.1
> 

