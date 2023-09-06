Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EB47939A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbjIFKQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbjIFKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A588CC7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693995331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7P8kh6CIVjrAvpwiqFyzHCIsBPa3I3p11VQyjXy+3Zk=;
        b=h6ebQunvsQAC5qCltJw1T+eTRBqH5Sylz7w02Y4dvpYLXMMNuwBM1ePu4FZ8nKs+fuJCu+
        zxFDEVLp8XZ1//0oVPUrHFTyMRS6glFMmDyeHTLdfNNmFaR39mmCOedgfOWgklfRvvOVZD
        RgsCMtNRSc1Fg5ocoY/uyUBWKYc1e6s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-0KU3d17zPAaa3zdfALZplQ-1; Wed, 06 Sep 2023 06:13:39 -0400
X-MC-Unique: 0KU3d17zPAaa3zdfALZplQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40298cbbcdbso19901995e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995218; x=1694600018;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7P8kh6CIVjrAvpwiqFyzHCIsBPa3I3p11VQyjXy+3Zk=;
        b=UscU7ykOj0juTNPOU9Rqg0QdWqA+J0E/hMjnPqwSBwcckf5eD1hrT5xRw9M6yFJbha
         2VgRW31U0FxPSYv8cw5okXPrKpuW6AC3ZHJFPCbZ9k3KLV5/zc+QSZeGmhZ3VAw69CBL
         Vl7zORWLKupLpWOJdwX+Uc0tcdPXl7I9s3FMTgKH3QHCM40P3cZbNpDenvdMwUVJ4GTB
         BBhsV3HoRctD9tDH9AEYny16Cfs6fp0wjwTYbbFZYsCaZ+0iu8r9g8juiLqdgzT2JMvy
         q2eglX4tAEthODKYSirwrNbNWN1EtI2NuluBEuvmaiWofx4AJSMo98+Ht0Cl0oLwUet2
         g7uQ==
X-Gm-Message-State: AOJu0YyuF+lvsanJRyersWcYqC/Ol5EPGSqNmrO4cCW+NFJZsXCjSPLS
        fPCqSdJ6pSRiF3akYrZavRCOF7nh6ii+N1OHvO2mp1u7Vfcr1FOGr0Oy+XQE2thxJmnhrtJL7yt
        sZADWIGb4VFAmZeDeNdLraC7n
X-Received: by 2002:a7b:cc8f:0:b0:401:7d3b:ccaf with SMTP id p15-20020a7bcc8f000000b004017d3bccafmr1731100wma.4.1693995218315;
        Wed, 06 Sep 2023 03:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGa0rqlpwHCD3ArX4qRxa6wt4EmB6m2UPyb4S2zhNfk6B8JHfjyXVCJwwpoBZ8fsicra3CMQ==
X-Received: by 2002:a7b:cc8f:0:b0:401:7d3b:ccaf with SMTP id p15-20020a7bcc8f000000b004017d3bccafmr1731087wma.4.1693995218007;
        Wed, 06 Sep 2023 03:13:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fefca26c72sm19443756wmi.23.2023.09.06.03.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:13:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 7/7] fbdev/core: Clean up include statements in fbmem.c
In-Reply-To: <20230829142109.4521-8-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-8-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 12:13:37 +0200
Message-ID: <877cp34nji.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Remove all unnecessary include statements from fbmem.c. Most of
> them were for functionality that has meanwhile been moved into
> other files.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

