Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3007A903E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjIUAwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUAwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA342D7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695257509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFI5WmIh4My0R+y7lKbpmUV46PPypYnH5zMhfJ0bQVY=;
        b=Adq5/gItfwpSxT4V4ytOYnQu4Kos8JqMhnNfzfPXY6dTd4INSDLvKMR6cmk1UkolZtWL3/
        wqHh1LmErV4ZEi01QTGHc24sH1E7/e+wthMCMzmUBNQc2oXAeebO0Vb/CiHhaPhgiwaE/Y
        NNGaE2HccoNl/01HfyfWh01NDd5wvVY=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-ZZDXWCvbPjmgOGWro_k7Dg-1; Wed, 20 Sep 2023 20:51:47 -0400
X-MC-Unique: ZZDXWCvbPjmgOGWro_k7Dg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1c0ed186cf5so592840fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695257507; x=1695862307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFI5WmIh4My0R+y7lKbpmUV46PPypYnH5zMhfJ0bQVY=;
        b=QyvIdJVe6Of+vBMI0BXqp1PRKe/885f/7BXlYrhOP81IKs8iMW9HAtBmxSWOkB80Y9
         k5pEE+OBESdiGyuY2Z+Qb/9zBTj2JS9ITIESJrmZJVPN3XOpIvNHOmwFZwAyt3N+Qgla
         Om+UxevpoGxFEveiANik5Q204jTcacBpDXoenN/C7XvkGif9xVaUHwW/MTa0yf8CdqIV
         FtypJf6xEk2ppUPWh3Xt1KlW1Ciyuc+NQPOkimnLIUaXacWNiKuP+8IetIImr7bVL6Be
         pd4OKn9QXUML3NW68g/ktn0xZaCuT2aL8UkxE4ABbFIzmJEhuOIqUvNjij6DH5joSxIk
         DTJQ==
X-Gm-Message-State: AOJu0YyW1ksGmvY/c1wBaT/BZsaG7qzhNYLnBA93bYNdtOXDsR6Ny8bD
        /UXfhF6ExsMemjf2+oRPXnf9EbZ6hsomZhn0De6TgNViXxVAY0nQ2H62cGkZLF1QdybLCQLi6tD
        ez9nfi155za6mXVx65Nw1zsEuVo8h0y6N
X-Received: by 2002:a05:6870:5622:b0:1be:f23f:99b with SMTP id m34-20020a056870562200b001bef23f099bmr4401521oao.42.1695257507070;
        Wed, 20 Sep 2023 17:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7X444xzNTr4txbg0xM0A5uyV0tfIQjl2wXSUHMAGPu5TLRpN4bMw26THHBcBC+GsfKNwKjA==
X-Received: by 2002:a05:6870:5622:b0:1be:f23f:99b with SMTP id m34-20020a056870562200b001bef23f099bmr4401508oao.42.1695257506782;
        Wed, 20 Sep 2023 17:51:46 -0700 (PDT)
Received: from [10.72.113.125] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bi17-20020a056a00311100b00682bec0b680sm127170pfb.89.2023.09.20.17.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 17:51:46 -0700 (PDT)
Message-ID: <2ed5afa7-7ca7-87d2-ea84-5e80485bae97@redhat.com>
Date:   Thu, 21 Sep 2023 08:51:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs: apply umask if POSIX ACL support is disabled
Content-Language: en-US
To:     Max Kellermann <max.kellermann@ionos.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net
References: <20230919081900.1096840-1-max.kellermann@ionos.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230919081900.1096840-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/19/23 16:18, Max Kellermann wrote:
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   fs/ceph/super.h           | 1 +
>   fs/ext2/acl.h             | 1 +
>   fs/jfs/jfs_acl.h          | 1 +
>   include/linux/posix_acl.h | 1 +
>   4 files changed, 4 insertions(+)
>
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 51c7f2b14f6f..e7e2f264acf4 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1194,6 +1194,7 @@ static inline void ceph_forget_all_cached_acls(struct inode *inode)
>   static inline int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
>   				     struct ceph_acl_sec_ctx *as_ctx)
>   {
> +	*mode &= ~current_umask();
>   	return 0;
>   }

This LGTM.

Shouldn't we also do this in 'ceph_pre_init_acls()' when we couldn't get 
'acl' from 'posix_acl_create()' ?

Thanks!

- Xiubo


>   static inline void ceph_init_inode_acls(struct inode *inode,
> diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
> index 4a8443a2b8ec..694af789c614 100644
> --- a/fs/ext2/acl.h
> +++ b/fs/ext2/acl.h
> @@ -67,6 +67,7 @@ extern int ext2_init_acl (struct inode *, struct inode *);
>   
>   static inline int ext2_init_acl (struct inode *inode, struct inode *dir)
>   {
> +	inode->i_mode &= ~current_umask();
>   	return 0;
>   }
>   #endif
> diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
> index f892e54d0fcd..10791e97a46f 100644
> --- a/fs/jfs/jfs_acl.h
> +++ b/fs/jfs/jfs_acl.h
> @@ -17,6 +17,7 @@ int jfs_init_acl(tid_t, struct inode *, struct inode *);
>   static inline int jfs_init_acl(tid_t tid, struct inode *inode,
>   			       struct inode *dir)
>   {
> +	inode->i_mode &= ~current_umask();
>   	return 0;
>   }
>   
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 0e65b3d634d9..54bc9b1061ca 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -128,6 +128,7 @@ static inline void cache_no_acl(struct inode *inode)
>   static inline int posix_acl_create(struct inode *inode, umode_t *mode,
>   		struct posix_acl **default_acl, struct posix_acl **acl)
>   {
> +	*mode &= ~current_umask();
>   	*default_acl = *acl = NULL;
>   	return 0;
>   }

