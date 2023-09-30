Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223AF7B42F9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 20:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjI3SUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 14:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjI3SUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 14:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0933FD3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696097968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gv73ytAfKviSPiQIHeC0hOen5aE24T4EuTj3zfm6kg=;
        b=iNKrzqac58PCKLXoJlNR860t9O4pRK4gJKwR6nwmnUfso/Ph+EIOl+Jcs4dHb2TEZNnAN8
        zMH76iXBENkZZY2b1zjaIdMZZpNIr+8GC6epVR0J05src+aEgGiRax3b74Y7LVxOJ5cFLj
        RB8mi5m5AW74lC9lwZp7ii1Ee8Zwfz0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-v3BXl96tM-m7aKMVceXfLA-1; Sat, 30 Sep 2023 14:19:24 -0400
X-MC-Unique: v3BXl96tM-m7aKMVceXfLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3182185A78E;
        Sat, 30 Sep 2023 18:19:23 +0000 (UTC)
Received: from rhel-developer-toolbox (unknown [10.2.16.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C8C62156A27;
        Sat, 30 Sep 2023 18:19:22 +0000 (UTC)
Date:   Sat, 30 Sep 2023 11:19:20 -0700
From:   Chris Leech <cleech@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023093055-gotten-astronomy-a98b@gregkh>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 09:06:51AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 29, 2023 at 10:00:23AM -0700, Chris Leech wrote:
> > Make use of the new UIO_MEM_DMA_COHERENT type to properly handle mmap
> > for dma_alloc_coherent buffers.
> 
> Why are ethernet drivers messing around with UIO devices?  That's not
> what UIO is for, unless you are trying to do kernel bypass for these
> devices without anyone noticing?
> 
> confused,

It's confusing. The bnx2 driver stack included a cnic (converged nic?)
module that sits between the ethernet drivers (bnx2, bnx2x) and protocol
offload drivers (iscsi, fcoe, rdma).

The iscsi module (bnx2i) uses a passthrough interface from cnic to
handle some network configuration that the device firmware doesn't do.
It uses a uio device and a userspace component called iscsiuio to do
that.

Questions beyond that will probably need to be answer by one of the many
Marvell engineers copied on this thread.

- Chris

