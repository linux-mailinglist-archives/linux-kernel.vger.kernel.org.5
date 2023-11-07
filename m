Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD897E422B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjKGO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjKGO4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:56:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D86C11F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699368943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QiSVy1pXRSo5MmppHuXGQ+MP2WzuNcVblg0LwRCEErU=;
        b=JZ62WoI7UuEEuxbht226EgKZbMmygScDbg/AOn5rnBKhq+1JwDKEC+eRaR1K9IqQSAqXR4
        84ZejCxe+JNqEPALKTdgwoa7nBxMQ8pIzR/49sucQOYnWLjNFhTgnrAJWzji8dlp7TRtwp
        tsEVi1LbO3XS021z6yWkkEIxkcl33w4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-DvNlx5QENgeEPlGW6WcwKA-1; Tue, 07 Nov 2023 09:55:32 -0500
X-MC-Unique: DvNlx5QENgeEPlGW6WcwKA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-408695c377dso36282335e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 06:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699368931; x=1699973731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiSVy1pXRSo5MmppHuXGQ+MP2WzuNcVblg0LwRCEErU=;
        b=CrwYjaox7QLWTd2Vsx1wMuJbZ5cl4rwtkAkwIViTVtEBRt4c4DAkDtJ+zKR5oMZZ0U
         Wrk6wzEhdvf92OduYY/jjOjAdDDILfr2dMev46QLOO5Jko7PbrC/Kt3OStcSHhqyUq9A
         k0vuW/dzKOcbbpS/x0UwAQRnbuROr1Z9JTqBvjifJQ26T5+W4DDJ9GY9rFCMxmsRB2zx
         WyY3yp3vYYaHX1asDPX07axx4DN5jX1I5Q3aQqszV4G6x9Eqj4u8U12Lh0zWPPYH+ZE/
         18ZGtiwfNPnovZ0mSkgA0cJr+SVEOn+6V0QLixFpEJDL67h1UlVoR7gMYYISJ+OPUqla
         lWlA==
X-Gm-Message-State: AOJu0YzlWyqdfmwxS3f7/P+UK2Yk7IQHEcu2wYjxIpoSV9b22RIqjnLD
        7yjv6xnmYKlX4sI4O2gmPH45FFQvIVhdtr4JNjRbzQQIZign/BSlPi5V6e1V5PWiIHUoFC2OnSG
        cqx9FeYI5U8NEc5rhauqhgb49
X-Received: by 2002:a05:600c:4687:b0:401:bcd9:4871 with SMTP id p7-20020a05600c468700b00401bcd94871mr2498498wmo.21.1699368930997;
        Tue, 07 Nov 2023 06:55:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzbMM8W1j1GgoDZM90c2d8/HJ8vQIG2CKZzYqMIhxHMdsZxgqX9hfyV1Tq0rIL8huNSNR6FA==
X-Received: by 2002:a05:600c:4687:b0:401:bcd9:4871 with SMTP id p7-20020a05600c468700b00401bcd94871mr2498480wmo.21.1699368930620;
        Tue, 07 Nov 2023 06:55:30 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
        by smtp.gmail.com with ESMTPSA id o5-20020a056000010500b00327bf4f2f14sm2556719wrx.88.2023.11.07.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:55:29 -0800 (PST)
Date:   Tue, 7 Nov 2023 09:55:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107094818-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107124902.GJ4488@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> IMHO, this patch series needs to spend more time internally to Red Hat
> before it is presented to the community.

Just to add an example why I think this "internal review" is a bad idea
I seem to recall that someone internal to nvidia at some point
attempted to implement this already. The only output from that
work we have is that "it's tough" - no pointers to what's tough,
no code to study even as a bad path to follow.
And while Red Hat might be big, the virt team is rather smaller.

-- 
MST

