Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECE17A5F69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjISKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjISKYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:24:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40002F2;
        Tue, 19 Sep 2023 03:24:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 08B4666071A9;
        Tue, 19 Sep 2023 11:23:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695119040;
        bh=vEd/MlguL02ZXOoi5Lbo0eYYX6tjl/mBmpK3ZZEUtB8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ND8iOwdDEuuZr6o5GFR1BcGk2ITNPnArgMvUGFAJohCweD6qZLyhpVjkG1nFoh04l
         /XF9yMOyv6CmWws+8IYm9fx/12p2Xq/2k/SV/5w5OFfnI4jFkNGEJcSdYZzAg/+KWN
         +CK+wHtpexMo1hYbB3fasJsYDmxaBSHTUVj5+6VD6YMb9tX1iCteOb2D5gat/q0Pns
         klLQPVyPR7lNfMzV0OWv8JqGcMaesyHa1qhhO9IRFycI6rtN96iSu7tgG5rDwlQdkR
         7hdg9gZNBmNeYmn6TQ0mY7FpB1bO2nzFyzSCQcXbqbzlCnDadDg9klsyOHlp6eZ1D2
         TjzD/OXqZFCzQ==
Message-ID: <f1e28c8d-c30f-d80b-3d6f-fbfd3e55a64a@collabora.com>
Date:   Tue, 19 Sep 2023 12:23:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] media: platform: mtk-mdp3: Use devicetree phandle to
 retrieve SCP
Content-Language: en-US
To:     wens@kernel.org
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
References: <20230919095938.70679-1-angelogioacchino.delregno@collabora.com>
 <20230919095938.70679-3-angelogioacchino.delregno@collabora.com>
 <CAGb2v66rEqWBjdMNO3VMZhYj36hhKTxPk+9pborPjnqW0B-=ZA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGb2v66rEqWBjdMNO3VMZhYj36hhKTxPk+9pborPjnqW0B-=ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/23 12:21, Chen-Yu Tsai ha scritto:
> On Tue, Sep 19, 2023 at 6:00 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Instead of walking the entire parent node for something that has the
>> right compatible, use the scp_get() function provided by the MediaTek
>> SCP remoteproc driver to retrieve a handle to mtk_scp through the
>> devicetree "mediatek,scp" (phandle) property.
>>
>> In case of multi-core SCP, this also allows to select a specific core.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../media/platform/mediatek/mdp3/mtk-mdp3-core.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
>> index 8677e7fd5083..d93d3833633e 100644
>> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
>> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
>> @@ -254,13 +254,17 @@ static int mdp_probe(struct platform_device *pdev)
>>                  goto err_destroy_job_wq;
>>          }
>>
>> -       mm_pdev = __get_pdev_by_id(pdev, NULL, MDP_INFRA_SCP);
>> -       if (WARN_ON(!mm_pdev)) {
>> -               dev_err(&pdev->dev, "Could not get scp device\n");
>> -               ret = -ENODEV;
>> -               goto err_destroy_clock_wq;
>> +       mdp->scp = scp_get(pdev);
>> +       if (!mdp->scp) {
>> +               mm_pdev = __get_pdev_by_id(pdev, NULL, MDP_INFRA_SCP);
>> +               if (WARN_ON(!mm_pdev)) {
>> +                       dev_err(&pdev->dev, "Could not get scp device\n");
>> +                       ret = -ENODEV;
>> +                       goto err_destroy_clock_wq;
>> +               }
>> +               mdp->scp = platform_get_drvdata(mm_pdev);
> 
> You need to keep the original code as a fallback for old device trees.
> 

I haven't removed the original code, it *is* there as a fallback :-)

mdp->scp = scp_get() <--- new
if (!mdp->scp) { fallback }

Regards,
Angelo

> ChenYu
> 
>>          }
>> -       mdp->scp = platform_get_drvdata(mm_pdev);
>> +
>>          mdp->rproc_handle = scp_get_rproc(mdp->scp);
>>          dev_dbg(&pdev->dev, "MDP rproc_handle: %pK", mdp->rproc_handle);
>>
>> --
>> 2.42.0
>>
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com


