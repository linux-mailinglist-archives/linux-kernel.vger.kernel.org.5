Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA947AEDC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjIZNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjIZNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB07AFC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695733830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53RN2iEKcF7cesjBINs3uKbZmoYEjMUrrV2QK4YxQVs=;
        b=NGRj70LkD0MMjgiHDYGjLXrP3Ob3DD4gxhD48/ghqOtA+Ddhkvx+LdVeMirh9jM1LCZQnA
        fiTcYaoYz1UhuRDLTRZERMKkXWGG4lTIgTjEtGlMAhHbuLU5XTOtROGyeR7P7zEmNEdhuM
        yNVoObEm3E9cmBkq1/p0X5zPqPuSjfg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-69TMxRJvOUCwdkl6V_hzZQ-1; Tue, 26 Sep 2023 09:10:28 -0400
X-MC-Unique: 69TMxRJvOUCwdkl6V_hzZQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a647551b7dso481747966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695733827; x=1696338627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53RN2iEKcF7cesjBINs3uKbZmoYEjMUrrV2QK4YxQVs=;
        b=D13q96UC36Z7B3cahLXbbZYXzvmtsDQ45gNxBTH4xPjRqD+LN+GTko1ZCFg7cMd+co
         upsLILfehIb5c0f/1YL/u/J+PUcZwuvuBEd7O93W90I6O4nLM4HrAJjhsUwWv0tjcDo8
         ZGt0htOj625/bWT4u3QvUvMJe7t0rVYrRNdPnfHA5ltJuRXC/Nj6ArZ2IwJXzQBVPy9n
         ddJNcY6gFmHaSMQl8/4uSlCI1e9wY7UFGLJmB4zUL0o8vx61R8MKhz4I8T5g8ujIluo8
         D+GhFW5Ktv9vy6j5H06gkvHBOLxiaGlCR8WvJhj3VV8uA5dQ8Tn6XaS/FOIeFPyMW0nR
         O3zQ==
X-Gm-Message-State: AOJu0YxCclz52eyTvSydm5HQBh4ticfqnmmOKTaiPuAqdrFBgQoK7f3A
        5Mbh7eM8DyiajtXigOQ8RaPBxluRuTF3y5LziyJKYFPzbXiLH2S+u/jVDGTHqHclUerA+k7/ZGG
        0nUFkI9mgBfzUxd11q/QfA2ZX
X-Received: by 2002:a17:907:3e0b:b0:9ae:5a56:be32 with SMTP id hp11-20020a1709073e0b00b009ae5a56be32mr4084911ejc.38.1695733827497;
        Tue, 26 Sep 2023 06:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhr8aocGYblGQIkanfvgdcYkJGgnxjzR7Ndhh5heLB5k61gMBi2Cpl5HUKWX7e6D9TEIPTRA==
X-Received: by 2002:a17:907:3e0b:b0:9ae:5a56:be32 with SMTP id hp11-20020a1709073e0b00b009ae5a56be32mr4084743ejc.38.1695733825833;
        Tue, 26 Sep 2023 06:10:25 -0700 (PDT)
Received: from sgarzare-redhat ([46.6.146.182])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090634ca00b00997e00e78e6sm7780777ejb.112.2023.09.26.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 06:10:25 -0700 (PDT)
Date:   Tue, 26 Sep 2023 15:10:21 +0200
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
Subject: Re: [PATCH net-next v1 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <zurqqucjbdnyxub6u7ya5gzt2nxgrgp4ggvz76smljqzfi6qzb@lr6ojra35bab>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On Fri, Sep 22, 2023 at 08:24:16AM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset contains second and third parts of another big patchset
>for MSG_ZEROCOPY flag support:
>https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>
>During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>suggested to split it for three parts to simplify review and merging:
>
>1) virtio and vhost updates (for fragged skbs) (merged to net-next, see
>   link below)
>2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>   tx completions) and update for Documentation/. <-- this patchset
>3) Updates for tests and utils. <-- this patchset
>
>Part 1) was merged:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7

Thanks for the series.
I did a quick review highlighting some things that need to be changed.

Overall, the series seems to be in good shape. The tests went well.

In the next few days I'll see if I can get a better look at the larger 
patches like the tests, or I'll check in the next version.

Thanks,
Stefano

