Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06C97FC1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbjK1QqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjK1QqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:46:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB780D4B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701189982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtguvXmgcADMzdVOD2VT2BOnlg+LybpKeuHvVA1rDbs=;
        b=RFKBnhOEnqJYUfcN0xHtw6rysHjdr/o24ug/6q0S0Q2Cqt9XmtcCz/cg/FyRgPkSZYKVJu
        uvlfrIgrSujf+WM5Et2LYjRNXExknJa9eM+aWrSJFiuiLYGSSgozce0dfPKiCHYeOQrXrL
        HKYhm7DijvQo6QKTQQtlPsFQgdWb1kA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-oPxxcZXpPHmDlMsvbvZYeg-1; Tue,
 28 Nov 2023 11:46:19 -0500
X-MC-Unique: oPxxcZXpPHmDlMsvbvZYeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D97273C0FC8B;
        Tue, 28 Nov 2023 16:46:18 +0000 (UTC)
Received: from [10.22.17.248] (unknown [10.22.17.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55AAB20268DA;
        Tue, 28 Nov 2023 16:46:18 +0000 (UTC)
Message-ID: <708eda13-6615-4efe-87e1-f3610e90e116@redhat.com>
Date:   Tue, 28 Nov 2023 11:46:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
References: <20231106210543.717486-1-longman@redhat.com>
 <20231106210543.717486-3-longman@redhat.com>
 <a9aa2809-95f5-4f60-b936-0d857c971fea@redhat.com>
 <ZWYYrJVMUOrl9r2g@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZWYYrJVMUOrl9r2g@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

On 11/28/23 11:43, Tejun Heo wrote:
> On Mon, Nov 27, 2023 at 11:01:22PM -0500, Waiman Long wrote:
> ...
>>> + * Recursively traverse down the cgroup_rstat_cpu updated tree and push
>>> + * parent first before its children into a singly linked list built from
>>> + * the tail backward like "pushing" cgroups into a stack. The parent is
>>> + * pushed by the caller. The recursion depth is the depth of the current
>>> + * updated subtree.
>>> + */
>>> +static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
>>> +				struct cgroup_rstat_cpu *prstatc, int cpu)
>>> +{
>>> +	struct cgroup *child, *parent;
>>> +	struct cgroup_rstat_cpu *crstatc;
>>> +
>>> +	parent = head;
>>> +	child = prstatc->updated_children;
>>> +	prstatc->updated_children = parent;
>>> +
>>> +	/* updated_next is parent cgroup terminated */
>>> +	while (child != parent) {
>>> +		child->rstat_flush_next = head;
>>> +		head = child;
>>> +		crstatc = cgroup_rstat_cpu(child, cpu);
>>> +		if (crstatc->updated_children != child)
>>> +			head = cgroup_rstat_push_children(head, crstatc, cpu);
>>> +		child = crstatc->updated_next;
>>> +		crstatc->updated_next = NULL;
>>> +	}
>>> +	return head;
> The recursion bothers me. We don't really have a hard limit on nesting
> depth. We might need to add another pointer field but can make this
> iterative, right?

I see. Yes, I think it is possible to make it iterative. Using recursion 
is just an easier way to do it. Will look into that.

Thanks,
Longman

>
> Thanks.
>

