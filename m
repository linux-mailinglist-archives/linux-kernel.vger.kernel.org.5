Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87467F3F24
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjKVHpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVHpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A6C197
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700639138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jTGOOSKEq2M9Q7E6uQFEx6Kxv1A8e9evjKXYaodJf9c=;
        b=fuDfCiodXAofXvsRSVjGucwJWNjsQCBN8/GCIE0rq6ztvRUKcC7SgxuwiCQW2CqlHPG6TD
        npe/OtnN2O1mNlIdEwIXZUeq5Slez66t3moF/o3tAVu+6+U6SYaa6/MwxAZbGYbb4DDQCd
        3Kfb7MfB8LqLKDUCp+ck01uXfYSh7uM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-d6584vmDO0Wf2Ns6rQrEnw-1; Wed, 22 Nov 2023 02:45:34 -0500
X-MC-Unique: d6584vmDO0Wf2Ns6rQrEnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA5FE89C666;
        Wed, 22 Nov 2023 07:45:33 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09A8640C6EB9;
        Wed, 22 Nov 2023 07:45:28 +0000 (UTC)
Date:   Wed, 22 Nov 2023 15:45:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Message-ID: <ZV2xlDgkLpPeUhHN@fedora>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
 <ZV2tuLCH2cPXxQ30@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV2tuLCH2cPXxQ30@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:28:56PM -0800, Christoph Hellwig wrote:
> > +	if (partno && bdev_flagged(disk->part0, BD_FLAG_HAS_SUBMIT_BIO))
> > +		bdev_set_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
> >  	else
> > +		bdev_clear_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
> 
> While the block layer has a bit of history of using wrappers for
> testing, setting and clearing flags, I have to say I always find them
> rather confusing when reading the code.
> 
> > +#define BD_FLAG_READ_ONLY	0 /* read-only-policy */
> 
> I know this is copied from the existing field, but can you expand
> it a bit?
> 
> > +#define BD_FLAG_WRITE_HOLDER	1
> > +#define BD_FLAG_HAS_SUBMIT_BIO	2
> > +#define BD_FLAG_MAKE_IT_FAIL	3
> 
> And also write comments for these. 
> 
> > +
> >  struct block_device {
> >  	sector_t		bd_start_sect;
> >  	sector_t		bd_nr_sectors;
> > @@ -44,10 +49,8 @@ struct block_device {
> >  	struct request_queue *	bd_queue;
> >  	struct disk_stats __percpu *bd_stats;
> >  	unsigned long		bd_stamp;
> > -	bool			bd_read_only;	/* read-only policy */
> > +	unsigned short		bd_flags;
> 
> I suspect you really need an unsigned long and atomic bit ops here.
> Even a lock would probably not work on alpha as it could affect
> the other fields in the same 32-bit alignment.
 
All the existed 'bool' flags are not atomic RW, so I think it isn't
necessary to define 'bd_flags' as 'unsigned long' for replacing them.

Thanks, 
Ming

