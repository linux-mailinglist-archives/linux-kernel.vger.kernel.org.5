Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0F7F3CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjKVE3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVE3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DADD10C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 20:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700627386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ni9rUzf536MMNXosEPewL7ksFPjKlMlRmgB/zWpvKA0=;
        b=RVsSrQ0Mpxl+ZnysLjrA2QD5Xx9Lz0p1k35HXqtccY1BtI7tHWXhDddHZrAboQzmN8GVkt
        3KkECSoIty0HXzLkkRXFQWCZnTrFplnTSjliKGK82EiiUPGLGnjiQRQOBbzupDJ1lAIogS
        XyD9E2h5CrXJ1tN+6r0Jpb3aFHqRlZ8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-D-d-LYUMMeulfc8ISXZCfw-1; Tue, 21 Nov 2023 23:29:45 -0500
X-MC-Unique: D-d-LYUMMeulfc8ISXZCfw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c1bfc5066aso7526671a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 20:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700627384; x=1701232184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ni9rUzf536MMNXosEPewL7ksFPjKlMlRmgB/zWpvKA0=;
        b=URR7RVfUzLq/8nPFvxRZWJEkXP7z4QABsWhkZcHufOyOkhSKGY4neSo7nqpOyX704z
         h11seFsTG0cUYo8farc1gQI+rZOy9oJelA3TSw5P/ljCcL2Ol/ibSMwHITvsyDn7pKxR
         gOpklsfHbf0f4O61MmUui4ClJVlYNsCODYe7neIy/9+/jFxIu4Twwt/Twl7TnOOXTDSf
         +EIbzwzMbZ8LdMHST/1gSzqIWS3GQVxomK6fWn28NprAQAArXGRmO0PuqckT/PW6PYt3
         BQkYxewBR7wKuCs8avDKLrFD6Hes53eHISMiRm2sf6X1q/an7R5kpeaTkv1NLHFXHIhU
         pRwQ==
X-Gm-Message-State: AOJu0YwVveSqp3nlxA7Gi6BF71UPSw6VZ4tBUsLrIPD6re6n8EYtfZ5/
        sbZ/2pMFB84sVmbuBJXDp74BqwnujKHOBKffCN+l+pD94IkvGMLuWLi92UTdlwWcTTiSbHP2BWD
        Ko1k7Nd1tRVSyYNH4P32FKecK
X-Received: by 2002:a17:903:24d:b0:1cf:50a0:566d with SMTP id j13-20020a170903024d00b001cf50a0566dmr1391871plh.7.1700627383964;
        Tue, 21 Nov 2023 20:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1GIJIoGrGb8XiGKZPey8twt4tfN45REcxda1deEvqy4kwy8rE791WEDcv1dnwQshBlJ/4mA==
X-Received: by 2002:a17:903:24d:b0:1cf:50a0:566d with SMTP id j13-20020a170903024d00b001cf50a0566dmr1391863plh.7.1700627383623;
        Tue, 21 Nov 2023 20:29:43 -0800 (PST)
Received: from [10.72.112.224] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o24-20020a170902779800b001c613091aeasm8669183pll.297.2023.11.21.20.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 20:29:43 -0800 (PST)
Message-ID: <d5eda932-dec0-ba2d-2f4d-a7edbbfa1f81@redhat.com>
Date:   Wed, 22 Nov 2023 12:29:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ceph: quota: Fix invalid pointer access if
 get_quota_realm return ERR_PTR
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Luis Henriques <lhenriques@suse.de>, ceph-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20231120082637.2717550-1-haowenchao2@huawei.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20231120082637.2717550-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/20/23 16:26, Wenchao Hao wrote:
> This issue is reported by smatch that get_quota_realm() might return
> ERR_PTR but we did not handle it. It's not a immediate bug, while we
> still should address it to avoid potential bugs if get_quota_realm()
> is changed to return other ERR_PTR in future.
>
> Set ceph_snap_realm's pointer in get_quota_realm()'s to address this
> issue, the pointer would be set to NULL if get_quota_realm() failed
> to get struct ceph_snap_realm, so no ERR_PTR would happen any more.
>
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
> V2:
>   - Fix all potential invalid pointer access caused by get_quota_realm
>   - Update commit comment and point it's not a immediate bug
>
>   fs/ceph/quota.c | 41 +++++++++++++++++++++++------------------
>   1 file changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 9d36c3532de1..e85a85b34a83 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -197,10 +197,10 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
>   }
>   
>   /*
> - * This function walks through the snaprealm for an inode and returns the
> - * ceph_snap_realm for the first snaprealm that has quotas set (max_files,
> + * This function walks through the snaprealm for an inode and set the
> + * realmp with the first snaprealm that has quotas set (max_files,
>    * max_bytes, or any, depending on the 'which_quota' argument).  If the root is
> - * reached, return the root ceph_snap_realm instead.
> + * reached, set the realmp with the root ceph_snap_realm instead.
>    *
>    * Note that the caller is responsible for calling ceph_put_snap_realm() on the
>    * returned realm.
> @@ -211,10 +211,9 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
>    * this function will return -EAGAIN; otherwise, the snaprealms walk-through
>    * will be restarted.
>    */
> -static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
> -					       struct inode *inode,
> -					       enum quota_get_realm which_quota,
> -					       bool retry)
> +static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode *inode,
> +			   enum quota_get_realm which_quota,
> +			   struct ceph_snap_realm **realmp, bool retry)
>   {
>   	struct ceph_client *cl = mdsc->fsc->client;
>   	struct ceph_inode_info *ci = NULL;
> @@ -222,8 +221,10 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>   	struct inode *in;
>   	bool has_quota;
>   
> +	if (realmp)
> +		*realmp = NULL;
>   	if (ceph_snap(inode) != CEPH_NOSNAP)
> -		return NULL;
> +		return 0;
>   
>   restart:
>   	realm = ceph_inode(inode)->i_snap_realm;
> @@ -250,7 +251,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>   				break;
>   			ceph_put_snap_realm(mdsc, realm);
>   			if (!retry)
> -				return ERR_PTR(-EAGAIN);
> +				return -EAGAIN;
>   			goto restart;
>   		}
>   
> @@ -259,8 +260,11 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>   		iput(in);
>   
>   		next = realm->parent;
> -		if (has_quota || !next)
> -		       return realm;
> +		if (has_quota || !next) {
> +			if (realmp)
> +				*realmp = realm;
> +			return 0;
> +		}
>   
>   		ceph_get_snap_realm(mdsc, next);
>   		ceph_put_snap_realm(mdsc, realm);
> @@ -269,14 +273,15 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>   	if (realm)
>   		ceph_put_snap_realm(mdsc, realm);
>   
> -	return NULL;
> +	return 0;
>   }
>   
>   bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
>   {
>   	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(old->i_sb);
> -	struct ceph_snap_realm *old_realm, *new_realm;
> +	struct ceph_snap_realm *old_realm = NULL, *new_realm = NULL;

Here you initialized it as NULL.

>   	bool is_same;
> +	int ret;
>   
>   restart:
>   	/*
> @@ -286,9 +291,9 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
>   	 * dropped and we can then restart the whole operation.
>   	 */
>   	down_read(&mdsc->snap_rwsem);
> -	old_realm = get_quota_realm(mdsc, old, QUOTA_GET_ANY, true);
> -	new_realm = get_quota_realm(mdsc, new, QUOTA_GET_ANY, false);
> -	if (PTR_ERR(new_realm) == -EAGAIN) {
> +	get_quota_realm(mdsc, old, QUOTA_GET_ANY, &old_realm, true);
> +	ret = get_quota_realm(mdsc, new, QUOTA_GET_ANY, &new_realm, false);
> +	if (ret == -EAGAIN) {
>   		up_read(&mdsc->snap_rwsem);
>   		if (old_realm)
>   			ceph_put_snap_realm(mdsc, old_realm);
> @@ -492,8 +497,8 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>   	bool is_updated = false;
>   
>   	down_read(&mdsc->snap_rwsem);
> -	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
> -				QUOTA_GET_MAX_BYTES, true);
> +	get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
> +				QUOTA_GET_MAX_BYTES, &realm, true);

While here you ignored it.

I think we can just ignore it and the 'get_quota_realm()' will help 
initialize it.

Thanks

- Xiubo

>   	up_read(&mdsc->snap_rwsem);
>   	if (!realm)
>   		return false;

