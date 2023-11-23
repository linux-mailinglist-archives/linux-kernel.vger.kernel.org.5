Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A87F6320
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbjKWPhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346206AbjKWPhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:37:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33A110FA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:37:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEA5C433C7;
        Thu, 23 Nov 2023 15:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700753861;
        bh=uQXiq96nO9VqagRTVjE4tsnRbIa5zMx/56VxvD4vqmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MNbX5XYoqyBOdgPdCyGzkWB4YkNNJx6Bb6oX+qx8Q66cZfm3KBHY+aafog/SV6IFL
         +rsfrj+JI8rU872TJebCWAvHnhKhkpFt92dlQlKtgkB6ulGXBgBmgNkte9YwWzYnWh
         6Wh/0gBvUrnet0wg1xSvGqMNlYpZ2NxE54kxpzMTpqx3hczB1PiNI3SsxxOdaa3rkn
         RpTmcDL98KGaLcTavywN1D6rp7FipD/6ygRWtUilwXJ3KMnl3c20hEVQjraOopyvY8
         9eD/yuTL8K+rqNLTS/xGb6pQiueDvG51NyX4i03cDGd7VfqQik9mczivvqVTV+vWvK
         maaAzVZrWWQxg==
MIME-Version: 1.0
Date:   Thu, 23 Nov 2023 16:37:36 +0100
From:   Michael Walle <mwalle@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v4 2/2] drm/mediatek: dpi/dsi: fix possible_crtcs
 calculation
In-Reply-To: <CAAOTY__LqKkj7Exg=wr0QUD-AQ_i3adXLUSdT2M_oYj7iCBAKQ@mail.gmail.com>
References: <20230905084922.3908121-1-mwalle@kernel.org>
 <20230905084922.3908121-2-mwalle@kernel.org>
 <93576c3b04c8378c5c9296ec7a6585d9@kernel.org>
 <CAAOTY__LqKkj7Exg=wr0QUD-AQ_i3adXLUSdT2M_oYj7iCBAKQ@mail.gmail.com>
Message-ID: <27e0368bb6dd44cd8d176c824cbfe464@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> > mtk_drm_find_possible_crtc_by_comp() assumed that the main path will
>> > always have the CRTC with id 0, the ext id 1 and the third id 2. This
>> > is only true if the paths are all available. But paths are optional
>> > (see
>> > also comment in mtk_drm_kms_init()), e.g. the main path might not be
>> > enabled or available at all. Then the CRTC IDs will shift one up, e.g.
>> > ext will be 0 and the third path will be 1.
>> >
>> > To fix that, dynamically calculate the IDs by the presence of the
>> > paths.
>> >
>> > While at it, make the return code a signed one and return -ENOENT if no
>> > path is found and handle the error in the callers.
>> >
>> > Fixes: 5aa8e7647676 ("drm/mediatek: dpi/dsi: Change the getting
>> > possible_crtc way")
>> > Suggested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> > Signed-off-by: Michael Walle <mwalle@kernel.org>
>> > Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> > Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> 
>> Is there anything wrong with these two patches? They are now lingering
>> around for more than two months.
>> 
>> Unfortunately, patch 2/2 won't apply anymore because of commit
>> 01389b324c97 ("drm/mediatek: Add connector dynamic selection
>> capability). And I'm a bit puzzled for what the crtc_id is used
>> there because I guess it will have the same problem this patch
>> fixes.
> 
> Please base on the latest kernel version to fix.

Of course, but the question is how to fix it. Maybe Jason-JH.Lin
can help here.

In any case, please pick patch 1/2, it's independent of the second
patch and should still apply.

-michael
