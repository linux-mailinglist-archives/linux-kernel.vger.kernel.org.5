Return-Path: <linux-kernel+bounces-3616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F73816E82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539F3B22E31
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8183F5A;
	Mon, 18 Dec 2023 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fdsnd/R+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCB4237D;
	Mon, 18 Dec 2023 12:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16894C433CA;
	Mon, 18 Dec 2023 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702903497;
	bh=FA7bC/Tz22mCuz19J7PFs++xTkp+j/DZIFm/pULGGl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fdsnd/R+4UyNhga0DfAdvjbrWZezQ0FT1GzT8s+S7SlcxFsgX1mKGoN9yh5NHcYkm
	 JNt65swmHeDRpnVHlAPgjUltjxLZRsIbBSLKQ4e4Add2aZtW+ZbBSVRGKTD1RE5+lR
	 0ZFwok+z2pABDWQSIXNVrTYxO3b7KSNkp580lMxU=
Date: Mon, 18 Dec 2023 13:44:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] /proc/sysrq-trigger can now pause processing for one
 second
Message-ID: <2023121858-detonator-deepness-0135@gregkh>
References: <20231218114222.283705-1-tomas.mudrunka@gmail.com>
 <c22997c9-6d99-4e1f-9015-b7f80be2a720@kernel.org>
 <CAH2-hcJe40e7LhrmQb5XjGpRfrUEp3RukqWUqn1p8UQSNkpisg@mail.gmail.com>
 <2023121858-aground-consent-cfe3@gregkh>
 <CAH2-hc+BO=oxt2faSqy4AJS6qPdjC+cAc+ONZrvYnCPJT1H61Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2-hc+BO=oxt2faSqy4AJS6qPdjC+cAc+ONZrvYnCPJT1H61Q@mail.gmail.com>

On Mon, Dec 18, 2023 at 01:37:44PM +0100, Tomáš Mudruňka wrote:
> > What will kill it?  I feel like you are adding features to the kernel
> > that can be done in userspace, which is generally not a good idea.
> 
> The mere act of writing "e" to /proc/sysrq-trigger kills everything
> except for init, which is rather unfortunate when doing that through
> remote access, like ssh (or other). I can surely block SIGTERM in
> userspace by fixing all remote access software that exists to not exit
> after SIGTERM, but if i want to do SIGKILL and then execute few more
> sysrq actions (sync, unmount, reboot, ...) it surely is a problem
> unless i am doing this from init process. which sometimes is just not
> possible on remote system that have undergone some crash. and as linux
> admin with 13 years of experience i can safely say that situations
> with unresponsive init do happen every now and then. that is when i
> usually have to resort to rebooting the system remotely via
> sysrq-trigger. this process failing can be difference between me being
> able to fix issue remotely with minimum downtime and me having to
> physicaly visit datacenter during holidays.
> 
> BTW if still unclear, here is simple example of how running that
> suggested code will not work:
> 
> $ ssh root@10.10.10.10
> root@10.10.10.10's password:
> Last login: Wed Oct  4 12:34:03 2023
> root@debian-arm64:~#
> root@debian-arm64:~# echo e > /proc/sysrq-trigger
> Connection to 10.10.10.10 closed by remote host.
> Connection to 10.10.10.10 closed.

Great, then perhaps sysrq is not the thing you should be doing here?
Why is sysrq suddenly responsible for remote connection fixes?

I'm all for adding stuff that is useful, but really, sysrq is a "last
possible chance" type of thing, if you need it to reboot your box, your
box is hosed and it's not here to make it any less hosed.

Add pauses and soon you will want loops and then it's turing complete :)

Why not have a bpf script that does this instead?  :)

thanks,

greg k-h

