Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7877A70A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjITCjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITCjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A89CE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 19:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695177526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mltdWUrYuG2mZM3mBsS3pkG+K6kdQVfPyUFr6/Wteqo=;
        b=AOWX7lgUaZspsKmG+QZi0GIZsyMIUxppG+FMOJFs2TJj4hwUQ0QaAApAjWVOaHDI8iQZx7
        eh0PocRlNzoqcCp5gNtjshSx3NWFq/GwM0kRzuQv/ADs+4+kItCtR2eItx62WjNH6AUjlE
        qhbXOTrkabHZ8p5QnQNXQGH+2LXOMWM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-ZZhNlappONGtNttESPd2Kw-1; Tue, 19 Sep 2023 22:38:40 -0400
X-MC-Unique: ZZhNlappONGtNttESPd2Kw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c0165b5c5cso31672131fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 19:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695177519; x=1695782319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mltdWUrYuG2mZM3mBsS3pkG+K6kdQVfPyUFr6/Wteqo=;
        b=BPrrugzH7BtJ/VOLHBsfAG42iDIbTU4+/UY7nYgNNsVaDihb2ieJLofrBlgEae6q0T
         dwHU8/PVbG6WVwvMIPz6FuCMtRxmOcu+VOpcA+OYy8tj84zWEiYnq7JBlJHTehJF15Ml
         W2L++oIfDG4kcH1MjWHIIbcWN3QYsY7rlgA88zp3mXdaNML97HqBLZtBb9BE1nJj28qk
         3OEQCf9AbCwEIvARvXQ1vVnmcTXH250r4vXlICGIADjZvqAiWikmicDshjky88d9A7X9
         3ubP/sVKPcFUzDdytVq9JZ3uwTDCApMtU4jlhf56kbTjQ9BVziFDA+pZnvWTQhxgAIPG
         hdFQ==
X-Gm-Message-State: AOJu0YxrlvfqZPzAsA24kW3ywh/IQUvhjcpZ2Td2zk/huK+pX8WWhLZI
        spR+moC2CT+il7xlrAg19Js/CNJQsDmHK2u3DqVCaq4CN4L35dlqlnEPUjFHmIXPxHm1T2koDZ4
        xYfUhJZ8FGYUDRpBHj+Pm4S8Z
X-Received: by 2002:a2e:a3cd:0:b0:2bc:c557:84a0 with SMTP id w13-20020a2ea3cd000000b002bcc55784a0mr928154lje.30.1695177519197;
        Tue, 19 Sep 2023 19:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwXnlVNVhmJOWz1liAl5cY3Hket0qS/kxuaMrxgmSZwkofhhqlaN8M29TK4O/sX6epr0sArA==
X-Received: by 2002:a2e:a3cd:0:b0:2bc:c557:84a0 with SMTP id w13-20020a2ea3cd000000b002bcc55784a0mr928135lje.30.1695177518840;
        Tue, 19 Sep 2023 19:38:38 -0700 (PDT)
Received: from redhat.com ([2.52.26.122])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906350b00b009a5f1d1564dsm8531069eja.126.2023.09.19.19.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:38:37 -0700 (PDT)
Date:   Tue, 19 Sep 2023 22:38:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <20230919223700-mutt-send-email-mst@kernel.org>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
 <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
 <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
 <a5b25ee07245125fac4bbdc3b3604758251907d2.camel@redhat.com>
 <hq67e2b3ljfjikvbaneczdve3fzg3dl5ziyc7xtujyqesp6dzm@fh5nqkptpb4n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hq67e2b3ljfjikvbaneczdve3fzg3dl5ziyc7xtujyqesp6dzm@fh5nqkptpb4n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 03:35:51PM +0200, Stefano Garzarella wrote:
> On Tue, Sep 19, 2023 at 03:19:54PM +0200, Paolo Abeni wrote:
> > On Tue, 2023-09-19 at 09:54 +0200, Stefano Garzarella wrote:
> > > On Mon, Sep 18, 2023 at 07:56:00PM +0300, Arseniy Krasnov wrote:
> > > > Hi Stefano,
> > > >
> > > > thanks for review! So when this patchset will be merged to net-next,
> > > > I'll start sending next part of MSG_ZEROCOPY patchset, e.g. AF_VSOCK +
> > > > Documentation/ patches.
> > > 
> > > Ack, if it is not a very big series, maybe better to include also the
> > > tests so we can run them before merge the feature.
> > 
> > I understand that at least 2 follow-up series are waiting for this, one
> > of them targeting net-next and the bigger one targeting the virtio
> > tree. Am I correct?
> 
> IIUC the next series will touch only the vsock core
> (net/vmw_vsock/af_vsock.c), tests, and documentation.
> 
> The virtio part should be fully covered by this series.
> 
> @Arseniy feel free to correct me!
> 
> > 
> > DaveM suggests this should go via the virtio tree, too. Any different
> > opinion?
> 
> For this series should be fine, I'm not sure about the next series.
> Merging this with the virtio tree, then it forces us to do it for
> followup as well right?
> 
> In theory followup is more on the core, so better with net-next, but
> it's also true that for now only virtio transports support it, so it
> might be okay to continue with virtio.
> 
> @Michael WDYT?
> 
> Thanks,
> Stefano

I didn't get DaveM's mail - was this off-list?
I think net-next is easier because the follow up belongs in net-next.
But if not I can take it, sure. Let me know.

-- 
MST

