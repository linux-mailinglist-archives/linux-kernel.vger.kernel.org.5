Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40907F5043
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344220AbjKVTKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjKVTKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:10:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6597493
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700680235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsoJo2l8lD4Jvd7NTpN+4+u9qrR7rpvUbJoMpoTC8R8=;
        b=Nda69vvDz/Z/B53ytItodxHyn1yzpTTz86Rkw8eIH2gA31Md7m9xfFY3EfWBnkcMvCQfK8
        JhimaicePmsYfM5dWIyHt79KwMdEv6d4nUyywRJAIQNc7OmykX53d47UPaM26rHM68x5oL
        7NPV6C05Eevu98HEcF2RRHws1bByc/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-v4A_Y-yrNxGAUxHQgtLjsQ-1; Wed, 22 Nov 2023 14:10:32 -0500
X-MC-Unique: v4A_Y-yrNxGAUxHQgtLjsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02151810FC1;
        Wed, 22 Nov 2023 19:10:32 +0000 (UTC)
Received: from [10.22.17.147] (unknown [10.22.17.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BACD21C060AE;
        Wed, 22 Nov 2023 19:10:31 +0000 (UTC)
Message-ID: <ac0242e3-74ab-426a-a806-e12d9eba2435@redhat.com>
Date:   Wed, 22 Nov 2023 14:10:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] workqueue: Make sure that wq_unbound_cpumask is never
 empty
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     zhuangel570 <zhuangel570@gmail.com>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
References: <20231120121623.119780-1-alexyonghe@tencent.com>
 <ZVuudtAtDqHqYJr8@slm.duckdns.org>
 <CANZk6aTS9BODJiqtDSHxwhz2dV3RmaxRautR8WZfH5aYYhcQJw@mail.gmail.com>
 <ZV0jmGSismObVncD@slm.duckdns.org>
 <8f469287-e29a-4473-a181-9013292ef62c@redhat.com>
 <ZV4mPoOvIgX9Um0z@slm.duckdns.org> <ZV4rEDd-5E83wJrJ@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZV4rEDd-5E83wJrJ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/23 11:23, Tejun Heo wrote:
> On Wed, Nov 22, 2023 at 06:03:10AM -1000, Tejun Heo wrote:
>> It's a workqueue fix patch, so what I'm gonna do is land this in
>> wq/for-6.6-fixes and just resolve it in cgroup/for-next.
>             ^
> 	   7
>
> So, I applied the fix to wq/for-6.7-fixes and merged it into cgroup/for-6.8
> for conflict resolution.

That will work too. Thanks for taking care of that.

Cheers,
Longman

