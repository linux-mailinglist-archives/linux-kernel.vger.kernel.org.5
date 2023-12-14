Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BB9812C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443475AbjLNJ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443458AbjLNJ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAD8E0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702547774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/tkL8YLXBdtuh1lhYs0W2zJGNUrEl73DXiA9GWiR3Xc=;
        b=Yagx8o6OikMINwIq3qxQBSoNrcZlY+uGSN99PVI/cWREyimdBK/GIaCh5YS+dm08g81MJn
        +qmzCNDedgP/9k2brURSCi2M79e0iW5CjYud5HfB5DRLt3RHawv6MPSNUrZ6A8eqJom0ug
        SQOfEtJdb55+qrh1uYtKx9i72v8ARTQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Z0T6gOHrOL2LYdmrOitu-A-1; Thu, 14 Dec 2023 04:56:12 -0500
X-MC-Unique: Z0T6gOHrOL2LYdmrOitu-A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33641bbc49dso869330f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547771; x=1703152571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tkL8YLXBdtuh1lhYs0W2zJGNUrEl73DXiA9GWiR3Xc=;
        b=r/ljEFIVpi8USQpgi2v8zlVT6Vyi/iCFmYqnGBjqBp3BS/ppGmUtNnZ3WzEaj6/bnb
         ah/UviP1CXcGGZIwqweso6NkbADG3t9GvUIbF4efPQwbYOfH+PEuuwEFKDmGFb288s6L
         Ua3AVqHFxd3O6vRv5JOYGgC87J+l96nX/mBzmLq6GMX10G1GAdJNWzhvHg/Sz9nS8WKE
         uhHAyN6QxtBRROQFI3G5CAA2koHh+Qj6IDzI10XrYbkWXBIO2/mwNjY3bnQhgknDzlHU
         q8rU9+MW0oPSDLjhALS+1e7tmInliESmJQUKuh2cGrOk9GrN6o68wKzgMR5qAumlkz4l
         UjUQ==
X-Gm-Message-State: AOJu0YxXlngykdgdy2vDRQ56sPZzAGNAEHEae1D/D4s8+Gze3U13MLFG
        r1wf9pSyEmAB4mlMURn6e8Tn1Ds8tubUjhAkNtX9DLqSMGw5SNzsDMY9TLXwaB6qGtRnWtrinBu
        pC4ImghESod4jarajX4gYCeNJ
X-Received: by 2002:a5d:614a:0:b0:336:9f9:6df with SMTP id y10-20020a5d614a000000b0033609f906dfmr5151065wrt.5.1702547771645;
        Thu, 14 Dec 2023 01:56:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiakjz1ILbcnOG+FrF8iuBB/YhiQdiiOV88jj7k12GPoMjsxf1aAqx1tuBwIkVtWxpFGD4+Q==
X-Received: by 2002:a5d:614a:0:b0:336:9f9:6df with SMTP id y10-20020a5d614a000000b0033609f906dfmr5151053wrt.5.1702547771279;
        Thu, 14 Dec 2023 01:56:11 -0800 (PST)
Received: from sgarzare-redhat ([5.11.101.217])
        by smtp.gmail.com with ESMTPSA id c15-20020adfe74f000000b0033335644478sm15617053wrn.114.2023.12.14.01.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:56:10 -0800 (PST)
Date:   Thu, 14 Dec 2023 10:56:04 +0100
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
Subject: Re: [PATCH net-next v9 0/4] send credit update during setting
 SO_RCVLOWAT
Message-ID: <4qaygyv6sw4qip6gnu2dirw7d7r3f3cmmh3qctnznda3rslzug@r2cyub6rjw6h>
References: <20231214091947.395892-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231214091947.395892-1-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:19:43PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>                               DESCRIPTION
>
>This patchset fixes old problem with hungup of both rx/tx sides and adds
>test for it. This happens due to non-default SO_RCVLOWAT value and
>deferred credit update in virtio/vsock. Link to previous old patchset:
>https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
>
>Here is what happens step by step:
>
>                                  TEST
>
>                            INITIAL CONDITIONS
>
>1) Vsock buffer size is 128KB.
>2) Maximum packet size is also 64KB as defined in header (yes it is
>   hardcoded, just to remind about that value).
>3) SO_RCVLOWAT is default, e.g. 1 byte.
>
>
>                                 STEPS
>
>            SENDER                              RECEIVER
>1) sends 128KB + 1 byte in a
>   single buffer. 128KB will
>   be sent, but for 1 byte
>   sender will wait for free
>   space at peer. Sender goes
>   to sleep.
>
>
>2)                                     reads 64KB, credit update not sent
>3)                                     sets SO_RCVLOWAT to 64KB + 1
>4)                                     poll() -> wait forever, there is
>                                       only 64KB available to read.
>
>So in step 4) receiver also goes to sleep, waiting for enough data or
>connection shutdown message from the sender. Idea to fix it is that rx
>kicks tx side to continue transmission (and may be close connection)
>when rx changes number of bytes to be woken up (e.g. SO_RCVLOWAT) and
>this value is bigger than number of available bytes to read.
>
>I've added small test for this, but not sure as it uses hardcoded value
>for maximum packet length, this value is defined in kernel header and
>used to control deferred credit update. And as this is not available to
>userspace, I can't control test parameters correctly (if one day this
>define will be changed - test may become useless).
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=9bab51bd662be4c3ebb18a28879981d69f3ef15a
>
>Link to v1:
>https://lore.kernel.org/netdev/20231108072004.1045669-1-avkrasnov@salutedevices.com/
>Link to v2:
>https://lore.kernel.org/netdev/20231119204922.2251912-1-avkrasnov@salutedevices.com/
>Link to v3:
>https://lore.kernel.org/netdev/20231122180510.2297075-1-avkrasnov@salutedevices.com/
>Link to v4:
>https://lore.kernel.org/netdev/20231129212519.2938875-1-avkrasnov@salutedevices.com/
>Link to v5:
>https://lore.kernel.org/netdev/20231130130840.253733-1-avkrasnov@salutedevices.com/
>Link to v6:
>https://lore.kernel.org/netdev/20231205064806.2851305-1-avkrasnov@salutedevices.com/
>Link to v7:
>https://lore.kernel.org/netdev/20231206211849.2707151-1-avkrasnov@salutedevices.com/
>Link to v8:
>https://lore.kernel.org/netdev/20231211211658.2904268-1-avkrasnov@salutedevices.com/
>
>Changelog:
>v1 -> v2:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * New patch is added as 0001 - it removes return from SO_RCVLOWAT set
>   callback in 'af_vsock.c' when transport callback is set - with that
>   we can set 'sk_rcvlowat' only once in 'af_vsock.c' and in future do
>   not copy-paste it to every transport. It was discussed in v1.
> * See per-patch changelog after ---.
>v2 -> v3:
> * See changelog after --- in 0003 only (0001 and 0002 still same).
>v3 -> v4:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.
>v4 -> v5:
> * Change patchset tag 'RFC' -> 'net-next'.
> * See per-patch changelog after ---.
>v5 -> v6:
> * New patch 0003 which sends credit update during reading bytes from
>   socket.
> * See per-patch changelog after ---.
>v6 -> v7:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.
>v7 -> v8:
> * See per-patch changelog after ---.
>v8 -> v9:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * Add 'Fixes' tag for the current 0002.
> * Reorder patches by moving two fixes first.
>
>Arseniy Krasnov (4):
>  virtio/vsock: fix logic which reduces credit update messages
>  virtio/vsock: send credit update during setting SO_RCVLOWAT
>  vsock: update SO_RCVLOWAT setting callback
>  vsock/test: two tests to check credit update logic

This order will break the bisectability, since now patch 2 will not
build if patch 3 is not applied.

So you need to implement in patch 2 `set_rcvlowat` and in patch 3
updated it to `notify_set_rcvlowat`, otherwise we always need to
backport patch 3 in stable branches, that should be applied before
patch 2.

You have 2 options:
a. move patch 3 before patch 2 without changing the code
b. change patch 2 to use `set_rcvlowat` and updated that code in patch 3

I don't have a strong opinion, but I slightly prefer option a. BTW that
forces us to backport more patches on stable branches, so I'm fine with
option b as well.

That said:
Nacked-by: Stefano Garzarella <sgarzare@redhat.com>

