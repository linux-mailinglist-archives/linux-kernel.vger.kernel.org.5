Return-Path: <linux-kernel+bounces-51236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2233B84882C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE781C22561
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00835FBA0;
	Sat,  3 Feb 2024 18:21:10 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A95FDC4
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706984470; cv=none; b=WFdOUyn3zeqdx4CO01zTt9TJ3nxNTL+nlzZE/Yv5JMzTF5H4pP6DursC18JOV+KDOnnJ7mifpx7DPPQihqk7xg7/Kq/s1BQ7WuROJcyGwshnUq6jvPNHU8VLNyHrORA1VtT898CFF8g1m9/CEoyCCtHCIxLVz8yiEUrUhZWVzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706984470; c=relaxed/simple;
	bh=qA865xa4elxfqR0ETOEGZ8wiHt8e6J9WOySJVfXBmz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZxGxEE5xTuynBiWF0CFzuDqWT0y8DXXgcgSlSSLGBrJ4vwqwYvx/FgNWCQ3lxCcgdsnFZS75DcC9tIWQWFnkQ4m8q3LRkNnH0W9wLgQ16i5sMu+QJehZZefFlxOXZPD+n/3SBLdbZkKFkfQJPkQY4XLZ6mSmTcHR0D9R/LbahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 8144C140116; Sat,  3 Feb 2024 19:20:47 +0100 (CET)
Date: Sat, 3 Feb 2024 19:20:47 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	linux-netdev@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: This is the fourth time =?utf-8?Q?I?=
 =?utf-8?Q?=E2=80=99ve_tried_to_find_what_led_to_the_regression_of_outgoin?=
 =?utf-8?Q?g_network_speed_and_each_time_I_fin?= =?utf-8?Q?d?= the merge
 commit 8c94ccc7cd691472461448f98e2372c75849406c
Message-ID: <Zb6D/5R8nNrxveAP@cae.in-ulm.de>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>

On Sat, Feb 03, 2024 at 06:02:15AM +0500, Mikhail Gavrilov wrote:
> Hi,
> I'm trying to find the first bad commit that led to a decreased
> network outgoing speed.
> And every time I come to a huge merge [Merge tag 'usb-6.8-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb]
> I have already triple-checked all my answers and speed measurements.
> I don't understand where I'm making a mistake.
> 
> Let's try to figure it out together.
> 
> Input data:
> Two computers connected 1Gbps link.
> Both have the same hardware.
> Network: RTL8125 2.5GbE Controller (rev 05)
> 
> When I copy files from one computer to another and kernel snapshot
> builded from commit 296455ade1fd I have 97-110MB/sec which is almost
> max speed of 1Gbps link.
> When I move to commit 9d1694dc91ce I have only 66-70MB/sec which is
> significantly slower.
> 
> I bisected the issue by measuring network speed on each step.
> I save all results to file [1]
> 
> [1] file is attached as a zip archive.
> 
> # first bad commit: [8c94ccc7cd691472461448f98e2372c75849406c] Merge
> tag 'usb-6.8-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb

So (simplified) the change history looks something like this:

   branch point  296455ade1fd (good)     9d1694dc91ce (merge, bad)
       |             |                         |
 ----- * ----------- * ----------------------- * --------------  <- master
        \                                     /
	  ----------- * ---------------------   <- development branch
	              |
		  Bug introduced here

The straight line is Linus' master branch. At some point in the
past a development branch was forked from Linus's branch (the
lower line). During that development the regression was introduced
and when the branch was merged back the master branch started to
have the regression.

To further pin point the bug in the development branch you'll have to
bisect along the lower line.

So how do you do this:

Look at the merge:
$ git cat-file -p 9d1694dc91ce | head -n3
tree d9093aecb9261cccaea1f0a58887fcd9db542172
parent e9a5a78d1ad8ceb4e3df6d6ad93360094c84ac40
parent b2e792ae883a0aa976d4176dfa7dc933263440ea

So the merge commit has two parent commits, one is on the master
branch, the other is on the development branch. To find out which
of the parents is on the development branch you can ask git to find
the common ancestor of the two parent commits and your good commit
on the master branch:

$ git merge-base 296455ade1fd e9a5a78d1ad8ceb4e3df6d6ad93360094c84ac40
296455ade1fdcf5f8f8c033201633b60946c589a
$ git merge-base 296455ade1fd b2e792ae883a0aa976d4176dfa7dc933263440ea
587371ed783b046f22ba7a5e1cc9a19ae35123b4

So the second parent is not on the master branch and the merge base
(i.e. the point where the development branch was forked from the master
branch) is 587371ed783b046f22ba7a5e1cc9a19ae35123b4.

So I'd assume that 587371ed783b046f22ba7a5e1cc9a19ae35123b4 is a good
commit and b2e792ae883a0aa976d4176dfa7dc933263440ea is a bad commit.
You can verify this and then start bisecting like this for better
results:
$ git bisect good 587371ed783b046f22ba7a5e1cc9a19ae35123b4
$ git bisect bad b2e792ae883a0aa976d4176dfa7dc933263440ea

      regards   Christian


