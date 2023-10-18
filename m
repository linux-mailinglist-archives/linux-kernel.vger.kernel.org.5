Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D897CE0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345143AbjJRPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjJRPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D696512A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697641689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4k32Qll7xmolYIKH5+vDPZG05ddmo4Sz7Cnu5kKN0s=;
        b=Fnc2bWi7E+/ctWN1vgzNozj9otHH119Stc+OsCf706V1kt43ShYy6+4zwYcCFxdwAwySsV
        KXpXskKlbWqlnxrgCPeiMsChVaK5OUH/5qAAZzFeye4EtFRlwnieq2kdfwKZ4eZJ1I3Kvg
        yFVqOunFjzBlUQ2kmdIEaAJEAzKwRC8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-liqcBvy7M5yq0Yibhj42Iw-1; Wed, 18 Oct 2023 11:07:48 -0400
X-MC-Unique: liqcBvy7M5yq0Yibhj42Iw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5079fd9754cso4859814e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697641662; x=1698246462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4k32Qll7xmolYIKH5+vDPZG05ddmo4Sz7Cnu5kKN0s=;
        b=cKLl//nyWx6oOW5so4/NmHSdjH+CShvOxvIp98GH0eJDP+gRC/VMaxJeOH46kthKWA
         5pipVnkqcYlOMaejQ+cxi64ebV3pKH5s2PKuXK5/g8gtsFJn8fXXwHE7n5LyckbVzZKS
         VpohekQUlDI9adWTHLcKQQOdvvmUKxM6Ph56PwZd7p4z2JM95vdGPWse7oqfELyBXrsQ
         lUkrjRDF8lZoAZUD6Zz0JExKz6HYLtxo9lRmwcZQlQbHB9Jw1NFsGIeY+vy8sQbQX9ce
         TVc68VmWE3lHBqwwYdn0cCeZvuZvAu+fbyDhlupOjXzohlmOKihZLzDmWmTHVl5a1ig6
         GQYA==
X-Gm-Message-State: AOJu0YySnoIo4Hq8Qin+3kjVNYOY+8eHSO7udd1W31HR+zxHvKsa3Vpg
        aH3ACo6QjAx6/GV8gMZyXUZdhDXZmkH8yZ1AxkSA2ikXguWp4hJpN8+/bjzPNphYWB+7XG5lGoF
        gzViTOHmsI6EDTjHjzrWDUhZt
X-Received: by 2002:a19:740e:0:b0:507:a1dd:5a86 with SMTP id v14-20020a19740e000000b00507a1dd5a86mr4098733lfe.13.1697641662357;
        Wed, 18 Oct 2023 08:07:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy/4zb+S5NM6sEmS0XLktdnB9E2DgK42NBe1FM60xzp+eEpX+jYGqKyBED2FMOWx4ESBVAZQ==
X-Received: by 2002:a19:740e:0:b0:507:a1dd:5a86 with SMTP id v14-20020a19740e000000b00507a1dd5a86mr4098704lfe.13.1697641662008;
        Wed, 18 Oct 2023 08:07:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c355200b00407752bd834sm1932821wmq.1.2023.10.18.08.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 08:07:41 -0700 (PDT)
Date:   Wed, 18 Oct 2023 11:07:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jiang Dongxu <jiangdongxu1@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, longpeng2@huawei.com,
        eric.fangyi@huawei.com, eperezma <eperezma@redhat.com>,
        Siwei Liu <loseweigh@gmail.com>
Subject: Re: [PATCH 0/2] vdpa: Add logging operatins
Message-ID: <20231018110719-mutt-send-email-mst@kernel.org>
References: <cover.1693012755.git.jiangdongxu1@huawei.com>
 <CACGkMEsP+3nTjG8gj0PoYg0DvyqqOpJKoAxG=m27t+iv-6GVbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsP+3nTjG8gj0PoYg0DvyqqOpJKoAxG=m27t+iv-6GVbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 02:56:58PM +0800, Jason Wang wrote:
> Adding Eugenio and Si Wei.
> 
> On Sat, Aug 26, 2023 at 9:24 AM Jiang Dongxu <jiangdongxu1@huawei.com> wrote:
> >
> > From: jiangdongxu <jiangdongxu1@huawei.com>
> >
> > Currently, the vdpa device supports suspend and resume operations.
> > To support vdpa device live migration, we need to support logging
> > operations and device state save/load opertions.
> >
> > These series introduces some new operations for vdpa devices.
> > They allow vdpa to enable logging while vm start live migration.
> >
> > And I will submit another patches about saving and loading
> > vdpa device state later.
> 
> Thanks for working on this, I have several questions:
> 
> 1) Is there an example implementation of the logging in the drivers?
> We need a real user in order to merge this.
> 2) Is the logging based on IOVA or VA? How the DMA isolation is being
> done with this? Do we need a SET_LOGGING_ASID uAPI for this? (We had
> some discussion on this in the past).
> 
> Thanks


Seems to be stuck. Dropped this for now.

> >
> > jiangdongxu (2):
> >   vdpa: add log operations
> >   vhost-vdpa: add uAPI for logging
> >
> >  drivers/vhost/vdpa.c       | 49 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/vdpa.h       | 14 +++++++++++
> >  include/uapi/linux/vhost.h |  4 ++++
> >  3 files changed, 67 insertions(+)
> >
> > --
> > 2.27.0
> >

