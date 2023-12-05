Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F0804437
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbjLEBqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEBqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2511101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701740773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1C3Q/KwQSqG9yP6ISOd9Cb0ee81aaiJLrsTwyDo8cI=;
        b=GE8WddnCqe8U8dogiu0XJn5LLEJNuqegKbU9q5d+TdcRR+DSZaJvMiADw0X+EqebkdDjL0
        GYmDch4cMnqDSdAVIniy2xIDeGx1WEQvOW0n+uIsRTnfHx9hbB/Ww7PLBA5nt/rnMVYnKG
        27Atl4aqJq7ENTG9mzU2cCGqF8qoXag=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-wLc8U6qJMbyT2DZnFWgRjQ-1; Mon, 04 Dec 2023 20:46:09 -0500
X-MC-Unique: wLc8U6qJMbyT2DZnFWgRjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 242C785A5B5;
        Tue,  5 Dec 2023 01:46:08 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BB08C1596F;
        Tue,  5 Dec 2023 01:45:58 +0000 (UTC)
Date:   Tue, 5 Dec 2023 09:45:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Message-ID: <ZW6A0R04Gk/04EHj@fedora>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <ZW05th/c0sNbM2Zf@fedora>
 <03a87103-0721-412c-92f5-9fd605dc0c74@oracle.com>
 <ZW3DracIEH7uTyEA@fedora>
 <bd639010-2ad7-4379-ba0a-64b5f6ebec41@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd639010-2ad7-4379-ba0a-64b5f6ebec41@oracle.com>
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

On Mon, Dec 04, 2023 at 01:13:55PM +0000, John Garry wrote:
> 
> > > 
> > > I added this here (as opposed to the caller), as I was not really worried
> > > about speeding up the failure path. Are you saying to call even earlier in
> > > submission path?
> > atomic_write_unit_min is one hardware property, and it should be checked
> > in blk_queue_atomic_write_unit_min_sectors() from beginning, then you
> > can avoid this check every other where.
> 
> ok, but we still need to ensure in the submission path that the block device
> actually supports atomic writes - this was the initial check.

Then you may add one helper bdev_support_atomic_write().

> 
> > 
> > > > > +	if (pos % atomic_write_unit_min_bytes)
> > > > > +		return false;
> > > > > +	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
> > > > > +		return false;
> > > > > +	if (!is_power_of_2(iov_iter_count(iter)))
> > > > > +		return false;
> > > > > +	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
> > > > > +		return false;
> > > > > +	if (pos % iov_iter_count(iter))
> > > > > +		return false;
> > > > I am a bit confused about relation between atomic_write_unit_max_bytes and
> > > > atomic_write_max_bytes.
> > > I think that naming could be improved. Or even just drop merging (and
> > > atomic_write_max_bytes concept) until we show it to improve performance.
> > > 
> > > So generally atomic_write_unit_max_bytes will be same as
> > > atomic_write_max_bytes, however it could be different if:
> > > a. request queue nr hw segments or other request queue limits needs to
> > > restrict atomic_write_unit_max_bytes
> > > b. atomic_write_unit_max_bytes does not need to be a power-of-2 and
> > > atomic_write_max_bytes does. So essentially:
> > > atomic_write_unit_max_bytes = rounddown_pow_of_2(atomic_write_max_bytes)
> > > 
> > plug merge often improves sequential IO perf, so if the hardware supports
> > this way, I think 'atomic_write_max_bytes' should be supported from the
> > beginning, such as:
> > 
> > - user space submits sequential N * (4k, 8k, 16k, ...) atomic writes, all can
> > be merged to single IO request, which is issued to driver.
> > 
> > Or
> > 
> > - user space submits sequential 4k, 4k, 8k, 16K, 32k, 64k atomic writes, all can
> > be merged to single IO request, which is issued to driver.
> 
> Right, we do expect userspace to use a fixed block size, but we give scope
> in the API to use variable size.

Maybe it is enough to just take atomic_write_unit_min_bytes
only, and allow length to be N * atomic_write_unit_min_bytes.

But it may violate atomic write boundary?

> 
> > 
> > The hardware should recognize unit size by start LBA, and check if length is
> > valid, so probably the interface might be relaxed to:
> > 
> > 1) start lba is unit aligned, and this unit is in the supported unit
> > range(power_2 in [unit_min, unit_max])
> > 
> > 2) length needs to be:
> > 
> > - N * this_unit_size
> > - <= atomic_write_max_bytes
> 
> Please note that we also need to consider:
> - any atomic write boundary (from NVMe)

Can you provide actual NVMe boundary value?

Firstly natural aligned write won't cross boundary, so boundary should
be >= write_unit_max, see blow code from patch 10/21:

+static bool bio_straddles_atomic_write_boundary(loff_t bi_sector,
+				unsigned int bi_size,
+				unsigned int boundary)
+{
+	loff_t start = bi_sector << SECTOR_SHIFT;
+	loff_t end = start + bi_size;
+	loff_t start_mod = start % boundary;
+	loff_t end_mod = end % boundary;
+
+	if (end - start > boundary)
+		return true;
+	if ((start_mod > end_mod) && (start_mod && end_mod))
+		return true;
+
+	return false;
+}
+

Then if the WRITE size is <= boundary, the above function should return
false, right? Looks like it is power_of(2) & aligned atomic_write_max_bytes?

> - virt boundary (from NVMe)

virt boundary is applied on bv_offset and bv_len, and NVMe's virt
bounary is (4k - 1), it shouldn't be one issue in reality.

> 
> And, as I mentioned elsewhere, I am still not 100% comfortable that we don't
> pay attention to regular max_sectors_kb...

max_sectors_kb should be bigger than atomic_write_max_bytes actually,
then what is your concern?



Thanks,
Ming

