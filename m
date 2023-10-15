Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95ED7C97AD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 04:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjJOCg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 22:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJOCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 22:36:56 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B41CC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 19:36:54 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57b68556d6dso1842053eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697337414; x=1697942214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VU2x4r2C1Cg+Ar4cIjbSuCvHfJH/2aoAhlJs5r56OOM=;
        b=JyaUD53GYUBMrimAlpH81aFRJHFPeeoC7UCiOPQiiwcj43ZW0DnuLNd4C8NM1jEE7w
         BlLzGvi+6si8Wzf3Ksfce61ykygIcAAg6b230hYUhEma9hqIAmwwxdYE2sYn04n5tC62
         KMSe2LtLMeDKfMA+ZXomL9Ng9JVjLOgBcdWv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697337414; x=1697942214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU2x4r2C1Cg+Ar4cIjbSuCvHfJH/2aoAhlJs5r56OOM=;
        b=Grr5uQ2V89TS9c8EnwBb5uWRVqiNYOKXXUtgYG5JRPgzOET40FZ4Ad6zAa4EHRDbCd
         YiDSSDNSibGq8dgOpDisukpcJ00vJnY6d1uo4IRhAUH4fXAn/7i7affEsF6vT8J777Lr
         l8oIUjhkBGwDVBeaSM+gV198JW+tDyae/bkzySWU5BpXY6ckGVshIhyLZtQjcNQtnafZ
         5bmh215AARZWdXwqGENC7q6UiGLM7S1jmuibsF3MCNIdyDsDsEqFzHwy/JUExi2fgGqn
         cZViA4iJF95l+SLPkkAjSdplEY/wwOfsQL/7l1jit/sYZYl/KYFC0NlH4KSyeNysd9Wo
         7oSw==
X-Gm-Message-State: AOJu0Yx/VChslUjz7KkVCZF/rcswhccfg1c2DY0kRKbgpttnR7mOnfjC
        KpkmjES5F9KagZyCXeAWfGTI8Q==
X-Google-Smtp-Source: AGHT+IHClQo+ghAM+7G8NtI+1Ce3WoRKJIKQToAT9aiTv3CxelXG6k00DC30no3I3lgVgPNYZ5q6YQ==
X-Received: by 2002:a05:6358:702:b0:143:9bc0:a975 with SMTP id e2-20020a056358070200b001439bc0a975mr29192932rwj.7.1697337413969;
        Sat, 14 Oct 2023 19:36:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z9-20020aa785c9000000b006926e3dc2besm15684432pfn.108.2023.10.14.19.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 19:36:53 -0700 (PDT)
Date:   Sat, 14 Oct 2023 19:36:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Justin Stitt <justinstitt@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310141935.B326C9E@keescook>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
 <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
 <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
 <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
 <202310131630.5E435AD@keescook>
 <a958d35e-98b6-4a95-b505-776482d1150c@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a958d35e-98b6-4a95-b505-776482d1150c@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 03:55:41AM +0200, Andrew Lunn wrote:
> > I've been told that this whole ethtool API area is considered
> > deprecated. If that holds, then I don't think it's worth adding new
> > helpers to support it when ethtool_sprintf() is sufficient.
> 
> I think deprecated is too strong. The current API is not great, so
> maybe with time a new API will emerge. But given there are around 160
> users of the API, probably over 100 drivers, it will be 20 years or
> more before all that hardware becomes obsolete and the drivers are
> removed.
> 
> > Once you're done with the strncpy->ethtool_sprintf conversions I think
> > it would be nice to have a single patch that fixes all of these
> > "%s"-less instances to use "%s". (Doing per-driver fixes for that case
> > seems just overly painful.)
> 
> I guess it is the same amount of effort to replace them with
> ethtool_puts()?

Yup, right. If adding ethtool_puts() makes sense, then I totally agree.

-- 
Kees Cook
