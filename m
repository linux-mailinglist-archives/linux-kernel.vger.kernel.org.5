Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274E57EC70A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbjKOPU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344389AbjKOPUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:20:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BF31B9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700061620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VyQzbJEnX2TdDTDcKx6zAX1Mn/CHxaqqGd8YZWvobWQ=;
        b=jDdX/KYS07U0bTKgAAu6x1+QEswB83+QLLnciCoeGxl8idLuEcoUU9EDvqBzkGWbPRNufG
        SqhGbuyHuCJmIIZwleckv15c49rGj4/cWlL7S4H6VDHAtraIb+1rN8IIArtx6nidlFoiZE
        b3kdXQacXCVWoueXE9Itw5U1kupNt5U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-7iAGC8ihN7-vKfyUrNYFRw-1; Wed,
 15 Nov 2023 10:20:17 -0500
X-MC-Unique: 7iAGC8ihN7-vKfyUrNYFRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC44D38117E6;
        Wed, 15 Nov 2023 15:20:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8D381121308;
        Wed, 15 Nov 2023 15:20:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <202311061616.cd495695-oliver.sang@intel.com>
References: <202311061616.cd495695-oliver.sang@intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     dhowells@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David Laight" <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput -16.9% regression
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3865841.1700061614.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Nov 2023 15:20:14 +0000
Message-ID: <3865842.1700061614@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I've got this to work - kind of.  Your test box has a lot more RAM t=
han
mine (192G according to the email), so I had to reduce the sizes and make =
it
delete the files between tests.  I ended up using the attached script to r=
un
things.  I don't see the statistical analysis stuff.

Anyway, with upstream Linus, I see something like:

	Count: 27
	Total: 10649173
	Range: 391374...398472
	Mean : 394413
	Stdev: 10218

With that patch reverted, I see something like:

	Count: 27
	Total: 10665161
	Range: 391427...399601
	Mean : 395005
	Stdev: 13720

But the outcome is a bit variable and the result spaces overlap considerab=
ly.
I certainly don't see a 17% performance reduction.  Now, this may be due t=
o
hardware differences.  The CPU I'm using is an Intel i3-4170 - which is a =
few
years old at this point.

David
---
for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file=3D"$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file=3D"$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

#DATADIR=3D/mnt2/vm-scalability-tmp
#WORKDIR=3D$DATADIR/vm-scalability
#WORKDIR=3D/mnt2/vm-scalability
WORKDIR=3D/tmp/vm-scalability

cd /root/lkp-tests/pkg/vm-scalability/vm-scalability-lkp/lkp/benchmarks/vm=
-scalability
#mount -t tmpfs -o size=3D100% vm-scalability-tmp $DATADIR
#mkdir -p $DATADIR || exit $?
#truncate -s 10G $WORKDIR.img || exit $?
#mkfs.xfs -f -q $WORKDIR.img || exit $?
mkdir -p $WORKDIR || exit $?
#mount -o loop $WORKDIR.img $WORKDIR || exit $?
#./case-msync

truncate $WORKDIR/sparse-msync-1 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-1 -F --prealloc --open-=
rw 449340754
rm $WORKDIR/sparse-msync-1

truncate $WORKDIR/sparse-msync-2 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-2 -F --prealloc --open-=
rw 449340754
rm $WORKDIR/sparse-msync-2

truncate $WORKDIR/sparse-msync-3 -s 10G
truncate $WORKDIR/sparse-msync-4 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-3 -F --prealloc --open-=
rw 449340754
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-4 -F --prealloc --open-=
rw 449340754
rm $WORKDIR/sparse-msync-[34]

truncate $WORKDIR/sparse-msync-5 -s 10G
truncate $WORKDIR/sparse-msync-6 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-5 -F --prealloc --open-=
rw 449340754
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-6 -F --prealloc --open-=
rw 449340754
rm $WORKDIR/sparse-msync-[56]

truncate $WORKDIR/sparse-msync-7 -s 10G
truncate $WORKDIR/sparse-msync-8 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-7 -F --prealloc --open-=
rw 449340754
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-8 -F --prealloc --open-=
rw 449340754
rm $WORKDIR/sparse-msync-[78]

truncate $WORKDIR/sparse-msync-9 -s 10G
truncate $WORKDIR/sparse-msync-10 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-9 -F --prealloc --open-=
rw 449340754
truncate $WORKDIR/sparse-msync-11 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-10 -F --prealloc --open=
-rw 449340754
rm $WORKDIR/sparse-msync-{9,10}

truncate $WORKDIR/sparse-msync-12 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-11 -F --prealloc --open=
-rw 449340754
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-12 -F --prealloc --open=
-rw 449340754
rm $WORKDIR/sparse-msync-{11,12}

truncate $WORKDIR/sparse-msync-13 -s 10G
truncate $WORKDIR/sparse-msync-14 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-13 -F --prealloc --open=
-rw 449340754
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-14 -F --prealloc --open=
-rw 449340754
rm $WORKDIR/sparse-msync-{13,14}

truncate $WORKDIR/sparse-msync-15 -s 10G
truncate $WORKDIR/sparse-msync-16 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-15 -F --prealloc --open=
-rw 449340754
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-16 -F --prealloc --open=
-rw 449340754
rm $WORKDIR/sparse-msync-{15,16}

truncate $WORKDIR/sparse-msync-17 -s 10G
truncate $WORKDIR/sparse-msync-18 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-17 -F --prealloc --open=
-rw 449340754
truncate $WORKDIR/sparse-msync-19 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-18 -F --prealloc --open=
-rw 449340754
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-19 -F --prealloc --open=
-rw 449340754
rm $WORKDIR/sparse-msync-{17,18,19}

truncate $WORKDIR/sparse-msync-20 -s 10G
truncate $WORKDIR/sparse-msync-21 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-20 -F --prealloc --open=
-rw 449340754
truncate $WORKDIR/sparse-msync-22 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-21 -F --prealloc --open=
-rw 449340754
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-22 -F --prealloc --open=
-rw 449340754
rm $WORKDIR/sparse-msync-{20,21,22}

truncate $WORKDIR/sparse-msync-23 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-23 -F --prealloc --open=
-rw 449340754
rm $WORKDIR/sparse-msync-23
truncate $WORKDIR/sparse-msync-24 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-24 -F --prealloc --open=
-rw 449340754
rm $WORKDIR/sparse-msync-24
truncate $WORKDIR/sparse-msync-25 -s 10G
truncate $WORKDIR/sparse-msync-26 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-25 -F --prealloc --open=
-rw 449340754
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-26 -F --prealloc --open=
-rw 449340754
rm $WORKDIR/sparse-msync-{25,26}

truncate $WORKDIR/sparse-msync-27 -s 10G
truncate $WORKDIR/sparse-msync-28 -s 10G
./usemem --runtime 300 -S -f $WORKDIR/sparse-msync-27 -F --prealloc --open=
-rw 449340754
rm $WORKDIR/sparse-msync-{27,28}

