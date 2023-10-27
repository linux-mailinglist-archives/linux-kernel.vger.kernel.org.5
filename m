Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862067D93C3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbjJ0Jcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345622AbjJ0Jci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5761A7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698399108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i5tK4NsSAMVwjRdwU7wyEET86Ne+WP2XLYS+WWydcWk=;
        b=Sgvk9H2xvBT2DLHy0pfixyAp8tYRdSMhJmqmf3FhuGTln2SgPvDmT/ExG9ALItx7gkCcm7
        7k2+hAAYChfBg6L1Xwpld9Q+mBRySOl/ge6Ots3gGaKIwl6isqhPXACQTzcI/YA9r6hLry
        3mvZEO6FO5E8nNkHetaoH0dLjgyC0mQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-ZDxDjHaBML-A5ayFFYlVDQ-1; Fri, 27 Oct 2023 05:31:47 -0400
X-MC-Unique: ZDxDjHaBML-A5ayFFYlVDQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32d8d17dcbaso962496f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399106; x=1699003906;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5tK4NsSAMVwjRdwU7wyEET86Ne+WP2XLYS+WWydcWk=;
        b=dZojstezK9/d6zu+IVwDgmuygrbzOxyEicMXNavQYQi3UXiAxQCnSeDHkw7Q1XxFRo
         90PgxQ7XCCs28kOsAGc8Qc0uPc+lKKv+bJi5gupQ7Ve38Coi+NDtWIB65m3z+9+nqv4J
         r4Fmo3NpxWYWTdewYPsvaJR93uxZ6/7TxAR8EC9p6m/KZwU2RhCGxY6QFIJm/eNs9S1C
         mEcgILKHud1u0E/Vb3FFFeK1IQjnbu/Irw2BTfqZAVq0R8wjFMymYHWLR8NSqSxsLRES
         D3zI1+Q2pJUkIuSofvI77Joj9t9IHjWBVfmSA9srAIGMQMWJiz+dTPbcrXOUQyzrCWG6
         DAlA==
X-Gm-Message-State: AOJu0YxMGVclBzPwqjzbvtEDdseKGRZ3t+h94bPCDe5cmjb+sKV/fEaq
        Wg5tAxs5Z4aBXL2Fqvms/5YbjrSoVbQCZnfy3FZNpWUnSXddWpsLSG7Mo/7UGtsnTT8C8dGLQ/X
        rXyJqaDDNhOSjrZEfNGFQ6eeK
X-Received: by 2002:adf:ec52:0:b0:32d:a405:b6b7 with SMTP id w18-20020adfec52000000b0032da405b6b7mr1728466wrn.32.1698399106370;
        Fri, 27 Oct 2023 02:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4GTSZ5mevbLNAhGTl6ibJEtqheMFk0mh+g9KjS0o00s6f7UUrHkcef0JX6jVsVgS7HiPf/A==
X-Received: by 2002:adf:ec52:0:b0:32d:a405:b6b7 with SMTP id w18-20020adfec52000000b0032da405b6b7mr1728454wrn.32.1698399106098;
        Fri, 27 Oct 2023 02:31:46 -0700 (PDT)
Received: from localhost ([212.80.183.76])
        by smtp.gmail.com with ESMTPSA id j15-20020adfb30f000000b0032d8eecf901sm1369948wrd.3.2023.10.27.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:31:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jocelyn Falempe <jfalempe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] drm/ssd130x: Fix possible uninitialized usage of
 crtc_state variable
In-Reply-To: <b048247c-75e9-488e-a4f3-b227a38bca5e@redhat.com>
References: <20231020225338.1686974-1-javierm@redhat.com>
 <b048247c-75e9-488e-a4f3-b227a38bca5e@redhat.com>
Date:   Fri, 27 Oct 2023 11:31:45 +0200
Message-ID: <87v8aso1ha.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jocelyn Falempe <jfalempe@redhat.com> writes:

> Hi,
>
> On 21/10/2023 00:52, Javier Martinez Canillas wrote:
>> Avoid a possible uninitialized use of the crtc_state variable in function
>> ssd132x_primary_plane_atomic_check() and avoid the following Smatch warn:
>> 
>>      drivers/gpu/drm/solomon/ssd130x.c:921 ssd132x_primary_plane_atomic_check()
>>      error: uninitialized symbol 'crtc_state'.
>
> That looks trivial, so you can add:
>
> Acked-by: Jocelyn Falempe <jfalempe@redhat.com>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

