Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7807928CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347308AbjIEQYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353772AbjIEIDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:03:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E74CCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:03:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D307B660716C;
        Tue,  5 Sep 2023 09:03:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693900993;
        bh=ds0zLIqF4zHaiOeC7HqV5SxOUmkM7LOq32FcWWfWQTs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AlDblQi667rjIYA6FJV2mzSgLg+4xrfRl1ZNuOnlnIS4zfpfViTzPyJvRSQwrkcVu
         zjlXSX5c3Ep80HnoFh0XR2zyq3Fj/bgMrku2VemIW4I1cupd+pIj61I4auP98ZEAIS
         lt4XRE6EumQd960xed2+Kuupa6ikuZxYJH1XGefi4lmvqjK4C676/r1O+R4INI0FWy
         ltTrVNQsIFT2tpUnMwMwP4almUZMiJmSdezilqRASQW6xBTxDOfWtibrUU3MCC4eaY
         qVRhdzz13X/+QMWhGrNENeHsX2l6+KlumYlva5eWuiJM+Sd+DYqLtrQ2wIj+jQ9Zvi
         8l+GFdMdNs1mA==
Message-ID: <02380e49-7848-c968-ef6a-bc64d87d6228@collabora.com>
Date:   Tue, 5 Sep 2023 10:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] drm/mediatek: dpi/dsi: fix possible_crtcs
 calculation
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230901174557.3617839-1-mwalle@kernel.org>
 <20230901174557.3617839-2-mwalle@kernel.org>
 <d7e6917d-7315-12d6-d7d4-dc7ea8c58dc9@collabora.com>
 <cf7d01700f5e5adf2f28b0376451143b@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <cf7d01700f5e5adf2f28b0376451143b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/09/23 09:58, Michael Walle ha scritto:
>> At this point, I think that it would be sane to change this function to
>> return a signed type, so that we can return -ENOENT if we couldn't find
>> any DDP path (so, if we couldn't find any possible crtc).
> 
> Fair enough, but should it be part of the fixes commit or a different one?
> 
> -michael

I would say that this should be part of the Fixes commit: after all, you're
fixing a case in which the possible_crtcs calculation *may fail*, so the
error handling for this possible failure is, indeed, one part of the fix :-)

Angelo
