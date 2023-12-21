Return-Path: <linux-kernel+bounces-9152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B745F81C1A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D954A1C24E18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FCA79475;
	Thu, 21 Dec 2023 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="cXXV+fkJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mr85p00im-zteg06022001.me.com (mr85p00im-zteg06022001.me.com [17.58.23.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2794C77620
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1703200347; bh=DCyDcGB+njyvZgduAOSYZ57kEuruZLX4DxL5rDhZZEc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cXXV+fkJVcexXshAtBA9kqoVzxZi82it4LAoVoRl4eliL18HhCFsbd8RyT/tzi1Ks
	 m7aaW3XhS8S+TqeuoeNyJ7IcQTl1s4KDvYUu07QGPU/Z6Pem/dO33pLm7xZ35AtckL
	 FcNdEAmrnYLHV8jJgahIucatEc0iQgtfQLGeipUJeL0KtQLPx1eUKBDE5G/DyNc3k0
	 9dwLiRv2OwdHFU3jW3zQlhkrcX1agIKHQBMw4loHfRMDhWzIBy6kM8DZumG+tyBtqP
	 dLuyeGgN5vb5Mb/+WL40zWSOBvIqMB24o1Rsx8uBodbrBJ1uYD+X2W2Fpc7oi8NNXZ
	 A3hlQld2axaNw==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id A7BD2800127;
	Thu, 21 Dec 2023 23:12:26 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: dan@danm.net
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [REGRESSION] net/ipv6/addrconf: Temporary addresses with short lifetimes generating when they shouldn't, causing applications to fail
Date: Thu, 21 Dec 2023 16:10:57 -0700
Message-ID: <20231221231115.12402-1-dan@danm.net>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2x4J6n-3fdC5FS1JBV_-vkus0m_RhcGg
X-Proofpoint-GUID: 2x4J6n-3fdC5FS1JBV_-vkus0m_RhcGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_11,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1030 mlxlogscore=528 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2312210177

I started running v6.7-rc5 on a desktop and began having problems
where Chromium would frequently fail to load pages and give an
"ERR_NETWORK_CHANGED" message instead. I also noticed instability in
avahi-daemon (it would stop resolving local names and/or consume 100%
CPU). Eventually I discovered that what is happening is that new
temporary IPv6 addresses for a ULA address are being generated once
every second, with very short preferred lifetimes (and I had an
interface with thousands of such temporary addresses). I also found
that it seems to be triggered when one of the devices on the network
sends a router advertisement with a prefix that has a preferred
lifetime of 0 (presumably it's sending that because it wants to
deprecate that prefix).

I bisected it to commit 629df6701c8a ("net: ipv6/addrconf: clamp
preferred_lft to the minimum required"). Upon reviewing that change, I
see that it has changed when generation of temporary addresses will be
allowed. I believe that change might have inadvertently caused the
kernel to violate RFC 4941 and might need to be reverted.

In particular RFC 4941 specifies that the preferred lifetime of a
temporary address must not be greater than the preferred lifetime of
the public address it is derived from. However, this change allows a
temporary address to be generated with a preferred lifetime greater
than the public address' preferred lifetime.

From RFC 4941:

    4.  When creating a temporary address, the lifetime values MUST be
        derived from the corresponding prefix as follows:

        *  Its Valid Lifetime is the lower of the Valid Lifetime of the
           public address or TEMP_VALID_LIFETIME.

        *  Its Preferred Lifetime is the lower of the Preferred Lifetime
           of the public address or TEMP_PREFERRED_LIFETIME -
           DESYNC_FACTOR.

Previously temporary addresses would not be generated for an interface
if the administratively configured preferred lifetime on that
interface was too short. This change tries to avoid that, and allow
generating temporary addresses even on interfaces with very short
configured lifetimes, by simply increasing the preferred lifetime of
the generated address. However, doing so runs afoul of the above
requirement. It allows the preferred lifetime of the temporary address
to be increased to a value that is larger than the public address'
preferred lifetime. For example, in my case where the router
advertisement causes the public address' preferred lifetime to be set
to 0, the current code allows a temporary address to be generated with
a preferred lifetime of (regen_advance + age + 1), which is obviously
greater than 0. It also, in my case, leads to new temporary addresses
with very short lifetimes being generated, about once every second,
leading to the application-level issues I described above.

Cheers,

-- Dan

