Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F329788D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344106AbjHYQ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjHYQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B49E67
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692982504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+kuzpbbgam9B45lp1NOAHkhMMTQTFbfFGLvI71Il4Q=;
        b=Ep9QNxU1zEafnEg5ZDk0BtIoDJvwewIw572faeqrBrUtR1kEq8I8fQWZ9rx+tm/k0zr/sO
        gsD6cJBrMOPdXCOmwUMo9yRUl63FDx8N1Cz7Nlb5k3lldpfy8utfvbXIGcBiAr8accNhSS
        4hq1qBM8MLJ1+8ekJ5B0X7vHquXqXFE=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-PqJmO5kdPYCJeTU4jUAQBg-1; Fri, 25 Aug 2023 12:55:02 -0400
X-MC-Unique: PqJmO5kdPYCJeTU4jUAQBg-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-44d5dba1d31so472884137.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692982502; x=1693587302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+kuzpbbgam9B45lp1NOAHkhMMTQTFbfFGLvI71Il4Q=;
        b=CHQuH+v0GSeYfbM1htBCk0oT3rm8erJvKVrrmupRyQRLOHbLuZcOWlyv80QIxNFEoD
         RSRNfLdCZgRMNySdhpcVkFDz0MtqRJ8KFw25NoT4J4JQxwExIdq8zXJtXaP0BX8wUNYJ
         VkurkhOIFPnaGnE7eYan/CmfD54NlbFyHzegkhwb1GC2GFo4EZsN3upHQcFvGxW+hjUY
         RvTYNNqyOHkO1xpTfjC7l6lk3BL4ABqr+I9DNOz7ld0z6S/aLiG5qpxXXapIRb+Z9SYF
         faLHhR/ZbR0vcgA5rbtjAneSOo9oLbNqitJ8aJwhNUw6L9+OfQcx6/53v0dygATYvZJ6
         /91w==
X-Gm-Message-State: AOJu0Ywa9FyvEkpsHwrR8GyvdYoGrxA+5ej1ccX6eF57+OwBbBnz+/FK
        xbnTzF1vP9Zxynf4ghx9gQlk1LOz4BXtbZFlhjHev5aquY+ueCqaNKEcUtbGlpCt+bQ8AhEUkLa
        +XdjHapy1t4LLrIMemALXhVMN
X-Received: by 2002:a67:fb88:0:b0:44e:9d4f:1ffb with SMTP id n8-20020a67fb88000000b0044e9d4f1ffbmr4661576vsr.11.1692982502502;
        Fri, 25 Aug 2023 09:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJHUcXGtBB0jsSsUCaYK4Ywqg+0sSZuvf61wthRYX4YE+f077r/a3H5gRwGIIX2XhPhD1/Pg==
X-Received: by 2002:a67:fb88:0:b0:44e:9d4f:1ffb with SMTP id n8-20020a67fb88000000b0044e9d4f1ffbmr4661566vsr.11.1692982502304;
        Fri, 25 Aug 2023 09:55:02 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id n6-20020a0ce486000000b006490a9946b6sm656091qvl.119.2023.08.25.09.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 09:55:01 -0700 (PDT)
Date:   Fri, 25 Aug 2023 09:55:00 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
        john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com
Subject: Re: [PATCH v2 1/2] iommu/iova: Make the rcache depot scale better
Message-ID: <ob2tqg6amvr3ozxdrjtotc6gpfzlyvftncu7jw7zgau6qso6rx@h33gsipsnmuc>
References: <cover.1692641204.git.robin.murphy@arm.com>
 <fe7beab68167c4d86e770eb309985dfd3905bd8b.1692641204.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7beab68167c4d86e770eb309985dfd3905bd8b.1692641204.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 07:22:51PM +0100, Robin Murphy wrote:
> The algorithm in the original paper specifies the storage of full
> magazines in the depot as an unbounded list rather than a fixed-size
> array. It turns out to be pretty straightforward to do this in our
> implementation with no significant loss of efficiency. This allows
> the depot to scale up to the working set sizes of larger systems,
> while also potentially saving some memory on smaller ones too.
> 
> Since this involves touching struct iova_magazine with the requisite
> care, we may as well reinforce the comment with a proper assertion too.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

