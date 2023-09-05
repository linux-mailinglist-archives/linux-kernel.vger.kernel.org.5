Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A720792578
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348977AbjIEQSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353764AbjIEH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:58:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB98CCCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53848CE1084
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81992C433C8;
        Tue,  5 Sep 2023 07:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693900729;
        bh=Dnlu1SDu2v2QnFOKA53mp8v1htY/lKtNTEha/hvocxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BsAmLrNAK3vRW/Ymrt8hnLJqZhHBqtc+z93aKmix89cbGbhO2h2ccpOS4/emu37Cm
         qZ+cQ1oNKl378LvaB9nSaSmHygFW1LhtwTaYl0ydUbXhifhmuQiUVSJR28StLntCxv
         qXB92+lnyhBs4cNDyi6aUVcHKJq4qDPK28NvR7GyfZ2+9rHjVXdxWW/srzQMqfWB2u
         F/QpNxnAGoYouTTd9HyrWrxWrcDW8A7QqArEMDyudwVNB9vu8ILYYIIwQovFT/zcai
         vRq5UGfIkVUDpxpL7p1Jkm1ESvxYR1epeYhWTQ3opxRexM98a1st/YvMkEAHrpyM6H
         DveQ0u/e2HqQg==
MIME-Version: 1.0
Date:   Tue, 05 Sep 2023 09:58:44 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
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
Subject: Re: [PATCH v3 2/2] drm/mediatek: dpi/dsi: fix possible_crtcs
 calculation
In-Reply-To: <d7e6917d-7315-12d6-d7d4-dc7ea8c58dc9@collabora.com>
References: <20230901174557.3617839-1-mwalle@kernel.org>
 <20230901174557.3617839-2-mwalle@kernel.org>
 <d7e6917d-7315-12d6-d7d4-dc7ea8c58dc9@collabora.com>
Message-ID: <cf7d01700f5e5adf2f28b0376451143b@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> At this point, I think that it would be sane to change this function to
> return a signed type, so that we can return -ENOENT if we couldn't find
> any DDP path (so, if we couldn't find any possible crtc).

Fair enough, but should it be part of the fixes commit or a different 
one?

-michael
