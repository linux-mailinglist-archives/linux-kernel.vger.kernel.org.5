Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191C97BE95B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378050AbjJIScA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377501AbjJISb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:31:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5728E1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:31:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-692ada71d79so3663339b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696876309; x=1697481109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxOk0Qe6UPn44OvxWZwPSW3rRJkqXORiJb9E5OphMiQ=;
        b=n/SIJ1/StnZQ/Sekobp/ZBP8e7mbHRPqgRKZcEuCrTTrDwpzYLkFBLVxBKWuo9R0EC
         nmlxQdeSuXKXMf9PYDxBCJlM31//nzfzLdLP5IE/W///X0nFvnaWWef9CHnIRrOODrxX
         nnpNJUEfL64aHETUZeDvMQ0Wbc0frAJdmckKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876309; x=1697481109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxOk0Qe6UPn44OvxWZwPSW3rRJkqXORiJb9E5OphMiQ=;
        b=RhFVWRayqyweKqanF5WhpyH8EUbr5mFEmUUgTkfmoxo5bEORQ+GSlobXPEG9VPVwoO
         C4la8KKCudTxT1gWdY44qes5wOic+uFhWbS/3n2XQsZQBnyN4ZoyXCUaWj31U8S5odmY
         XZqw3H9BSfFyDdZnJxT4fY6KgQWgjcns5EKWPRKdCmMK/uFO2mueaxvWXtDI3Fz62D/O
         n/QmTjipPjWSL2OnoRl0cIG9wUfQHdCqbo6k/tSTWYbzNXkK5m2N/k1t6tkv7YXwbDoF
         69qISOxBPbA+LWZKHdV14lnVo+EhB/TDT+wkvqwyiapQZudqWWI3NUPOFmRQoRRrZdYR
         6MJw==
X-Gm-Message-State: AOJu0YzU5ldPq4zg4/9HZZdfPNjLP8ufzMxU0T3SS26YNq2l+TnXvHom
        IC2drnCjTASBCm8v0DUDpoKP7w==
X-Google-Smtp-Source: AGHT+IGMYrmFaqpRwdTAW2MVusib1Bdp/eV2z4yNjbyFulBH77GpTBAsliVbiaNkBmPnFki9DWoAJw==
X-Received: by 2002:a05:6a20:3d29:b0:15d:7e2a:cc77 with SMTP id y41-20020a056a203d2900b0015d7e2acc77mr16427859pzi.48.1696876309199;
        Mon, 09 Oct 2023 11:31:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a25-20020a62e219000000b0068fe7e07190sm6653399pfi.3.2023.10.09.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:31:48 -0700 (PDT)
Date:   Mon, 9 Oct 2023 11:31:46 -0700
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
Message-ID: <202310091131.550C9CD8@keescook>
References: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:29:19PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/dsa/mt7530.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 035a34b50f31..e00126af8318 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -836,8 +836,7 @@ mt7530_get_strings(struct dsa_switch *ds, int port, u32 stringset,
>  		return;
>  
>  	for (i = 0; i < ARRAY_SIZE(mt7530_mib); i++)
> -		strncpy(data + i * ETH_GSTRING_LEN, mt7530_mib[i].name,
> -			ETH_GSTRING_LEN);
> +		ethtool_sprintf(&data, "%s", mt7530_mib[i].name);

Err, wait, I spoke too soon. Shouldn't this be "data" and not "&data"?

>  }
>  
>  static void
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231009-strncpy-drivers-net-dsa-mt7530-c-40cad383654d
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
