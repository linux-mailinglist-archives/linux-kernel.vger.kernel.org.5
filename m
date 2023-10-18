Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7907CEBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjJRXP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJRXPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A336113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697670881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RiaZftp2sTY9F+anMpEkbmYxNf1b1ZMPyR9wBMotkjE=;
        b=cA4+hEAtZNmDqk5LYxEvV+BUzACf2OsnW6nTW3xy+Ec61Ov22/C+t2U4AXJI4goUEqu4pq
        MmWAsx5HRgCay0Zkk7s54gKJVBTphP3p2T2uRN2bO+E9h+l95jR7nlVhYg3i/+bKOQv9id
        ZRjRNxlgZ2Hk6mcuxdllmgegYMUZb5k=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-ldraqc9MOzOcQAgHtS0tig-1; Wed, 18 Oct 2023 19:14:29 -0400
X-MC-Unique: ldraqc9MOzOcQAgHtS0tig-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-d9a3942461aso10783315276.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670869; x=1698275669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiaZftp2sTY9F+anMpEkbmYxNf1b1ZMPyR9wBMotkjE=;
        b=ROSxkPPxMFFfJDy9lavQ5cB5ZOzi+mJqEtPWXP8UzVcSwyoa1MMmrDSa6tWSxF77tN
         PtVOtvl7R0DFmVakVZU/1Uj4Mp8rd2TG5Qs+rozH6fqcbPXkZSbo6nq26XJLy2C9PPMo
         2S9hHobxQrm6+J6QTCfoYVzZTTKP5iDUwLd/F6S1axC3vA1T9QYL+Xk50AtSqC9WPsr+
         H4CTMlAb96IEcKpwaV1sGu1cKWPwTd1KASp58LrzKxeJ4IzuPw3DG+D8dO6cg1/RLDS8
         Q+oH40xab3E5EkFtrsIl35jwCzcI3QaG65VHArM6jO8JpcJlXoQhhUC2tuN8QYBIxvX1
         r2xA==
X-Gm-Message-State: AOJu0YwD3SCc4sSDWyU2uTSUPNMAbF3vCsBD4EfKdKuskgntL7TlbdDz
        NSyNSmn2ne/PotKN16eZt+dNFUb24yX5EMyN3UEbhSNBMPRB9PX5MJhtGtbdSc+hRndYXiOTYwF
        JUF7CsxLm772BjR8/YxKARzeY
X-Received: by 2002:a5b:849:0:b0:d9a:c946:bb47 with SMTP id v9-20020a5b0849000000b00d9ac946bb47mr779962ybq.5.1697670869380;
        Wed, 18 Oct 2023 16:14:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Qlh2VPorkSO+9RrzUENXrsGkfk/ZnsdYWF0xLaVuov4AA5j14vG088ZVN9GgcVux/fgJdg==
X-Received: by 2002:a5b:849:0:b0:d9a:c946:bb47 with SMTP id v9-20020a5b0849000000b00d9ac946bb47mr779947ybq.5.1697670869063;
        Wed, 18 Oct 2023 16:14:29 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ef10-20020a0562140a6a00b00656506a1881sm314623qvb.74.2023.10.18.16.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:14:28 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:14:27 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] iommu: Validate that devices match domains
Message-ID: <4syngx7peypqkc6aakw7ybapuoqkww5kv3drujkysvywuj7wzw@6cnaldhvqx3l>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <4e8bda33aac4021b444e40389648deccf61c1f37.1697047261.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e8bda33aac4021b444e40389648deccf61c1f37.1697047261.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:50PM +0100, Robin Murphy wrote:
> Before we can allow drivers to coexist, we need to make sure that one
> driver's domain ops can't misinterpret another driver's dev_iommu_priv
> data. To that end, add a token to the domain so we can remember how it
> was allocated - for now this may as well be the device ops, since they
> still correlate 1:1 with drivers. We can trust ourselves for internal
> default domain attachment, so add checks to cover all the public attach
> interfaces.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v4: Cover iommu_attach_device_pasid() as well, and improve robustness
>     against theoretical attempts to attach a noiommu group.
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

