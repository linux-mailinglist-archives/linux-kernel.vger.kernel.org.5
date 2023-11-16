Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28297EE0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345154AbjKPMm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345142AbjKPMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:42:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60F193
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700138540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0cgDtlCn3yVws2N/gdlQc9Ry1b50ay82U2VPVFHUd8=;
        b=eTZ5IJOL0qAyuOJeSlxvzvw2IUHYPSwyYhHinJk+s3VcnNXOAPE9T+GmP29nI856npIAA2
        Bfi99OYSwcPBXpq044zEiJdMwZkUMfh+J/h5l1TZvocDUnc0O82biZdPAZgSsnPeyzU9Mu
        NeoRMN2rNn3q1X7RvrwhGm7/omg7Z8U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-cunVPJq3M0ikTpkJFsMo_w-1; Thu, 16 Nov 2023 07:42:17 -0500
X-MC-Unique: cunVPJq3M0ikTpkJFsMo_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15A2B8058ED;
        Thu, 16 Nov 2023 12:42:17 +0000 (UTC)
Received: from [10.22.16.205] (unknown [10.22.16.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C95041C060B5;
        Thu, 16 Nov 2023 12:42:16 +0000 (UTC)
Message-ID: <c1c23a29-17a4-43de-9967-f3bca079b860@redhat.com>
Date:   Thu, 16 Nov 2023 07:42:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: optimise "struct lock_class" layout
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <e527403e-9be1-4aa2-98c0-a3ab1f02787f@p183>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <e527403e-9be1-4aa2-98c0-a3ab1f02787f@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 06:25, Alexey Dobriyan wrote:
> struct lock_class does
>
> 	const struct lock_trace *	usage_traces[];
> 	int				name_version;
> 	const char *			name;
>
> which wastes 4 bytes after "name_version".
>
> Put pointer after pointers shrinking sizeof from 208 bytes to 200 bytes.
> Space savings are considerable for such a trivial patch:
>
> 	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
> 	add/remove: 0/0 grow/shrink: 1/11 up/down: 2/-65640 (-65638)
> 	Function                       old     new   delta
> 	check_irq_usage               2852    2854      +2
> 	reacquire_held_locks           486     484      -2
> 	lock_chain_get_class            41      39      -2
> 	l_start                         34      32      -2
> 	check_noncircular              276     274      -2
> 	print_usage_bug.part           688     683      -5
> 	print_circular_bug            1017    1011      -6
> 	hlock_conflict                 141     135      -6
> 	print_deadlock_bug             944     935      -9
> 	mark_lock                     3791    3769     -22
> 	__lock_acquire                9801    9753     -48
> 	lock_classes               1703936 1638400  -65536
> 	Total: Before=21163908, After=21098270, chg -0.31%
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>   include/linux/lockdep_types.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
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
>
LGTM.

Acked-by: Waiman Long <longman@redhat.com>

