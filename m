Return-Path: <linux-kernel+bounces-10479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B05B81D4D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C92D1C2114A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816CE569;
	Sat, 23 Dec 2023 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="c3DtDiPW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2B12E53
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1703344958; bh=ovGTlMDPRAGKzno3u31CFlIC7HFqSBjL48kKASqoQW4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=c3DtDiPWp1lf3yECMzAwbWceyad9k0h3W7JXDa6qf5inhdNeKd8Gu31a43mkIz27g
	 65HUH+FnCfIEftGhQGxo/GF7eYJxnaVG2T1IFUtA6UIAFo2jILd8gjVKUzjMedNZM0
	 VHtUr1yrj+TmCQ2SYXufc80cjiAck099GAGMB1QGRgH2BuZGTEqnqEp04rmYiDWN4C
	 1R6vN2tMAdjH0o1ncCbr7B0CBZ11ZmCF4VYDpcSd7VWZaSGfadD6+Ebf/1El8PgqF6
	 5U7BTSMaeL/D3AD37UqkBPi5PymsFa863200G+Lka/itTR85fK9tChS0524ncTGfSU
	 lFtHaU8NuYl8w==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 1EB61357AE1A;
	Sat, 23 Dec 2023 15:22:36 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: alexhenrie24@gmail.com
Cc: bagasdotme@gmail.com,
	dan@danm.net,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] net/ipv6/addrconf: Temporary addresses with short lifetimes generating when they shouldn't, causing applications to fail
Date: Sat, 23 Dec 2023 08:22:35 -0700
Message-ID: <20231223152235.15713-1-dan@danm.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222234237.44823-1-alexhenrie24@gmail.com>
References: <20231222234237.44823-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IVspz_wVv4nBP_guhifhXr4Xdh0VPXjO
X-Proofpoint-GUID: IVspz_wVv4nBP_guhifhXr4Xdh0VPXjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-23_06,2023-12-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1030 malwarescore=0 mlxlogscore=938 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2312230121

> Sorry for the unintended consequences, and thank you for the detailed
> explanation. Does this patch fix the problem for you?

Thanks. I think this patch may resolve the application-level issues
I'm seeing.

However, it looks to me like this would still violate the RFC. The
temoporary address' preferred liftime must be lower than /both/ the
preferred lifetime of the public address and TEMP_PREFERRED_LIFETIME -
DESYNC_FACTOR.

These two existing lines ensure that it will meet the requirement:

	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
	cfg.preferred_lft = min_t(__u32, ifp->prefered_lft, cfg.preferred_lft);

Once that has been computed, cfg.preferred_lft is already at its
maximum allowed value. There is no case where the RFC allows
increasing that value after doing that computation.

I think the safest thing to do is revert this change, and try to find
some other way to achieve the goal of preventing the user from
administratively setting a preferred lifetime that prevents temporary
addresses from being generated, when the user wants to use the privacy
extensions. For example, this could be done where administratively
configured values are accepted (wherever that is), and either generate
a warning or reject the change, if the value provided by the user is
lower than REGEN_ADVANCE.

-- Dan

