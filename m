Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8579D2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbjILNwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjILNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FF7710D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694526687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5lfiJckN/13MGfvnlzv5q+pc0YoaLDh1Btxxg/r0Ec=;
        b=SpeSOHukgcfk0xocvq55pmEjzmGq1JbX0KqzggA052VayRJSgI0NEFpdQiP2wyMXjPoeXP
        Qsv5M/hOiqzJFWkcUAFDUdQWnCuPur8ZjG7ellOqX/2WwF7LqNDjg89RNj2YXI13gIOtKH
        MgRoE8mxMBtJ2cET1cka6BX+Eht8l6s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-5n4_CGvyOAGST_b0DkZxZQ-1; Tue, 12 Sep 2023 09:51:20 -0400
X-MC-Unique: 5n4_CGvyOAGST_b0DkZxZQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4131d4bc82dso68043241cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526671; x=1695131471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5lfiJckN/13MGfvnlzv5q+pc0YoaLDh1Btxxg/r0Ec=;
        b=f1XvJ57Pa7iCGKD7X6iTgeDuEUCl6pkYgxrET2xiPH8A9BH7uRC6J+oo/m+9Fheaty
         KLfSGWD9OGup7Sp/E8JWj6Zs+5LnSK2JR3f6o1EfmSZmGXKhsMOZoi5w9p8t1MA8M1Ii
         0dwGTZt8ibWER6dfsWKqBNtsTFTdSpI1+9JfdQtOSSAam5f3M3wxR+JWQKBJyE4dzVy7
         TfWfVSBixFx6jIoywVjpNjjKICYdRmXBhmEb7clzcDQXeU14uqKopBOY38CXAnGWqlKN
         cUnW1rpvYI9LG7i0pk+2NgkalBqypEfuWfWb1uzQBuc2DsyH7GjFiXVxDqHe/Yzpk4lQ
         ASmw==
X-Gm-Message-State: AOJu0YyZc2Vfdx0/2/kO3YxXbnZ64oNDf3tLg2Irs20mCKs7D1orQjCy
        mLzH7KpcB1w2ghIxAm7oeunQiJyROSzC3i7HdRq77CKmBrOnXSMjLj2IlTB9s5VQk6Bs8DEXiku
        6O/7E6ypi67cuvFfkBcRTtWi4zdKNFw6l
X-Received: by 2002:a0c:cb8f:0:b0:655:71df:4c7d with SMTP id p15-20020a0ccb8f000000b0065571df4c7dmr12509686qvk.56.1694526671599;
        Tue, 12 Sep 2023 06:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2rIC7fM7Y4KuuARIkvnE5F0tW2H84N7tKoB+BEH77qqLzSPFO3gETYAg0qGQfzzu7r0gEdQ==
X-Received: by 2002:a0c:cb8f:0:b0:655:71df:4c7d with SMTP id p15-20020a0ccb8f000000b0065571df4c7dmr12509669qvk.56.1694526671279;
        Tue, 12 Sep 2023 06:51:11 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id z14-20020a0cfece000000b00655e5724eeasm1920387qvs.65.2023.09.12.06.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:51:10 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:51:23 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: Fix a handful of spelling mistakes in
 various messages
Message-ID: <ZQBs2yEEupnoa2ZI@bfoster>
References: <20230912082527.3913330-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912082527.3913330-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:25:27AM +0100, Colin Ian King wrote:
> There are several spelling mistakes in error messages. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/bcachefs/alloc_background.c | 2 +-
>  fs/bcachefs/backpointers.c     | 2 +-
>  fs/bcachefs/btree_iter.c       | 2 +-
>  fs/bcachefs/fsck.c             | 2 +-
>  fs/bcachefs/recovery.c         | 2 +-
>  fs/bcachefs/snapshot.c         | 2 +-
>  fs/bcachefs/super-io.c         | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
> index 540d94c0cceb..dd9f3cbace1e 100644
> --- a/fs/bcachefs/alloc_background.c
> +++ b/fs/bcachefs/alloc_background.c
> @@ -1247,7 +1247,7 @@ static noinline_for_stack int __bch2_check_discard_freespace_key(struct btree_tr
>  		return ret;
>  
>  	if (fsck_err_on(!bch2_dev_bucket_exists(c, pos), c,
> -			"entry in %s btree for nonexistant dev:bucket %llu:%llu",
> +			"entry in %s btree for non-existent dev:bucket %llu:%llu",

"nonexistent" doesn't necessarily need to be hyphenated, right?

Not that I really care ;), just curious. I'm sure Kent can massage or
not if desired:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  			bch2_btree_ids[iter->btree_id], pos.inode, pos.offset))
>  		goto delete;
>  
> diff --git a/fs/bcachefs/backpointers.c b/fs/bcachefs/backpointers.c
> index 8747c5e19f99..bec62e5b21e5 100644
> --- a/fs/bcachefs/backpointers.c
> +++ b/fs/bcachefs/backpointers.c
> @@ -357,7 +357,7 @@ static int bch2_check_btree_backpointer(struct btree_trans *trans, struct btree_
>  	int ret = 0;
>  
>  	if (fsck_err_on(!bch2_dev_exists2(c, k.k->p.inode), c,
> -			"backpointer for mising device:\n%s",
> +			"backpointer for missing device:\n%s",
>  			(bch2_bkey_val_to_text(&buf, c, k), buf.buf))) {
>  		ret = bch2_btree_delete_at(trans, bp_iter, 0);
>  		goto out;
> diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
> index 1dbb4d7dfb45..8d089bbdb1e5 100644
> --- a/fs/bcachefs/btree_iter.c
> +++ b/fs/bcachefs/btree_iter.c
> @@ -1495,7 +1495,7 @@ static void bch2_trans_update_max_paths(struct btree_trans *trans)
>  static noinline void btree_path_overflow(struct btree_trans *trans)
>  {
>  	bch2_dump_trans_paths_updates(trans);
> -	panic("trans path oveflow\n");
> +	panic("trans path overflow\n");
>  }
>  
>  static inline struct btree_path *btree_path_alloc(struct btree_trans *trans,
> diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
> index 238caeeaf06c..cc04d5a22f40 100644
> --- a/fs/bcachefs/fsck.c
> +++ b/fs/bcachefs/fsck.c
> @@ -80,7 +80,7 @@ static int __snapshot_lookup_subvol(struct btree_trans *trans, u32 snapshot,
>  	if (!ret)
>  		*subvol = le32_to_cpu(s.subvol);
>  	else if (bch2_err_matches(ret, ENOENT))
> -		bch_err(trans->c, "snapshot %u not fonud", snapshot);
> +		bch_err(trans->c, "snapshot %u not found", snapshot);
>  	return ret;
>  
>  }
> diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> index 30efb3c90560..a78f5d023ef2 100644
> --- a/fs/bcachefs/recovery.c
> +++ b/fs/bcachefs/recovery.c
> @@ -561,7 +561,7 @@ static void check_version_upgrade(struct bch_fs *c)
>  			if ((recovery_passes & RECOVERY_PASS_ALL_FSCK) == RECOVERY_PASS_ALL_FSCK)
>  				prt_str(&buf, "fsck required");
>  			else {
> -				prt_str(&buf, "running recovery passses: ");
> +				prt_str(&buf, "running recovery passes: ");
>  				prt_bitflags(&buf, bch2_recovery_passes, recovery_passes);
>  			}
>  
> diff --git a/fs/bcachefs/snapshot.c b/fs/bcachefs/snapshot.c
> index 9da09911466e..c2af574acb7c 100644
> --- a/fs/bcachefs/snapshot.c
> +++ b/fs/bcachefs/snapshot.c
> @@ -1385,7 +1385,7 @@ int bch2_delete_dead_snapshots(struct bch_fs *c)
>  	if (!test_bit(BCH_FS_STARTED, &c->flags)) {
>  		ret = bch2_fs_read_write_early(c);
>  		if (ret) {
> -			bch_err(c, "error deleleting dead snapshots: error going rw: %s", bch2_err_str(ret));
> +			bch_err(c, "error deleting dead snapshots: error going rw: %s", bch2_err_str(ret));
>  			return ret;
>  		}
>  	}
> diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
> index f01883e785a5..6efd279655ae 100644
> --- a/fs/bcachefs/super-io.c
> +++ b/fs/bcachefs/super-io.c
> @@ -385,7 +385,7 @@ static int bch2_sb_validate(struct bch_sb_handle *disk_sb, struct printbuf *out,
>  	}
>  
>  	if (bch2_is_zero(sb->uuid.b, sizeof(sb->uuid))) {
> -		prt_printf(out, "Bad intenal UUID (got zeroes)");
> +		prt_printf(out, "Bad internal UUID (got zeroes)");
>  		return -BCH_ERR_invalid_sb_uuid;
>  	}
>  
> -- 
> 2.39.2
> 

