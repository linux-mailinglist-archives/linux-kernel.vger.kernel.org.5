Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A28806660
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 05:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376651AbjLFEsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 23:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFEsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 23:48:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A856A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 20:48:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1695EC433C7;
        Wed,  6 Dec 2023 04:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701838137;
        bh=m+CegGpcxRyo/raoNH696719o8PPhaXae7JopGc2FhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rPLjrLQk+3kKLIQvdb+37zG5m/hX+g/MoFu7JFtBKiJXzDG0RJLhvM4U6Jkd2K0T7
         +m/7kY3FKFU4lOlzH+f9hd1m4iDOKIipNneln2zfDPnj1G/4TCiaVY7izmmNUz+32s
         J+GZZpKWh4y1vxQysMI9tHWwH5cRJDbHB76qblvVdEx5/X0w1yDRZrg9daOpFbnk2u
         Xz0pfQdjX1eAH+mJmnmr7eepktoWfOxbRynp2muQag611UkwGW9yZdBzIMB+GEejZ/
         xqrNleabKQvgmOtAWYX0KvNE9rFZYTrEpf6ewmYh3EVJL7Yyi1/gOHNEGBr021qL6S
         S24PhyYlhvILQ==
Date:   Tue, 5 Dec 2023 20:48:55 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Aron Silverton <aron.silverton@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231205204855.52fa5cc1@kernel.org>
In-Reply-To: <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
References: <20231128044628.GA8901@u2004-local>
        <20231128065321.53d4d5bb@kernel.org>
        <20231128162413.GP436702@nvidia.com>
        <20231128084421.6321b9b2@kernel.org>
        <20231128175224.GR436702@nvidia.com>
        <20231128103304.25c2c642@kernel.org>
        <ZWZJGF7moDM_k6TU@x130>
        <2023112922-lyricist-unclip-8e78@gregkh>
        <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
        <20231204185210.030a72ca@kernel.org>
        <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 11:11:00 -0600 Aron Silverton wrote:
> 1. As mentioned already, we recently faced a complex problem with RDMA
> in KVM and were getting nowhere trying to debug using the usual methods.
> Mellanox support was able to use this debug interface to see what was
> happening on the PCI bus and prove that the issue was caused by
> corrupted PCIe transactions. This finally put the investigation on the
> correct path. The debug interface was used consistently and extensively
> to test theories about what was happening in the system and, ultimately,
> allowed the problem to be solved.

You hit on an important point, and what is also my experience working
at Meta. I may have even mentioned it in this thread already.
If there is a serious issue with a complex device, there are two ways
you can get support - dump all you can and send the dump to the vendor
or get on a live debugging session with their engineers. Users' ability
to debug those devices is practically non-existent. The idea that we
need access to FW internals is predicated on the assumption that we
have an ability to make sense of those internals.

Once you're on a support call with the vendor - just load a custom
kernel, module, whatever, it's already extremely expensive manual labor.

> 2. We've faced RDMA issues related to lost EQ doorbells, requiring
> complex debug, and ultimately root-caused as a defective CPU. Without
> interactive access to the device allowing us to test theories like,
> "what if we manually restart the EQ", we could not have proven this
> definitively.

I'm not familiar with the RDMA debugging capabilities. Perhaps there
are some gaps there. The more proprietary the implementation the harder
it is to debug. An answer to that would be "try to keep as much as
possible open".. and interfaces which let closed user space talk to
closed FW take us in the opposite direction.

FWIW good netdevice drivers have a selftest which tests IRQ generation
and EQ handling. I think that'd cover the case you're describing?
IDK if mlx5 has them, but if it doesn't definitely worth adding. And I
recommend running those on suspicious machines (ethtool -t, devlink has
some selftests, too)

> Firstly, We believe in working upstream and all of the advantages that
> that brings to all the distros as well as to us and our customers.
> 
> Secondly, Our cloud business offers many types of machine instances,
> some with bare metal/vfio mlx5 devices, that require customer driven
> debug and we want our customers to have the freedom to choose which OS
> they want to use.

I understand that having everything packaged and shipped together makes
life easier.

If the point of the kernel at this stage of its evolution is to collect
incompatible bits of vendor software, make sure they build cleanly and
ship them to distros - someone should tell me, and I will relent.
