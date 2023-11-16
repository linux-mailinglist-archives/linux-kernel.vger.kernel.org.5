Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EFC7EDE44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbjKPKOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjKPKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B046D5C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700129655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/qSf17nLKwBzvhXGOsVf7cFolqlSlgq1S8Xm68Mw6Xg=;
        b=Wy1BUoBCI/lLr0wG67a9lJBUt0VbZxlzH5ums4U8JErYzGFaQAuZVl5Cr1OeB0uWV6tbiJ
        jmhgfYaxEEP/cPjXHPQe6necmycLOGQQtFlbfPcfc04fuE8/tU1TUc7BccHAv/eApz05cu
        I64LtjljL1vl5DoL5QjW8kjKldEzc2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-dMjoYVQONpiGjZaMrqRBHA-1; Thu, 16 Nov 2023 05:14:08 -0500
X-MC-Unique: dMjoYVQONpiGjZaMrqRBHA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07D0C101A529;
        Thu, 16 Nov 2023 10:14:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99618492BFD;
        Thu, 16 Nov 2023 10:14:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <4c0c3ee6cfa84d21a807055bc1aa27b8@AcuMS.aculab.com>
References: <4c0c3ee6cfa84d21a807055bc1aa27b8@AcuMS.aculab.com> <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk> <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com> <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com> <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com> <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=whFW+uWOmOtRNh0What_fu8Xo8KF2+EeUH1kn4qFxGAhA@mail.gmail.com> <CAHk-=whrc-ruKs4Kt90EGzKd+pYhZFKs6bgBVCV=55BK+p1nzg@mail.gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput -16.9% regression
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97467.1700129643.1@warthog.procyon.org.uk>
Date:   Thu, 16 Nov 2023 10:14:03 +0000
Message-ID: <97468.1700129643@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> On haswell (which is now quite old) both 'rep movsb' and
> 'rep movsq' copy 16 bytes/clock unless the destination
> is 32 byte aligned when they copy 32 bytes/clock.
> Source alignment make no different, neither does byte
> alignment.

I think the i3-4170 cpu I'm using is Haswell.  Does that mean for my
particular cpu, just using inline "rep movsb" is the best choice?

David

