Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEDB7E1779
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjKEW4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKEW4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:56:00 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCDCB3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:55:58 -0800 (PST)
Received: from [192.168.68.112] (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3F79220075;
        Mon,  6 Nov 2023 06:55:56 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1699224956;
        bh=BmKouZmZD2oA2wKKyTwBO38CA3p2KV+l6HWrITDlUJY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=AO6vOEIpB+RjBLjYHeCdrlWhQ1Ul3OXNUGjGEj48y64XyFQfC76q7qqYdrQqgHfRW
         P4ZAEBLswmawe5Ei45jvDKCm/eyLwHNpFmQWLfipn4mg4swYFOflv1azfPv7bKxuoH
         cebk++wB8RlNzkYqG3s+2bs5IufqCWBpFHxBQKcEVBMtDyG38NdytLEVl0NreDd9ZU
         dbThXQTsuQhzlsXsI1gvUwuGHaf7EXwwR9JXov880ch8vvkadoClxdqVeewERl+rCc
         NXJT0MPoIkMOlJSHURXr7jpdqHE9x+4sSUiegTdLrtHuS2bM/1holF0YHEuwONLrzb
         GeTdAlxlxQpkw==
Message-ID: <7318575f6a5715c4c77ff56e616dfde7877e101a.camel@codeconstruct.com.au>
Subject: Re: [PATCH 06/10] ipmi: kcs_bmc: Integrate buffers into driver
 struct
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, aladyshev22@gmail.com,
        jk@codeconstruct.com.au
Date:   Mon, 06 Nov 2023 09:25:55 +1030
In-Reply-To: <20231103144559.00003faf@Huawei.com>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
         <20231103061522.1268637-7-andrew@codeconstruct.com.au>
         <20231103144559.00003faf@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-03 at 14:45 +0000, Jonathan Cameron wrote:
> On Fri,  3 Nov 2023 16:45:18 +1030
> Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>=20
> > Consolidate several necessary allocations into one to reduce the number
> > of possible error paths.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Gets rid of some of the devm_kfree() fun, so I'm in favor of the change :=
)
>=20
> One trivial comment inline.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.

> > @@ -478,19 +476,15 @@ static int kcs_bmc_ipmi_add_device(struct kcs_bmc=
_device *kcs_bmc)
> > =20
> >  	spin_lock_init(&priv->lock);
> >  	mutex_init(&priv->mutex);
> > -
> Unrelated change...

Ack, will drop in v2.
