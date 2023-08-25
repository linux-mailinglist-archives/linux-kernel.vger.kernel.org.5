Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105D4789285
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjHYXyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjHYXyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:54:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2CC2680
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:54:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdbbede5d4so12261975ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693007678; x=1693612478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VpMaAc/+rHUYpU/kaviuY/CqhSZVdXyXfaFB/RaptSE=;
        b=mCfvTqg8FBDz1xZGzDewFoKOiGUsFkij77b1+ZGW6euJFr+oubteZ+icOhhVMzvRze
         AnYBs6QzAOIhI6Hv3Fo3C5ZRs0RDbHFH2O3Fr4o7W0AicrUo0f6gvJJ91snHrvLWYJ0T
         3duJox9k0dAnldDQBXSw38k54/oXQaTvFY7ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693007678; x=1693612478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpMaAc/+rHUYpU/kaviuY/CqhSZVdXyXfaFB/RaptSE=;
        b=i5LQ1l0NS5n7Bl4vCSrrupDk5cfwHXmOZZBjweEzfGM+ZQAyv+ouSyHsSCtDN8peRW
         GCMMxt+isOEa74lSY5i4coGGS6cZaSuwM1XgENWhkjqON0+kzxOEolC63EKoFU1R7YEP
         y2PVLJGJ0Wju1f37hT8qIqV6ew9160wh1KIBn48ARSRFGwAgKxVpe1GcYByxeTqhRjYK
         XLmtLM1t3+LrnbBo+OeYUYu4TsZByT3Qcy5gP5g1GCRxzW598dvZdOBTpd8kGYIVbu8x
         O+N41bz2OMZh9gf3NFdhxmw4zvT4FfGg4u/3LI3wZs/WUFcq5Ln0DcwLeGiQm/wl2PEA
         aiEA==
X-Gm-Message-State: AOJu0YyWbuu0nQHb7eUm3nts+UgL6ls2T6ED92kJsjB0nb0XlOnxNMTX
        3u0JIFls1zH2wgOsFWYnVYQrK20ShM7lUyCAJ0g=
X-Google-Smtp-Source: AGHT+IFEuZ99MPLIDqpxwG1Vt4boeH8jtHmkm9WzqpyWAxYtGeHG9/wvuJT+nhNSmfJ03PfN2NFqmQ==
X-Received: by 2002:a17:902:8bc4:b0:1b8:36a8:faf9 with SMTP id r4-20020a1709028bc400b001b836a8faf9mr19617146plo.38.1693007678180;
        Fri, 25 Aug 2023 16:54:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jk13-20020a170903330d00b001b881a8251bsm2345723plb.106.2023.08.25.16.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 16:54:37 -0700 (PDT)
Date:   Fri, 25 Aug 2023 16:54:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] wifi: mwifiex: Sanity check tlv_len and
 tlv_bitmap_len
Message-ID: <202308251653.72F1ADC417@keescook>
References: <cover.1692931954.git.gustavoars@kernel.org>
 <d4f8780527d551552ee96f17a0229e02e1c200d1.1692931954.git.gustavoars@kernel.org>
 <202308251410.8DAA6AC5E@keescook>
 <CA+ASDXNxYZsxFcF2iiKidBr4znsS5ejjmQKU_pdNpsrAqyeXEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ASDXNxYZsxFcF2iiKidBr4znsS5ejjmQKU_pdNpsrAqyeXEg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 04:38:56PM -0700, Brian Norris wrote:
> On Fri, Aug 25, 2023 at 2:10 PM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Aug 24, 2023 at 09:10:45PM -0600, Gustavo A. R. Silva wrote:
> > > +                     mwifiex_dbg(priv->adapter, WARN,
> > > +                                 "TLV size (%zu) overflows event_buf buf_left=%d\n",
> > > +                                 size_add(sizeof(tlv_rxba->header), tlv_len),
> > > +                                 tlv_buf_left);
> >
> > With the suggested change to make this a warning and not dbg:
> 
> mwifiex_dbg(..., WARN, ...) *is* a warning, not a debug message. Or at
> least, that's how it's used throughout this driver, even though it
> actually yields a dev_info()-level message, regardless of the 'mask'
> arg:

Oh duh. My eyes didn't get any further than "dbg". My bad! Yes, this is
good as-is. :) Sorry for the noise!

-Kees

-- 
Kees Cook
