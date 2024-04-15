Return-Path: <linux-kernel+bounces-144802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46D88A4AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DA5282D94
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DBD3C087;
	Mon, 15 Apr 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="KZuz/w9x"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4792110F;
	Mon, 15 Apr 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171191; cv=none; b=K7YJOtreNqFVQnZTEMnuWHQ1uA1BsXxgqnNn2xmU86XwLJZqVVaL9datZNAeS+vIDa0RGvMIsSInSm1OAZjpyjx9NXMP4se7g9XXJsJK6tozT+NTIy3cJcTB8TTJG4eEpk6CQ5PXfZn5TLUBjuyAR0GN+5TqmCcN1MHc3s27m7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171191; c=relaxed/simple;
	bh=8oyoBvkStTpVskCvMWBdHyeZcZ4EnMx4KxN8q9qWTwA=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=YnxbEE3bJurIApR5PiyTjuWHdtMjG52Te3jEVuAT1kuMw9Ou1FWduceC1q6jmD+bzAKhrgrS9P/WqaDfF1gD2x1qZXp0tM8L+675g5+QafS6fkLkbPkbhM4nV1inydgCLMuN37u7MXKDp3O7WEiFgXnGpQhvrUvWUH29knyGBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=KZuz/w9x reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=qYbmhSIlBOGpGAcKUkRPEkfru6Iubl4Z5Utz/vgD9RA=; b=K
	Zuz/w9xejdqUrYW9PCpWbsFuGJ80b4KjeBjpFdiyw92gjAd97CVsp5jIv+kIrvlx
	rNmJm6KxFUMSOYeSgt39YdP5DoNeDI0V2aXPm6kNGhLyQETy0YTUO6DHH1VT7Wsl
	OSrooixKaGmiGR83pPtaP12KIX/GcXdVYK4ASjdfAU=
Received: from congei42$163.com ( [159.226.94.118] ) by
 ajax-webmail-wmsvr-40-122 (Coremail) ; Mon, 15 Apr 2024 16:52:41 +0800
 (CST)
Date: Mon, 15 Apr 2024 16:52:41 +0800 (CST)
From: sicong <congei42@163.com>
To: robdclark@gmail.com, quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org, 
	sean@poorly.run, airlied@gmail.com, daniel@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Bug report: mdp5_crtc.c: use-after-free bug in mdp5_crtc_destroy
 due to race condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2aAf2cvkkt5ymdY+kfm0YUh+c7UMO5ufQh245eOpF8jDHp+jgFQWJiI0D36NmCMgW2uTm2dztV29t4WZJfeIIObVLBd41QF5OXHFqc9BGSSQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4221f7a6.ce68.18ee0f5636b.Coremail.congei42@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3vxHZ6hxml_sXAA--.15036W
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/1tbivhrB8mV4Iq35ZQAKsT
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgptZHA1X2NydGMuYzogdXNlLWFmdGVyLWZyZWUgYnVnIGluIG1kcDVfY3J0Y19kZXN0cm95IGR1
ZSB0byByYWNlIGNvbmRpdGlvbgoKSW4gbWRwNV9jcnRjX2luaXQsICZtZHA1X2NydGMtPnVucmVm
X2N1cnNvcl93b3JrIGlzIGJvdW5kIHdpdGggCnVucmVmX2N1cnNvcl93b3JrZXIuIFRoaXMgd29y
ayB3aWxsIGJlIGNvbW1pdGVkIGJ5IGRybV9mbGlwX3dvcmtfY29tbWl0IApsb2NhdGVkIGluIG1k
cDVfY3J0Y192YmxhbmtfaXJxLgoKSWYgd2UgY2FsbCBtZHA1X2NydGNfZGVzdHJveSB0byBtYWtl
IGNsZWFudXAsIHRoZXJlIG1heSBiZSBhIHVuZmluaXNoZWQgd29yay4gClRoaXMgZnVuY3Rpb24g
d2lsbCBjYWxsIGRybV9mbGlwX3dvcmtfY2xlYW51cCB0byBkZXN0cm95IHJlc291cmNlcyBhbGxv
Y2F0ZWQgCmZvciB0aGUgZmxpcC13b3JrLiBIb3dldmVyLCBkcm1fZmxpcF93b3JrX2NsZWFudXAg
d29ya3MgYXMgZm9sbG93aW5nOgpXQVJOX09OKCFsaXN0X2VtcHR5KCZ3b3JrLT5xdWV1ZWQpIHx8
ICFsaXN0X2VtcHR5KCZ3b3JrLT5jb21taXRlZCkpOwoKQWZ0ZXIgbWRwNV9jcnRjX2Rlc3Ryb3kg
Y2FsbCBrZnJlZSB0byByZWxlYXNlIHRoZSBvYmplY3QgIm1kcDVfY3J0YyIsIAombWRwNV9jcnRj
LT51bnJlZl9jdXJzb3Jfd29yayB3aWxsIGdldCB1c2UtYWZ0ZXItZnJlZSBlcnJvci4KCkNQVSAw
ICAgICAgICAgICAgICAgICAgICAgICAgICAJICAgICAgICBDUFUgMQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfAl1bnJlZl9jdXJzb3Jfd29ya2VyCm1kcDVfY3J0
Y19kZXN0cm95ICAgICAgICAgICAgfAprZnJlZShtZHA1X2NydGMpICAoZnJlZSkgICAgfAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAlnZXRfa21zKCZtZHA1X2Ny
dGMtPmJhc2UpICh1c2UpCgpUaGlzIGJ1ZyBtYXkgYmUgZml4ZWQgYnkgYWRkaW5nIHRoZSBmb2xs
b3dpbmcgaW5zdHJ1Y3Rpb25zIGluIGRybV9mbGlwX3dvcmtfY2xlYW51cC4KZmx1c2hfd29yaygm
bWRwNV9jcnRjLT51bnJlZl9jdXJzb3Jfd29yaykKCkJlc3QgcmVnYXJkcywKU2ljb25nIEh1YW5n
Cgo=

