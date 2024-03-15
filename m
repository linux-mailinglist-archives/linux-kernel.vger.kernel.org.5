Return-Path: <linux-kernel+bounces-104074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4773F87C8A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31401F22FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D59F101F2;
	Fri, 15 Mar 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="OIuts2m2"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043012B71
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481892; cv=none; b=mGsS22IfQ3loFM/9mI0pUmARhy3iBBpIvKG9xgVeoRgE6dIEXaD3NmT2893l5vbp2693MIxh0x1+Nq7US5unMYHRVj7TEKeDyIChlP5rsKmEBKVrWpQw7mjCjERDHHQqoxnIp2mx7imxZMZ6BONHz/Ny62HNZoZOfs5bHxyreNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481892; c=relaxed/simple;
	bh=A/81nqGsGt73GISU0dF+EkR2mLtnRJReyWNTwcTSWz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpZSTUePQAD3yn2CzdPS2PG1rF+MHK1c2+iOOpZMamYz5dDGW/gbfL/AxLgljXbehtXIwzwsQIxdyS+9jUgWt3me+2yXFvucK7nqIQhuj7KDXDgbYNl0KkMa73mTyl6QahvOL6TknAPWjGulp0nRRbtdrC0xxrFJntnIl1GK4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIuts2m2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-428405a0205so149581cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 22:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710481889; x=1711086689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHDQcVf2C6y8hW1gdfqpTODbSAP0JHIS+G1G4PTmCbA=;
        b=OIuts2m2wtty1AlSBq8L2OBiikY7V8ijFJWdoVXJOAybnajTagRf7MzmSfKTvX/u8a
         QpX9mA/hSExxi5Yncj6jN2e4Tuas+GZ0vMl4odvjSA8nJx1zrh5Sx0DsmcHAX9JA4FGb
         Fvp8pR2sCxZWVkGstK86zAhlen6x/wBsiKiR2MAfwd5LjaMhuDIxrqWhf49nzJIx91pk
         pZBm0nyISw4fsEkF51w9DR0+AVpe8WHCP7/Z1xfA2kATkACJIbheGOAUh1M/cijzWogo
         AfMrByY4ptTfHV4VhF8aHL26lr9t2X9O+PqBzoRuwxBo4o8P3CjwqMvj37jEnpkwTxZW
         0FiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710481889; x=1711086689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHDQcVf2C6y8hW1gdfqpTODbSAP0JHIS+G1G4PTmCbA=;
        b=tBEAHNXffw1cuj33TQgyYKpQElZXvSuMTZq5upoBoIt3ck0jPl7eQjKr9ZnDSLzqpD
         22dzglnJn569o+7iSzaYzMbEyuCRg70PieLa8eFDStW7Z5VLUcp56DBSzW3khmKWMgvu
         +shmxy1m5J6Gf4uvoXEv85GXn9Qjd9lAElA71WmEClWTOYPmqFWwH48+86oqGbV2H6Mn
         ntJmIQn2tdu63SC4Hv6wgJyfo34iPXNe3sXd+pbpDi3J3syzH2JQM2Qk5my2dVgjSG77
         IhHAXDGVyA96TsQG3KJ0Dr9mEgOd9qlV15AgtqKNjDiQnNy7aqPfE1ywQsgduPSE4SqH
         g3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAkaTxXxmShWjpg/TgmMUT5eS1+ybypH9+95wvbgJRD42gBMdGGQSe3/226adWWg3uMmXGaW0epPAajkqCrMJJhUtmfxqXH7HmcNer
X-Gm-Message-State: AOJu0Yz2Pf7JyT3kqUg71br6MMOpvWImP7JqtIUwfpGx3nQDNOl9QtXb
	fkiq1Tt9Iw+ESu6wU+RStwgQHDFGLp/nvm0dzIZ9DNFitDQydBSta/jzrXFS1Iqr+VQNOmciyjS
	IB0B4ASxZEVNr8wVL1WaH/hT4aBuZdBQ88GMt
X-Google-Smtp-Source: AGHT+IHVVYu7hkZnD5KhAz/hheqXyXO0hGEa5ngxa9jJy+T/Gp8PiPKSDnaGqcU0AEjlaxo7NoG6bv97dmdPx7FaIdg=
X-Received: by 2002:ac8:5e97:0:b0:430:9ee1:a8 with SMTP id r23-20020ac85e97000000b004309ee100a8mr397654qtx.3.1710481888872;
 Thu, 14 Mar 2024 22:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224052436.3552333-1-saravanak@google.com>
 <CAMuHMdWhm1WaX3X3P7tyB+e-rX=iwkwm8LxE3=gfHzJ1umhsFg@mail.gmail.com>
 <CAGETcx_g5fdeSibDv8C2S4WpVekMvCQ9srwR3BwCzCU2z3kk-g@mail.gmail.com> <CAMuHMdV-P9nt1htpn-+jicUMA_JsOpf6mszajP9qORNweicLLw@mail.gmail.com>
In-Reply-To: <CAMuHMdV-P9nt1htpn-+jicUMA_JsOpf6mszajP9qORNweicLLw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 14 Mar 2024 22:50:52 -0700
Message-ID: <CAGETcx9nohVEisxoBDB7Q6eVUv3mx7W50g-Ujx+L-iN=hcKGrw@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 1:46=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Saravana,
>
> On Thu, Mar 14, 2024 at 2:48=E2=80=AFAM Saravana Kannan <saravanak@google=
com> wrote:
> > On Thu, Feb 29, 2024 at 2:11=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Sat, Feb 24, 2024 at 6:25=E2=80=AFAM Saravana Kannan <saravanak@go=
ogle.com> wrote:
> > > > Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Impr=
ove
> > > > finding the supplier of a remote-endpoint property") due to a last =
minute
> > > > incorrect edit of "index !=3D0" into "!index". This patch fixes it =
to be
> > > > "index > 0" to match the comment right next to it.
> > > >
> > > > Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > > Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> > > > Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of=
 a remote-endpoint property")
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/of/property.c
> > > > +++ b/drivers/of/property.c
> > > > @@ -1304,7 +1304,7 @@ static struct device_node *parse_remote_endpo=
int(struct device_node *np,
> > > >                                                  int index)
> > > >  {
> > > >         /* Return NULL for index > 0 to signify end of remote-endpo=
ints. */
> > > > -       if (!index || strcmp(prop_name, "remote-endpoint"))
> > > > +       if (index > 0 || strcmp(prop_name, "remote-endpoint"))
> > > >                 return NULL;
> > > >
> > > >         return of_graph_get_remote_port_parent(np);
> > > > --
> > > > 2.44.0.rc0.258.g7320e95886-goog
> > >
> > > After this, the "Fixed dependency cycle" messages I reported to be
> > > gone in [1] are back.
> > >
> > > In fact, they are slightly different, and there are now even more of =
them:
> > >
> > > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef7000/ports/port@1/endpoint@0
> > > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef6000/ports/port@1/endpoint@0
> > > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef5000/ports/port@1/endpoint@0
> > > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef4000/ports/port@1/endpoint@0
> > > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef3000/ports/port@1/endpoint@0
> > > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef2000/ports/port@1/endpoint@0
> > > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef1000/ports/port@1/endpoint@0
> > > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef0000/ports/port@1/endpoint@0
> > > -platform feaa0000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef3000/ports/port@1/endpoint@2
> > > -platform feaa0000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef2000/ports/port@1/endpoint@2
> > > -platform feaa0000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef1000/ports/port@1/endpoint@2
> > > -platform feaa0000.csi2: Fixed dependency cycle(s) with
> > > /soc/video@e6ef0000/ports/port@1/endpoint@2
> > > -platform fead0000.hdmi: Fixed dependency cycle(s) with
> > > /soc/sound@ec500000/ports/port@1/endpoint
> > > -platform feae0000.hdmi: Fixed dependency cycle(s) with
> > > /soc/sound@ec500000/ports/port@2/endpoint
> > > -platform feb00000.display: Fixed dependency cycle(s) with
> > > /soc/hdmi@feae0000/ports/port@0/endpoint
> > > -platform feb00000.display: Fixed dependency cycle(s) with
> > > /soc/hdmi@fead0000/ports/port@0/endpoint
> > > -platform hdmi0-out: Fixed dependency cycle(s) with
> > > /soc/hdmi@fead0000/ports/port@1/endpoint
> > > -platform hdmi1-out: Fixed dependency cycle(s) with
> > > /soc/hdmi@feae0000/ports/port@1/endpoint
> > > -platform vga-encoder: Fixed dependency cycle(s) with /vga/port/endpo=
int
> > > -platform vga-encoder: Fixed dependency cycle(s) with
> > > /soc/display@feb00000/ports/port@0/endpoint
> > > +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
aa0000
> > > +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
aa0000
> > > +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
aa0000
> > > +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
aa0000
> > > +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef4000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef5000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef6000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef7000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fe=
ae0000
> > > +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fe=
ad0000
> > > +platform ec500000.sound: Fixed dependency cycle(s) with
> > > /soc/i2c@e6510000/codec@10
> > > +platform e6ef7000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef6000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef5000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef4000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
a80000
> > > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef7000
> > > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef6000
> > > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef5000
> > > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef4000
> > > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef3000
> > > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef2000
> > > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef1000
> > > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef0000
> > > +platform fea80000.csi2: Fixed dependency cycle(s) with
> > > /soc/i2c@e66d8000/video-receiver@70
> > > +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
aa0000
> > > +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
aa0000
> > > +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
aa0000
> > > +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fe=
aa0000
> > > +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef3000
> > > +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef2000
> > > +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef1000
> > > +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6=
ef0000
> > > +platform feaa0000.csi2: Fixed dependency cycle(s) with
> > > /soc/i2c@e66d8000/video-receiver@70
> > > +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fe=
ad0000
> > > +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/sound@ec=
500000
> > > +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/display@=
feb00000
> > > +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fe=
ae0000
> > > +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/sound@ec=
500000
> > > +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/display@=
feb00000
> > > +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/display@=
feb00000
> > > +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/display@=
feb00000
> > > +platform feb00000.display: Fixed dependency cycle(s) with /soc/hdmi@=
feae0000
> > > +platform feb00000.display: Fixed dependency cycle(s) with /soc/hdmi@=
fead0000
> > > +platform cvbs-in: Fixed dependency cycle(s) with
> > > /soc/i2c@e66d8000/video-receiver@70
> > > +platform hdmi-in: Fixed dependency cycle(s) with
> > > /soc/i2c@e66d8000/video-receiver@70
> > > +platform fead0000.hdmi: Fixed dependency cycle(s) with /hdmi0-out
> > > +platform hdmi0-out: Fixed dependency cycle(s) with /soc/hdmi@fead000=
0
> > > +platform feae0000.hdmi: Fixed dependency cycle(s) with /hdmi1-out
> > > +platform hdmi1-out: Fixed dependency cycle(s) with /soc/hdmi@feae000=
0
> > > +platform vga: Fixed dependency cycle(s) with /vga-encoder
> > > +platform feb00000.display: Fixed dependency cycle(s) with /vga-encod=
er
> > > +platform vga-encoder: Fixed dependency cycle(s) with /vga
> > > +platform vga-encoder: Fixed dependency cycle(s) with /soc/display@fe=
b00000
> > >
> > > -i2c 2-0010: Fixed dependency cycle(s) with
> > > /soc/sound@ec500000/ports/port@0/endpoint
> > > +platform ec500000.sound: Fixed dependency cycle(s) with
> > > /soc/i2c@e6510000/codec@10
> > >
> > > -i2c 4-0070: Fixed dependency cycle(s) with
> > > /soc/csi2@fea80000/ports/port@0/endpoint
> > > -i2c 4-0070: Fixed dependency cycle(s) with
> > > /soc/csi2@feaa0000/ports/port@0/endpoint
> > > -i2c 4-0070: Fixed dependency cycle(s) with /hdmi-in/port/endpoint
> > > -i2c 4-0070: Fixed dependency cycle(s) with /cvbs-in/port/endpoint
> > > +platform feaa0000.csi2: Fixed dependency cycle(s) with
> > > /soc/i2c@e66d8000/video-receiver@70
> > > +platform fea80000.csi2: Fixed dependency cycle(s) with
> > > /soc/i2c@e66d8000/video-receiver@70
> > > +i2c 4-0070: Fixed dependency cycle(s) with /soc/csi2@fea80000
> > > +i2c 4-0070: Fixed dependency cycle(s) with /soc/csi2@feaa0000
> > >
> > > I guess all of that is expected?
> >
> > Hi Geert,
> >
> > Greg has picked up my "post-init-providers" series in his driver core.
>
> You mean https://lore.kernel.org/all/20240305050458.1400667-2-saravanak@g=
oogle.com/?

Yes.

>
> > Once you pull that in, you should be able to use the
> > post-init-providers property to break these cycles. Basically treat it
> > like any other supplier binding, but use it to mark the link in the
> > cycle that's not real. For the remote-endpoints case, you need to list
> > property at the device level. Not the endpoint, port or ports nodes.
> >
> > Once you add this property, you should see an increase in the number
> > of device links that are present after all device probing is done.
> > Also, a bunch of existing device links should get converted from
> > sync_state_only device links to normal managed device links. Meaning,
> > the sync_state_only file under those /class/devlink/<device-link-x>/
> > folder should change from "1" to "0".
> >
> > If that's what you see and it works, then go ahead and send out a
> > patch so that the boards you care about have a more
> > deterministic/stable probe/suspend/resume ordering.
>
> You mean we have to add additional properties to the DTS?

Yes.

> What about compatibility with old DTBs?

It'll continue working like today.

> Where are the DT bindings for "post-init-providers"?
> I see it was part of earlier submissions, but I cannot find any evidence
> they have ever been accepted by the DT maintainers?

It's been submitted to dt-schema. Rob is okay with it. So it'll land.

You don't need to merge your patches till it lands. But it'll be good
to test it for your case and confirm it makes things better for you.

-Saravana

>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

