Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2F7D7CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJZGna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZGn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE56210E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698302560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YcSdpoUqOf2Z9R33aI1lokYDTHT4EyidLQqYg+ty5Po=;
        b=GSGeO/KQ7+WKEHE3DC28BnvCE9azbFHoHyNnYCIamCgyhK+7wJgVw3vIYOyqj55TEwvQL5
        dm+bdO4jBuQiUt8lNQYwtze3QydGt7oy56aYafWjGevmnnpvAx5zervTUbNKkfUaTG4AwC
        plXjI7BjPNc9AyeWgbX7fjUpTDTjykA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-gfbQmlJJMxWbMvIhF9jkkQ-1; Thu, 26 Oct 2023 02:42:36 -0400
X-MC-Unique: gfbQmlJJMxWbMvIhF9jkkQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32da215295fso279655f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698302555; x=1698907355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcSdpoUqOf2Z9R33aI1lokYDTHT4EyidLQqYg+ty5Po=;
        b=hyvtebSl+J2V+NDX+l+cYfmrQBQmwOdXq292pXwiwm3BFd9Pi50uojI6/aDafhkLyS
         2z8fWfKMdIy2OMN8F0VYWnMZPge/V5z6hfgWpbRU07OrzRJt/D2VjrjPMj3UwtnAc7ud
         K+jkRb5vzvzVKK2vn5cZ+4Agf0jaZ1aOdvFYYqMEoV9b3xPz2dOeOWc4mHZ31Vwc9Sbi
         uHrb914wbmm7pQi5HLuGSQC/BwhvTPdve6qc/Ywvsx45uVnAj6A8G6+qNM1nEfReu5qQ
         RxrwfTHB1I/o+jA99E+R/h7g4tbxKnLy/pfYaEnOoNd3NzlkJG1aW4kxw0xoYHrytDju
         WQow==
X-Gm-Message-State: AOJu0Yx5iQ3n22EXpeT7X5xt8SExjOHDvZrzJKK7TiRL4Pc1W7KzVIiO
        Hvi/5jQjN7CfJnHkgcmVNUHhJ8Aqcjlfoh/yKCM36/KjKgB7svtFuHcMBh3DU5XWbs1YjDbhWg1
        DRApPGkXKnCCVzTz8zAAlDeCN
X-Received: by 2002:adf:f346:0:b0:32d:b55c:41fa with SMTP id e6-20020adff346000000b0032db55c41famr11780965wrp.28.1698302555147;
        Wed, 25 Oct 2023 23:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyERIAjDqKu0DYcUvMGZ5OQyQV1lKAaWBiouUmORp6s90/5p5CWf/xBYBrtM78ZcOrPN+XpQ==
X-Received: by 2002:adf:f346:0:b0:32d:b55c:41fa with SMTP id e6-20020adff346000000b0032db55c41famr11780951wrp.28.1698302554847;
        Wed, 25 Oct 2023 23:42:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3c98:7fa5:a31:81ed:a5e2])
        by smtp.gmail.com with ESMTPSA id e16-20020adfef10000000b0032d8354fb43sm13637693wro.76.2023.10.25.23.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 23:42:34 -0700 (PDT)
Date:   Thu, 26 Oct 2023 02:42:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
Message-ID: <20231026024147-mutt-send-email-mst@kernel.org>
References: <20230923170540.1447301-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 01:05:33AM +0800, Cindy Lu wrote:
> Hi All
> Really apologize for the delay, this is the draft RFC for
> iommufd support for vdpa, This code provides the basic function 
> for iommufd support 
> 
> The code was tested and passed in device vdpa_sim_net
> The qemu code is
> https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
> 
> ToDo
> 1. this code is out of date and needs to clean and rebase on the latest code 
> 2. this code has some workaround, I Skip the check for
> iommu_group and CACHE_COHERENCY, also some misc issues like need to add
> mutex for iommfd operations 
> 3. only test in emulated device, other modes not tested yet
> 
> After addressed these problems I will send out a new version for RFC. I will
> provide the code in 3 weeks

What's the status here?

-- 
MST

