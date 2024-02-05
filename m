Return-Path: <linux-kernel+bounces-52098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A7849410
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB7CB22648
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2F11198;
	Mon,  5 Feb 2024 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CNnVZzDM"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6411184
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116258; cv=none; b=rXne+y1vyPr9dAjg2QrGkiZhOLUKBDvFDEnH+CvERDWD8B5kMb/Bb8HMgei8ztQVkCxrzzGfQTSvH0R6IIiwB4FADzIPjy9dGOeVwOBiFCSyaUMZ4G0dN8Ef/kKt/vB5qia8ZzVToOdTinG076mYwPp7f7N9esx5oe3wXPSsZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116258; c=relaxed/simple;
	bh=D503/AjxBwgTT+qoYJKIIUiW1y30Pd8so2kspwugprU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ENsizQP8OIKi1kgKYJvTPwu1xbKeahtER7gTdYRGA568jdSrv7SbYnqbWMrMSD1qN6aWOY3J3IKOWat3iEQp5cwjK82DeH8RkjiN7LWJjtHJ6lm/LKy1cXu8YFPKq3neRZUMMmici8mAPdDNFs5WnN78zHl3zSJQtUsV2sQVj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CNnVZzDM; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707116253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D503/AjxBwgTT+qoYJKIIUiW1y30Pd8so2kspwugprU=;
	b=CNnVZzDM/YbUjKn8gIpgpk8IY8zGmVVPbiStfakFINLT/UN7vUHlp16trrIjio2UL1GAVz
	sBCEVy7f1QnM1Raykom7VqrGoht08yz7tLSVtMnja2iSu2DrfYUgwHkD2J8aWkarUCx2WU
	XukElD5CIWYIRuB/P3ozmX9qJoeJkoA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] mm: hugetlb: fix hugetlb allocation failure when handling
 freed or in-use hugetlb
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <b2e6ce111400670d8021baf4d7ac524ae78a40d5.1707105047.git.baolin.wang@linux.alibaba.com>
Date: Mon, 5 Feb 2024 14:56:49 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Michal Hocko <mhocko@kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E549C993-A900-40AF-9D0E-F14109237487@linux.dev>
References: <b2e6ce111400670d8021baf4d7ac524ae78a40d5.1707105047.git.baolin.wang@linux.alibaba.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT



> On Feb 5, 2024, at 11:54, Baolin Wang <baolin.wang@linux.alibaba.com> =
wrote:
>=20
> When handling the freed hugetlb or in-use hugetlb, we should ignore =
the
> failure of alloc_buddy_hugetlb_folio() to dissolve the old hugetlb =
successfully,
> since we did not use the new allocated hugetlb in this 2 cases.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

OK. It is not a fix (I see a fix keyword in subject) but an
optimization for unnecessary-allocation cases. Thanks.

Reviewed-by: Muchun Song <muchun.song@linux.dev>


