Return-Path: <linux-kernel+bounces-65658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A936D855018
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5B81C2107B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B186625;
	Wed, 14 Feb 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gj7URXbb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226BE83A1E;
	Wed, 14 Feb 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931320; cv=none; b=ZLLjsnXF9LQ4KWolAG0CtxHvGhSM1/fXhn3053rj8xk0DPnmuqadPgkM3wrTrWHr4h0Ad29Xbx4nbbUbMnAdoYm3XEj999XmEzD6ZH1Nf0ubbvZcBDOi39c7iTd9gb8llcdP9Va6DliyablOxhXEKFRw8LJqHqhjaJE3C3kTvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931320; c=relaxed/simple;
	bh=wNciBySlMAxEqegwGBJHPqbtebvqeKeL8MXAm8xIM9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiZGReiiWRLDZVUuVRBh5X/0scr3xIqX4W/Kt2PABHwDwebxTE8VtiTcEKrpsgzE1+2wKS2ZC6KlgPEvsmG1Va1yichu4QMeUBSab630dOmleuINVvy0TOIJJ/TH+P11F89TgZjW01097nI8bgjVQoJkCOfa+YH4XKK1AiPWEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=gj7URXbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037B6C433C7;
	Wed, 14 Feb 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gj7URXbb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1707931315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZwi+vdzpHGZX+Nb7Ks31fJ33S155hZL64yC+vQwOQw=;
	b=gj7URXbb4PfZ+LnbtVPwINBwopSuxpUC9VnhcHhu4v8RoIZJ6vwu/qKYE4Q4OiFarheJIU
	NMaS+ekZth9cjpnULPk5rvE93c5/qzHWFbFWYCxmKJDQIDfsFsRQJZhU9NxAIy7AFTNCS/
	j37QJ6zF3tsm462Xv51jQ2JrIP1eQxc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 97ac0457 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Feb 2024 17:21:54 +0000 (UTC)
Date: Wed, 14 Feb 2024 18:21:51 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <Zcz2r51Tbb44ywjl@zx2c4.com>
References: <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu>
 <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>

Hi Elena,

On Wed, Feb 14, 2024 at 4:18 PM Reshetova, Elena <elena.reshetova@intel.com> wrote:
> "The RdRand in a non-defective device is designed to be faster than the bus,
> so when a core accesses the output from the DRNG, it will always get a
> random number.
> As a result, it is hard to envision a scenario where the RdRand, on a fully
> functional device, will underflow.
> The carry flag after RdRand signals an underflow so in the case of a defective chip,
> this will prevent the code thinking it has a random number when it does not.

That's really great news, especially combined with a very similar
statement from Borislav about AMD chips:

On Fri, Feb 9, 2024 at 10:45 PM Borislav Petkov <bp@alien8.de> wrote:
> Yeah, I know exactly what you mean and I won't go into details for
> obvious reasons. Two things:
>
> * Starting with Zen3, provided properly configured hw RDRAND will never
> fail. It is also fair when feeding the different contexts.

I assume that this faster-than-the-bus-ness also takes into account the
various accesses required to even switch contexts when scheduling VMs,
so your proposed host-guest scheduling attack can't really happen
either. Correct?

One clarifying question in all of this: what is the point of the "try 10
times" advice? Is the "faster than the bus" statement actually "faster
than the bus if you try 10 times"? Or is the "10 times" advice just old
and not relevant.

In other words, is the following a reasonable patch?

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 02bae8e0758b..2d5bf5aa9774 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -13,22 +13,16 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 
-#define RDRAND_RETRY_LOOPS	10
-
 /* Unconditional execution of RDRAND and RDSEED */
 
 static inline bool __must_check rdrand_long(unsigned long *v)
 {
 	bool ok;
-	unsigned int retry = RDRAND_RETRY_LOOPS;
-	do {
-		asm volatile("rdrand %[out]"
-			     CC_SET(c)
-			     : CC_OUT(c) (ok), [out] "=r" (*v));
-		if (ok)
-			return true;
-	} while (--retry);
-	return false;
+	asm volatile("rdrand %[out]"
+		     CC_SET(c)
+		     : CC_OUT(c) (ok), [out] "=r" (*v));
+	WARN_ON(!ok);
+	return ok;
 }
 
 static inline bool __must_check rdseed_long(unsigned long *v)

(As for the RDSEED clarification, that also matches Borislav's reply, is
what we expected and knew experimentally, and doesn't really have any
bearing on Linux's RNG or this discussion, since RDRAND is all we need
anyway.)

Regards,
Jason

