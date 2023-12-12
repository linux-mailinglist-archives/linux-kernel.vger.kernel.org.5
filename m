Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498EB80EC62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346617AbjLLMo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346779AbjLLMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:44:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F21CAC;
        Tue, 12 Dec 2023 04:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702385097; x=1733921097;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cHqtOeNKP076/ZBIP1FBovIIDSXx16JPG8Oa+T/X2Sk=;
  b=M7uWfJ4TUHUDKEePSmp97ECavY3/iEbIsfUHXfXgQ9hsqQQVF07cNAHG
   sK/LhEWIo9fYRRv3B9tdyu0L3RKW4XkYsJ45A/y4i2LAFd5wRghj4o4Ne
   OtZC8NLteeqgbj/F1HyiieL71oLOVNqb8pT2cYilqxAIhSQvN+uNCdgva
   d0F64GZGnUcfF64Sd/qAlcEPBYKj38/t9hPGSLsZYLPDrVBfXyQouEIjR
   /445cO55KrzUPVdXJ67GIfX2OYnYoIsGWDM4R1h/B0JCyMhsipO5zQ6Nz
   LdcvPM+hvqt5fV6ty5Q1V/QRAb3TzTXvaIYcBbiC8NLDPufdhT4B3NlZS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="397586774"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="397586774"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 04:44:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="17634142"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 04:44:54 -0800
Date:   Tue, 12 Dec 2023 14:44:41 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: hdac_hda: Fix NULL pointer dereference when hda_pvt
 is not set
In-Reply-To: <20231212064533.233748-1-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2312121441490.14041@eliteleevi.tm.intel.com>
References: <20231212064533.233748-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 12 Dec 2023, Kai-Heng Feng wrote:

> Kernel splat can be found on boot:
> [    7.906438] BUG: kernel NULL pointer dereference, address: 0000000000000078
> [    7.906449] #PF: supervisor read access in kernel mode
> [    7.906455] #PF: error_code(0x0000) - not-present page
[...]
> This is caused by attempting to dereference hda_pvt, so check if it's
> NULL before using it.
> 
> Fixes: a0575b4add21 ("ASoC: hdac_hda: Conditionally register dais for HDMI and Analog")

can you try this fix already merged to Mark's tree (merged on 7th Dec):

"ASoC: SOF: Intel: hda-codec: Delay the codec device registration"
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=ce17aa4cf2db7d6b95a3f854ac52d0d49881dd49

Br, Kai
