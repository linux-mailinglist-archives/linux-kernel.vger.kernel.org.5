Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808C0806BBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377653AbjLFKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377607AbjLFKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:19:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E92FA;
        Wed,  6 Dec 2023 02:19:37 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB2EF660732A;
        Wed,  6 Dec 2023 10:19:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701857975;
        bh=UIy6Wcqp5kGevxZ+Hlaa9ohz+boVqoC9hBiFx+0skE8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LZw1QPHbwHNH02hOUzhaAEEcCznJHI2Kccpc0j+0vxUhqn2EB2YTd5Jbjhk6mVg9Z
         gAXkyxL9euyUl4jiueoQqpvhXTEJW3uzC0hF+G4lj8WUB5IXpo1U0KBdU1plfLfbvr
         jTvzqJboeY/EywwNiPMFg0dzYZ4XNlOkJmOfQFbHXPQ+49OX+4ikX4osHH47lKtNF+
         9nCGDSAfLobENWjskTqJTsnIuD/9F4Tt7Q2DjMimyz2vegEhvg5rGm5vyuDd7Zp0JP
         MzjL/nijM5NUkgrogipZ8BvrKAl3Fkbu+Zpm1YBq+bTln+/TT6b1U+vCd/B9BcsxoT
         qYWzxupVCjIMA==
Message-ID: <6c693161-0e89-4f9d-9a92-18f3783eefd2@collabora.com>
Date:   Wed, 6 Dec 2023 11:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] media: mediatek: vcodec: Fix mtk_vcodec_mem_free()
 error log criteria
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231113123049.4117280-1-fshao@chromium.org>
 <20231113123049.4117280-4-fshao@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231113123049.4117280-4-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/11/23 13:26, Fei Shao ha scritto:
> mtk_vcodec_mem_free() shouldn't print error if the target DMA buffer has
> never been allocated or was freed properly in the previous call. That
> makes log confusing.
> 
> Update the error path to print log only when the caller attempts to free
> nonzero-size buffer with VA being NULL, which indicates something indeed
> went wrong.
> 
> This brings another benefit that the callers no more need to check
> mem->va explicitly to avoid the error, which can make the code more
> compact and neat.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

I think that this error is supposed to catch two issues in one:
  - We're called to free no memory (something that does make no sense),
    this may happen for example when calling xxx_free() twice, and it
    is a mistake that *must* be fixed;
  - We're failing to free memory for real (which you covered)

....that said, I think that if you want to clarify the error messages
in this function, it should look something like this:

if (!mem->va) {
	mtk_v4l2_err(plat_dev, "%s: Tried to free a NULL VA", __func__);
	if (mem->size)
		mtk_v4l2_err(plat_dev, "Failed to free %lu bytes", mem->size);
	return;
}

Cheers,
Angelo

