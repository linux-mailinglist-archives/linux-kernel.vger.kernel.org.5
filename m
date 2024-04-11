Return-Path: <linux-kernel+bounces-141648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D39A8A212A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B824B210CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C83A1CB;
	Thu, 11 Apr 2024 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="BVKYmapX"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5B3D0D5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872551; cv=none; b=DV02omQCDoklkoQjHnJh6yr3Bpl6trV5nIi0qm7dk+FOXOtVujFf7WDVf/wSTJ2ODDXHwTjZjE9B2THUwXZzR1HghB3xGUKpw1NhtT0diFISKa+7Z/R2zPbgCfXuscB3kGUwRbX+5AERpeMdKucnhYzX/584uNHatFLm+d5c88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872551; c=relaxed/simple;
	bh=vYr0mKjVOQg91xmKttDAlsJb0rZr3EEjxdJu6HCZK8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWbCiND4dDvLfrykOCd9BkCALrzfujsoATkHdRi8t2qCwa2RmcFdp83NnEAj4rrVgyGeh/84koGTewdNWbTwxj4Z/xmIHyVz68c23ifydi1xt2t8VaD4LstNrzQaN4R+sp2ll+Ul7YJ9PbvqrLHVf6NuDYpmAuTwOxxXJqXgbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=BVKYmapX; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BKIY6W026336;
	Thu, 11 Apr 2024 21:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=6LYvGz0NjGEDF0F4MeQxcBfQj90O4KY8yAlAO0l0TAM=;
 b=BVKYmapXfQvRlQyCekNqfQitv6lgeNbMEYUUBSCt8iwYy0lnZec3hIdy4UMnNs4miKbT
 0b67Xdk/XMlpcdqiLUFPGkfCSGJUzwYl3A/h/wZB/nUPKxk6iP3/dpqrUqA+A/fM7tSG
 vWZAyyvUVt6wCmlCVOVaBwM0O7W8NBVt8U4t93gQ/xpHvlWSkUgLwIQaqRsDLZ2yTT1t
 RLWE1Ui7jkMRii40fOAeBqGy2yxvJHDucI/2mvw4kZ53pZC6HWvdJxWIb/G5j6+HFb1T
 cRuxWuxPAZfNr8RLStjFkaT9yPPBUoSW9yknIwZXwby/hBlPXBpLvHofHC08DAforQUq Fg== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3xepsggj4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 21:55:15 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 0F9138005F7;
	Thu, 11 Apr 2024 21:55:15 +0000 (UTC)
Received: from DESKTOP-IR8JFSN. (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 81960804027;
	Thu, 11 Apr 2024 21:55:11 +0000 (UTC)
Date: Thu, 11 Apr 2024 16:55:11 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH v2 2/2] sched/topology: Optimize topology_span_sane()
Message-ID: <ZhhcPwFCgxDUhndo@DESKTOP-IR8JFSN.>
References: <20240410213311.511470-1-kyle.meyer@hpe.com>
 <20240410213311.511470-3-kyle.meyer@hpe.com>
 <Zhe9ttm9Ppv2wT3S@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhe9ttm9Ppv2wT3S@smile.fi.intel.com>
X-Proofpoint-ORIG-GUID: jD26pNE1mOf2rkl--URvm96tOcy0NIvA
X-Proofpoint-GUID: jD26pNE1mOf2rkl--URvm96tOcy0NIvA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=574 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110158

On Thu, Apr 11, 2024 at 01:38:46PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 10, 2024 at 04:33:11PM -0500, Kyle Meyer wrote:
> > Optimize topology_span_sane() by removing duplicate comparisons.
> > 
> > Since topology_span_sane() is called inside of for_each_cpu(), each
> > pervious CPU has already been compared against every other CPU. The
> 
> previous

Thank you for pointing that out. Should I send an updated version or can
a maintainer correct my mistake?

> > current CPU only needs to be compared against higher-numbered CPUs.
> > 
> > The total number of comparisons is reduced from N * (N - 1) to
> > N * (N - 1) / 2 on each non-NUMA scheduling domain level.
> 
> Thank you, now it makes sense.

Thanks,
Kyle Meyer

