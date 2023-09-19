Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D337A5F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjISKPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjISKOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:14:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6645FED;
        Tue, 19 Sep 2023 03:14:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE1461FE31;
        Tue, 19 Sep 2023 10:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695118478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BqMbcEnQ6os/yIzidgiwTsnnSh4DkvSm5AJWdUsULfE=;
        b=Fp7OOz3L93luSmwVfhBCp68Y20TYaHVbKgP6lCIjwGRzEMd+Gc2PM1a+AX79JNKOP+qm/Z
        yVyNRADOSl3nUis7Df3OTJ2jZVbWDdaX6/G+YRlf7QPx9jEBFlL1kVncQYXVbYKaS/e1BH
        qviGDotKFrCVuguDTOHhAoZVKQ7Wd7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695118478;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BqMbcEnQ6os/yIzidgiwTsnnSh4DkvSm5AJWdUsULfE=;
        b=Z5Eo2NGRMZGb7i/dOdfMTwT4lw+u68vIhb8Kte0KDpOSdDOfWXSlykBzJBkUeIs4s6rS3g
        SEs2Su87ZNrlZgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D960A13458;
        Tue, 19 Sep 2023 10:14:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lUXtNI50CWUbQwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 19 Sep 2023 10:14:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5D08FA0759; Tue, 19 Sep 2023 12:14:38 +0200 (CEST)
Date:   Tue, 19 Sep 2023 12:14:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v3] jbd2: Fix potential data lost in recovering journal
 raced with synchronizing fs bdev
Message-ID: <20230919101438.rjmxut6l2d6ufwnj@quack3>
References: <20230919012525.1783108-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919012525.1783108-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-09-23 09:25:25, Zhihao Cheng wrote:
> JBD2 makes sure journal data is fallen on fs device by sync_blockdev(),
> however, other process could intercept the EIO information from bdev's
> mapping, which leads journal recovering successful even EIO occurs during
> data written back to fs device.
> 
> We found this problem in our product, iscsi + multipath is chosen for block
> device of ext4. Unstable network may trigger kpartx to rescan partitions in
> device mapper layer. Detailed process is shown as following:
> 
>   mount          kpartx          irq
> jbd2_journal_recover
>  do_one_pass
>   memcpy(nbh->b_data, obh->b_data) // copy data to fs dev from journal
>   mark_buffer_dirty // mark bh dirty
>          vfs_read
> 	  generic_file_read_iter // dio
> 	   filemap_write_and_wait_range
> 	    __filemap_fdatawrite_range
> 	     do_writepages
> 	      block_write_full_folio
> 	       submit_bh_wbc
> 	            >>  EIO occurs in disk  <<
> 	                     end_buffer_async_write
> 			      mark_buffer_write_io_error
> 			       mapping_set_error
> 			        set_bit(AS_EIO, &mapping->flags) // set!
> 	    filemap_check_errors
> 	     test_and_clear_bit(AS_EIO, &mapping->flags) // clear!
>  err2 = sync_blockdev
>   filemap_write_and_wait
>    filemap_check_errors
>     test_and_clear_bit(AS_EIO, &mapping->flags) // false
>  err2 = 0
> 
> Filesystem is mounted successfully even data from journal is failed written
> into disk, and ext4/ocfs2 could become corrupted.
> 
> Fix it by comparing the wb_err state in fs block device before recovering
> and after recovering.
> 
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217888
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  v1->v3: Initialize wb_err. Untialized wb_err could be same with
> 	 mapping->wb_err(eg. EIO without ERRSEQ_SEEN). When EIO
> 	 occurs again, mapping->wb_err won't be changed, and wb_err
> 	 is still same with mapping->wb_err.

Yeah, good catch. The patch still looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


>  fs/jbd2/recovery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index c269a7d29a46..5b771a3d8d9a 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -289,6 +289,8 @@ int jbd2_journal_recover(journal_t *journal)
>  	journal_superblock_t *	sb;
>  
>  	struct recovery_info	info;
> +	errseq_t		wb_err;
> +	struct address_space	*mapping;
>  
>  	memset(&info, 0, sizeof(info));
>  	sb = journal->j_superblock;
> @@ -306,6 +308,9 @@ int jbd2_journal_recover(journal_t *journal)
>  		return 0;
>  	}
>  
> +	wb_err = 0;
> +	mapping = journal->j_fs_dev->bd_inode->i_mapping;
> +	errseq_check_and_advance(&mapping->wb_err, &wb_err);
>  	err = do_one_pass(journal, &info, PASS_SCAN);
>  	if (!err)
>  		err = do_one_pass(journal, &info, PASS_REVOKE);
> @@ -327,6 +332,9 @@ int jbd2_journal_recover(journal_t *journal)
>  
>  	jbd2_journal_clear_revoke(journal);
>  	err2 = sync_blockdev(journal->j_fs_dev);
> +	if (!err)
> +		err = err2;
> +	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
>  	if (!err)
>  		err = err2;
>  	/* Make sure all replayed data is on permanent storage */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
