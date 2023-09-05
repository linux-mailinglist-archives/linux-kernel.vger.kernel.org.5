Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75C2792525
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjIEQBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354333AbjIEKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C8519B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693910790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDobuVmsHf6VbTCDGPgqLnhe8HEWnYtAH71GRAdCw84=;
        b=Z07qXoNbzkJOBA5N3RmnBjieYhyU0Jt2ujSCwEhQjCvPAN9sVPwYJ/6gRgSOGwuuCCOLwr
        73kV0R9TqSOKBJWDrJd9BBnxnLOc1OSXxsrBuiOnAeh1ww1FPHxP3ZZuBNznug5jduAD3o
        z+dLmae1oITSHRwWQrC8ee10RtkOdcc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-7rejvRzKNzGk5yDPopRCpQ-1; Tue, 05 Sep 2023 06:46:29 -0400
X-MC-Unique: 7rejvRzKNzGk5yDPopRCpQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1c4506e1eso39121766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 03:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693910788; x=1694515588;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDobuVmsHf6VbTCDGPgqLnhe8HEWnYtAH71GRAdCw84=;
        b=HviZ/PdQcoKmqCivw6MZzGYG+syGSFNGqWDJ3bC7H3Et9AZYVhtgQnBKayuwzoz0Um
         THH5uIuu7hywdLSFWUNswuNVkaecS4H7hihInhppXuWWCr0y7liHxbmF+HbA2U7QwJIY
         cXF1EZTbw5JVHRbtzkiyjrTpnfhcDXczkmyOy3ET+se8pjBMkaAG3pE8CS11zdZ7S97r
         85GXUqyhkcDRzcytN4NDZ1AsOEpJSZcyAnmEknsUSZpgdYQF7q7WPlcUJrNglXdKFx6t
         sNQUMsue+/4ebG2noMzX2Wr2Hy0EupHaeqowDHUYxy19OBi+Nh2S91oxbS/XZzfoNK3X
         MyEw==
X-Gm-Message-State: AOJu0Yz9TG5wR36rPxWvXLCFq3ZdbF5HAM3Yb8o7h8U1cx9veXNcnBtJ
        tmAxP2pTexU+1t9fZAdp2Zk5S+HFKD/E4UA5WwS9rHuLlUV8Au9VerZOa8xznqvNp0SAq1DOELS
        ZthrPPKaznHlTg2nFzmUdhLcYd+vzDkfu
X-Received: by 2002:a17:906:1d9:b0:9a5:ce62:6e1a with SMTP id 25-20020a17090601d900b009a5ce626e1amr9074525ejj.1.1693910788542;
        Tue, 05 Sep 2023 03:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVP0e7U+C7DkOymIDEKc3tYHSdF8TqbQ0M/RyNmnZKDwX7FgEegi976Dw6DLG26KofkHwMIg==
X-Received: by 2002:a17:906:1d9:b0:9a5:ce62:6e1a with SMTP id 25-20020a17090601d900b009a5ce626e1amr9074509ejj.1.1693910788209;
        Tue, 05 Sep 2023 03:46:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id qw17-20020a170906fcb100b0099d798a6bb5sm7469193ejb.67.2023.09.05.03.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 03:46:27 -0700 (PDT)
Message-ID: <c1437313a3fea94a66d33f7bf97f363c77838359.camel@redhat.com>
Subject: Re: [PATCH v4] drivers/net: process the result of hdlc_open() and
 add call of hdlc_close() in uhdlc_close()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexandra Diupina <adiupina@astralinux.ru>,
        Zhao Qiang <qiang.zhao@nxp.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Date:   Tue, 05 Sep 2023 12:46:26 +0200
In-Reply-To: <1005f190-8c03-bb5d-214c-c7fca9dd876b@csgroup.eu>
References: <20230904123130.14099-1-adiupina@astralinux.ru>
         <1005f190-8c03-bb5d-214c-c7fca9dd876b@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-04 at 17:03 +0000, Christophe Leroy wrote:
>=20
> Le 04/09/2023 =C3=A0 14:31, Alexandra Diupina a =C3=A9crit=C2=A0:
> > diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_h=
dlc.c
> > index 47c2ad7a3e42..fd999dabdd39 100644
> > --- a/drivers/net/wan/fsl_ucc_hdlc.c
> > +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> > @@ -34,6 +34,8 @@
> >   #define TDM_PPPOHT_SLIC_MAXIN
> >   #define RX_BD_ERRORS (R_CD_S | R_OV_S | R_CR_S | R_AB_S | R_NO_S | R_=
LG_S)
> >  =20
> > +static int uhdlc_close(struct net_device *dev);
> > +
> >   static struct ucc_tdm_info utdm_primary_info =3D {
> >   	.uf_info =3D {
> >   		.tsa =3D 0,
> > @@ -731,7 +733,9 @@ static int uhdlc_open(struct net_device *dev)
> >   		napi_enable(&priv->napi);
> >   		netdev_reset_queue(dev);
> >   		netif_start_queue(dev);
> > -		hdlc_open(dev);
> > +
> > +		int rc =3D hdlc_open(dev);
>=20
> Do not mix declarations and code. Please put all declaration at the top=
=20
> of the block.
>=20
> > +		return rc =3D=3D 0 ? 0 : (uhdlc_close(dev), rc);
> >   	}
>=20
> That's not easy to read.
>=20
> I know that's more changes, but I'd prefer something like:
>=20
> static int uhdlc_open(struct net_device *dev)
> {
> 	u32 cecr_subblock;
> 	hdlc_device *hdlc =3D dev_to_hdlc(dev);
> 	struct ucc_hdlc_private *priv =3D hdlc->priv;
> 	struct ucc_tdm *utdm =3D priv->utdm;
> 	int rc;
>=20
> 	if (priv->hdlc_busy !=3D 1)
> 		return 0;
>=20
> 	if (request_irq(priv->ut_info->uf_info.irq,
> 			ucc_hdlc_irq_handler, 0, "hdlc", priv))
> 		return -ENODEV;
>=20
> 	cecr_subblock =3D ucc_fast_get_qe_cr_subblock(
> 				priv->ut_info->uf_info.ucc_num);
>=20
> 	qe_issue_cmd(QE_INIT_TX_RX, cecr_subblock,
> 		     QE_CR_PROTOCOL_UNSPECIFIED, 0);
>=20
> 	ucc_fast_enable(priv->uccf, COMM_DIR_RX | COMM_DIR_TX);
>=20
> 	/* Enable the TDM port */
> 	if (priv->tsa)
> 		qe_setbits_8(&utdm->si_regs->siglmr1_h, 0x1 << utdm->tdm_port);
>=20
> 	priv->hdlc_busy =3D 1;
> 	netif_device_attach(priv->ndev);
> 	napi_enable(&priv->napi);
> 	netdev_reset_queue(dev);
> 	netif_start_queue(dev);
>=20
> 	rc =3D hdlc_open(dev);
> 	if (rc)
> 		uhdlc_close(dev);
>=20
> 	return rc;
> }

I agree the above is more readable, but I don't think the whole
refactor is not worthy for a -net fix. I think simply rewriting the
final statements as:

		rc =3D hdlc_open(dev);
		if (rc)
			uhdlc_close(dev);

		return rc;=09

would be good for -net.
=20
> >   	return 0;
> > @@ -824,6 +828,8 @@ static int uhdlc_close(struct net_device *dev)
> >   	netdev_reset_queue(dev);
> >   	priv->hdlc_busy =3D 0;
> >  =20
> > +	hdlc_close(dev);
> > +
> >   return 0;
> >    =20
>=20
> And while you are looking at the correctness of this code, is it sure=20
> that uhdlc_open() cannot be called twice in parallele ?
> If it can be called in parall=C3=A8le I think the "if (priv->hdlc_busy !=
=3D 1)"=20
> should be replaced by something using cmpxchg()

That part is safe, ndo_open() is invoked under the rtnl lock.

The other comments are IMHO relevant, @Alexandra: please address them.

Thanks!

Paolo

