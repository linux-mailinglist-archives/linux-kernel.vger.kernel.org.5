Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08357F9BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjK0IeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjK0IeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:34:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BD0A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:34:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804CDC433C7;
        Mon, 27 Nov 2023 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701074051;
        bh=unCaXJLxTUPj78Mw3wAj0N85QPztmDRO+DsnNzOcHyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eeGLYqfHsnH5C6JZJowFVGo9N5tWStKUX+kM+DtxMi7feq8XDRqdrh5Kd71O7SOPv
         jcXSPKwkVBN/lTBdh6MAQMaoP9XelvBzA8LyL+R20UoV6Cs+fLQO7ldHpTAiHQA58e
         aZ+E4v/P+v+uD7kviN+GaxpOjy0gCd7+itWbRKSkjjUrYnLgBgqYUZoNrlpdB4+p88
         ILOrEGU5g+6zjXMkhdBNzJ4DqEkYDEoVvu93RwXhbsXevJu2Mj21tpj1itZ59FcsqV
         he+pXIMym5Br9bRJdUZtYR3TuJET+EoeXlw16FnAF93Y996DFyICivSTRIH6uL3QBU
         Ys7Jt98Wddt+w==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r7X4f-0002ln-0B;
        Mon, 27 Nov 2023 09:34:37 +0100
Date:   Mon, 27 Nov 2023 09:34:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-ID: <ZWRUnUvzJIxqFXDI@hovoldconsulting.com>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
 <ZTukaxUhgY4WLgEs@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTukaxUhgY4WLgEs@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

For the record, the remaining click sounds were incidentally fixed by
commit 3efcb471f871 ("ASoC: soc-pcm.c: Make sure DAI parameters cleared
if the DAI becomes inactive") which also went into 6.7-rc1:

	https://lore.kernel.org/lkml/20230920153621.711373-1-chancel.liu@nxp.com/

Johan
