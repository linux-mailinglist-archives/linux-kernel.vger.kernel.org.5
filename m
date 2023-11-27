Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ED47FAA32
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjK0T0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjK0T0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:26:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2033FD60
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:26:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B55C433C7;
        Mon, 27 Nov 2023 19:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701113168;
        bh=gZKfaF2aYd71Rx0IiDPFKiGIoAGGkjTyziP8BWTgjZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=As1AsuEkjH5B2Ue0e+KowLmulndf3k2RJyFnwaP3aeTuICzi+ufdiVjJTOCz5k1Ky
         7oVQpKNFb+9HvolH1p/7kyZGJjm8N/t3T1S1owpX6mOgwEVNtwhTGn7pz28c1MTfsU
         Eo90D/nDfK5kwEnGCJfrvJekHl3WqThpmKhQTu95rCwvm5bQJ4FkW4GdByN42lnAiM
         pYXmBbywEtffsnfYDNHNMFZ+HBZ8R30Vj/5EkG3Dah6ZBo0L6MLJZJDQNStSgGwsxx
         llrVsG0EY2hgZX5oN8u8k19paWLCYZhqZ066yszBKkNwzmj0r4QhWrUpYKIe2/Ji2P
         a2yDKQDo8myiw==
Date:   Mon, 27 Nov 2023 11:26:06 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <ZWTtTjgBrNxpd9IO@x130>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112702-postal-rumbling-003f@gregkh>
 <20231127144017.GK436702@nvidia.com>
 <2023112752-pastel-unholy-c63d@gregkh>
 <20231127161732.GL436702@nvidia.com>
 <2023112707-feline-unselect-692f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2023112707-feline-unselect-692f@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Nov 18:27, Greg Kroah-Hartman wrote:
>On Mon, Nov 27, 2023 at 12:17:32PM -0400, Jason Gunthorpe wrote:
>> On Mon, Nov 27, 2023 at 03:51:10PM +0000, Greg Kroah-Hartman wrote:
>>
>> > Ok, best of luck with this mess, I'll stop harping on it now and just
>> > point out all of the other issues here.  First off, you all need to get
>> > the network maintainers to agree that this driver is ok to do this way,
>> > and I don't think that has happened yet, so I'll wait on reviewing the
>> > series until that is resolved.
>>
>> As I said already, I strongly disagree with the idea that the netdev
>> maintainers get a global veto on what happens with mlx5 devices just
>> because they sometimes have an ethernet port on the back of the card.
>
>I understand you might disagree, however I hold their opinion in high
>regard and want to ensure that they agree that exposing device-specific
>debugging information for a device that deals with networking is ok to
>do so in a device-specific misc device node and not through some other
>way that other networking devices normally do (i.e. netlink or
>some-other-such-thing.)
>
>Note, device-specific character devices have almost always proven to be
>a bad idea in the long run, I understand your immediate need to do
>something like this, but remember that keeping it alive for the next 20+
>years is going to be tough.
>

This driver is different as it doesn't replace existing mlx5 drivers,
mlx5 functionality drivers are still there to expose the device features
through the standard stacks, this is just a companion driver to access
debug information, by driver and FW design mlx5ctl is not meant to
manage or pilot the device like other device specific char drivers.

To be clear this debug driver (or at least an older version of it) 
has been already in use for over than 15 years, since the beginning
of mlx5, we used to only provide it as external package called mft 
debug tools [1] which has the kernel parts as well. Now it's time to
upstream it.

mlx5ctl will keep serving existing and future HW for the next few decades,
I am pretty sure of that. as the cover-letter explains  mlx5 architecture
is set in stone and written in ink, the same mlx5 drivers work on any
ConnectX chip since 2012, and the will keep working on the next generations
of chips, mlx5ctl will be no different.

[1] https://network.nvidia.com/products/adapter-software/firmware-tools/

>> This module is primarily (but not exclusively) for rdma related
>> functionality, not netdev, and the RDMA maintainers Ack it.
>

For Infiniband/virtio/vfio/vdpa/nvme/fpga ConnectX devices mlx5 netdev
doesn't even exist, so it is not reasonable to ask that the debug
interface should go via the netdev stack, mlx5ctl is needed to serve
all users of mlx5 devices, not only netdev (networking).

So I really find this odd, that one stack maintainer gets a veto over all
others.

>In my mind, RDMA implies networking, as it's over a network connection,
>but hey, I might be wrong :)
>
>thanks,
>
>greg k-h
