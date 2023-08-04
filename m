Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF3A770151
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjHDNT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHDNTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EC046A8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yghE1gT7JEHr9Ft4Ug/jdVqABt7mGQZ6VHMNTdkCnVs=;
        b=EtXFSAf/R4Us0GdwQVVnqtZMOylXMwaCl0w8BecP7mtvHiIIoCiuWIcZoMNdJ9R5bOf4m3
        1sWsgw/MdSQ1PDoNT702pNqV8mnd5fcOMfyWr2/5/vEg8gk8NQr0QZXACZIkWENE0fb1IL
        l2j2+8Bnsuj88I0ueqOn4oOdbQyKouM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-w9U9nd_0P2K9r2FVugSwoQ-1; Fri, 04 Aug 2023 09:15:47 -0400
X-MC-Unique: w9U9nd_0P2K9r2FVugSwoQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a3a70425b4so3410785b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691154946; x=1691759746;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yghE1gT7JEHr9Ft4Ug/jdVqABt7mGQZ6VHMNTdkCnVs=;
        b=brw1FCy9VCnGmREfksu5Sz8Pbtg5QQq767FfoKujeUmSMDrdemXxHfRBmrMN36himL
         XmPOAiwR3QXImRYqZyJr8hnntZo2MlxgNUwriCA27vXrsz8EUyf0ovr9yhNNeeHtBirm
         EcWhx/o0zTPSYGRw6ti2v2bue2dJ7zD4j/NbA+hSWXkAsvYjCA9v+ZkyNRL7lHGz5JEs
         2gSTZ3AQ62CpVpepgTCM4Lq0lphyCOqftKv+KfV3432rfjqEcqj8ON+HjDJSGByOQ1DO
         eFpXvbc/qfOJQcLDJ6wnyVdsVaPLSF+c+9vOO8q0YdWA9C2dHxQZAiRMSzrFY/w+7pwG
         ISEg==
X-Gm-Message-State: AOJu0YwvxgM7ahsGadomO6g/43xtrwfp5KFwhqcrqA93cdNYscum/sVm
        mpq4MhWHSnjK3rH7BE1i0PB1xyxvFRTUyo2PFrqYojNbhOIAUw4XTo5B4UOanR16CHnKxCfcRcu
        3n0vsbfs0ld1ABxitNdd8te4jcHmFJ5Ss
X-Received: by 2002:a05:6808:1307:b0:3a0:5596:efe8 with SMTP id y7-20020a056808130700b003a05596efe8mr2348285oiv.54.1691154946636;
        Fri, 04 Aug 2023 06:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENWP+4GK74C7AuYHmh+2X37PsqlfaNPjW5MQ5IAf9v1dlH0ambZpvXNVp8pt59GOqaQo2gFA==
X-Received: by 2002:a05:6808:1307:b0:3a0:5596:efe8 with SMTP id y7-20020a056808130700b003a05596efe8mr2348264oiv.54.1691154946400;
        Fri, 04 Aug 2023 06:15:46 -0700 (PDT)
Received: from localhost ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id x16-20020a05680801d000b003a463ded3a3sm939158oic.53.2023.08.04.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:15:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: linux-next: Tree for Jul 31 (font problems on UML)
In-Reply-To: <dd29e5f5-d9f7-0103-e602-b98f26c88fb1@infradead.org>
References: <20230731140924.5d45b2b4@canb.auug.org.au>
 <dd29e5f5-d9f7-0103-e602-b98f26c88fb1@infradead.org>
Date:   Fri, 04 Aug 2023 15:15:43 +0200
Message-ID: <87y1ireyo0.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

Hello Randy,

Thanks for the report.

> On 7/30/23 21:09, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20230728:
>> 
>
> I don't know if this is related to FONT changes or fbdev build changes.
>
>
> on ARCH=um, SUBARCH=i386:
>
> WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>   Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
>   Selected by [y]:
>   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]
>

https://lists.freedesktop.org/archives/dri-devel/2023-August/417565.html
should fix this.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

