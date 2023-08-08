Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493A3774C65
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjHHVIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjHHVIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:08:02 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066251FC8C;
        Tue,  8 Aug 2023 13:39:02 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EC3D33F7B7;
        Tue,  8 Aug 2023 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691527141;
        bh=g4haua1IOmEAZIW6GpRHq65jQw5+tkVRcSl6jTiUYWE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Sk7TlFRtjCEL1EgTvHO0+JFUkHXioqPLs/P3V+X2gPA1XLr2blkUd7RNW/wsKMF9r
         ivUJPqPQovu/t2MFHdzmiCvkD5+izdmPtAcX8TdFMDPZaaCaP6kiQPKZEfFe+UnKFW
         EEgpjQh6reR1/FlPpDCJ3VANSE964P2NGSVkJ5uyrzgUIJNnqufxBIBK7g5pDxNof7
         QWn+OTZetD6pkjCReQNVz/kBadC7e/7kjm0DQqlP38aKgm1JRjxIublUxEDBBWjRM8
         hB8n1unTxD69uHUYplqPiS4y3mPy+LIl/Lj7T0AFjj4B/GdbNNFbtxIrkr8RdtrOyR
         6a062F51ddwUw==
Message-ID: <33790c5c-c23a-7207-c3a7-454af1452ad5@canonical.com>
Date:   Tue, 8 Aug 2023 13:38:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] apparmor: cleanup unused functions in file.h
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, mike.salvatore@canonical.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230725141259.233391-1-xiujianfeng@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230725141259.233391-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 07:12, Xiu Jianfeng wrote:
> After changes in commit 33bf60cabcc7 ("LSM: Infrastructure management of
> the file security"), aa_alloc_file_ctx() and aa_free_file_ctx() are no
> longer used, so remove them, and also remove aa_get_file_label() because
> it seems that it's never been used before.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Acked-by: John Johansen <john.johansen@canonical.com>

this has been pulled into apparmor-next

> ---
>   security/apparmor/include/file.h | 37 --------------------------------
>   1 file changed, 37 deletions(-)
> 
> diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
> index 5be620af33ba..23cb6f9dbe6e 100644
> --- a/security/apparmor/include/file.h
> +++ b/security/apparmor/include/file.h
> @@ -45,43 +45,6 @@ struct aa_file_ctx {
>   	u32 allow;
>   };
>   
> -/**
> - * aa_alloc_file_ctx - allocate file_ctx
> - * @label: initial label of task creating the file
> - * @gfp: gfp flags for allocation
> - *
> - * Returns: file_ctx or NULL on failure
> - */
> -static inline struct aa_file_ctx *aa_alloc_file_ctx(struct aa_label *label,
> -						    gfp_t gfp)
> -{
> -	struct aa_file_ctx *ctx;
> -
> -	ctx = kzalloc(sizeof(struct aa_file_ctx), gfp);
> -	if (ctx) {
> -		spin_lock_init(&ctx->lock);
> -		rcu_assign_pointer(ctx->label, aa_get_label(label));
> -	}
> -	return ctx;
> -}
> -
> -/**
> - * aa_free_file_ctx - free a file_ctx
> - * @ctx: file_ctx to free  (MAYBE_NULL)
> - */
> -static inline void aa_free_file_ctx(struct aa_file_ctx *ctx)
> -{
> -	if (ctx) {
> -		aa_put_label(rcu_access_pointer(ctx->label));
> -		kfree_sensitive(ctx);
> -	}
> -}
> -
> -static inline struct aa_label *aa_get_file_label(struct aa_file_ctx *ctx)
> -{
> -	return aa_get_label_rcu(&ctx->label);
> -}
> -
>   /*
>    * The xindex is broken into 3 parts
>    * - index - an index into either the exec name table or the variable table

