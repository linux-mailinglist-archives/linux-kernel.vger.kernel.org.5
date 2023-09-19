Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7707A5BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjISHzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjISHzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D4810F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695110094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xq2PUpZjcLYmB0sc19KGgnU6q5ctsCTIhTwce+KUPmU=;
        b=Ce0z8gGszWnl6D/Oqz/K5mqKT8Fcxi3yjdNaEa8zAq4FzzNOgjdAZHoad/cNdrTRzN1JLY
        +GE67bvXAiXCsmfd3eHPIHq/XMSdZYkEGiIiOj2QasWiD68m12NqVR7UP2FjYoogabfa+w
        9fJ1dcIGDWxTVeudyH49XI4HWtGRFl0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-WqD8D1n5NUuPHAGDEW7ELA-1; Tue, 19 Sep 2023 03:54:52 -0400
X-MC-Unique: WqD8D1n5NUuPHAGDEW7ELA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c001029f99so28145081fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695110091; x=1695714891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq2PUpZjcLYmB0sc19KGgnU6q5ctsCTIhTwce+KUPmU=;
        b=K1Y201ka4Jo4BFYEyEhdeRrM+TcpqZDEhTqTLJMNM+KulHfkG62veJr4qZye6hyB5I
         twa64YQ+uGiwq3tU4xOfHeMICK5JdNrZBRtuIirb4BbhvX7r7iIqrR/7s8YwuCbrE+s/
         co/g4doRfdzvxq0S2eNRbEpiSzOn8arccdQAlZ0Y9w9UQz/rwXKihGO7mT2TL97XePiv
         jobCIBJfpDRrF9+3ry9sEodQy7z5xdqRJNoOimjlnN/14zsu3AvHa74nIQU8vHYnruUz
         zsyFBHxBVu8hnLhe46oHwW2Dq16/iSeCcGAVs3zRtdx3Id/QsPUo4YYLZThrFIFhLAX7
         5G5Q==
X-Gm-Message-State: AOJu0Yyn8i5Od0oZEOJH6ylnQgmVAQ5K4YiyZjAfJarnVQct2jQ4xP72
        mTj8bZpKaH9AN4A5oVVSbxBuAmcinzkrUHQuFXGz6PRgmxBUCGEGxg0ZrvPLF8v3cYGul1HdAgK
        iNkj4khBxlKxyKwdf0WIvwi5/
X-Received: by 2002:a05:6512:988:b0:500:7e64:cff1 with SMTP id w8-20020a056512098800b005007e64cff1mr7920457lft.14.1695110091567;
        Tue, 19 Sep 2023 00:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuCMWkGTykvVJzGOBWF+ltNRkIaGMXVMrzHnBowZKeRdkWnM1pfr62hc7g2qB3p0oGcC763w==
X-Received: by 2002:a05:6512:988:b0:500:7e64:cff1 with SMTP id w8-20020a056512098800b005007e64cff1mr7920452lft.14.1695110091255;
        Tue, 19 Sep 2023 00:54:51 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.147.15])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c068400b004042dbb8925sm14294571wmn.38.2023.09.19.00.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:54:50 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:54:47 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
 <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 07:56:00PM +0300, Arseniy Krasnov wrote:
>Hi Stefano,
>
>thanks for review! So when this patchset will be merged to net-next,
>I'll start sending next part of MSG_ZEROCOPY patchset, e.g. AF_VSOCK +
>Documentation/ patches.

Ack, if it is not a very big series, maybe better to include also the
tests so we can run them before merge the feature.

WDYT?

Stefano

