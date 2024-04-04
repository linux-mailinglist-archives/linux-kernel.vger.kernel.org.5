Return-Path: <linux-kernel+bounces-131365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997858986C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E8728FF94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459DF85276;
	Thu,  4 Apr 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="kj5amjGx"
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52F83A09;
	Thu,  4 Apr 2024 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232321; cv=none; b=SS6gFzE0qrhu14EXo/WOs5G2W2qHS6VIxH5OTKtopr/cq7KnomX5AiWQ+fHgbTKHDcs4XLn3kW/pAtuIypi56hpXAyvhBW5jPTA7cIWSIzNwbYSVQWfhhs0NkdUzfCSJhNYg7w+vBHz4ei6x3B0cBFz/azat+ig4Z8bPW6O+f5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232321; c=relaxed/simple;
	bh=djP7G2rig6EO/2llzbNLtTorDJ2reGUZB8vpRLoZWJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiDRS86ef64MK9UZAqOSrWrmSB50DOfPdkApk02brQuscFvt4XbT0XhYeAdnjPHaSUdYcseU53Zs3nR+5Fan9KJ5x0pSXHXjqMWxUjSwhI0RcaSVhUS825PzVWfnqg4duWA1jcilofXlq4S+QrCKsaJPLnUV4dQx+/rE8YXPgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=kj5amjGx; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <0c2ee56a-13a6-4d93-8c45-f43f551bf1da@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1712232314;
	bh=djP7G2rig6EO/2llzbNLtTorDJ2reGUZB8vpRLoZWJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kj5amjGxgXm/nFWRYWSRIxH8YJ4hyKb/r5v/Bi01EbEbGtTPyrw3su9xFE7nqi8Xg
	 53IkPRXF7VJjZNWwyeNIJTBq6NFm76BcGcVbrNcdkOED4cgKgPNUNSnyH0BZ37/Mht
	 CEGiIxDXwdEwr2qbKAyVyzNW82tuHiTP1Ze3YEEI=
Date: Thu, 4 Apr 2024 14:05:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [scsi?] WARNING in sg_remove_sfp_usercontext
To: Pengfei Xu <pengfei.xu@intel.com>,
 syzbot <syzbot+93cdc797590ffc710918@syzkaller.appspotmail.com>
Cc: dgilbert@interlog.com, jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 syzkaller-bugs@googlegroups.com
References: <000000000000a6e0450614b960ac@google.com>
 <00000000000007e8290614c036a6@google.com> <Zg6HlGO8ZyRQZSUA@xpf.sh.intel.com>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <Zg6HlGO8ZyRQZSUA@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.24 12:57, Pengfei Xu wrote:
> cc Alexander Wetzel,
> 
> I used syzkaller and found the similar problem.
> 
> And bisected and found the related commit:
> 27f58c04a8f4 scsi: sg: Avoid sg device teardown race
> Reverted the commit on top of v6.9-rc2, this issue was gone.

There were now multiple reports about the issue. The first (main) 
discussion and fix is here:
https://lore.kernel.org/all/20240401191038.18359-1-Alexander@wetzel-home.de/

In a nutshell:
The new WARN_ON_ONCE() was a (very) stupid idea and must be undone.
It's ok to just drop the line with the WARN_ON_ONCE(). The rest of the 
proposed patch fixes a much less urgent issue.

Of course I can also break the fix into two patches, when this speeds up 
the merge...

Alexander

