Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755527D1101
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377468AbjJTN4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377514AbjJTN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:56:08 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404961A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:56:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2F44240017;
        Fri, 20 Oct 2023 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697810164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guw01RKGbn1f3hLQyDo30kntXr8E8ttJ8J7CZjAKzjs=;
        b=iAr0lMGu8lG5QiztzmvYFF7EeDTGk7e9deIr8sIygM2F03wozOgIGiI1DoxPx8aTtaoQrQ
        vQj0cte+G92WrfW2bba0M9XqksyCfSaq066ICISm66+OzOTimCLmNrX94ybnzwfQFuAsDA
        BaSQPVy2KSCZhyEVQgbhgfx/QMvd8Vxybkk1Huhvisek5eSEmgwGJ4YRew64YWuUKQ1Z/h
        IaobZza12XF0rPFnjtI4Yn46Paq8xIm4fG61Wqy0/qwwSjAK421P1H0DFf8bbmrRAEWTcR
        TwUlFvxG+TzbUj3KO3FnjkOxOCcpR4hmt6gj1dKdktqBER+rPr3iX5qnCDomvw==
Date:   Fri, 20 Oct 2023 15:56:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] i3c: master: svc: fix wrong data return when IBI
 happen during start frame
Message-ID: <20231020155603.52cc7206@xps-13>
In-Reply-To: <20231019222725.3598022-3-Frank.Li@nxp.com>
References: <20231019222725.3598022-1-Frank.Li@nxp.com>
        <20231019222725.3598022-3-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Thu, 19 Oct 2023 18:27:21 -0400:

>      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =
=E2=94=8F=E2=94=80=E2=94=80=E2=94=90  =E2=94=8F=E2=94=80=E2=94=80=E2=94=90 =
 =E2=94=8F=E2=94=80=E2=94=80=E2=94=90  =E2=94=8F=E2=94=80=E2=94=80=E2=94=90=
  =E2=94=8F=E2=94=80=E2=94=80=E2=94=90  =E2=94=8F=E2=94=80=E2=94=80=E2=94=
=90  =E2=94=8F=E2=94=80=E2=94=80=E2=94=90  =E2=94=8F=E2=94=80=E2=94=80=E2=
=94=90  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> SCL: =E2=94=98     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=9B  =E2=94=94=E2=94=80=E2=94=80=E2=94=9B  =E2=94=94=E2=94=80=E2=94=
=80=E2=94=9B  =E2=94=94=E2=94=80=E2=94=80=E2=94=9B  =E2=94=94=E2=94=80=E2=
=94=80=E2=94=9B  =E2=94=94=E2=94=80=E2=94=80=E2=94=9B  =E2=94=94=E2=94=80=
=E2=94=80=E2=94=9B  =E2=94=94=E2=94=80=E2=94=80=E2=94=9B  =E2=94=94=E2=94=
=80=E2=94=80=E2=94=98
>      =E2=94=80=E2=94=80=E2=94=80=E2=94=90                       =E2=94=8C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =E2=94=8C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =E2=94=8C=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
> SDA:    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=98     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =
          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>      xxx=E2=95=B1    =E2=95=B2=E2=95=B1                                  =
      =E2=95=B2=E2=95=B1    =E2=95=B2=E2=95=B1    =E2=95=B2=E2=95=B1    =E2=
=95=B2
>    : xxx=E2=95=B2IBI =E2=95=B1=E2=95=B2               Addr(0x0a)         =
      =E2=95=B1=E2=95=B2 RW =E2=95=B1=E2=95=B2NACK=E2=95=B1=E2=95=B2 S  =E2=
=95=B1
>=20
> If an In-Band Interrupt (IBI) occurs and IBI work thread is not immediate=
ly
> scheduled, When svc_i3c_master_priv_xfers() initiates the I3C transfer and

nit:		when

> attempts to send address 0x7e, the target interprets it as an
> IBI handler and returns the target address 0x0a.
>=20
> However, svc_i3c_master_priv_xfers() does not handle this case and procee=
ds
> with other transfers, resulting in incorrect data being returned.
>=20
> Add IBIWON check in svc_i3c_master_xfer(). In case this situation occurs,
> return a failure to the driver.
>=20
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---


Thanks,
Miqu=C3=A8l
