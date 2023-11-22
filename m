Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA3D7F3FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjKVIUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjKVIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:20:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006E198
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700641196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NIoITgQxtiObzPXLhbMbQ4g44rH9YUmiKgRrHrYsxWk=;
        b=FFuy4uKp92dGR4THblPwM/BRZYSLHNl3NCQTUT4gz9QLg8v6gkXOxTFtU+kxFwSxIs56lg
        Hzb87qEUqJUOAKooRRi983hKxsrwXHjVDX2VqRaCbevrl/2lYiZDHA1rb/kmKO+VKroY3m
        DqHra0PNbVn04y4H/ugMDALVwvCqvn4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-Y8eM_pUwMYakn0zSjgAXzg-1; Wed,
 22 Nov 2023 03:19:50 -0500
X-MC-Unique: Y8eM_pUwMYakn0zSjgAXzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B1A93C10146;
        Wed, 22 Nov 2023 08:19:50 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BBCBC1596F;
        Wed, 22 Nov 2023 08:19:45 +0000 (UTC)
Date:   Wed, 22 Nov 2023 16:19:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Message-ID: <ZV25nGGMYQuyclK6@fedora>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
 <ZV2tuLCH2cPXxQ30@infradead.org>
 <ZV2xlDgkLpPeUhHN@fedora>
 <ZV2zbTPTZ0qC2F1U@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV2zbTPTZ0qC2F1U@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:53:17PM -0800, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 03:45:24PM +0800, Ming Lei wrote:
> > All the existed 'bool' flags are not atomic RW, so I think it isn't
> > necessary to define 'bd_flags' as 'unsigned long' for replacing them.
> 
> So because the old code wasn't correct we'll never bother?  The new
> flag and the new placement certainly make this more critical as well.

Can you explain why the old code was wrong?

1) ->bd_read_only and ->bd_make_it_fail

- set from userspace interface(ioctl or sysfs)
- check in IO code path

so changing it into atomic bit doesn't make difference from user
viewpoint.

2) ->bd_write_holder

disk->open_mutex is held for read & write this flag

3) ->bd_has_submit_bio

This flag is setup as oneshot before adding disk, and check in FS io code
path.

Of course, defining it as 'unsigned long' can extend its future usage, but
it depends on the atomic requirement of each flag itself.


Thanks, 
Ming

