Return-Path: <linux-kernel+bounces-78911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59257861A82
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CEE1F27D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FE413EFF7;
	Fri, 23 Feb 2024 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="CB5hM1IU"
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BB1292DF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710296; cv=none; b=AvIG31xfWJRIVihwmpEAoo9XqP1VIHqcMUpRFWFO8nRA0FnVmhKgehHU9SRtVp1fLRkOIG4LjvEphvcgTXEl6+THYJODqJ+US6US6EgwHsv2J+sKsxBB/rgktY6hhMtbt7rEojhd3icKymMaHv9+GeMBkeMznnsO4OZD0+kGNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710296; c=relaxed/simple;
	bh=ISpRbHIDoHxLfDN7k/rYb+hc7AVPOYDIgOoZFSxpWxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIDZ8dZ3stDnvrrv+YdgBBek2iTmEVplYoTAfZG+ZTSUp7OVh29piWGaQN6LsQFATw+gp/ojzG1D0cPXDyG5IHVCFwL83TqI2jezSi4G4SyTRRlqXxF4uLANW3mGhUvDg3YVN/OsFoelHnA4KxH8dzymITkicA4O9loES6tIJe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=CB5hM1IU; arc=none smtp.client-ip=17.58.23.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1708710294; bh=ISpRbHIDoHxLfDN7k/rYb+hc7AVPOYDIgOoZFSxpWxQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CB5hM1IUoALNX07oGgjXBP1FYi5Ias7TKzEBLe2aeqABzQV2AeQX5nrws4SOf6s8N
	 zRZN+s87txjlmIOaaeP12dLwxFX6ZaRNvI6PU3/9ViITxpQoH1eUfWKy4KtJX4Dv6J
	 PPYBEaxjVKlVDQJ9ISQj/Gby8RPctMsJc8RWVIb0xUL9VRVY9Z1Uiu2eVV/j214r1z
	 t5PJeFgm4QTDjFTmAkV9l5qwxtFLc9THqh+peJZ0CwDIaxC6f6oOCEEcG8wIxQvUI8
	 wvuojGujPJPvtzfhNktGbDYLJuW5/UAaKl8KEppVNkNN1z6pYFooK9k1jy10wjSCwT
	 XliOrrKEL3cEQ==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 805DB279409C;
	Fri, 23 Feb 2024 17:44:53 +0000 (UTC)
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
Date: Fri, 23 Feb 2024 10:44:52 -0700
Message-ID: <20240223174452.10209-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f32cd478-a905-4e98-a46c-0612bc10c38e@oracle.com>
References: <f32cd478-a905-4e98-a46c-0612bc10c38e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xV9SYKzsJ77FnJ1FBGeY4h0_shv3Ktry
X-Proofpoint-ORIG-GUID: xV9SYKzsJ77FnJ1FBGeY4h0_shv3Ktry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_04,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=471 clxscore=1030
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2402230130

Hi Junxiao,

Thanks for your time so far on this problem. It took some time,
because I've never had to generate a vmcore before, but I have one now
and it looks usable from what I've seen using crash and gdb on
it. It's a bit large, 1.1GB. How can I share it? Also, I'm assuming
you'll also need the vmlinux image that it came from? It's also a bit
big, 251MB.

-- Dan

