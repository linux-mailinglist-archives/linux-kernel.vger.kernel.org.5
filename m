Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668977E0097
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjKCIF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjKCIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C7D45
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698998703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0goRDSlLlyjMoDih0tqHLHjHlJcT6C1DNszg6j75nEY=;
        b=Svx7GJ+XVwJYjSDAQtts28buSRJ1hpO95IqtT4UqkL+iC4VPexoSZUvyAcuE2haORcUmub
        94Qr/NqaeB2bQffsEWCX8fQJdptGiV4W9ZuyuPVhkSCcVmF629zvVqWWliIDr7l+wHvLkc
        h4+FZ9gxUIzktBYVmL5eM0HmoyBaBrQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-miNfQpFcNv2DFO_l9yMZTQ-1; Fri, 03 Nov 2023 04:05:00 -0400
X-MC-Unique: miNfQpFcNv2DFO_l9yMZTQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4090fa518bbso11868555e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 01:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698998699; x=1699603499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0goRDSlLlyjMoDih0tqHLHjHlJcT6C1DNszg6j75nEY=;
        b=neintl/I7hmzfv6eM0woqz2r5vLE7HJmnJYNh+AZr4JeLhpnXCCtJONmNlqemjLonT
         hQhEMryfzFGe+qK2E6au4U1CXkKCJkr+j1iAv7Z+rvKWcu/VzRlgvhPLxFQnYTc7ScCV
         Fcg9QRI6z6DI94/ltGLOyr6uGOROYey5GEexLjpOwxDkIUQjlxHnFEyMQrr0VT+LMr9C
         2CZapSU35jKEsUWQJ7fDqlzG+Z/w4zzD/+WvngOx/Sunm+tCHrA6KJvsNzz2NV5sgO+x
         lEBtFBWI5F8kKPrSukRu4LHbSGtQiisI1X7A/98ITghiptURPlF+wIjjxo0S3ChxqHMV
         pcAA==
X-Gm-Message-State: AOJu0YzXORY5fs2Rvpmv6o53LmYmFN+ULNqt3U13QcJJ4YBZQ9Acd582
        okWedrhh2hYC78zT3eZjNRxSHALEttwmCu7yuvC2cbcm29k9gt4or4yi8zCv1JX3YiKlP2TVpbs
        52E2QiYmCE3DmcMqSJuOCXTRY
X-Received: by 2002:a05:600c:4452:b0:405:1ba2:4fcb with SMTP id v18-20020a05600c445200b004051ba24fcbmr17479669wmn.16.1698998699382;
        Fri, 03 Nov 2023 01:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXjwfTlForiM0e7Gfu81AsDakzIXUggSQoKB86qdXt49dyHB+qYnn5A8NgeTNVESwg3RI+fQ==
X-Received: by 2002:a05:600c:4452:b0:405:1ba2:4fcb with SMTP id v18-20020a05600c445200b004051ba24fcbmr17479651wmn.16.1698998698970;
        Fri, 03 Nov 2023 01:04:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c459000b003fefaf299b6sm1600329wmo.38.2023.11.03.01.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 01:04:58 -0700 (PDT)
Date:   Fri, 3 Nov 2023 04:04:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, xieyongji@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
Message-ID: <20231103040224-mutt-send-email-mst@kernel.org>
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
 <20231020155819.24000-5-maxime.coquelin@redhat.com>
 <c8f189e6-c79b-429a-ab36-2193bb68e3e9@schaufler-ca.com>
 <923f87a1-1871-479e-832e-db67b5ae87fd@redhat.com>
 <64626db9-e37a-4c65-a455-fc3985382216@schaufler-ca.com>
 <7524dee3-7c48-4864-8182-1b166b0f6faa@redhat.com>
 <b307ec62-7cfd-4a58-88ef-ea549c64e75e@schaufler-ca.com>
 <76572500-5f90-46fe-9bf2-b090bf1b616b@redhat.com>
 <20231102145932-mutt-send-email-mst@kernel.org>
 <598eb8df-0f5f-4f21-8c34-f54ecbbcaca2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <598eb8df-0f5f-4f21-8c34-f54ecbbcaca2@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 08:55:19AM +0100, Maxime Coquelin wrote:
> 
> 
> On 11/2/23 19:59, Michael S. Tsirkin wrote:
> > On Thu, Nov 02, 2023 at 06:56:59PM +0100, Maxime Coquelin wrote:
> > > 
> > > 
> > > On 10/24/23 17:30, Casey Schaufler wrote:
> > > > On 10/24/2023 2:49 AM, Maxime Coquelin wrote:
> > > > > 
> > > > > 
> > > > > On 10/23/23 17:13, Casey Schaufler wrote:
> > > > > > On 10/23/2023 12:28 AM, Maxime Coquelin wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 10/21/23 00:20, Casey Schaufler wrote:
> > > > > > > > On 10/20/2023 8:58 AM, Maxime Coquelin wrote:
> > > > > > > > > This patch introduces LSM hooks for devices creation,
> > > > > > > > > destruction and opening operations, checking the
> > > > > > > > > application is allowed to perform these operations for
> > > > > > > > > the Virtio device type.
> > > > > > > > 
> > > > > > > > Why do you think that there needs to be a special LSM check for virtio
> > > > > > > > devices? What can't existing device attributes be used?
> > > > > > > 
> > > > > > > Michael asked for a way for SELinux to allow/prevent the creation of
> > > > > > > some types of devices [0].
> > > > > > > 
> > > > > > > A device is created using ioctl() on VDUSE control chardev. Its type is
> > > > > > > specified via a field in the structure passed in argument.
> > > > > > > 
> > > > > > > I didn't see other way than adding dedicated LSM hooks to achieve this,
> > > > > > > but it is possible that their is a better way to do it?
> > > > > > 
> > > > > > At the very least the hook should be made more general, and I'd have to
> > > > > > see a proposal before commenting on that. security_dev_destroy(dev)
> > > > > > might
> > > > > > be a better approach. If there's reason to control destruction of vduse
> > > > > > devices it's reasonable to assume that there are other devices with the
> > > > > > same or similar properties.
> > > > > 
> > > > > VDUSE is different from other devices as the device is actually
> > > > > implemented by the user-space application, so this is very specific in
> > > > > my opinion.
> > > > 
> > > > This is hardly unique. If you're implementing the device
> > > > in user-space you may well be able to implement the desired
> > > > controls there.
> > > > 
> > > > > 
> > > > > > 
> > > > > > Since SELinux is your target use case, can you explain why you can't
> > > > > > create SELinux policy to enforce the restrictions you're after? I
> > > > > > believe
> > > > > > (but can be proven wrong, of course) that SELinux has mechanism for
> > > > > > dealing
> > > > > > with controls on ioctls.
> > > > > > 
> > > > > 
> > > > > I am not aware of such mechanism to deal with ioctl(), if you have a
> > > > > pointer that would be welcome.
> > > > 
> > > > security/selinux/hooks.c
> > > 
> > > We might be able to extend selinux_file_ioctl(), but that will only
> > > covers the ioctl for the control file, this patch also adds hook for the
> > > device file opening that would need dedicated hook as the device type
> > > information is stored in the device's private data.
> > > 
> > > Michael, before going further, I would be interested in your feedback.
> > > Was this patch what you had in mind when requesting for a way to
> > > allow/deny devices types for a given application?
> > > 
> > > Regards,
> > > Maxime
> > 
> > 
> > Yes, this is more or less what I had in mind.
> 
> Great.
> 
> Do you think we need to cover both ioctl() on the control file and
> open() on the device file, or only ioctl() is enough?
> 
> If the former, we will need VDUSE-specific hooks. I may be able to
> improve my patch to have a single hook instead of 3 by passing the type
> of operation as an extra argument (create/destroy/open).
> 
> If the latter, we may be able to extend the generic ioctl hook.
> 
> Personally, I think it would make sense to also ensure a given
> application can only open existing VDUSE devices it supports. For
> example, openvswitch should only be allowed to open networking VDUSE
> devices.
> 
> Thanks,
> Maxime

I agree here. I think an open hook is important.
Make sure to document the need in the cover letter
and commit log.

> > 
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Maxime
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Maxime
> > > > > > > 
> > > > > > > [0]:
> > > > > > > https://lore.kernel.org/all/20230829130430-mutt-send-email-mst@kernel.org/
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > 
> > > > 
> > 

