Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD74F757521
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGRHQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjGRHQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2610AE48
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689664518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LO/OU3eOEKbiSK+Rpa6237MBQHj5ytyRv/Karly+Uw4=;
        b=A5ZdXFyoSxGrEJSW68BKFT3EcXOX5u6qf4sZ86vt1ZDDpuAktf7LO+aA1ZdvsISDwZvQdT
        SVDkqbtj4Ov3TQKE9uqHEFXmyRL+qReG5/QYnKB3a8WV1945H116Y3x0rLZtBJs/NVXBcR
        V5gsdTxyBlT5ABSunncuXkWNNVihpWk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-MS-F2VMUOkmU9HgVl_EUPQ-1; Tue, 18 Jul 2023 03:15:17 -0400
X-MC-Unique: MS-F2VMUOkmU9HgVl_EUPQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-401e1fc831fso9932041cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689664516; x=1692256516;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LO/OU3eOEKbiSK+Rpa6237MBQHj5ytyRv/Karly+Uw4=;
        b=ErTAP1TVuCjlAko9X0cf6JijQOiYj6C4c4Lvu0qeNrGOp3RFFxNYqs5kdrofXUZYVZ
         58eg6AnEeQVSdtN11pygTVMg+GUJ+jbneGB+F8Tbgv2C7Onnkk6a+8SmdFn+pKj4uy6o
         xEHy9KlHa5LU9pGaUGqKhjW7Nh4nokgDIWzTI9fHrdKHUiHU5vienfgVvi0OYDO50SrN
         T/EhuRzGlQPSKvQ62h26zsjEDiGqU3NR9t3UEkpC0ddBSJ+yNdrSZH7NDXwRDGXtBknI
         FV5QjJ+sP8x2gIi7/A0RU2R1zOX+kXiz3BdReAr5L1pSjRstuQSmTSInQszqZP+iU3ZX
         1S5g==
X-Gm-Message-State: ABy/qLaQ6hVnjtF5LgFyyKOX1azbp8pet6Kuva9w0TeP14VnyDCE6vkh
        JafPeFxW0Go8ODePHmqrCt3J02tUj6qFKDO0mNFwvkOvpoKpFqHyodQRvlE6B9yWbtl621AruEB
        ehmfbqsvRjcTZYsMmt65u0oci
X-Received: by 2002:a05:622a:145:b0:403:b11f:29f0 with SMTP id v5-20020a05622a014500b00403b11f29f0mr12838200qtw.0.1689664516501;
        Tue, 18 Jul 2023 00:15:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCnBH5LbDKP5eqb3how4HWFYkMEEbEjoni1XoZY9ApODHPDOx/exsxIFeKjFPBf7UcYJHAUw==
X-Received: by 2002:a05:622a:145:b0:403:b11f:29f0 with SMTP id v5-20020a05622a014500b00403b11f29f0mr12838190qtw.0.1689664516267;
        Tue, 18 Jul 2023 00:15:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id bt6-20020ac86906000000b003f364778b2bsm482217qtb.4.2023.07.18.00.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:15:15 -0700 (PDT)
Message-ID: <6818bc7ffe07c21d415265c00b00cf32c6d2ac6f.camel@redhat.com>
Subject: Re: [PATCH] net: ftgmac100: support getting MAC address from NVMEM
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Fertser <fercerpav@gmail.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Liang He <windhl@126.com>, Geoff Levand <geoff@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jul 2023 09:15:11 +0200
In-Reply-To: <ZLDas0gsLNkzuUWR@home.paul.comp>
References: <20230713095743.30517-1-fercerpav@gmail.com>
         <CALs4sv08GJXexShzkrhhW5CDSgJC0z3om5YJzy_qYRqEtvyMtg@mail.gmail.com>
         <ZLDas0gsLNkzuUWR@home.paul.comp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 08:18 +0300, Paul Fertser wrote:
> Hello Pavan,
>=20
> On Fri, Jul 14, 2023 at 10:14:02AM +0530, Pavan Chebbi wrote:
> > On Thu, Jul 13, 2023 at 3:28=E2=80=AFPM Paul Fertser <fercerpav@gmail.c=
om> wrote:
> > > Make use of of_get_ethdev_address() to support reading MAC address no=
t
> > > only from the usual DT nodes but also from an NVMEM provider (e.g. us=
ing
> > > a dedicated area in an FRU EEPROM).
> >=20
> > Looks like earlier ftgmac100_probe() would move on with self generated
> > (random) MAC addr if getting it from the device failed.
> > Now you will fail the probe in a failure case. Is that OK?
>=20
> I think the previous behaviour is preserved with this patch in all the
> cases other than of_get_ethdev_address returning -EPROBE_DEFER. Can
> you please explain what failure case you have in mind and how the
> probe is going to be failed in that case?

FTR, I agree with the above: it looks like the old behavior is
preserved. The patch LGTM, thanks!

Paolo

