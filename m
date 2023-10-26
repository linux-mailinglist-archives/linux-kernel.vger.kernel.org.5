Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595C47D7D47
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbjJZHFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJZHFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764501BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698303847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4bmkXJMJqFq2y2BT9JWWBJPo9uIKV40dEB2MqEeCLgk=;
        b=CAzgvImOhTVyu2nhlzUSJ2LugMRcjHUer+OLF1x0BDtAad4JBuJnfFdBsu9oIg/70Ls0lT
        Ytfp0s4v8Er3nWFnwB4WstJzPtzq27tc3ywpIqd14FJ+R2yZ8hOGHCzEGB8LxrPUoWkIbF
        aKDy1mGnLgNXkKUDR1hbqjRhoo8Oi5s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-9GttP1LVM-aMiwMzvGI8PA-1; Thu, 26 Oct 2023 03:04:05 -0400
X-MC-Unique: 9GttP1LVM-aMiwMzvGI8PA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-521da4c99d4so398377a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698303844; x=1698908644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bmkXJMJqFq2y2BT9JWWBJPo9uIKV40dEB2MqEeCLgk=;
        b=YtoqFpYR8ZE3M+lQ5FAMLd/wjEUblQSWF09vQvpveNqYbR3qx57CfHpcAySAM99pfX
         K1a1PefQGFhu7yDknqMKwjShKbOMTzpSJ2SXvdtmWBqii+G3jZxzlTZNp0ZERICNmVLV
         P/MPxrma9/vweRAMgNyFeeV8ELS+Cca2dJC5SfmAVq8s8vwvpPAVpT7uzxlh8SOBmUv0
         21h6y77jLXfPOtbiknA9xtUTBFrdyCF8QEuxC//O7dozfaKf70XgiMS6XE7CyMHZ+rRH
         wJ1bGWjkWk8ui8niaw3+Nc+R0ywpq0P43BuWeFVUTNG9YX1fFiVUO0hJIDi66sDeNByX
         +IRw==
X-Gm-Message-State: AOJu0YwTwSGgdGunHAWDvDxCg99lKJzK+ExFlP8bcPz3AyEM+ov7J9Gs
        wjtGrSl0OhKErEvF0EIO6mayukMX073m9lAteQpUyKKaBiAx7bXfuqnTvDHsB3JQnvipIJnQZwS
        3u5zj0f3oO+tVTeFMUXupUyJJH3McR+gGwDW8/yDM
X-Received: by 2002:a50:f616:0:b0:53e:bb41:7506 with SMTP id c22-20020a50f616000000b0053ebb417506mr1055723edn.33.1698303844770;
        Thu, 26 Oct 2023 00:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/hIUnsMuQLJWc0lCUDVWC3du0OmX4Ephe8O1KYUpUHk8vCjeZyT+gihr9WwOm7WNgtppvDgI7lbQpKLePO4s=
X-Received: by 2002:a50:f616:0:b0:53e:bb41:7506 with SMTP id
 c22-20020a50f616000000b0053ebb417506mr1055699edn.33.1698303844262; Thu, 26
 Oct 2023 00:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20231026024147-mutt-send-email-mst@kernel.org>
 <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com> <20231026024931-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231026024931-mutt-send-email-mst@kernel.org>
From:   Cindy Lu <lulu@redhat.com>
Date:   Thu, 26 Oct 2023 15:03:25 +0800
Message-ID: <CACLfguXkhyNc-idDSsE9jEAySVO0xBqaaq7bPDQras+CCPhdgw@mail.gmail.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 2:49=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Oct 26, 2023 at 02:48:07PM +0800, Cindy Lu wrote:
> > On Thu, Oct 26, 2023 at 2:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Sun, Sep 24, 2023 at 01:05:33AM +0800, Cindy Lu wrote:
> > > > Hi All
> > > > Really apologize for the delay, this is the draft RFC for
> > > > iommufd support for vdpa, This code provides the basic function
> > > > for iommufd support
> > > >
> > > > The code was tested and passed in device vdpa_sim_net
> > > > The qemu code is
> > > > https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> > > > The kernel code is
> > > > https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
> > > >
> > > > ToDo
> > > > 1. this code is out of date and needs to clean and rebase on the la=
test code
> > > > 2. this code has some workaround, I Skip the check for
> > > > iommu_group and CACHE_COHERENCY, also some misc issues like need to=
 add
> > > > mutex for iommfd operations
> > > > 3. only test in emulated device, other modes not tested yet
> > > >
> > > > After addressed these problems I will send out a new version for RF=
C. I will
> > > > provide the code in 3 weeks
> > >
> > > What's the status here?
> > >
> > Hi Michael
> > The code is finished, but I found some bug after adding the support for=
 ASID,
> > will post the new version after this bug is fixed, should be next week
> > Thanks
> > Cindy
>
>
> We'll miss this merge window then.
>
thanks Micheal=EF=BC=8C I will try my best. will post the new version as so=
on as I can
Thanks
Cindy
> > > --
> > > MST
> > >
>

