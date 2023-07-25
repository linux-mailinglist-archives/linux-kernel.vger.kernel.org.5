Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132527610DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjGYK3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjGYK32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:29:28 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3FA10F6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:29:10 -0700 (PDT)
Message-ID: <1bb7858d-fab0-f3c2-b786-a93f3789b400@linux.intel.com>
Date:   Tue, 25 Jul 2023 12:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 8/9] ASoC: SOF: Intel: Remove deferred probe for SOF
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Matthew Auld <matthew.auld@intel.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <20230719164141.228073-9-maarten.lankhorst@linux.intel.com>
 <03d5abcd-53a6-bf61-227e-d608c5fbfe70@linux.intel.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <03d5abcd-53a6-bf61-227e-d608c5fbfe70@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 2023-07-24 13:32, Pierre-Louis Bossart wrote:
> 
> 
> On 7/19/23 18:41, Maarten Lankhorst wrote:
>> This was only used to allow modprobing i915, by converting to the
>> -EPROBE_DEFER mechanism, it can be completely removed, and is in
>> fact counterproductive since -EPROBE_DEFER otherwise won't be
>> handled correctly.
> 
> I personally remember only that the request_module("i915") was the main
> motivation for the use of the workqueue, but when it comes to the
> HDaudio codec management we don't even know what we don't know.
> 
> I am a bit worried that the snd-hda-intel driver keeps the workqueue for
> HDaudio codec initialization, and this patch removes the workqueue
> completely for SOF. That doesn't seem right. Either both drivers need a
> workqueue or none need a workqueue.
> 
> Maybe what we need is to move the i915/xe initialization out of the
> workqueue, and see in a second pass if that workqueue can be safely
> removed from the SOF driver?
> 
As I mentioned in some of the other sound driver conversions. I believe 
it's possible to completely kill off most workqueues.

However, I don´t have the hardware or knowledge to test it. I saw that 
the SOF had the non-workqueue path already, so it felt less risky to 
simply convert it to always use that path.

avs/skylake drivers should be easy to convert too. This is why I left 
the comment: "Removing the workqueue would simplify init even further, 
but is left as exercise for the reviewer."

HDA-intel has this retry-probe logic used on AMD's,
which makes me more hesitant to convert it.

I wanted to tackle one problem at a time, I believe workqueue removal 
can be done by anyone.

Cheers,
~Maarten
