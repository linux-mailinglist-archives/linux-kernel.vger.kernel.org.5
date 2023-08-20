Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D28781CB3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjHTGz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHTGzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:55:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAFE7DBA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 23:26:06 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id XbsvqZmnh8aG6XbsvqhZSZ; Sun, 20 Aug 2023 08:26:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692512765;
        bh=hA/31A3nSikbjETm9tmDXC3w2WmloFZQ7/DFTrTusAU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RCrhZUcxXtrh7cDKGb3F/lzLcCv6rmtJGrrjTahMqx0swjF6QPjKAQq5Oc4AZ/yEq
         CUh02Ik4mJbGJIVPy/Zj+UbAQQtVR4y9YDmucbiLV8ZuJ2nED7r+NiaOc4h8vSIz6n
         iMVJeUWEl4RticbG+ZEZ1kI6E0bqx0Kwztpqokz3p+BsPfW7ppRmGN5JBzC5GuToVT
         Q4717P0hAr/rErNJL2llBitlNlH5SpuwVP4TbsVrRf0cyDFB8OkRJ4mRamN3KqgM7n
         z9CTFAQfEP3/jeNad8JWRJBz7GSoDJwlMkAHQf7fX49dpOrbkJCQQlKJG8FbyAyWv0
         VpEiUkMij6Rsw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Aug 2023 08:26:05 +0200
X-ME-IP: 86.243.2.178
Message-ID: <022417df-9d3b-6760-3a57-c725906561e5@wanadoo.fr>
Date:   Sun, 20 Aug 2023 08:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] firmware: imx-dsp: Fix an error handling path in
 imx_dsp_setup_channels()
Content-Language: fr
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <2b4bc0b22fac32ab3a7262240019486804c1691f.1673806409.git.christophe.jaillet@wanadoo.fr>
 <CAEnQRZC=JNGixTRVDnEK0p5rZWuQbOmQvApTUM5=0iJN9pzVRw@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAEnQRZC=JNGixTRVDnEK0p5rZWuQbOmQvApTUM5=0iJN9pzVRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/01/2023 à 08:55, Daniel Baluta a écrit :
> On Sun, Jan 15, 2023 at 8:35 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> If mbox_request_channel_byname() fails, the memory allocated a few lines
>> above still need to be freed before going to the error handling path.
>>
>> Fixes: 046326989a18 ("firmware: imx: Save channel name for further use")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Good catch.
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> 

Hi,

polite reminder.

This patch is still not in -next.

CJ
