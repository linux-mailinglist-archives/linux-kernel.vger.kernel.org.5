Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FD37CEC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjJSADI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJSADG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:03:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26CD106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:03:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5b5354da665so2505563a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697673784; x=1698278584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/Zi+O5EOF8MxmYTpNQNZzDcOGwyvihj+XdDWSOvn6s=;
        b=iTY8joTjEef/ERLwWT1SitzkN02oqldiSAsUv38Bn7nIXqZFzrW+D9erwAxe29Dk7V
         O5rSFaI9v6q1Ndk/Dh3RgW0ZXHyiQxwvJH801k5CfMuHe5aHLwsQ9LlMz0GPxdsBGiRU
         AkK+jzaPEqxxikeP6WT23RtUwlDnlMTqCvLKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697673784; x=1698278584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/Zi+O5EOF8MxmYTpNQNZzDcOGwyvihj+XdDWSOvn6s=;
        b=vGX368tviB/N9P+SVivYUez1TROEsTKj21pWYVn5gRTK7d+luOugH7CzbyyIzooEp/
         zjQd8jiNTn6ZuK/ypTH6Ik8CkdwGVrhGUhnSdb654yjAZJKXOfhI6izu5AKHaxXNCEkO
         +DpwlBdfY+QxmKOH0lhQpsNG+jEqafAk3yRitxNdOG+rjoUv2k5NvYjDAIte+TmPnrmh
         ySUzCYs+DjHCBr2juO0nyiGi8w8Av7lyascZgQHLKw8yGbJ/1mgRbk34jpxhQF6HSDgq
         m48k/vj67rQ0GwVBNlEoo7v2mDxVAI+qND3Ns93qXT3gmFdvV1ItOWE1lPRN9O3nrUB2
         upuw==
X-Gm-Message-State: AOJu0YzWeLo5y6wareMHn6x4kNsUF09abKdMrjFWOv7DT/B6wTjD1NG4
        B7/sBnJsTqetaPCdo7fIh8VyqA==
X-Google-Smtp-Source: AGHT+IGrcFp93mw31etRpM+tGlTdUDGBZ2GMJztc6dNNbeKI6ATXUY7U6QHgT4Dp4nc4Q3FOq4tEVA==
X-Received: by 2002:a05:6a20:12d5:b0:16b:c62d:876 with SMTP id v21-20020a056a2012d500b0016bc62d0876mr866390pzg.23.1697673784108;
        Wed, 18 Oct 2023 17:03:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d92-20020a17090a6f6500b0027654d389casm467204pjk.54.2023.10.18.17.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:03:03 -0700 (PDT)
Date:   Wed, 18 Oct 2023 17:03:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] wifi: brcmsmac: replace deprecated strncpy with
 memcpy
Message-ID: <202310181654.E47A7709@keescook>
References: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
 <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-2-af780d74ae38@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-2-af780d74ae38@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:11:29PM +0000, Justin Stitt wrote:
> Let's move away from using strncpy and instead use the more obvious
> interface for this context.
> 
> For wlc->pub->srom_ccode, we're just copying two bytes from ccode into
> wlc->pub->srom_ccode with no expectation that srom_ccode be
> NUL-terminated:
> wlc->pub->srom_ccode is only used in regulatory_hint():
> 1193 |       if (wl->pub->srom_ccode[0] &&
> 1194 |           regulatory_hint(wl->wiphy, wl->pub->srom_ccode))
> 1195 |               wiphy_err(wl->wiphy, "%s: regulatory hint failed\n", __func__);
> 
> We can see that only index 0 and index 1 are accessed.
> 3307 |       int regulatory_hint(struct wiphy *wiphy, const char *alpha2)
> 3308 |       {
> ...  |          ...
> 3322 |          request->alpha2[0] = alpha2[0];
> 3323 |          request->alpha2[1] = alpha2[1];
> ...  |          ...
> 3332 |       }
> 
> Since this is just a simple byte copy with correct lengths, let's use
> memcpy(). There should be no functional change.
> 
> In a similar boat, both wlc->country_default and
> wlc->autocountry_default are just simple byte copies so let's use
> memcpy. However, FWICT they aren't used anywhere. (they should be
> used or removed -- not in scope of my patch, though).
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> index 5a6d9c86552a..f6962e558d7c 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> @@ -341,7 +341,7 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(struct brcms_c_info *wlc)
>  	/* store the country code for passing up as a regulatory hint */
>  	wlc_cm->world_regd = brcms_world_regd(ccode, ccode_len);
>  	if (brcms_c_country_valid(ccode))
> -		strncpy(wlc->pub->srom_ccode, ccode, ccode_len);
> +		memcpy(wlc->pub->srom_ccode, ccode, ccode_len);

        const char *ccode = sprom->alpha2;
        int ccode_len = sizeof(sprom->alpha2);

struct ssb_sprom {
	...
        char alpha2[2];         /* Country Code as two chars like EU or US */

This should be marked __nonstring, IMO.

struct brcms_pub {
	...
        char srom_ccode[BRCM_CNTRY_BUF_SZ];     /* Country Code in SROM */

#define BRCM_CNTRY_BUF_SZ        4       /* Country string is 3 bytes + NUL */

This, however, is shown as explicitly %NUL terminated.

The old strncpy wasn't %NUL terminating wlc->pub->srom_ccode, though, so
the memcpy is the same result, but is that actually _correct_ here?

>  
>  	/*
>  	 * If no custom world domain is found in the SROM, use the
> @@ -354,10 +354,10 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(struct brcms_c_info *wlc)
>  	}
>  
>  	/* save default country for exiting 11d regulatory mode */
> -	strncpy(wlc->country_default, ccode, ccode_len);
> +	memcpy(wlc->country_default, ccode, ccode_len);
>  
>  	/* initialize autocountry_default to driver default */
> -	strncpy(wlc->autocountry_default, ccode, ccode_len);
> +	memcpy(wlc->autocountry_default, ccode, ccode_len);

struct brcms_c_info {
	...
        char country_default[BRCM_CNTRY_BUF_SZ];
        char autocountry_default[BRCM_CNTRY_BUF_SZ];

These are similar...

So, this change results in the same behavior, but is it right?

-Kees

-- 
Kees Cook
