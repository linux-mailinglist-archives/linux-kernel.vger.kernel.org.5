Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA207D3C50
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjJWQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjJWQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55410D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698078172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8sviLcqtrzQ+oBXbTZRqaovwEitzC/w+7tvYOUmsOnM=;
        b=c+KTcZ+ahDOTvBlWzuBUO8uK4hyPK3mxEF0Enm64gkr7cexMcLZTkqfZRoVyUJIegtWDFU
        ieZAd8zfmTcPdWW9sBdvzDlO8hgN/cNgt6biOoq4h43Q8vz2kNAokdiPJI0WDbZ2EaRzsg
        Z/9ii+wh29GQ0CEjcsKn7Q70+Wwg1pk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-dTp__7mjOdquEPPiudebYA-1; Mon, 23 Oct 2023 12:22:40 -0400
X-MC-Unique: dTp__7mjOdquEPPiudebYA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507ce973a03so3488315e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698078159; x=1698682959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sviLcqtrzQ+oBXbTZRqaovwEitzC/w+7tvYOUmsOnM=;
        b=hTo3Wp6rs4UdyQcn3aW9SJDv9mmkBPs1MxwePHsV1wlguDLhUslcmL2Cbbc4ygGHvD
         metm4B74ZW+Bipgo8SYmD0JM8k12aikDTZaTgBbEZtO1LPRRQutA7RUPmfrjjUCB0g8R
         3uIokTXF+56tB02Iyg+tdVd1nw4+90PIa737IwBulZN85UkJOYyktelEEJZrV7i3CSQu
         ZkMe2HoMzZDhzQp+yLjgGLatamMxyzSm8+UPARyzmY2hvWmdDpm9LsvBpZDElxAKrvL7
         2aCtZ1bt1bIX/eSo/kILi544Lr0B/4fqeoYDlc+pK7E4lqUJa6/T/8CNH9s6QWUieLG+
         yeig==
X-Gm-Message-State: AOJu0YxPYu/Ze9PauEZamM/26FSWdvyFoBNnl7VGf/L+ZY9RtY+TfNtT
        iewYnUIDcBDgVVl8IfvgRtLUW1Ch4lXfTbvw13BsV3+1eg/5XzlhXrpdjEXYjuAP9ifE9NFglns
        klJStyIztMWpQTpW1BwqvbhckDx3mJ3jnrWSmfHXW
X-Received: by 2002:ac2:48bb:0:b0:507:9628:afb with SMTP id u27-20020ac248bb000000b0050796280afbmr6722512lfg.68.1698078159074;
        Mon, 23 Oct 2023 09:22:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbIRkANsjn89iNuqMdSM4mAotF8J81pYMXXM8hyKKFJUjkJU2kQkUkdRCav68P4tImvumU1W4ItopDKpd3MgU=
X-Received: by 2002:ac2:48bb:0:b0:507:9628:afb with SMTP id
 u27-20020ac248bb000000b0050796280afbmr6722499lfg.68.1698078158729; Mon, 23
 Oct 2023 09:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221207-rpi-hdmi-improvements-v3-0-bdd54f66884e@cerno.tech>
 <20221207-rpi-hdmi-improvements-v3-3-bdd54f66884e@cerno.tech>
 <CAKMK7uFQ8yJLKgTrQdmhwmq9uL-hbUsfUeU6cxWdB2AW3i4vOg@mail.gmail.com>
 <fwcn3vlgxq5uygi32pyjuktj62wa7zvdgu7xxlpqr7an3kjn7i@25axhlrrkk6z>
 <12669999-295f-40c5-8c58-ba3ed26efb16@xs4all.nl> <tnkfcgkoobxyyhnsmoyayohip73wl6axnd7liefsvof6qwgovd@ropob4set3nl>
In-Reply-To: <tnkfcgkoobxyyhnsmoyayohip73wl6axnd7liefsvof6qwgovd@ropob4set3nl>
From:   Sebastian Wick <sebastian.wick@redhat.com>
Date:   Mon, 23 Oct 2023 18:22:27 +0200
Message-ID: <CA+hFU4yeUsGy9rzq3H6hmfkjXsYHxf6W=bJ-1ti1Um9jgkihcQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] drm/vc4: hdmi: Add Broadcast RGB property to allow
 override of RGB range
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Emma Anholt <emma@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honestly, the less time people spend on this property the better. Lift
the Intel one into core and be done with it. We'll hopefully be able
to remove it in the not-to-distant future with the new color pipeline
API and adding a new property which only sets the connector metadata
instead of influencing the color pipeline as well.

On Mon, Oct 23, 2023 at 4:58=E2=80=AFPM Maxime Ripard <maxime@cerno.tech> w=
rote:
>
> Hi Hans,
>
> On Thu, Oct 19, 2023 at 10:26:40AM +0200, Hans Verkuil wrote:
> > Hi Maxime,
> >
> > On 19/10/2023 10:02, Maxime Ripard wrote:
> > > Hi,
> > >
> > > On Wed, Oct 11, 2023 at 03:23:18PM +0200, Daniel Vetter wrote:
> > >> On Mon, 6 Mar 2023 at 11:49, Maxime Ripard <maxime@cerno.tech> wrote=
:
> > >>>
> > >>> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >>>
> > >>> Copy Intel's "Broadcast RGB" property semantics to add manual overr=
ide
> > >>> of the HDMI pixel range for monitors that don't abide by the conten=
t
> > >>> of the AVI Infoframe.
> > >>>
> > >>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > >>
> > >> Stumbled over this grepping around, but would have been nice to lift
> > >> this into drm code and document the property. It's one of the legacy
> > >> ones from the table of horrors after all ...
> > >>
> > >> Shouldn't be an uapi problem because it's copypasted to much, just n=
ot great.
> > >
> > > We already discussed it on IRC, but just for the record I have a curr=
ent
> > > series that should address exactly that:
> > >
> > > https://lore.kernel.org/dri-devel/20230920-kms-hdmi-connector-state-v=
2-3-17932daddd7d@kernel.org/
> > >
> > > Maxime
> >
> > I've pasted a snippet from that patch below for a quick review:
> >
> > >  /**
> > >   * DOC: HDMI connector properties
> > >   *
> > > + * Broadcast RGB (HDMI Specific):
> >
> > Full vs Limited is actually not HDMI specific, DisplayPort can signal t=
his as
> > well for whatever it is worth.
>
> Sure, what I (and the original patch I guess) meant is that it's only
> ever used on HDMI connectors these days. If that ever changes, then we
> can update the doc.
>
> > > + *      Indicates the RGB Range (Full vs Limited) used.
> >
> > RGB Range -> RGB Quantization Range
> >
> > > + *
> > > + *      The value of this property can be one of the following:
> > > + *
> > > + *      Automatic:
> > > + *              RGB Range is selected automatically based on the mod=
e
> > > + *              according to the HDMI specifications.
> > > + *
> > > + *      Full:
> > > + *              Full RGB Range is forced.
> > > + *
> > > + *      Limited 16:235:
> >
> > It is very unfortunate that this is called "Limited 16:235" instead of =
just "Limited"
> > since for color component bit depths > 8 these values are different.
> >
> > I have no idea if it is possible to add an alias "Limited" that you can=
 use instead.
> > In any case, this should document that it works just as well for higher=
 bit depths,
> > but with different limits.
>
> I had a look and it doesn't look like the property infrastructure can
> deal with aliases. I'll add something in the doc
>
> Thanks!
> Maxime

