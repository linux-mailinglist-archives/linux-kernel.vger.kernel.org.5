Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DBD79399D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbjIFKOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjIFKOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1626C10F9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693995201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSB+vCAalu3WUew7xxSbOR2TbNfeFmYmf0o3TX9uef8=;
        b=UuC6OVyT5/a2e+q+PTNUSfBIZNtkg5Ui7389sJiq3XTxlrezONl12nQeCRyh0ZvutKIkNA
        v9g0XE/xdJUS9nKiqZgH5w2rr6vIpA/nUcSWkRMzcMvAUpU1gNrnoRr9fRck/vWLrfetMY
        8fp2uHxPXUp8YZhxf7fGPqh8KOcXJTo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-6OyXdo91PpSYfAXJzI0BoQ-1; Wed, 06 Sep 2023 06:13:18 -0400
X-MC-Unique: 6OyXdo91PpSYfAXJzI0BoQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-402c46c4a04so21118955e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995197; x=1694599997;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSB+vCAalu3WUew7xxSbOR2TbNfeFmYmf0o3TX9uef8=;
        b=GwxmwTNbNpSgUnpglGMYYDJ1errNxB62hTYDuQfyxGz1j+ThJ1DJ2GNYIBKLPvBcfw
         ThcJQ7BSOziKGrJovvVB3ZROjaTzZHVi5y7PSnNFDXK2v7XplgE2pR1Db4Hddc0oDBXo
         be+5aOs3JH8Fkg2ldw0O3FOb/qC/KIHvm5H/AyxVfA9dpqzbFXil4J05EpbrCI88s8zp
         h7FZu0D2zlTpjpPHmTRhGoeg9Dc1tMIY27ZB/aQQJbnIWNKi4sZKruI4Q+5d4+vx8lcw
         iUW15BIPGjJIFwrBuZCvE2sJJJ6bojtt8C0RMUZPz7FEv8nNKTRnMuBse/aIEFsM+Dch
         zCvw==
X-Gm-Message-State: AOJu0Yz3pD3I9DQoWzG2kLqYXRPoCSlyBNAfpZI/1lAFBbCn4gfiJma3
        aZa45gXvdGAzHC+NcCcqFPIg3Q5KVOOK8EQyO0ntvExm7ayUkTplpITG88EZFsipuLNTePpXEIt
        qNKJZdjRjqbuV3hwGhKlXd8/r
X-Received: by 2002:a05:600c:301:b0:3fc:60:7dbf with SMTP id q1-20020a05600c030100b003fc00607dbfmr1790118wmd.41.1693995196928;
        Wed, 06 Sep 2023 03:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnVKep36NTxhm2Uz+EzZ6XCQaju2TJOZj/zg0bqn2Adp/5Scn3RpkEDRfRw4uwyOH1UrQfNA==
X-Received: by 2002:a05:600c:301:b0:3fc:60:7dbf with SMTP id q1-20020a05600c030100b003fc00607dbfmr1790100wmd.41.1693995196613;
        Wed, 06 Sep 2023 03:13:16 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z17-20020a7bc7d1000000b003fbdbd0a7desm22321298wmk.27.2023.09.06.03.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:13:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 6/7] fbdev/core: Remove empty internal helpers from
 fb_logo.c
In-Reply-To: <20230829142109.4521-7-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-7-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 12:13:15 +0200
Message-ID: <87a5tz4nk4.fsf@minerva.mail-host-address-is-not-set>
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

> Remove the two empty helpers for the case the CONFIG_FB_LOGO_EXTRA
> has not been set. They are internal functions and only called once.
> Providing empty replacements seems like overkill. Instead protect
> the call sites with a test for CONFIG_FB_LOGO_EXTRA.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

