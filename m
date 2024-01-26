Return-Path: <linux-kernel+bounces-40299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024D483DDEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADF61F23CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89471D542;
	Fri, 26 Jan 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="gQKChUco"
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3D1D524
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283975; cv=none; b=jiFe5OqCWfJbDyMQWTXzGTbjsU2wJ1Xksq8/6qGNJ/jC+CjnradqOfPvr3Dg9Af+NjZ5hkh0TRtP70zzJwD4uG4DwWWZYs/lZN9lBqXahPA0EXgD685K9rBKrvWk/0mWGQpUSDMicMZSDoc+Dklq4eB1bOhU3IarlP6miDT39BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283975; c=relaxed/simple;
	bh=5kf8tTxC0yiNRmCBDthAhZJGzsbO6k25ITijcAGsWTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeRgT+3xMSt/1UBSGyMa2LWVMEjfLl4WreCBvOyvVU283wMaQ8SjpbgvscoW73Qa5NwcQXBU25KdE05byFXZOTTu3xtgrwEJJlsLufXHqx+rqiAy8rIvrK5nxZ4/OPQBYWoPfncUdmD4bYvXHZSA6aNjbQIy/a4DfYkQgTYuUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=gQKChUco; arc=none smtp.client-ip=17.58.23.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1706283973; bh=5kf8tTxC0yiNRmCBDthAhZJGzsbO6k25ITijcAGsWTQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gQKChUcoceWZ6jSCQJ6LYTZoNogu4NpF+edGmgqNXwmRet04DWyv7pP7hZfkn1oFJ
	 /djtOWXNiLpmrY688KopFycF2sOJfyS10cPwFY7VErniHtURhSgcN0QcnCRZHuKlM+
	 PFaGapg0LYwEji8+Ug67L+tEKuytxr4tJ9JICGAoZexM+82PuOTdq9pDRVMH4o9rwu
	 snXjAGpH0ZHTpeFWmjsTPn/UEIgR18AZOuP3hSMsa0DSbaBxHav3B54Q47wfVp+u88
	 G0qCzX95Qw+mah3SkhIr9MS2Ftn6Ik7T1WUEM8luslxjwSWxQ6xXiH1fsAKFNz6Uk5
	 ng1r103eHQBkA==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id ACF286E02D3;
	Fri, 26 Jan 2024 15:46:11 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: carlos@fisica.ufpr.br
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	junxiao.bi@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	song@kernel.org,
	stable@vger.kernel.org,
	yukuai1@huaweicloud.com
Subject: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Fri, 26 Jan 2024 08:46:10 -0700
Message-ID: <20240126154610.24755-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZbMnZnvyIyoWeIro@fisica.ufpr.br>
References: <ZbMnZnvyIyoWeIro@fisica.ufpr.br>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BcY4iSij5chVyVi4r0gaADDEYhZiD5Sd
X-Proofpoint-ORIG-GUID: BcY4iSij5chVyVi4r0gaADDEYhZiD5Sd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=393 spamscore=0
 malwarescore=0 mlxscore=0 clxscore=1030 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401260116

> It's known that ext4 has these symptoms with parity raid.

Interesting. I'm not aware of that problem. One of the systems that
hit this hang has been running with ext4 on an MD RAID-5 array with
every kernel since at least 5.1 and never had an issue until this
regression.

> To make sure it's a raid problem you should try another filesystem or
> remount it with stripe=0.

That's a good suggestion, so I switched it to use XFS. It can still
reproduce the hang. Sounds like this is probably a different problem
than the known ext4 one.

Thanks,

-- Dan

