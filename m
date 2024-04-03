Return-Path: <linux-kernel+bounces-128950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1229489622F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358BA1C235D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B6C3FB09;
	Wed,  3 Apr 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OHJFRp4h"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6E3D56F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108539; cv=none; b=FUg8IL0Ig9vqWXV8MNQSr+Oo7IQAmr7KWTXjXIgUKSGu8iVLk35ITcAZkbBoKT9ZM5Kd/QX+av+UFXCu65o8G5G03kaib6nIZlQ7Zw9xlgAc0IAcSJXuM9wrNYWwzScF6tcuUVsHNFsffwEDR/9RuS//CBywAlI7qvU00zvv0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108539; c=relaxed/simple;
	bh=BveWeSxCi0loH+vKizl2LilUVLCFhaPq8UMgwWLFAsc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=gbl7EcuA/snVIr/RW118jcTxrsYHNYgrOmTOfFzvKeGhWyqmVidSI+axWaFJL/6plkjSEwXHM2ypdEwXIrQP2N31D8M7hm4WYaKPtw5DzD/OtYP6zK5M2Ch3qBa55h9g/zRPBXRgPWOs7dm4zpS63iPXI0LqbvYAeVHFi4kP4Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OHJFRp4h; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240403014209epoutp01328f195344c1763fa7ec7be7cb51e0de~CoaLqm4za1513015130epoutp01X
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:42:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240403014209epoutp01328f195344c1763fa7ec7be7cb51e0de~CoaLqm4za1513015130epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712108529;
	bh=kt3kANoeV9EnYpuxlOo6BAgqtuID6mxjSyyK3XKAQj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OHJFRp4heWisFxQeqwy5OG6sUGWpx/R2yqQdVJYKjnc7RSOU4OMTxq0YHIlxP4W1r
	 FswRNA1wrxWc7XSH6AUkmWyT0hVqyh/hp8DAmzfmQnputNoMTqC/ay+NWZmw0DeLJa
	 NhCpENK1PxvKBVD2MLW2lrFLRu8kRZz57vTuFIa8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240403014209epcas2p21d9fe0b5975795c29d82e7229cb79e3e~CoaLSy8fS0310203102epcas2p21;
	Wed,  3 Apr 2024 01:42:09 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4V8SD02r79z4x9Q8; Wed,  3 Apr
	2024 01:42:08 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C1.D7.09673.0F3BC066; Wed,  3 Apr 2024 10:42:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240403014208epcas2p4c27e6414361437cbe5a6ba6673d7058b~CoaKXSdPX0883508835epcas2p4y;
	Wed,  3 Apr 2024 01:42:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240403014208epsmtrp1bb1f4079774e3a65d555c7cbbf6c87a1~CoaKWmwnH0428504285epsmtrp1d;
	Wed,  3 Apr 2024 01:42:08 +0000 (GMT)
X-AuditID: b6c32a45-a89fa700000025c9-37-660cb3f0583e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.06.08924.FE3BC066; Wed,  3 Apr 2024 10:42:07 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240403014207epsmtip15df1b7d5d829712f2cd93eacc3465cac~CoaKMMZDy1272212722epsmtip1A;
	Wed,  3 Apr 2024 01:42:07 +0000 (GMT)
Date: Wed, 3 Apr 2024 10:42:07 +0900
From: Bongkyu Kim <bongkyu7.kim@samsung.com>
To: John Stultz <jstultz@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, bongkyu7.kim@samsung.com
Subject: Re: [PATCH v2 0/2] Make reader optimistic spinning optional
Message-ID: <20240403014207.GA499@KORCO045595.samsungds.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANDhNCpvKj6Swer-8DtQEotdnOiqfAg43oZLw_HZs6ogwqPwzg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmue6HzTxpBtMXiVi8bnzJZLFmSyOT
	RfPi9WwWf05sZLO4vGsOm8XpYydYLC4dWMBkcbz3AJNFyx1TB06PnbPusnss2FTqsXmFlsem
	VZ1sHvvnrmH3eL/vKptH35ZVjB6fN8kFcERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
	6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
	KTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM749GQdY8F8uYol154yNTBOF+1i5OSQEDCReHB7
	MlsXIxeHkMAORonV/3YxQTifGCVa751mhHC+MUrcaTzADtOy799OqKq9jBL3/71igavaeGUq
	cxcjBweLgIrE5yNaIA1sAjoS/1fPYAKxRYDCD+f+BNvHDNJ84cMlZpCEsICLRNv39YwgNq+A
	jcSEcxOhbEGJkzOfsIDYnAKBEo1334I1Swgs5ZBYuLKdCeIkF4ljv1qhzhOWeHV8C5QtJfGy
	vw3KLpaY+BLkOJDmBkaJptfbWSASxhKznrWDbWMWyJCY+fY/E8gHEgLKEkdusUCE+SQ6Dv9l
	hwjzSnS0CUF0qknsft7KCmHLSBw8uxbqHA+JawcnQ0PoEpNE7+9r7BMY5WYh+WcWkm2zgMYy
	C2hKrN+lDxGWl2jeOpsZIiwtsfwfB5KKBYxsqxjFUguKc9NTi40KDOGxnZyfu4kRnHC1XHcw
	Tn77Qe8QIxMH4yFGCQ5mJRHen96caUK8KYmVValF+fFFpTmpxYcYTYHxNJFZSjQ5H5jy80ri
	DU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYAqI99xlr3RV6vVtd/7/
	el9iEhy/d28RNfh0b33tZlf1diGrr4Yu6ff2cWaJ/2SSO2P1Y7OOxOutHw98TDGz40xq+Lvk
	dXri12d3dhw6+3tvpDxTONeestcG+5aWrDlf/+Q3W5ubxuyNtRf5rZ8JdtfxbP671U7F/qzJ
	g3WlZlPS5I9d2D+7cfrLd1xGJa09rgyPWKUYS8NEqtruRbaeN904Nypjol3tku8TObepfRRe
	fH7Z5oq578v89I8vX+64Zam46sXCEyXvbV+/q1Ddnn8t3++dqDFT+N26BWfenziWvfc0+1XP
	W7PzuUUeqq4MmrI+hKVAQatNjCVpRm5BZID1omnHtwiyKFkUC6blr1ViKc5INNRiLipOBAAN
	9jtNQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJTvf9Zp40g/3brC1eN75kslizpZHJ
	onnxejaLPyc2sllc3jWHzeL0sRMsFpcOLGCyON57gMmi5Y6pA6fHzll32T0WbCr12LxCy2PT
	qk42j/1z17B7vN93lc2jb8sqRo/Pm+QCOKK4bFJSczLLUov07RK4Mk7cPMxUcFC64ubmPtYG
	xqtCXYycHBICJhL7/u1k6mLk4hAS2M0o8ayniQkiISNx6N9aKFtY4n7LEVaIoi+MEpcX/mXs
	YuTgYBFQkfh8RAukhk1AR+L/6hlg9SJA4Ydzf7KB1DML7GeU6L6yghkkISzgItH2fT0jiM0r
	YCMx4dxERoihl5gkDkw4zw6REJQ4OfMJC4jNLKAu8WfeJWaQZcwC0hLL/3FAhOUlmrfOBpvJ
	KRAo0Xj3LdsERsFZSLpnIemehdA9C0n3AkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5
	uZsYwZGkpbmDcfuqD3qHGJk4GA8xSnAwK4nw/vTmTBPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	K/6iN0VIID2xJDU7NbUgtQgmy8TBKdXANH319QvGa98uTQjKaf116+u7Py9etUtbl05f+mJl
	bKKT330j2+o71wTS7ux7MuW+1fFPHD/fykx5HbqrKCZ2fYml69vOy3kbl8jJbZVe+M42yk6M
	z1TsfvytoxMX8LDs+v9e/ePfRxl3d65+6FtWnf/Z+YnNpI/fJsR8N7Fg8l3a2pf1QED4uQgb
	z+GbBk6SE+ZWrviZon2waM5Sq6cH2N8IvwkxzBE+UjF54oHCGzrKJSWb73sem2Z4Lfdu6JVI
	/hSvZe6PJAr9rrovnPzsM3P4V/Uz7JxGk5c9fvS0+rKve9IrUZW+nJPzlBoOzTXz81VIy1HR
	N/b4cFnSXPBzeONJi2VMro+DuD6WXd21/ZISS3FGoqEWc1FxIgCTxerAEwMAAA==
X-CMS-MailID: 20240403014208epcas2p4c27e6414361437cbe5a6ba6673d7058b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----9D_2.EQ5cGIhcMb2E9QR8GFUB51-NQQYsO-rsNzGreYF.8HD=_b7a51_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230901010734epcas2p4aadced02d68d3db407fda23de34601d2
References: <CGME20230901010734epcas2p4aadced02d68d3db407fda23de34601d2@epcas2p4.samsung.com>
	<20230901010704.18493-1-bongkyu7.kim@samsung.com>
	<CANDhNCoFRr=qizswLm-dzxJK0fHuCx98Z2B1pUspdwGqBEejYg@mail.gmail.com>
	<20240403012132.GA460@KORCO045595.samsungds.net>
	<CANDhNCpvKj6Swer-8DtQEotdnOiqfAg43oZLw_HZs6ogwqPwzg@mail.gmail.com>

------9D_2.EQ5cGIhcMb2E9QR8GFUB51-NQQYsO-rsNzGreYF.8HD=_b7a51_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tue, Apr 02, 2024 at 06:27:40PM -0700, John Stultz wrote:
> On Tue, Apr 2, 2024 at 6:21 PM Bongkyu Kim <bongkyu7.kim@samsung.com> wrote:
> > On Tue, Apr 02, 2024 at 04:46:06PM -0700, John Stultz wrote:
> > > On Thu, Aug 31, 2023 at 6:07 PM Bongkyu Kim <bongkyu7.kim@samsung.com> wrote:
> > > >
> > > > This is rework of the following discussed patch.
> > > > https://lore.kernel.org/all/20230613043308.GA1027@KORCO045595.samsungds.net/
> > > >
> > > > Changes from the previous patch
> > > > - Split to revert and modify patches
> > > > - Change according to Waiman Long's review
> > > >     More wording to documentation part
> > > >     Change module_param to early_param
> > > >     Code change by Waiman Long's suggestion
> > > >
> > > > In mobile environment, reader optimistic spinning is still useful
> > > > because there're not many readers. In my test result at android device,
> > > > it improves application startup time about 3.8%
> > > > App startup time is most important factor for android user expriences.
> > > > So, re-enable reader optimistic spinning by this commit. And,
> > > > make it optional feature by cmdline.
> > > >
> > > > Test result:
> > > > This is 15 application startup performance in our exynos soc.
> > > > - Cortex A78*2 + Cortex A55*6
> > > > - unit: ms (lower is better)
> > > >
> > > > Application             base  opt_rspin  Diff  Diff(%)
> > > > --------------------  ------  ---------  ----  -------
> > > > * Total(geomean)         343        330   -13    +3.8%
> > > > --------------------  ------  ---------  ----  -------
> > > > helloworld               110        108    -2    +1.8%
> > > > Amazon_Seller            397        388    -9    +2.3%
> > > > Whatsapp                 311        304    -7    +2.3%
> > > > Simple_PDF_Reader        500        463   -37    +7.4%
> > > > FaceApp                  330        317   -13    +3.9%
> > > > Timestamp_Camera_Free    451        443    -8    +1.8%
> > > > Kindle                   629        597   -32    +5.1%
> > > > Coinbase                 243        233   -10    +4.1%
> > > > Firefox                  425        399   -26    +6.1%
> > > > Candy_Crush_Soda         552        538   -14    +2.5%
> > > > Hill_Climb_Racing        245        230   -15    +6.1%
> > > > Call_Recorder            437        426   -11    +2.5%
> > > > Color_Fill_3D            190        180   -10    +5.3%
> > > > eToro                    512        505    -7    +1.4%
> > > > GroupMe                  281        266   -15    +5.3%
> > > >
> > >
> > > Hey Bongkyu,
> > >   I wanted to reach out to see what the current status of this patch
> > > set? I'm seeing other parties trying to work around the loss of the
> > > optimistic spinning functionality since commit 617f3ef95177
> > > ("locking/rwsem: Remove reader optimistic spinning") as well, with
> > > their own custom variants (providing some substantial gains), and
> > > would really like to have a common solution.
> > >
> >
> > I didn't get an reply, so I've been waiting.
> > Could you let me know about their patch?
> 
> I don't have insight/access to any other implementations, but I have
> nudged folks to test your patch and chime in here.
> 
> Mostly I just wanted to share that others are also seeing performance
> trouble from the loss of optimistic spinning, so it would be good to
> get some sort of shared solution upstream.
> 
> thanks
> -john
> 

Thanks for your sharing!
Bongkyu.

------9D_2.EQ5cGIhcMb2E9QR8GFUB51-NQQYsO-rsNzGreYF.8HD=_b7a51_
Content-Type: text/plain; charset="utf-8"


------9D_2.EQ5cGIhcMb2E9QR8GFUB51-NQQYsO-rsNzGreYF.8HD=_b7a51_--

