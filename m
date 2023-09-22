Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4718B7ABA01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjIVTYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIVTYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7EEA3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695410636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWz2594PebN6/sZ7Xi+2z+TcUg7W+ur8FNaCU/72PSU=;
        b=TpipMnCNDn8LonxEwrttBqSSomWq0dojiUbPi2BfG6uD4FznWUgWPu0FiRc5OluBCwzvip
        OoB9owAHLDVm2Cqvja2bFzDXO75oWNmxH5jVJg8SLVxl2a8jeiHHmYaRtu61++dxLn3oGC
        ssug70SG4lndXbvRWvocS7Z23KekUS4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-nMDscAA8M-a30vb7Nh5MOQ-1; Fri, 22 Sep 2023 15:23:55 -0400
X-MC-Unique: nMDscAA8M-a30vb7Nh5MOQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3adbc8aaf29so3753849b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695410634; x=1696015434;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWz2594PebN6/sZ7Xi+2z+TcUg7W+ur8FNaCU/72PSU=;
        b=XMf5R669vO2HLya4T34KdRr961IhnEJ5aBU10eX9O9RieN+1DCog97Sue/mqKVS54t
         lxx9bErPnwWWl1Lb2wc6RqPYKlwnqctHK7TgirRGZuYLWhait3ASXaof8q0s8Re+teq9
         HN767g1zvBeUpcoD+aM1+5k0xJSF1yJm+9d3ZYWfPzBOZsC2t4cFWmOfw3oo5hgt4TyQ
         RzwA9TvoQo5F7/2EXZIr4dGW9JNGzapoUHOQmNA7OOgDIfHJrDvInAeY/MIRfvdmPhEY
         fiHNNpB1xUZJl7TI+hyO071bgM/zBtz2GkfsGMri31Gaxf7HwFXzrgtcIl3Gzx7LAi6A
         HROA==
X-Gm-Message-State: AOJu0YzIPMu4xiwCstvsrX7kjEgWAmwPhwAG/9k4Wf4f7oK7gQsC7rIU
        KFXAc8A3WsDDQFvVfRQs+9vV6WS9BsXIWB4BIKRmyhOh863Y4Vq3speXPBfzHmaRXW9PeY4wRPv
        drEXhbwXO0YfHNALnhs4xzXdn
X-Received: by 2002:a05:6808:f0b:b0:3a7:6385:28ac with SMTP id m11-20020a0568080f0b00b003a7638528acmr776349oiw.4.1695410634471;
        Fri, 22 Sep 2023 12:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7i3t/aNow9fEg4WVwOXQACcWlQdpl28s/1sD0IP5eE9lXMGuH+nE1i0GSI+4FI9Z5yq196Q==
X-Received: by 2002:a05:6808:f0b:b0:3a7:6385:28ac with SMTP id m11-20020a0568080f0b00b003a7638528acmr776333oiw.4.1695410634158;
        Fri, 22 Sep 2023 12:23:54 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id a27-20020ac844bb000000b004035843ec96sm1681935qto.89.2023.09.22.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:23:53 -0700 (PDT)
Message-ID: <b9d52ce542021b88fe602bdd93434d0ddaa188e5.camel@redhat.com>
Subject: Re: [PATCH v1] drm/dp/mst: fix missing modeset unlock for MST port
 detect
From:   Lyude Paul <lyude@redhat.com>
To:     imre.deak@intel.com
Cc:     Ramya SR <quic_rsr@quicinc.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jeff Layton <jlayton@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Sep 2023 15:23:52 -0400
In-Reply-To: <ZQ3pbVHRXMiLfUCf@ideak-desk.fi.intel.com>
References: <1694753689-29782-1-git-send-email-quic_rsr@quicinc.com>
         <19ce2cd9abfd3bdf3ea91f9bceb43206e4740c2e.camel@redhat.com>
         <ZQ3pbVHRXMiLfUCf@ideak-desk.fi.intel.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6ugh, thanks for catching that :|

yes you're completely right - NAK on this patch then

On Fri, 2023-09-22 at 22:22 +0300, Imre Deak wrote:
> On Fri, Sep 22, 2023 at 03:02:23PM -0400, Lyude Paul wrote:
> >=20
> > Oh! wow thank you for catching this:
> >=20
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> >=20
> > I will go and push this to drm-misc-next in just a moment
> >=20
> > On Fri, 2023-09-15 at 10:24 +0530, Ramya SR wrote:
> > > Modeset mutex unlock is missing in drm_dp_mst_detect_port function.
> > > This will lead to deadlock if calling the function multiple times in
> > > an atomic operation, for example, getting imultiple MST ports status
> > > for a DP MST bonding scenario.
> > >=20
> > > Signed-off-by: Ramya SR <quic_rsr@quicinc.com>
> > > ---
> > >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/=
gpu/drm/display/drm_dp_mst_topology.c
> > > index ed96cfc..d6512c4 100644
> > > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > @@ -4154,7 +4154,7 @@ drm_dp_mst_detect_port(struct drm_connector *co=
nnector,
> > > =20
> > >  	ret =3D drm_modeset_lock(&mgr->base.lock, ctx);
> > >  	if (ret)
> > > -		goto out;
> > > +		goto fail;
> > > =20
> > >  	ret =3D connector_status_disconnected;
> > > =20
> > > @@ -4181,6 +4181,8 @@ drm_dp_mst_detect_port(struct drm_connector *co=
nnector,
> > >  		break;
> > >  	}
> > >  out:
> > > +	drm_modeset_unlock(&mgr->base.lock);
>=20
> Isn't this supposed to be unlocked only by drm_helper_probe_detect_ctx()
> / drm_helper_probe_detect() ?
>=20
> > > +fail:
> > >  	drm_dp_mst_topology_put_port(port);
> > >  	return ret;
> > >  }
> >=20
> > --=20
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> >=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

