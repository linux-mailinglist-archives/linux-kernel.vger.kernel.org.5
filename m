Return-Path: <linux-kernel+bounces-36825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6875E83A775
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D59DB275AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0441B5B1;
	Wed, 24 Jan 2024 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DK6Ytl6N"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED81B59F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094093; cv=none; b=HWlQ5snnRiS5b+B6pKbn2jGClvlp4jP7comg6KHcyMQ2vUdSk4ApaCFrUNoFJ9o6fK0zjdJTryJbaGHfQ0MxwMx/Ow7f1SqeVc9RjS4PEh25znJdZy2nscCBwVL0ajNE7LGDc0StzGIYKV+aCJkud7E4BtVpD8jPTmlPuDoGc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094093; c=relaxed/simple;
	bh=nXjQm9pxB4OBi7P7cQxdR6tOb1Xaf8tNG19Uf9ztXJc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRaniC9srcfU4IUOnvOZ1VzLkroqFsP+F+3cae6J6e2e7KuS9ALM4P3GChL6exR4vnlNm1R6bauzcey8T+wx46dTws7USbeO/04NXyoTLw750xDbPLlzqV19HSeFRByX94cTawwgR28UPRHS2Uj8O6uinfOzG3wFypkmM3rdcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DK6Ytl6N; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O6RXoP022084;
	Wed, 24 Jan 2024 05:01:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=Nuu5pfDsxpWyiex
	Gbs0jpfyR5a3ackAw/VZy6NSnBKY=; b=DK6Ytl6N4/+X/5MM/G1urTdYelG0JOM
	AWJ8Phn5K5e3vjamvGKGoeGLNeoDTR8SzbhlujoHl+4jieMzrq8z6GbHzCF6RQKU
	lZlDrNNV7WO37R9jtqqzJo23Ei8Nw4wE5LBr96KCn0UNjv5HaMV02qm6Fu+1hNBH
	7UIZ9ow6NDhZFg+/cia75j+Vel340+gSvwh/3u/X5tiuEeWTbmphnI2vdKi7eaQW
	ddTf/ygEt3OO1etQcQm6TOI3D7qlrsJQjhzCY7MbESSnjo1Fj9mRc7LDUN4D4+fO
	EuLs6xALo/WsZow3rrzYVLAAujEbFW2ESZpEfEInCUZ3eYZ3r64/ihA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9rpka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 05:01:22 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 11:01:20 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 11:01:20 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 82180820243;
	Wed, 24 Jan 2024 11:01:20 +0000 (UTC)
Date: Wed, 24 Jan 2024 11:01:02 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
CC: Lee Jones <lee@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3] mfd: wm831x: Remove redundant forever while
 loop
Message-ID: <ZbDt7to9i462oWlT@ediswmail9.ad.cirrus.com>
References: <20240123154259.81258-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240123154259.81258-1-mstrozek@opensource.cirrus.com>
X-Proofpoint-GUID: IiLjbf_8iiZgVZMoLOZE11uHWRLeclmh
X-Proofpoint-ORIG-GUID: IiLjbf_8iiZgVZMoLOZE11uHWRLeclmh
X-Proofpoint-Spam-Reason: safe

On Tue, Jan 23, 2024 at 03:42:59PM +0000, Maciej Strozek wrote:
> Current code excutes only once despite the while loop, so remove the
> loop. Also msleep(1) will likely result in a larger sleep, so increase
> its value for clarity while keeping the same behaviour.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

