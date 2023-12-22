Return-Path: <linux-kernel+bounces-9847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0437481CC50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2792831B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AD323776;
	Fri, 22 Dec 2023 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="gNsPl0V6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10BF23760
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1703259459; bh=W75HZle+KPuF3ARFyLYmGgDl0isjRggq7C/WnAUD0k0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gNsPl0V6bHDLrc7jMl31yBHa4uzbJROjkl5kZIPMZM3jx0WPliPgcyoJBm1sNy7j3
	 nroAp1a7vFtav334P2i4fFGr1xSa1wVmnh4ldrWr2mLqvT9jFVfDVsnLl/E5OeMTQg
	 hRudQoNSOvE2FB5btsOqJd9iOESMkp+1my1yq8HxvRrpVN3CwdhP6bMzRXEdS/7uF3
	 tD/bu12BPWfhIq7NfVGlxZFvkyPdMI+1YZrjyyjP/TNZ5Ojh8HeKwUjj2sEAb6THL8
	 QgLQfoZdT5JLVqnAgTHjYn3A01lcEGroh3zkKQT7RClomYINEi7SYRUQVkV1ZN9Hhn
	 31PLfh4wiE7gQ==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id C565A27941E3;
	Fri, 22 Dec 2023 15:37:31 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: bagasdotme@gmail.com
Cc: alexhenrie24@gmail.com,
	dan@danm.net,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] net/ipv6/addrconf: Temporary addresses with short lifetimes generating when they shouldn't, causing applications to fail
Date: Fri, 22 Dec 2023 08:37:03 -0700
Message-ID: <20231222153703.11268-1-dan@danm.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZYWNr_4P-je2uVDe@archie.me>
References: <ZYWNr_4P-je2uVDe@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4H-3eGBeWOOgncmUP221yFMYypoSXwZO
X-Proofpoint-ORIG-GUID: 4H-3eGBeWOOgncmUP221yFMYypoSXwZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_10,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=630
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2312220115

> > I bisected it to commit 629df6701c8a ("net: ipv6/addrconf: clamp
> > preferred_lft to the minimum required"). Upon reviewing that change, I
> > see that it has changed when generation of temporary addresses will be
> > allowed. I believe that change might have inadvertently caused the
> > kernel to violate RFC 4941 and might need to be reverted.
>
> Can you verify that by actually reverting 629df6701c8a91 on top of net
> tree?

Yes, after bisecting it to that commit, I did revert it on top of
v6.7-rc6 and verified that the problem goes away. It doesn't start
accumulating addresses once every second. Instead the single temporary
address that was generated for the deprecated prefix is still there,
with a preferred lifetime of 0, like I'd expect, and no new addresses
get generated. The application-level problems are also gone (Chromium
loads pages without issue, and avahi-daemon hasn't jumped to 100%
CPU).

I'm now running it this way on several machines and everything is
looking good again.

-- Dan

