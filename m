Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506707D7D08
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjJZGtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjJZGti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2449D191
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698302930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZhX4iyxXFC0MCsQGeir9FIncGn784C5EIdLY3Kqf/o=;
        b=MmnL/f+KIEB1Vhp1nP7+1tMpEQ3uVYb/sWPiTfMnEZHY8TgdcWnSVAq8EfrW2Ul/j64l/M
        Jeu0CiUqUuX0AS8JeaaXO2G+r4LUkj8N0aFcCkQsdLKO/cs0ENzfa+6fQA1YmO4/jWuXCg
        fiXcjpjnWkbBLSD4+GyU+JU6fjr8B8g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-9WzObKsvMtSz7edm6A-IsA-1; Thu, 26 Oct 2023 02:48:46 -0400
X-MC-Unique: 9WzObKsvMtSz7edm6A-IsA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079fd9754cso519562e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698302925; x=1698907725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZhX4iyxXFC0MCsQGeir9FIncGn784C5EIdLY3Kqf/o=;
        b=G4OelhA9P2I+2f2ggqVtedw3GDN0uusIoK/CC1fPyRNXnM55PBp9I8Ivg0CbyIuRQZ
         nnGVySTQ5zuirINSslX20+aJWKbeWNYqM21r5zxJeq32yTkj0gzprilkZkt1qqA7V93r
         tevMalM8dRUpBfMrxiGFz17QlwYAYdg2odCHsJdKfC4MMqshlVeUVOf9T7JCddV9hOf0
         mknaVAVLLUvQpXqiRIG/QeAcxhGVcQwLHxToJ7JRPlbcLrmszeBJnSu2SgyhoXper+BU
         H8+6ez3NlJbg0TH5dAcqF/hTrqedPaEJCMpZCkh7pADGg7aUvDhCVotrJsp5GBFolDei
         PZww==
X-Gm-Message-State: AOJu0YzCPiSy7OLSRnypnLjYqIEQmaOqsjZM31Z4oZGqdWIubgNsd2gm
        2GJbGypdOeH5LhQCjlmDxp0hXjOtG0atBtS5YlDA2xWH2RGK8IsaQvonwJAg8jNKqHWtGtjAie+
        yPjFbhtaH/DholqwpVcCCERjVfDGITnEpjFWkgk5h
X-Received: by 2002:a19:550f:0:b0:507:bbbe:5287 with SMTP id n15-20020a19550f000000b00507bbbe5287mr12237676lfe.51.1698302925288;
        Wed, 25 Oct 2023 23:48:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMwwL0RGJDkxIK0JiqAOnmXyEk1qhDXOl4RL0c1Djxza+SUefJr9FuA0rhF/Pzzy+BBAOIL4AIupG/QYhCR5c=
X-Received: by 2002:a19:550f:0:b0:507:bbbe:5287 with SMTP id
 n15-20020a19550f000000b00507bbbe5287mr12237663lfe.51.1698302924964; Wed, 25
 Oct 2023 23:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20231026024147-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231026024147-mutt-send-email-mst@kernel.org>
From:   Cindy Lu <lulu@redhat.com>
Date:   Thu, 26 Oct 2023 14:48:07 +0800
Message-ID: <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 2:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Sep 24, 2023 at 01:05:33AM +0800, Cindy Lu wrote:
> > Hi All
> > Really apologize for the delay, this is the draft RFC for
> > iommufd support for vdpa, This code provides the basic function
> > for iommufd support
> >
> > The code was tested and passed in device vdpa_sim_net
> > The qemu code is
> > https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> > The kernel code is
> > https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
> >
> > ToDo
> > 1. this code is out of date and needs to clean and rebase on the latest=
 code
> > 2. this code has some workaround, I Skip the check for
> > iommu_group and CACHE_COHERENCY, also some misc issues like need to add
> > mutex for iommfd operations
> > 3. only test in emulated device, other modes not tested yet
> >
> > After addressed these problems I will send out a new version for RFC. I=
 will
> > provide the code in 3 weeks
>
> What's the status here?
>
Hi Michael
The code is finished, but I found some bug after adding the support for ASI=
D,
will post the new version after this bug is fixed, should be next week
Thanks
Cindy

> --
> MST
>

