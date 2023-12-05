Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F328056D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345641AbjLEOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345612AbjLEOJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:09:37 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B019B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:09:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c0e7b8a9bso22131005e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701785382; x=1702390182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OetAMAddY0Kvgc03SJD9zPupbx1ViU/NeH7cMTkTAv4=;
        b=l5T9Nfv3iRwkKCx4KyQSelsHvaWPsBV5tTsZVSZ3kQKn7/Fk9IGfELxNSrCilcvYHU
         vDNdZSZNnZyAnmb2xSQG8AnkXvJzeDRidkuIrZAfyMDY6uGrad0mdGGW0fBRMFdN7DAk
         aYBQJBM3ZLsbzSE4Lhzak9ocWKT6xrYCldt2Q01EW7iyhjK2iylxzeB3Mp7Qi/um7Mgy
         y+OuNuA8yKNjUX/z3N1fcW3R3lySN/q0iEUyEV0F4tFoc+nNyiOPDFkR9BV2IsY/IOY8
         d3HldDjv2q+zLwEDwqY5RE0bckR4/amoNpvOwskmd36wXrqOSifbl3u5q1eW/DPKCb4T
         OSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701785382; x=1702390182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OetAMAddY0Kvgc03SJD9zPupbx1ViU/NeH7cMTkTAv4=;
        b=pABBzeidsJTkxaXdTDH9czgqeh0srweQBBTLa16kNefQPosfNQ82Vh2xVJT8FAL52x
         vWkh5VM+4W18gSVWmjf+oRiuiCpW8Pm5Dcr39qHIvCg7YynERPdVaKVBHopRtmpizSJL
         2acaI3JGiPcWR5377416IL/+QXvRSCja9GHZgrXXcXnmJ/1WNJyndRMxHIMl56VLPmC8
         fXHGQJBinqLIUatrzRZEZFpW3lPP7xnlZDnAdkOHL3ycuOPSapM23sVnmZhucdwc+U5Y
         mY51UzJKHarfKKNj5IIfSbj1beg+msF07V9RsKb7rFz3ecz9fNhED3BTM7DRg+C9M1rY
         3Kog==
X-Gm-Message-State: AOJu0YzkqJIW6lTIgL1r6nIUp3vVwZkB8ZvbJ4amNg1Wzf+QLxkUcSpi
        dhTnGfT5SHMoFIaodBeMS/s+CA==
X-Google-Smtp-Source: AGHT+IGjE7ABuNASpckDLdyxi0klki+3P/24IvfmCPYHlYSCTyShLyBe1GZt2tZF8GFux4EJenGyWA==
X-Received: by 2002:a05:600c:1c22:b0:40b:5e21:dd15 with SMTP id j34-20020a05600c1c2200b0040b5e21dd15mr569098wms.67.1701785381922;
        Tue, 05 Dec 2023 06:09:41 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t19-20020a05600c451300b0040a3f9862e3sm632489wmo.1.2023.12.05.06.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:09:41 -0800 (PST)
Date:   Tue, 5 Dec 2023 17:09:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Robert Foss <rfoss@kernel.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        kernel-janitors@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH] drm/bridge: nxp-ptn3460: fix i2c_master_send() error
 checking
Message-ID: <dfb64765-4b3b-4ef6-ad98-596f0d64f0ba@suswa.mountain>
References: <0cdc2dce-ca89-451a-9774-1482ab2f4762@moroto.mountain>
 <170178410677.683894.16036596185582079991.b4-ty@kernel.org>
 <a10a75c7-0626-454f-a3c4-d6031713f26f@suswa.mountain>
 <CAN6tsi6c7ncaiRAiAvrs_GoUMB8v9ciaMvu7s7hnPA0KN0xkWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN6tsi6c7ncaiRAiAvrs_GoUMB8v9ciaMvu7s7hnPA0KN0xkWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:04:49PM +0100, Robert Foss wrote:
> On Tue, Dec 5, 2023, 15:01 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > On Tue, Dec 05, 2023 at 02:48:26PM +0100, Robert Foss wrote:
> > > On Mon, 4 Dec 2023 15:29:00 +0300, Dan Carpenter wrote:
> > > > The i2c_master_send/recv() functions return negative error codes or the
> > > > number of bytes that were able to be sent/received.  This code has
> > > > two problems.  1)  Instead of checking if all the bytes were sent or
> > > > received, it checks that at least one byte was sent or received.
> > > > 2) If there was a partial send/receive then we should return a negative
> > > > error code but this code returns success.
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/1] drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking
> > >       https://cgit.freedesktop.org/drm/drm-misc/commit/?id=914437992876
> > >
> >
> > Wait.  That was unexpected.  Neil's review comments were correct.  I was
> > planning to send a v2 patch which was just a cleanup.
> >
> 
> Sorry Dan, I was too quick on the draw. Can you send a fixup and I'll apply
> it too?
> 

Sure.  I will do that.

regards,
dan carpenter

