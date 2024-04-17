Return-Path: <linux-kernel+bounces-148801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D698A8795
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28CC1C21BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48435147C60;
	Wed, 17 Apr 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="En+WNy9z"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A40145FE2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367798; cv=none; b=tDul6D8dSAzfnN0zj+y9rGvW+evuH+QjsZeHTiQmNhLftJmE0G+aayYmjNUDrQfMopgm5OKpYUrix8D0KAyVUIlWKYHqQr7eypAmxopZSxVFYPSU7CX8j79p6py60E5yI9vj78lbRJZ0wJUlfMKduprFLe/O0SZJBed0jrfstro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367798; c=relaxed/simple;
	bh=2iI96QrTRQ5jyvNs1Lv99V5eEk8SGHk02aKLXCaXwMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLjoV1Yl35umBmq41ngDCno1EC3SKlO/9w7QEjhjh6z8V4jLrDkIzcUwrAwwCgj/C44Sskm5fxtHxYIOWO9BitbdSxRGSG1uE26lbIwQXHqUDgnjTFn5EzKTxkdcF5kCgqHnE19Xh3HlvBhDktRU80P+nblHVXWWJu/zeyrFutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=En+WNy9z; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43HFTfQ7015111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 11:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713367784; bh=bM970VzfEpyjYp5p95QWPLHvSVRRx7peqRZSOKjgA7g=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=En+WNy9zl1Xwaq3WsBsFMsIvn7BVaWDlTn3RaDX6s9Lfa99/Dumgnm/sei778rv1U
	 3tPZy2HlbKbOfsdnsWq/SfN4jN+6o+NOHvDavLUxLhZ5EOQ74WSFcUhL6H9yYzjCod
	 YRY2A41SEhlSl+/23kMq+q3VWW8TigB4/U7xYLbMo/iEFHwdgpaD23O75IoZMyAuA2
	 f1dS76aMDUO6BHh6+ioPRL8uRkIgnzk3VTCVO2Bl2CRGIVZzkMY22niQM+Vv0q7nzc
	 uH3mY/RTvxrteGnuUbVMYyrAoN05Y0HkKVpshxv4R1FeJWBdc6fWbClseolo+0Tzq0
	 1G541e9pfWkzA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BA4B115C0CBA; Wed, 17 Apr 2024 11:29:41 -0400 (EDT)
Date: Wed, 17 Apr 2024 11:29:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org,
        linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26774: ext4: avoid dividing by 0 in
 mb_update_avg_fragment_size() when block bitmap corrupt
Message-ID: <20240417152941.GD2277619@mit.edu>
References: <2024040308-CVE-2024-26774-52d9@gregkh>
 <20240417114324.c77wuw5hvjbm6ok5@quack3>
 <2024041711-chapter-uninstall-b1d3@gregkh>
 <20240417145446.uh2rqcbxlebnkbfm@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417145446.uh2rqcbxlebnkbfm@quack3>

On Wed, Apr 17, 2024 at 04:54:46PM +0200, Jan Kara wrote:
> So if we should honestly state the situation (and filesystem folks are
> trying to get this message across for a few years already), we should issue
> a CVE for "mounting untrusted fs image can crash your kernel or install
> rootkit to your system". And yes, I know most distros will happily mount
> whatever is plugged into the USB port because that is what users expect and
> it is convenient. So if anybody wants a practical solution to this security
> problem, I'd suggest working on FUSE drivers for filesystems you care about
> and make distros use that when mounting removable media... That is actually
> pretty secure and robust solution if you don't care about performance
> *that* much.

I will note that the insistence of enabling the automounter is
apparently the fault of some Red Hat product manager.  Alas, our
requests to "cut that out" have been ignored.

I'll also note that Darrick and I have included udev rules in xfsprogs
and e2fsprogs to disable the automounter for ext4 and xfs file
systems.  I believe the xfsprogs udev rules have already been
released, and the ext4 udev rules in e2fsprogs will be released in the
next upstream release.

It will be interesting to see how many distributions explicitly decide
to override our udev rules....  If they do, hopefully the security
liability will attach to those distributions, and they will get
everything that they deserve.

Humming "Flexing like a godd*mn acrobat ; Karma and I vibe like that",

						- Ted

