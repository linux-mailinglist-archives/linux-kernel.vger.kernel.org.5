Return-Path: <linux-kernel+bounces-134215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB70F89AF0D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A38283E25
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58003101D4;
	Sun,  7 Apr 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d8N3c70a"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886CE56A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712474324; cv=none; b=Oub4F1MwabY/lP/zSAD4KzgXbUVGifu7ksruv72Y+8DO/KrdThB+6RDe8LSNyC8XaNS7XpVZF9XMwaaigrQvfC6fePErKRXhqm+P6FatSfinZ8psHsGDh6eg9wNjxQR61EPCPUGxtZMOfTzMiAkIQqMPpJ5kMZsWpNs12WPBK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712474324; c=relaxed/simple;
	bh=c34tb701YjyYGcV+qxQdrUEneQB34k6REaRDFAgcgJY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QuEZofk5mweCgliRbSqqNM1qgofEPtvlpgI4eDteaTlwzux/aOaFuyrnj+6lhG3Sn3aqrJ1qMig1ViTI6YvY670xavVLWlXJpJ12VhGxnnJ9MVknwrPiOdsVceFSgFmuU0cJWsVGGI2VTTUsTiKShH48iiL44EY0UPQ3pdqP3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d8N3c70a; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712474319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c34tb701YjyYGcV+qxQdrUEneQB34k6REaRDFAgcgJY=;
	b=d8N3c70aoPRRLJO4ZmGU42POIOcIrDWMUKgwOjP46ChvV1oAQiWO3HAXp1ZramcNnc34zH
	JQvEPjUBKHafoLeBoikdwan6e2eZAsnfqnTzA9cQAoTgjm26BDiO1/yfaDD05W85831eSX
	p/+PwdDDiW/wHSSHzB00py/CzlxF8rw=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v2 1/3] hugetlb: Convert hugetlb_fault() to use struct
 vm_fault
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240401202651.31440-2-vishal.moola@gmail.com>
Date: Sun, 7 Apr 2024 15:18:00 +0800
Cc: Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 akpm@linux-foundation.org,
 willy@infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB9CCE6F-0247-4B13-BFE7-93F48342D19C@linux.dev>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-2-vishal.moola@gmail.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 2, 2024, at 04:26, Vishal Moola (Oracle) =
<vishal.moola@gmail.com> wrote:
>=20
> Now that hugetlb_fault() has a vm_fault available for fault tracking, =
use
> it throughout. This cleans up the code by removing 2 variables, and
> prepares hugetlb_fault() to take in a struct vm_fault argument.
>=20
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


