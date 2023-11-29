Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976BF7FDE50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjK2R0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2R0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:26:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D77ABD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701278777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DPMxPCyUCiU/DiBoTo+PVsbSuI7/XmfmesVjgz8N+MA=;
        b=LDNPlax3LG7tIA+rA4EAGrGGHMc6a4rzW8BIyqE0gw8BeapVe5q0aw98xyKoF4Y3uAI7KU
        1oGbEooRdMogO0p67tLPuosQTZGArIfC4QuJeAW9mSchqCgJtLuQ9e2yUqwmq0szxpzPfL
        Q6yMWCqcBnL2maAJNNgqd3suZUCuJ44=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-Ev4XW5WYNuOjmwnPQnEKOQ-1; Wed,
 29 Nov 2023 12:26:15 -0500
X-MC-Unique: Ev4XW5WYNuOjmwnPQnEKOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B84438143B2;
        Wed, 29 Nov 2023 17:26:08 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 472775038;
        Wed, 29 Nov 2023 17:26:08 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 3149230C1A8C; Wed, 29 Nov 2023 17:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 2EAB63FB76;
        Wed, 29 Nov 2023 18:26:08 +0100 (CET)
Date:   Wed, 29 Nov 2023 18:26:08 +0100 (CET)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Wu Bo <bo.wu@vivo.com>
cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dm verity: don't verity if readahead failed
In-Reply-To: <b23a4fc8baba99010c16059a236d2f72087199a1.1700623691.git.bo.wu@vivo.com>
Message-ID: <b84fb49-bf63-3442-8c99-d565e134f2@redhat.com>
References: <cover.1700623691.git.bo.wu@vivo.com> <b23a4fc8baba99010c16059a236d2f72087199a1.1700623691.git.bo.wu@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Nov 2023, Wu Bo wrote:

> We found an issue under Android OTA scenario that many BIOs have to do
> FEC where the data under dm-verity is 100% complete and no corruption.
> 
> Android OTA has many dm-block layers, from upper to lower:
> dm-verity
> dm-snapshot
> dm-origin & dm-cow
> dm-linear
> ufs
> 
> Dm tables have to change 2 times during Android OTA merging process.
> When doing table change, the dm-snapshot will be suspended for a while.
> During this interval, we found there are many readahead IOs are
> submitted to dm_verity from filesystem. Then the kverity works are busy
> doing FEC process which cost too much time to finish dm-verity IO. And
> cause system stuck.
> 
> We add some debug log and find that each readahead IO need around 10s to
> finish when this situation occurred. Because here has a IO
> amplification:
> 
> dm-snapshot suspend
> erofs_readahead     // 300+ io is submitted
> 	dm_submit_bio (dm_verity)
> 		dm_submit_bio (dm_snapshot)
> 		bio return EIO
> 		bio got nothing, it's empty
> 	verity_end_io
> 	verity_verify_io
> 	forloop range(0, io->n_blocks)    // each io->nblocks ~= 20
> 		verity_fec_decode
> 		fec_decode_rsb
> 		fec_read_bufs
> 		forloop range(0, v->fec->rsn) // v->fec->rsn = 253
> 			new_read
> 			submit_bio (dm_snapshot)
> 		end loop
> 	end loop
> dm-snapshot resume
> 
> Readahead BIO got nothing during dm-snapshot suspended. So all of them
> will do FEC.
> Each readahead BIO need to do io->n_blocks ~= 20 times verify.
> Each block need to do fec, and every block need to do v->fec->rsn = 253
> times read.
> So during the suspend interval(~200ms), 300 readahead BIO make
> 300*20*253 IOs on dm-snapshot.
> 
> As readahead IO is not required by user space, and to fix this issue,
> I think it would be better to pass it to upper layer to handle it.
> 
> Cc: stable@vger.kernel.org
> Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  drivers/md/dm-verity-target.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index beec14b6b044..14e58ae70521 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -667,7 +667,9 @@ static void verity_end_io(struct bio *bio)
>  	struct dm_verity_io *io = bio->bi_private;
>  
>  	if (bio->bi_status &&
> -	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
> +	    (!verity_fec_is_enabled(io->v) ||
> +	     verity_is_system_shutting_down() ||
> +	     (bio->bi_opf & REQ_RAHEAD))) {
>  		verity_finish_io(io, bio->bi_status);
>  		return;
>  	}
> -- 
> 2.25.1
> 

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

