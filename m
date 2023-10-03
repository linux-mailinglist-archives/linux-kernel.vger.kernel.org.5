Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FFB7B673A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjJCLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjJCLIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DE99E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696331260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkX3U2XtLh0SwP2dw+8InxKx4ja/2ylF1rIlz3maCoQ=;
        b=OmlzaQZ0AUv3PHX9T/5OgMCdAJRnlSrMDyH23FHXzNF5d4UCVpVrjOJz9ZBnDkIVHMA1XG
        5je1Wz/DgZqJRFpsJPG/AHm/pvwz/XXn0XL6hcBeEBoLE0PsX9Qzim1DBynIEy/8xSe5N/
        YYRtC98heEjoquAYVGa3X96e2l4AVVI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-KpuWuxytOyyBWZWalYlJpQ-1; Tue, 03 Oct 2023 07:07:39 -0400
X-MC-Unique: KpuWuxytOyyBWZWalYlJpQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b2d2d8f9e0so13922166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 04:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331258; x=1696936058;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkX3U2XtLh0SwP2dw+8InxKx4ja/2ylF1rIlz3maCoQ=;
        b=qSVHdwE+kcCtRRqY3w+GPRWOWGRT1IQUpEEN7pdeS881bo8s5q5qJMTiThC7GjLIGR
         FZmypl89//GdVXDT/mcgAkdLrdyMSNzTc0Cri5mCWLg/OnK4UpKDdAdlqALvwQXEhBXC
         SNJpwPpt7YdUMRGVHMACgjWNd3szWofJeHTm2pCBvG9C5dChvoTm/kpLBTGHcUXsQfOg
         t0L94TECP8YZ3PrWav3OqDxnbY+AnLxpmI3x/yacCdmUJ1atXvpJwnHky8aRVEvde30X
         R+Jiwpy72E93elcvGXK+2DBDrEMk0XnODLownXq1BOBSoNTXvwVL3ViJWZQYJ3iuh+VV
         Bh/Q==
X-Gm-Message-State: AOJu0YxLA8ntWQkga+O0mOozPjjrxtPfNb4QWwlQEoP0PQggQR2q1ILG
        YHHHch0R4vNXAEKtA62m63I2OiBorp7/ksg4ikICzhxbn2YipGcJvu1JRx0HgyJrHPdo/fMV/ia
        +dHI2phj3AWomJhRJ9Tz34dMx
X-Received: by 2002:a17:906:105d:b0:9ae:5868:c8c9 with SMTP id j29-20020a170906105d00b009ae5868c8c9mr11024443ejj.0.1696331258317;
        Tue, 03 Oct 2023 04:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkhlAIXYFVb2EVm+9XNesx6S7O3/U021Az3cUkjHDMO5/4Ow9uAXi1UHhVA83zO+sTrcIO6w==
X-Received: by 2002:a17:906:105d:b0:9ae:5868:c8c9 with SMTP id j29-20020a170906105d00b009ae5868c8c9mr11024422ejj.0.1696331257909;
        Tue, 03 Oct 2023 04:07:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id op13-20020a170906bced00b0098921e1b064sm875546ejb.181.2023.10.03.04.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:07:37 -0700 (PDT)
Message-ID: <018982972b43bdac3f6d50bde03287282364e357.camel@redhat.com>
Subject: Re: [PATCH] fjes: Add missing check for vzalloc
From:   Paolo Abeni <pabeni@redhat.com>
To:     Petr Machata <petrm@nvidia.com>, Chen Ni <nichen@iscas.ac.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        izumi.taku@jp.fujitsu.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Oct 2023 13:07:35 +0200
In-Reply-To: <87r0mms4a5.fsf@nvidia.com>
References: <20230925085318.1228225-1-nichen@iscas.ac.cn>
         <87r0mms4a5.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-25 at 16:40 +0200, Petr Machata wrote:
> Chen Ni <nichen@iscas.ac.cn> writes:
>=20
> > Because of the potential failure of the vzalloc(), the hw->hw_info.trac=
e
> > could be NULL.
> > Therefore, we need to check it and return -ENOMEM in order to transfer
> > the error.
> >=20
> > Fixes: b6ba737d0b29 ("fjes: ethtool -w and -W support for fjes driver")
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > ---
> >  drivers/net/fjes/fjes_hw.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/net/fjes/fjes_hw.c b/drivers/net/fjes/fjes_hw.c
> > index 704e949484d0..3a06a3cf021d 100644
> > --- a/drivers/net/fjes/fjes_hw.c
> > +++ b/drivers/net/fjes/fjes_hw.c
> > @@ -330,6 +330,9 @@ int fjes_hw_init(struct fjes_hw *hw)
> >  	ret =3D fjes_hw_setup(hw);
> > =20
> >  	hw->hw_info.trace =3D vzalloc(FJES_DEBUG_BUFFER_SIZE);
> > +	if (!hw->hw_info.trace)
> > +		return -ENOMEM;
> > +
>=20
> I'm not sure, but shouldn't this call fjes_hw_cleanup() to mirror the
> setup() above? Also only if ret=3D0 I suppose.

Yes, that looks needed, or memory will be leaked. Additionally it looks
like the rest of the driver handles correctly the case where
hw_info.trace is NULL, so this fix is likely not needed at all.

Cheers,

Paolo

