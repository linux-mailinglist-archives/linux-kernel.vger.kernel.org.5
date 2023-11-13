Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314DD7EA313
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjKMSty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:49:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D410EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699901365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9Fat91VCfWswbfB4dQoar2RJWXbpc4KeUVKZoklMG4=;
        b=UTnm1QUR5rZRRZ3/+AIS0gDlleJ7KCgUVGQWKZF2kuLq0vJnjIeitJRybnU7xAQezDxCZ/
        fE0Wl/IFE0W6OY5145a5jf8Zbl3tqWIvM4BYH0t5KSa/XYVdo4HHJiRruJSciIduvS+UvH
        JSOlBgFfWwunXRLOtiqUVOGLNgsltWo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-XunLOqUuMTiUU8mrPhRrxw-1; Mon, 13 Nov 2023 13:49:23 -0500
X-MC-Unique: XunLOqUuMTiUU8mrPhRrxw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9e28d82339aso306259866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699901362; x=1700506162;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9Fat91VCfWswbfB4dQoar2RJWXbpc4KeUVKZoklMG4=;
        b=FU/bjWESd+CBAVSA+19KyFMKl9DI27afmcGruN6SvY4CncrV9+2Wq4gRwhU2VVEuVk
         v8SdfonUffQdfO1WoE6+4KxAsgupKZu2VRPXZbyYgk/vCGnbBFWSXtOIa9UsMkcQadyf
         UN7GNHAExB6MPvJF3YQiFtvsd67q52W3XfFHOl7RcaIhLT/mgvMq4ltfqIYOWOAMU/VF
         o6DdGvuA1RLsNFFOHmPc+Az44Qhf6sbzO8bJFDqmYEDDN2UiI0q5PC3aahmNJM6Ne62e
         OTDFgZQY6sjxUDgK5WonNstayBRPUc9oqxV2SZjJnUdikThMP5ObMgCTj1SMQ96j22np
         iKJA==
X-Gm-Message-State: AOJu0Yy3cQL63KEvZYaad/qyl8BsrYbgCvVOLpVpQb0YAw6F9eKiPvCw
        LyCPKOkBzMWewx7kGhzdALporvg5Jhm7X7Iwun8cGZQMRqRjoCV5iDDAhT8aT6MggLcx5Ca4EHQ
        CCPNoMIV3icAUMh60Xmk9EYh4
X-Received: by 2002:a17:906:3bd7:b0:9dd:7ccf:77f8 with SMTP id v23-20020a1709063bd700b009dd7ccf77f8mr4957512ejf.20.1699901362782;
        Mon, 13 Nov 2023 10:49:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ0uVWVogauvgHwe0HaAW2uaROhlGctVUZQkTd5P1FixQh0Rbjuz2KkG7VPVhO+wwo/3DUDA==
X-Received: by 2002:a17:906:3bd7:b0:9dd:7ccf:77f8 with SMTP id v23-20020a1709063bd700b009dd7ccf77f8mr4957500ejf.20.1699901362466;
        Mon, 13 Nov 2023 10:49:22 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906471800b009dda94509casm4368759ejq.102.2023.11.13.10.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 10:49:21 -0800 (PST)
Message-ID: <373d97fc-0612-40da-ae9d-6702aa4483ba@redhat.com>
Date:   Mon, 13 Nov 2023 19:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver: gpu: Fixing warning directly dereferencing a
 rcu pointer
Content-Language: en-US
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <d33fc41b-5a1f-4186-a0b2-3c82dcb8f00b@redhat.com>
 <20231113184238.3276835-1-singhabhinav9051571833@gmail.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20231113184238.3276835-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for sending a v2.

On 11/13/23 19:42, Abhinav Singh wrote:
> This patch fixes a sparse warning with this message
> "warning:dereference of noderef expression". In this context it means we
> are dereferencing a __rcu tagged pointer directly.

Better use imperative here, e.g. "Fix a sparse warning ...".

Wouldn't ask you to send a v3 for that alone...

> 
> We should not be directly dereferencing a rcu pointer, rather we should
> be using rcu helper function rcu_dereferece() inside rcu read critical
> section to get a normal pointer which can be dereferenced.

...but this doesn't seem accurate anymore as well.

- Danilo

> 
> I tested with qemu with this command
> qemu-system-x86_64 \
> 	-m 2G \
> 	-smp 2 \
> 	-kernel bzImage \
> 	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
> 	-drive file=bullseye.img,format=raw \
> 	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
> 	-net nic,model=e1000 \
> 	-enable-kvm \
> 	-nographic \
> 	-pidfile vm.pid \
> 	2>&1 | tee vm.log
> with lockdep enabled.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
> v1 -> v2 : Replaced the rcu_dereference(...) with unrcu_pointer(...) and
> also removed the rcu locking and unlocking function call.
> 
>   drivers/gpu/drm/nouveau/nv04_fence.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nv04_fence.c b/drivers/gpu/drm/nouveau/nv04_fence.c
> index 5b71a5a5cd85..cdbc75e3d1f6 100644
> --- a/drivers/gpu/drm/nouveau/nv04_fence.c
> +++ b/drivers/gpu/drm/nouveau/nv04_fence.c
> @@ -39,7 +39,7 @@ struct nv04_fence_priv {
>   static int
>   nv04_fence_emit(struct nouveau_fence *fence)
>   {
> -	struct nvif_push *push = fence->channel->chan.push;
> +	struct nvif_push *push = unrcu_pointer(fence->channel)->chan.push;
>   	int ret = PUSH_WAIT(push, 2);
>   	if (ret == 0) {
>   		PUSH_NVSQ(push, NV_SW, 0x0150, fence->base.seqno);

