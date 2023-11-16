Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100707EDDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjKPJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D5187
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700127480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Hf8LAx7bki1E0+UUAWwLzQvW31NE2EWhiu1SC5q3wA=;
        b=AOc8Yoi3HESqB7RCFhrzAPhorJm2sQl82BAXr1T4Bqk0cts1bG5ErUepmrz6iujra4bXfL
        gQ/hcyhhQjIaNhsWcpnfuMUc0orNxSD6kPI2XUCw5Mw3t61Iu1EfHFHg/FdOnQIu2upPnD
        eaGlPZs7t0U9zqT5C1v3B0NU8l26qIg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-JdrEmoI3PQWQJrrlRpgRgg-1; Thu, 16 Nov 2023 04:37:59 -0500
X-MC-Unique: JdrEmoI3PQWQJrrlRpgRgg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c39f53775fso8660966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127478; x=1700732278;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Hf8LAx7bki1E0+UUAWwLzQvW31NE2EWhiu1SC5q3wA=;
        b=B4bVaI73M/nvz8JUO9T/LTwra1QWUrDIK8EpRR/aU1A7IuLGW22CYipXwiSkve/Gqc
         bC2LqOjsvt1LuPeV1O1rRkysOlExjoMHvvFmYnPS+ou4mJIddSS76fLYpFyrT7OP6iE4
         g4qlMykAJFI83vL4KedDU8TZeGQegYxI0kziS3CCMC45W+S7UbAX1qjQzrjDR/lzz7D2
         D9LVWEidnh4muz8FJ/0nzMBsuPpSaoe5qA2Fa9wJsyR34KzyVPNBdEavCq5qAeKgEcnh
         7WaN6t1wRoTSNmUwi7sG5ntIO4nfLrMaPZA+8nhYfua9hThZt6gXs6p/zxiHV0gzeAj1
         JRug==
X-Gm-Message-State: AOJu0Ywh8QIyeVSEBu+bz+IsuSrCqBeSmj/1Pcamdoi8ktvGaeCxjSFK
        29f9aEKZxL8JbNvWUHW2XKzDSbIABitsJPT7MW2dRPEhejwGQ3TKhSIn3WsGgQ4Jzx3kyhw6FMz
        C0ldUgG6r/xTdDzQo2PtnT65p
X-Received: by 2002:a17:906:1de:b0:9bf:b83c:5efd with SMTP id 30-20020a17090601de00b009bfb83c5efdmr5493541ejj.3.1700127477903;
        Thu, 16 Nov 2023 01:37:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtvSRCoxqvqt1KeFT05sRiQfB46lYfJJBCPO6bAY48AI0riSceQ/hxVl5Z0X7BgzQkZOEe5g==
X-Received: by 2002:a17:906:1de:b0:9bf:b83c:5efd with SMTP id 30-20020a17090601de00b009bfb83c5efdmr5493519ejj.3.1700127477428;
        Thu, 16 Nov 2023 01:37:57 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-98-67.dyn.eolo.it. [146.241.98.67])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906714900b0099d804da2e9sm8153342ejj.225.2023.11.16.01.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:37:56 -0800 (PST)
Message-ID: <d17b696c81a57fb857b54a8c05e121be1cfc47fa.camel@redhat.com>
Subject: Re: [PATCH 1/2] net: usb: ax88179_178a: fix failed operations
 during ax88179_reset
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     weihao.bj@ieisystem.com
Date:   Thu, 16 Nov 2023 10:37:55 +0100
In-Reply-To: <20231114125111.313229-2-jtornosm@redhat.com>
References: <20231114125111.313229-1-jtornosm@redhat.com>
         <20231114125111.313229-2-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-14 at 13:50 +0100, Jose Ignacio Tornos Martinez wrote:
> Using generic ASIX Electronics Corp. AX88179 Gigabit Ethernet device,
> the following test cycle has been implemented:
>     - power on
>     - check logs
>     - shutdown
>     - after detecting the system shutdown, disconnect power
>     - after approximately 60 seconds of sleep, power is restored
> Running some cycles, sometimes error logs like this appear:
>     kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Fa=
iled to write reg index 0x0001: -19
>     kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Fa=
iled to read reg index 0x0001: -19
>     ...
> These failed operation are happening during ax88179_reset execution, so
> the initialization could not be correct.
>=20
> In order to avoid this, we need to increase the delay after reset and
> clock initial operations. By using these larger values, many cycles
> have been run and no failed operations appear.
>=20
> Reported-by: Herb Wei <weihao.bj@ieisystem.com>
> Tested-by: Herb Wei <weihao.bj@ieisystem.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

We need at least a suitable Fixes tag

> ---
>  drivers/net/usb/ax88179_178a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178=
a.c
> index aff39bf3161d..4ea0e155bb0d 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1583,11 +1583,11 @@ static int ax88179_reset(struct usbnet *dev)
> =20
>  	*tmp16 =3D AX_PHYPWR_RSTCTL_IPRL;
>  	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
> -	msleep(200);
> +	msleep(500);

Do you know if there is some status register you can query for 'reset
completed'? or some official documentation you can quote for the above
delay?

Thanks!

Paolo

