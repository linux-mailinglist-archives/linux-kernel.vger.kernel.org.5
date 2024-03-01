Return-Path: <linux-kernel+bounces-89222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E1F86ECC4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33A7284874
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5685EE9B;
	Fri,  1 Mar 2024 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="eo9WJS4J"
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85775EE81
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334747; cv=none; b=ENGfOZJTS+rYSTrntzxm3KLt75JKQt84YH1NfC0hwxvps7bHKIGLqtfEO4q2r9fUb1Cn5umK1VruZbNXD33RYJLApYYIFXJQlStR/wuD7GX1cWucozBifd+U0VOI0e+/M2fD6CqyypDHIa6h4tD2TGMUwOepSDRDdoYIFsOmN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334747; c=relaxed/simple;
	bh=tCN7z5opTuaxuZKaKbGh+7h5gaws+AxIaLR7eadkP+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOKhzuCIKPO4tsVRNdhT0qZ8ZVMGBRfg16kWYWgheE9d0SV+jy3meUWD+vOXi4FiwuoI4sdFfbakms03w92R/yx8T8gLOXEaNeDxXMMEDNratG4+Hw7WzXcRdVFEsdTlU9jfCbtiTdjnp5YaMj9cX8BaBIflF89yOZ/rSdXxrQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=eo9WJS4J; arc=none smtp.client-ip=17.58.23.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1709334745; bh=tCN7z5opTuaxuZKaKbGh+7h5gaws+AxIaLR7eadkP+I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eo9WJS4JLPZpvgeqNyJLnO/hNZlTyc17b7AVpcMAVDpJ+g/1jW+MeuAz8UKxJE6+8
	 ZDiQlf9T1g/C8iY8iZLZG/pLS+a9mGSqK8yWbRYyQRnD2Drb+1/xlZRtz4OkTXIuUh
	 y+lZBfIn6i8j+VD93ms0OAJxR10o07qR5usAN7BBTHcY49ky5E8FAxiR0j7YiSjxBQ
	 tS8nQvSBATgaXoHYJ85jmMHo9PKjXlxwOKCifrI+jgT5on9S2iGZHTW09YT/Ey/zCd
	 uWynyrHGtctoBLD5B04eAoJRKYjXMwAEV8fzekpGNJ9lGl11vdk8CMMoWWR74+aAG1
	 AgbgM53J7T7IA==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 15B92357AEFA;
	Fri,  1 Mar 2024 23:12:23 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: junxiao.bi@oracle.com
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	song@kernel.org,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Fri,  1 Mar 2024 16:12:22 -0700
Message-ID: <20240301231222.20120-1-dan@danm.net>
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
X-Proofpoint-ORIG-GUID: tztJZvPg1SNT2tkeUQLA2R5vDPZNdcts
X-Proofpoint-GUID: tztJZvPg1SNT2tkeUQLA2R5vDPZNdcts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=572 clxscore=1030 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403010191

> 5. Looks like the block layer or underlying(scsi/virtio-scsi) may have
> some issue which leading to the io request from md layer stayed in a
> partial complete statue. I can't see how this can be related with the
> commit bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in
> raid5d"")

There is no question that the above mentioned commit makes this
problem appear. While it may be that ultimately the root cause lies
outside the md/raid5 code (I'm not able to make such an assessment), I
can tell you that change is what turned it into a runtime
regression. Prior to that change, I cannot reproduce the problem. One
of my RAID-5 arrays has been running on every kernel version since
4.8, without issue. Then kernel 6.7.1 the problem appeared within
hours of running the new code and affected not just one but two
different machines with RAID-5 arrays. With that change reverted, the
problem is not reproducible. Then when I recently upgraded to 6.8-rc5
I immediately hit the problem again (because it hadn't been reverted
in the mainline yet). I'm now running 6.8.0-rc5 on one of my affected
machines without issue after reverting that commit on top of it.

It would seem a very unlikely coincidence that a careful bisection of
all changes between 6.7.0 and 6.7.1 pointed at that commit as being
the culprit, and that the change is to raid5.c, and that the hang
happens in the raid5 kernel task, if there was no connection. :)

> Are you able to reproduce using some regular scsi disk, would like to
> rule out whether this is related with virtio-scsi?

The first time I hit this problem was on two bare-metal machines, one
server and one desktop with different hardware. I then set up this
virtual machine just to reproduce the problem in a different
environment (and to see if I could reproduce it with a distribution
kernel since the other machines are running custom kernel
configurations). So I'm able to reproduce it on:

- A virtual machine
- Bare metal machines
- Custom kernel configuration with straight from stable and mainline code
- Fedora 39 distribution kernel

> And I see the kernel version is 6.8.0-rc5 from vmcore, is this the
> official mainline v6.8-rc5 without any other patches?

Yes this particular vmcore was from the Fedora 39 VM I used to
reproduce the problem, but with the straight 6.8.0-rc5 mainline code
(so that you wouldn't have to worry about any possible interference
from distribution patches).

Cheers,

-- Dan

