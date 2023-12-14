Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602F78124C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442987AbjLNBwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442971AbjLNBwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:52:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1625E0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702518727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AXXFjkdvphmQ1MZVdZxrm1IU4YccGEU/JmOtXsDs6c=;
        b=OE/OHna9DsPkQGLY2qVXz9FCpEfSDPD23MpBYRyeOZZJNANxHTi7diiyFGb5iEdhOcaeeR
        qa0UBD5YQmscmeL654cDYxc2iPKNiSYvAXDJr8+hvoHjMuxcnVoqiwFnv7fv/7/GBSjDlL
        hQNZb1g7kBuo1tjxg0kjgITVQ49/+og=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-FawC5tQhPU2pB8SQSY2xmw-1; Wed, 13 Dec 2023 20:52:05 -0500
X-MC-Unique: FawC5tQhPU2pB8SQSY2xmw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A21685A588;
        Thu, 14 Dec 2023 01:52:04 +0000 (UTC)
Received: from [10.22.33.1] (unknown [10.22.33.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 017AD492BF0;
        Thu, 14 Dec 2023 01:52:02 +0000 (UTC)
Message-ID: <ff0c735e-9e8e-4f26-96eb-3927c26e1e01@redhat.com>
Date:   Wed, 13 Dec 2023 20:52:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] locking: add define if mutex_destroy() is not an
 empty function
Content-Language: en-US
To:     George Stark <gnstark@salutedevices.com>,
        andy.shevchenko@gmail.com, pavel@ucw.cz, lee@kernel.org,
        vadimp@nvidia.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hdegoede@redhat.com,
        mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com, nikitos.tr@gmail.com
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
References: <20231213223020.2713164-1-gnstark@salutedevices.com>
 <20231213223020.2713164-3-gnstark@salutedevices.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231213223020.2713164-3-gnstark@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/23 17:30, George Stark wrote:
> mutex_destroy() is only a debug helper and an empty function on non-debug
> configurations still we can't legally ignore it because it's the
> established API call and it can be extended theoretically in the future.
> Sometimes it could be useful to know e.g. in the higher-level API if
> mutex_destroy() really does something in the current configuration
> and it's should be called or skipped otherwise for the sake of
> optimization so add dedicated define to recognize these cases.
>
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>   include/linux/mutex.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index a33aa9eb9fc3..2395ce4fcaf6 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -83,6 +83,9 @@ struct mutex {
>   
>   extern void mutex_destroy(struct mutex *lock);
>   
> +/* mutex_destroy() is a real function, not a NOP */
> +#define mutex_destroy  mutex_destroy
> +
>   #else
>   
>   # define __DEBUG_MUTEX_INITIALIZER(lockname)
Acked-by: Waiman Long <longman@redhat.com>

