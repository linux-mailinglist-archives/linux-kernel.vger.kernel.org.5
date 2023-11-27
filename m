Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72CE7F9742
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjK0Bm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0Bm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC70CB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 17:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701049377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3piOFjqcmG4ig54gxirYMZgy91A3m3a1YqEizDwKOMI=;
        b=HL1B3y7EK29cWyUCPQzn4jqjqyQCwzK6kQ0zPB9KE9aBUjJIcx3s1PdepUfETDtF3eUtpv
        JxFFoUJiyjURTzzN4PNVVDenYu3soZNp0QA4orVHu2AxozydnZc1k3oPbs34NdiYG1yDrT
        P4QLWFH7VaWlgw8ppocs5jUh3ZTH9Mk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-KbV6OW_VM6uk70V0fQA6og-1; Sun, 26 Nov 2023 20:42:54 -0500
X-MC-Unique: KbV6OW_VM6uk70V0fQA6og-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE4DF811E82;
        Mon, 27 Nov 2023 01:42:53 +0000 (UTC)
Received: from [10.22.32.84] (unknown [10.22.32.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7281121307;
        Mon, 27 Nov 2023 01:42:53 +0000 (UTC)
Message-ID: <701b0b03-2c66-462a-830a-c08a27b79839@redhat.com>
Date:   Sun, 26 Nov 2023 20:42:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: slightly reorder 'struct lock_class' to save
 some memory
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <801258371fc4101f96495a5aaecef638d6cbd8d3.1700988869.git.christophe.jaillet@wanadoo.fr>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <801258371fc4101f96495a5aaecef638d6cbd8d3.1700988869.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/23 03:56, Christophe JAILLET wrote:
> Based on pahole, 2 holes can be combined in the 'struct lock_class'. This
> saves 8 bytes in the structure on my x86_64.
>
> On a x86_64 configured with allmodconfig, this saves 64kb of memory in
> 'kernel/locking/lockdep.o', certainly because of:
>    struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
>
> Before:
>     text	   data	    bss	    dec	    hex	filename
>   102501	1912490	11531636	13546627	 ceb483	kernel/locking/lockdep.o
>
> After:
>   102181	1912490	11466100	13480771	 cdb343	kernel/locking/lockdep.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> After the reorder, pahole gives:
>
> struct lock_class {
>          struct hlist_node          hash_entry;           /*     0    16 */
>          struct list_head           lock_entry;           /*    16    16 */
>          struct list_head           locks_after;          /*    32    16 */
>          struct list_head           locks_before;         /*    48    16 */
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          const struct lockdep_subclass_key  * key;        /*    64     8 */
>          lock_cmp_fn                cmp_fn;               /*    72     8 */
>          lock_print_fn              print_fn;             /*    80     8 */
>          unsigned int               subclass;             /*    88     4 */
>          unsigned int               dep_gen_id;           /*    92     4 */
>          long unsigned int          usage_mask;           /*    96     8 */
>          const struct lock_trace  * usage_traces[10];     /*   104    80 */
>          /* --- cacheline 2 boundary (128 bytes) was 56 bytes ago --- */
>          const char  *              name;                 /*   184     8 */
>          /* --- cacheline 3 boundary (192 bytes) --- */
>          int                        name_version;         /*   192     4 */
>          u8                         wait_type_inner;      /*   196     1 */
>          u8                         wait_type_outer;      /*   197     1 */
>          u8                         lock_type;            /*   198     1 */
>
>          /* XXX 1 byte hole, try to pack */
>
>          long unsigned int          contention_point[4];  /*   200    32 */
>          long unsigned int          contending_point[4];  /*   232    32 */
>
>          /* size: 264, cachelines: 5, members: 18 */
>          /* sum members: 263, holes: 1, sum holes: 1 */
>          /* last cacheline: 8 bytes */
> };
> ---
>   include/linux/lockdep_types.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> index 2ebc323d345a..857d785e89e6 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -127,12 +127,12 @@ struct lock_class {
>   	unsigned long			usage_mask;
>   	const struct lock_trace		*usage_traces[LOCK_TRACE_STATES];
>   
> +	const char			*name;
>   	/*
>   	 * Generation counter, when doing certain classes of graph walking,
>   	 * to ensure that we check one node only once:
>   	 */
>   	int				name_version;
> -	const char			*name;
>   
>   	u8				wait_type_inner;
>   	u8				wait_type_outer;

LGTM

Acked-by: Waiman Long <longman@redhat.com>

