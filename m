Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3D7EE36E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbjKPO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345319AbjKPO4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:56:40 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398A719D;
        Thu, 16 Nov 2023 06:56:37 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SWNQm0DMdz9smv;
        Thu, 16 Nov 2023 15:56:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1700146592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3yUWRdWVzFsHuFxni3WD8C/C0FkQZr20qtDs5ikp/zE=;
        b=xh2AQe0xUrjfUlssPBVy3kajBUviDJWiDKpIcLF/uoHsiSgqDG6RBYFq22aExSG9idOboB
        UpCyUJw+/N5nB/DtC+cToz/5L7QJThArsBYZrbqR9JX+XrdGs73MdsJCGKjZLFdeQkFou4
        kuCnJBNYxVWRCEppD6is8FahWy4GI4oCgFqrW1sPC2PoCibhG1o/TcaodOuaJ/hJVbBc+H
        /v61kRbF9J/zRHMQz2Ol/Oi9kmXNlG0ShsrwTOIIaN90k4iWiCJyj6ztBUnjXFvmHLUdfo
        HBGr/u8ISbmBr9Bb7cyIwf1YRLm2eNLTijgx5QCSmMb90bvXgGSlqovgN6e09w==
Date:   Thu, 16 Nov 2023 15:56:27 +0100
From:   Erhard Furtner <erhard_f@mailbox.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: kmem: properly initialize local objcg variable in
 current_obj_cgroup()
Message-ID: <20231116155627.3686da61@yea>
In-Reply-To: <4bd106d5-c3e3-6731-9a74-cff81e2392de@suse.cz>
References: <20231116025109.3775055-1-roman.gushchin@linux.dev>
        <4bd106d5-c3e3-6731-9a74-cff81e2392de@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: aff93ffdac5d040c37e
X-MBO-RS-META: g87qosyzznw96wykn5m39uyrjqc47iur
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 08:04:18 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 11/16/23 03:51, Roman Gushchin wrote:
> > Actually the problem is caused by uninitialized local variable in
> > current_obj_cgroup(). If the root memory cgroup is set as an active
> > memory cgroup for a charging scope (as in the trace, where systemd
> > tries to create the first non-root cgroup, so the parent cgroup is
> > the root cgroup), the "for" loop is skipped and uninitialized objcg is
> > returned, causing a panic down the accounting stack.
> > 
> > The fix is trivial: initialize the objcg variable to NULL
> > unconditionally before the "for" loop.
> > 
> > Fixes: e86828e5446d ("mm: kmem: scoped objcg protection")
> > Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1959
> > Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: stable@vger.kernel.org  
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> We could also do this to make it less confusing?
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 774bd6e21e27..a08bcec661b6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3175,7 +3175,6 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
>  		objcg = rcu_dereference_check(memcg->objcg, 1);
>  		if (likely(objcg))
>  			break;
> -		objcg = NULL;
>  	}
>  
>  	return objcg;
> 
> 

I can confirm the 1st patch from Roman fixes the issue on my amd64 and on my i686 box.

The 2nd patch from Vlastimil unfortunately does not (only tried on amd64).

Regards,
Erhard
