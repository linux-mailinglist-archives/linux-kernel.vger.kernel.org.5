Return-Path: <linux-kernel+bounces-55614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C284BEFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DB31F22FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA01B94A;
	Tue,  6 Feb 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="HdcuQ4zV"
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A171B810
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252965; cv=none; b=T0iyD4Dbz6M0fOKgJDv62FuE5xVhbO9C6I/k+ee+G1dNs1RqT2nArjhWhtGpRU3SC7BbjATG+BijVFZSZZmG2NA4fYVFzCv1euSBtXbIinuCBZmrIIlpLpOm722uubTgMtoTON3xwZGdnQSS8UIPawM7yHYpW8szEyAKfji8eEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252965; c=relaxed/simple;
	bh=2xm3AT/eRSxwqdNOftMIryVkwU+qLY7viqygWB+r4Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oi6Gfe7mRGdRct6wgq0iOZXSorLsZFGtyHzBl5vnBBZ6KNMhS8at6wzVCPSX7FO4mL/rdiUkG6laTUwCwZpU2k/rfYqgptWoVg/2PtnPBqccJMBYySpPOuDxf0SNDt0VwWGMLcaufmoPwaP2RWpZlvNbzCuIW+6T6hub91OhO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=HdcuQ4zV; arc=none smtp.client-ip=17.58.23.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1707252963; bh=9ZmzGBmNVTa/8kwYBxGy8hTi1lwybR+HgPQFnfk+Pp0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HdcuQ4zVg41Gc0d4hEPK19pUUvu8IsCu2yFIrX/oo1b4z2bWLQxZ+9LQsTY4jMxfL
	 5JsHo1MJzANr48dqcSUOMn9bCoqanZsGU5wSZ0Nb2WXlYnskpeLtlvuVAOdE+dKo2a
	 BEGznsW6rTjsNb8x5ljfBNvMgQcGsAd5oH0r2j4uTIdnCYlq9fijjW8DMNZ630ckR3
	 WEEKT43hYJi6eKWgdWRjdxob/dWcLVzw8fYFgII3U6BYwAYp1uW131gzZ7RLqa6CDa
	 n2CvNNI3Tahqg+jgWMUzBHLsw8AeHizlURNvncHIIZThP/JAu2Pp/pV0dRzoYYyXfA
	 ElCNIQfNOfnCQ==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id 110BA6E0369;
	Tue,  6 Feb 2024 20:56:01 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: song@kernel.org
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	junxiao.bi@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	yukuai1@huaweicloud.com
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Tue,  6 Feb 2024 13:56:00 -0700
Message-ID: <20240206205600.20788-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPhsuW58VdmZwigxP6t_fstkSDb34GB9+gTM0Sziet=n17HzQg@mail.gmail.com>
References: <CAPhsuW58VdmZwigxP6t_fstkSDb34GB9+gTM0Sziet=n17HzQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1PwEXQiIHZiZPEsu5x6_2YSUNe4Yw20j
X-Proofpoint-ORIG-GUID: 1PwEXQiIHZiZPEsu5x6_2YSUNe4Yw20j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 adultscore=0 clxscore=1030 malwarescore=0 mlxlogscore=688
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2402060146

> Dan, could you please run the test on this branch
> (83cbdaf61b1ab9cdaa0321eeea734bc70ca069c8)?

I'm sorry to report that I can still reproduce the problem running the
kernel built from the md-6.9 branch (83cbdaf61b1a).

But the only commit I see on that branch that's not in master and
touches raid5.c is this one:

    test@sysrescue:~/src/linux$ git log master..song/md-6.9 drivers/md/raid5.c
    commit 61c90765e131e63ead773b9b99167415e246a945
    Author: Yu Kuai <yukuai3@huawei.com>
    Date:   Thu Dec 28 20:55:51 2023 +0800

        md: remove redundant check of 'mddev->sync_thread'

Is that expected, or were you expecting additional fixes to be in there?

-- Dan

