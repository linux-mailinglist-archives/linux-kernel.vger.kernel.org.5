Return-Path: <linux-kernel+bounces-73802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA7985CBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5131F21F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B2154451;
	Tue, 20 Feb 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="O5tSmIzw"
Received: from mr85p00im-zteg06021901.me.com (mr85p00im-zteg06021901.me.com [17.58.23.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CC13475F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470423; cv=none; b=om7N7HsAlw6M8MdVYxlGCM2CDeOvfglIFDRGEy0o/f4Pkf0L+VaidT+1mOgoNeQw82O358VkQBqQ0NhXRPhdvzuTW+IvItaqa43jrK5+eOyUvlmMOyRl8jS6Gr8ZX1pZKwFmU59rZDIVqcmZkcqwmuuy5gyiQBNG1dx/0gPiAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470423; c=relaxed/simple;
	bh=cx5Sp2rzq605sbkwS0QAmMyCZpMew4wZqnM5dGM4UJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2j06dBztbXBoPzL3+RzWRzS//sPok1YQ0NwolIWPQV3Wnv6YZY5u0K4F7UZUIMTBusFlvxf9pNg1rr08NFMER/UF2gPuwAFCKUGTjd3ogR3cFf6KmRHQ4cR+urIwXDK3t5ttAvMPov068ZIORlJIAW4IcMMKgMV/E4TnFSYxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=O5tSmIzw; arc=none smtp.client-ip=17.58.23.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1708470421; bh=cx5Sp2rzq605sbkwS0QAmMyCZpMew4wZqnM5dGM4UJI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=O5tSmIzwKRREKtHEUcm3gR8skmnkjDKRgoT1VGqc6XxiKLtzF3qgu6SorRLydGmDi
	 5MC71Z5wSOJvSD3iL/6d3Fsdhe4TQlhbYYiyR7CyMXVvYRGsOPzU0oYVvxsVF9L8+Q
	 lmgCRkwnRcpheZ6WwiHB9grbi+jlq1qMMhAxPd1ovGcRCTaahrb2ycamBG5dbcc0mp
	 e5O71bN9BHE0ES1TpsBqY+mKqLN5ipYltBQBZiFkhZX5e7cAdot4PM7zm3bil1prtv
	 nvm48DBV6V1mD8Ryi0rhh3Y17q8ikWEfC7pkBmgb30j1QdYhWSLMGD2oZOPGx1vH5m
	 O1jKHfqn1fGWA==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021901.me.com (Postfix) with ESMTPSA id 3DA0674035C;
	Tue, 20 Feb 2024 23:07:00 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: dan@danm.net
Cc: gregkh@linuxfoundation.org,
	junxiao.bi@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	song@kernel.org,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Tue, 20 Feb 2024 16:06:58 -0700
Message-ID: <20240220230658.11069-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123005700.9302-1-dan@danm.net>
References: <20240123005700.9302-1-dan@danm.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sySGESD_014rY6xbZq2xHo3R1DaQWchd
X-Proofpoint-GUID: sySGESD_014rY6xbZq2xHo3R1DaQWchd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=3 adultscore=0 mlxscore=3 spamscore=3
 suspectscore=0 clxscore=1030 bulkscore=0 malwarescore=0 phishscore=0
 mlxlogscore=156 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2402200166

Just a friendly reminder that this regression still exists on the
mainline. It has been reverted in 6.7 stable. But I upgraded a
development system to 6.8-rc5 today and immediately hit this issue
again. Then I saw that it hasn't yet been reverted in Linus' tree.

Cheers,

-- Dan

