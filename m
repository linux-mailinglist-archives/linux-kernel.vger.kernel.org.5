Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DD7811291
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379155AbjLMNNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjLMNNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:13:37 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7FB2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:13:40 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-425c54f5842so24985101cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702473219; x=1703078019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qo5R6yTzwaWH5LM+yEuRkuuzL/LOwLG4Rnp9GlOsN0=;
        b=nbXR0iWY60rcWdeTGupQ2mX4EmoMVHTu5yLrjncNaQD7vK9KHDqRulVzI9Yn/JZdRZ
         dtCsyK+AIxfNDkFU7YvHv0x7FJ+EqpbPJZVvVDRV2L3vVgnOMdMcd1FEdelDx8pRhWv7
         cQFuGAAH1AWMk02blZVThXX5CeMbZ9FqJaBhX4SV38Nla1a2qt040u/xIN06kwVfmeXG
         GAp9gXMkW/Q6qq4fbuCGz5quKub/9WTnYp1VkGQdxj7tvdOgrGgC7XxGcYkpcr91zIVz
         gHAXYdd7Rv47MWBSVkB2HnS6/h4SkdkzPGLfNTGRcTskWus+Xp4ERrdOYxBAnsFFXFKM
         VA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473219; x=1703078019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Qo5R6yTzwaWH5LM+yEuRkuuzL/LOwLG4Rnp9GlOsN0=;
        b=vzWO3tJDwC4ZHfNL1Svl2HYItH5s49IGB1ig03qkn6+va+/ZyyUV4VxtPw6po5UAXo
         CPlOUgiUTJKT1dAJ5SLD984w6IOBk37iO82AcjlvVOvPgBaxQ0MjBmuCVG9P9eKr6pGE
         x1p5C0WAHlzim3u2htak2Qj/ItR1DOeIga4DHzqkR2rBWTuWKn+ncrV4JYKgAbyVYP3T
         xZP+gn/fqc+veMGuK9xznAs+5mr8xBtv3evvsjhSlAjiWNnKGPHqSek5gvmrcUj60rOH
         1yzKoCxUyvXhMnnaXElW6ZCYa7UvvzFTvOfuexr9E6NPAxKAGw7rKRXd7JzkzkUvlCqs
         EckQ==
X-Gm-Message-State: AOJu0YwFshz0AiP+rG/RU9biPH2Xuzt0KTb9Kc2wWx4qxXxGe3SkL+Qv
        GSr3DXbBoXc5Wj9QvFVgUs+dLg==
X-Google-Smtp-Source: AGHT+IFiXyPVZqdJtAPBMBKl/zR7/AwrfluYAbKiw6zzrn8OLvxIyWqo3MQ7VLohJVWc7AW8Q3QsNA==
X-Received: by 2002:ac8:5909:0:b0:423:7d92:ddba with SMTP id 9-20020ac85909000000b004237d92ddbamr10443139qty.5.1702473219241;
        Wed, 13 Dec 2023 05:13:39 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id p18-20020ac84612000000b00423e77c96adsm4871616qtn.94.2023.12.13.05.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:13:38 -0800 (PST)
Date:   Wed, 13 Dec 2023 16:13:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     xueqin Luo <luoxueqin@kylinos.cn>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, xiongxin@kylinos.cn, wangqi@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RESEND PATCH-next] staging: rtl8723bs: replace deprecated
 strncpy with strscpy_pad
Message-ID: <f0abc689-a084-4c74-b5fe-3592eceb3399@suswa.mountain>
References: <20231213011840.10005-1-luoxueqin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213011840.10005-1-luoxueqin@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:18:40AM +0800, xueqin Luo wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We should NUL-pad as there are full struct copies happening in places:
> |	case NL80211_IFTYPE_MONITOR:
> |                ret = rtw_cfg80211_add_monitor_if(padapter,
> |						(char *)name, &ndev);
> |                break;
> 

I don't see where the full copy is...  What you're looking for is some
place that copies "mon_ndev->name" to the user.

> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees both NUL-termination and NUL-padding on the destination
> buffer.
> 
> Additionally, replace size macro `IFNAMSIZ` with sizeof():
> |	struct net_device {
> |		char			name[IFNAMSIZ];
> |		...

This would normally be the right move but IFNAMSIZ is a really standard
macro that everyone knows.

When I'm reviewing this code, I later on see a line:

	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ + 1);

That means name must be "IFNAMSIZ + 1" characters long or it is a bug.
Please find out where name is set.  We need to know how long it is
before we can go any further.

regards,
dan carpenter

