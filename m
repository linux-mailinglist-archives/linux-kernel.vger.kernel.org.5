Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4B57B080A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjI0PVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjI0PVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73CC121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695828014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/EIbBjpy9O83n9qhTihg7QeV6q2TpAQGQwYAPKsUVIA=;
        b=K01LKSaed/MPl3hSmA3N+Lf9sYM61H5LPVjm1mNY3xkbyV6+Q6fQzyuUKDSh+86RQFkFC5
        V5G37yO+9cXOeTE+u+6D9qksfH0mh9M0CN+7uJ3w4gBpBynwqJX8au8LRB1vVuQZ86Vdup
        0YR8MK31Vw/xyyFEJAmM9nMclGFdOx8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-VRfhcXSfOWONNqhEXd4YJA-1; Wed, 27 Sep 2023 11:20:12 -0400
X-MC-Unique: VRfhcXSfOWONNqhEXd4YJA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-320004980a2so9290598f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695828011; x=1696432811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EIbBjpy9O83n9qhTihg7QeV6q2TpAQGQwYAPKsUVIA=;
        b=GPffq/OHj/jXUH9rWKG6OsdzwSgdW+c5o1Ab8Z340PiDwLOsJlcdoqXAqYsSfbvqRa
         xU1KRu9xrCN4Cfq2qVIt4p7Fx9hZ0G+4hSsUFumENs4dzPmXXO9BQjLesQca1r+/Rqbb
         MtxLqXb7M56hGHPv4BIgyrdmO39Sds06sV+kpufLdWJgEAK/MZAc3RzJvlvGfKYx//KB
         8ZgKk9ZWyw0ZjEHpz7lCQcLcwRLUhcO7eiqlKsEn9EO47qBCI9XVoOn+JIV3M85Txfg9
         g1P3f5Y6bN8ZB5MxpzC1yEOFxvGkmn8+p/KybQY6/2Yi6e9TFHvYmPN+WJBYi0+jpkfY
         SNxA==
X-Gm-Message-State: AOJu0Yz6pdZOJp2wildxtr3jZsXzf5MLCOOamDSO6+caYerKnsSoDL/D
        k/fXirYaEHpxzaxKEXwFqiZKz2mcU1H3e1hxy6n55nHpDppkjqVO5g2q9O/kazflIwbf/gxJDlF
        IpxStwB8RJTQkKUTQabw8LdbR
X-Received: by 2002:a5d:4cc7:0:b0:314:a3f:9c08 with SMTP id c7-20020a5d4cc7000000b003140a3f9c08mr1876007wrt.39.1695828011761;
        Wed, 27 Sep 2023 08:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdjsQhdmBlcldN4VQo0/wB1Ma3pLJGSeiqWpRsH5/5aS/zWnrBptxpvSLI02eGQaomR+j8gQ==
X-Received: by 2002:a5d:4cc7:0:b0:314:a3f:9c08 with SMTP id c7-20020a5d4cc7000000b003140a3f9c08mr1875993wrt.39.1695828011418;
        Wed, 27 Sep 2023 08:20:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:b9f6:556e:c001:fe18:7e0a])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d6511000000b0031fd849e797sm17324370wru.105.2023.09.27.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:20:10 -0700 (PDT)
Date:   Wed, 27 Sep 2023 11:20:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     liming.wu@jaguarmicro.com
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, 398776277@qq.com
Subject: Re: [PATCH 2/2] tools/virtio: Add hints when module is not installed
Message-ID: <20230927111904-mutt-send-email-mst@kernel.org>
References: <20230926050021.717-1-liming.wu@jaguarmicro.com>
 <20230926050021.717-2-liming.wu@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926050021.717-2-liming.wu@jaguarmicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 01:00:20PM +0800, liming.wu@jaguarmicro.com wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
> 
> Need to insmod vhost_test.ko before run virtio_test.
> Give some hints to users.
> 
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  tools/virtio/virtio_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 028f54e6854a..ce2c4d93d735 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -135,6 +135,10 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>  	dev->buf = malloc(dev->buf_size);
>  	assert(dev->buf);
>  	dev->control = open("/dev/vhost-test", O_RDWR);
> +
> +	if (dev->control < 0)
> +		fprintf(stderr, "Install vhost_test module" \
> +		"(./vhost_test/vhost_test.ko) firstly\n");

Thanks!

things to improve:

firstly -> first
add space before (
End sentence with a dot
align "" on the two lines

>  	assert(dev->control >= 0);
>  	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
>  	assert(r >= 0);
> -- 
> 2.34.1

