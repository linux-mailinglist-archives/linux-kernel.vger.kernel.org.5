Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7177E4004
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjKGNYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjKGNYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F9CD6E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699363420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6FU32l39lKCSdZhSytwDwo2S8vBHIikXujdpUSbPKo8=;
        b=PvTOtuNAgO5a4t4fAwNwn7zoMgnxsUmUSgmCiWJ7nonTxC9OWiBBpjI1S/xoB+ihLJTFz9
        DdOBtc8uVmgG9Y3pY2FFaQSFQElzz+u6ZF1mLOYvLXwPodaydTkEueoisZRthjPaUKIdeZ
        4/VGbIALM2xCwOZzsK9s9IM6mDSaa4k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-0LwpXkEhMzucEYKodt8AZQ-1; Tue, 07 Nov 2023 08:23:39 -0500
X-MC-Unique: 0LwpXkEhMzucEYKodt8AZQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f7943913aso2940789f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363418; x=1699968218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FU32l39lKCSdZhSytwDwo2S8vBHIikXujdpUSbPKo8=;
        b=U+VB4ceoWzpUIfBP0YP0RCIokV+Phy1hfvHwY/h/ujXbkyYyXPn418//BrDHiH9WpM
         azdcHpBAXLIeSdsLR5Sovchx6Mwbq9WI1LiadNBDHIF0Ec/mrHgwHG5VEbEy3aRTXq60
         Sqs3OXuUyFtYHWAS90zHDThvYW4hX72N0CHKbaEnf3CZFhb3vb15e1Yj4JGQOI7/KD/+
         7/pCZb9Skz/kx5bxGZNgbvyeoSyBoIKQR9XpCyaMK7dcMeYnCCg1LI9FQC8gkoLvqKvT
         thQEY4wiw8KY4bBZZVR2c/i7RZc7+WwsvxDWw/b1K4NMeKf3RAcFb/yfCJ4t/7e+AR1M
         sxtQ==
X-Gm-Message-State: AOJu0YziOlHLcc8/Qs59LaItyIP33kYnbjPIt+MpF4PDWhRsETO893AK
        Ke4rpyFz6dRuIGTGCxwGNtbtZebtTuY+qQGeu5D988Xb2qZ6/N8nQC3k9wjt6gOG7XtfIOFAegE
        /Sea39BrIRSTcA4CkTyZmIjft
X-Received: by 2002:a5d:64af:0:b0:32f:aaff:96dd with SMTP id m15-20020a5d64af000000b0032faaff96ddmr11425179wrp.4.1699363417940;
        Tue, 07 Nov 2023 05:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkb/2QIpst9kXo1JNieCe98S9IH2A6ymDLslfoNXCzUG50rRwswfRq4amhWEX0BKprIvqrcA==
X-Received: by 2002:a5d:64af:0:b0:32f:aaff:96dd with SMTP id m15-20020a5d64af000000b0032faaff96ddmr11425155wrp.4.1699363417297;
        Tue, 07 Nov 2023 05:23:37 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
        by smtp.gmail.com with ESMTPSA id o3-20020a056000010300b0032da4f70756sm2391885wrx.5.2023.11.07.05.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:23:36 -0800 (PST)
Date:   Tue, 7 Nov 2023 08:23:32 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107082214-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
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

On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 

I'm not sure there's even value in bothering with iommufd for the
simulator. Just find a way to disable it and fail gracefully.

-- 
MST

