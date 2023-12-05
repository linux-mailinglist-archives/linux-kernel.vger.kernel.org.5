Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E249804DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbjLEJ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjLEJ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C66410C0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701768540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWSbeQkndxR8pOH1jrEtRfCn62USiBxMT3pXbunoD3Q=;
        b=B8XqXBQ+c0pJHMG8Z5IevmGWYnAcAyhn+/CtfAZeu5FnF60y86dUekuoQS3iWwQ8DoMEYV
        ZGPdOj4FBOVVw3o7CpPAVBozPgULs6Z+1jWcdmZdN5fqnhBp9SbypezcOTsHwaL+irE+FS
        s37vdAYE2tLhzKMFkEDc+XB34b+mjts=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-aixiTFyWOoCC-pJRViDbQg-1; Tue, 05 Dec 2023 04:28:59 -0500
X-MC-Unique: aixiTFyWOoCC-pJRViDbQg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5450c83aa5dso667826a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768538; x=1702373338;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWSbeQkndxR8pOH1jrEtRfCn62USiBxMT3pXbunoD3Q=;
        b=PvtCAlMw1rngXg3Gwq1WD6bcw1Ofouwxd+iIK++yXqjXdOKMTR+UdxVSIeD+dbptnr
         Cvqj12jst4oDPxR3CRtTfSmOwl7Nc1fuRj/IS1p2gZ86VBegpoo1MM7Kdg4GkYjepTWS
         331VAat9tEED1C/p64mlGC5B9qUyyLGGN1MmanJXw2at+YGGHdPHXq7kFWDSI/F9JOk4
         erxw+5JNMtvv9XSEOeXeUEUtkXIA/jpSYJ7FEZjJpIh/V3NI2Q5pjlk75VtpAlqm1nGP
         vDdhaBOyuyIhiUvanIrNEDRxxv0jJPHkh4t1mMXYNBNUdyZVT7E+E98Gm892kCBrZlzc
         0svw==
X-Gm-Message-State: AOJu0YwXqJTkNdrruj8lBGqH2+wj4CxG3sl6CLkEeB4ktJEOp8/f2P1o
        nc+pFCwfi0iT7f2/G4aFrCelr7ZsJKyuozQhh2egJz7of5p4OBjMpVdARdB+LzGwP/CH9fuUcgJ
        GCOpV2ey1h0JnG1UI3Cq2YAC9
X-Received: by 2002:a17:906:3b96:b0:a1c:87a2:c183 with SMTP id u22-20020a1709063b9600b00a1c87a2c183mr484065ejf.5.1701768538138;
        Tue, 05 Dec 2023 01:28:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAbf9T1cl753dwNJrA4r4f5Cd5wzRLvS/Q1MW1BiOQwtPcGxLNeQjBeV3vMyTRD3tSBQzs7w==
X-Received: by 2002:a17:906:3b96:b0:a1c:87a2:c183 with SMTP id u22-20020a1709063b9600b00a1c87a2c183mr484053ejf.5.1701768537730;
        Tue, 05 Dec 2023 01:28:57 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090636d400b009dd98089a48sm6382410ejc.43.2023.12.05.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:28:57 -0800 (PST)
Message-ID: <d657f059d384419fe4df02580a4af9cf69e0e9c2.camel@redhat.com>
Subject: Re: [PATCH net-next v6 1/6] ptp: clockmatrix: support 32-bit
 address space
From:   Paolo Abeni <pabeni@redhat.com>
To:     Simon Horman <horms@kernel.org>, Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Date:   Tue, 05 Dec 2023 10:28:56 +0100
In-Reply-To: <20231205092429.GS50400@kernel.org>
References: <PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
         <20231205092429.GS50400@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-05 at 09:24 +0000, Simon Horman wrote:
> On Thu, Nov 30, 2023 at 01:46:29PM -0500, Min Li wrote:
> > From: Min Li <min.li.xe@renesas.com>
> >=20
> > We used to assume 0x2010xxxx address. Now that
> > we need to access 0x2011xxxx address, we need
> > to support read/write the whole 32-bit address space.
> >=20
> > Signed-off-by: Min Li <min.li.xe@renesas.com>
>=20
> ...
>=20
> > diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatri=
x.c
> > index f6f9d4adce04..f8556627befa 100644
> > --- a/drivers/ptp/ptp_clockmatrix.c
> > +++ b/drivers/ptp/ptp_clockmatrix.c
> > @@ -41,8 +41,8 @@ module_param(firmware, charp, 0);
> >  static int _idtcm_adjfine(struct idtcm_channel *channel, long scaled_p=
pm);
> > =20
> >  static inline int idtcm_read(struct idtcm *idtcm,
> > -			     u16 module,
> > -			     u16 regaddr,
> > +			     u32 module,
> > +			     u32 regaddr,
> >  			     u8 *buf,
> >  			     u16 count)
> >  {
> > @@ -50,8 +50,8 @@ static inline int idtcm_read(struct idtcm *idtcm,
> >  }
> > =20
> >  static inline int idtcm_write(struct idtcm *idtcm,
> > -			      u16 module,
> > -			      u16 regaddr,
> > +			      u32 module,
> > +			      u32 regaddr,
> >  			      u8 *buf,
> >  			      u16 count)
> >  {
>=20
> Hi Min Li,
>=20
> My understanding of Paolo's review of v5 was that it would be cleaner to:
>=20
> 1. Leave the type of the module parameter as u16
> 2. Update the type of the regaddr parameter to u32

[almost over the air conflict here ;) ]

I think the module parameter as u32 is needed, as later macro
definitions will leverage that.

>=20
> And...
>=20
> ...
>=20
> > @@ -553,11 +554,11 @@ static int _sync_pll_output(struct idtcm *idtcm,
> >  	val =3D SYNCTRL1_MASTER_SYNC_RST;
> > =20
> >  	/* Place master sync in reset */
> > -	err =3D idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
> > +	err =3D idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
> >  	if (err)
> >  		return err;
> > =20
> > -	err =3D idtcm_write(idtcm, 0, sync_ctrl0, &sync_src, sizeof(sync_src)=
);
> > +	err =3D idtcm_write(idtcm, sync_ctrl0, 0, &sync_src, sizeof(sync_src)=
);
> >  	if (err)
> >  		return err;
> > =20
>=20
> ... avoid the need for changes like the two above.

This part is correct/what I meant ;)

Cheers,

Paolo

