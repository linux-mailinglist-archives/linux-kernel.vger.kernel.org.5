Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7547EDDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbjKPJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjKPJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:42:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514E1B3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700127769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=heGG96XfkpUgzfldNR64oAGB+yDvLKeqZ76hGOTYKIY=;
        b=RJIvCqUEPVwkyiEEHLB2wgKjuYnPSQjbe4RxhXulZazRw1+il2BQwXuoRJ/EKi2hq6c71S
        YtGLQMFhcfnIhJm5Q049dUtgM3Of3Jrk3b8rItR0Sgbiv0ydo5/KvxaqDCDqr0Un+ilP+h
        267Wu18PGkUiilZlKNw5A9a17SH4uVM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-zIugWFoaNe2_Tcm8uyRB_g-1; Thu, 16 Nov 2023 04:42:45 -0500
X-MC-Unique: zIugWFoaNe2_Tcm8uyRB_g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c45a6a8832so11216066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127764; x=1700732564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heGG96XfkpUgzfldNR64oAGB+yDvLKeqZ76hGOTYKIY=;
        b=ENpvp/Hy8v2/NGvMbuTpudV0U6VCQdUKEwrVF1Ap2ygXv3tSEpo7P4KXSzy6/N2HZg
         pUXyjfO4vtkjA+yIJkflvmHks1IHnWqSb3ZiHNkJv8DsMoxVhWdC1OXQUSbG1gOoCAgQ
         mhhsRKva6S6D/mV1j2NpdvIt0F7H7JEyzgYSd/Uqk3IOYh6nwpf817uENL/fSKlKZhWl
         T49Q6Mtz3i1QT1eO5ZDlaapunZJDNMGvu2d5uMJnvWcFMKewjmSV69aY7+MHBAiKPhwV
         sOZ8kJrJsGIUM5QrHzlNQ/U1294L1yuuZdndnRWDJgsws+Dis2Hxf0afpcw7VSlDwBt7
         zaVQ==
X-Gm-Message-State: AOJu0YxZoE0MeOVV8bFnH9SI6edMmznpQF156SANkrRGGPcRlg2RgTlP
        X21tX6Bbatz54oQormq8EUk5if6bNRB3Q8JYmjKqy+P69Ggds7WXGYLQY90wByMZs+7P17gHX/G
        CoDUIl9PHs+Q3P/QCXwDYg38c
X-Received: by 2002:a17:906:74d6:b0:9d0:51d4:4dc6 with SMTP id z22-20020a17090674d600b009d051d44dc6mr5575109ejl.2.1700127764289;
        Thu, 16 Nov 2023 01:42:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9Lx2TYA5UNjfQFCcN+QXNqEZ/5fLFxxydsbS74Vjgexqqz/6UU/5qGFIbdY0aCgbA2PVuHA==
X-Received: by 2002:a17:906:74d6:b0:9d0:51d4:4dc6 with SMTP id z22-20020a17090674d600b009d051d44dc6mr5575077ejl.2.1700127763868;
        Thu, 16 Nov 2023 01:42:43 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-98-67.dyn.eolo.it. [146.241.98.67])
        by smtp.gmail.com with ESMTPSA id q24-20020a17090622d800b009db53aa4f7bsm8151379eja.28.2023.11.16.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:42:43 -0800 (PST)
Message-ID: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
Subject: Re: [PATCH 2/2] net: usb: ax88179_178a: avoid two consecutive
 device resets
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     weihao.bj@ieisystem.com
Date:   Thu, 16 Nov 2023 10:42:42 +0100
In-Reply-To: <20231114125111.313229-3-jtornosm@redhat.com>
References: <20231114125111.313229-1-jtornosm@redhat.com>
         <20231114125111.313229-3-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-14 at 13:50 +0100, Jose Ignacio Tornos Martinez wrote:
> The device is always reset two consecutive times (ax88179_reset is called
> twice), one from usbnet_probe during the device binding and the other fro=
m
> usbnet_open.
>=20
> Let only the reset during the device binding to prepare the device as soo=
n
> as possible and not repeat the reset operation (tested with generic ASIX
> Electronics Corp. AX88179 Gigabit Ethernet device).
>=20
> Reported-by: Herb Wei <weihao.bj@ieisystem.com>
> Tested-by: Herb Wei <weihao.bj@ieisystem.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

We need a suitable Fixes tag even here ;)

> ---
>  drivers/net/usb/ax88179_178a.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178=
a.c
> index 4ea0e155bb0d..864c6fc2db33 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1678,7 +1678,6 @@ static const struct driver_info ax88179_info =3D {
>  	.unbind =3D ax88179_unbind,
>  	.status =3D ax88179_status,
>  	.link_reset =3D ax88179_link_reset,
> -	.reset =3D ax88179_reset,
>  	.stop =3D ax88179_stop,
>  	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX,
>  	.rx_fixup =3D ax88179_rx_fixup,

This looks potentially dangerous, as the device will not get a reset in
down/up cycles; *possibly* dropping the reset call from ax88179_bind()
would be safer.

In both cases touching so many H/W variant with testing available on a
single one sounds dangerous. Is the unneeded 2nd reset causing any
specific issue?

Thanks,

Paolo

