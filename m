Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C987D877B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjJZRVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjJZRVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:21:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C26116
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:21:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1caa371dcd8so10305175ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698340901; x=1698945701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hw++taqiAXJcJaevbl9Amw4ktPoTvoXuDaFGZEL0LMc=;
        b=LeO0za5tAiUlysaCURGdKsibnH5is8GpLUJWX9TrDP38vZBjsz1tKYme3QUvMrucYa
         8Wt8r/aXcTEnUBrasmOVHmlTQONzCbYwbJPxJf7zogHaj66UbVz617xa8sebCCPn1wr9
         obd/zMrLKPcHFeqt/cu0zmv6pItofUuJNjT5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340901; x=1698945701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hw++taqiAXJcJaevbl9Amw4ktPoTvoXuDaFGZEL0LMc=;
        b=EPmKkKRPCF47vrh+xTXPil9sHFUdPbXiD5iJ1rwF+O3xdIdfKUsuDl672e1VebttGr
         +QYso7H0SB/vHLX7TJzlGhTp75LP8ukSJueR6Kqsxg0g1IXNqjfSt0/xlOO+9UNOzDm3
         SDL2nq+g+94AOvqgWeUXfsKfGXc3z4vie+TL33J52MkQXTp96Q15gfbgthY5H4+rNlRw
         XCZEcadWyE+vvtlxHzavqGs6CECJP46HfYHJrqTczcathMojN9Hs5TxxteWmM5bXRoWH
         yLxy3Rud2GappTetNTOrvrcXY1g+i4S9+ICZXcWXPC+38fQyeRJTSSok/lNHq/sr3JRp
         jF4g==
X-Gm-Message-State: AOJu0Yx8zrDjz8arTQ6LP8tDu0zJ4TTREynrRipNcpWRkqQ7uen02RjW
        gT36Rts4VW+Cdqo2f9mkkuCSjw==
X-Google-Smtp-Source: AGHT+IHLci2DTytmV/JdBaItNFV0GuBlIsEY5ALqpTGTgm1IFXlRUZZ0zzqUWLU33lMHFwbN6G/ZBQ==
X-Received: by 2002:a17:903:1ca:b0:1c9:d6f8:1902 with SMTP id e10-20020a17090301ca00b001c9d6f81902mr204408plh.15.1698340901297;
        Thu, 26 Oct 2023 10:21:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902704100b001c61921d4d2sm11241779plt.302.2023.10.26.10.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:21:40 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:21:40 -0700
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
Message-ID: <202310261021.B86F566@keescook>
References: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
 <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-2-af780d74ae38@google.com>
 <202310181654.E47A7709@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310181654.E47A7709@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 05:03:02PM -0700, Kees Cook wrote:
> On Tue, Oct 17, 2023 at 08:11:29PM +0000, Justin Stitt wrote:
> > Let's move away from using strncpy and instead use the more obvious
> > interface for this context.
> [...]
> So, this change results in the same behavior ...

I should have included my r-b tag:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
