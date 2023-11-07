Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246577E41DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjKGObV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjKGObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:31:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B8DF3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699367431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0BEK4Nq2797qPXi5hUhUOD+w7Yxl1Y5y6keCDboqBnw=;
        b=Of4PASZjPYtpcx7NaEMxBZk8sa21j4tPyCox960KCw1SRFDq6fyBYirTpQwXvG56TRQ5ZO
        Rdphcb1uqHZisgU16dif/C64RhKLCAnMjCYPSnFnplKf0zuzF+G9lRODXNg3XqML5bAMWc
        4UaX0SLfU+fezPOAkyOpD9LxwxnXvVs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-GmTw2rmmOqWKADrNPUH2LQ-1; Tue, 07 Nov 2023 09:30:27 -0500
X-MC-Unique: GmTw2rmmOqWKADrNPUH2LQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507b8ac8007so6212988e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 06:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699367426; x=1699972226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BEK4Nq2797qPXi5hUhUOD+w7Yxl1Y5y6keCDboqBnw=;
        b=HX22ww6if3i3ZD8ORPKpl2qF8ZOK3nDP7+XQv6lTXjgisY/0VUbBcw47o2HGmrnocO
         kZJEZqSD5cOe3sXuLDR7xGmAa7aLGF9wYOnFg18z4uY1oShlMBDtKTsbJ0wlSQOsVUvI
         85662LlobVoVYRyF+phV6X99FgmCyCM+QlX6F0V48gk6v+b7yYOimvmgqxrfHuLueHY1
         IAw2CcAXxecauj+cfd2fXly10g4s30E6LgnB7ZldsP2Y02P2CSnZGtaivKY4WkwQVepC
         Cq2UAj3CFM+OHp1rvAgev6E6Fmssp6KEi1y9Z2VczgX91AgT61PboK1FvWSNDnUGG8Z2
         6ltg==
X-Gm-Message-State: AOJu0YyfUDGQ4DpAmLS27Kqxc0XM8zNO4PgetvS+ib/Ky8iibsowEomU
        oK4hbauF8Xd0A47MW5EFvZ+8xbhCoo97/lXYEM+u7Uh8MAJJndEnlVPYn5oj1RkWysELlMA4LYi
        2Q60uA8SSeSYvBGUeeXFbjQ1+
X-Received: by 2002:ac2:488e:0:b0:500:7cab:efc3 with SMTP id x14-20020ac2488e000000b005007cabefc3mr23998200lfc.11.1699367426352;
        Tue, 07 Nov 2023 06:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJy8gOlznCOc9sukgGEsAedAcGzp6nnH6baVR5lODsEIZgCRdZq2T6s/WT4PvnZAwy92AFJA==
X-Received: by 2002:ac2:488e:0:b0:500:7cab:efc3 with SMTP id x14-20020ac2488e000000b005007cabefc3mr23998175lfc.11.1699367425918;
        Tue, 07 Nov 2023 06:30:25 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000100600b0031984b370f2sm2499881wrx.47.2023.11.07.06.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:30:25 -0800 (PST)
Date:   Tue, 7 Nov 2023 09:30:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107092551-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107082343-mutt-send-email-mst@kernel.org>
 <20231107141237.GO4488@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107141237.GO4488@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:12:37AM -0400, Jason Gunthorpe wrote:
> Big company's should take the responsibility to train and provide
> skill development for their own staff.

That would result in a beautiful cathedral of a patch. I know this is
how some companies work. We are doing more of a bazaar thing here,
though. In a bunch of subsystems it seems that you don't get the
necessary skills until you have been publically shouted at by
maintainers - better to start early ;). Not a nice environment for
novices, for sure.

-- 
MST

