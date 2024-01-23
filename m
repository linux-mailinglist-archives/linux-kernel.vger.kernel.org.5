Return-Path: <linux-kernel+bounces-34559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01F6837FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F41A2859C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C665012BF39;
	Tue, 23 Jan 2024 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="OzH+f9lN"
Received: from mr85p00im-zteg06021901.me.com (mr85p00im-zteg06021901.me.com [17.58.23.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF1C12BF27
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971431; cv=none; b=UdTEnCkfK9fTB8RpsyKwXh6ZcAsEmaYQQKmQQUJ7jMsHvKJuiBwaRyE7E3Xs1387roOx3n0Aptgvoi14+R+l6z6Uyd/QxcOPFeEsgSS5TdX8nrZnhkXD1yZwkioaQq+SeUwCg35621a4Q4z2/LNxSEIvkqBBdUTI6z7fR2ORRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971431; c=relaxed/simple;
	bh=QuFQTE9exHrJRr35+dJ3UyDgS7P65rSpnJVRQHYSrNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAGFAfjfftNElh3JtJYFgzk9W7mLXpMQjt3HJtyN7jM1GCGbPf65U3uHHQL4clfdursoip/ksGxLjxJ7R52pHVUHzurDUzu5ZbF0P2qIBThiZRGBmSeHRfpP+hhX+O/M4tKps5dPnEmfTLsu3kljYuLVPyn7h4JzRV1i3Isszfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=OzH+f9lN; arc=none smtp.client-ip=17.58.23.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1705971428; bh=i6qwIcb65hKUVeZw2T4gWRTYt29i3qmG0p6UeSGRy4Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=OzH+f9lNDTKyqDq+9UkocpvxWjiRST4Pn44zrNJZ4u7atAUlTTeX9W4UCrCgzZHu8
	 fZtynv2toBLM5fBgmcyJi4ZrMOyUpJ9EbU3Aw/4bERZUipTpc7o0zPIk7vyYzNipXs
	 R/sgifIZ6nnVjKBdxQkAIPrurSFXQfpw6ICGxENGL9UB9kgC89CJecN1IQxBpvf9OA
	 eJUP28lrNuQe7HDPq8Lv/lJhGDoLLhWiIusqVUr0EL1B603X1BWXJzjG3Rznap+1E5
	 8p8KuC5zFYvM9Eo1rRMukvHtj/+m1UhrOrytrTWr2SFV8rb3ATaRMZRKfVCrFC52xS
	 O6TUR7tNx1jHQ==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021901.me.com (Postfix) with ESMTPSA id 9522A740228;
	Tue, 23 Jan 2024 00:57:07 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: Song Liu <song@kernel.org>
Cc: regressions@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Moulding <dan@danm.net>
Subject: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Mon, 22 Jan 2024 17:56:58 -0700
Message-ID: <20240123005700.9302-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: roqiKP-niqHYz2b0Fa5A3TKVMmmoX9S6
X-Proofpoint-ORIG-GUID: roqiKP-niqHYz2b0Fa5A3TKVMmmoX9S6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=4 mlxlogscore=137 mlxscore=4
 clxscore=1030 suspectscore=0 bulkscore=0 phishscore=0 spamscore=4
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2401230006

After upgrading from 6.7.0 to 6.7.1 a couple of my systems with md
RAID-5 arrays started experiencing hangs. It starts with some
processes which write to the array getting stuck. The whole system
eventually becomes unresponsive and unclean shutdown must be performed
(poweroff and reboot don't work).

While trying to diagnose the issue, I noticed that the md0_raid5
kernel thread consumes 100% CPU after the issue occurs. No relevant
warnings or errors were found in dmesg.

On 6.7.1, I can reproduce the issue somewhat reliably by copying a
large amount of data to the array. I am unable to reproduce the issue
at all on 6.7.0. The bisection was a bit difficult since I don't have
a 100% reliable method to reproduce the problem, but with some
perseverence I eventually managed to whittle it down to commit
0de40f76d567 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in
raid5d"). After reverting that commit (i.e. reapplying the reverted
commit) on top of 6.7.1 I can no longer reproduce the problem at all.

Some details that might be relevant:
- Both systems are running MD RAID-5 with a journal device.
- mdadm in monitor mode is always running on both systems.
- Both systems were previously running 6.7.0 and earlier just fine.
- The older of the two systems has been running a raid5 array without
  incident for many years (kernel going back to at least 5.1) -- this
  is the first raid5 issue it has encountered.

Please let me know if there is any other helpful information that I
might be able to provide.

-- Dan

#regzbot introduced: 0de40f76d567133b871cd6ad46bb87afbce46983

