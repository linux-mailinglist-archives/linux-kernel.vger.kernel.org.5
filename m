Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D48005CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377842AbjLAIhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAIhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:37:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9283196
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:37:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381EAC433C8;
        Fri,  1 Dec 2023 08:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701419862;
        bh=q6uyK3KduoHE8Rp2A1HWjw0i+9QdOkbCcHpv3VuzKnY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=s4GxHUbAKKrXLvZe3ST3qpBvL3RTor6PdTIMHw9UOwvaSIu9tECHqjjclSIEYSNkg
         7MVAtaMtUsUGDWyPw7vr0bEwQlaT1z+tF/P8xClmd409WFNKm64kyVM8xRLCqLFNg2
         zgPWLcNExCoXIpNdnfLMFcEOQNhIUxjn6RyzPbzWWrEIsRnQrT1JN/ADcKHFsVlMvk
         JvC1YSxJIfgBriYyHhFRa5atIeJ8QEtt0pzR58PS7hLDucW/jYbEcDPy7Yy+VXDKCl
         QpiPULE0NW6ARKPvk3RB0tFxVUON8WS1RFuSgpCrbYTVuM7sRUJ5Y13JMKGQ92/+d4
         gw9nNwnn4KjQQ==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>
Cc:     matt.coster@imgtec.com, frank.binns@imgtec.com,
        boris.brezillon@collabora.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20231130160017.259902-1-donald.robson@imgtec.com>
References: <20231130160017.259902-1-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH v2 1/5] drm/imagination: Fixed warning due to
 implicit cast to bool
Message-Id: <170141985986.3198881.16310139541433130875.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 09:37:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 16:00:13 +0000, Donald Robson wrote:
> This line appears to confuse the compiler and had been noticed previously in
> clang-tidy output. There isn't anything fundamentally wrong that I can see.
> I suspect that it just looks like a mistake - hence the first note.  By making
> the second operand an actual bool result, const correctness can be preserved
> while silencing the warning.
> 
> >> drivers/gpu/drm/imagination/pvr_device_info.c:230:47: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
>      230 |         } else if (features_size == mapping_max_size && (mapping_max & 63)) {
>          |                                                      ^  ~~~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/imagination/pvr_device_info.c:230:47: note: use '&' for a bitwise operation
>      230 |         } else if (features_size == mapping_max_size && (mapping_max & 63)) {
>          |                                                      ^~
>          |                                                      &
>    drivers/gpu/drm/imagination/pvr_device_info.c:230:47: note: remove constant to silence this warning
>      230 |         } else if (features_size == mapping_max_size && (mapping_max & 63)) {
>          |                                                     ~^~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

