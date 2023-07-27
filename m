Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB67648C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjG0HfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjG0Hea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:34:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76382619C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:24:26 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxNvGoG8JkHp0KAA--.26506S3;
        Thu, 27 Jul 2023 15:24:24 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx7yOdG8JkObk8AA--.56804S3;
        Thu, 27 Jul 2023 15:24:22 +0800 (CST)
Message-ID: <1690f822-7b35-5108-abee-93593d2ae655@loongson.cn>
Date:   Thu, 27 Jul 2023 15:24:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/mediatek: Fix potential memory leak if vmap() fail
To:     =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        loongson-kernel@lists.loongnix.cn
References: <20230706134000.130098-1-suijingfeng@loongson.cn>
 <6c639e58198680a8d2fb903bb27184bd328e2d54.camel@mediatek.com>
Content-Language: en-US
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <6c639e58198680a8d2fb903bb27184bd328e2d54.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx7yOdG8JkObk8AA--.56804S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy5Zw15tF1DGFWfAr18WFX_yoW8Kw48pF
        sak3WUAFWkJr4UZF1Iv3Wqv3W3Wa4fXF47Grya9r47ZF98G347Gry2yw1YkrWjvrsFka13
        tr4qqrya9r1jyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
        kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
        6r1q6rW5McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
        vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TCJP
        UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Thanks a lot!


On 2023/7/27 09:47, CK Hu (胡俊光) wrote:
> Hi, Jingfeng:
>
> On Thu, 2023-07-06 at 21:40 +0800, Sui Jingfeng wrote:
> >   
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Also return -ENOMEM if such a failure happens, the implement should
> > take
> > responsibility for the error handling.
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
>
> > 
> > Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap
> > function")
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > index a25b28d3ee90..9f364df52478 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > @@ -247,7 +247,11 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object
> > *obj, struct iosys_map *map)
> >  
> >  mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
> >         pgprot_writecombine(PAGE_KERNEL));
> > -
> > +if (!mtk_gem->kvaddr) {
> > +kfree(sgt);
> > +kfree(mtk_gem->pages);
> > +return -ENOMEM;
> > +}
> >  out:
> >  kfree(sgt);
> >  iosys_map_set_vaddr(map, mtk_gem->kvaddr);
> > -- 
> > 2.34.1
>
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

