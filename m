Return-Path: <linux-kernel+bounces-46473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2AB844041
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B7FB2D652
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970DE7CF37;
	Wed, 31 Jan 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LeTBhhlf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D97BB01
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706871; cv=none; b=XpadCfIkfXMZD+34psFsnmybLw0Y7EaMpECbxHHeHobjU7ITiQLIm3/u9hqzY4IFnRglJy/W3NiXbJHKKIIzB7/KLWEoc9B+Xm18iExWqaKQLErfph+1GaSMyKFKO8mVfQC1s/g33+C6JMl9x0GyrxXI/GqNmb5XvaXWCT2tEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706871; c=relaxed/simple;
	bh=Nf7Dsr8EZJZ/9+wMClmS4IGj8jjb2jaLazmD3JQsIjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkFkAlAGho3bOiS4ZXdRsGaze5GE/e7sEnXG9rA089lvOxZN26+rnbX0P6ZCYl3dPXKfFjoJfkAv+wFEZH10PqJQNq63nEtSdF8X2syGBxvhE++tL6MJdHhVUSMVLzuBuYsHtag0VNGu4XC1r+BnEQl1sj7Jmkt2jCNxkEcze/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=LeTBhhlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F24C43390
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:14:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LeTBhhlf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706706867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf7Dsr8EZJZ/9+wMClmS4IGj8jjb2jaLazmD3JQsIjs=;
	b=LeTBhhlfRubCzCvTnrCld87vvpqNbt0RklPmCJWEZGjaRrXz3r3h/ZsTQ823q96rlw4Lak
	YwG3eja7w39qIDT0M3L1cBrWfKmi4Hvg+Fvf8L/n5+rfVrGYxjhBdpg+LGKjmHOBoQcQv5
	htXDG9QrhnEk5qrdqNK3APKqasptwYQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8e0e383d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Wed, 31 Jan 2024 13:14:27 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc256e97e0aso3484505276.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:14:27 -0800 (PST)
X-Gm-Message-State: AOJu0Yxr1/QD2H0SsfMfeo7/oKBeF6wcosM6sBloJFot+/YZ0B/rx72p
	cGVtY7C4CTuMrmzjj5x3TC9Jf044xLVQl9jIBLIN2Y2sA0JEYF/botdUbFYTPrOcomIPLu54sMa
	kYhP+xXx54hJEkZd1c75W2CYLcBc=
X-Google-Smtp-Source: AGHT+IG7ugdd5Qlh5wvfmqUhORJS8tPHXMuq81Um+RJsm3yiTXYZzY1qllJi7ExDQtROoYla5w2i8zC2NtYaYUGP8VI=
X-Received: by 2002:a25:1846:0:b0:dc2:547f:27a2 with SMTP id
 67-20020a251846000000b00dc2547f27a2mr1406802yby.50.1706706865823; Wed, 31 Jan
 2024 05:14:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
 <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
 <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com> <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 31 Jan 2024 14:14:14 +0100
X-Gmail-Original-Message-ID: <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
Message-ID: <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"x86@kernel.org" <x86@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:56=E2=80=AFAM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
> So given this, I would personally consider the virtual guest TSC value
> observable by host/VMM.
> [2] TDX module source code:
> https://www.intel.com/content/www/us/en/download/738875/782152/intel-trus=
t-domain-extension-intel-tdx-module.html

Thanks for the explanation and link. Indeed if this is all mediated by
the host, we're in bad shape.

> For the high resolution timers, host controls guest apic timers and inter=
rupts fully.
> So, it has the power to see and even affect when a certain interrupt happ=
ens
> or doesnt happen in the guest. It can delay guest timers at its will on p=
retty
> extensive time periods. This seems powerful enough for me.
> Things like HPET are also fully under host control.

And I suppose RDPMC is similar?

And it's not like the guest can just take an excessive amount of TSC
samples and randomly select which ones it uses because chickens and
eggs...

The situation you paint is that all of our entropy inputs -- timers,
rdrand, etc -- are either host controllable, host observable, or host
(and guest sibling) DoS'able, so if you don't trust the host, there
are no good inputs. That's not a great position to be in, and I wonder
if something can be done on the hardware side to remedy it, as this
seems like a major shortcoming in TDX. So far, all of the proposed
mitigations introduce some other DoS.

> Yes, in practice there will be physical hw underneath, but the problem im=
o is
> that the host is in between and still very powerful when it comes to inte=
rrupts and
> timers at the moment.

Sure sounds like it.

Jason

