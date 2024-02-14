Return-Path: <linux-kernel+bounces-64830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B613485435D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B571F23FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F8B11716;
	Wed, 14 Feb 2024 07:23:17 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BA111B5;
	Wed, 14 Feb 2024 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895396; cv=none; b=SUkPGKKXmaqKw86QQbotyab7xkKbwj2/yrGFejdlWILtuIyGyKF2NG2kxlIJEhTQTL6PAhTc46988LU7qV6k4eldLj3dGynvHMQ0JZJIxnoxZ2J3E1I4Offzet5aQT9Ome+b16AG0Z58yiQFB29I9k3kZAkaZ2f27AnrbejWAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895396; c=relaxed/simple;
	bh=zYB2nxLixfzl3ch2TWuc6MXy/7yfnH7admD1znY/Ky8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=km4r5TzbXr57BJcq0aAMiOCvAXXRePqxaj7GSReyTuNhgINWAgkI4gvV9Isb0L6leikoGyo3c0ooVgQ+B42fAvaCdRAVSABhjLhCOGDsKvCOVt/vy4cAFKJy+HVQR2FrHwb4Frqey5qmczXr1/9n7RMrsVVq+qAEy17FeIe+5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aea4b.dynamic.kabel-deutschland.de [95.90.234.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1916E61E5FE05;
	Wed, 14 Feb 2024 08:22:21 +0100 (CET)
Message-ID: <926b5031-47d2-42d7-938d-01fc4ebc9dc0@molgen.mpg.de>
Date: Wed, 14 Feb 2024 08:22:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [net-next v3] intel: make module parameters
 readable in sys filesystem
To: Jon Maxwell <jmaxwell37@gmail.com>, jesse.brandeburg@intel.com
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
References: <20240213222344.195885-1-jmaxwell37@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240213222344.195885-1-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jon,


Thank you very much for your patch.

Am 13.02.24 um 11:23 PM schrieb Jon Maxwell:
> Linux users sometimes need an easy way to check current values of module
> parameters. For example the module may be manually reloaded with different
> parameters. Make these visible and readable in the /sys filesystem to allow
> that.
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> ---
> V2: Remove the "debug" module parameter as per Andrew Lunns suggestion.

Please mention this in the commit message, why `debug` should not be 
exposed.


Kind regards,

Paul


> V3: Correctly format v2.
>   drivers/net/ethernet/intel/e100.c             | 4 ++--
>   drivers/net/ethernet/intel/igb/igb_main.c     | 2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index 01f0f12035caeb7ca1657387538fcebf5c608322..3fcb8daaa2437fa3fe7b98ba9f606dbbb1844e58 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -171,8 +171,8 @@ static int debug = 3;
>   static int eeprom_bad_csum_allow = 0;
>   static int use_io = 0;
>   module_param(debug, int, 0);
> -module_param(eeprom_bad_csum_allow, int, 0);
> -module_param(use_io, int, 0);
> +module_param(eeprom_bad_csum_allow, int, 0444);
> +module_param(use_io, int, 0444);
>   MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
>   MODULE_PARM_DESC(eeprom_bad_csum_allow, "Allow bad eeprom checksums");
>   MODULE_PARM_DESC(use_io, "Force use of i/o access mode");
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 4df8d4153aa5f5ce7ac9dd566180d552be9f5b4f..31d0a43a908c0a4eab4fe1147064a5f5677c9f0b 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -202,7 +202,7 @@ static struct notifier_block dca_notifier = {
>   #endif
>   #ifdef CONFIG_PCI_IOV
>   static unsigned int max_vfs;
> -module_param(max_vfs, uint, 0);
> +module_param(max_vfs, uint, 0444);
>   MODULE_PARM_DESC(max_vfs, "Maximum number of virtual functions to allocate per physical function");
>   #endif /* CONFIG_PCI_IOV */
>   
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index bd541527c8c74d6922e8683e2f4493d9b361f67b..9d26ff82a397d4939cf7adea78c217e4071aa166 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -147,13 +147,13 @@ static struct notifier_block dca_notifier = {
>   
>   #ifdef CONFIG_PCI_IOV
>   static unsigned int max_vfs;
> -module_param(max_vfs, uint, 0);
> +module_param(max_vfs, uint, 0444);
>   MODULE_PARM_DESC(max_vfs,
>   		 "Maximum number of virtual functions to allocate per physical function - default is zero and maximum value is 63. (Deprecated)");
>   #endif /* CONFIG_PCI_IOV */
>   
>   static bool allow_unsupported_sfp;
> -module_param(allow_unsupported_sfp, bool, 0);
> +module_param(allow_unsupported_sfp, bool, 0444);
>   MODULE_PARM_DESC(allow_unsupported_sfp,
>   		 "Allow unsupported and untested SFP+ modules on 82599-based adapters");
>   

