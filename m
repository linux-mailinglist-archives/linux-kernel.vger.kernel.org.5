Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BB07E34D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjKGFSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKGFSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:18:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EB0113
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 21:18:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4083f61322fso38222295e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 21:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1699334323; x=1699939123; darn=vger.kernel.org;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9sJTMReKQmrBy3JWoqVqeZdB1qJQ8aGUI4Df5EyrF2M=;
        b=IMWnxpe7EkrCsQP6ucbqe3NTvkDG19wlkFISktrsaMBt083c5W1Ayd5uIzRk9cx1+Z
         kTVaBvKmdPtBGZzYApR3QgLvgvSRVuLh1QcuIN5LVNIAQ7BiKC9vUAX1qskX6v/TOoPl
         3qr8CI1RPxtSQ4831cesTG86j6374kcwW7oOb4g/NYXp1J7DKqQ4M8D56hL3k36GKvCM
         59W7n9ld0ALBcf7zm8X4BBxbcjeBTNMV1D8I1uE0tAvrXZTfJC6VErg628boMr43Yi4n
         BMQF/NBaeht7aJnslXTW++BjbY5I07BVtQohNHt8HdYLuRiyXiyshqt2l6dK1LHPcy9U
         bBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699334324; x=1699939124;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sJTMReKQmrBy3JWoqVqeZdB1qJQ8aGUI4Df5EyrF2M=;
        b=pWlLPh11jMQ6VHJFGVdDt4XIaAvj2iqVyFRgC3E4LtxkjzqwjxA1Zrr9f2C5hR004B
         yZR1of+1BpD3mSRbTriSRgD4DpAortHp+yKZiu92Eb4iyVdsK8jb7Oi9riVHPkkjWetW
         MnIForOHCFEc+0m+mrvG9YXmI1QhdGWayvzxZWBbcCOTBJqbVGtWn3UUGtun1CtOYg+I
         zfFYWUo6LyOyMf61uN10c+y1T7EGhDtBOW5WOf2VAmwW5LUQpxAN+S9wz1nn/8ThUWmz
         V2EqgoEIhiHtn7H2kW9EBDwUKNguZGd+0bkRTanZd9NHvDVLONRKqL6XeU5P7xllnE/9
         zUHw==
X-Gm-Message-State: AOJu0YynXE/DP2cKpskWV2RjRnQ65+5TevjwWRAYsBhZ9t77l6I4+4/y
        ASjOW2VGnw9HOtIe4yOTW1mg+A==
X-Google-Smtp-Source: AGHT+IF7cFIfmSCXiDieDJOC0fc632oc8tYaDyxQSPe4yc+y4AEhXbIfboAFmLnH/p4P7N9WhSIrDQ==
X-Received: by 2002:a05:600c:4e4c:b0:409:2825:6dd5 with SMTP id e12-20020a05600c4e4c00b0040928256dd5mr1429161wmq.13.1699334323511;
        Mon, 06 Nov 2023 21:18:43 -0800 (PST)
Received: from fedora.fritz.box (p5494469c.dip0.t-ipconnect.de. [84.148.70.156])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b004064e3b94afsm14464494wms.4.2023.11.06.21.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 21:18:42 -0800 (PST)
Date:   Tue, 7 Nov 2023 06:18:41 +0100
From:   Damian Tometzki <damian@riscv-rocks.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Damian Tometzki <damian@riscv-rocks.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Steve French <smfrench@gmail.com>,
        John Sanpe <sanpeqf@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cifs: Fix encryption of cleared, but unset rq_iter data
 buffers
Message-ID: <ZUnIsXpjd7ckkTVw@fedora.fritz.box>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        Damian Tometzki <damian@riscv-rocks.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Steve French <smfrench@gmail.com>, John Sanpe <sanpeqf@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <ZUiXkPPP1TuOgmmf@fedora.fritz.box>
 <20231022183917.1013135-1-sanpeqf@gmail.com>
 <ZUfQo47uo0p2ZsYg@fedora.fritz.box>
 <CAH2r5msde65PMtn-96VZDAQkT_rq+e-2G4O+zbPUR8zSWGxMsg@mail.gmail.com>
 <20231105193601.GB91123@sol.localdomain>
 <ZUfvk-6y2pER6Rmc@fedora.fritz.box>
 <20231105201516.GC91123@sol.localdomain>
 <2610852.1699281611@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2610852.1699281611@warthog.procyon.org.uk>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 39 (Thirty Nine) (Kernel 6.6.0)
Organization: Linux hacker
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06. Nov 14:40, David Howells wrote:
> Hi Damian,
> 
> Does the attached fix it for you?
Hello David,

this fix my issue with the cifs mount. 

Great many Thanks

Damian

> 
> David
> ---
> cifs: Fix encryption of cleared, but unset rq_iter data buffers
> 
> Each smb_rqst struct contains two things: an array of kvecs (rq_iov) that
> contains the protocol data for an RPC op and an iterator (rq_iter) that
> contains the data payload of an RPC op.  When an smb_rqst is allocated
> rq_iter is it always cleared, but we don't set it up unless we're going to
> use it.
> 
> The functions that determines the size of the ciphertext buffer that will
> be needed to encrypt a request, cifs_get_num_sgs(), assumes that rq_iter is
> always initialised - and employs user_backed_iter() to check that the
> iterator isn't user-backed.  This used to incidentally work, because
> ->user_backed was set to false because the iterator has never been
> initialised, but with commit f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74[1]
> which changes user_backed_iter() to determine this based on the iterator
> type insted, a warning is now emitted:
> 
>         WARNING: CPU: 7 PID: 4584 at fs/smb/client/cifsglob.h:2165 smb2_get_aead_req+0x3fc/0x420 [cifs]
>         ...
>         RIP: 0010:smb2_get_aead_req+0x3fc/0x420 [cifs]
>         ...
>          crypt_message+0x33e/0x550 [cifs]
>          smb3_init_transform_rq+0x27d/0x3f0 [cifs]
>          smb_send_rqst+0xc7/0x160 [cifs]
>          compound_send_recv+0x3ca/0x9f0 [cifs]
>          cifs_send_recv+0x25/0x30 [cifs]
>          SMB2_tcon+0x38a/0x820 [cifs]
>          cifs_get_smb_ses+0x69c/0xee0 [cifs]
>          cifs_mount_get_session+0x76/0x1d0 [cifs]
>          dfs_mount_share+0x74/0x9d0 [cifs]
>          cifs_mount+0x6e/0x2e0 [cifs]
>          cifs_smb3_do_mount+0x143/0x300 [cifs]
>          smb3_get_tree+0x15e/0x290 [cifs]
>          vfs_get_tree+0x2d/0xe0
>          do_new_mount+0x124/0x340
>          __se_sys_mount+0x143/0x1a0
> 
> The problem is that rq_iter was never set, so the type is 0 (ie. ITER_UBUF)
> which causes user_backed_iter() to return true.  The code doesn't
> malfunction because it checks the size of the iterator - which is 0.
> 
> Fix cifs_get_num_sgs() to ignore rq_iter if its count is 0, thereby
> bypassing the warnings.
> 
> It might be better to explicitly initialise rq_iter to a zero-length
> ITER_BVEC, say, as it can always be reinitialised later.
> 
> Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than a page list")
> Reported-by: Damian Tometzki <damian@riscv-rocks.de>
> Link: https://lore.kernel.org/r/ZUfQo47uo0p2ZsYg@fedora.fritz.box/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <smfrench@gmail.com>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Namjae Jeon <linkinjeon@kernel.org>
> cc: Tom Talpey <tom@talpey.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Eric Biggers <ebiggers@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74 [1]
> ---
>  fs/smb/client/cifsglob.h |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 02082621d8e0..c70760871606 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -2143,6 +2143,7 @@ static inline int cifs_get_num_sgs(const struct smb_rqst *rqst,
>  	unsigned int len, skip;
>  	unsigned int nents = 0;
>  	unsigned long addr;
> +	size_t data_size;
>  	int i, j;
>  
>  	/*
> @@ -2158,17 +2159,21 @@ static inline int cifs_get_num_sgs(const struct smb_rqst *rqst,
>  	 * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
>  	 */
>  	for (i = 0; i < num_rqst; i++) {
> +		data_size = iov_iter_count(&rqst[i].rq_iter);
> +		    
>  		/* We really don't want a mixture of pinned and unpinned pages
>  		 * in the sglist.  It's hard to keep track of which is what.
>  		 * Instead, we convert to a BVEC-type iterator higher up.
>  		 */
> -		if (WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
> +		if (data_size &&
> +		    WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
>  			return -EIO;
>  
>  		/* We also don't want to have any extra refs or pins to clean
>  		 * up in the sglist.
>  		 */
> -		if (WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_iter)))
> +		if (data_size &&
> +		    WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_iter)))
>  			return -EIO;
>  
>  		for (j = 0; j < rqst[i].rq_nvec; j++) {
> @@ -2184,7 +2189,8 @@ static inline int cifs_get_num_sgs(const struct smb_rqst *rqst,
>  			}
>  			skip = 0;
>  		}
> -		nents += iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
> +		if (data_size)
> +			nents += iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
>  	}
>  	nents += DIV_ROUND_UP(offset_in_page(sig) + SMB2_SIGNATURE_SIZE, PAGE_SIZE);
>  	return nents;
> 
