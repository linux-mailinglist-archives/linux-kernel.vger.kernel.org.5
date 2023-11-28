Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C0E7FC2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345459AbjK1STM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbjK1STK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:19:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81235198D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701195556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JEKWLaDVIFRpkj9puYB4V6jOflCn8/al2pYPArL2FG8=;
        b=ORe3wcaP55zGoFud6Fqh/0tWWYiO20iWN1dfGG1yfvzAO4J7H4EIUg370P1jRLmmpu+8XJ
        YyMaF8TcGtFosvcSRwGlqa1+ZOA02/s9Tp8fBdSYAht4AUHOQ831IwYzb8+aBq64AVTH7H
        3d+REf6B64e6VggpUVBHSMACizghyB0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-Hmkm9F9RPhqpbpAeIIjApQ-1; Tue, 28 Nov 2023 13:19:12 -0500
X-MC-Unique: Hmkm9F9RPhqpbpAeIIjApQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6834E185A785;
        Tue, 28 Nov 2023 18:19:12 +0000 (UTC)
Received: from [10.22.17.248] (unknown [10.22.17.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDF5520268D8;
        Tue, 28 Nov 2023 18:19:11 +0000 (UTC)
Message-ID: <521b7c3d-6c30-4176-bd72-d5826eff70cb@redhat.com>
Date:   Tue, 28 Nov 2023 13:19:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Expose cpuset.cpus.isolated
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20231127195105.290402-1-longman@redhat.com>
 <ZWYZfqAtObghsqxS@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZWYZfqAtObghsqxS@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/23 11:46, Tejun Heo wrote:
> Hello,
>
> On Mon, Nov 27, 2023 at 02:51:05PM -0500, Waiman Long wrote:
>> The root-only cpuset.cpus.isolated control file shows the current set
>> of isolated CPUs in isolated partitions. This control file is currently
>> exposed only with the cgroup_debug boot command line option which also
>> adds the ".__DEBUG__." prefix. This is actually a useful control file if
>> users want to find out which CPUs are currently in an isolated state by
>> the cpuset controller. Remove CFTYPE_DEBUG flag for this control file and
>> make it available by default without any prefix.
>>
>> The test_cpuset_prs.sh test script and the cgroup-v2.rst documentation
>> file are also updated accordingly. Minor code change is also made in
>> test_cpuset_prs.sh to avoid false test failure when running on debug
>> kernel.
> Applied to cgroup/for-6.8 but I wonder whether this would be useful in
> non-root cgroups too. e.g. In a delegated partition which is namespaced,
> wouldn't this be useful too?
>
> Thanks.

For simplicity,we only maintain one cpumask of isolated CPUs that 
includes all the exclusive CPUs in isolated partitions. We haven't 
maintain separate masks for delegation purposes. We can certainly extend 
that if the needs arise. At this point, the set of isolated CPUs is 
mainly used for determining what kernel background services can be 
disabled to reduce interference from the whole kernel point of view.

Cheers,
Longman

