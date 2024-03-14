Return-Path: <linux-kernel+bounces-103602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7EF87C1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33752283FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753907443A;
	Thu, 14 Mar 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="A51Ptusn"
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437DA18E20;
	Thu, 14 Mar 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435928; cv=pass; b=o2MAnW38BS6wSChnqidEZULEYt7MBd5jhirksgiXwkFF8KaGNxrWYcSXVay7DxYR9mW4LdaPAmYuFSnqrXKZ86rSMdrnxBBYoet+4iTFq/A06TmOACFy4sJWTh8Agylne0EQytMjbwwepNMlw0Rll9eXN/UFhvWdF5X1u4PPNEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435928; c=relaxed/simple;
	bh=DmvN4Rx5zhHqeGMONsS7mrLgEC4s0XLDCnjg6T6lItk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tql/i/yW4oYwU9IWWPrvGrt7jiNplrWMAONAAty9Dvub23Un5cbR7ZTsZ1MFmhgNhn+SRNPTRz+t+Ecfs6jc+5AyBxc8M6m9wDOG+AIwxVVe6YIUy5W0h9nAfIDMokRWAK745kB6uz2XIFOrpZUBpeNlvjpJbq0sTky7Fo27VmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=A51Ptusn; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4TwYfZ2dfkz41HY;
	Thu, 14 Mar 2024 17:05:26 +0000 (UTC)
	(envelope-from jhb@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4TwYfZ1j4gz49x0;
	Thu, 14 Mar 2024 17:05:26 +0000 (UTC)
	(envelope-from jhb@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1710435926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9j0M8JjxyKdPr3iVbt4uZU0hUBO6Bi0AlJBh7AZ66ww=;
	b=A51PtusnP8asP8mnDHEarH6Ygs7ApTBboH+2fkmMUZZWMQd6O2ZnfnsaAeM8sabDEqzkRz
	08bgNG2faS/SlNd+34rb2StDL/E4oUpsYVrp6oXecdQ0/OYpQuzjus+pS+TQOeM0ng0tp7
	QHMsNl8RFwMn5FGJB67uGfsa0d+LpJ/eycek8xJH5HmFKOTHJoMd62ecdomzVEwcWY7bmK
	p0brbvdkTeniKPoV/EjTlAJiwPO5BGqGAlfqV52jdnd0eoxx8Yur9qaHX+rlcQSn76NJ2R
	MfamkDe2dJS7AjEVgYh560gB65doD8KEU0iSd7STNxGd8hRm+qABTqZjkyYvzg==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1710435926; a=rsa-sha256; cv=none;
	b=vm7k1fiPbWJRiqvXvm7Ez8E4FTzKcB6GfoF7flPBilfr1wfM2/Ld+gpgSkWKjj2Mi3aZ3T
	ydoR2k0dpzwRFhgsdFLo9skNsAJ2Kih9sVr1RZlitKN3Ohgn8ukmZO1xgkET5Ngi7yNJjM
	z3s9nC5zBIZ3Y4r072FqqL415nfL8ZmaXUgiUQOqhEyDp4c6Rx9G6iImsohDZJb4JQPer1
	T8b258H0cmME0PYhrmb0LYRn0yci2wNvlH3hulkrA7C3c24UWOre/J1BMetsV2DsD/Tb1x
	BNzR9R9/BYzyiWnueGwKXmGuxwe7HUWqGfTLq65SXVPsxCYPMaRhFs2U7pfJyA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1710435926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9j0M8JjxyKdPr3iVbt4uZU0hUBO6Bi0AlJBh7AZ66ww=;
	b=JFPLHqMDzcZhkDiXx3+G2enS6uq9qihacbeSHGKIV38irhdfze26RrdTDocRqr8zue12EY
	N6+A8Ff1UBf6S94UeegAQu2uLdml9S4HeXYhhsRYG3kO61rFByJNxoZ6AbqdsN+VB3JARj
	vaJLd1EJm2AVZ32/AB9zvK7jFTW0u6LkUd/ICBFJ7H+BsHbJF1uZQBcf9TwnS2PllWVhlS
	gqLehBMi5XHoo4LIpKvRr4Smq50V2rZ8wYYrVoyl+/u1IqK1ngVqtkey6K5Fa44nobLMy3
	me7kgcdz6lWhIMKR4qf3GX2tDCBDV4h5ISeMKj7Krt5ameP8vWRAio9DNA4wtg==
Received: from [128.232.109.22] (user-109-22.vpn.cl.cam.ac.uk [128.232.109.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: jhb)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4TwYfT3WVWzNvT;
	Thu, 14 Mar 2024 17:05:21 +0000 (UTC)
	(envelope-from jhb@FreeBSD.org)
Message-ID: <fb50847a-37a4-494f-a5c4-a2087ff35a78@FreeBSD.org>
Date: Thu, 14 Mar 2024 10:05:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/elf: Add a new .note section containing Xfeatures
 information to x86 core files
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>,
 Vignesh Balasubramanian <vigbalas@amd.com>, linux-kernel@vger.kernel.org,
 linux-toolchains@vger.kernel.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, ebiederm@xmission.com,
 keescook@chromium.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, bpetkov@amd.com, jinisusan.george@amd.com, matz@suse.de,
 binutils@sourceware.org, felix.willgerodt@intel.com
References: <20240314112359.50713-1-vigbalas@amd.com>
 <20240314112359.50713-2-vigbalas@amd.com>
 <dd54d6de-0bcc-4b2e-a420-b1a429b06246@intel.com>
From: John Baldwin <jhb@FreeBSD.org>
In-Reply-To: <dd54d6de-0bcc-4b2e-a420-b1a429b06246@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 8:37 AM, Dave Hansen wrote:
> On 3/14/24 04:23, Vignesh Balasubramanian wrote:
>> But this patch series depends on heuristics based on the total XSAVE
>> register set size and the XCR0 mask to infer the layouts of the
>> various register blocks for core dumps, and hence, is not a foolproof
>> mechanism to determine the layout of the XSAVE area.
> 
> It may not be theoretically foolproof.  But I'm struggling to think of a
> case where it would matter in practice.  Is there any CPU from any
> vendor where this is actually _needed_?
> 
> Sure, it's ugly as hell, but these notes aren't going to be available
> universally _ever_, so it's not like the crummy heuristic code gets to
> go away.

I forgot to mention one other use case for this note.

Today (and before my earlier patch series to add the ugly heuristic),
when the NT_X86_XSTATE core dump note grows because a CPU vendor adds
a new xfeature and OS's which just dump the entire XSAVE state start
including that, GDB fails to parse the entire note.

Having a note describing the layout (whichever format is chosen),
allows GDB to still pull registers for features it understands from
the larger note and ignoring the parts of the XSAVE block it doesn't
understand.

-- 
John Baldwin


