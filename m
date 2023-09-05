Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42848792B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245264AbjIEQuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353737AbjIEHqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:46:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D969CCB;
        Tue,  5 Sep 2023 00:46:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0313D660716C;
        Tue,  5 Sep 2023 08:46:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693899999;
        bh=M7ijh1NV65ef/d85X0SUJPK+cCBA9TUb25WnmHtKT/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GfmE4x/kxAwI40jVpWeIH0F7aLiEdbCqghvYyXiLpppjDHyEi5ja0gmPY8JMxrMN2
         EKUPi3uWTwy7Ju8OX43emkXri2FELmHV60atHRcwTBZuNYh0mEk+EsoPH1Ny/mas50
         GOLBBCH/paJW7d+w9PSqz9ylfh9/UPUeNOeBaqzChlt/QCRdu/k3JsVlbIKtcgXM3v
         tsp+q5ccXPg4ojEGFdPY9hXfw3kPJM8C4l4tku6YOegCB6mbPFh8ccyeYlJmJeSEEx
         6mrkq+4VI4Te6IYiQimQkn6V5qGIU/Brawaag7fCO8e+QYzHl9FF0kGKlpv+GsATzO
         f1czlQN0/EVtQ==
Message-ID: <8f6390e4-690b-948c-f91b-f99768ba7cf0@collabora.com>
Date:   Tue, 5 Sep 2023 09:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v17 09/14] remoteproc: mediatek: Remove dependency of
 MT8195 SCP L2TCM power control on dual-core SCP
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230901080935.14571-1-tinghan.shen@mediatek.com>
 <20230901080935.14571-10-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230901080935.14571-10-tinghan.shen@mediatek.com>
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

Il 01/09/23 10:09, Tinghan Shen ha scritto:
> Previously, SCP core 0 controlled the power of L2TCM and dictated that
> SCP core 1 could only boot after SCP core 0. To address this constraint,
> extracted the power control flow of L2TCM and made it shared
> between both cores, enabling support for arbitrary boot order.
> 
> The flow for controlling L2TCM power has been incorporated into the
> mt8195_scp_before_load() and mt8195_scp_stop() APIs, which are
> respectively invoked during the rproc->ops->start() and
> rproc->ops->stop() operations. These APIs effectively serve the same
> purpose as the rproc prepare()/unprepare() APIs."
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


