Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37177EDCA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbjKPILz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjKPILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:11:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA72119D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700122309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QdxgmAIHvXZQQ6jHVUpXaSiCgu9Ax2tLuylEkXqKU7s=;
        b=h0vWrNjzfj9X6fw+MOK945KOEsBpZopnkWOqEDWgg9kA4EXLfc7PWOVvlxXQj9pvc7yVCo
        MSMA7HRlaK3Bwyx1ZOI2zqkcsZ4qHQSSkadYWHidoIQwg7ajq30p1T/gaO2u2wpHRSdBNe
        3e7zEdhm0ll70qgDJLvmvqbN++e/Mgc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-tQfynuWFP0Sbw_sTLHuNOw-1; Thu, 16 Nov 2023 03:11:46 -0500
X-MC-Unique: tQfynuWFP0Sbw_sTLHuNOw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4083fec2c30so2928015e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700122305; x=1700727105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdxgmAIHvXZQQ6jHVUpXaSiCgu9Ax2tLuylEkXqKU7s=;
        b=dE7u03qFc44rQdhE1nefGoCeCBNG3nED1Xg9QzrpJl4kmNtpqnO2RxgiE5UkKK0128
         TaDegRbq45BfIl5+u+/ELsLKcTjo7vrMYkak+DAsGxjHA/OboRR5N5DnL2hejbCZcKZg
         AG10+5tZ5cpBx+Y31kKU/1vH3BjIdkqla+6GZo+h/yZigAjtkjov8DxMvXJXEgS2vxKp
         M0gNqXolgxHUXCZZAu9Y9BzY9o523zaPXhzYM2mokhm4hhyvja7c3OozK/slbabzqVWB
         WYFmID0gemPPmoUbMNmrOm/EO8BVbpa5zPI7jqVVH4XoH8P+lhe1iTmcysKWYJVAEY9h
         q4+Q==
X-Gm-Message-State: AOJu0YziOiqiQf255wFf5cSK6Hgxh3tvqHbUf4l1mqlMd69OpcQk9vTF
        GPIzxO5+QVba8OLNvUQJ17Yh0VY+YvYc8A7lLyyMdxPUIWvFxzPgfFtLp53sScgQH49SOfRzZWx
        wuXEU3YszXv3dYwUV7cnNfcDN
X-Received: by 2002:a05:600c:c14:b0:409:51c2:1192 with SMTP id fm20-20020a05600c0c1400b0040951c21192mr11997529wmb.38.1700122304996;
        Thu, 16 Nov 2023 00:11:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFArIjVMDUnueoI1XD+Bo6xsKtSuttRwG0IUwtvvb5tgUEIqUlUQnkr13VMXQfIq5mmPwWJw==
X-Received: by 2002:a05:600c:c14:b0:409:51c2:1192 with SMTP id fm20-20020a05600c0c1400b0040951c21192mr11997506wmb.38.1700122304611;
        Thu, 16 Nov 2023 00:11:44 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c4fd600b004064741f855sm2504399wmq.47.2023.11.16.00.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 00:11:44 -0800 (PST)
Date:   Thu, 16 Nov 2023 09:11:43 +0100
From:   Maxime Ripard <mripard@redhat.com>
To:     Luben Tuikov <ltuikov89@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
Message-ID: <73cg637ax5cahqocscx5cjvtqkwlt4ves6cxgprbwqllasxq6v@gk6vzsqfc46j>
References: <20231114075501.61321c29@canb.auug.org.au>
 <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
 <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
 <20231114134506.2ba0de1f@canb.auug.org.au>
 <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
 <20231114140855.0b259b2d@canb.auug.org.au>
 <f1b21cbd-5bb6-4030-ae7d-a0ca2fbc76a9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7hqxyzpgktklwnyb"
Content-Disposition: inline
In-Reply-To: <f1b21cbd-5bb6-4030-ae7d-a0ca2fbc76a9@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7hqxyzpgktklwnyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 06:46:21PM -0500, Luben Tuikov wrote:
> On 2023-11-13 22:08, Stephen Rothwell wrote:
> > BTW, cherry picking commits does not avoid conflicts - in fact it can
> > cause conflicts if there are further changes to the files affected by
> > the cherry picked commit in either the tree/branch the commit was
> > cheery picked from or the destination tree/branch (I have to deal with
> > these all the time when merging the drm trees in linux-next).  Much
> > better is to cross merge the branches so that the patch only appears
> > once or have a shared branches that are merged by any other branch that
> > needs the changes.
> >=20
> > I understand that things are not done like this in the drm trees :-(
>=20
> Hi Stephen,
>=20
> Thank you for the clarification--understood. I'll be more careful in the =
future.
> Thanks again! :-)

In this case, the best thing to do would indeed have been to ask the
drm-misc maintainers to merge drm-misc-fixes into drm-misc-next.

We're doing that all the time, but we're not ubiquitous so you need to
ask us :)

Also, dim should have caught that when you pushed the branch. Did you
use it?

Maxime

--7hqxyzpgktklwnyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZVXOvwAKCRDj7w1vZxhR
xSpoAP9R6u/FDuWma6CxU5HZBYqMkt5dLAFaBh09JkKgEgODsQEA+ff+2mfWZWks
JIa2770u4xDDPwvd4rX6nTK1ILbicQk=
=OXab
-----END PGP SIGNATURE-----

--7hqxyzpgktklwnyb--

