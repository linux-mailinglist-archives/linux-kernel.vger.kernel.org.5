Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83157F1BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjKTRw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjKTRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:52:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EC394
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700502773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaP8zHgiN92957jp7fZCzqskbnxzXQoKIlUtUyIIKl0=;
        b=CDN8NVAJE4w3TourdOqHAQb3T2z+UiZ7MvZaEdLmHx9QIY41jFjk6QRaq1JpDbLXhvhhEU
        R7WX7GwGu3yHNzcmkn9+eMEJDREzv6aI1zp9LRADAZUP/nIE92axZxJ/HBOQSpphRIRegF
        9h/URM8d7PscPdYlEdNmGZqi8q4nJ+k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-5MHgQduvOpGFOS2IHDsWsg-1; Mon,
 20 Nov 2023 12:52:52 -0500
X-MC-Unique: 5MHgQduvOpGFOS2IHDsWsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 980C13C0F429;
        Mon, 20 Nov 2023 17:52:51 +0000 (UTC)
Received: from [10.22.33.229] (unknown [10.22.33.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D96E410F45;
        Mon, 20 Nov 2023 17:52:50 +0000 (UTC)
Message-ID: <eb92acba-6aab-487d-b06f-1da1c4796b4b@redhat.com>
Date:   Mon, 20 Nov 2023 12:52:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] cgroup/cpuset: Improve CPU isolation in isolated
 partitions
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Peter Hunt <pehunt@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20231116033405.185166-1-longman@redhat.com>
 <ZVoojBi4ZoVR2mOt@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZVoojBi4ZoVR2mOt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/19/23 10:23, Tejun Heo wrote:
> On Wed, Nov 15, 2023 at 10:34:00PM -0500, Waiman Long wrote:
>> v4:
>>   - Update patch 1 to move apply_wqattrs_lock() and apply_wqattrs_unlock()
>>     down into CONFIG_SYSFS block to avoid compilation warnings.
> I already applied v3 to cgroup/for-6.8. Can you please send the fix up patch
> against that branch?
>
Sure. I will post another fixup patch.

Thanks,
Longman

