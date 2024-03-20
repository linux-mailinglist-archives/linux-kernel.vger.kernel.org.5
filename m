Return-Path: <linux-kernel+bounces-108280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CB18808B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B161C21C90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6F815C3;
	Wed, 20 Mar 2024 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ts01ML99"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9A10E9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895783; cv=none; b=iG4QFeACioSLy6Ng4cULM1O3B3FF5LjlQVoiu8ku6awLRQcbIVpVmgx6+643Snp0NHtYTtOWMSVMIP1uUo9uOgrtmYPa/ZX5aCe9VMlRFaPRrfeX4ni/1eGB4UCisj4GSZip0tHNHXv5p6QXrCWFp7PUnuRKXrYwvfOClmhXFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895783; c=relaxed/simple;
	bh=ERVtS46WeUubUziYLbTp6DRCLkiyt+pu3gjQPBSpKD4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=sMmPNQbKrEkiodTj3PwZxK6mr2d98VHpUq7IJjfJBGFdzU2rWVk+f/JaHy2Ji+lI13o4kFJ9hTcwKJ56JDslIggiYsSUAmWpU+Ahp8Ab0dODCdRazHiZZVCg5/HIMl8bD+IrMIAkHyDCmMrRzBX01/qmHcG1PaFN6GksNARfZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ts01ML99; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240320004933epoutp020b150bf52a8fbc17f742163b1d5b7f9d~_UqQNmUwK1726217262epoutp02M
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:49:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240320004933epoutp020b150bf52a8fbc17f742163b1d5b7f9d~_UqQNmUwK1726217262epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710895773;
	bh=VpzjF0qh5NjxrbLO1pfq2OCm/9xagT5oGFlM8kOGkmo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ts01ML99LUTFY7f/jLYCuwfoEofd+zqGImQ+3Oq3D2Vxjo/gwmHQ53Su+gPX1fsdq
	 6EENDiE7qBfgi8DgwwMzP1lyNt9BANBnuLVLONp8GvABUpYssS6E2vN99fFLs+k3k/
	 4r2bBnuDG9obTM+witOfxgeI1RM5HiF7qz5BL14w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240320004932epcas2p3945220f7bc1e27524c58948e93f69d4e~_UqP0vgW60173201732epcas2p3P;
	Wed, 20 Mar 2024 00:49:32 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Tzqjm1vrCz4x9Pv; Wed, 20 Mar
	2024 00:49:32 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	DC.97.09639.C923AF56; Wed, 20 Mar 2024 09:49:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240320004931epcas2p45e52ca36be366e939d955328dbc669af~_UqPKeSGr0836708367epcas2p4D;
	Wed, 20 Mar 2024 00:49:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240320004931epsmtrp2db333263e58585f51908abdc1f7adcee~_UqPJ2zus2082220822epsmtrp2X;
	Wed, 20 Mar 2024 00:49:31 +0000 (GMT)
X-AuditID: b6c32a46-8ddfa700000025a7-a8-65fa329c5503
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.66.08924.B923AF56; Wed, 20 Mar 2024 09:49:31 +0900 (KST)
Received: from KORCO121695 (unknown [10.229.18.202]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240320004931epsmtip15aba2402f24312054e5e51e5bb0ddec4~_UqPByw1c2365923659epsmtip1e;
	Wed, 20 Mar 2024 00:49:31 +0000 (GMT)
From: "bumyong.lee" <bumyong.lee@samsung.com>
To: "'Linux regressions mailing list'" <regressions@lists.linux.dev>
Cc: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban@linumiz.com>, <saravanan@linumiz.com>, "'karthikeyan'"
	<karthikeyan@linumiz.com>, <vkoul@kernel.org>
In-Reply-To: <07b0c5f6-1fe2-474e-a312-5eb85a14a5c8@leemhuis.info>
Subject: RE: dmaengine: CPU stalls while loading bluetooth module
Date: Wed, 20 Mar 2024 09:49:31 +0900
Message-ID: <001001da7a60$78603130$69209390$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMwipOl/cAOi38P2p1VCUOGtvzp0QMWgtoHAULg3K4CqzIErAEiRasjAoYUeeCuPkDJsA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmue4co1+pBnt+8FisnvqX1WLHak2L
	y7vmsFnsvv2H1WLj2w52i3d7FC123jnB7MDusWlVJ5vH9s+n2D1ebJ7J6PF5k1wAS1S2TUZq
	YkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QfiWFssScUqBQ
	QGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbW3SdZ
	Cy6xVZw50cfWwDiPtYuRk0NCwETizPZHTF2MXBxCAjsYJd5NWQPlfGKU+PTlOBuE841RYvqa
	CywwLTMWnWaBSOxllOhcMJcZwnnJKDH/yTo2kCo2AV2JmS8PgnWICLhITJrXDjaKWWALo8S1
	rUsYQRKcAo4Ss25OYAKxhYHs3kkTwK5iEVCVWP7oEZjNK2Ap0bCwDcoWlDg58wnYUGYBeYnt
	b+cwQ5ykIPHz6TJWiGVhErv2L2eDqBGRmN3ZBnadhEAnh8Sr3Z+hGlwkmm9NYoOwhSVeHd/C
	DmFLSXx+txcqni8xc84NqJ9rJL7e+wcVt5dYdOYnUD0H0AJNifW79EFMCQFliSO3oE7jk+g4
	/JcdIswr0dEmBGGqSjTdrIeYIS2x7MwM1gmMSrOQ/DULyV+zkNw/C2HVAkaWVYxiqQXFuemp
	xUYFRvDITs7P3cQITppabjsYp7z9oHeIkYmD8RCjBAezkggvO/fPVCHelMTKqtSi/Pii0pzU
	4kOMpsCQnsgsJZqcD0zbeSXxhiaWBiZmZobmRqYG5krivPda56YICaQnlqRmp6YWpBbB9DFx
	cEo1MDnttHG2mLamYN9F9wKNGS1qNqd/1+Uyna3uq1Rf5Ca08eT2mPqNuvzx/5T5/s7wmaX/
	/5n6TNn5k89oHeE4wMzN83Lhbckgp802HkwrDhwtfMbJ9V/xRdjrzsxwpZLzL478fSX1Wr1R
	4/Qd365W2/Sfd2ec33/w8KFdxqEFL8K/2sRklW9aa2U9SzpSc0HokmjvKxqnXv1dHx3yKzCw
	WzXO5UrGuqlC8te1z0dJvTt45b5bqE5tB0/8gz+/Xr56w8lv9vPtqxAdK3GVAntt9WwFt6e/
	ja48X3JZpoz1VI3Xii6R3Afviw8aPTi+7vLm2entmzc6n4mvYLi9ISpq04bfaWf2m61Mzeq9
	e+VaSpQSS3FGoqEWc1FxIgC5NHaTIwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnO5so1+pBmdvG1msnvqX1WLHak2L
	y7vmsFnsvv2H1WLj2w52i3d7FC123jnB7MDusWlVJ5vH9s+n2D1ebJ7J6PF5k1wASxSXTUpq
	TmZZapG+XQJXxtbdJ1kLLrFVnDnRx9bAOI+1i5GTQ0LARGLGotMsXYxcHEICuxklGvu6WSAS
	0hIvWr9BFQlL3G85wgpR9JxRYte2dkaQBJuArsTMlwfBGkQEXCQmzWtnAyliFtjFKLH39jtm
	iI5rTBK9v2Yzg1RxCjhKzLo5gQnEFgayeydNAFvBIqAqsfzRIzCbV8BSomFhG5QtKHFy5hOw
	DcwC2hK9D1sZIWx5ie1v5zBDnKcg8fPpMlaIK8Ikdu1fzgZRIyIxu7ONeQKj8Cwko2YhGTUL
	yahZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjiItzR2M21d90DvEyMTB
	eIhRgoNZSYSXnftnqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZ
	Jg5OqQYm51e602Ym23IGaAW9+ZJeWfefWU19isNinSUMH2Xe8TgHMc6y6frBe6LhTfaSgqV3
	uPYmvb8x0U638nl80JtffdIsAe1XZdj0XoSWS/z5aH/hsdnXatmy6IyD3yr+XuOa61T/+1VO
	3fNjV+vUpU/rK667cmBFOYv7E2ab1mszU3JtzG/rbfR6p2OoPGvaprsmxanh6vqxPPkyFpPY
	/1rrOUYpG9Qf+Kj44tKOJ2p6eXrTDvrICjRUarov5lPm+Dlpc/BtEYmn8wKmspv8cls6f6fm
	vaJ9b3JeVJY2WOT/ufLgQ/9e74Oqn52fP3+zZt/3mdxXLfaL2r5viw2VYs72SesWsykNlLC4
	ffqL4EYlluKMREMt5qLiRAAF6GL3EQMAAA==
X-CMS-MailID: 20240320004931epcas2p45e52ca36be366e939d955328dbc669af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb
References: <CGME20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb@epcas2p1.samsung.com>
	<1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>
	<000001da6ecc$adb25420$0916fc60$@samsung.com>
	<12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>
	<000001da7140$6a0f1570$3e2d4050$@samsung.com>
	<07b0c5f6-1fe2-474e-a312-5eb85a14a5c8@leemhuis.info>

Hello.

> >> Hmmm. 6.8 final is due. Is that something we can live with? Or would
> >> it be a good idea to revert above commit for now and reapply it when
> >> something better emerged? I doubt that the answer is "yes, let's do
> >> that", but I have to ask.
> >
> > I couldn't find better way now.
> > I think it's better to follow you mentioned
> 
> 6.8 is out, but that issue afaics was not resolved, so allow me to ask:
> did "submit a revert" fell through the cracks or is there some other
> solution in the works? Or am I missing something?

"submit a revert" would fix the issue. but it would make another issue
that the errata[1] 719340 described.

Sometimes dma wouldn't work well when issueing dma_issue_pending()
after dma_terminate()

Best regards

[1]: https://developer.arm.com/documentation/genc008428/latest


