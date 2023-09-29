Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE897B371E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjI2PnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjI2Pmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:42:53 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B21A8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:42:50 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230929154246euoutp02475e5b0c8c6180a787e899944e6f18a4~JaPwXHSVn1218112181euoutp02p
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230929154246euoutp02475e5b0c8c6180a787e899944e6f18a4~JaPwXHSVn1218112181euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696002166;
        bh=CQTRN2vo9WK0OShy1SLmkbvDHRVLHte2+59M6kPbZg8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=PA3uuCGbkheZJ4Kl3Jr2qqkvLhPL5D4JkhRBGX76rVCEBejZ3Spu8FcTi1ph2e/Us
         PqHPeiSahDx2/5PhjuX1dUQRssH74Ph1/1px7NlMhoQqA1l8wGtT2e2wHsEOsbiraq
         sAkoc1UKQ02plCBUvsVDNVFNjhbfgFwUX3C2mZVA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230929154246eucas1p1bdfd26c3f7ecd0f0fb5810012e0d00ea~JaPwPIGdP2198521985eucas1p1E;
        Fri, 29 Sep 2023 15:42:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.80.42423.670F6156; Fri, 29
        Sep 2023 16:42:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230929154246eucas1p2ccbc8fc3f916d7edcfe89ce3d50331a6~JaPv0Vp240913609136eucas1p2O;
        Fri, 29 Sep 2023 15:42:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230929154246eusmtrp2e2dc508523525d475ba0e8ef0d94d7d7~JaPvzyUOd0408104081eusmtrp2T;
        Fri, 29 Sep 2023 15:42:46 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-f4-6516f0767169
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9C.02.10549.570F6156; Fri, 29
        Sep 2023 16:42:45 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230929154245eusmtip16e01c544e29d470035523d841b766e6e~JaPvWsuVU0372603726eusmtip10;
        Fri, 29 Sep 2023 15:42:45 +0000 (GMT)
Message-ID: <07cfbe4d-35e9-b7d2-ca0f-7c38eac2e4e6@samsung.com>
Date:   Fri, 29 Sep 2023 17:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] media: s5p-mfc: Fix potential deadlock on condlock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>, andrzej.hajda@intel.com,
        mchehab@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230926105330.10281-1-dg573847474@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djP87plH8RSDZY8FbO4v/gzi8WSu1vY
        LTY9vsZqcXnXHDaLng1bWS2WbfrD5MDmsXPWXXaPxXteMnlsWtXJ5rF5Sb3H501yAaxRXDYp
        qTmZZalF+nYJXBnH/s5gKmjmq1j/eipLA+Ml7i5GTg4JAROJ/qVrWLoYuTiEBFYwSpzcMQPK
        +cIosXPlTkYI5zOjxIKH+5hgWjafXMYMkVjOKHHx7i0mCOcjo8TymXuYQap4BewkTn86yA5i
        swioShz5soYRIi4ocXLmExYQW1QgVaL5zXmwGmEBd4mm/h6wXmYBcYlbT+YDDeXgEBEIlziw
        3R8inCrx5O0iNhCbTcBQouttF5jNKWAtsenlOahWeYntb+eAHSchcIFD4t2LL4wQV7tIHH/T
        wAphC0u8Or6FHcKWkfi/cz4TREM70Ju/70M5ExglGp7fguq2lrhz7hcbyEXMApoS63fpQ4Qd
        Ja4dussOEpYQ4JO48VYQ4gg+iUnbpjNDhHklOtqEIKrVJGYdXwe39uCFS8wTGJVmIYXKLCTf
        z0LyziyEvQsYWVYxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEJp7T/45/2sE499VHvUOM
        TByMhxglOJiVRHjbLoilCvGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBa
        BJNl4uCUamByZLuV6Xib3/nQu25p1fWqauWm8jdMOdSn74qYpHFG3Oz63i1uTF52fxzFn8jL
        9/MwNrA/Wp+oarwi23LSW7b6z43hld/37OFk9lecIi349NIH5cUmSwNSzBqZVMyCd65km5Hb
        Vv5ogpDl8j9bprEFicypfLk4QdYlYOqWP6/KHsqoRigen17K0PxvyTROm3eS5upGSoYRqsds
        qvb9kgjmmMnNmLxARKrxyIqm8D9yhdWRclf64njtt/f+2DIjLCb2cw1vdUak68IjE2LmL/+3
        Y/2SbxLX0wLyl+9yzk0vWMKlfetKxTqP5ZNennoaerDxjfTdKp4Eu4ZTlyvX17uf6PhV98Jq
        j2bMLmYeHiWW4oxEQy3mouJEAHNKK+CrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7qlH8RSDbrmW1vcX/yZxWLJ3S3s
        FpseX2O1uLxrDptFz4atrBbLNv1hcmDz2DnrLrvH4j0vmTw2repk89i8pN7j8ya5ANYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxjf2cwFTTz
        Vax/PZWlgfESdxcjJ4eEgInE5pPLmLsYuTiEBJYySqzc+4oNIiEjcXJaAyuELSzx51oXG0TR
        e0aJydeamUASvAJ2Eqc/HWQHsVkEVCWOfFnDCBEXlDg58wkLiC0qkCpxetomsLiwgLtEU38P
        M4jNLCAucevJfLA5IgLhEm/alrBBxFMlZnx8zA6xrI9R4sPUI2CD2AQMJbredoEVcQpYS2x6
        eQ5qkJlE19YuRghbXmL72znMExiFZiG5YxaSfbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5x
        aV66XnJ+7iZGYKxtO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMLbdkEsVYg3JbGyKrUoP76oNCe1
        +BCjKTAwJjJLiSbnA6M9ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mD
        U6qBaUrrZLuf63/zsE57m8vsu93x+7J7t5lWW8wRdy12Yyj47PVkytaw24aSko7xWzmCS6J6
        GEIFQn7I7wr+3sYaen1jw+rcgDeyPHZf+P/uf7pca33+NV3fg/ZhcmeqxHtqtHNc1yhyL9Mu
        O/r0UHlwGOeW2m7h1Z+OaMjdqdM4O6vnOp+//v+9HY9du1QXZ5gbbNn0II/B/s1ylQynNt3a
        BHvz+QbSF3l/Pbm74faFqAsJpmFRmQ+yVBIt7VnEg0yE68+0TGT3Wan/b4Xv5eMT9W/+mKlr
        W15y8sS9wA9mPM03RcW7zjJ7+fYbaq5RnO+k8WzLlbvb/xQ/5JkQeO146vpGV3aWXSZ9bgc1
        mlcqsRRnJBpqMRcVJwIAoM0kVj4DAAA=
X-CMS-MailID: 20230929154246eucas1p2ccbc8fc3f916d7edcfe89ce3d50331a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230926105338eucas1p286ab56d3177817fbb32713228af9f9ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230926105338eucas1p286ab56d3177817fbb32713228af9f9ba
References: <CGME20230926105338eucas1p286ab56d3177817fbb32713228af9f9ba@eucas1p2.samsung.com>
        <20230926105330.10281-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2023 12:53, Chengfeng Ye wrote:
> As &dev->condlock is acquired under irq context along the following
> call chain from s5p_mfc_irq(), other acquisition of the same lock
> inside process context or softirq context should disable irq avoid double
> lock. enc_post_frame_start() seems to be one such function that execute
> under process context or softirq context.
>
> <deadlock #1>
>
> enc_post_frame_start()
> --> clear_work_bit()
> --> spin_loc(&dev->condlock)
> <interrupt>
>     --> s5p_mfc_irq()
>     --> s5p_mfc_handle_frame()
>     --> clear_work_bit()
>     --> spin_lock(&dev->condlock)
>
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
>
> To prevent the potential deadlock, the patch change clear_work_bit()
> inside enc_post_frame_start() to clear_work_bit_irqsave().
>
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> index f62703cebb77..4b4c129c09e7 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> @@ -1297,7 +1297,7 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
>   	if (ctx->state == MFCINST_FINISHING && ctx->ref_queue_cnt == 0)
>   		src_ready = false;
>   	if (!src_ready || ctx->dst_queue_cnt == 0)
> -		clear_work_bit(ctx);
> +		clear_work_bit_irqsave(ctx);
>   
>   	return 0;
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

