Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B467F9BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjK0I2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjK0I2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:28:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469CFD6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:28:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E8AC433C7;
        Mon, 27 Nov 2023 08:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701073738;
        bh=zkIajtumZwqOpyIXYiKzh7afVZjXgDnAjVN67KB4Nlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCG7Yqk0IfGUKmVsDhCjnubH3mc95XUFU5wIkJ8Rlwey4P+qEJXOJ3l7F3h9zUWPJ
         su8x78HsvwdKDB3OJNkqZpkMCbcdDSwePwhUXt7TQZFqZtfOFHUez30wk2US3dNJ3m
         PE3Z/Lpa/b+UaLCXu6ElIJv4IVfVNFHeAPHUFqSeRGgB8k3XEt7UcUe6hVJMlmY+2w
         QMUzXjEb0XZzEtVszH8qAsqiWoTzB8+wQ0U5Z8k7x1msftlCUxb5amAz1XSqcIGp4F
         bT5ju7o3CLSNJEUo2KLoicEkJrKPrJx6qkpJqErcK+yjk8rcF9LmVuWwej6k8Y3CQ+
         SQwgxxmUwTGTQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r7Wzc-0002jY-1S;
        Mon, 27 Nov 2023 09:29:24 +0100
Date:   Mon, 27 Nov 2023 09:29:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/1] ASoC: soc-pcm.c: Make sure DAI parameters cleared
 if the DAI becomes inactive
Message-ID: <ZWRTZLi9SqarEUXa@hovoldconsulting.com>
References: <20230920153621.711373-1-chancel.liu@nxp.com>
 <20230920153621.711373-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920153621.711373-2-chancel.liu@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:36:21PM +0800, Chancel Liu wrote:
> The commit 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs parameters after
> stream_active is updated") tries to make sure DAI parameters can be
> cleared properly through moving the cleanup to the place where stream
> active status is updated. However, it will cause the cleanup only
> happening in soc_pcm_close().
> 
> Suppose a case: aplay -Dhw:0 44100.wav 48000.wav. The case calls
> soc_pcm_open()->soc_pcm_hw_params()->soc_pcm_hw_free()->
> soc_pcm_hw_params()->soc_pcm_hw_free()->soc_pcm_close() in order. The
> parameters would be remained in the system even if the playback of
> 44100.wav is finished.
> 
> The case requires us clearing parameters in phase of soc_pcm_hw_free().
> However, moving the DAI parameters cleanup back to soc_pcm_hw_free()
> has the risk that DAIs parameters never be cleared if there're more
> than one stream, see commit 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs
> parameters after stream_active is updated") for more details.
> 
> To meet all these requirements, in addition to do DAI parameters
> cleanup in soc_pcm_hw_free(), also check it in soc_pcm_close() to make
> sure DAI parameters cleared if the DAI becomes inactive.
> 
> Fixes: 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs parameters after stream_active is updated")
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

For the record, this change incidentally also fixed the remaining click
sounds I heard when stopping pulseaudio (e.g. on reboot) with the Lenovo
ThinkPad X13s, which have also been discussed here:

	https://lore.kernel.org/lkml/ZTukaxUhgY4WLgEs@hovoldconsulting.com/

Johan
