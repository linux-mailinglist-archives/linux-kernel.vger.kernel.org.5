Return-Path: <linux-kernel+bounces-34593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB08381E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCA328A66A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E3C4F21B;
	Tue, 23 Jan 2024 01:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="ICP+XLrb"
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54265524C1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705973722; cv=none; b=hfW/0g/vpfIfoN3v3kwlrn1NslZ1E8/1/TiLrfYeJlA1HjPMQW/Tefi9zSD9tbkIpdeM/7tcJDwY4BP9CtU3IRbEdFtaZbZKKeHXODG+trNY1hhTXN02axC7KOMOl9DEY6AYhLMrPpCYaFY6kVMUczhmcqp1Xj4duR/y5i5qwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705973722; c=relaxed/simple;
	bh=sah6Xek+srS2p2Pn7bvG4UHevwcL+grb3CBbgjQc+TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJbjX3fx6SLK0cEJfHvBocQVaFStFEzbetMzUAx/e6QNPD2TiCh/c5T9S/wr1+jQCH0RlA0888Z8fZPLo9eU7UxhZahJyNIcVbhzTiTLBD4l5IciHROdR+ZYnXQwg3dVRFhxLsuKGsHtVbguzbh+Y5sH5URSgJn6nqrqMPXVwA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=ICP+XLrb; arc=none smtp.client-ip=17.58.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1705973718; bh=sah6Xek+srS2p2Pn7bvG4UHevwcL+grb3CBbgjQc+TM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ICP+XLrbZU0KXMwBwZpH5hiAFN2S7t2Fw83glczYxYp9I29CbcY+AOrkZnu93bHOp
	 vbXFoq6YWmijrFcFwZN+yQaFK++EPJ1HPXZ6a38Ixzho2vNGd3Xvgqjx4+oeyz2Nb7
	 aNxEqGxsuZQBSQou1SSrxgZpZiNrllgQxhQsItJ1KhbH1lAJ08c8WCFDQygmedLxGf
	 aM2CDeZSySH4UYj5pxDno3y3Tpjb3OizNahkPVxBcYVOxu//iJ8jIRlIXwXcoxpZSt
	 QAikfMgOhwadFhiuexozuiABAVcu0LKc7sE/8cWL55Id8m68UlHw3oSbFDLEnqnvUf
	 BzqOYtUaP0dBQ==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id 42B9830585CD;
	Tue, 23 Jan 2024 01:35:17 +0000 (UTC)
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
Date: Mon, 22 Jan 2024 18:35:14 -0700
Message-ID: <20240123013514.7366-1-dan@danm.net>
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
X-Proofpoint-ORIG-GUID: CGjGPmDYwSrLW_CGDW0snxWtJ2ZFhDoJ
X-Proofpoint-GUID: CGjGPmDYwSrLW_CGDW0snxWtJ2ZFhDoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=595
 suspectscore=0 malwarescore=0 clxscore=1030 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401230009

Some additional new information: I realized after filing this report
that on the mainline there is a second commit, part of a pair, that
was supposed to go with commit 0de40f76d567. That second commit
upstream is d6e035aad6c0 ("md: bypass block throttle for superblock
update"). That commit probably also was supposed to have been
backported to stable along with the first, but was not, since it
provides what is supposed to be a replacement for the fix that has
been reverted.

So I rebuilt my kernel with the missed commit also backported instead
of just reverting the first commit (i.e. I have now built 6.7.1 with
just commit d6e035aad6c0 on top). Unfortunately, I can still reproduce
the hang after applying this second commit. So it looks
like even with that fix applied the regression is still present.

Coincidentally, I see it seems this second commit was picked up for
inclusion in 6.7.2 just today. I think that needs to NOT be
done. Instead the stable series should probably revert 0de40f76d567
until the regression is successfully dealt with on master. Probably no
further changes related to this patch series should be backported
until then.

Cheers,

-- Dan

