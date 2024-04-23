Return-Path: <linux-kernel+bounces-154467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C7D8ADC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BB31C21A08
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A041C6A0;
	Tue, 23 Apr 2024 03:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IJFGHH3x"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527ED1C290
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843829; cv=none; b=G2jPE8kuEOCgzxz2ngVMzlqsnaVyCbuTzRHy2rGfA5PfeRqEsDwtZCQTcl8xTty0mdd1YvvI4Zg5GaMadvpWcAo78z5G9IWhEmJx25VTfLUbc80zUEvXhvAXRecuESYja3JmUYnuutSJinyQWjQ4hkZZH11re6SrkMj+SpZAmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843829; c=relaxed/simple;
	bh=iInm7+zNta96li8+Ll+B1j4wbBOQekmHlKm5lzeH6uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=sijGgqy5JiWAtV6NAzKlu5cSvoaLIDBKcrDHwv+z+fXZ/ZE5f5Ijr0Y1eLYZZ5G/MuRJFWowmJGbxIqm1ixujT1Opu0XKxaX8UIUJzJKwST+1K1vuMWgzlkOx7URMPhAZR9GlOA9glNIRsZ9p34P1zY/daJBL9Me0baCbzx1Oe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IJFGHH3x; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240423034343epoutp038a0333bc4807763b799d6c4825c97844~Iy_Cm_ZZz0854208542epoutp03W
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:43:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240423034343epoutp038a0333bc4807763b799d6c4825c97844~Iy_Cm_ZZz0854208542epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713843823;
	bh=jzsAYpAu0Vx01jiFCrcJGQatfTygwvtPpYTDPDR/hlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJFGHH3xTDTvFdFezDVAPGTiawyg35yiGgTgTU1PKthxg7xRbSXbcIEGIRHGtuXTW
	 45UozvT7P1IKnjfcJRqRJE/x0DhUOsGqTgggGlPLffC95eknQO3dU9fqMhrMGRDHAW
	 xbHwuB+p9oR/a3UQrWwB8se3VvBaVn/f4LHipSuA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240423034343epcas5p16ce42ad4af9b770b90c7f97e204626a6~Iy_CCXUKT0740507405epcas5p1I;
	Tue, 23 Apr 2024 03:43:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VNnz14hjlz4x9Pw; Tue, 23 Apr
	2024 03:43:41 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.F7.09688.D6E27266; Tue, 23 Apr 2024 12:43:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240423033155epcas5p315a8e6ea0114402afafed84e5902ed6b~IyzulEt-b1550215502epcas5p3Y;
	Tue, 23 Apr 2024 03:31:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240423033155epsmtrp2e8163bd260b9e4ab42d25af652aef3aa~IyzujGIHn1760817608epsmtrp2X;
	Tue, 23 Apr 2024 03:31:55 +0000 (GMT)
X-AuditID: b6c32a4a-837fa700000025d8-0b-66272e6dbb10
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	82.20.08390.BAB27266; Tue, 23 Apr 2024 12:31:55 +0900 (KST)
Received: from testpc11818.samsungds.net (unknown [109.105.118.18]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240423033153epsmtip1ea898b3ee7964f26e06650dd3a45492c~Iyzs_6vNY2149021490epsmtip1F;
	Tue, 23 Apr 2024 03:31:53 +0000 (GMT)
From: hexue <xue01.he@samsung.com>
To: ammarfaizi2@gnuweeb.org
Cc: anuj20.g@samsung.com, asml.silence@gmail.com, axboe@kernel.dk,
	cliang01.li@samsung.com, io-uring@vger.kernel.org, joshi.k@samsung.com,
	kundan.kumar@samsung.com, linux-kernel@vger.kernel.org,
	peiwei.li@samsung.com, ruyi.zhang@samsung.com, wenwen.chen@samsung.com,
	xiaobing.li@samsung.com, xue01.he@samsung.com
Subject: Re: Re: [PATCH v2] io_uring: releasing CPU resources when polling
Date: Tue, 23 Apr 2024 11:31:47 +0800
Message-Id: <20240423033147.2547016-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAFBCWQJAjef4AGXmVDZ-dR02zqstpXuP_mWimsF5HQCMxxeCcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmpm6unnqawatueYsbv9cyWTRN+Mts
	MWfVNkaL1Xf72SxO/33MYvGu9RyLxdH/b9ksfnXfZbTY+uUrq8XlXXPYLJ7t5bT4cvg7u8XZ
	CR9YLaZu2cFk0dFymdGi68IpNgcBj52z7rJ7HJi2g9Xj8tlSj74tqxg9Pm+SC2CNyrbJSE1M
	SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpYSaEsMacUKBSQ
	WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8XvRPPaC
	lWwVy6csYG1gPMPSxcjJISFgItH86iNjFyMXh5DAbkaJYycfMIEkhAQ+MUo0vq2DSHxjlPhw
	/w0jTMeljvvMEIm9jBKffp9gh3B+MEp8nDUDbC6bgJLE/i0fgDo4OEQEpCVubrcFqWEWOMAk
	sXzPC3aQuLCAl8TbXieQchYBVYkpk0+BtfIKWEvs3r+ZDWKZvMTNrv3MIDanQKDE3usrmCFq
	BCVOznwCVs8MVNO8dTbYQRICazkk5h3ewwzR7CKxbM9GKFtY4tXxLewQtpTE53d7oRbkS0z+
	vh7qsxqJdZvfQcPFWuLflT0sIHcyC2hKrN+lDxGWlZh6ah0TxF4+id7fT5gg4rwSO+bB2EoS
	S46sgBopIfF7wiJWCNtD4ueSt9CwWsIo0bt5PtMERoVZSP6ZheSfWQirFzAyr2KUTC0ozk1P
	LTYtMMpLLYdHcnJ+7iZGcCLW8trB+PDBB71DjEwcjIcYJTiYlUR4f/1RSRPiTUmsrEotyo8v
	Ks1JLT7EaAoM8InMUqLJ+cBckFcSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoR
	TB8TB6dUA9PGBO4gAwbHE9sdClL97ee5pKpyiRqfP/XX/d6/P7pZ+vF8p3Y+y19m+fVp0gYr
	b6/p26YyNEpLyZzgMBR17Ek7be3uHfCXfwWnv0O/m8cpNYGHgSJ7tvgXSn1OOiRYtOlmnFSD
	as6PqAc3SwVeTiyPmRvfruIhVS2QtDisukmHUfqem5Oy81e/ZWsShRrl7vtO8jib27H/VviK
	3qftnw23T3u92vB6zH85f86Z86Me822b2B7yJzxxyuzO6FeWFp9PTU+Uccp+zayjEfCnpHjm
	Gq3gl6Jmf2eXxyUsnsYf6HP3d7MWz8+90e2dSVx86S3914pFFtzlf/Ky5GSDwFrNlnb5iD8M
	b2tWfPurxFKckWioxVxUnAgAwEckjU0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnO5qbfU0g/ZzrBY3fq9lsmia8JfZ
	Ys6qbYwWq+/2s1mc/vuYxeJd6zkWi6P/37JZ/Oq+y2ix9ctXVovLu+awWTzby2nx5fB3douz
	Ez6wWkzdsoPJoqPlMqNF14VTbA4CHjtn3WX3ODBtB6vH5bOlHn1bVjF6fN4kF8AaxWWTkpqT
	WZZapG+XwJXxe9E89oKVbBXLpyxgbWA8w9LFyMkhIWAicanjPnMXIxeHkMBuRonLb9oYIRIS
	Ejse/WGFsIUlVv57zg5iCwl8Y5Q48cAbxGYTUJLYv+UDUD0Hh4iAtMTN7bYgc5gFLjBJPL66
	ixkkLizgJfG21wmknEVAVWLK5FNge3kFrCV279/MBjFeXuJm135mEJtTIFBi7/UVzBCrAiTW
	LVvCDFEvKHFy5hOwXmag+uats5knMArMQpKahSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5x
	aV66XnJ+7iZGcKRoae1g3LPqg94hRiYOxkOMEhzMSiK8v/6opAnxpiRWVqUW5ccXleakFh9i
	lOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXAJJBR2Z/At/DHnjQHv4Vvbs69cedFV8Yx
	pa9Tup3i9j3/+MJyw+4HrFu286yrXhAk1ndWbsrMPOvDbF+vrDj+gFnt4yVnk9k/M+/sYNdK
	fHzn18EMDamoUi2Lo4sXKNktnSRv+PhERol5Ac+2tfF3RVtmv1nEqNAr19bjcfC2VsC1KU43
	r/09ef7fhxUiGtx7GQ6pzjcP9ijRFtZtlY+98n17wfnjytfNLDIMDtS8tE9QZ1g7d+GiDd0s
	Bm6Z6gudtr7ZalOw8+9bIYkT597sSgqfIqnsslV1i2tWT9nrv1t3P/j1lGWjjMOdzQlFIkKM
	H5I32M9sm1XMM0X84cu55VKHleO3O2z3r/u97Y9HTowSS3FGoqEWc1FxIgCJaeT6AwMAAA==
X-CMS-MailID: 20240423033155epcas5p315a8e6ea0114402afafed84e5902ed6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240423033155epcas5p315a8e6ea0114402afafed84e5902ed6b
References: <CAFBCWQJAjef4AGXmVDZ-dR02zqstpXuP_mWimsF5HQCMxxeCcg@mail.gmail.com>
	<CGME20240423033155epcas5p315a8e6ea0114402afafed84e5902ed6b@epcas5p3.samsung.com>

On Mon, Apr 19, 2024 at 16:09 Ammar Faizi wrote:
>On Fri, Apr 19, 2024 at 3:47 PM hexue wrote:
>> +void init_hybrid_poll_info(struct io_ring_ctx *ctx, struct io_kiocb *req)
>> +{
>> +       u32 index;
>> +
>> +       index = req->file->f_inode->i_rdev;
>> +       struct iopoll_info *entry = xa_load(&ctx->poll_array, index);
>> +
>> +       if (!entry) {
>> +               entry = kmalloc(sizeof(struct iopoll_info), GFP_KERNEL);
>> +               entry->last_runtime = 0;
>> +               entry->last_irqtime = 0;
>> +               xa_store(&ctx->poll_array, index, entry, GFP_KERNEL);
>> +       }
>
>GFP_KERNEL may fail; you must check for failure. Otherwise, it could
>lead to NULL pointer dereference.
>

yes, thanks for your correction, I will fix this and resubmit v3 patch.

