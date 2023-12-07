Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8275B8090B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443324AbjLGSx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjLGSx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:53:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1432C10FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:54:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61DDC433C7;
        Thu,  7 Dec 2023 18:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701975243;
        bh=K+4baxLGJCbqA3zWkhFCwva3PQMKvUCWJT2l+eXdYiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVAeBBGVY0Rj8o+1+QzAK0FiQb+Wo/noUN2XTR3/HHK+3u8pwdPiBt/+3VG6jYRAY
         WqXJMIiidKTfbd1agraFBV09t+gnSpekXl2UqpJe3Fxmovr3m23PNJ3zvObGuJoX6C
         Tg11zCPh9VStRw01fngVLaydmkFdCFiwmbnHvSzlKvpyAenBzoNOKV0NEWqOjFbLAy
         c8rUj+KYrBzKjTtQKvj7Jk+90873OgW+EVbraqjAwfnT5XrmY1We7aYJgoJ0L6sTaK
         boH+iVzipKXl8VFeltmEcK25ItMfidGIXRYnODmHp89CmXKSG1gd6PFRkRFkK1yre/
         H/bjL5xtw3Zyg==
Date:   Thu, 7 Dec 2023 10:54:02 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Aron Silverton <aron.silverton@oracle.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <ZXIUysBgNWWZHe0z@x130>
References: <20231128084421.6321b9b2@kernel.org>
 <20231128175224.GR436702@nvidia.com>
 <20231128103304.25c2c642@kernel.org>
 <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
 <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
 <20231205204855.52fa5cc1@kernel.org>
 <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Dec 10:41, Aron Silverton wrote:
>On Tue, Dec 05, 2023 at 08:48:55PM -0800, Jakub Kicinski wrote:
>> On Tue, 5 Dec 2023 11:11:00 -0600 Aron Silverton wrote:
>> > 1. As mentioned already, we recently faced a complex problem with RDMA
>> > in KVM and were getting nowhere trying to debug using the usual methods.
>> > Mellanox support was able to use this debug interface to see what was
>> > happening on the PCI bus and prove that the issue was caused by
>> > corrupted PCIe transactions. This finally put the investigation on the
>> > correct path. The debug interface was used consistently and extensively
>> > to test theories about what was happening in the system and, ultimately,
>> > allowed the problem to be solved.
>>
>> You hit on an important point, and what is also my experience working
>> at Meta. I may have even mentioned it in this thread already.
>> If there is a serious issue with a complex device, there are two ways
>> you can get support - dump all you can and send the dump to the vendor
>> or get on a live debugging session with their engineers. Users' ability
>> to debug those devices is practically non-existent. The idea that we
>> need access to FW internals is predicated on the assumption that we
>> have an ability to make sense of those internals.
>>
>> Once you're on a support call with the vendor - just load a custom
>> kernel, module, whatever, it's already extremely expensive manual labor.
>>
>> > 2. We've faced RDMA issues related to lost EQ doorbells, requiring
>> > complex debug, and ultimately root-caused as a defective CPU. Without
>> > interactive access to the device allowing us to test theories like,
>> > "what if we manually restart the EQ", we could not have proven this
>> > definitively.
>>
>> I'm not familiar with the RDMA debugging capabilities. Perhaps there
>> are some gaps there. The more proprietary the implementation the harder
>> it is to debug. An answer to that would be "try to keep as much as
>> possible open".. and interfaces which let closed user space talk to
>> closed FW take us in the opposite direction.
>>
>> FWIW good netdevice drivers have a selftest which tests IRQ generation
>> and EQ handling. I think that'd cover the case you're describing?
>> IDK if mlx5 has them, but if it doesn't definitely worth adding. And I
>> recommend running those on suspicious machines (ethtool -t, devlink has
>> some selftests, too)
>
>Essentially, a warning light, and that doesn't solve the underlying
>problem. We still need experts (e.g., vendors) to investigate with their
>toolsets when and where the problem occurs.
>
>I offered this as an example of one issue we solved. I cannot predict
>what kind of issues will pop up in the future, and writing a self-test
>for every possible situation is impossible by definition.
>
>>
>> > Firstly, We believe in working upstream and all of the advantages that
>> > that brings to all the distros as well as to us and our customers.
>> >
>> > Secondly, Our cloud business offers many types of machine instances,
>> > some with bare metal/vfio mlx5 devices, that require customer driven
>> > debug and we want our customers to have the freedom to choose which OS
>> > they want to use.
>>
>> I understand that having everything packaged and shipped together makes
>> life easier.
>
>I think it is a requirement. We operate with Secure Boot. The kernel is
>locked down. We don't have debugfs access, even if it were sufficient,
>and we cannot compile and load modules. Even without Secure Boot, there
>may not be a build environment available.
>
>We really need the module ready-to-go when the debug calls for it - no
>building, no reboots, no months long attempts to reproduce in some lab -
>just immediate availability of the debug interface on the affected
>machine.
>
>>
>> If the point of the kernel at this stage of its evolution is to collect
>> incompatible bits of vendor software, make sure they build cleanly and
>> ship them to distros - someone should tell me, and I will relent.
>
>I'm not sure I follow you... The mlx5ctl driver seems very compatible
>with the mlx5 device driver. I may be misunderstanding.
>

mlx5ctl is 100% compatible with mlx5 ConnectX open spec [1], and supports
any mlx5 driven stacks, not only netdev, it is able to expose millions of
objects and device states interactively, debugfs would explode if we even
try to accommodate some of these objects or states via debugfs, not to
mention it is also impossible to maintain a stable debugfs output for such
a huge data set, when this mlx5ctl interface speaks out a clear and open
ConnectX language, which is the hole point of the driver.

ConnectX is a highly programmable device for the enduser, and we have a
very open / accommodating policy, an advanced user who can read the open
spec [1], will also have the ability to do self-debug of their own
RDMA/DPU/FPGA apps or similar usecases.

Also I would like to repeat, this is not touching netdev, netdev's policies
do not apply to the greater kernel or RDMA, and we have use cases with
pure-infiniband/DPU/FPGA cards that have no netdev at all, or other cases
with pur virtio instances, and much more.

[1] https://network.nvidia.com/files/doc-2020/ethernet-adapters-programming-manual.pdf

