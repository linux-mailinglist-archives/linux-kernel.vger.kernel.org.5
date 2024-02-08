Return-Path: <linux-kernel+bounces-57469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B99084D975
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72D7B236C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE50B67A14;
	Thu,  8 Feb 2024 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lthftdi+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8067A0C;
	Thu,  8 Feb 2024 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707368617; cv=none; b=jXf2HJbqxgwU3pEKKJZIfVD/AL4IpIoPaJW4y8OwdRnW1l/6Y4EG87SzxNdYjTspCN9gKZulEpxhaiO1Fwzpd3xZptSoQd3Hr0EmB36a8cqWPJq7x0oRIKb1eDIOf97obcDib1brtEjn0fn03eLb5VuTncxDYjtV4UwG0vsJ+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707368617; c=relaxed/simple;
	bh=M6FtK7HMDcVHm0QaVRLZ5YiBe+m2JcUHhos1oSncHTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ms56baQBE4nqpF6DulVBQA6eLqWG5sYFiVgOk6/5MrB8rvTk8N7SEh7pSfV+BiGK0J4IO0UkXWauDm4TjwW16NM6fN+o2qQwIHYw004ztvp8hVHCUqI+lNid/K14H0b0oUwtO7s97VbcCqPucNdjXeml403XuFS3G46+twe+gUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lthftdi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF57C433F1;
	Thu,  8 Feb 2024 05:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707368617;
	bh=M6FtK7HMDcVHm0QaVRLZ5YiBe+m2JcUHhos1oSncHTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lthftdi+CN+TWzVWn+5untjrJpF/sxDaLHxYzi/ZYik4e95kMLyq9CAV8sq4lRwaK
	 seDuNxEBPWnfX7SLjxsto8qXQgqDBGfNZoYiEJX1+6ooef3ZlG8wmzUKasu3RXguFp
	 v9DinIyUR/M7wFaLpfzviJRPA7+yfQb5tyZ8rIQlmC8pvNJ5Qy8oDUScgusnlXrcb+
	 Lu2tWK8S8cJCfcJe4T5XrgXz9sacGeBqQ12Rv3cjUiYxm3nx1P0pntQ6DB3Yb5OkXi
	 h8ZwvhetXCU4oRsfc7TuHu5ik74TebOAD3qyraIJPAex86NW3PZmZOFBTCmtsrXl4U
	 kHFqdOO9xDEPg==
Date: Wed, 7 Feb 2024 21:03:35 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <ZcRgp76yWcDfEbMy@x130>
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207070342.21ad3e51@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240207070342.21ad3e51@kernel.org>

On 07 Feb 07:03, Jakub Kicinski wrote:
>On Tue,  6 Feb 2024 23:24:30 -0800 Saeed Mahameed wrote:
>> From: Saeed Mahameed <saeedm@nvidia.com>
>>
>> Recap from V3 discussion:
>> =========================
>>
>> LWN has published an article on this series aptly summarizing the debate.
>> LINK: https://lwn.net/Articles/955001/
>>
>> We continue to think that mlx5ctl is reasonable and aligned with the
>> greater kernel community values. People have pointed to the HW RAID
>> miscdevices as a good analog. The MD developers did not get to block HW
>> RAID configuration on the basis that it undermines their work on the
>> software RAID stack. Further, while there is a superficial similarity to
>> the DRM/accel debate, that was grounded in a real concern that DRM values
>> on open source would be bypassed. That argument does not hold up here as
>> this does come with open source userspace and the functionality mlx5ctl
>> enables on lockdown has always been available to ConnectX users through
>> the non-lockdown PCI sysfs. netdev has been doing just fine despite the
>> long standing presence of this tooling and we have continued to work with
>> Jakub on building common APIs when appropriate. mlx5 already implements
>> a wide range of the netdev common interfaces, many of which were pushed
>> forward by our staff - the DPLL configuration netlink being a recent
>> example.
>
>I appreciate Jiri's contributions (and you hired Maciej off of Intel at
>some point) but don't make it sound like nVidia lead DPLL, or pushed for
>a common interface :| Intel posted SyncE support. I asked them make it
>a standalone API family:
>

I will let the stats speak for itself.
$ git shortlog -sne --no-merges net/devlink 
and prior to commit f05bd8ebeb69 devlink: move code to a dedicated directory
$ git shortlog -sne --no-merges net/core/devlink.c

More than 70% of the commits are authored by more than 10 different individuals
form Mellanox/Nvidia .. 

Ok you don't like DPLL, here is a list of some central devlink features we did 
push to the devlink standard API:

  - subfunction API and devlink infrastructure
  - Shared buffer API
  - port function and rate API
  - shared buffer
  - health 

>https://lore.kernel.org/netdev/20210830162909.110753ec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/
>
>Vadim from Meta joined in and helped a lot based on the OCP time card.
>Then after some delaying and weird noises y'all started participating.
>

I remember those discussions, and I agree it is very weird when it
takes 3 vendors and 2 years to get a simple devlink API for single bit
flip accepted.

>> mlx5 ConnectX control misc driver:
>> ==================================
>>
>> The ConnectX HW family supported by the mlx5 drivers uses an architecture
>> where a FW component executes "mailbox RPCs" issued by the driver to make
>> changes to the device. This results in a complex debugging environment
>> where the FW component has information and low level configuration that
>> needs to be accessed to userspace for debugging purposes.
>
>You don't explain anywhere why addressing the challenges of using
>debugfs in secure environments isn't the way to go.
>

I already answered this question in length in v3
here: https://lore.kernel.org/all/ZWZFm2qqhV1wKKCV@x130/

>Also you keep saying debugging purposes but the driver is called
>"control misc driver", you need to iron out your narrative just
>a bit more.
>
>> Historically a userspace program was used that accessed the PCI register
>> and config space directly through /sys/bus/pci/.../XXX and could operate
>> these debugging interfaces in parallel with the running driver.
>> This approach is incompatible with secure boot and kernel lockdown so this
>> driver provides a secure and restricted interface to that.
>
>[snip]
>
>>     i) mstreg
>>       The mlxreg utility allows users to obtain information regarding
>>       supported access registers, such as their fields
>
>So the access mstreg gives over this interface is read only? That's
>what your description sounds like, but given your complaints about
>"inability to add knobs" and "control" in the name of the driver that
>must be false.
>

Yes this is enforced by the mlx5ctl driver and FW using the special
debug uid.

>> Other usecases with umem:
>>   - dynamic HW and FW trace monitoring
>>   - high frequency diagnostic counters sampling
>
>Ah yes, the high frequency counters. Something that is definitely
>impossible to implement in a generic way. You were literally in the
>room at netconf when David Ahern described his proposal for this.
>

I was in the room and I am in support of David's idea, I like it a lot,
but I don't believe we have any concrete proposal, and we don't have any
use case for it in netdev for now, our use case for this is currently RDMA
and HPC specific.

Also siimilar to devlink we will be the first to jump in and implement
the new API once defined, but this doesn't mean I need to throw away the
whole driver just because one single use case will be implemented in netdev
one day, and I am sure the netdev implementation won't satisfy all the
use-cases of high frequency counters:

Also keep in mind high frequency counters is a very small part of the debug 
and access capabilities the mlx5ctl interface offers.

>Anyway, I don't want to waste any more time arguing with you.
>My opinion is that the kernel community is under no obligation to carry
>your proprietary gateway interfaces. I may be wrong, but I'm entitled
>to my opinion.
>

Thanks, I appreciate your honesty, but I must disagree with your Nack, we
provided enough argument for why we believe this approach is the right
way to go, it is clear from the responses on V3 and from the LWN article
that we have the community support for this open source project.

>Please do me the basic courtesy of carrying my nack on these patches:
>
>Nacked-by: Jakub Kicinski <kuba@kernel.org>
>
>and CC netdev, so I don't have to respond again :|

Ack.

Thanks,
Saeed.


