Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D3804D34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjLEJGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FCDFA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701767210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/5hbavG9FxtP2fqgbrUZXKsls1QEJHwMBm7cnQddac=;
        b=NNVUQvzoSQQ0tIEW+atLuD3QTxTsAkTnPoDmNbK8F0Ag50D0VmE68S7xQ0YUW6AMUoQxKu
        GoMmB/bsBO++hahDlqCHXQPmfUUcKeIEvFEfwcCbW/bUvz75GyjA9uAb49rOoaTPnbN4Kc
        pwyW9VNCgV//71wv6b0CIk/C46SJTQo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-BgkAH3AkOayh0Kysjbg3YA-1; Tue, 05 Dec 2023 04:06:49 -0500
X-MC-Unique: BgkAH3AkOayh0Kysjbg3YA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1a3f8b80e1so57282266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701767208; x=1702372008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/5hbavG9FxtP2fqgbrUZXKsls1QEJHwMBm7cnQddac=;
        b=H9DiBsToBnrG+m7SAFZygYxzUqe/LCi5wiGRen/3veYHT9C6gpOvfKmUaUg5NItipn
         GSi7052CHLjMACiudmfZYtN7c2QYBNnfNNJOWpqFy/2ME2JrKGmmjnqeLKfFPaSMdYq/
         MozJ1G+myTWoPAdHQ6A73RQXllrOcUdMH1wW2JFlBZzZ2NY9KOS61JLK1k4IRo8pLhg0
         AqIbVtK4ELsGZp3+6LRTMyvNFKPq0zTFKlYxvVs5Tnh5H/zD0xmH1zJ5R+0PIvD+l07C
         kCc+V/BLffDbY1oilVPzZlu74y3og3zGu8tQa+U4B+cVIBptmwEep1Fn2TNxqLisLc8U
         biXQ==
X-Gm-Message-State: AOJu0YymCPc+4CjParNC36aT0a1gp97b0hz6i825n8sW6+pAFuaVSKTQ
        2dnuzujnvuQl8o1qHMajYI34BmSDo4ZJXWleYTVttcUcH0UOV3xEmWaAFUwR2Z9itV9asOJ4/n4
        sR26DJhlTLHkfywWHG5N99xHd
X-Received: by 2002:a17:907:7b94:b0:a1c:5944:29bb with SMTP id ne20-20020a1709077b9400b00a1c594429bbmr1029473ejc.7.1701767208263;
        Tue, 05 Dec 2023 01:06:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2xEfzHGLjR6dkG5vPelsChBHYBSZ8pQ6/tWoEjwLbIwKq9MOsnOkGAMl0nAtEF2pfqgyfKQ==
X-Received: by 2002:a17:907:7b94:b0:a1c:5944:29bb with SMTP id ne20-20020a1709077b9400b00a1c594429bbmr1029447ejc.7.1701767207884;
        Tue, 05 Dec 2023 01:06:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id ay19-20020a170906d29300b00a0c3b122a1esm6361708ejb.63.2023.12.05.01.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:06:47 -0800 (PST)
Message-ID: <1f0cd6c635d1f570ff36c4b5a94e8d5a9f596aee.camel@redhat.com>
Subject: Re: [PATCH net-next v6 1/6] ptp: clockmatrix: support 32-bit
 address space
From:   Paolo Abeni <pabeni@redhat.com>
To:     Min Li <lnimi@hotmail.com>, richardcochran@gmail.com,
        lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Date:   Tue, 05 Dec 2023 10:06:46 +0100
In-Reply-To: <PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
References: <PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2023-11-30 at 13:46 -0500, Min Li wrote:
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.=
c
> index f6f9d4adce04..f8556627befa 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -41,8 +41,8 @@ module_param(firmware, charp, 0);
>  static int _idtcm_adjfine(struct idtcm_channel *channel, long scaled_ppm=
);
> =20
>  static inline int idtcm_read(struct idtcm *idtcm,
> -			     u16 module,
> -			     u16 regaddr,
> +			     u32 module,
> +			     u32 regaddr,
>  			     u8 *buf,
>  			     u16 count)
>  {

[...]
> @@ -553,11 +554,11 @@ static int _sync_pll_output(struct idtcm *idtcm,
>  	val =3D SYNCTRL1_MASTER_SYNC_RST;
> =20
>  	/* Place master sync in reset */
> -	err =3D idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
> +	err =3D idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
>  	if (err)
>  		return err;

I'm sorry, but it looks like my previous feedback was not clear enough:
now that the 'regaddr' argument in idtcm_write() has 'u32' type, you
don't need anymore to swap the 'module' and 'regaddr' arguments in the
call site.

Specifically, you can drop the above chunk, many later similar ones=20
and additionally even chunks calling to idtcm_write(), for the same
reason.

That would make the patch smaller, and IMHO more clear: it would be=20
strange that something that was known as a register address suddenly
become a 'module'.

Thanks!

Paolo

