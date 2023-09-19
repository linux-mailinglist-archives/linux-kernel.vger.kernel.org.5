Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA567A64B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjISNUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjISNUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED9EF3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695129599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htK7pnwIzqRDFi5FwPMaJzCXKtfTe2X9wFdfV0qhhDg=;
        b=dTbZx3yPdrjyksWEVcMmG9mQvP6WFbfKPi1PXwWmBmSuoNINoF228/lEGwmclizgDPlhay
        +fLBB8yPUCn16wHvKZ68o4o6bTt03xWAnZhwrTl0o2pTABfngezzmR9QPvk75QMSpaiJXN
        jsQ3b9KgRoMykULEvIx8uHuZ251fask=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-SlQkCZ66NtSadtJ-57H6Pw-1; Tue, 19 Sep 2023 09:19:57 -0400
X-MC-Unique: SlQkCZ66NtSadtJ-57H6Pw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-320089dad3cso109969f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129596; x=1695734396;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htK7pnwIzqRDFi5FwPMaJzCXKtfTe2X9wFdfV0qhhDg=;
        b=lLYcSA5OWoAMYjaozMof5Rch8OVHvcH4FMXYLGuRtPuug7mG1HiVivPbD1c+mUYfOS
         VmeUo1Xy6gnJRNl/A5vGkDhjxpdCeQXR7nXc/jMDtze+6UO1QY2vEAC7wZQumlvK0JZx
         HWqGEVaadc52valDpUafJbpsrPZ+qFKZkeN0I8dZ8SemUXTQJ0hK/pZ2+jFLXyMePxTU
         imiJKN974bC8Fj89/l/b6dqySGIBkIGijdRhhVeL17N/bwgKdiDgbGt+UQSCX9hYQ2rF
         yzD40I9cOxpKYVSU+sUoijk/TfuoW+hncfB9+1wEMAG5qTT2ckG+q65nBbrGBtKNxUGb
         3QcA==
X-Gm-Message-State: AOJu0YxsWqGc7R6meNhTXFYP3Db2QF8SBGi5QiE5zWBRxc4XhfXJZcgM
        LTFVTodF4ftKIZkpZNdTAVXWh67DzeEXHrvvo6O8GZF7wDfcGoIBO+YOqgjgArdLTfZc8OPxBJh
        +SqN98pybiZ25efmCAXn4/eoE
X-Received: by 2002:adf:ecc7:0:b0:31f:899b:a47 with SMTP id s7-20020adfecc7000000b0031f899b0a47mr10072503wro.4.1695129596646;
        Tue, 19 Sep 2023 06:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvl5GMANKuJZvPgoz3bArRsym+FAKYbCuhPA1oJy7XAET85TTZwn7Qk9G/FVTxfAXX1wyEcg==
X-Received: by 2002:adf:ecc7:0:b0:31f:899b:a47 with SMTP id s7-20020adfecc7000000b0031f899b0a47mr10072490wro.4.1695129596314;
        Tue, 19 Sep 2023 06:19:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b0099bd453357esm7754752ejb.41.2023.09.19.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:19:55 -0700 (PDT)
Message-ID: <a5b25ee07245125fac4bbdc3b3604758251907d2.camel@redhat.com>
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
From:   Paolo Abeni <pabeni@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Date:   Tue, 19 Sep 2023 15:19:54 +0200
In-Reply-To: <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
         <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
         <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-19 at 09:54 +0200, Stefano Garzarella wrote:
> On Mon, Sep 18, 2023 at 07:56:00PM +0300, Arseniy Krasnov wrote:
> > Hi Stefano,
> >=20
> > thanks for review! So when this patchset will be merged to net-next,
> > I'll start sending next part of MSG_ZEROCOPY patchset, e.g. AF_VSOCK +
> > Documentation/ patches.
>=20
> Ack, if it is not a very big series, maybe better to include also the
> tests so we can run them before merge the feature.

I understand that at least 2 follow-up series are waiting for this, one
of them targeting net-next and the bigger one targeting the virtio
tree. Am I correct?

DaveM suggests this should go via the virtio tree, too. Any different
opinion?

Thanks!

Paolo

