Return-Path: <linux-kernel+bounces-68892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379BD858187
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E706A285B75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B0512F58E;
	Fri, 16 Feb 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="gmc3RLnk"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864B5465D;
	Fri, 16 Feb 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097879; cv=none; b=i8tDbXqFS9d7Ue8esDNdgXBRUMsf2n45TcqU7oxDGPgqKGnJhyDNS/HKbH8V11LKSsxHCR0o96nCcul2Y2IZqWyNTs63+MH1GZwCG8mDsxIuJUW091TNHxnyu6/QXwAAhPUxiKLEtf0KPd35Ufoo0QSSAYyfn5FtWYUUh56HmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097879; c=relaxed/simple;
	bh=y9Q3fD2tnKTk+FgvsD0F3JDBSD+nj+VyEVSlrWNPkAQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d3ZX8atQlO2qbkHGfRnNtc9PQcItouKytwVOQFzMDrxc9gxb77AYMCHX4KoEX/Q6D60bObo8z4HzTV3ejeSx1K1yicdwtjIOTTfd1OO7vymUVl8Pm3ESqdlQroh9mIcjOnQ6pUhtQOAO+n109TOYVP8mJzMh7YuwoX4v4Jyfn3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=gmc3RLnk; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708097878; x=1739633878;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0cZh71B0l8IG4uZIp4OIszUKFw5xlrbFMIKov5F9rMU=;
  b=gmc3RLnki406KhSIyDzlrLXhs60xT4GU23LmmmnOWGxS4T6hfCDSu6pa
   x4grGGjjJtDqoVUkrGwxLWXfqw3psxUj5uVL5gDHk9fTh44/u4FX1NkDu
   qMGx5hYqrJ0TOoVk2d6GdC+2ak0L81wJQKP3gYHWKu6nH5sB+s5yKvnPQ
   8=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="613548127"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 15:37:56 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:15970]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.23.202:2525] with esmtp (Farcaster)
 id a4a5ea06-05a2-4ef6-b192-ef4a9bf9607e; Fri, 16 Feb 2024 15:37:54 +0000 (UTC)
X-Farcaster-Flow-ID: a4a5ea06-05a2-4ef6-b192-ef4a9bf9607e
Received: from EX19D008UEA001.ant.amazon.com (10.252.134.62) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:37:50 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEA001.ant.amazon.com (10.252.134.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:37:50 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 16 Feb 2024 15:37:50 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id BFA7920CE8; Fri, 16 Feb 2024 16:37:49 +0100 (CET)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Alexander Graf <graf@amazon.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
Subject: Re: [PATCH v3 05/17] kexec: Add KHO support to kexec file loads
In-Reply-To: <20240117144704.602-6-graf@amazon.com> (Alexander Graf's message
	of "Wed, 17 Jan 2024 14:46:52 +0000")
References: <20240117144704.602-1-graf@amazon.com>
	<20240117144704.602-6-graf@amazon.com>
Date: Fri, 16 Feb 2024 16:37:49 +0100
Message-ID: <mafs0le7k8lo2.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Wed, Jan 17 2024, Alexander Graf wrote:

> Kexec has 2 modes: A user space driven mode and a kernel driven mode.
> For the kernel driven mode, kernel code determines the physical
> addresses of all target buffers that the payload gets copied into.
>
> With KHO, we can only safely copy payloads into the "scratch area".
> Teach the kexec file loader about it, so it only allocates for that
> area. In addition, enlighten it with support to ask the KHO subsystem
> for its respective payloads to copy into target memory. Also teach the
> KHO subsystem how to fill the images for file loads.

This patch causes compilation failures when CONFIG_KEXEC_FILE is not
enabled. I am not listing them all here since there are a bunch. You can
try disabling it and see them for yourself.

Since Documentation/kho/usage.rst says:

    It is important that you use the ``-s`` parameter to use the
    in-kernel kexec file loader, as user space kexec tooling currently
    has no support for KHO with the user space based file loader.

you can just make CONFIG_KEXEC_FILE a dependency for CONFIG_KEXEC_KHO to
get rid of these errors.

Or, if you foresee wanting to use the user space tooling to use KHO as
well then you should refactor your code to work with the option enabled
and disabled.

>
> Signed-off-by: Alexander Graf <graf@amazon.com>
[...]

--
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




