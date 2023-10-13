Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE107C7B75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJMCDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJMCDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C46C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697162538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1BZTAWCLnjPY0yXHnQbDlEMs44wsXzwC+R4ev+Nup1M=;
        b=BBL6OZuA2DGG6E/qST9GDILN+vWaGWU0qUUQnQGb+B/hKC5GORAqVABo/s1qPbJUQWdoJ4
        yzvPgJmbRglhuoA3rjmb7o0sqGN7FmfEnF1viYJv7E0IMmPDcyaHrw5cZDRvHRV0MQNmtR
        KCLwsg9A+xotUj9EfNKqYcuKpRMcqIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-4u3xc-cXMd-J70mk6Nx6XQ-1; Thu, 12 Oct 2023 22:01:59 -0400
X-MC-Unique: 4u3xc-cXMd-J70mk6Nx6XQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E9D988B7A6;
        Fri, 13 Oct 2023 02:01:59 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E997486F32;
        Fri, 13 Oct 2023 02:01:53 +0000 (UTC)
Date:   Fri, 13 Oct 2023 10:01:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: add module parameter to not run block kworker on
 isolated CPUs
Message-ID: <ZSilDBknf2yqDKNB@fedora>
References: <20231010142216.1114752-1-ming.lei@redhat.com>
 <ZSWb2DNV9cIPYv5H@slm.duckdns.org>
 <ZSXuqZNsyjJk1FGX@fedora>
 <ZShPS46jgVsaBGHY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZShPS46jgVsaBGHY@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Thu, Oct 12, 2023 at 09:55:55AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Oct 11, 2023 at 08:39:05AM +0800, Ming Lei wrote:
> > I appreciate that any specific suggestions about dealing with isolated CPUs
> > generically for bound WQ can be shared.
> 
> Oh, all I meant was whether we can at least collect this into or at least
> adjacent to the existing housekeeping / isolcpu parameters. Let's say
> there's someone who really wants to isolated some CPUs, how would they find
> out the different parameters if they're scattered across different
> subsystems?

AFAIK, the issue is reported on RH Openshift environment and it is real use
case, some of CPUs are isolated for some dedicated tasks(such as network polling,
...) by passing "isolcpus=managed_irq nohz_full".

But blk-mq still queue kworker on these isolated CPUs, and cause very long
latency in nvme IO workloads. Joe should know the story much more then me.


Thanks,
Ming

