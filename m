Return-Path: <linux-kernel+bounces-102701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246EA87B631
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28E228649E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC94683;
	Thu, 14 Mar 2024 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ypfsvP9o"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D71C01
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710380932; cv=none; b=bYJlQDH41jW3ecgqElUZHrR7tpetsj+1cRSBjVTCjn3xgbJRno3Lb0ByAsU63HFbox8aM5RCP670SC3i+6yGhbIS1vzLve+RyHlnocwUDjw1W+hczYYw7dExRW46LaR1CNHO7YzvFy4HaoKJDFq6LwvnmmRLgU3Fuvgl6GMtzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710380932; c=relaxed/simple;
	bh=DemfoqH6NUl8ANWgqrarNGT/fY3gONhfvTSJTKH6ekM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RW/tF1EymI0OCVPRSzb/4ixxMAt7rZQVcMACmTKIR71wxE3kJV7tL1qwugqtxnDj077uqv+mHY6oPd7O0Ct4jd+4YLCzXbpTsMfQmgjTlFLAXvXFZ/ukhi0s/hu2CyLb9DPjbDvXuI6l6QQ8a2TjS+kM1UmnY2yqeVD8ezNixZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ypfsvP9o; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso2529a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710380928; x=1710985728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5efaAgWuBTuJY+okAmQC7KnwocCXtcKLJHyMVMEVdw=;
        b=ypfsvP9on/2KerdwojS+ZFYlKTE26LHbhkRqyMXjscSotWZFKH/s+wo3wGPKRGSL7L
         XTYnU1OM+j0i8jbilICQCLtqZA9jzexwYFOcGfBXNXNNcz8TIwRNMWbrHw9OX81usiDe
         sNzXYTsnegYTxApPx5H7kz5h0YrM2r2KINKYBKbVSpnS37UQgzN1azntSskwWRHmFP+Z
         ifKP23CPaPKeSIjzhdnB0ng+RY1JLLlYS7FvvVDg1ruA+O6Lha9SlRcO/0jx7w2rtCa5
         Axixg3LJavUT/rH24pDDwvIsC/0LcfHUsxlTMf2XNbgF4Evt9Y0+JXkFi2mUl6V468E2
         RbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710380928; x=1710985728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5efaAgWuBTuJY+okAmQC7KnwocCXtcKLJHyMVMEVdw=;
        b=wxS1e1dsgyIBUOCb0/KPVQupvhuhJalUVqkxtblzKb3M3zs/TgVZ5ZLieymgtqkwzz
         3uXSJWfPICUCZwPPBkmusV3C1iXj7t2mOLqtF3hekQ+5lwKMuRBs0pZbi1/p12djjj3r
         j5o/RaWxqTravwSLSymdw5WGMWHrwTnSR0Pn/fn9ZvCe5Z7vNPeasIu1W/L1CrSeOHQW
         WCeU9TRoBr511aTt49g0LwHlgC9P7KuYfIpiEfHfCqkavpaBPgB6moWnMS+Gay84LPGz
         2r3PkYor6qtw5JcRHIl0n8rQECcTmhpN2ltXotqCKOhxPCJyFX62tKBiARIKIlMaRoLN
         M30A==
X-Forwarded-Encrypted: i=1; AJvYcCXspPNrwZECuI81RuecjHJQkV2tPw74NMovhFwjTLlzCkupgeFt2jNuxkKhRQUyezjQsUAhuYW21eIyB65H35Gx2TWpBnFt528zEje7
X-Gm-Message-State: AOJu0YzZs9X7wtPrYRBhlLiy8dn/dh1P1W867JqP4W68dlbbyPs7WXfu
	mX9+AGpux/7dQN2TiIFTOQ+haQfpG9qe9Ad9OF3RFl2GByZ6MQ7Qje/GunTSl4gxsVAWtd4VZgH
	mSdqiJWQY5SReE3JqhvCCU2PKl83o+KcJcvCG
X-Google-Smtp-Source: AGHT+IGkqCTnZ22acpFRAP79ja7eFaJsqihoAQF1r9XTqnHmez8YYvhmspoLnDyk0QFGf+hXGF5v3epCPOLiyRWh6aQ=
X-Received: by 2002:aa7:df8e:0:b0:568:55db:8c69 with SMTP id
 b14-20020aa7df8e000000b0056855db8c69mr62818edy.4.1710380928394; Wed, 13 Mar
 2024 18:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224052436.3552333-1-saravanak@google.com> <CAMuHMdWhm1WaX3X3P7tyB+e-rX=iwkwm8LxE3=gfHzJ1umhsFg@mail.gmail.com>
In-Reply-To: <CAMuHMdWhm1WaX3X3P7tyB+e-rX=iwkwm8LxE3=gfHzJ1umhsFg@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 13 Mar 2024 18:48:09 -0700
Message-ID: <CAGETcx_g5fdeSibDv8C2S4WpVekMvCQ9srwR3BwCzCU2z3kk-g@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:11=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Saravana,
>
> On Sat, Feb 24, 2024 at 6:25=E2=80=AFAM Saravana Kannan <saravanak@google=
com> wrote:
> > Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
> > finding the supplier of a remote-endpoint property") due to a last minu=
te
> > incorrect edit of "index !=3D0" into "!index". This patch fixes it to b=
e
> > "index > 0" to match the comment right next to it.
> >
> > Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> > Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a r=
emote-endpoint property")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch!
>
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1304,7 +1304,7 @@ static struct device_node *parse_remote_endpoint(=
struct device_node *np,
> >                                                  int index)
> >  {
> >         /* Return NULL for index > 0 to signify end of remote-endpoints=
 */
> > -       if (!index || strcmp(prop_name, "remote-endpoint"))
> > +       if (index > 0 || strcmp(prop_name, "remote-endpoint"))
> >                 return NULL;
> >
> >         return of_graph_get_remote_port_parent(np);
> > --
> > 2.44.0.rc0.258.g7320e95886-goog
>
> After this, the "Fixed dependency cycle" messages I reported to be
> gone in [1] are back.
>
> In fact, they are slightly different, and there are now even more of them=
:
>
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef7000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef6000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef5000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef4000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef3000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef2000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef1000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef0000/ports/port@1/endpoint@0
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef3000/ports/port@1/endpoint@2
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef2000/ports/port@1/endpoint@2
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef1000/ports/port@1/endpoint@2
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef0000/ports/port@1/endpoint@2
> -platform fead0000.hdmi: Fixed dependency cycle(s) with
> /soc/sound@ec500000/ports/port@1/endpoint
> -platform feae0000.hdmi: Fixed dependency cycle(s) with
> /soc/sound@ec500000/ports/port@2/endpoint
> -platform feb00000.display: Fixed dependency cycle(s) with
> /soc/hdmi@feae0000/ports/port@0/endpoint
> -platform feb00000.display: Fixed dependency cycle(s) with
> /soc/hdmi@fead0000/ports/port@0/endpoint
> -platform hdmi0-out: Fixed dependency cycle(s) with
> /soc/hdmi@fead0000/ports/port@1/endpoint
> -platform hdmi1-out: Fixed dependency cycle(s) with
> /soc/hdmi@feae0000/ports/port@1/endpoint
> -platform vga-encoder: Fixed dependency cycle(s) with /vga/port/endpoint
> -platform vga-encoder: Fixed dependency cycle(s) with
> /soc/display@feb00000/ports/port@0/endpoint
> +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef4000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef5000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef6000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef7000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@feae00=
00
> +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fead00=
00
> +platform ec500000.sound: Fixed dependency cycle(s) with
> /soc/i2c@e6510000/codec@10
> +platform e6ef7000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef6000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef5000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef4000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef70=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef60=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef50=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef40=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef30=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef20=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef10=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef00=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef30=
00
> +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef20=
00
> +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef10=
00
> +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef00=
00
> +platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fead00=
00
> +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/sound@ec5000=
00
> +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb0=
0000
> +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@feae00=
00
> +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/sound@ec5000=
00
> +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb0=
0000
> +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb0=
0000
> +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb0=
0000
> +platform feb00000.display: Fixed dependency cycle(s) with /soc/hdmi@feae=
0000
> +platform feb00000.display: Fixed dependency cycle(s) with /soc/hdmi@fead=
0000
> +platform cvbs-in: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +platform hdmi-in: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +platform fead0000.hdmi: Fixed dependency cycle(s) with /hdmi0-out
> +platform hdmi0-out: Fixed dependency cycle(s) with /soc/hdmi@fead0000
> +platform feae0000.hdmi: Fixed dependency cycle(s) with /hdmi1-out
> +platform hdmi1-out: Fixed dependency cycle(s) with /soc/hdmi@feae0000
> +platform vga: Fixed dependency cycle(s) with /vga-encoder
> +platform feb00000.display: Fixed dependency cycle(s) with /vga-encoder
> +platform vga-encoder: Fixed dependency cycle(s) with /vga
> +platform vga-encoder: Fixed dependency cycle(s) with /soc/display@feb000=
00
>
> -i2c 2-0010: Fixed dependency cycle(s) with
> /soc/sound@ec500000/ports/port@0/endpoint
> +platform ec500000.sound: Fixed dependency cycle(s) with
> /soc/i2c@e6510000/codec@10
>
> -i2c 4-0070: Fixed dependency cycle(s) with
> /soc/csi2@fea80000/ports/port@0/endpoint
> -i2c 4-0070: Fixed dependency cycle(s) with
> /soc/csi2@feaa0000/ports/port@0/endpoint
> -i2c 4-0070: Fixed dependency cycle(s) with /hdmi-in/port/endpoint
> -i2c 4-0070: Fixed dependency cycle(s) with /cvbs-in/port/endpoint
> +platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +i2c 4-0070: Fixed dependency cycle(s) with /soc/csi2@fea80000
> +i2c 4-0070: Fixed dependency cycle(s) with /soc/csi2@feaa0000
>
> I guess all of that is expected?

Hi Geert,

Greg has picked up my "post-init-providers" series in his driver core.
Once you pull that in, you should be able to use the
post-init-providers property to break these cycles. Basically treat it
like any other supplier binding, but use it to mark the link in the
cycle that's not real. For the remote-endpoints case, you need to list
property at the device level. Not the endpoint, port or ports nodes.

Once you add this property, you should see an increase in the number
of device links that are present after all device probing is done.
Also, a bunch of existing device links should get converted from
sync_state_only device links to normal managed device links. Meaning,
the sync_state_only file under those /class/devlink/<device-link-x>/
folder should change from "1" to "0".

If that's what you see and it works, then go ahead and send out a
patch so that the boards you care about have a more
deterministic/stable probe/suspend/resume ordering.

Thanks,
Saravana



>
> [1] https://lore.kernel.org/all/CAMuHMdVon3mdivZQ0O6D4+va0nGBrUQbDp23bEq6=
61QD=3D4t7+g@mail.gmail.com/
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

