Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C598D75A40E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjGTBhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGTBhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85571FF3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689816990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqhqXOvnlSHG620dXl7PNKzQR1gdWAKECIiVIx/Zy2E=;
        b=OCac8xIx8x7OovxD6n6WYnYaLll+BLqZSz/D5ZWi4E5MM2vJTFZddC2iSPbCSDG8brBgjr
        uY6gvurmjqJcTB4hY3mCYP0b9dDQgrcCJgbxAYNDX4ssYYcih2Aw+LVsNoLN3BQ5TzP+ej
        H7BlJIg0Qy0ShJ0eT+TiUqi2C87Gm4g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-RxBLp1bXMQ-hsCJjTgfhvw-1; Wed, 19 Jul 2023 21:36:29 -0400
X-MC-Unique: RxBLp1bXMQ-hsCJjTgfhvw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-55c964d031aso183063a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689816988; x=1690421788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqhqXOvnlSHG620dXl7PNKzQR1gdWAKECIiVIx/Zy2E=;
        b=AH4gaUSTkVTE9iwNNN8xJofQ5UK8T83EXYfszCS4zDi3cj8c/3+YRRiAyhKyIRrRdy
         XtTtFzW10C0+7YCU5HsvM0qj0xEIM81EsUrfbd33EFDKUNcQdUjwRaZnEEGs9Nny+zXo
         Idc7MYqfxzW01eH3Xss292/QY9d7AViE0KaYQa6yCieHuDSm+tMpOnsJFUgpNnfyOirO
         Q9X0DaBlssxgPzOUA2qp5afRssMGzi58q5MK+4Q/TaKAvbwmiTvaNg81iF59hVf+4OMB
         AdKAsBH/lqsquRv3W82SnAaD0Te/XGuDqihKTiX99gKIxdL8NJGy6y7pGednNpsmzH+4
         TGIA==
X-Gm-Message-State: ABy/qLZDfuNOVNzhApr5fk/I+pJenS5ob+/ipYVyAXjxTxCo2k+U8bg8
        iAXru7zHUlNRdx0Cr0MRHCRfWsMXeEhuihVU3TsIrxwZyjvuXgFnWa3OuZZuMNrADj1OM+h/fxg
        bKPWSwFE+auxLL7oQvxlhqIuO
X-Received: by 2002:a05:6a20:8c19:b0:135:32b1:b03d with SMTP id j25-20020a056a208c1900b0013532b1b03dmr1081930pzh.42.1689816988408;
        Wed, 19 Jul 2023 18:36:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGK/TMD30tNzaC0+Dilqw7kUqG82GxrXS6kz0f1yBZ8Eq8MvuFD2dyuTjnr8s3iHWuWEWg2uA==
X-Received: by 2002:a05:6a20:8c19:b0:135:32b1:b03d with SMTP id j25-20020a056a208c1900b0013532b1b03dmr1081912pzh.42.1689816988058;
        Wed, 19 Jul 2023 18:36:28 -0700 (PDT)
Received: from [10.72.12.173] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78186000000b006783ee5df8asm3856430pfi.189.2023.07.19.18.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 18:36:27 -0700 (PDT)
Message-ID: <694be793-7917-5498-67fb-fd0b57b5a3df@redhat.com>
Date:   Thu, 20 Jul 2023 09:36:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] netfs: Fix errors in cache.h The following checkpatch
 errors are removed: ERROR: "foo* bar" should be "foo *bar" ERROR: "foo* bar"
 should be "foo *bar" ERROR: "foo* bar" should be "foo *bar" ERROR: "foo* bar"
 should be "foo *bar" ERROR: "foo* bar" should be "foo *bar"
Content-Language: en-US
To:     huzhi001@208suo.com, idryomov@gmail.com
Cc:     jlayton@kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <tencent_4A53697595E9D930D4AE5727D5913360DB0A@qq.com>
 <071ee91b1fade5bc4de45f3e33f45f5c@208suo.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <071ee91b1fade5bc4de45f3e33f45f5c@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ZhiHu

This looks good to me.

Could you restructure the patch title and commit comment ?

Thanks

- Xiubo


On 7/19/23 19:10, huzhi001@208suo.com wrote:
> Signed-off-by: ZhiHu <huzhi001@208suo.com>
> ---
>  fs/ceph/cache.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
> index dc502daac49a..b9fb1d1b21a1 100644
> --- a/fs/ceph/cache.h
> +++ b/fs/ceph/cache.h
> @@ -14,11 +14,11 @@
>  #ifdef CONFIG_CEPH_FSCACHE
>  #include <linux/fscache.h>
>
> -int ceph_fscache_register_fs(struct ceph_fs_client* fsc, struct 
> fs_context *fc);
> -void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc);
> +int ceph_fscache_register_fs(struct ceph_fs_client *fsc, struct 
> fs_context *fc);
> +void ceph_fscache_unregister_fs(struct ceph_fs_client *fsc);
>
>  void ceph_fscache_register_inode_cookie(struct inode *inode);
> -void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci);
> +void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info *ci);
>
>  void ceph_fscache_use_cookie(struct inode *inode, bool will_modify);
>  void ceph_fscache_unuse_cookie(struct inode *inode, bool update);
> @@ -76,13 +76,13 @@ static inline void 
> ceph_fscache_note_page_release(struct inode *inode)
>      fscache_note_page_release(ceph_fscache_cookie(ci));
>  }
>  #else /* CONFIG_CEPH_FSCACHE */
> -static inline int ceph_fscache_register_fs(struct ceph_fs_client* fsc,
> +static inline int ceph_fscache_register_fs(struct ceph_fs_client *fsc,
>                         struct fs_context *fc)
>  {
>      return 0;
>  }
>
> -static inline void ceph_fscache_unregister_fs(struct ceph_fs_client* 
> fsc)
> +static inline void ceph_fscache_unregister_fs(struct ceph_fs_client 
> *fsc)
>  {
>  }
>
> @@ -90,7 +90,7 @@ static inline void 
> ceph_fscache_register_inode_cookie(struct inode *inode)
>  {
>  }
>
> -static inline void ceph_fscache_unregister_inode_cookie(struct 
> ceph_inode_info* ci)
> +static inline void ceph_fscache_unregister_inode_cookie(struct 
> ceph_inode_info *ci)
>  {
>  }
>

