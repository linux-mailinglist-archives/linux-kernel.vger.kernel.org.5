Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204437BB5CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjJFLDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjJFLDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:03:07 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F4BC5;
        Fri,  6 Oct 2023 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696590186; x=1728126186;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=+Oj9cWZfF6C+d+uAdm+g5fcf0+MKR1+ZXyJy38ELkUI=;
  b=amxSpM34Qfm3XB60YT21eqg6iKiI/M1PGuzaeUG4jiE3O4ANJbWbhdTE
   CfnzjKMYdupn+7FZBVrvin6tAi9I2tKaUizwhS4OEmVFVOKo+mYA0yC4L
   sM7UAvjpwxOQeh0DnI7hcbiDIRO/ZtQ17OEf+H4hksOJ7VwAG6aTN1weH
   c=;
X-IronPort-AV: E=Sophos;i="6.03,203,1694736000"; 
   d="scan'208";a="158577964"
Subject: RE: [PATCH] net: ena: replace deprecated strncpy with strscpy
Thread-Topic: [PATCH] net: ena: replace deprecated strncpy with strscpy
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 11:03:03 +0000
Received: from EX19D020EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id 108B4807C1;
        Fri,  6 Oct 2023 11:03:02 +0000 (UTC)
Received: from EX19D047EUA001.ant.amazon.com (10.252.50.171) by
 EX19D020EUA001.ant.amazon.com (10.252.50.154) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 6 Oct 2023 11:02:39 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D047EUA001.ant.amazon.com (10.252.50.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 6 Oct 2023 11:02:39 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1118.037; Fri, 6 Oct 2023 11:02:39 +0000
From:   "Kiyanovski, Arthur" <akiyano@amazon.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Justin Stitt <justinstitt@google.com>,
        "Agroskin, Shay" <shayagr@amazon.com>,
        "Arinzon, David" <darinzon@amazon.com>,
        "Dagan, Noam" <ndagan@amazon.com>,
        "Bshara, Saeed" <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Thread-Index: AQHZ9ybKM2b6eyqkVE+Gavzwy9pPV7A7w5HwgAAHhICAAIzkkA==
Date:   Fri, 6 Oct 2023 11:02:22 +0000
Deferred-Delivery: Fri, 6 Oct 2023 07:05:46 +0000
Message-ID: <5f8d24d16fba49bfb57fd4b6678ac27d@amazon.com>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
 <fe65f57f91f342c7a173891b84cda37b@amazon.com>
 <202310051537.7C5CEE6E@keescook>
In-Reply-To: <202310051537.7C5CEE6E@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.50.216]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
> Sent: Friday, October 6, 2023 1:39 AM
> To: Kiyanovski, Arthur <akiyano@amazon.com>
> Cc: Justin Stitt <justinstitt@google.com>; Agroskin, Shay
> <shayagr@amazon.com>; Arinzon, David <darinzon@amazon.com>; Dagan,
> Noam <ndagan@amazon.com>; Bshara, Saeed <saeedb@amazon.com>; David
> S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> hardening@vger.kernel.org
> Subject: RE: [EXTERNAL] [PATCH] net: ena: replace deprecated strncpy with
> strscpy
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick
> links or open attachments unless you can confirm the sender and know the
> content is safe.
>=20
>=20
>=20
> On Thu, Oct 05, 2023 at 10:25:08PM +0000, Kiyanovski, Arthur wrote:
> > > -----Original Message-----
> > > From: Justin Stitt <justinstitt@google.com>
> > > Sent: Thursday, October 5, 2023 3:56 AM
> > > To: Agroskin, Shay <shayagr@amazon.com>; Kiyanovski, Arthur
> > > <akiyano@amazon.com>; Arinzon, David <darinzon@amazon.com>; Dagan,
> > > Noam <ndagan@amazon.com>; Bshara, Saeed <saeedb@amazon.com>;
> David
> > > S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> > > Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > hardening@vger.kernel.org; Justin Stitt <justinstitt@google.com>
> > > Subject: [EXTERNAL] [PATCH] net: ena: replace deprecated strncpy
> > > with strscpy
> > >
> > > CAUTION: This email originated from outside of the organization. Do
> > > not click links or open attachments unless you can confirm the
> > > sender and know the content is safe.
> > >
> > >
> > >
> > > `strncpy` is deprecated for use on NUL-terminated destination
> > > strings [1] and as such we should prefer more robust and less ambiguo=
us
> string interfaces.
> > >
> > > NUL-padding is not necessary as host_info is initialized to
> > > `ena_dev-
> > > >host_attr.host_info` which is ultimately zero-initialized via
> > > alloc_etherdev_mq().
> > >
> > > A suitable replacement is `strscpy` [2] due to the fact that it
> > > guarantees NUL- termination on the destination buffer without
> unnecessarily NUL-padding.
> > >
> > > Link:
> > > https://www.kernel.org/doc/html/latest/process/deprecated.html#strnc
> > > py-on-
> > > nul-terminated-strings [1]
> > > Link:
> > > https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.ht
> > > ml
> > > [2]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > Note: build-tested only.
> > > ---
> > >  drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > > b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > > index f955bde10cf9..3118a617c9b6 100644
> > > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > > @@ -3276,8 +3276,8 @@ static void ena_config_host_info(struct
> > > ena_com_dev *ena_dev, struct pci_dev *pd
> > >         strscpy(host_info->kernel_ver_str, utsname()->version,
> > >                 sizeof(host_info->kernel_ver_str) - 1);
> > >         host_info->os_dist =3D 0;
> > > -       strncpy(host_info->os_dist_str, utsname()->release,
> > > -               sizeof(host_info->os_dist_str) - 1);
> > > +       strscpy(host_info->os_dist_str, utsname()->release,
> > > +               sizeof(host_info->os_dist_str));
> > >         host_info->driver_version =3D
> > >                 (DRV_MODULE_GEN_MAJOR) |
> > >                 (DRV_MODULE_GEN_MINOR <<
> > > ENA_ADMIN_HOST_INFO_MINOR_SHIFT) |
> > >
> > > ---
> > > base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> > > change-id:
> > > 20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-
> > > 6c4804466aa7
> > >
> > > Best regards,
> > > --
> > > Justin Stitt <justinstitt@google.com>
> > >
> >
> > Thanks for submitting this change.
> >
> > The change looks good but the sentence "NUL-padding is not necessary
> > as host_info is initialized to `ena_dev->host_attr.host_info` which is
> > ultimately zero-initialized via alloc_etherdev_mq()." is inaccurate.
> >
> > host_info allocation is done in ena_com_allocate_host_info() via
> > dma_alloc_coherent() and is not zero initialized by alloc_etherdev_mq()=
.
> >
> > I looked at both the documentation of dma_alloc_coherent() in
> > https://www.kernel.org/doc/Documentation/DMA-API.txt
> > as well as the code itself, and (maybe I'm wrong but) I didn't see
> > 100% guarantees the that the memory is zero-initialized.
> >
> > However zero initialization of the destination doesn't matter in this
> > case, because strscpy() guarantees a NULL termination.
>=20
> If this is in DMA memory, should the string buffer be %NUL-padded? (Or is=
 it
> consumed strictly as a %NUL-terminated string?)
>=20
> -Kees
>=20
> --
> Kees Cook

No need for NULL-padding, It is consumed strictly as a NULL-terminated stri=
ng

Thanks,
Arthur Kiyanovski
