Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9421877AF63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjHNCFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjHNCFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5D01717
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691978638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OkkvN5LaeJ7jSZxGFsHd4Qul6dNlN5wnF04FypSAqNk=;
        b=EmJruo35XaHhK8JlvSfLEHsQWH+OgNNIMy/bw/gmA2xcLgMcwSN+nUgvpBVH/+wi6+uuIZ
        L4lmeTpdbTa3fsasKzAwIrzPfsFe2hpQS5XTKaadu+1as/UODuljfaQK2TNcvoYrJYGHxz
        Z0+/QucJM5xAAHO0qtAbTX2mk2ZJ6r4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-BNu-ZOwjOI-42Xcp2PFdzA-1; Sun, 13 Aug 2023 22:03:54 -0400
X-MC-Unique: BNu-ZOwjOI-42Xcp2PFdzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89513C02532;
        Mon, 14 Aug 2023 02:03:53 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53B33400DE97;
        Mon, 14 Aug 2023 02:03:48 +0000 (UTC)
Date:   Mon, 14 Aug 2023 10:03:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guangwu Zhang <guazhang@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH] lib/group_cpus.c: avoid to acquire cpu hotplug lock in
 group_cpus_evenly
Message-ID: <ZNmLgBW06NZWUMo1@fedora>
References: <20230810021640.252033-1-ming.lei@redhat.com>
 <CAGS2=Ypt3U6AiR77B-WDUMB5atGt9YsuQoEn+PgZVmcH0n8tXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS2=Ypt3U6AiR77B-WDUMB5atGt9YsuQoEn+PgZVmcH0n8tXg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas and Guys,

On Fri, Aug 11, 2023 at 06:59:25PM +0800, Guangwu Zhang wrote:
> Hi Ming,
> I don't find any IO block after apply the patch.
> 
> Tested-by: Guangwu Zhang <guazhang@redhat.com>

Can you take a look at this fix? And this one solves a couple
of nvme io hang report in case of cpu hotplug & reset involved.

Thanks,
Ming

