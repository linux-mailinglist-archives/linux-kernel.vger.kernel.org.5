Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F697D3F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjJWSkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWSkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:40:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776C5B7;
        Mon, 23 Oct 2023 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698086415; x=1729622415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7I76GhrFH1ankannClmf806vy5yk8xmXcsOuatft2C8=;
  b=jK/lvCYdTWyBeONLE9BFEWH1EXFfPWYNwKWwYD6znV4b1LERWojBMnoT
   cQkjZtgdk1C+DdLBrj9a+wGCqUmLk/9q+v8GCCHfQC/LcqynhJYxa8eUQ
   LWrop+/waE09AXwl/W6ONzBswj7vLml5ykZPfdNkGa6iHDpQNEDnnxlF1
   1i25qV4zdbQ6f7OT3VRHdJYc1NG6s622UL+un9CsertStHG9l2JPw7+6q
   hYP4VYYXjSyrwBCjUVIbP9mQREhBeYU5V/NMA/tGVnNwGpf3eXObfNpkZ
   GdhPCCxDSinsMAF1CAAwpwGC37nVP+uxI0DI213NEMg5AtkagGwB9WTrQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="390788523"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="390788523"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 11:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="824048819"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="824048819"
Received: from weiyiwil-mobl.amr.corp.intel.com (HELO [10.212.122.211]) ([10.212.122.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 11:40:02 -0700
Message-ID: <fb7cf366-b659-4321-b81b-ca76704a85ab@linux.intel.com>
Date:   Fri, 20 Oct 2023 16:21:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ALSA: SOF: sof-pci-dev: Fix community key quirk
 detection
Content-Language: en-US
To:     Curtis Malainey <cujomalainey@google.com>,
        Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        stable@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org
References: <20231020145953.v1.1.Iaf5702dc3f8af0fd2f81a22ba2da1a5e15b3604c@changeid>
 <CAOReqxhrhzWh-aO5kt-7yqcfX9CbHW-WBgBAqQ9FqeUj-h1o=A@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAOReqxhrhzWh-aO5kt-7yqcfX9CbHW-WBgBAqQ9FqeUj-h1o=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Oct 20, 2023 at 2:00 PM Mark Hasemeyer <markhas@chromium.org> wrote:
>>
>> Some Chromebooks do not populate the product family DMI value resulting
>> in firmware load failures.
>>
>> Add another quirk detection entry that looks for "Google" in the BIOS
>> version. Theoretically, PRODUCT_FAMILY could be replaced with
>> BIOS_VERSION, but it is left as a quirk to be conservative.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> 
> Acked-by: Curtis Malainey <cujomalainey@chromium.org>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Now let's see how the machine drivers need to be updated...
