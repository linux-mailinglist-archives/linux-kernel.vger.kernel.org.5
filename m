Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A942812383
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjLMXsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLMXsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:48:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE3C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702511307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlH0hEer7+Nk19Vq61ytYQm6EsTqNJlYAMHbJqXd6yE=;
        b=iNtUpGyZGhhXwlkidiImOYI4rWxdpZ0dW3tb/m5+QAHMu/0LpRuRbQdg1LRngWi0yadzJk
        lu0qHIH2AqmuLPY9eH+ZdQmIzpdys0Q/UzYVv5eUXW/5teiqze28O+4vGylcIZyohTnuP2
        pvfCnOu4lvS21ef15WTadb4K+fmMJU0=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Dld9x1wDNfeNZdEMSFM3RQ-1; Wed, 13 Dec 2023 18:48:25 -0500
X-MC-Unique: Dld9x1wDNfeNZdEMSFM3RQ-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4b287defc7eso2029588e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702511304; x=1703116104;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlH0hEer7+Nk19Vq61ytYQm6EsTqNJlYAMHbJqXd6yE=;
        b=OzFPfgeyne3rmB/Kteu3eF7T4pz5IZwf31ZkyuN2KZ7++mykcMDLeeEziTdCLZqtoS
         zG9A58cAsQc/cJqg2y5+UZS8f2BSJwew1AziLoYSXl8guYXvy+94PHeDglCe3+eXWSYZ
         K7Mr8cxL2O47as0iLxW80VPcXBmnd47FWvHvgAx4q5v6lirbUH+JuAVKiO5rbtYwuNmG
         XETQo6+onvhI3WvJg0O/GkUwCoPBQ5yaM/Lz9dPW+p3g4si04B+4ZR5cjYD/OJPm8PdZ
         Mj97gxSnJ0ZIkGj8vU6NbHPVQEgvXKRS6fQzQRRFsH9q4Nvsu2D43b0M4q8khFHiTq41
         yZ7g==
X-Gm-Message-State: AOJu0YzVUoEKkSifps/RBShTt3g1yehmoww/gf+SFdVvrjbDu5RMIuX+
        RrueZ3Z7ssuSJfIbLEoHBUCw/u0tr8zJj23dFHncEQO1VNhY8mrPJl134YSGxzpR/G5zw4xM11k
        2jqWRebwvt9UY9Ok4mm7OW4vzC9KrszzZ
X-Received: by 2002:a1f:f4c9:0:b0:4b2:884d:60ef with SMTP id s192-20020a1ff4c9000000b004b2884d60efmr6453509vkh.9.1702511304471;
        Wed, 13 Dec 2023 15:48:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdScfcgntZWOMNXTw3/v7+E4FVhmTkodlicMCAD2tYLEyL4jcsSSdQlpenRfQ9H4cIjARGMQ==
X-Received: by 2002:a1f:f4c9:0:b0:4b2:884d:60ef with SMTP id s192-20020a1ff4c9000000b004b2884d60efmr6453500vkh.9.1702511304155;
        Wed, 13 Dec 2023 15:48:24 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id ej8-20020ad45a48000000b0067a4396f9cdsm5449659qvb.8.2023.12.13.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 15:48:23 -0800 (PST)
Message-ID: <f10791773520f85857749c080af999821dd41a0d.camel@redhat.com>
Subject: Re: nouveau 0000:01:00.0: drm_WARN_ON(!found_head)
From:   Lyude Paul <lyude@redhat.com>
To:     Borislav Petkov <bp@alien8.de>, Paul Dufresne <dufresnep@zoho.com>,
        Danilo Krummrich <me@dakr.org>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 13 Dec 2023 18:48:22 -0500
In-Reply-To: <114bf9f5790f637a6cdec4957244192d3bd76a04.camel@redhat.com>
References: <20231111120323.GAZU9tiw8e0RSzCGB9@fat_crate.local>
         <20231212224037.GAZXjhZUDeoq50xKJ5@fat_crate.local>
         <18c613ec092.ae61cf7d6029.4389632938517239705@zoho.com>
         <20231213113936.GBZXmX+MKqX/qOnPn1@fat_crate.local>
         <20231213124936.GCZXmoYDq8nMRs75XM@fat_crate.local>
         <114bf9f5790f637a6cdec4957244192d3bd76a04.camel@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully you're still on at this point - if you are, could you try startin=
g
the machine up with the following kernel module arguments passed to nouveau=
?

debug=3Ddisp=3Dtrace

Then see if you can find any lines that mention INHERIT? I have a feeling I=
'm
just going to have to add a workaround for the time being, but I'd really l=
ove
to know how we're managing to get that far on a hardware generation we neve=
r
implemented that nvkm ioctl for=E2=80=A6

On Wed, 2023-12-13 at 18:37 -0500, Lyude Paul wrote:
> agh - thank you for repeatedly poking on this, I've been busy enough with=
 GSP
> work I totally missed this. Yes - I'm quite surprised that this is blowin=
g up,
> but considering that looks to be a GT218 I guess display state readback m=
ust
> just work a bit differently there since that's really early on into the N=
V50
> days.
>=20
> The reason that was a drm_WARN_ON() was because it indicates that we're n=
ot
> reading back OR -> head assignments properly. But, I'm confused how we're=
 even
> getting that far on a non-GSP platform. I'm going to dig into this now, b=
ut if
> I don't figure out a good fix by the end of the day I'll just send a patc=
h to
> silent the warning.
>=20
> Thanks again for bugging me about this!
>=20
> On Wed, 2023-12-13 at 13:49 +0100, Borislav Petkov wrote:
> > On Wed, Dec 13, 2023 at 12:39:36PM +0100, Borislav Petkov wrote:
> > > We're getting close to releasing so I guess we either debug this or s=
hut
> > > up the WARN.
> >=20
> > Not only that - panic_on_warn turns this into an explosion so you don't
> > want that in a released kernel.
> >=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

