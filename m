Return-Path: <linux-kernel+bounces-77439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A398886055D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57FB1C2539D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8922212D21C;
	Thu, 22 Feb 2024 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/2dyR85";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3P0A8iIY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC012D1EC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639499; cv=none; b=qBXx+d9geXLlJcrYYU+Ml+21Erm/zE2HLshjTuB1Zi2Hjwv8nyr/iBz/GNFhkGQJyt/MRQjsj4XwLKt8IV2PM0QCD6u/DXDocgOXewvXKTSm0CqU1LqEnwfq+7BE7nws3JgyXaRncD6pLwd55pqtz8iqAJ0IqQkP67OEOdwxmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639499; c=relaxed/simple;
	bh=xXS+uiHmPKxW40P0P65T09ha/nNwEp1FEeNKV9lC8Jg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R8ysItm/v1m2Lj8AUtnMzJC8ZpczTIGHj/4tu140g6ETJMBDH5zblEeUZB1q6ozdaiRgKwz8TjqBB/8Uxq3tfxfYtl0995kLkxS4QHxC8P/j4Ug3AUUrCua7+DxdLiD2hKVMtHrPi2VpCVnhrtLDF/cgHdrwNAslL2UONFNqm4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/2dyR85; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3P0A8iIY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708639496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXS+uiHmPKxW40P0P65T09ha/nNwEp1FEeNKV9lC8Jg=;
	b=m/2dyR85JIcCZGGQAeMJdxKDF024ImfMz99e5pyEMaUY+Fdv9HkWyfwbGViJcw/1GsTU9C
	8DlytIkC6CfziPrs7KYoFvgFP3/Sx/czcK21SfpTS2DjTbyfhPk8O1OszRPXJQflOgeomK
	UiqPbaS4/7VjEl7989ZoaPpKS4NAJJQRqCRnvMCPRgLc04BR1OZrWH+dCx99XRPneivpeY
	Ki6y92Dd/pC+o+66J2I6p5mayn0z/fVgF6ejdRp2EOqY8uL7ewCuvnNmknT4Y4Y3t6rzM3
	TZ3yF+FHuyOyV6NXNQVcgplxcJ0ZhSMrJv4VXiuFn9SD1CyP0kf0SKih2T7T6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708639496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXS+uiHmPKxW40P0P65T09ha/nNwEp1FEeNKV9lC8Jg=;
	b=3P0A8iIYNJKmKCEkHPb/QvfbAasAull6AWDpa1ZTYuv6xCjlo8gStKpcoFEdANi6im3piH
	WcGG495WSr94wCAw==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, "Huang,
 Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv7 05/16] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
In-Reply-To: <20240212104448.2589568-6-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-6-kirill.shutemov@linux.intel.com>
Date: Thu, 22 Feb 2024 23:04:56 +0100
Message-ID: <87le7cduk7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 12:44, Kirill A. Shutemov wrote:

> TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> to #VE.
>
> Use alternatives to keep the flag during kexec for TDX guests.
>
> The change doesn't affect non-TDX-guest environments.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

