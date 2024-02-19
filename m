Return-Path: <linux-kernel+bounces-71580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AADE85A74C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0421C21827
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C27383BE;
	Mon, 19 Feb 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fv4XKd/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601B39ACA;
	Mon, 19 Feb 2024 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356197; cv=none; b=rN4lSlIhrfgTbkUKJyQs3aWMFGbG1pECQIDWltpCl+ezaBL/4XB/0m/t2yXEZkrHFc4fSargee/9rOP3gh084gqAehh2ox9iQUynMjbK7ZLlWb3K/kodqN2fourLsPw5Y43ZIqoxhUHEeHzAQYAUUEFu6S5awKHz+uTkkY5oyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356197; c=relaxed/simple;
	bh=JNh62JRLg8fbXzqeXktZKO30ccvU8cSYgOtKGgR1GTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6fWAmfkONwe2/97girT5mw6lTIU5tpSUo8pY4Y/JHLl7y7sh7eg85l/FWeuGL0t30UXMPl+vOaZ8nVo/zlzm9guI3j2SJ6SBOmPLBdQ1hMvwYmycC4Fhr+mdsReiXmdbvpY3oCZz/HXp6BudFGlwf5Db0y/qTFvvzhQ7n3B1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fv4XKd/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BA2C433F1;
	Mon, 19 Feb 2024 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708356197;
	bh=JNh62JRLg8fbXzqeXktZKO30ccvU8cSYgOtKGgR1GTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fv4XKd/NcPTVC5J1o8uIejsGeuMK+AyXccbshb2aTjyePC+0FWS5Qcwqp4vAP1QUx
	 2nKuNKJpTVpH++Wqac85mgKTfi/fPHdWv9/++BrZBgcFBPV2wWSFwc68PQ9UUO1Ry5
	 mqxrHfZQeHQ5EHwWCQNsNbxID5Pl+XU0apdX2vC2JeE4gB0QUtLcn49hppT1T5q1VJ
	 YgSYprKkqYqv4gM7UJWGj9UBgxteJpOUimticMPQWxotvy5+G2DMUAvgpfe5tae0se
	 i/kW9Ay5ItYlRWG/A3iDm6QOtPUddT6YtL5dNY+1DrldDLYCy2oBsLnPwybO3t+UzE
	 gOLpoKSaEqF5w==
Date: Mon, 19 Feb 2024 15:23:12 +0000
From: Lee Jones <lee@kernel.org>
To: James Bottomley <jejb@linux.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	drew@colorado.edu, Tnx to <Thomas_Roesch@m2.maus.de>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <20240219152312.GD10170@google.com>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-4-lee@kernel.org>
 <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>
 <20240208102939.GF689448@google.com>
 <98bdd564c6bf1894717d060f3187c779e969fc5f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98bdd564c6bf1894717d060f3187c779e969fc5f.camel@linux.ibm.com>

On Sat, 10 Feb 2024, James Bottomley wrote:

> On Thu, 2024-02-08 at 10:29 +0000, Lee Jones wrote:
> > On Thu, 08 Feb 2024, Geert Uytterhoeven wrote:
> > 
> > > Hi Lee,
> > > 
> > > Thanks for your patch!
> > > 
> > > On Thu, Feb 8, 2024 at 9:48 AM Lee Jones <lee@kernel.org> wrote:
> > > > There is a general misunderstanding amongst engineers that
> > > > {v}snprintf()
> > > > returns the length of the data *actually* encoded into the
> > > > destination
> > > > array.  However, as per the C99 standard {v}snprintf() really
> > > > returns
> > > > the length of the data that *would have been* written if there
> > > > were
> > > > enough space for it.  This misunderstanding has led to buffer-
> > > > overruns
> > > > in the past.  It's generally considered safer to use the
> > > > {v}scnprintf()
> > > > variants in their place (or even sprintf() in simple cases).  So
> > > > let's
> > > > do that.
> > > 
> > > Confused... The return value is not used at all?
> > 
> > Future proofing.  The idea of the effort is to rid the use entirely.
> > 
> >  - Usage is inside a sysfs handler passing PAGE_SIZE as the size
> >    - s/snprintf/sysfs_emit/
> >  - Usage is inside a sysfs handler passing a bespoke value as the
> > size
> >    - s/snprintf/scnprintf/
> >  - Return value used, but does *not* care about overflow
> >    - s/snprintf/scnprintf/
> >  - Return value used, caller *does* care about overflow
> >    - s/snprintf/seq_buf/
> >  - Return value not used
> >    - s/snprintf/scnprintf/
> > 
> > This is the final case.
> 
> To re-ask Geert's question: the last case can't ever lead to a bug or
> problem, what value does churning the kernel to change it provide?  As
> Finn said, if we want to deprecate it as a future pattern, put it in
> checkpatch.

Adding this to checkpatch is a good idea.

What if we also take Kees's suggestion and hit all of these found in
SCSI in one patch to keep the churn down to a minimum?

-- 
Lee Jones [李琼斯]

