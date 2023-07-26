Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3FE763F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjGZTaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGZT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190692D5B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690399743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwkepaC05QLl5gztwV48WAfFUdJ93Ti/DuPyfYVfFp8=;
        b=XwrU2YLYnHbCMZ6NJWpLROK+pvkm6m49kwsDarw8mXGc7mSEdNcW28bnizm36Ca0WrOWT/
        8/r/1L7BpEs5sGAhvBMy+iRjS0e2K84gg21xfw1g5Gf1cUvba4VwIemaygFVI29kbSdp5w
        q7RPoR44zs95AvCw5jRDieHT4inxjBw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-r2vllq_-PO-mCRYr0_3SAw-1; Wed, 26 Jul 2023 15:29:02 -0400
X-MC-Unique: r2vllq_-PO-mCRYr0_3SAw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-997d069a914so3327666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399725; x=1691004525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwkepaC05QLl5gztwV48WAfFUdJ93Ti/DuPyfYVfFp8=;
        b=W5NVblB01VHaHxhUbQHYwn1Bzhd0fJZeHOBXCw3SMDB4agoT3b5tFcOzaMpNWoEUa2
         +Nj9zIvB2UU3Azcrkv1eYCk8XSHV5T2PP8GvU7k17ssdUqf6kgKFQth1VimJvouZ5EZu
         boXc6u0mQE+n6k2SaRgHEhfG3qdaq3q3bngQF+OfOHE/ATK9yJmVTF4RKwszLmJVyr1j
         6mAMbZdEwyACXy8A3xqNY+ird9SDbDPXGM2r/I+EzrHaJ2uPeIUxFWn1kKOdiMKMUXsm
         zMC9vxFlyfiJ9iNhRi5S1FLzTrYQCjdyJN+LFK7nvQg5G+yeA4RoyomSizt3YEMhO0jM
         pWQA==
X-Gm-Message-State: ABy/qLab02SH43IY38KQev9UPQtEJsm8ipJkLnfa+LQ+aqPD6dRP9QZz
        CzLqi4UNZ0tnhBSP/z7pN9//utziLUWM7NUwtwcK9r9+YOBmbEUUwLb89nZt5HCNMUr3QxIFJg9
        Wf4OfgB9e2wUMvHuwAOqNdJC/
X-Received: by 2002:a17:906:1ba2:b0:991:e7c3:5712 with SMTP id r2-20020a1709061ba200b00991e7c35712mr98549ejg.30.1690399725408;
        Wed, 26 Jul 2023 12:28:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhQ3WDKlew1+1e3F7M/hEhcV3TrwVWza1XW/STKFBc6D4wdOZOdGNePdu6A08NQAkUqJEdpA==
X-Received: by 2002:a17:906:1ba2:b0:991:e7c3:5712 with SMTP id r2-20020a1709061ba200b00991e7c35712mr98541ejg.30.1690399725074;
        Wed, 26 Jul 2023 12:28:45 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709064a0800b0099bd4e3b4b3sm155891eju.199.2023.07.26.12.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:28:42 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:28:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>,
        "linma@zju.edu.cn" <linma@zju.edu.cn>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Message-ID: <20230726152820-mutt-send-email-mst@kernel.org>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
 <20230726143640-mutt-send-email-mst@kernel.org>
 <8a97e0d439d74373605b00dcaef91108ced9e5ee.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a97e0d439d74373605b00dcaef91108ced9e5ee.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:56:24PM +0000, Dragos Tatulea wrote:
> On Wed, 2023-07-26 at 14:36 -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 26, 2023 at 09:30:48PM +0300, Dragos Tatulea wrote:
> > > The original patch from Lin Ma enables the vdpa driver to use validation
> > > netlink ops.
> > > 
> > > The second patch simply disables the validation skip which is no longer
> > > neccesary. Patchset started of from this discussion [0].
> > > 
> > > [0]
> > > https://lore.kernel.org/virtualization/20230726074710-mutt-send-email-mst@kernel.org/T/#t
> > 
> > Cc stable with at least 1/2 ?
> > 
> Sent a v2 with stable in cc. But looks like 1/2 breaks the "fix one thing only"
> rule due to the many Fixes tags I guess...

you can split it up to 3 patches to simplify backports if you like.



> > > Dragos Tatulea (1):
> > >   vdpa: Enable strict validation for netlinks ops
> > > 
> > > Lin Ma (1):
> > >   vdpa: Complement vdpa_nl_policy for nlattr length check
> > > 
> > >  drivers/vdpa/vdpa.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > 
> > > -- 
> > > 2.41.0
> > 
> 

