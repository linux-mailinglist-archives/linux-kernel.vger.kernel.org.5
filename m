Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2A7DE147
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbjKANCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343956AbjKANCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468DB7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698843701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U25hlv0d5a4u4nzaxOvc1rnVpT1wnO8Tahwawd9Dugw=;
        b=PN6kwg3lGGdEjG1TPyotGwaYQUAa6H1UeO0F9uzBzVgnxlXI6Or8+wW8ditydxJc1uCyZN
        jFr+NLGE6N4RckSumNEuOHGAizJ3UzsrmbMFdBr7F4siW3j4RVVCqfjUy3Bye8vXjKIekg
        ZNY0YvzTOXXkV0aL+MfnFSijzuqyMm0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-2ezJ4zgFPuanvqmoCi_2Yw-1; Wed, 01 Nov 2023 09:01:37 -0400
X-MC-Unique: 2ezJ4zgFPuanvqmoCi_2Yw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae0601d689so453474966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 06:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698843696; x=1699448496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U25hlv0d5a4u4nzaxOvc1rnVpT1wnO8Tahwawd9Dugw=;
        b=nl7RyQ/CvI7uQ82spho6QUmYEscK7TCJc8hv6QWW2HPF+yLP4hhFzEwnVA7aBaOXb3
         rORK4zhn9AHKba/rumOkGawpKQbvMo+Xa+zNU6P9uR93Q5ROX0shE9wwAo8xmLS2m73P
         1ce4xT9hNNLv3ZeTPlFuxkBt7uTaM49LGBhec1csPhw7GBAXZftyyhZVzviJ17CqTZKs
         CRs77OmkvsUnIEY4qdLbESL4Qc3na/akGarIROnKsZWRiQixwLip5L+a+sjilU3ZxF2c
         cnfEpzWsNs7pSrNlg8Uy29fG1T4EFSrcGqhN61o9juJn6wQfLlcc1fDxiY9jO6xeAGRl
         WkNA==
X-Gm-Message-State: AOJu0YzMxeUCZY3Jc5tCSHcBeQ45QooC8qpJtMomUN78qdrTTEzu7Ez+
        uxQpUyQ+0SbygBUdohhPEOOrExKzPvis7yk9pD84tGkZpJkm7nfRm/60x0xRdVH0v9HmZeLo52R
        YYgyVMuVQE+PbFjodX+cw0L0d
X-Received: by 2002:a17:906:b008:b0:9d5:d803:31ee with SMTP id v8-20020a170906b00800b009d5d80331eemr1617001ejy.34.1698843695927;
        Wed, 01 Nov 2023 06:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERo4+i+XMFGmYaRUefWF1xxE2JKB60Ea01trIxcM+Pd00A2B92UcuBtp4Hc8zdtSJw0q8cqQ==
X-Received: by 2002:a17:906:b008:b0:9d5:d803:31ee with SMTP id v8-20020a170906b00800b009d5d80331eemr1616963ejy.34.1698843695452;
        Wed, 01 Nov 2023 06:01:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:e470:9af7:1504:1b35:8a09])
        by smtp.gmail.com with ESMTPSA id oz3-20020a170906cd0300b00977eec7b7e8sm2378853ejb.68.2023.11.01.06.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 06:01:34 -0700 (PDT)
Date:   Wed, 1 Nov 2023 09:01:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jiang Dongxu <jiangdongxu1@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, longpeng2@huawei.com,
        eric.fangyi@huawei.com, eperezma <eperezma@redhat.com>,
        Siwei Liu <loseweigh@gmail.com>
Subject: Re: [PATCH 0/2] vdpa: Add logging operatins
Message-ID: <20231101090114-mutt-send-email-mst@kernel.org>
References: <cover.1693012755.git.jiangdongxu1@huawei.com>
 <CACGkMEsP+3nTjG8gj0PoYg0DvyqqOpJKoAxG=m27t+iv-6GVbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsP+3nTjG8gj0PoYg0DvyqqOpJKoAxG=m27t+iv-6GVbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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


No answer so far so I'll drop this for now.

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

