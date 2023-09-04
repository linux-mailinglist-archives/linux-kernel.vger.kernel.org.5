Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97B1791799
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbjIDMyg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 08:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjIDMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:54:35 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F2133;
        Mon,  4 Sep 2023 05:54:31 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso338401fac.0;
        Mon, 04 Sep 2023 05:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693832071; x=1694436871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeDHUCLwksnJPcwVXSrcFz8/yPLcYJaj8zr++E/gP4c=;
        b=Xg5P6oeZPYdSi3vIBu//yCaMk5fQcXO8xlPbDxb3Q8PNzND3JQdxgGzIPZ/S2gQifw
         sSvctrEwMS51jLbg7uHq+FoiRSopmpXO/SSixGSIdI6ENKILL017gqFImiwcYvAnt6SO
         JtzLcyNeWp2FgxScttEjBi02jIltvXMvBW7H/l4e/NuWhGNi0IHPTC3I9RUd6z+6KM3+
         JKjl4TcDA0GGi7l6tyXPyCnmBZcdpR2LCbY+GmEEv1G1+rlgcH4ul54v4Hn3wTWeQmdX
         L6ysefjQh+SA6/rLAP59CT8R/F69qGKvlE2sjJtEyeyZQ+lXQz1xsahJ5d1Wn9Syi/zG
         jveQ==
X-Gm-Message-State: AOJu0Yws3WevTNJjcDzGWc95oaJEnI19y2fEeG8x5qJQQ0LWQz2M6j2T
        Kymutk2ygGyjolSHRp3BUaL7ui3ri55O/fVy2/M=
X-Google-Smtp-Source: AGHT+IFL0Wes92lvn4wugsrLu1e14OHmDzZwUpp4y3nrxoKC1Won+ITU9A/qmWpffpatVTxJ15KO82DxnwQoazl6Hbk=
X-Received: by 2002:a4a:db8a:0:b0:573:4a72:6ec with SMTP id
 s10-20020a4adb8a000000b005734a7206ecmr8185159oou.1.1693832070712; Mon, 04 Sep
 2023 05:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <1870450.tdWV9SEqCh@kreacher> <8272147.T7Z3S40VBb@kreacher> <20230831085838.2e3b99cd@xps-13>
In-Reply-To: <20230831085838.2e3b99cd@xps-13>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Sep 2023 14:54:19 +0200
Message-ID: <CAJZ5v0hc0Of4vHY3Gdz6ifSWA1DSg3_-SVc-KpXhYRwOBvHZPQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] thermal: Use thermal_tripless_zone_device_register()
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 8:58 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> rjw@rjwysocki.net wrote on Wed, 30 Aug 2023 18:14:57 +0200:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > All of the remaining callers of thermal_zone_device_register()
> > can use thermal_tripless_zone_device_register(), so make them
> > do so in order to allow the former to be dropped.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> >  drivers/thermal/armada_thermal.c                        |    5 +++--
>
> For armada:
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thank you!
