Return-Path: <linux-kernel+bounces-137540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4E089E39D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2BB284CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F0A1581F3;
	Tue,  9 Apr 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="RcCMPlEG"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFF157A64
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690994; cv=none; b=NdjuhcMFw7xW7EZlzAwonPSbt5TNW5Bxhl3Ks58hJQKxn/hSpJXWuoZgUIqJIUByPeG0KgsqCmF4CE1oAkqSzhCqzQPD1wQ+xPn5MAtm/YR13fy3pzQxMzsgtUtGy7Ea4N6DqUIKhTO82EzdMXgSD1tu7AHBLNkEBhzhNs1GVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690994; c=relaxed/simple;
	bh=LiSFGMCSSKnYkf60jiFM/yhu/QxWYBrFCaoEop90N+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPRRF67buixZiynlX6fQERSDJgj0cSjnHDVTMnDdma/07URH9C3UwCBUGiShPkYDli2U9k0B4NZmCkHzxTJkB44zhhX0k+jshurzIXMqwFY7aY9qABUQEU5+t/mMQ9LSxwEt/pso+RXpfEA5vBTlTCDOvi7KhpTF1kg0dzMTavM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=RcCMPlEG; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439HWgCR000982;
	Tue, 9 Apr 2024 19:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=hehvBNt/chTmd8Q6DSxolfy+ZHmK0w/V9CNvPAEMrxg=;
 b=RcCMPlEGPqOtkUgjfojjte4EoONnypYOQlHUJDbbbj5j4rzSHkfVUEGeM7crNUkf5BH/
 tlOx71gQUP1OOIykDo+TcVAE18mz4mQLvYljFE/0ZGw6sC0qFNvmoqyJ0Va8b8LVJ/Ic
 t6jcg5Ylml0nY/BKfK/rBhVyiOgnl8ytF+UbmOUcwofzC4EnoKlz5HatLe+J1se8W1z4
 Ykp9eBcrNIjYysG5U3cXRyu3YROcZRBp5TvvphEBxrEYn/W9Pg2KZKpmkjz4vn6N9lH+
 5MjeGC2fq4ojapXXYwXloRMm+MnkIaAh9fSVMH6IH9aWCdliSg5zUV047DBaCxxL1/r/ Fw== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3xd7bc2euv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 19:29:18 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 0FD3B2766A;
	Tue,  9 Apr 2024 19:29:17 +0000 (UTC)
Received: from DESKTOP-IR8JFSN. (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 487C480036C;
	Tue,  9 Apr 2024 19:29:12 +0000 (UTC)
Date: Tue, 9 Apr 2024 14:29:09 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH 2/2 RESEND] sched/topology: Optimize topology_span_sane()
Message-ID: <ZhWXBSMDPKThcLsY@DESKTOP-IR8JFSN.>
References: <20240409155250.3660517-1-kyle.meyer@hpe.com>
 <20240409155250.3660517-3-kyle.meyer@hpe.com>
 <ZhVr4i5F1uWyrJ15@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhVr4i5F1uWyrJ15@smile.fi.intel.com>
X-Proofpoint-GUID: X8cln8Q1nqgEPKVNFQ84NJX0FsTL3gtw
X-Proofpoint-ORIG-GUID: X8cln8Q1nqgEPKVNFQ84NJX0FsTL3gtw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=741 suspectscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090129

On Tue, Apr 09, 2024 at 07:25:06PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 09, 2024 at 10:52:50AM -0500, Kyle Meyer wrote:
> > Optimize topology_span_sane() by removing duplicate comparisons.
> > 
> > The total number of comparisons is reduced from N * (N - 1) to
> > N * (N - 1) / 2 (per non-NUMA scheduling domain level).
> 
> ...
> 
> > -	for_each_cpu(i, cpu_map) {
> > -		if (i == cpu)
> > -			continue;
> > +	for_each_cpu_from(i, cpu_map) {
> 
> Hmm... I'm not familiar with the for_each_cpu*(), but from the above
> it seems only a single comparison? Or i.o.w. can i ever repeat the value?

for_each_cpu() is a macro around for_each_set_bit() which iterates over each set
bit in a bitmap starting at zero.

for_each_cpu_from() is a macro around for_each_set_bit_from() which iterates
over each set bit in a bitmap starting at the specified bit.

The above (topology_span_sane()) currently does a "single comparison" for each
CPU in cpu_map, but it's called for each CPU in cpu_map and for each scheduling
domain level (please see build_sched_domains() in kernel/sched/topology.c).

> And what about i < cpu cases?

Those values have already been passed to topology_span_sane(). This patch uses
for_each_cpu_from() starting at cpu + 1 to prevent those duplicate comparisons.

Thanks,
Kyle Meyer

