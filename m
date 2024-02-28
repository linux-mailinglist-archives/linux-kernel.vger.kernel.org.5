Return-Path: <linux-kernel+bounces-85419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170E86B5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952C11F25408
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A15715A482;
	Wed, 28 Feb 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cOTMUdX5"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FA1482ED
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140338; cv=none; b=N9oSY4DR+3ylSahLAvk7r32fkYEzQWHRfIzwvSMNKFP413BB5PFXMxH8cprVZV4d6UtyohTfeRn8PwbxBtvL82CWVk0j4F/S3vhBxGIFWKKP8+MEkTKoLO8Ck5kbNXEbNO1dRhsUygdEXA9Pa6faPfeZh7/ska84uvnQHRlpd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140338; c=relaxed/simple;
	bh=hfhCB2eTtMDU4hzhxyX634Fhi879pfeThwP8OkqS91U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z54F0Ms0MGbq5SgXPwZcFPlfgO62/V5baZYR9SWzTJkVg4GaJwc1ZWsYJFCt5n5rmnilmD14b1v0y9y2xUA4vWkK+9sPy89xMDJ0lPllYku5JxoxrZ0unkH+rONWJGDEEGWGcHy4OCUEosRhW8dLnr+O4LCxDOXYJSUR+xvauqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cOTMUdX5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso4648918a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709140337; x=1709745137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NKWPHLTB4vVoleUbkDHc4KBRcoFTHSNI1EJnoQEzOuQ=;
        b=cOTMUdX5Wvi83lUG1rlhbT0NBL576zKVFquuCzZWugywrSR2rwIvzNT+i8pxWUhAo4
         gYH9Hb8EuCgiT5FPUMPtjhT4FqDn+cVCUROwNw49ZIUD3L59pk1clsBTZJY0grcCLb2C
         WQPR6JCnPaDcsw/fYll9+e16xSJN7TJ/vnrmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140337; x=1709745137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKWPHLTB4vVoleUbkDHc4KBRcoFTHSNI1EJnoQEzOuQ=;
        b=DO82XbGAwocJC8xIrNohQ49sPY9U0l/XYn5IFQzjVm9xFeXkKPf1sWLKhnWmlwELA4
         YPrDzsVqRU1IFCY+jp7SNmR00OPje8b42L52zDEVBpkUApI8L/VvcvHTM3qQpWZgjkBu
         XFMTNO7Fg9ex7df8xgF5Kf1cFMljN6Qi9T5LTaOZ9lhiKfi1iljQDk2CzOozV1QQVJPa
         OaWG8OQU6K0QTSlaBKHyZIMqIYvMNv62qu0TjwBHai7QmQJlfCvKS5SkT4gyafsyDrAU
         WeNC4JbZmNJo//9d/KYrx761Dfes3pSueiQKncBAVCcPS7P3Pg0P8KiFZumhy4PrSQn7
         RF5w==
X-Forwarded-Encrypted: i=1; AJvYcCXxPufkaUySf58y5b8KstZxh9AIA5rdd+ucYxzFgmkUyA1GgoxsrLOW6ZjjxBe8/NQuTSuJvJGqZgkGXyAm2w8QxDb1pM/AYgufV8/O
X-Gm-Message-State: AOJu0YwFGZLIMOaqB2CwdVGiWjgtWmWkpApkOlGJPsA20tcFOpiBn45W
	lRaqozyhCqIo0PWoPio+JKWJyiIVcEMcX6iDUsAeaoFi0PKPkgr/w7fdRjljEQ==
X-Google-Smtp-Source: AGHT+IEgcbz+UbTUNhUPsSbE85jDpgqdf7lL215pm1U3S7l8mSiUv0aJXll3M5pSq2NGYPNMXwkj6g==
X-Received: by 2002:a17:90a:4a06:b0:29a:575c:7d90 with SMTP id e6-20020a17090a4a0600b0029a575c7d90mr371761pjh.9.1709140336748;
        Wed, 28 Feb 2024 09:12:16 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y32-20020a17090a53a300b0029932d64c2bsm2083656pjh.17.2024.02.28.09.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:12:16 -0800 (PST)
Date: Wed, 28 Feb 2024 09:12:15 -0800
From: Kees Cook <keescook@chromium.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <202402280906.D6D5590DB@keescook>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <202402271029.FD67395@keescook>
 <Zd8hPpP_6q_o8uQW@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd8hPpP_6q_o8uQW@tiehlicka>

On Wed, Feb 28, 2024 at 01:04:14PM +0100, Michal Hocko wrote:
> On Tue 27-02-24 10:35:40, Kees Cook wrote:
> > On Mon, Feb 26, 2024 at 04:25:09PM +0100, Michal Hocko wrote:
> [...]
> > > Does that mean that any potentially incorrect input provided by an admin is
> > > considered CVE now?
> > 
> > Yes. Have you seen what USER_NS does? There isn't a way to know how
> > deployments are using Linux, and this is clearly a "weakness" as defined
> > by CVE. It is better to be over zealous than miss things.
> 
> If we are over zealous to the point when almost any fix is marked CVE
> then the special marking simply stops making any sense IMHO.

Perhaps, but the volume of fixes is high, and I think it's better to
over estimate than under estimate -- the work needed to actually
evaluate all these changes is huge: it's better to take everything from
-stable. This has been a long standing problem with communicating this
to engineering management in many organizations. They have pointed to
the relatively small number of CVEs and said, "just backport those
fixes", and trying to explain that it's is totally insufficient falls on
deaf ears.

> Are you confusing hardening with security relevant fixes here? It makes
> a lot of sense to reduce the attack space by sacrificing functionality
> for some usecases but in general a large part of the kernel is built
> around a "root can do anything" philosophy. Whether we like it or not.
> And that means that we do not even pretend to protect dubious
> configurations by root/CAP_SYSADMIN which could effectivelly DoS the
> system (just consider hotplug/hotremove as an example - try to run your
> workload when most CPUs or memory is offlined). Some operations are
> simply not suited for untrusted entity.

Sure, I understand, but it's not possible to prove the negative. Perhaps
this particular fix will never be used in an attack, but I don't think
it's good to underestimate the creativity of attackers chaining
unexpected states together.

> [...]
> 
> > There's no harm in marking fixes for weaknesses as CVEs, so why the
> > push back?
> 
> Because assigning CVEs nilly willy was the main downside of the prior
> process and I was hoping that the new one, in hands of kernel people,
> could be better and we could be getting more relevant CVEs.

The old assignment pattern was both radically below actual fixes
landing, and also regularly not applicable at all (CVEs for out-of-tree
downstream patches against Linux). On both counts, I think the new
process is better, even if it will produce some "very low" severity
CVEs. :)

-Kees

-- 
Kees Cook

