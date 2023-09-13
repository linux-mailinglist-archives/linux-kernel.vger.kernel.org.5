Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B02E79F18F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjIMS7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjIMS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AF421999
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694631500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PogGVCHPdjunWAB1ZLN/UpXwnYlHki+1H1daV1Zio0=;
        b=IvEbsH1RrD3QGk/7HPUNrrbsjoQ1ID63+wtfx8rBF2w0hpSibS3Qa8PCIHZDDBLbL6O3YM
        L+ELo+2QWtiCyNJLYnnne4o12IUYMvK1mZlhMzyrM/siMs4OA5Ze7oAmXxLJ2psIS/slvf
        iU05ddxGNJhPp3XP8Gvf1ubW/bvsE5A=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-uCWS3XyGOmCafoUPTd-vFA-1; Wed, 13 Sep 2023 14:58:18 -0400
X-MC-Unique: uCWS3XyGOmCafoUPTd-vFA-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-34f9739e7d9so937075ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631498; x=1695236298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PogGVCHPdjunWAB1ZLN/UpXwnYlHki+1H1daV1Zio0=;
        b=wUoLijBkA7efpZIJaXZ60OL2fHx0UlBTdXHbyAIq3vBn3/OzLgKjAg2P8MFJVuxsuY
         ZhXq3mhBRcm5O4UktnKsF4AAEk/lcwfMdDonHEP57/b/g7y2FJbfdJGLNJAJTr9nnjGh
         h9l0e1JfVcck5K3H5zmy4/BIVnoeIhU3u4wT3IbXrfiTcAfBPYhIPcDdHQTbepKww/Ew
         S4cQp3mKdTRYU5dvmHzloDrfc9HLO+AuSOe2/5D3kP0Rzg6ruElV9zTXu3A197J/+qQ4
         +qbd3aSjOvy9wRDK0buP+L08if4a7586rm99E3IiyZEF6Hwlm4IkEem6cEfeQD4XBNmn
         p7EQ==
X-Gm-Message-State: AOJu0Yyb0Czc8tEyMXzmTjKKhDNStacjUHp4xfBmhYDjSDcTkLC+cpTt
        WiX8GphoQM4rD+iMWN8Kfk1hcYwSo8iSvw/ZB0kk1MwtbHwaGzbPp7IOCWcrrfzT0pehZuq9TrW
        GhHJLYECsnr2FznxszY5s/9cA
X-Received: by 2002:a05:6e02:1a2b:b0:34f:234d:4b5a with SMTP id g11-20020a056e021a2b00b0034f234d4b5amr3931358ile.29.1694631498159;
        Wed, 13 Sep 2023 11:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiB96yO/TTZ6XXOFdbqg/TwTOfa3ydr1lhqrL/GFy/AIAOhiMnNg1hoBaqbU3IgS+wG1idNQ==
X-Received: by 2002:a05:6e02:1a2b:b0:34f:234d:4b5a with SMTP id g11-20020a056e021a2b00b0034f234d4b5amr3931346ile.29.1694631497907;
        Wed, 13 Sep 2023 11:58:17 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id do13-20020a0566384c8d00b0043194542229sm3467615jab.52.2023.09.13.11.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 11:58:17 -0700 (PDT)
Date:   Wed, 13 Sep 2023 12:58:15 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        oushixiong <oushixiong@kylinos.cn>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Brett Creeley <brett.creeley@amd.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/pds: Using pci_physfn() to fix a compilation issue
Message-ID: <20230913125815.3ef654e6.alex.williamson@redhat.com>
In-Reply-To: <ZP8H0puYJeYF33fn@ziepe.ca>
References: <20230911080828.635184-1-oushixiong@kylinos.cn>
        <BN9PR11MB527657CA940184579FD31CAC8CF2A@BN9PR11MB5276.namprd11.prod.outlook.com>
        <ZP8H0puYJeYF33fn@ziepe.ca>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 09:28:02 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Sep 11, 2023 at 08:25:18AM +0000, Tian, Kevin wrote:
> > > From: oushixiong <oushixiong@kylinos.cn>
> > > Sent: Monday, September 11, 2023 4:08 PM
> > >=20
> > > From: Shixiong Ou <oushixiong@kylinos.cn>
> > >=20
> > > If PCI_ATS isn't set, then pdev->physfn is not defined.
> > > it causes a compilation issue:
> > >=20
> > > ../drivers/vfio/pci/pds/vfio_dev.c:165:30: error: =E2=80=98struct pci=
_dev=E2=80=99 has no
> > > member named =E2=80=98physfn=E2=80=99; did you mean =E2=80=98is_physf=
n=E2=80=99?
> > >   165 |   __func__, pci_dev_id(pdev->physfn), pci_id, vf_id,
> > >       |                              ^~~~~~
> > >=20
> > > So using pci_physfn() rather than using pdev->physfn directly.
> > >=20
> > > Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn> =20
> >=20
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com> =20
>=20
> Yes, we should do both patches

Sure, but it's sloppy to put both in with the same commit log.  Should
we change this one to something like:

    vfio/pds: Use proper PF device access helper

    The pci_physfn() helper exists to support cases where the physfn
    field may not be compiled into the pci_dev structure.  We've
    declared this driver dependent on PCI_IOV to avoid this problem,
    but regardless we should follow the precedent not to access this
    field directly.

Thanks,
Alex=20

