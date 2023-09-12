Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4E79D7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbjILRoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbjILRoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:44:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473DB10C9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694540655; x=1726076655;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cm5fmflUTyUPcscwv9xakLpN6ml82B7DzcINH5QsMyM=;
  b=ROsOy7uQ0lJ8cJKVHFTwqz4HYNg7gkNY3tfjwFLeXNaq3ycc4q5lWP+9
   Uqx5gG9KQFj8vPuc1k82b7VaB+Po4ILcIXRi16z0nAYatP4zsYEWi8dd7
   9LNB0csZLvz1tSwMIl48W1DpQLKp44LFNwLUkEt8VfhGIe1QiiDuDEREt
   aXiQLvUxPY6/EpvkO++jwXf8K9zOHTcBtQRxRp4SFp9hEIHEzHelHAZrU
   5Z3HCuGtKeNWuztnF6WDlur+N6kA/GAr148QZO4zo4al2X1YqUES5zWcP
   Hr8CPE+OK5Z0Sz3vZw+piqW0Bt4nw8U50na0vCA3Yc2GWkLaQ+eMNOsOM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378356230"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378356230"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809363946"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="809363946"
Received: from skotini-mobl.amr.corp.intel.com (HELO [10.209.169.137]) ([10.209.169.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:44:14 -0700
Message-ID: <1d2d927d-6506-86fb-fc42-038d2d70c853@linux.intel.com>
Date:   Tue, 12 Sep 2023 13:39:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] ASoC: cs35l56: Use PCI SSID to select specific
 firmware
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        yung-chuan.liao@linux.intel.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20230912163207.3498161-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230912163207.3498161-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/23 12:32, Richard Fitzgerald wrote:
> The PCI device registers contain a subsystem ID (SSID), that is
> separate from the silicon ID. The PCI specification defines it thus:
> 
> "They provide a mechanism for board vendors to distiguish their
>  boards from one another even thought the boards may have the same
>  PCI controller on them."
> 
> This allows the driver for the silicon part to apply board-speficic
> settings based on this SSID.
> 
> The CS35L56 driver uses this to select the correct firmware file for
> the board. The actual ID is part of the PCI register set of the
> host audio interface so this set of patches includes extracting the
> SSID from the Intel audio controller and passing it to the machine
> driver and then to ASoC components. Other PCI audio controllers
> will have the same SSID registers, so can use the same mechanism to
> pass the SSID.
> 
> Richard Fitzgerald (4):
>   ASoC: soc-card: Add storage for PCI SSID
>   ASoC: SOF: Pass PCI SSID to machine driver
>   ASoC: Intel: sof_sdw: Copy PCI SSID to struct snd_soc_card
>   ASoC: cs35l56: Use PCI SSID as the firmware UID

for the series

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> 
>  include/sound/soc-acpi.h         |  7 ++++++
>  include/sound/soc-card.h         | 37 ++++++++++++++++++++++++++++++++
>  include/sound/soc.h              | 11 ++++++++++
>  include/sound/sof.h              |  8 +++++++
>  sound/soc/codecs/cs35l56.c       | 11 ++++++++++
>  sound/soc/intel/boards/sof_sdw.c |  6 ++++++
>  sound/soc/sof/sof-audio.c        |  7 ++++++
>  sound/soc/sof/sof-pci-dev.c      |  8 +++++++
>  8 files changed, 95 insertions(+)
> 
