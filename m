Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2624E7EBA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 01:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjKOAgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 19:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjKOAgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 19:36:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D83E7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 16:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700008558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+qBxi2zv75rbxCrPxryNoF5AVHcLiK4v1bHRUG29OY=;
        b=YDDYLNLvVTIaP8O6SA7irJ8iU0BXOZu/NFF9oV5mM9BK1p2zwvwmSkhJk7C62pMetN1Ohy
        z6RREb3ejJJXQDt5uauk05UfDtRQD6k3Vp6gzzEhrDgazIBjnrRuYwHp3Fq+E7kot1Kb8p
        zYhMYKSV6kKR0PI/Vba8uJdl0VdACMo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-7wexyUibNI-bikQ1W-HDeQ-1; Tue, 14 Nov 2023 19:35:57 -0500
X-MC-Unique: 7wexyUibNI-bikQ1W-HDeQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6c4d0b51c7fso5738200b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 16:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700008556; x=1700613356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+qBxi2zv75rbxCrPxryNoF5AVHcLiK4v1bHRUG29OY=;
        b=XygCClvbmjtZl+YPyj0CxoU+ZWXSd1HoQLe4ugXiSsUUwFLVnTLz41RvMnOaUy/4Je
         xR0mLQzeEPhguNXo8Dg5Vt3l3IceaUD5bEljmik+6g4b0i95U4sfRjCFjDXSuh5xBQqg
         0o0H8Rvv2BLEDZoD1LueGXn795tedoPXrgJGI++HeXn4OcVT05cG723K0zpPQKIt7INO
         cniGV3r0FwIkvslXgtgXqEXFwdWMdJ9cjrtEhsyUC+J6ecedSGTVUo8uGBddMS1OvQTz
         1b0P8VAkvLxtWiZ6uVkqkcLMjJSt06bY8TtfJwNvMBkB27Q7Vt1zFBirsSwf2q2+EUCN
         sIdQ==
X-Gm-Message-State: AOJu0YyPR6oRnCyq1/CqCKMRdQS9HquD5mn2FRTnzhbJbjsr+0dI+dq8
        7lC+TIt3ZgDGWpvQIRDSCIZN3nNaKNLK4/mnBz/KF+Csill5nX9Alei0x9KeIxhR8h3EhbfkP95
        pcPk2k6I79TBc8C2p1kQbJQfgIZiHp0SeHaY=
X-Received: by 2002:a05:6a00:b4e:b0:6b7:b42f:e438 with SMTP id p14-20020a056a000b4e00b006b7b42fe438mr10351054pfo.8.1700008555673;
        Tue, 14 Nov 2023 16:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZlHALYAfVi6+dTLG0CQtCK2CG0LfW1MNn2kFBFV7ENAXN52ZqeUNfXq0J256Xu5xoSs2Dxw==
X-Received: by 2002:a05:6a00:b4e:b0:6b7:b42f:e438 with SMTP id p14-20020a056a000b4e00b006b7b42fe438mr10351028pfo.8.1700008555111;
        Tue, 14 Nov 2023 16:35:55 -0800 (PST)
Received: from [10.72.112.63] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y19-20020a62b513000000b006c4eb4e7f98sm1755436pfe.169.2023.11.14.16.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 16:35:54 -0800 (PST)
Message-ID: <af8549c8-a468-6505-6dd1-3589fc76be8e@redhat.com>
Date:   Wed, 15 Nov 2023 08:35:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: quota: Fix invalid pointer access in
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     louhongxiang@huawei.com
References: <20231114153108.1932884-1-haowenchao2@huawei.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20231114153108.1932884-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/14/23 23:31, Wenchao Hao wrote:
> This issue is reported by smatch, get_quota_realm() might return
> ERR_PTR, so we should using IS_ERR_OR_NULL here to check the return
> value.
>
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   fs/ceph/quota.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 9d36c3532de1..c4b2929c6a83 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -495,7 +495,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>   	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
>   				QUOTA_GET_MAX_BYTES, true);
>   	up_read(&mdsc->snap_rwsem);
> -	if (!realm)
> +	if (IS_ERR_OR_NULL(realm))
>   		return false;
>   
>   	spin_lock(&realm->inodes_with_caps_lock);

Good catch.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

We should CC the stable mail list.

Thanks

- Xiubo

