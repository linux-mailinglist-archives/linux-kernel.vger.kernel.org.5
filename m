Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DE5755D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGQHrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGQHrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:47:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51534170B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:47:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 24DFC6603203;
        Mon, 17 Jul 2023 08:47:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689580029;
        bh=26aPzlNp986WPqG7Lr26YQExo7j+A8YekqKqBBz+4rU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eT/cA7mzOMzprdYTN7JPBq6J8JkCnQ3Md41jwehyo3Wox495OAwDew95SwshJvlqX
         p9vq+ZN62VFp0DzvvFkNZKf1NI/HXI9/fS3GLfygbbYvBL6w3WCcughXfuQEE7NRB9
         dHMmYOEbYUteeZiGKnbDxWsLU3OrF8obZcsRQkTpvwstAwu2DUjSAjq5Z8GSGBjIHJ
         tRWbyg3itBTj9UZzWWx6aMnDPVeIT4T9kBh/1ebUhV8w3z1duWjfrtRLKqF4NQ9VYN
         J1JWBzA7n5g5nBHDAm/srxjFLMnB+PyWk3hnKiVk+8hoA1UQgKafeoTzBzH9pdjpJt
         BySmsC1pm0C8g==
Message-ID: <1e84f0e3-8902-d55e-ed15-5c6476944656@collabora.com>
Date:   Mon, 17 Jul 2023 09:47:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/4] drm/mediatek: Fix unintentional integer overflow
 in multiplying different types
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230714094908.13087-1-jason-jh.lin@mediatek.com>
 <20230714094908.13087-4-jason-jh.lin@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230714094908.13087-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/07/23 11:49, Jason-JH.Lin ha scritto:
> 1. Instead of multiplying 2 variable of different types. Change to
> assign a value of one variable and then multiply the other variable.
> 
> 2. Add a int variable for multiplier calculation instead of calculating
> different types multiplier with dma_addr_t variable directly.
> 
> Fixes: 1a64a7aff8da ("drm/mediatek: Fix cursor plane no update")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

