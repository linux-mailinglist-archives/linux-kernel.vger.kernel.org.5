Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A74773BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjHHP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHHPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:55:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634AD5B89
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691509427; x=1723045427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jHOYn9//8iPX+RoPt/5H1z0TENE0RN0IS8pVvDCFJC0=;
  b=XqI32yKRcgV03nxJVN6NkuEIg2kWcRD/SzoYEIPTYWHpqk/zlh6VaXZC
   Di6Si/PEo7kJ/yL5MsEJWpSC+1LdZbQEldgKmklZdNy2847ypHMBxNcbs
   Efe05Tnx1Bfs1KQWcVIcJceO8ZAY8W3oyqe4KtjPzYBkgGSG3AfPQ/pXX
   To48Y+9ZzTORnUhkguDar1eL+dzhn7HlcK2ddK41ZdXNQm08OQ/ZtmDGG
   2ta6eyiWidvx0WViRGrukG1bD98XxnWUYALfDcg9nkSq2QI9vWUIQqR8E
   cK4x1P95ULdZOHNfJuXMQMVJBW/l1W8SJW6XyJxZSqqNpoX9zg896bRgR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457176638"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="457176638"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 04:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681198357"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="681198357"
Received: from romanagn-mobl1.ger.corp.intel.com (HELO [10.252.49.59]) ([10.252.49.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 04:01:45 -0700
Message-ID: <98188012-8e07-4bb1-be1c-04d6c0f5260a@linux.intel.com>
Date:   Tue, 8 Aug 2023 14:03:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression fix not progressing towards mainline/stable
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     sound-open-firmware@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Alsa-devel <alsa-devel@alsa-project.org>
References: <661fcece-a83c-cb24-1b37-5d8693b1fb94@leemhuis.info>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <661fcece-a83c-cb24-1b37-5d8693b1fb94@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On 08/08/2023 09:10, Thorsten Leemhuis wrote:
> Hi everyone, I noticed a regression fix that afaics lingers in the
> thesofproject's git repo instead of progressing towards the stable trees
> and wondered what's up here.
>
> I'm talking about about the fix "ASoC: SOF: intel: hda: Clean up link
> DMA for IPC3 during stop" for this ticket:
> https://github.com/thesofproject/linux/issues/4455
> 
> Two more tickets about it:
> https://github.com/thesofproject/linux/issues/4482
> https://bugzilla.kernel.org/show_bug.cgi?id=217673
> 
> It seems the fix is ready and reviewed for two weeks now, but not even
> in -next by now. That's not how it should be for regression fixes, as
> per https://docs.kernel.org/process/handling-regressions.html it ideally
> should be in -stable soon or already. Is this a mistake, am I missing
> something, or is there a good reason for this?

We take regressions (and user reports) seriously and trying our best to
provide fixes asap.
We do prioritize bug fixes over features but in this case for some
reason the review process took longer than it usually does and the patch
has not been sent upstream. Patches must pass the review before they put
to the upstream queue.

I will be sending the fix in few minutes after testing it on top of next.

-- 
Péter
