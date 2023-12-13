Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E83812345
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442667AbjLMXiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjLMXia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F331705
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702510647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bM5SMenaJ88uFf7XU2jdKzO8ftktLKCbuzz3KkFPnI=;
        b=hEGiEamJkB+HwuGGLAUfGB+oR+x2ibWSk2jOsfELOgW+bldCEYyKPSExkuIp7wXJWurBWI
        JibSUjsocyA6DFXyVjy6YJeNIL3uI4jorArSAqebIdWpyXrxd0h2fxj+SCJRYve9uri7iY
        YsNTlKu8kVnz4fCljmmY9C+SUlJEckE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-sN8pGApKOT-lIhNe6-KtAw-1; Wed, 13 Dec 2023 18:37:24 -0500
X-MC-Unique: sN8pGApKOT-lIhNe6-KtAw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77f74245de3so528671385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510644; x=1703115444;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bM5SMenaJ88uFf7XU2jdKzO8ftktLKCbuzz3KkFPnI=;
        b=jFHUt5ww3ESFNW2a/BzmN9bQbNJmKz/uvwxv7U4IGo/eCRfrKZiJkQOdU+blxjX7GJ
         7TGUHhslVOKoUpCsRGSyC0y0o6GPM6eQaUmum6ltAJ+hVZIDBnFYgLlDjoqYzVVbPhf2
         hQcymx8Z1qJqIpogpjxNGj8zR5LF59itWQSCz2fqXo4dTeCOspJlU6iwHfayfZ6NoVgj
         aPzYV9xlQnZ2oOkhfcE7ngu+0a6QYEAdlep7bo6W/cWoBJnHN9E2fuAGHVH5n1hgV2iK
         Lycid9/U//TzNUYPWHGNVGUPWNz5K7VPqoeIwAHpTHWNnGbIOSrJdkAvU+YOzGlCVTB/
         iC3Q==
X-Gm-Message-State: AOJu0YwRJZlbi1uj5jQDYWabIamotwV8HsXqfndITq+SvS8klQr/u1O1
        2mu4/t+BR9R6JYNI1wtDCZ3/h8d4JHwxAe3XMb93QUgume8nkfmW1uEVJagELWuqK20FMm1n0uv
        N3mljCKrIjtn3hX4gWUVXnhvJ
X-Received: by 2002:a05:620a:2603:b0:77b:e2ae:934c with SMTP id z3-20020a05620a260300b0077be2ae934cmr10952571qko.12.1702510644403;
        Wed, 13 Dec 2023 15:37:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUVH/OQpyNoeiuSGiiYho89l/+ehiBCwR+TccPGs5nC6eWuLzhfay1fvd3HpT8GnD42ZeXXA==
X-Received: by 2002:a05:620a:2603:b0:77b:e2ae:934c with SMTP id z3-20020a05620a260300b0077be2ae934cmr10952558qko.12.1702510644183;
        Wed, 13 Dec 2023 15:37:24 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id b5-20020a05620a270500b0076ce061f44dsm4878672qkp.25.2023.12.13.15.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 15:37:23 -0800 (PST)
Message-ID: <114bf9f5790f637a6cdec4957244192d3bd76a04.camel@redhat.com>
Subject: Re: nouveau 0000:01:00.0: drm_WARN_ON(!found_head)
From:   Lyude Paul <lyude@redhat.com>
To:     Borislav Petkov <bp@alien8.de>, Paul Dufresne <dufresnep@zoho.com>,
        Danilo Krummrich <me@dakr.org>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 13 Dec 2023 18:37:22 -0500
In-Reply-To: <20231213124936.GCZXmoYDq8nMRs75XM@fat_crate.local>
References: <20231111120323.GAZU9tiw8e0RSzCGB9@fat_crate.local>
         <20231212224037.GAZXjhZUDeoq50xKJ5@fat_crate.local>
         <18c613ec092.ae61cf7d6029.4389632938517239705@zoho.com>
         <20231213113936.GBZXmX+MKqX/qOnPn1@fat_crate.local>
         <20231213124936.GCZXmoYDq8nMRs75XM@fat_crate.local>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

agh - thank you for repeatedly poking on this, I've been busy enough with G=
SP
work I totally missed this. Yes - I'm quite surprised that this is blowing =
up,
but considering that looks to be a GT218 I guess display state readback mus=
t
just work a bit differently there since that's really early on into the NV5=
0
days.

The reason that was a drm_WARN_ON() was because it indicates that we're not
reading back OR -> head assignments properly. But, I'm confused how we're e=
ven
getting that far on a non-GSP platform. I'm going to dig into this now, but=
 if
I don't figure out a good fix by the end of the day I'll just send a patch =
to
silent the warning.

Thanks again for bugging me about this!

On Wed, 2023-12-13 at 13:49 +0100, Borislav Petkov wrote:
> On Wed, Dec 13, 2023 at 12:39:36PM +0100, Borislav Petkov wrote:
> > We're getting close to releasing so I guess we either debug this or shu=
t
> > up the WARN.
>=20
> Not only that - panic_on_warn turns this into an explosion so you don't
> want that in a released kernel.
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

