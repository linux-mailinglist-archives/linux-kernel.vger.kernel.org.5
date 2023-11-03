Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7701C7E03EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjKCNqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:46:52 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA7A91;
        Fri,  3 Nov 2023 06:46:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5735640013;
        Fri,  3 Nov 2023 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699019204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MWVWZN94e51Kb18auyRiLeqhoOf2GJa5P8GvtHKBzk=;
        b=dUzPAqLztbdKOYCaw6nMFwqeACnAxtAeWsRQkQvZgQL4rJSrFiAd+q4Ux6sLbx3JIAdQ1q
        FnDh7IqUElNHzqoKKsW+N/HZbvIwVmH1DoHXzjaarVzctf3fZnR0YhdFtZSNoikHI/i/tI
        aF25Ypi72MQhaMHKY1ENI3C3JZQWnFmawEUwWcJNVJseqto9TiHv6mRugNdcT6KvZ7bpvo
        kbYQqPYZfUjUUi6f3FokIxk99PmcmFtLghl103/cAhhm1mCpCgEH4BIs/mSMwhQR5ISr63
        PBsofYkJGBrAhIMa9Jk9h+2la5LIHMRTQXMGCFJKlW9BLQ60XDghgLzyq0FrZQ==
Date:   Fri, 3 Nov 2023 14:46:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <qpic_varada@quicinc.com>
Subject: Re: [RFC PATCH 1/5] mtd: nand: ecc-qcom: Add support for ECC Engine
 Driver
Message-ID: <20231103144639.6ff40ae2@xps-13>
In-Reply-To: <4b911907-44b9-c164-9648-3d399e557672@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
        <20231031120307.1600689-2-quic_mdalam@quicinc.com>
        <b9af01d2-1a86-4b41-9bd6-3bf7a0dde1c0@linaro.org>
        <553c1373-c9a0-b2af-2286-058824e31bad@quicinc.com>
        <CAA8EJpp-xsP1x==a5DH8pKpy7XH75UF-L8ewKWmeL8ePtxUq-A@mail.gmail.com>
        <4b911907-44b9-c164-9648-3d399e557672@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Based on below feedback [1] and NAK on the device node patch
> got idea of having separate device node for ECC is not acceptable.
> Could you please help to clarify that.

If I may try to compare with the Macronix situation, the ECC engine
was an independent hardware block, with its own mapping and its own
registers, so it was described as an independent node in the DT. The
type of ECC controller (pipelined or external) is described by the
nand-ecc-engine property which either points at the parent node
(pipelined) or an external node (external). The SPI host would itself
point at the external ECC engine node with its own nand-ecc-engine
property (see mtd/mxicy,nand-ecc-engine.yaml in the bindings).

> Since ECC block is inlined with QPIC controller so is the below
> device node acceptable ?
>=20
>     bch: qpic_ecc {
>                            compatible =3D "qcom,ipq9574-ecc";
>                            status =3D "ok";
>                    };

If it does not has its own mapping and if you access the ECC engine
through the host registers then the controller should be part of the
host node, but I am not sure it really needs to be described
explicitly, most of them are not for historical reasons. Conceptually
there is a problem with subnodes of each of these controllers having
a signification already: SPI devices or NAND chips.

Thanks,
Miqu=C3=A8l
