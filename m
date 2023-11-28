Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E997FB932
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbjK1LPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbjK1LP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB93D45
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701170132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XwvmjFErIGzwz5go6JPDHcyZkRWLzYD3EQT1Kkemfnk=;
        b=R5ipbPuSxoGIKeAJBMo23ZqzY10ucnIO0/ZLyl4sYD5KCVqCgwZH6qTTsIEQyEeGnY//Ot
        qdFPmHA7qVikz9FvVDmgJcFGiGfGl4eEbVEc88Cg+xbsioTdQi7lf4f3bxJtnpdXbz8fhF
        LikeIomTseoMFt4B+TZ3KunrK/RpqoY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-Vw6gbMdWNmKimPGBH-G8Xg-1; Tue, 28 Nov 2023 06:15:31 -0500
X-MC-Unique: Vw6gbMdWNmKimPGBH-G8Xg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b38501d82so27972075e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701170130; x=1701774930;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwvmjFErIGzwz5go6JPDHcyZkRWLzYD3EQT1Kkemfnk=;
        b=A7TaBLhtDr9DRgRDdgso8XhmAQLflcRBxQClP7UCdV59u1eMuexXsmKy6m4Or9Vz4u
         8wUFDJi1n2Rim5F0TO+2ASd42ALPwBuPsDG1bA50PjQHg9RzNa4cpN7HQl8AD/Xi2trF
         IOLU7EM/CkhxKGtvixAADrzOKl0dke1e5n3qUwHmQV4f14/+3aYuojYtNRbxkzs4XO66
         lZOrX/D66PzuelIeW6SvFjwogy4ftmZ9Gd/zRP3zlbS7ue0BvmukHeCJMNxWzJsaPztr
         6LVaodkCL0zX/bPGptf1o33BIoRHOuBpnpbP6OG6NUqT0fCbwsIymDtRUvjCIvVa9ugx
         TxQQ==
X-Gm-Message-State: AOJu0Yy3KdU5YpBqoxAAOwEB2AANAQLxdHtBfE3bsZOGGyhTPBrUcykW
        4/rbt/fPzFIX4QExXqEVfW8fTq5WcrFT2Fa7oFRWcJy2B5oc8NtWHc/YfmAX+aUw2/jgVS3gzcs
        pf7Ykt/J4vpkjzwxuC13USJ1R
X-Received: by 2002:a05:600c:46ce:b0:405:37bb:d942 with SMTP id q14-20020a05600c46ce00b0040537bbd942mr11304279wmo.4.1701170129913;
        Tue, 28 Nov 2023 03:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjIkoXG2gDHfX1ljO9mtdizJ2dUC2E1WgpYfyZokwGf55M1EY3JopOUWWYB/pF4LqfYH+Xmg==
X-Received: by 2002:a05:600c:46ce:b0:405:37bb:d942 with SMTP id q14-20020a05600c46ce00b0040537bbd942mr11304257wmo.4.1701170129524;
        Tue, 28 Nov 2023 03:15:29 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b0040b347d90d0sm17744555wmq.12.2023.11.28.03.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:15:29 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Marco Pagani <marpagan@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kunit: run test suites only after module
 initialization completes
In-Reply-To: <20231128101627.65399-1-marpagan@redhat.com>
References: <20231128101627.65399-1-marpagan@redhat.com>
Date:   Tue, 28 Nov 2023 12:15:28 +0100
Message-ID: <878r6icenj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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

Marco Pagani <marpagan@redhat.com> writes:

Hello Marco,

[...]

> @@ -737,12 +738,14 @@ static void kunit_module_exit(struct module *mod)
>  	};
>  	const char *action = kunit_action();
>  
> +	if (!suite_set.start || !virt_addr_valid(suite_set.start))
> +		return;
> +

I would add a comment here explaining why this condition is checked and
what it means. Maybe something like the following ?

+       /*
+        * Check if the kunit test suite start address is a virtual
+        * address or a direct mapping address. This is used as an
+        * indication of whether the kunit_filter_suites() was used
+        * to filter the kunit test suite or not.
+        *
+        * If is not a virtual address, then this means that the
+        * kunit_module_init() function was not called and the kunit
+        * suite was not filtered. Let's just bail out in that case.
+        */
+       if (!suite_set.start || !virt_addr_valid(suite_set.start))
+               return;

The patch makes sense to me though and agree that is a better approach.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

