Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589CA808D26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjLGP4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbjLGP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:56:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3153ABD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:55:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E08C433C8;
        Thu,  7 Dec 2023 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701964492;
        bh=j+A8HC+/CTEKAKXAGf5rsMfShCOdniBO0jQsFTvKPe0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y/dGeoJlP1O0eQTnVpyyoz7c48ZnIZUgVvUdoywSWgr911ILlbFHm9CZi2pTzPgrU
         DxEx7/Uw4oRtdexPJf6+IHCybyBVF8BpiY5lTUJr42kHN6UPjTxSz5c5oNpIykpWJQ
         Zmnjuj8RdQM1Z0woOGe3u1t/Xie6jJ/8RtZ9tbgnETYPpruMuTp3V/t5eocqKJQouD
         ps1H6vCEVZKeHhxbMr3r6crD6a5FIokfK1vbc0v4sPhaz4EMfPAlGCUX8DjwxLDsg0
         SS1GBva9dtJPLy1vWdFpDqwkEscHFl6hqKesCyeeNN4p9nglKhJkMo7PPQlkj8/Tkl
         gRDH14Z6Ud5pQ==
Message-ID: <2bbc4c40-ff8b-4243-9987-dc7d5502a37c@kernel.org>
Date:   Thu, 7 Dec 2023 08:54:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
References: <20231128044628.GA8901@u2004-local>
 <20231128065321.53d4d5bb@kernel.org> <20231128162413.GP436702@nvidia.com>
 <20231128084421.6321b9b2@kernel.org> <20231128175224.GR436702@nvidia.com>
 <20231128103304.25c2c642@kernel.org> <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
 <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
 <20231205204855.52fa5cc1@kernel.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231205204855.52fa5cc1@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

On 12/5/23 9:48 PM, Jakub Kicinski wrote:
> On Tue, 5 Dec 2023 11:11:00 -0600 Aron Silverton wrote:
>> 1. As mentioned already, we recently faced a complex problem with RDMA
>> in KVM and were getting nowhere trying to debug using the usual methods.
>> Mellanox support was able to use this debug interface to see what was
>> happening on the PCI bus and prove that the issue was caused by
>> corrupted PCIe transactions. This finally put the investigation on the
>> correct path. The debug interface was used consistently and extensively
>> to test theories about what was happening in the system and, ultimately,
>> allowed the problem to be solved.
> 
> You hit on an important point, and what is also my experience working
> at Meta. I may have even mentioned it in this thread already.
> If there is a serious issue with a complex device, there are two ways
> you can get support - dump all you can and send the dump to the vendor
> or get on a live debugging session with their engineers. Users' ability
> to debug those devices is practically non-existent. The idea that we
> need access to FW internals is predicated on the assumption that we
> have an ability to make sense of those internals.
> 
> Once you're on a support call with the vendor - just load a custom
> kernel, module, whatever, it's already extremely expensive manual labor.

You rail against out of tree drivers and vendor proprietary tools, and
now you argue for just that. There is no reason debugging capabilities
can not be built into the OS and used when needed. That means anything
needed - from kernel modules to userspace tools.

The Meta data point is not representative of the world at large -
different scale, different needs, different expertise on staff (OS and
H/W). Getting S/W installed (especially anything requiring a compiler)
in a production server (and VMs) is not an easy request and in many
cases not even possible.

When a customer hits problem, the standard steps are to run a script,
generate a tar file and ship it to the OS vendor. Engineers at the OS
vendor go through it and may need other data - like getting detailed
dumps from individual pieces of H/W. Every time those requests require
going to a vendor web site to pull down vendor tools, get permission to
install them, schedule the run of said tool ... it only serves to drag
out the debugging process. ie., this open-ended stance only serves to
hurt Linux users.
