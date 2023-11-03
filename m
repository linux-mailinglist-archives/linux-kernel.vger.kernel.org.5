Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE77E00DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346884AbjKCJME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346903AbjKCJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7414187
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699002672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooq7AHFYBXmzpPFUKTDHvs5KE2zq7ZILirZFjdfOu3Y=;
        b=O+MiGkdftAlbyImia1C6HtD6qC9PMcaI7kQwOkrXHlV1A/UTJR7DJc0WuwYFyx1LQXVcW4
        BnYNGDrbp0/G2KOZ4kDVJE3nKYOo3N8Y71fX/jmEKUF06QcxsuRBB3Igi2GDi+2cBIg4Xq
        oeYWrqY658RxmX/GuacvW+6VV95CHD4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-J5MwutuwOS-BG8PtZkD4kg-1; Fri, 03 Nov 2023 05:11:09 -0400
X-MC-Unique: J5MwutuwOS-BG8PtZkD4kg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c39f53775fso28015566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 02:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699002668; x=1699607468;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooq7AHFYBXmzpPFUKTDHvs5KE2zq7ZILirZFjdfOu3Y=;
        b=NVAI9PtNGzpa0OJnY7SSDQ8qfwYId79QPvJgiOm+GBEkUca9QVYWgxnbkK49aRTKP9
         au23WElQt/jrcl7KlAyb5vYWu1RoQgiyoSM/+zwz9qp6fNsFHg/H+6yGRR8BEPJoj4bt
         IZvkAWHocJaxMr5g/SKT0G6AqTRWat2jgVPG/5mleZerquq1vSS1kqH7dqM63WXUNg+i
         XaThwpc16X30as6CsXVxpbDRJHJmiucGv/X5xj7TFWMNsAPna5mN0b5l7tlY5Ahw6Btz
         jKicIF5oZm5RfSufvBfVxkcdrGBfv/xu1Ufxy3nTrb/7F8itcBLt5F/VjSvHMwswxm1G
         TI7g==
X-Gm-Message-State: AOJu0YzXaiGhcFp19qm+vW92gFhPd2NcBV44Lg0P1IBdp+Y7h2CIEKs/
        UufNJ/QsEXlGrrfMLCifbXrZnKqzzGu8ix2j/LIeDJMF9f7z/Qk2Y71ErhVn7mnq+vJzwjoseVo
        rf2TXsYjqK2Fc/ywSSm1jv17W
X-Received: by 2002:a17:907:7dac:b0:9a6:5340:c337 with SMTP id oz44-20020a1709077dac00b009a65340c337mr16062983ejc.2.1699002667970;
        Fri, 03 Nov 2023 02:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWbSeL03NZMr+wbTH2OW8X5rhHS/f530LZB9EvIVHLUOclYcjdNyGVA9U2fJtzbal8D1Ti8w==
X-Received: by 2002:a17:907:7dac:b0:9a6:5340:c337 with SMTP id oz44-20020a1709077dac00b009a65340c337mr16062963ejc.2.1699002667592;
        Fri, 03 Nov 2023 02:11:07 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32d1:5200:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id r10-20020a170906350a00b009d22a1422a7sm667681eja.42.2023.11.03.02.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 02:11:07 -0700 (PDT)
Message-ID: <07a220351baa1e6851b90c961aade0ce6d26bcf6.camel@redhat.com>
Subject: Re: [PATCH] drivers/comedi: copy userspace array safely
From:   Philipp Stanner <pstanner@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Date:   Fri, 03 Nov 2023 10:11:06 +0100
In-Reply-To: <2023110348-drained-tameness-b943@gregkh>
References: <20231102190848.51376-2-pstanner@redhat.com>
         <2023110348-drained-tameness-b943@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-03 at 06:53 +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 02, 2023 at 08:08:49PM +0100, Philipp Stanner wrote:
> > comedi_fops.c utilizes memdup_user() to copy a userspace array. This
> > does not check for an overflow.
>=20
> Is there potential for an overflow today?

None that I'm aware of, no. This is more about establishing the new
function as the standard for array-copying, thereby improving
readability and maybe robustness in case of future changes.

>=20
> >=20
> > Use the new wrapper memdup_array_user() to copy the array more safely.
>=20
> How about saying something like:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"Use the new function mem=
dup_array_user() in case things change
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0in the future which would=
 prevent overflows if something were to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0change in the size of the=
 structures".
>=20
> Or something to the affect of "all is good today, but make it easy to be
> correct in the future as well".

Yes, good idea. I'll send a better wording

P.

>=20
> thanks,
>=20
> greg k-h
>=20

