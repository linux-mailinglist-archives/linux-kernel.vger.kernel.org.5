Return-Path: <linux-kernel+bounces-51890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2EC849071
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BA51C2101D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57562868D;
	Sun,  4 Feb 2024 20:47:25 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155E25567
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079645; cv=none; b=mM7yK9qIWJvYl8Q055MXZawBpXZfUh181E5ZWvbCug5MMzA8i9LKIzZ5iMzX9gBTcCduGaNc6zmkgvlGzQRUC5xAm5vrPqNuSZbVlTKeF/daucN8AekRt/9cZAzOQp7ZGjmVwGS5ZJEQWn2nYWtQ9blqYafaGqhz7G7ATSOhdXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079645; c=relaxed/simple;
	bh=gnyUR+f0Jp/5Ju8DmJrohRl2Q2I57247GaxMyU+VSn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXk5I0iUjVriiJC7NFng0h75TtK6COtazabbnN7rykvPyAJcVOmeL+/F3jg8m80kuqEkS9Vk/l4HPRzfbr5H1JtkTKbuYmzoicj8ymYjuGNiANwolnNTK9tSab6LNYNG4zniHYRL+r6WbaEk6kfdYhevJSIhAZ0QENmpHj4MYZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 9E88F140255; Sun,  4 Feb 2024 21:47:14 +0100 (CET)
Date: Sun, 4 Feb 2024 21:47:14 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	linux-netdev@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: This is the fourth time =?utf-8?Q?I?=
 =?utf-8?Q?=E2=80=99ve_tried_to_find_what_led_to_the_regression_of_outgoin?=
 =?utf-8?Q?g_network_speed_and_each_time_I_fin?= =?utf-8?Q?d?= the merge
 commit 8c94ccc7cd691472461448f98e2372c75849406c
Message-ID: <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb6D/5R8nNrxveAP@cae.in-ulm.de>

Hi,

[ sorry, replying to myself ]

On Sat, Feb 03, 2024 at 07:20:47PM +0100, Christian A. Ehrhardt wrote:
> On Sat, Feb 03, 2024 at 06:02:15AM +0500, Mikhail Gavrilov wrote:
> > Hi,
> > I'm trying to find the first bad commit that led to a decreased
> > network outgoing speed.
> > And every time I come to a huge merge [Merge tag 'usb-6.8-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb]
> > I have already triple-checked all my answers and speed measurements.
> > I don't understand where I'm making a mistake.
> > 
> > Let's try to figure it out together.
> > 
> > Input data:
> > Two computers connected 1Gbps link.
> > Both have the same hardware.
> > Network: RTL8125 2.5GbE Controller (rev 05)
> > 
> > When I copy files from one computer to another and kernel snapshot
> > builded from commit 296455ade1fd I have 97-110MB/sec which is almost
> > max speed of 1Gbps link.
> > When I move to commit 9d1694dc91ce I have only 66-70MB/sec which is
> > significantly slower.
> > 
> > I bisected the issue by measuring network speed on each step.
> > I save all results to file [1]
> > 
> > [1] file is attached as a zip archive.
> > 
> > # first bad commit: [8c94ccc7cd691472461448f98e2372c75849406c] Merge
> > tag 'usb-6.8-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> 
> So (simplified) the change history looks something like this:
> [ ... ]

Sorry, I was looking at the wrong merge commit and when using
the commit pinpointed by your bisect your log shows
that _both_ parents of the bad merge commit are marked as good
which is somewhat strange.

However, it should be possible to bisect further if you do a rebase
like this:

$ git cat-file -p
8c94ccc7cd691472461448f98e2372c75849406c  | head -n 3
tree d3907cad2a1fbbbcf71847274fdbdcf5a2aeb9a2
parent bd736f38c014ba70ba7ec3bdc6af6fe5368d6612
parent 933bb7b878ddd0f8c094db45551a7daddf806e00
$ git branch m bd736f38c014ba70ba7ec3bdc6af6fe5368d6612
$ git branch d933bb7b878ddd0f8c094db45551a7daddf806e000
$ git checkout d 
Updating files: 100% (11666/11666), done.
Switched to branch 'd'
$ git rebase m 
Successfully rebased and updated refs/heads/d.

Now, "m" must be good as per your bisect log and "d" must be bad
because it is the same tree as the bad merge commit (8c94ccc7cd69).

Due to the rebase there's a liner history between the two, thus
starting a bisect like this might yield more information:

$ git bisect good m
$ git bisect bad d

     regards   Christian



