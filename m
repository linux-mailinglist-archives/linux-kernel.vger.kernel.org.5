Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E357D2F63
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjJWKB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjJWJua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:50:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A16AD6B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:50:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BAC4D6606F51;
        Mon, 23 Oct 2023 10:50:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698054625;
        bh=jGS4wjjKQT+jnkpy/yvPYn70Z9+yx4rAHIJ/2NeAlz4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Aqh47hyd/S0BF0/zcRu4GCSeAePAoEpctZeh9g60YdqSt63KwdcI0vNUEtGmjzazQ
         oIBC4wFm4988DN9q9cf8o5ml5uVfkS1ygKLhO1Rti2q7UkCIF896zt7Attj6dwsdaG
         eS9QE6BFDNKFczC5BD0sXUq7IWeC/ikLLnZtRQWURAjN889N73j8DYNGKctgKA/HTY
         6RAvQMtlO3quQWOcCoGG0IwTwaGMN6xtsAtycrDHotzUxV8k3h588A9159nzBWLya1
         LiNRRRK8YkzgVgrYbNnB2NGw+eL3dTsXWr4Q94FNwu8cqDzqgLzm8SB/q+rH6bvlmG
         q5uPF/OWocVsw==
Message-ID: <e7668af8-f2b4-479b-80a3-2677d180e641@collabora.com>
Date:   Mon, 23 Oct 2023 11:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] soc: mailbox: Add cmdq_pkt_finalize_loop to
 support looping cmd with irq
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
 <20231023043751.17114-6-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231023043751.17114-6-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/10/23 06:37, Jason-JH.Lin ha scritto:
> Add cmdq_pkt_finalize_loop to CMDQ driver.
> 
> cmdq_pkt_finalize_loop appends end of command(EOC) instruction and
> jump to start of command buffer instruction to make the command
> buffer loopable.
> 
> GCE irq occurs when GCE executes to the EOC instruction.
> CMDQ client can use a loop flag to mark the CMDQ packet as looping
> packet. If the CMDQ packet is a loopping packet, GCE irq handler
> won't delete the CMDQ task and disable the GCE thread.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c       | 11 +++++++++++
>   drivers/soc/mediatek/mtk-cmdq-helper.c   | 23 +++++++++++++++++++++++
>   include/linux/mailbox/mtk-cmdq-mailbox.h |  1 +
>   include/linux/soc/mediatek/mtk-cmdq.h    |  8 ++++++++
>   4 files changed, 43 insertions(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 4d62b07c1411..56fe01cd9731 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c

It's true that without the changes in soc/mediatek this is not doing anything, but
mailbox/mtk-cmdq-mailbox.c goes through a different maintainer...

Please split the changes to drivers/mailbox/mtk-cmdq-mailbox.c and its header to a
different commit.

Hint:
1. soc: mediatek: cmdq: Add cmdq_pkt_finalize_loop for looping cmd with irq
2. mailbox: mtk-cmdq: Support GCE loop packets in interrupt handler

Thanks,
Angelo

