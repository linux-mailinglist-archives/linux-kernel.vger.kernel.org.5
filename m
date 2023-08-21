Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939E7782305
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjHUE6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjHUE6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:58:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C94A3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:58:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99df11828c6so836736866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1692593884; x=1693198684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQnlMj7kzE9dCiaVDYV86soTAPtlGDeMTtTorKnXjJo=;
        b=P3eoVjxzcooXy3dKqareoJbq/JQEiD1dr3jU/LmUb1arR/8CWPmZpHafq+iAq3Twls
         vnOoeoucqidlP4R6RagbmbttSGZweCIhklCuFI/cvAwn4uZgBd0tG6JHeUyaUaU8a5HN
         sUef+XHEtHFsOJQAgcGD0DAgUU59Mb4iqV0L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692593884; x=1693198684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQnlMj7kzE9dCiaVDYV86soTAPtlGDeMTtTorKnXjJo=;
        b=dHNXltfdVw+4v7PU6kGViXbxb4RtB8w/G0/JuzR5juHkwbm2UnwRufaN6iv2P3RYzE
         +Ca/krMoFA2yxSBKA6TcQS6SGCcuLKMQqwBVP4GItS2L2VmAZgnI/GKI+azmkuhQaZnZ
         vJPHAVJFpoBOR4QoS6JAFJUv2N5Qb2BL2ArLHk2m0EjPvZLbZT1vJF+CNIzxozhEJMi0
         xjH6qcyqBUoIvGnbKp1y7oqmxZ8LSmEltWMd/p0+SdRWAzwN7j23hSh/5WY/0VbiXMsi
         xPcV9SX1nlKyROHISj2/v7ucXMSpyqNCgzcOcf8erHCtXRQBJ+Q+xoNIxNsymOYbcjzR
         fOkw==
X-Gm-Message-State: AOJu0Yzv2QOjTW4kXx0iRIG8PIRWpb+AM/354W8jHcHuBhR4ojFokmDK
        RmEfy/f1aKicsV4QqDlsD7n6fAXQe6hXj3xZJMVwam98
X-Google-Smtp-Source: AGHT+IEGZV2Q63iCluq91jNesmkZwouRSXwFtdGfqrc2ai1Jhi9v0+OdLhNvNvsKP+t/qF1IWkfROPfEgjwUKB1ws28=
X-Received: by 2002:a17:906:209d:b0:99e:f3:67ae with SMTP id
 29-20020a170906209d00b0099e00f367aemr6413345ejq.31.1692593884032; Sun, 20 Aug
 2023 21:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230816171944.123705-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230816171944.123705-1-u.kleine-koenig@pengutronix.de>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Aug 2023 04:57:52 +0000
Message-ID: <CACPK8XdP=t4fLioXE=hnxN_oA1Qyo9VZxjqoUSnNCBErWKRXEQ@mail.gmail.com>
Subject: Re: [PATCH] fsi: i2cr: Switch to use struct i2c_driver's .probe()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eddie James <eajames@linux.ibm.com>, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        linux-fsi@lists.ozlabs.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 at 17:20, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> struct i2c_driver::probe_new is about to go away. Switch the driver to
> use the probe callback with the same prototype.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> this driver appeared in next just today. I intend to drop .probe_new
> from struct i2c_driver after v6.6-rc1, so it would be great if this
> patch would go in together with the commit adding this driver.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Greg, can you please take this for 6.6?

>
> Thanks
> Uwe
>
>  drivers/fsi/fsi-master-i2cr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.=
c
> index 61659c27a973..40f1f4d231e5 100644
> --- a/drivers/fsi/fsi-master-i2cr.c
> +++ b/drivers/fsi/fsi-master-i2cr.c
> @@ -301,7 +301,7 @@ static const struct of_device_id i2cr_ids[] =3D {
>  MODULE_DEVICE_TABLE(of, i2cr_ids);
>
>  static struct i2c_driver i2cr_driver =3D {
> -       .probe_new =3D i2cr_probe,
> +       .probe =3D i2cr_probe,
>         .remove =3D i2cr_remove,
>         .driver =3D {
>                 .name =3D "fsi-master-i2cr",
>
> base-commit: 53e89e3e4490d6630a68e61a3cb478e7a7f2ce8b
> --
> 2.40.1
>
