Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF2E7BA01E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjJEOda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjJEObd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5984526A58;
        Thu,  5 Oct 2023 05:41:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 958D36607327;
        Thu,  5 Oct 2023 13:41:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696509685;
        bh=NDq8WhFGsx/jhQOnfQkcqwGfnnhxjb66WolDxgBm/Cg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZXDNWhQQjc2aW+VD/brEY8/3/5zNdPZtYXEPmR0nAg2qLqrvv29J7eqCT0wxtBhun
         Nk2KTwvn6kh6VGbb3AnP/hZjgd9U1pfdX5WeLzdhiaO9VbeXAUXwyYjPtdK5J4C7NR
         NR3xON5fYD+iIsP6hhjuy6hV3MgsTXeIFCpC6nfhQauhvK7vZsV/JjQoh5UVhTJlz8
         EWk6gORts3D/ERtCsICChtTfMxhQalWnLqPBbau5MuX4StPr2/sXRNp5L4dYhZe9+W
         8q9RqrQN4gbY0d4fz6yzT5A+WGr0Ypk3b7SS6Td2b/vMwlBDtGRjvvWdqHybHA53+Y
         ktyQvh6JfpN5A==
Message-ID: <3e197ec0-154f-78b6-3bf1-12cf765a3cc6@collabora.com>
Date:   Thu, 5 Oct 2023 14:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: fix clock names for power
 domains
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>, matthias.bgg@gmail.com
Cc:     allen-kh.cheng@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231005103041.352478-1-eugen.hristev@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231005103041.352478-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/10/23 12:30, Eugen Hristev ha scritto:
> Clocks for each power domain are split into big categories: pd clocks
> and subsys clocks.
> According to the binding, all clocks which have a dash '-' in their name
> are treated as subsys clocks, and must be placed at the end of the list.
> The other clocks which are pd clocks must come first.
> Fixed the naming and the placing of all clocks in the power domains.
> For the avoidance of doubt, prefixed all subsys clocks with the 'subsys'
> prefix. The binding does not enforce strict clock names, the driver
> uses them in bulk, only making a difference for pd clocks vs subsys clocks.
> 
> The above problem appears to be trivial, however, it leads to incorrect
> power up and power down sequence of the power domains, because some
> clocks will be mistakenly taken for subsys clocks and viceversa.
> One consequence is the fact that if the DIS power domain goes power down
> and power back up during the boot process, when it comes back up, there
> are still transactions left on the bus which makes the display inoperable.
> 
> Some of the clocks for the DIS power domain were wrongly using '_' instead
> of '-', which again made these clocks being treated as pd clocks instead of
> subsys clocks.
> 
> Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

