Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6510E760952
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjGYFeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGYFeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6992210E4;
        Mon, 24 Jul 2023 22:34:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E321B61534;
        Tue, 25 Jul 2023 05:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78C2C433C7;
        Tue, 25 Jul 2023 05:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690263240;
        bh=YhW2JoN+KACizMCG/NzZPeSofxcSWYCPzvLxYlBvZY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntFeGZVrRVnUlxfbKKMVUrc6DPg6tTLkicFGWod9oPP4XgocN8Ek8b7gHbPBuLSRg
         NztaigcbWOeoNkLS5xYcTfF+TNnP8GOSXCQZBe+FIH1EJ/CAa0wl/qljnrZ3gEYGm0
         Z0bicpHUe4d+DLAiblPALmxXJrQW10EHrlUym5DY=
Date:   Tue, 25 Jul 2023 07:33:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mathias.nyman@intel.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_jackp@quicinc.com, pierre-louis.bossart@linux.intel.com,
        oneukum@suse.com, albertccwang@google.com, o-takashi@sakamocchi.jp
Subject: Re: [PATCH v4 12/32] sound: usb: Export USB SND APIs for modules
Message-ID: <2023072542-playtime-charger-dcfc@gregkh>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-13-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725023416.11205-13-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 07:33:56PM -0700, Wesley Cheng wrote:
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -87,7 +87,7 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
>  /*
>   * find a matching audio format
>   */
> -static const struct audioformat *
> +const struct audioformat *
>  find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
>  	    unsigned int rate, unsigned int channels, bool strict_match,
>  	    struct snd_usb_substream *subs)
> @@ -147,8 +147,9 @@ find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
>  	}
>  	return found;
>  }
> +EXPORT_SYMBOL_GPL(find_format);

This is a horrible symbol name for a global function, same for the other
ones in this file.  If you really want to export them, please put them
in the proper "snd_" prefix namespace, or better yet, use a module
namespace as well to ensure that we know who is using them.

thanks,

greg k-h
