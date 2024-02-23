Return-Path: <linux-kernel+bounces-78631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE5186161E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4051C23719
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A8382C6C;
	Fri, 23 Feb 2024 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hl77ICMb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179704A3D;
	Fri, 23 Feb 2024 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703033; cv=none; b=nK1G3GbAI9ZxAvY46lPzsTpU3jPMtS3PMaqzdci4D/hMH9gXlcdxmNp/qWehMxkpQXt6aW5Ruwi8ybiDIV1zEuvbncTnxTah6NH/fpr/iZ3COopXKvoVTj1gezql7O99ANtaO/A7PdyXn5ML0N332Q5h0TE4XWeS3QNdWSl79DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703033; c=relaxed/simple;
	bh=LRbUtJsi5tFV5Td5mfsuSsDvyXVEmiUYSJKc4U9GivU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeSY0aJBpbqD14J0i5nPjMvJjPiU5ttPJr8geDRk4vZwmKLb7zbzAIiiqNXO6YFxuCvCyIxPCV6EhBCF6MLGUs+1JuWuNmCbUm8vTyesJFedWrexGmIiFK8yQPC2J/e7gtZ6gjT5E+PUVmxmGNbnWKVjWWQO/1lomDof7bpuTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hl77ICMb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6F3D840E01A0;
	Fri, 23 Feb 2024 15:43:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YyMHoWaZT0-N; Fri, 23 Feb 2024 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708703018; bh=vOuid2cJTRQLhiLgDF9qDITkt0o2BhRLiMIp10b+zB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hl77ICMbkiYiZXvnyP7l2drG6hgZ4Ocx0OmlAwmeL+3agO8UQXbkPtu9UHeYwVvCk
	 fgojY2YiA1nbEZEf3o/QUicgYfYzdqtWICyIMv7KSvpQBZUON8BAPavJgOV4yyWRcv
	 MARAP+KTuGeW3nEJjwsJTVBZoHoW0cQmbDTlKpNsxMi4tETXM7Z67ftazhCz924lQ1
	 kR7sK/Lt/UoMVj0/HlLmsmJyRD5wRSonm1Zxr+Z0T0ocdHEMwujmFl0A9GvbqbaWFv
	 mxYHZ9FGCYCyxdlOitulO/q+SeT9+QE9v4nLngN6E/5SDn4GcnAYtTrDLA3Ijjaxw3
	 B+qnh6uLPCBZ0ZBR2x9alDC6rR8Dw5DhF2xjq27dcSfTPJ7wbiYeCfZMeCXcn8CVdF
	 s0p3vfTNLM+NsPctNdMKiEz+fVGwVCLIj7JRGSJJl84Pxgg1yYi1UA2sYcoC7qzRGu
	 ul5Od0UxW1Mrr1wGg12U2ReAaZ6zizCI5AEY7EtnLAue0T2F3GE5zClHTLexscMMSV
	 uA/JiB+48CLcWxmdjFDbhZLEReZRqrpjxa4aurhC3s5Kv2P/Qr/wGwukViwrlXv0Ni
	 ouDFi0Af7q5Hwk3AExxf1tmSoAtvDC/x/asn9L0GrL/G1brZFVMVEivvo6E6FhrX66
	 YaWYc02C743bAOSmPKn5wG/0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDE8040E016C;
	Fri, 23 Feb 2024 15:42:57 +0000 (UTC)
Date: Fri, 23 Feb 2024 16:42:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org,
	lenb@kernel.org, naoya.horiguchi@nec.com, james.morse@arm.com,
	jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	mike.malvestuto@intel.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [RFC PATCH v7 00/12] memory: scrub: introduce subsystem +
 CXL/ACPI-RAS2 drivers
Message-ID: <20240223154251.GAZdi8--NPaMAK_ZBp@fat_crate.local>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223143723.1574-1-shiju.jose@huawei.com>

On Fri, Feb 23, 2024 at 10:37:11PM +0800, shiju.jose@huawei.com wrote:
> CXL patrol scrub and DDR5 ECS and ACPI RAS2 HW based memory
> patrol scrub features are added as use cases for the scrub
> subsystem to expose the scrub controls to the user.

WTH is a RAS2 driver and where is the RAS1 driver?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

