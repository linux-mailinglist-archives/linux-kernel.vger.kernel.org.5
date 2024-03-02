Return-Path: <linux-kernel+bounces-89521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D2D86F180
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB75B23198
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4192BAF8;
	Sat,  2 Mar 2024 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="TDf4a8ID"
Received: from mr85p00im-zteg06011601.me.com (mr85p00im-zteg06011601.me.com [17.58.23.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F52BAEF
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398544; cv=none; b=u/FiVZrY5wMD+8GVkdt9x0FUyByxP/o7EDnDcV52D8BGSlWKFr0G+K6FdiSILNVYfMrd5Y1wsSYOMwUqZSgE0k+aWVLWSmA2h1gd86KnEYnUbrIVOo3gaudPiXPtaW+DV/Fc1vrVY6H4Mc2iVNPFPQne5ehS9wYQSe8/5tJTu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398544; c=relaxed/simple;
	bh=r1hdEvOvTGAyYI2NDiZwnAMIDbGJLBZ33WTBhZkrnjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtFahOD0lX6sqUh2wSnZY7Uk+Ac0GfrIXxgAzV69EmBWoR5p/vAHQUnBC8zQIp7p6DFUzfKQzxkLbCm1GW2BGmG5ZRiCGoELM8tUpeLZGP4YN2RKe9GcS2LM73uRG1FBbyVwYFqyAkJ/35ckD78Wwr3Wqk5sX/bR6ULS4ckxwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=TDf4a8ID; arc=none smtp.client-ip=17.58.23.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1709398542; bh=FPJi0KKilosGRHeh4YPOA99JZNRJDTi/69AY3tYVgS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TDf4a8IDxq2gQlVap0Wk3kfwJ5WcxRYxP4IPhPWORKWLVepQU7Oha3FduDhdHXaOe
	 6XGVhxkvA7NZFH4wYhKYJeLTZ6/wRHYoQvwrwExdTQVDZXhH1ND9IQ5SreiOWcqkXZ
	 G5rLpZuhxYRUmdxHng7YJvsAwKOD2ZP/hhaf5wYRUt3et4vL/LHFGUpXAkEpJ5YkdA
	 gs2jGor9O7vl22du6hmgoMuwj4Cn80kIPBTNhZZZPI3ch4isRse7Gp6FVtpdMqD6yY
	 /FOvRKumMMMKb67fzkSjngAbzaAB01pm/iut6AaJ+Q5ROmvIW0oDO/wJuNhG14xRyP
	 ztC/a3GncVqGA==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06011601.me.com (Postfix) with ESMTPSA id A175B180384;
	Sat,  2 Mar 2024 16:55:40 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: junxiao.bi@oracle.com
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	song@kernel.org,
	stable@vger.kernel.org,
	logang@deltatee.com
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Sat,  2 Mar 2024 09:55:38 -0700
Message-ID: <20240302165538.30761-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com>
References: <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JofO4N5HXtQWGery86c83noqRzdmhkBP
X-Proofpoint-GUID: JofO4N5HXtQWGery86c83noqRzdmhkBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-02_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=515 bulkscore=0 clxscore=1030 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403020146

> I have not root cause this yet, but would like share some findings from 
> the vmcore Dan shared. From what i can see, this doesn't look like a md 
> issue, but something wrong with block layer or below.

Below is one other thing I found that might be of interest. This is
from the original email thread [1] that was linked to in the original
issue from 2022, which the change in question reverts:

On 2022-09-02 17:46, Logan Gunthorpe wrote:
> I've made some progress on this nasty bug. I've got far enough to know it's not
> related to the blk-wbt or the block layer.
> 
> Turns out a bunch of bios are stuck queued in a blk_plug in the md_raid5 
> thread while that thread appears to be stuck in an infinite loop (so it never
> schedules or does anything to flush the plug). 
> 
> I'm still debugging to try and find out the root cause of that infinite loop, 
> but I just wanted to send an update that the previous place I was stuck at
> was not correct.
> 
> Logan

This certainly sounds like it has some similarities to what we are
seeing when that change is reverted. The md0_raid5 thread appears to be
in an infinite loop, consuming 100% CPU, but not actually doing any
work.

-- Dan

[1] https://lore.kernel.org/r/7f3b87b6-b52a-f737-51d7-a4eec5c44112@deltatee.com

