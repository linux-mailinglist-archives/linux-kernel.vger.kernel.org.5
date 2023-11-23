Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA9C7F565D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbjKWCTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjKWCTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CCA1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700705984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k2aZzryTXfwVm4bHgxcYkBHTBkYi7Y8xjXsoz4m2WKU=;
        b=cCmbqFd41WsUIqjG2zmPm8mJDn4Y1vRRzG5OVZaGBONVGWlPsHXPPlYajPhfVcM/QLTJio
        bg5O3YwM76hR2oqNA61HSJ/OGr3QMxpuGsRmYW/gRedv8Xjj3pAJD1bVm8poumB3AtF1jg
        56egW/5Ln8q6KLIjJBxgGtz9rRysE9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-_OvJFeQrOSu_YCCI76BTjg-1; Wed, 22 Nov 2023 21:19:40 -0500
X-MC-Unique: _OvJFeQrOSu_YCCI76BTjg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47A3E80D722;
        Thu, 23 Nov 2023 02:19:40 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D79A492BFA;
        Thu, 23 Nov 2023 02:19:34 +0000 (UTC)
Date:   Thu, 23 Nov 2023 10:19:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Message-ID: <ZV62svvu5MSUGoPD@fedora>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
 <ZV2tuLCH2cPXxQ30@infradead.org>
 <ZV2xlDgkLpPeUhHN@fedora>
 <ZV2zbTPTZ0qC2F1U@infradead.org>
 <ZV25nGGMYQuyclK6@fedora>
 <ZV34d/hI12pKFUzj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV34d/hI12pKFUzj@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 04:47:51AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 04:19:40PM +0800, Ming Lei wrote:
> > On Tue, Nov 21, 2023 at 11:53:17PM -0800, Christoph Hellwig wrote:
> > > On Wed, Nov 22, 2023 at 03:45:24PM +0800, Ming Lei wrote:
> > > > All the existed 'bool' flags are not atomic RW, so I think it isn't
> > > > necessary to define 'bd_flags' as 'unsigned long' for replacing them.
> > > 
> > > So because the old code wasn't correct we'll never bother?  The new
> > > flag and the new placement certainly make this more critical as well.
> > 
> > Can you explain why the old code was wrong?
> > 
> > 1) ->bd_read_only and ->bd_make_it_fail
> > 
> > - set from userspace interface(ioctl or sysfs)
> > - check in IO code path
> > 
> > so changing it into atomic bit doesn't make difference from user
> > viewpoint.
> 
> > 
> > 2) ->bd_write_holder
> > 
> > disk->open_mutex is held for read & write this flag
> > 
> > 3) ->bd_has_submit_bio
> > 
> > This flag is setup as oneshot before adding disk, and check in FS io code
> > path.
> 
> On architectures that can't do byte-level atomics all three can corrupt
> each other

Yeah, C/C++ doesn't provide such guarantee, but many modern ARCHs [1]
guarantees that RW on naturally aligned type is atomic.

I verified the point on x86/arm64/ppc64le by the following code, and
all three STOREs are done in single instruction.

	struct data {
		int b;
		char a;
		char a2;
		char a3;
		char a4;
	} __attribute__((aligned(8)));
	
	void atomic_test()
	{
		struct data d;
	
		d.b = 1;
		d.a = 2;
		d.a3 = 3;
	
		printf("%d %d %d\n", d.b, d.a, d.a3);
	}

[1] https://preshing.com/20130618/atomic-vs-non-atomic-operations/

> and even worse bd_partno.  Granted that is only alpha these
> days IIRC, but it's still buggy.

bd_has_submit_bio and bd_partno can be thought as read only, and the
two can be corrupted?

bd_dev may have similar trouble with bd_partno for ARCHs which don't
provide atomic RW on naturally aligned int.


Thanks,
Ming

