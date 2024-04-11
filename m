Return-Path: <linux-kernel+bounces-140064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C248A0B05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2461C21DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9780C13FD7C;
	Thu, 11 Apr 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7A7mnQV"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DF81E86A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823503; cv=none; b=oazMTmXAXhlNjRdXPFL9xIkTWDjFemw8UBSNyoR4R8HGOIvD58nj7eRinJUiVT1RRvyu5NONTchayRTnNVTRdehx4E13/aTl8wRULnkUZnE0o1ev8VAJV2/RLXAf9vAt8Pusz/ZoUoLuOvxjEvSSDUS/A3Y0jKCe/52A8ZUcth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823503; c=relaxed/simple;
	bh=vJGajiA7UqeVjotIh9nv4B6URr452FeySDSZULISs4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orF1XLnnbOCZIQBggNw1D2sdTZBmULITZPB9kfRgPly3BIjOtTEb2tWMmwlT25nGbqdaTkZnEHwcy8OSS+qJhsPcAvJ1Jb1m03IU3b6ie2WEP72NFcZEKfifujpHhG5O3E+Gb9BiZs5+7aA2xYLue7Y6t4VWh0ZT5Q4rXqQ96Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7A7mnQV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so5011776a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712823500; x=1713428300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Woxy7l8UlrwK+Rg0MzpQi7K/6cTVMzMJKuNM4e7aTU=;
        b=S7A7mnQV0Bg3iahRYT1jQ+w4YLyXp2M1WHhaljlPgaHEWepQKykdOgJ4lRPlXXAHeR
         qRpCR2X5LHeyogTWbubIMO29rivQfvzhmZfCddtJAEp99xJthR9nkCdzaTo+albKuOVn
         dajGiVvvresUjE57r29YhomTiWf5ebcImvo8+eDWX3Pn7ne5w8oLNLAfrsTjhfptlU60
         AIh0QVirAVafcYWko5U8n/+IvS33JwlRud3oiVzcfxWC0BDkvsmsCI0iNjt8SNdIFzpg
         YRIR5c+1Vxq+4pxp3csf+u7UkWZ3ZU6HuY2pf6H1xMheIUATE36dY+0vOprQjx4lR96F
         DOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712823500; x=1713428300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Woxy7l8UlrwK+Rg0MzpQi7K/6cTVMzMJKuNM4e7aTU=;
        b=Nqt2G42w+8GKG0pOLlRy6FVYjiwNrFLS7zMA5NZIXmFfJJTkap9cXj4zt6nTDLqLhN
         k0s36mErLqwY+ueGwgbscs8k5C1u7iLzUGgfqxWqjbnEv1naKto5Lbq76FcvXIM9JaUC
         Tafoiq/I4aN+afiYS5mO/JBsz1crZBBw7gPFSxX/p1nPXEqpII0+3qQFcp5ZM6oM09rb
         RLo7P4ds2+bhQclhiU50KH2UN9mizQXoyz8FXZZxCilYVSQRndDawvSEIrKi/X+h7B1Y
         ELRWoSiDicmoNz68tFpqvxITVrIeXryu4Wc0jWFYfA4kzh2Uay8UGrPvWw45DfVVlFKM
         tSzw==
X-Forwarded-Encrypted: i=1; AJvYcCWmswqJ8+tWeOHLh2nZxCV2JwozTQunaMpZP+T2K9emtG9pF9xvYKETjXSXZ6xB13el5PGdn9yOFlcR1ArGzVjyHm/TUmiaqsEi9EJY
X-Gm-Message-State: AOJu0Yx4j7Zsj7ZfvUf7bAUzQqiXDKpImniHMpJGcM4ioT7ltUvV7seE
	ZfhdFhIODoKl5s0NUL9H8myPenxTPBkfkm2COLWwm/kNPilkFsaK
X-Google-Smtp-Source: AGHT+IGSMdBoOaAaeV8GLc9r7uYamz3crCopLMU7amFYQcMXYhiwr6kRL+vS7/rKreIkGs8JONzpkQ==
X-Received: by 2002:a50:f603:0:b0:56b:ff5b:c49c with SMTP id c3-20020a50f603000000b0056bff5bc49cmr3149247edn.33.1712823499666;
        Thu, 11 Apr 2024 01:18:19 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id b24-20020a056402139800b0056fd89cd52dsm457187edv.85.2024.04.11.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 01:18:19 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 11 Apr 2024 10:18:16 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 7/7] x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with
 CONFIG_MITIGATION_SPECTRE_BHI
Message-ID: <ZhecyLQsGZ9Iv8wU@gmail.com>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <3833812ea63e7fdbe36bf8b932e63f70d18e2a2a.1712813475.git.jpoimboe@kernel.org>
 <ZheV2ly/LZjpaVTE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZheV2ly/LZjpaVTE@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> >  static enum bhi_mitigations bhi_mitigation __ro_after_init =
> > -	IS_ENABLED(CONFIG_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
> > +	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
> 
> Uhm, after this patch there's no CONFIG_MITIGATION_SPECTRE_BHI_ON 
> anymore, which is kindof nasty, as IS_ENABLED() doesn't generate a build 
> failure for non-existent Kconfig variables IIRC ...
> 
> So AFAICT this patch turns on BHI unconditionally.

BTW., this is why IS_ENABLED() is a bad primitive IMO:

kepler:~/tip> for N in $(git grep -w IS_ENABLED arch/x86/ | sed 's/.*IS_ENABLED(//g' | sed 's/).*//g' | sort | uniq | sed 's/^CONFIG_//g'); do printf "# %40s: " $N; git grep -E "^config $N$" -- '**Kconfig**' | wc -l; done | grep -w 0
#           RESCTRL_RMID_DEPENDS_ON_CLOSID: 0
#                   NODE_NOT_IN_PAGE_FLAGS: 0

1)

CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID doesn't exist anymore, but is used 
widely:

 kepler:~/tip> git grep RESCTRL_RMID_DEPENDS_ON_CLOSID
 arch/x86/kernel/cpu/resctrl/monitor.c: *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
 arch/x86/kernel/cpu/resctrl/monitor.c:  if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
 arch/x86/kernel/cpu/resctrl/monitor.c:  if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
 arch/x86/kernel/cpu/resctrl/monitor.c:  if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
 arch/x86/kernel/cpu/resctrl/monitor.c:  if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
 arch/x86/kernel/cpu/resctrl/monitor.c:          if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
 arch/x86/kernel/cpu/resctrl/monitor.c:  if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
 arch/x86/kernel/cpu/resctrl/rdtgroup.c: if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {

Each of those uses is bogus, as the Kconfig symbol doesn't exist. (!)

AFAICT CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID was never defined within the 
upstream kernel (!!).

AFAICT the first bogus CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID use was 
introduced in this recent commit:

   b30a55df60c3 ("x86/resctrl: Track the number of dirty RMID a CLOSID has")

.. and was cargo-cult copied in other patches. It was never explained in 
the changelog why it's used without a Kconfig entry anywhere.

Maybe in the future some other arch might (or might not) introduce 
RESCTRL_RMID_DEPENDS_ON_CLOSID, but that doesn't justify this bad pattern 
of dead code ...

2)

The NODE_NOT_IN_PAGE_FLAGS use is borderline correct:

  kepler:~/tip> git grep -w NODE_NOT_IN_PAGE_FLAGS arch/x86
  arch/x86/mm/numa.c:     if (IS_ENABLED(NODE_NOT_IN_PAGE_FLAGS)) {


As NODE_NOT_IN_PAGE_FLAGS is not a Kconfig symbol, but a flag defined by 
the VM:

  include/linux/page-flags-layout.h:#define NODE_NOT_IN_PAGE_FLAGS        1

.. which happens to work with how IS_ENABLED() is defined. No other user 
of NODE_NOT_IN_PAGE_FLAGS uses the IS_ENABLED() pattern.

Thanks,

	Ingo


