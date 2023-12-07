Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD58080DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377524AbjLGGij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGGii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126CDD59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701931124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWU3XhY3SGz8Nm4Q405d0erGPeXKkfHuFXSX394aJLk=;
        b=F8SpE+xTqNcOxnosIq2kwiHdPxTGD1nykvYX5r11gyU17crEKzI2QI07h0hPo8xtDY4duV
        L7oOYwh6Uw2oKRJWpEvRx62S/4qc78d2dKfLlGX8SSw053Erv9acqfOgCSrJ5qJmfvKYaT
        /NVlbHVBnMbNWoBQ4tQYbvCmtIy7VEY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-lgdW7a0BM-62ywO_z42CsA-1; Thu, 07 Dec 2023 01:38:42 -0500
X-MC-Unique: lgdW7a0BM-62ywO_z42CsA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1eb3f3dc2eso17893066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 22:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701931121; x=1702535921;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWU3XhY3SGz8Nm4Q405d0erGPeXKkfHuFXSX394aJLk=;
        b=eGkgS4ixpR85IU5A5lvvgeiX0+2o7OO7ih9YAGRPssIzA6OR3Ded1O4rEb8CmeT7GC
         xn/eMhO8oVE4PRKhIv8b74YelKnm9+0fkUzStAv7xv5UbXEs/fxaa2a7Ul+Z8mvTKTO/
         sgzhTSR4KfMQXF1SEq5CYFk1GeD+nXzQLwui8UN8g2Bjl3g6C0tLIUYP88ymSsfaV9eT
         bBzl2S8+FMQwSpqLcz8oZiUHrvI61KkFedRbFfg/Acv5r7mNYjPniUQUcoUfUuKDF2Kj
         A4NbVV4exyn0RXnBL4UZOZFrH5Hn90H7AmGtwro4uObz32cA2hzSHzEzz1kPtFY6ETsi
         BBcQ==
X-Gm-Message-State: AOJu0YxSwARJKYlNf12u24pxo4W8HtwkND5wfLuZGxKYhr16JemfB+J+
        PGZbbzk2ZvDf3K1iaNuLvx38r/U8JmY76FAcDzBd+pDwvBzQaV4mBwR/rP48x9fe91TfND7eVkx
        Yfg7oziVRiD3ttd7wqEArwnz6
X-Received: by 2002:a17:906:412:b0:a19:a1ba:8cdf with SMTP id d18-20020a170906041200b00a19a1ba8cdfmr1283535eja.125.1701931121431;
        Wed, 06 Dec 2023 22:38:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhiBhaS+kmbU1JKx2cAFUfZmT6awaVyiVkat1D9D0v41JMF0DlUXomnGzVKOZQPNjGyvsaNQ==
X-Received: by 2002:a17:906:412:b0:a19:a1ba:8cdf with SMTP id d18-20020a170906041200b00a19a1ba8cdfmr1283523eja.125.1701931121146;
        Wed, 06 Dec 2023 22:38:41 -0800 (PST)
Received: from redhat.com ([2.55.11.67])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906c30600b00a1dee0289b4sm376148ejz.169.2023.12.06.22.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 22:38:40 -0800 (PST)
Date:   Thu, 7 Dec 2023 01:38:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231207013617-mutt-send-email-mst@kernel.org>
References: <20231207043118.118158-1-fengli@smartx.com>
 <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 02:02:36PM +0800, Jason Wang wrote:
> On Thu, Dec 7, 2023 at 12:33 PM Li Feng <fengli@smartx.com> wrote:
> >
> > virtio-blk is generally used in cloud computing scenarios, where the
> > performance of virtual disks is very important. The mq-deadline scheduler
> > has a big performance drop compared to none with single queue.
> 
> At least you can choose the scheduler based on if mq is supported or not?
> 
> Thanks

This is already the case:

static struct elevator_type *elevator_get_default(struct request_queue *q)
{
        if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
                return NULL;

        if (q->nr_hw_queues != 1 &&
            !blk_mq_is_shared_tags(q->tag_set->flags))
                return NULL;

        return elevator_find_get(q, "mq-deadline");
}

I guess I agree blk is typically kind of similar to loopback
so none by default makes sense here same as for loopback.

Stefan care to comment?

-- 
MST

