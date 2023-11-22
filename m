Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5552B7F4D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjKVQq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjKVQqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:46:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED2B1B5;
        Wed, 22 Nov 2023 08:46:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B59C433C8;
        Wed, 22 Nov 2023 16:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700671611;
        bh=Ixoj1ZvTEGh811u0GLno9LmWU1DPcMeaYdUrYC39smM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkQr7SMNtfyyFwIKjw6EOSmHJbvc0I2sZal2yPuXSVOCs9VmQTOaz/e82zJ4vBzPD
         voPmwsbHXAH2IMnbHy72vG+BHz596cjPYEadMhXNKEU9+b2ulS5yaA8FG5HMFzNVdJ
         KaUGbuRjwUjGcMjJnI0k4D3OCh4JG7Fpu55gefeg=
Date:   Wed, 22 Nov 2023 16:46:49 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-ID: <2023112230-emphases-stardom-3d3a@gregkh>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
 <ZTukaxUhgY4WLgEs@hovoldconsulting.com>
 <ZV4hMR8oGQBSbnMl@hovoldconsulting.com>
 <2023112225-crop-uncle-9097@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112225-crop-uncle-9097@gregkh>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 04:35:17PM +0000, Greg Kroah-Hartman wrote:
> On Wed, Nov 22, 2023 at 04:41:37PM +0100, Johan Hovold wrote:
> > Hi Greg and Sasha,
> > 
> > On Fri, Oct 27, 2023 at 01:52:11PM +0200, Johan Hovold wrote:
> > > On Fri, Oct 27, 2023 at 11:57:45AM +0100, Srinivas Kandagatla wrote:
> > > > Click/Pop Noise was a long pending issue with WSA Codecs which are prone
> > > > to accumlate DC when ports are active but without any data streams.
> > > > There are multiple places in the current setup, where this could happen
> > > > in both startup as well as shutdown path.
> > > > 
> > > > This patchset adds a new flag mute_unmute_on_trigger to dai_ops to let
> > > > generic code do the mute/unmute on trigger.
> > > > 
> > > > This patches help fix those issues by making sure the PA is Muted/Unmuted
> > > > inline with the stream start/stop events.
> > > >
> > > > Srinivas Kandagatla (2):
> > > >   ASoC: soc-dai: add flag to mute and unmute stream during trigger
> > > >   ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag
> > > 
> > > I've verified that this fixes the pop sounds when starting and stopping
> > > a stream on the X13s, even if the click sound when killing pulseaudio
> > > (e.g. on reboot) is still there (as with the previous fixes).
> > > 
> > > Tested-by: Johan Hovold <johan+linaro@kernel.org>
> > > 
> > > If these are accepted, can we get them backported to 6.5 as well?
> > 
> > These fixes are now in 6.7-rc1 as
> > 
> > 	f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
> 
> This doesn't backport cleanly, can you provide a working backport?
> 
> > 	805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")
> 
> Now queued up, thanks.

And that broke the build, I'll go drop that too :(

