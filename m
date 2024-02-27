Return-Path: <linux-kernel+bounces-83848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D48869F31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFBC1C27E70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43763DB86;
	Tue, 27 Feb 2024 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jBtoZc/z"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADF3CF73
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058943; cv=none; b=Zu7xr6wcz+1Yns5r3H2VOYPfsiVBRL9OpPYFyAb+s566f2nO1xtvXj814A1XAgIAm0jKAOwd8ayK56msbZuX5f4UjY+5moN3t1uO0al1JL3LiMHIGWsDpPb5/lbX3gNKko1yi8jaNa9mSUQ6r1QahHwK4dIu3H0orWcZXphGwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058943; c=relaxed/simple;
	bh=jSq4KXeTFZtyct5vXm2/p0iPG2c3x2yxVOAqDx+e4mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaNTninnUXp2+iO/4u0jRtUdrjAQKlDLySd2AZaIG6OyluLkNva/7+6oFCKzDvqEHYzOVV/gSb9hTuI9gTkR8MKNOhjW2QLQG89NAm9QFrMZ4WlD4Urel2GFI3Repxn54hUMxxPIIXfOm4KMDuPnNjLI/IqvfPFU4tV+Fru3Blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jBtoZc/z; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-365af8c3017so2084655ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709058941; x=1709663741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7EEAovyY81QdyILZJTWXC3o/x97aztsoHpc1fLEZmQg=;
        b=jBtoZc/z/EqXFLFa50K69LayTU87Fqvd3xuXIrDkxR6uLMIceS9+xEonIw7slszZwH
         s/aliLImUWIPwktF8Vp2xmt/nmKsCblZMnP9ucevSpxAPyRQqR3KOx7vYRYyAuqxtIaO
         RgGC3aSIvFlNqy1cvw7l2zmqdwMELtbyPFUXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058941; x=1709663741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EEAovyY81QdyILZJTWXC3o/x97aztsoHpc1fLEZmQg=;
        b=qR6MIbMEcpw7KpiZ5Kesp6kn/iQ3QOZ2YWlfQrvGB2BlFg+slKbUbmLvMabUqGzQc4
         mi3uzmY4y9JjgWEQAZ99/1c2+wfrtct4HeiKvG1+nRbSRbKvqqNBZg4/synVdmSLouYx
         TCnC+6dWXQb1RWZduZXq95CVWZzMgWMjUprckkQOg5k+5qgqDzECia0EB5Pf1NG1jTfg
         lbZAz57e4MpX+Mkh/QhEt/mSruMTRullsJoq3uezPKUJQJ8DcMJ/HPD4gtFE/XwteEGB
         BlPsunHwDVza37bBRyhwG72EtZMSWsgWfw1sp7R/RBjtx6AvzZgoVYLqj0ezbRA/n3Av
         Ae3w==
X-Forwarded-Encrypted: i=1; AJvYcCVyp5wIF1+bpCR9oDuJ74n0gL40m1mFxgOVfs8iGNX6cBaJJ4S12xY72lTy1lXanQmEVZ8xtAPswDcZ+cKLsCCvHtMGSuZ3PTjJQCfz
X-Gm-Message-State: AOJu0YznekhIvxs/6fH1m98omoRsimTS6aR3sgD+FQMbXutGRYAeuTWE
	Px4P3rbNC7qI5AYIoMMWLTwSaYN/PoSG6CNsq1hhtXRFpAS1ToSbW9cW/ZX+AG99/O31iT0lYnc
	=
X-Google-Smtp-Source: AGHT+IH+8NWbyh3jP7jqjXUNFXEIOLY+YCFET2S/Srb4DTKS3StgCly8M2Pa6XuGyS647VFTKFAmMw==
X-Received: by 2002:a92:c9cf:0:b0:364:ff70:ecb3 with SMTP id k15-20020a92c9cf000000b00364ff70ecb3mr11896862ilq.29.1709058941627;
        Tue, 27 Feb 2024 10:35:41 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y6-20020a62f246000000b006e55530067bsm608153pfl.167.2024.02.27.10.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:35:41 -0800 (PST)
Date: Tue, 27 Feb 2024 10:35:40 -0800
From: Kees Cook <keescook@chromium.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <202402271029.FD67395@keescook>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdytVTOgfvKBBvtn@tiehlicka>

On Mon, Feb 26, 2024 at 04:25:09PM +0100, Michal Hocko wrote:
> On Mon 26-02-24 16:06:51, Greg KH wrote:
> > On Mon, Feb 26, 2024 at 03:52:11PM +0100, Michal Hocko wrote:
> > > On Thu 22-02-24 17:21:58, Greg KH wrote:
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > powerpc/pseries/memhp: Fix access beyond end of drmem array
> > > > 
> > > > dlpar_memory_remove_by_index() may access beyond the bounds of the
> > > > drmem lmb array when the LMB lookup fails to match an entry with the
> > > > given DRC index. When the search fails, the cursor is left pointing to
> > > > &drmem_info->lmbs[drmem_info->n_lmbs], which is one element past the
> > > > last valid entry in the array. The debug message at the end of the
> > > > function then dereferences this pointer:
> > > > 
> > > >         pr_debug("Failed to hot-remove memory at %llx\n",
> > > >                  lmb->base_addr);
> > > 
> > > While this is a reasonable fix and the stable material it is really
> > > unclear to me why it has gained a CVE. Memory hotplug is a privileged
> > > operation. Could you clarify please?
> > 
> > As you know, history has shown us that accessing out of your allocated
> > memory can cause problems, and we can not assume use-cases, as we don't
> > know how everyone uses our codebase, so marking places where we fix
> > out-of-bound memory accesses is resolving a weakness in the codebase,
> > hence a CVE assignment.
> 
> Does that mean that any potentially incorrect input provided by an admin is
> considered CVE now?

Yes. Have you seen what USER_NS does? There isn't a way to know how
deployments are using Linux, and this is clearly a "weakness" as defined
by CVE. It is better to be over zealous than miss things.

> I guess we would need to ban interfaces like /dev/mem and many others.

Yes. Absolutely. :) Have you seen CONFIG_STRICT_DEVMEM,
CONFIG_IO_STRICT_DEVMEM, etc? Many deployments keep a bright line
between root and kernel. There is a whole subsystem (lockdown) for
working to enforce this.

> > If your systems are not vulnerable to this specific issue, wonderful, no
> > need to take it, but why wouldn't you want to take a fix that resolves a
> > known weakness?
> 
> I have explicitly said, the fix is reasonable. I just do not see a point
> to mark it as CVE. I fail to see any thread model where this would
> matter as it would require untrusted privileged actor to trigger it
> AFAICS. I am happy to be proven wrong here.

Given that weaknesses are commonly chained together for exploits, it's
just not possible to say something can never be used in an attack.
Exploits are about slowly gaining more and more leverage on a system,
expanding the scope of control a little more with each step.

It's not possible to make these distinctions without deep reachability
analysis and an omniscient view of all Linux deployments.

There's no harm in marking fixes for weaknesses as CVEs, so why the
push back?

-Kees

-- 
Kees Cook

