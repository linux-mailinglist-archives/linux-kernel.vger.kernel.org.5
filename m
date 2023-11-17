Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD31A7EF42E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjKQOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQOMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:12:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C7C5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700230348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C+D0LhO6NECogVwI5g3Kwjiq5nOgvXFKjlmubrqlGHE=;
        b=D0DODdQ1QlQOmMGUzRONMyA/577l3sxd6vKkZyEZAbN208xymJoFJ0xAzzpbchMVPlmc/C
        0hp3ta6CoaUONVrPlKP/UItAxEINOgGjBieru6kGmwgeSdU555X9kGFRr0Tg7n0rONi5VK
        +DM6z9xooupplr0DPYRKsaPBaJBohyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-wzdnngaRM4yo03wd8meQTQ-1; Fri, 17 Nov 2023 09:12:22 -0500
X-MC-Unique: wzdnngaRM4yo03wd8meQTQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D3B09758C1;
        Fri, 17 Nov 2023 14:12:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AA58492BE0;
        Fri, 17 Nov 2023 14:12:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231117113549.GBZVdQFQ7VrfsPd9mV@fat_crate.local>
References: <20231117113549.GBZVdQFQ7VrfsPd9mV@fat_crate.local> <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local> <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk> <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com> <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com> <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com> <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com> <232440.1700153046@warthog.procyon.org.uk>
To:     Borislav Petkov <bp@alien8.de>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput -16.9% regression
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <864269.1700230337.1@warthog.procyon.org.uk>
Date:   Fri, 17 Nov 2023 14:12:17 +0000
Message-ID: <864270.1700230337@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> wrote:

> Hmm, stupid question: are those results better than without that
> oneliner?

Without any changes, I see something like:

 iov_kunit_benchmark_bvec: avg 3185 uS, stddev 19 uS
 iov_kunit_benchmark_bvec: avg 3186 uS, stddev 9 uS
 iov_kunit_benchmark_bvec: avg 3244 uS, stddev 153 uS
 iov_kunit_benchmark_bvec_split: avg 3397 uS, stddev 16 uS
 iov_kunit_benchmark_bvec_split: avg 3400 uS, stddev 16 uS
 iov_kunit_benchmark_bvec_split: avg 3402 uS, stddev 34 uS
 iov_kunit_benchmark_kvec: avg 2818 uS, stddev 550 uS
 iov_kunit_benchmark_kvec: avg 2906 uS, stddev 21 uS
 iov_kunit_benchmark_kvec: avg 2923 uS, stddev 1496 uS
 iov_kunit_benchmark_xarray: avg 3564 uS, stddev 6 uS
 iov_kunit_benchmark_xarray: avg 3573 uS, stddev 17 uS
 iov_kunit_benchmark_xarray: avg 3575 uS, stddev 58 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 3929 uS, stddev 9 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 3930 uS, stddev 6 uS
 iov_kunit_benchmark_xarray_to_bvec: avg 3930 uS, stddev 7 uS

David

