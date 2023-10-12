Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887987C7536
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441945AbjJLRyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379656AbjJLRyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8901BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697133249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFmlTU0whGflV8SQCVAE3kgzAoN0IEvaFssYzKGUMLY=;
        b=GJKD4JhSH9r8sShwNIi+Xs6KNs2FxS5gwfP77aYpWuYPTncO9+muqfBcz8GsybiOB5XxKs
        6i0fEi4s2pvuQYnqROZrE7yRMBkoqfG33MOIs94bHzfz2lyxdZkUBUtfIIIK2XRYGPO0Wx
        e65mxh9cyQU1DJxLsyJ0/VCFSU8CJdM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-FZ9tWwBzNSW9z59BEA-DsA-1; Thu, 12 Oct 2023 13:53:02 -0400
X-MC-Unique: FZ9tWwBzNSW9z59BEA-DsA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-53e1fe5b328so608782a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133181; x=1697737981;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFmlTU0whGflV8SQCVAE3kgzAoN0IEvaFssYzKGUMLY=;
        b=mwo1XSdkfI1bbqOd2NfjeWTrR3//rL/qXtlrQvqo7WZGBBwr5HgYF9YPcmNHIM/feH
         P02tzPUSi6yKek/701HKCYMozQDYa8n8fyf08QyM6cOgKPNImK3PEAg8LOTicf97RGYK
         H15zGVV2lnpwZmqgFvmYmgaVv+Il6P3/Ex3arH8IpxybVg7n17KWyJBC9HewG+7WNXeY
         3RgJNNggsz2DCU/6jioEGE7aQnswCm9MYwkC4419e25QsOlZl3DWdzFDuCHHsP9Xhpsi
         PwBG+A1Ei20rfADeHqWaRaz5vyguhMDrTUz80ZJY7HapBD/RMNpctDQpm0r0+BQ1Q9Q2
         Mxdw==
X-Gm-Message-State: AOJu0YzDBfPsBPOFGiMzSSKvHmPZLhK7sv4NwY0LRV8l5kwIYVFvSfM4
        9P1TkRV3tfkYhIA5WayOutkTrVwnS4rNVkb3dSGNHLw6pS4Bvb+YWO6OekzJ+vbXqaeJqXe9uSm
        9a36aeQqj6EhIgTiL4ZWGlyJr
X-Received: by 2002:a17:907:7635:b0:9a5:c9a4:ba19 with SMTP id jy21-20020a170907763500b009a5c9a4ba19mr22956681ejc.47.1697133181423;
        Thu, 12 Oct 2023 10:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDWRPItUQHPVnFrYhqkP09r7f/H7/7N+JuwoW5L/9difSByW8G/BZWddWWymKdYDVwwm2xZA==
X-Received: by 2002:a17:907:7635:b0:9a5:c9a4:ba19 with SMTP id jy21-20020a170907763500b009a5c9a4ba19mr22956665ejc.47.1697133181064;
        Thu, 12 Oct 2023 10:53:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id by8-20020a170906a2c800b009b913aa7cdasm11336219ejb.92.2023.10.12.10.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 10:53:00 -0700 (PDT)
Message-ID: <147a615b-be30-4959-baba-e56d1978c36b@redhat.com>
Date:   Thu, 12 Oct 2023 19:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/nouveau: exec: fix ioctl kernel-doc warning
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Dave Airlie <airlied@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
References: <20231008140231.17921-1-rdunlap@infradead.org>
Content-Language: en-US
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20231008140231.17921-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/23 16:02, Randy Dunlap wrote:
> kernel-doc emits a warning:
> 
> include/uapi/drm/nouveau_drm.h:49: warning: Cannot understand  * @NOUVEAU_GETPARAM_EXEC_PUSH_MAX
>   on line 49 - I thought it was a doc line
> 
> We don't have a way to document a macro value via kernel-doc, so
> change the "/**" kernel-doc marker to a C comment and format the comment
> more like a kernel-doc comment for consistency.
> 
> Fixes: d59e75eef52d ("drm/nouveau: exec: report max pushs through getparam")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for fixing this up, applied to drm-misc-fixes.

- Danilo

> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Danilo Krummrich <dakr@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
> v2: update commit text; somehow I sent a version of the patch before
>      adding the full text.
> v1: https://lore.kernel.org/lkml/20231007005518.32015-1-rdunlap@infradead.org/
> 
>   include/uapi/drm/nouveau_drm.h |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
> --- a/include/uapi/drm/nouveau_drm.h
> +++ b/include/uapi/drm/nouveau_drm.h
> @@ -45,8 +45,8 @@ extern "C" {
>   #define NOUVEAU_GETPARAM_HAS_BO_USAGE    15
>   #define NOUVEAU_GETPARAM_HAS_PAGEFLIP    16
>   
> -/**
> - * @NOUVEAU_GETPARAM_EXEC_PUSH_MAX
> +/*
> + * NOUVEAU_GETPARAM_EXEC_PUSH_MAX - query max pushes through getparam
>    *
>    * Query the maximum amount of IBs that can be pushed through a single
>    * &drm_nouveau_exec structure and hence a single &DRM_IOCTL_NOUVEAU_EXEC
> 

