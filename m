Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10870802AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 04:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjLDD4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 22:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDD4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 22:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D296CC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 19:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701662172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xNKUQpE6ACEyF1q91AK5Pa8cyyFRcdXFb2KIn9j+Qic=;
        b=ZTDOdNL4Ej95SNEAK13RgkV9ESUn+iltWoD1Ud3ZXYjuESJxBQEGt1gLOMUHY79FrWe+bW
        zmR9mKTTVwZRTn+KCM+Xq/CGYRmTRWqyp4YVi4NPf9eQBO6MntWr1ZD3chhpTca1GgUcyM
        EIUCP/e5o49k8jIeTbjDh3f+5/HMayE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-z5VdyYmhPpumcRg0ll2h0w-1; Sun,
 03 Dec 2023 22:56:07 -0500
X-MC-Unique: z5VdyYmhPpumcRg0ll2h0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 988FF3803515;
        Mon,  4 Dec 2023 03:56:06 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4215C1596F;
        Mon,  4 Dec 2023 03:55:55 +0000 (UTC)
Date:   Mon, 4 Dec 2023 11:55:50 +0800
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
Subject: Re: [PATCH 02/21] block: Limit atomic writes according to bio and
 queue limits
Message-ID: <ZW1NxiEh2x82SOai@fedora>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-3-john.g.garry@oracle.com>
 <ZW1FOFWsUGUNLajE@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW1FOFWsUGUNLajE@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 11:19:20AM +0800, Ming Lei wrote:
> On Fri, Sep 29, 2023 at 10:27:07AM +0000, John Garry wrote:
> > We rely the block layer always being able to send a bio of size
> > atomic_write_unit_max without being required to split it due to request
> > queue or other bio limits.
> > 
> > A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors,
> > and each vector is at worst case the device logical block size from
> > direct IO alignment requirement.
> 
> Both unit_max and unit_min are applied to FS bio, which is built over
> single userspace buffer, so only the 1st and last vector can include

Actually it isn't true for pwritev, and sorry for the noise.

Thanks,
Ming

