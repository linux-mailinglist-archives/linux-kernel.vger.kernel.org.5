Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CD577A063
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjHLOSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjHLOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:18:06 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789611FE1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=sKoqonJGkns3oYuhs1epSxG/U3/42aecgJBwpTG/v1Q=;
        b=bcKPGgC5JrECh2FEnvBi2x/UEzcKjhulx/KajpUjSnOiBw9MkSpzf4fkTD/xuXlRAP98
        aiyiGyqZa5Pc+y0SMEyQfOH+mzLlcigTIaXBonfjtk58SCEBRFkaqtK2tDAZaOKEvu4+fy
        UDeAfcSPbk3FrkJX8K3Yx0pr9HdejSd2AKrRn3Tz0ljIcNOADOrjgi19z9gRmMmYTHsNqj
        0vnmrq3Nh7oiUsS6R2iScv3NVbP3R1TAxSdlBw9fq4weRBvrcHAAxAPM6H5CcrxiRiT2UY
        5OLEYeaXs0S1RBarnNrIxdrPN05hoC3Odssxl21eoGGaQBSJkhhUzwGRnJrMk3ng==
Received: by filterdrecv-d7bbbc8bf-zf9x9 with SMTP id filterdrecv-d7bbbc8bf-zf9x9-1-64D7949D-11
        2023-08-12 14:18:05.386703198 +0000 UTC m=+8087893.184532908
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-3 (SG) with ESMTP
        id hCXh1dcGQruO7UNzEa6gzQ
        Sat, 12 Aug 2023 14:18:05.084 +0000 (UTC)
Message-ID: <17046b61-5188-28e3-41fc-dad36d76584f@kwiboo.se>
Date:   Sat, 12 Aug 2023 14:18:05 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/5] drm/rockchip: Fix crtc duplicate state and crtc
 reset funcs
Content-Language: en-US
References: <20230621223311.2239547-1-jonas@kwiboo.se>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230621223311.2239547-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hxUPmSkTscY2RCWIM?=
 =?us-ascii?Q?IReNLsbfMOphAa+9BFIZRWhyTq4tTnSSc4sCX6L?=
 =?us-ascii?Q?57Piv7leXKg2FML=2FUhTgWYOQY5MG4y9hgwX9HRI?=
 =?us-ascii?Q?aHgYXZmRq++hCZBIBMno7ehFGoXsIgDLIfCBqrP?=
 =?us-ascii?Q?EfY7hyEbe2OlFtRpD48xsdure+fzJfA5U4072t?=
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Mark Yao <markyao0591@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Please consider reviewing and merging this series [2], and also [3].

drm/rockchip: Fix crtc duplicate state and crtc reset funcs
[2] https://lore.kernel.org/all/20230621223311.2239547-1-jonas@kwiboo.se/

drm/rockchip: vop: Add NV15, NV20 and NV30 support
[3] https://lore.kernel.org/all/20230618220122.3911297-1-jonas@kwiboo.se/

Regards,
Jonas

On 2023-06-22 00:33, Jonas Karlman wrote:
> This series fixes a reset of state in duplicate state crtc funcs for VOP
> driver, a possible crash and ensure crtc reset helper is called in VOP2
> driver.
> 
> Patch 1 use kmemdup instead of kzalloc to duplicate the crtc state.
> Patch 2 change to use crtc and plane cleanup helpers directly.
> Patch 3 adds a null guard for allocation failure.
> Patch 4 adds a crash guard for empty crtc state.
> Patch 5 adds a missing call to crtc reset helper.
> 
> This is the next part of an ongoing effort to upstream HDMI 2.0 support
> used in LibreELEC for the past 3+ years.
> 
> Changes in v2:
> - Handle possible allocation failure in crtc reset funcs
> - Collect r-b tags
> 
> This series is also available at [1].
> 
> [1] https://github.com/Kwiboo/linux-rockchip/commits/next-20230621-duplicate-state
> 
> Jonas Karlman (5):
>   drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs
>   drm/rockchip: vop: Use cleanup helper directly as destroy funcs
>   drm/rockchip: vop: Fix call to crtc reset helper
>   drm/rockchip: vop2: Don't crash for invalid duplicate_state
>   drm/rockchip: vop2: Add missing call to crtc reset helper
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c  | 24 +++++-------
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 39 ++++++++++----------
>  2 files changed, 28 insertions(+), 35 deletions(-)
> 

