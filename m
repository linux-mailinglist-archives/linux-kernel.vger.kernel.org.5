Return-Path: <linux-kernel+bounces-36096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B138839B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D0D1F22681
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64024EB50;
	Tue, 23 Jan 2024 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="AFuFreAq"
Received: from mr85p00im-zteg06022001.me.com (mr85p00im-zteg06022001.me.com [17.58.23.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCB4CB4C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046792; cv=none; b=TzgcHr6gu8Ihec2/vtojh+eW48xH5E+5NS4g9INbRpEehfyi5JceZo7cw0YdUE5rmtFoJqnH5f340Of8WRkflWAAd/BWNa15eph6+EuX8w5AqmG3I4dKqiLSIJu8vUDzcvukS20kB814flETaje5HcEUWMpR9eLFDcKCeIJKjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046792; c=relaxed/simple;
	bh=nezbIq/D3ENhfCPuWNhv3F47gynsXBfOjGxNVePJ7fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nW2259nhfe5AM2min0HWz2ImQWYGo6olDO23hshG5GmM2SO12f10+hIhxIVZIRZDiDsHTBpkTc7jTPsdKr+dfgONJGtgAFmko/w+q+jF13T8kU94SWyh4b2O0TdWbMWSGvf+AyPktBfhvMgaxf/ukxfToeU5Hb1RUpvBeGIyFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=AFuFreAq; arc=none smtp.client-ip=17.58.23.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1706046790; bh=wNJHkz8AkFLOOTSoO2V4Be1p2DmOhk/MoD05yij4/20=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=AFuFreAqntFxUNMn6XQf/yaVdt6ae2KPtCS6gGRRRsUM8FOqeq9RNAiS4yANqrzZr
	 SBmkUdPpJ8MyHjekq40rMKc64a0zguzumjIVsuM7eJorJvcYyfeqbrXuc7X/Mp5q7K
	 /xnmfO0NRaVUro4W07pOz27CP0l1PfoVDbrHAqq64nMSoIXHr5Oj0yHR4BoPtN9Z9u
	 Ony6bYOEY/NoGKJy0Q7lypOQYppI9j6fnr6NF5fEJ1WwTuckKrOx8zOaqnJAYwVqGf
	 M+r8D3UGA1XfZ63bkOltZFWemzwWQbWHRWaMswONZiPFNtocL9/lRwLatNEZyE6Drn
	 R+V2IG0qe76rA==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id CE79C8002B6;
	Tue, 23 Jan 2024 21:53:08 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: song@kernel.org
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	junxiao.bi@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	yukuai1@huaweicloud.com
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Tue, 23 Jan 2024 14:53:07 -0700
Message-ID: <20240123215307.8083-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPhsuW7-r=UAO8f7Ok08vCx2kdVx6mZADyZ-LknNE8csnX+L8g@mail.gmail.com>
References: <CAPhsuW7-r=UAO8f7Ok08vCx2kdVx6mZADyZ-LknNE8csnX+L8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kXPpc39gOyrjU3mX9CFKgWRDEzE30LnH
X-Proofpoint-GUID: kXPpc39gOyrjU3mX9CFKgWRDEzE30LnH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_13,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=917 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2401230162

> I think we still want d6e035aad6c0 in 6.7.2. We may need to revert
> 0de40f76d567 on top of that. Could you please test it out? (6.7.1 +
> d6e035aad6c0 + revert 0de40f76d567.

I was operating under the assumption that the two commits were
intended to exist as a pair (the one reverts the old fix, because the
next commit has what is supposed to be a better fix). But since the
regression still exists, even with both patches applied, the old fix
must be reapplied to resolve the current regression.

But, as you've requested, I have tested 6.7.1 + d6e035aad6c0 + revert
0de40f76d567 and it seems fine. So I have no issue if you think it
makes sense to accept d6e035aad6c0 on its own, even though it would
break up the pair of commits.

> OTOH, I am not able to reproduce the issue. Could you please help
> get more information:
>   cat /proc/mdstat

Here is /proc/mdstat from one of the systems where I can reproduce it:

    $ cat /proc/mdstat
    Personalities : [raid6] [raid5] [raid4]
    md0 : active raid5 dm-0[4](J) sdc[3] sda[0] sdb[1]
          3906764800 blocks super 1.2 level 5, 512k chunk, algorithm 2 [3/3] [UUU]

    unused devices: <none>

dm-0 is an LVM logical volume which is backed by an NVMe SSD. The
others are run-of-the-mill SATA SSDs.

>  profile (perf, etc.) of the md thread

I might need a little more pointing in the direction of what exactly
to look for and under what conditions (i.e. should I run perf while
the thread is stuck in the 100% CPU loop? what kind of report should I
ask perf for?). Also, are there any debug options I could enable in
the kernel configuration that might help gather more information?
Maybe something in debugfs? I currently get absolutely no warnings or
errors in dmesg when the problem occurs.

Cheers,

-- Dan

