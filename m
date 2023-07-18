Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2A7584F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGRSjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGRSjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:39:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AECF7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:39:44 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id LpbhqgTmDgEYrLpbhqs7UZ; Tue, 18 Jul 2023 20:39:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689705582;
        bh=tdlBUHWUDeKcYw0WXmCHBGLh8IA7flKlmSo8k4y0V60=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZQcVTd5KpaeF4EOE+fysig0lBxjfUmgJO3PowpFkNTGclDydzH+tYki8gEi+Imi5u
         GkIbpmer1NKaH9M0eWIT1ZN2NADE/n9oQfzomnZbCavOjN5nNUqy0UpIEHc5n8Q1vg
         5fq4ctk6/ZQ2JbRENF82CDW+oSr+cPd+noFMKqSeCxM7jysC5pbssV5dXpesa3A5pi
         2ILIlsUoiO61Bq59piNwXMNArZnQ/2s6sz4a4qynqKcYOe9d5BycztLKblt7MlhLcs
         VN1maZ3TcEOlXqOEKaF6s1+J/Qm86/IMmb0MrsGAuuFsuVxP6EamKutSk9sms1MJXR
         iAPTcIILmSPGg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 Jul 2023 20:39:42 +0200
X-ME-IP: 86.243.2.178
Message-ID: <60305a76-4e41-8e51-a394-dc55c0ba05da@wanadoo.fr>
Date:   Tue, 18 Jul 2023 20:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: mediatek: vcodec: Fix an error handling path in
 vdec_msg_queue_init()
Content-Language: fr, en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <efa0d4910998931a2ec9d933117fa71482d7b33a.1689624542.git.christophe.jaillet@wanadoo.fr>
 <1dcd0fab-eee3-4693-a7d2-4a72baef5c97@kadam.mountain>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1dcd0fab-eee3-4693-a7d2-4a72baef5c97@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/07/2023 à 08:58, Dan Carpenter a écrit :
> On Mon, Jul 17, 2023 at 10:09:19PM +0200, Christophe JAILLET wrote:
>> All errors go to the error handling path, except this one. Be consistent
>> and also branch to it.
>>
>> Fixes: 2f5d0aef37c6 ("media: mediatek: vcodec: support stateless AV1 decoder")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
> 
> I sent this one a month ago but it hasn't been applied.
> 
> https://lore.kernel.org/all/b8948d9a-65bc-4f3f-aa90-60addd064819@moroto.mountain/
> 
> regards,
> dan carpenter
> 
> 

Hi Dan,

your patch is better than mine.
Less verbose and more complete.

CJ
