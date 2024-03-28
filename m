Return-Path: <linux-kernel+bounces-123350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914658906FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36A81C23306
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292942AA1;
	Thu, 28 Mar 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fspmrUkF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6B3CF58
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645936; cv=none; b=O3UWTvLjn0rvoiCPlvZgg7hUgN2X7OinDv4SKAf5s872YUnGhlwyPSdmiM7ECyLKu3iJveOwnhgxXr9MYpLkVoeFyp6A4s0/IrwTgBeFnDBCz8nHLQ66QLTZrzp0457fO9LUqsNayUsDCuAgpNvcKRrGpo0YIK3j7hTaydMyadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645936; c=relaxed/simple;
	bh=Hja3vS9thXGLKLww3PEJRfT0NndQJhzm8qU4nnPcckM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9Ft+ttRdiysGd4PRxsbVNNJecwjuQVxEfT16IRz54FR8ckaYA3d6v2q+w8d7cYoKxJPSbdkdFG4stjfK9/EH7iC6kn6JlWamFVbnfrf40bUmCH6yULA3aIlMWC5IsQso5Ij3M7t/ctPWOYY1dQx8YNbdUCl5vcHr4WyXqmWI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fspmrUkF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2F68D40E016C;
	Thu, 28 Mar 2024 17:12:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yWgCufbJBk8l; Thu, 28 Mar 2024 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711645928; bh=Luztintl3VI4viG+hHFnCoG31Xw06cMSvxb1/x6Ek5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fspmrUkFNWKeYONhOmlTwuBXeH8WlHc7ja0t+GF0Axve3WHZ9ymx6jR5SGIWT8cA/
	 r/2SuhTwW2VHXswsG1MPPwDLIvtCpFFt81g8VL8305+Zadp5pOaOMDDUOn1hIKN0Z9
	 7SRgbTVH+Wkrinblkj3FILy5qVdyO/0vTDdKj635y9vlf6EZQQd/l2CqXyaW8tjDcE
	 qd7L+kyz1BOs0A/sUrh/d9YsROIEExCItrFTyXEnjzxbircMr7DVqvNfqge8HFNaTM
	 t5ID26FzgM/wMGlcwWH5Dc75dJVsQVDRIg8G8vyezktlw7zqKaq/S1u1ZlWyxGw3/x
	 waeQDrKZ9fhHOtQvea2scqFpnk3DSZqISc9urEJatmchBhPcgStLCpqKX6G7ZgA77e
	 A8+3RCJOcbV+x4nhY8Llry64HPVltpPdZkLktBsduv5IAMlZs5/b7eZjAzsl02V9YT
	 1aKST/oJvgWgYA/4Pln8pT4flfDnaKF8uC9IaW7pPtYn9d0nx0Xm88QfXXUTZWZAYR
	 Fv9Su4Ou/y0uHzuy9F3MjUDAkTPTMU+ruv4+0aqj7i37Y7nbkXCUWP2+I+PDnB1RhC
	 IP1QBTA1ZUH7+VpdF6JTwVVZqSVqSt1dKGwps1k1D8eSmbJOzogtz83EzQw9Rvr8T8
	 e4HJ6oXXHJSjHbnT42Z16vHs=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A161A40E016B;
	Thu, 28 Mar 2024 17:12:05 +0000 (UTC)
Date: Thu, 28 Mar 2024 18:12:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Thu, Mar 28, 2024 at 05:00:59PM +0000, Luck, Tony wrote:
> It's essentially free to do this, and it makes the code more robust. It
> becomes impossible to check model without also checking vendor
> and family at the same time.

I see that but if we want to use CPUID(1).EAX, there's no vendor in
there.

And frankly, the x86 vendor is a Linux thing so I wouldn't mind if
checks are

	if (c->x86_vendor  == X86_VENDOR... &&
	    c->cpuid_1_eax == MACRO_BUILD_CPUID_1_EAX(fam, model, stepping))

Anyway, using CPUID(1).EAX is just a suggestion so that we don't have to
invent our own format and convert to and fro.

And that would be advantageous when we convert to dealing with
CPUID(1).EAX values everywhere and we compare them straightaway. We'd
need macros only when we need only some data elements from that leaf.

And since that leaf's layout is commonly known, the conversion errors
should be at a minimum...

I'd say.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

