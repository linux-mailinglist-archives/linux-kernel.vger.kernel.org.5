Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD337F4B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjKVPuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjKVPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:49:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE301D42;
        Wed, 22 Nov 2023 07:41:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC11C433CD;
        Wed, 22 Nov 2023 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667683;
        bh=nb+vxqjeyabcUI2vBsYP+73P7f/0NpuXBP4xRLAjd7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBTuAfhePpAotX7sRSqIyitfMkRt+aflL8y0NeRPu/6y8rucwCNTj5e3HzqmtmchV
         5j2g1w3B5cXxxpSGUESksw5sS32gyNtJNwxbVbq2DizpTz7JiCNfN58/UXpEiYwNi3
         QC51V/vyzOT0+dogzVgjEfH+9QjcAzNDe8n1QVpribmvrhyQjdZeaWYQ7d2GBNMwyT
         Kn0Pt3SS1Iv4O1OMeFxLfEDaYZ64qb1oJ4lIycwKFV0EeWXm3H9oWZIzpwZnpmG0e2
         IHO/pvW3UcLwS1b989ZaksrlU63RrN0ZgE0eLqQKBad7csdka4mJTU/Ufz4npRWNSL
         4B9cH0yUTP/jA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5pM9-0002ln-2i;
        Wed, 22 Nov 2023 16:41:38 +0100
Date:   Wed, 22 Nov 2023 16:41:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-ID: <ZV4hMR8oGQBSbnMl@hovoldconsulting.com>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
 <ZTukaxUhgY4WLgEs@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTukaxUhgY4WLgEs@hovoldconsulting.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Sasha,

On Fri, Oct 27, 2023 at 01:52:11PM +0200, Johan Hovold wrote:
> On Fri, Oct 27, 2023 at 11:57:45AM +0100, Srinivas Kandagatla wrote:
> > Click/Pop Noise was a long pending issue with WSA Codecs which are prone
> > to accumlate DC when ports are active but without any data streams.
> > There are multiple places in the current setup, where this could happen
> > in both startup as well as shutdown path.
> > 
> > This patchset adds a new flag mute_unmute_on_trigger to dai_ops to let
> > generic code do the mute/unmute on trigger.
> > 
> > This patches help fix those issues by making sure the PA is Muted/Unmuted
> > inline with the stream start/stop events.
> >
> > Srinivas Kandagatla (2):
> >   ASoC: soc-dai: add flag to mute and unmute stream during trigger
> >   ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag
> 
> I've verified that this fixes the pop sounds when starting and stopping
> a stream on the X13s, even if the click sound when killing pulseaudio
> (e.g. on reboot) is still there (as with the previous fixes).
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> If these are accepted, can we get them backported to 6.5 as well?

These fixes are now in 6.7-rc1 as

	f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
	805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")

As these fix a loud scary crackling noise on the Lenovo ThinkPad X13s,
is it possible to get these backported at least to stable 6.6 and 6.5?

Johan
