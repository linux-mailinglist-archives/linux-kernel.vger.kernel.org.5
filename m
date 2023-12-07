Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C534808F00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443479AbjLGRkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443385AbjLGRkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602DA1703
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701970841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMnbB7T1LQp0wZWytMfSaP8EVvp37hw/oAE/reqSj0w=;
        b=PdeR6wOrsbGrEPbDa8bbYWL6HvuQX2arFkOa7EyCQAuj1N8P+jJKDkMmwkCTuyK7NurH/F
        OoP+bIFstECt6mlYpLvRrOwTeju6YSnCr7mLC62E2SZ7Svg2NMvBgic74vRbwl57dCGBhk
        MHNt2Tkzwyi5bAIuSSAXUIZnLcSX6SA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-buOtMp_5M4CzKtPTlcRHWw-1; Thu,
 07 Dec 2023 12:40:35 -0500
X-MC-Unique: buOtMp_5M4CzKtPTlcRHWw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E5CB1C05EB5;
        Thu,  7 Dec 2023 17:40:34 +0000 (UTC)
Received: from [10.22.32.209] (unknown [10.22.32.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA010492BC6;
        Thu,  7 Dec 2023 17:40:33 +0000 (UTC)
Message-ID: <5c35f648-88cc-4de2-91d7-fb95ceae15b9@redhat.com>
Date:   Thu, 7 Dec 2023 12:40:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v2] cgroup: Move rcu_head up near the top of
 cgroup_root
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yafang Shao <laoar.shao@gmail.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yosry Ahmed <yosryahmed@google.com>
References: <20231207134614.882991-1-longman@redhat.com>
 <65h3s447i3fkygdtilucda2q6uaygtzfpxb6vsjgwoeybwwgtw@6ahmtj47ggzh>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <65h3s447i3fkygdtilucda2q6uaygtzfpxb6vsjgwoeybwwgtw@6ahmtj47ggzh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 11:46, Michal Koutný wrote:
> On Thu, Dec 07, 2023 at 08:46:14AM -0500, Waiman Long <longman@redhat.com> wrote:
>> Commit 77070eeb8821 ("cgroup: Avoid false cacheline sharing of read
>> mostly rstat_cpu") happens to be the last straw that breaks it.
> FTR, when I build kernel from that commit, I can see
>
>> struct cgroup_root {
>> 	struct kernfs_root *       kf_root;              /*     0     8 */
>> 	unsigned int               subsys_mask;          /*     8     4 */
>> 	int                        hierarchy_id;         /*    12     4 */
>>
>> 	/* XXX 48 bytes hole, try to pack */
>>
>> 	/* --- cacheline 1 boundary (64 bytes) --- */
>> 	struct cgroup              cgrp __attribute__((__aligned__(64))); /*    64  2368 */
>>
>> 	/* XXX last struct has 8 bytes of padding */
>>
>> 	/* --- cacheline 38 boundary (2432 bytes) --- */
>> 	struct cgroup *            cgrp_ancestor_storage; /*  2432     8 */
>> 	atomic_t                   nr_cgrps;             /*  2440     4 */
>>
>> 	/* XXX 4 bytes hole, try to pack */
>>
>> 	struct list_head           root_list;            /*  2448    16 */
>> 	struct callback_head       rcu __attribute__((__aligned__(8))); /*  2464    16 */
>> 	unsigned int               flags;                /*  2480     4 */
>> 	char                       release_agent_path[4096]; /*  2484  4096 */
>> 	/* --- cacheline 102 boundary (6528 bytes) was 52 bytes ago --- */
>> 	char                       name[64];             /*  6580    64 */
>>
>> 	/* size: 6656, cachelines: 104, members: 11 */
>> 	/* sum members: 6592, holes: 2, sum holes: 52 */
>> 	/* padding: 12 */
>> 	/* paddings: 1, sum paddings: 8 */
>> 	/* forced alignments: 2, forced holes: 1, sum forced holes: 48 */
>> } __attribute__((__aligned__(64)));
> 2480 has still quite a reserve below 4096. (I can't see an CONFIG_*
> affecting this.)
>
> Perhaps, I missed something from the linux-next merging thread?

CONFIG_LOCKDEP and some other debug configs are enabled with 
allmodconfig. This can greatly increase the size of some of the 
structures. I am not able to use pahole due to missing BTF info so I 
don't the exact size. However, I can reproduce the build failure and the 
patch is  able to fix it.

Cheers,
Longman

