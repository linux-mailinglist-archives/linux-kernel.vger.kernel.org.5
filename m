Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BBA78FAA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbjIAJUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348789AbjIAJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7D10D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693559978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TxaEqKAot2YDZpT3+Zb0cnetSMOO6oSzvZxYp8+PXg4=;
        b=ROXRJnM4KhvyUO74+2PaesrfYo/U28VGDo9EeuQBdiUiURjhC0+EBLAFpOi1Tes6SJeF3L
        aepljFZlkBMuP0RPFqJhbmgSwDiAUe6cMjMMQeoeRvQhymAcYfqN0DHN+chNu+4WVSXGcA
        fPoFzDJj0X5QfGw7H4idEdN4d4ZxwbM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-leakcTUGPLy8JcO3bNaRVA-1; Fri, 01 Sep 2023 05:19:37 -0400
X-MC-Unique: leakcTUGPLy8JcO3bNaRVA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3ff00714328so11554875e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 02:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693559976; x=1694164776;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxaEqKAot2YDZpT3+Zb0cnetSMOO6oSzvZxYp8+PXg4=;
        b=eS3b4bzo2jqjMX/jpJlcIAKJ0iT7GtPcR1lGhh7olvwoFLRlA46S3ahAruOISqjH8s
         orNMnhuImdkxQQA+PtphNLLUl2rakq4cqpLYLsRgmt/ItgiMhwp/R80Tnxx+J1fWh/FD
         AyexS9us8HIX330xS0VKk2sOQzg1vS+R9/2SLMCNlK7kn8LAgXD1TJ0ndqJRvEothLM0
         Ltw/mhvUe3Cnezvr30uWCSkEc/XTi9taOkQK7LFAhiww4u/y0htKOPDNt0stFIVU3Cqh
         2IWnBX4Yib2azavOzmqR+SOCw3IuuSRhn7Wfg2LCC126IEjC1oxu2T7nfVpzwy27dqDZ
         /IwQ==
X-Gm-Message-State: AOJu0YxKaxFXLtYutFpb58TPhBSq35ymePF8SSpC2htnXJeciKsRzz2V
        v+d6cwP9MtXufA6LnsqDp8CS9K9a4f4ugFOwNy6bU/jsGPf4K4TiPTyfGxn1mmxjuRpYSHNE4cZ
        9KCWJ6zteG+cdO8TblsuZrkwt
X-Received: by 2002:a7b:cb8f:0:b0:3fc:60:7dbf with SMTP id m15-20020a7bcb8f000000b003fc00607dbfmr1356347wmi.41.1693559976150;
        Fri, 01 Sep 2023 02:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgjIakCnIx1uWe1+b9ac1FNvsq5Jem3l4B20yMKwOjlq6edPw92y2dWuFW/CnZb1Ngwyk3yQ==
X-Received: by 2002:a7b:cb8f:0:b0:3fc:60:7dbf with SMTP id m15-20020a7bcb8f000000b003fc00607dbfmr1356336wmi.41.1693559975818;
        Fri, 01 Sep 2023 02:19:35 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fe1fe56202sm4283235wmi.33.2023.09.01.02.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:19:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
In-Reply-To: <5dj43wxsszikpwbwzxx5v5h7jbx4vjjavnhzi26xgfcdp5wsws@t2hd3pawau4t>
References: <20230830062546.720679-1-javierm@redhat.com>
 <6654778d-1f40-1775-c32c-ebf9728bc9a9@suse.de>
 <87ledqbah2.fsf@minerva.mail-host-address-is-not-set>
 <5dj43wxsszikpwbwzxx5v5h7jbx4vjjavnhzi26xgfcdp5wsws@t2hd3pawau4t>
Date:   Fri, 01 Sep 2023 11:19:30 +0200
Message-ID: <87jzta5jz1.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

> On Fri, Sep 01, 2023 at 09:48:09AM +0200, Javier Martinez Canillas wrote:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>> > Hi Javier,
>> >
>> > another idea about this patch: why not just keep the allocation in the 
>> > plane's atomic check, but store the temporary buffers in a plane struct. 
>> > You'd only grow the arrays length in atomic_check and later fetch the 
>> > pointers in atomic_update. It needs some locking, but nothing complicated.
>> >
>> 
>> Yes, that would work too. Another option is to just move the buffers to
>> struct ssd130x_device as it was before commit 45b58669e532 ("drm/ssd130x:
>> Allocate buffer in the plane's .atomic_check() callback") but just make
>> them fixed arrays with the size of the biggest format.
>> 
>> That will be some memory wasted but will prevent the problem of trying to
>> allocate buffers after drm_atomic_helper_swap_state() has been called.
>
> If we want to go that road, we don't even need an extra allocation, it
> can be part of the state or object structure itself.
>

Yes, I meant to have it as fixed-length arrays. But still the best option
seems to be to allocate them but in the CRTC's .atomic_check() and store
them in a CRTC private state as Thomas suggested.

Geert will post a v2 of his R1 support patches, I'll wait for those and
after that try to implement Thomas' suggestion.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

