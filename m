Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D16D7BEA2D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378056AbjJIS4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjJIS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:56:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C570A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:56:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-692eed30152so3549411b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696877796; x=1697482596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MsTR/cGryQq7rM7HxcuS1zRjm3nltuO+eDU9+kch7k=;
        b=QoVQcJR/1pcjpu45m1k4UZu/cDfvLCeUm4NHZ8etsBRlON2NUCosa4RTj2TvrcAscN
         SNhO0CvK+kvlg0gOfa7t1ZpW6JipZk3mj/hl8jU+0Hj04AxzUG/eWgGI+PSdr+BZirY4
         ANfFuGTt7etyT1BSiYt6vCarGiZns4AcIU2N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877796; x=1697482596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MsTR/cGryQq7rM7HxcuS1zRjm3nltuO+eDU9+kch7k=;
        b=Jj3lV9CTGvIpEwyKXeTTEhdMTAc81CrCHd9i7+j5TPewb60qvODvDV2+NLbMc2kint
         PhiSP0WQvtSXcAtsKqJwD1pzDYfMEyorvrwI/VLKgh1JYlpg0HtY/xNH/p8w3nPP5eFK
         Qf0p85/stNQo4S6M7SVUFGXVDcVNAWPD6RxqtgoGIzPzxWppPIQoDDdF15keWTkluXHo
         wHQxlzwYr3GqfY/WrjRB6wGmfyYUJJ3hZeMYuvS9uRXe9L6P72xkJHFea3lMgTNipBAw
         D4gJC/nz+jN3iiMKzSskty3XLCb5OZEEQA+smcGJ29M+PC1C/i+Hjfni6gdKYEiGFDT5
         1LbQ==
X-Gm-Message-State: AOJu0Yx09VhOZ8rLAONGsx2LshARwg1w087YnAqg3ei2u5FznjT48q3F
        mU0AF4Wb5e84C7vJ4ClyjwCwfQ==
X-Google-Smtp-Source: AGHT+IFqDuEFo+tIspVB6znFMkQC780hS1yhuBuvVg/TNH3PNioqeOxCygG+fs+D639q6fNE6/nUDA==
X-Received: by 2002:a05:6a00:2450:b0:693:4108:1eb7 with SMTP id d16-20020a056a00245000b0069341081eb7mr15271604pfj.30.1696877795997;
        Mon, 09 Oct 2023 11:56:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ey5-20020a056a0038c500b0068fe9c7b199sm6820919pfb.105.2023.10.09.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:56:35 -0700 (PDT)
Date:   Mon, 9 Oct 2023 11:56:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mt7530: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310091155.3E4328DC1B@keescook>
References: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
 <202310091131.550C9CD8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310091131.550C9CD8@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 11:31:46AM -0700, Kees Cook wrote:
> On Mon, Oct 09, 2023 at 06:29:19PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> > 
> > ethtool_sprintf() is designed specifically for get_strings() usage.
> > Let's replace strncpy in favor of this more robust and easier to
> > understand interface.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/net/dsa/mt7530.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> > index 035a34b50f31..e00126af8318 100644
> > --- a/drivers/net/dsa/mt7530.c
> > +++ b/drivers/net/dsa/mt7530.c
> > @@ -836,8 +836,7 @@ mt7530_get_strings(struct dsa_switch *ds, int port, u32 stringset,
> >  		return;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(mt7530_mib); i++)
> > -		strncpy(data + i * ETH_GSTRING_LEN, mt7530_mib[i].name,
> > -			ETH_GSTRING_LEN);
> > +		ethtool_sprintf(&data, "%s", mt7530_mib[i].name);
> 
> Err, wait, I spoke too soon. Shouldn't this be "data" and not "&data"?

Ugh, ignore me. I keep forgetting that ethtool_sprintf() updates the
"data" pointer. My original Reviewed-by is fine. :)

-Kees

-- 
Kees Cook
