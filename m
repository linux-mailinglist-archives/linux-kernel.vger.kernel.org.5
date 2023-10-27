Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A051C7D96F8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjJ0Lvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345783AbjJ0Lvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:51:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A631D43
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:51:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F2CC433C7;
        Fri, 27 Oct 2023 11:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698407506;
        bh=F9LC6GHBHY7uAatNHDSxSic7rHVxZ1n+xDOqhkfiSWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lN6z7kMbFfGnHS0I+C5BALxSNL3/YKgwnGYJo2rNUXMYJNxbh5Ae/FcsrXCicyyqE
         RAYVpqwZCpGGWRqfC7YXS1W38K3bDdoTGy+Xpli+nFdDYGvRF8+iD5VyxHvElv58Dx
         aiNEgHnleSU1bVRRPnMcSf8oPmHlx0jpMIjVEWBrKVNdCsgCpBuZBEJ4MYha5QHPur
         onrewUlId/MpBMbXo14gig4je18qT7GQQelVo7GKQEFxel+yTibWRvG37QKFLxt+ec
         ao78gN0PYkNi1L+639uiFC9Q7X6WyNxN+pL1I4AqktE8QnlL/4FVWLzi16l1XnUjj1
         fB+dXfUCMJRkA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qwLNr-0005u7-1z;
        Fri, 27 Oct 2023 13:52:11 +0200
Date:   Fri, 27 Oct 2023 13:52:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-ID: <ZTukaxUhgY4WLgEs@hovoldconsulting.com>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 11:57:45AM +0100, Srinivas Kandagatla wrote:
> Click/Pop Noise was a long pending issue with WSA Codecs which are prone
> to accumlate DC when ports are active but without any data streams.
> There are multiple places in the current setup, where this could happen
> in both startup as well as shutdown path.
> 
> This patchset adds a new flag mute_unmute_on_trigger to dai_ops to let
> generic code do the mute/unmute on trigger.
> 
> This patches help fix those issues by making sure the PA is Muted/Unmuted
> inline with the stream start/stop events.
>
> Srinivas Kandagatla (2):
>   ASoC: soc-dai: add flag to mute and unmute stream during trigger
>   ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag

I've verified that this fixes the pop sounds when starting and stopping
a stream on the X13s, even if the click sound when killing pulseaudio
(e.g. on reboot) is still there (as with the previous fixes).

Tested-by: Johan Hovold <johan+linaro@kernel.org>

If these are accepted, can we get them backported to 6.5 as well?

Johan
