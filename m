Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D3785554
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjHWKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjHWKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:25:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB7193;
        Wed, 23 Aug 2023 03:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB458619FD;
        Wed, 23 Aug 2023 10:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8125AC433C7;
        Wed, 23 Aug 2023 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692786344;
        bh=1SoNFlSDBESEpcUsmvCkcrZqM4mjft2HogS2NbeyGmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+vlYrSdAnPcxsYLLO0ChKFjh+9XZ9zyLgRhKIgkovbbZIZeZ7KMiIpxNmZSyQsib
         XUqttnDDlRKi8yHkzUyoVLIAFjZE9HQ5iBqaYvdUxO7HHNVceekz6YVg0Z/+PIoVXk
         2qGQRJCr5xBydAuNg9TMlrZGkrvrkOt1txoiQ3ag=
Date:   Wed, 23 Aug 2023 12:25:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Babis Chalios <bchalios@amazon.es>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, graf@amazon.de,
        xmarcalx@amazon.co.uk, aams@amazon.de, dwmw@amazon.co.uk
Subject: Re: [RFC PATCH 1/2] random: emit reseed notifications for PRNGs
Message-ID: <2023082317-bauble-appeasing-90c0@gregkh>
References: <20230823090107.65749-1-bchalios@amazon.es>
 <20230823090107.65749-2-bchalios@amazon.es>
 <2023082322-semester-heave-e5bc@gregkh>
 <ff6aa77e-4e5c-488e-bd45-319fc09720c3@amazon.es>
 <2023082340-daybreak-lagged-f157@gregkh>
 <89ce1064-e4a3-461f-8a78-88e72e5b6419@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ce1064-e4a3-461f-8a78-88e72e5b6419@amazon.es>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:08:35PM +0200, Babis Chalios wrote:
> 
> 
> On 23/8/23 12:06, Greg KH wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Wed, Aug 23, 2023 at 11:27:11AM +0200, Babis Chalios wrote:
> > > Hi Greg,
> > > 
> > > On 23/8/23 11:08, Greg KH wrote:
> > > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > > > 
> > > > 
> > > > 
> > > > On Wed, Aug 23, 2023 at 11:01:05AM +0200, Babis Chalios wrote:
> > > > > Sometimes, PRNGs need to reseed. For example, on a regular timer
> > > > > interval, to ensure nothing consumes a random value for longer than e.g.
> > > > > 5 minutes, or when VMs get cloned, to ensure seeds don't leak in to
> > > > > clones.
> > > > > 
> > > > > The notification happens through a 32bit epoch value that changes every
> > > > > time cached entropy is no longer valid, hence PRNGs need to reseed. User
> > > > > space applications can get hold of a pointer to this value through
> > > > > /dev/(u)random. We introduce a new ioctl() that returns an anonymous
> > > > > file descriptor. From this file descriptor we can mmap() a single page
> > > > > which includes the epoch at offset 0.
> > > > > 
> > > > > random.c maintains the epoch value in a global shared page. It exposes
> > > > > a registration API for kernel subsystems that are able to notify when
> > > > > reseeding is needed. Notifiers register with random.c and receive a
> > > > > unique 8bit ID and a pointer to the epoch. When they need to report a
> > > > > reseeding event they write a new epoch value which includes the
> > > > > notifier ID in the first 8 bits and an increasing counter value in the
> > > > > remaining 24 bits:
> > > > > 
> > > > >                 RNG epoch
> > > > > *-------------*---------------------*
> > > > > | notifier id | epoch counter value |
> > > > > *-------------*---------------------*
> > > > >        8 bits           24 bits
> > > > Why not just use 32/32 for a full 64bit value, or better yet, 2
> > > > different variables?  Why is 32bits and packing things together here
> > > > somehow simpler?
> > > We made it 32 bits so that we can read/write it atomically in all 32bit
> > > architectures.
> > > Do you think that's not a problem?
> > What 32bit platforms care about this type of interface at all?
> 
> I think, any 32bit platform that gets random bytes from the kernel.

You are making a new api, for some new functionality, for what I thought
was virtual machines (hence the virtio driver), none of which work in a
32bit system.

I thought this was an ioctl for userspace, which can handle 64bits at
once (or 2 32bit numbers).

For internal kernel stuff, a lock should be fine, or better yet, a 64bit
atomic value read (horrible on 32bit platforms, I know...)

Just asking, it feels odd to pack bits in these days for when 90% of the
cpus really don't need it.

greg k-h
