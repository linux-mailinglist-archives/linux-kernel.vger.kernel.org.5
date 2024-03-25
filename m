Return-Path: <linux-kernel+bounces-117523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB688B234
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2F8BA05F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028FE12E1D2;
	Mon, 25 Mar 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvgVHBHB"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9F3DAC19
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385817; cv=none; b=Eksd4Bow8tvd2jBzcaPaTDpatNVMs3aQZIzVtdmCd2hqpUk3FgOpTXyvvP1ZKzUfBaAsLZ6HaRq1v58HVCgH1VmgnyHDpF6vOd9o9/dBV70uZ+pVm4+bu3W171waadV8tvTkzOJUxlQoOkzZGbJysdPhEK9Bdm1iJCMI1j2hWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385817; c=relaxed/simple;
	bh=xPp/RUzgQsiSSqM+nB7eJxXqxjfyHTpV6y11jbU95bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLCH/4gXl2YcZVZbRUgBNOh+ohKZ5buF5g8AV41S+TH4XQuCcj7CkvC9mu3gPGp9p90CGthnG9yVPMEKgfFnLHS7FW5TzWH9ajyPPm11ptNeVNc5vHDv793nu00ObdvtsjMxJF55u1D+zcszg9f8EVrkbFtoMennnvrKv4+59SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EvgVHBHB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ea8ee55812so2360334b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711385815; x=1711990615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv8OSr8XfO/UGe4RvS9k3B7kgKFsdVwGKtydzmzsC34=;
        b=EvgVHBHBRwrEt62D05wEw2T7SLsjqv/45vVph0Re6SlKCA/NK8PkkFku1AF110yNYg
         1R4XVPFDWGGnsLwAmuNM3yOurFdVevZpppoyHPTv4xaGPjTUsVg05y8+ok24MpyXg44J
         Dvzga600PoTDSdcGaOu7QMIi4txFN1m3Q5+E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711385815; x=1711990615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv8OSr8XfO/UGe4RvS9k3B7kgKFsdVwGKtydzmzsC34=;
        b=tTOlND0cZzSSwTTLpAl3RrHs9xBJFTcZYdRaRNaKJpc26yjHQgsPmnMmdtCjha/y5n
         /hN9f2HRcvRW7DMjBASnQpu9IeC78gyeszVsPeojLfZubhprphcCqLZJtx85mk5xxJ9v
         ke3a3Bv97Hkr/n0RJubM+vinQj0A/Xap8aHPEUHxbnQJcSGjUhrMepg5+ZHhr+QZ05F5
         BHn+Xzh2q5h5zNb1eRMiY8qQiGx/QWEWFcTMCJDQVPe6Z9nRWd4RFRRD7e8+BBTfuShs
         2B0s1E4vrcTrn5EbJ9CmzTFc7I0Iioxh2k+MRVASjGe3ppdqQ4F1F6tpxY2wPafKjE8m
         qpRw==
X-Forwarded-Encrypted: i=1; AJvYcCUT7anq8Ls4nejzJsqzRUO2ZYiDf1a89tep4S6YjGimW0ZMOfxmJOFckcT9Qw82F9ArTUzchNdf68996vcfqQnxhyLrGHJauMNzrN4+
X-Gm-Message-State: AOJu0YzJBYzTyKoF5Tizog7ncLK9UvqtbW7988UFjwblJbcKurbZ8TVY
	ZpMW9Iqk+fDaRUgwBeu1w1YOlNk1IDwg4rYMwg8aeezoFOE+tQ06ez4Mq5Pr2Q==
X-Google-Smtp-Source: AGHT+IFJxDTO0PPcnDj1vjtBLWF+b9VN6OetGp9OFxlLXp0FJcL16ixfPvEZpVS4aubfeA3ZUF7duQ==
X-Received: by 2002:a05:6a00:2eaa:b0:6e7:29dd:84db with SMTP id fd42-20020a056a002eaa00b006e729dd84dbmr10135239pfb.31.1711385815206;
        Mon, 25 Mar 2024 09:56:55 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b006e6aee6807dsm4500309pfg.22.2024.03.25.09.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:56:54 -0700 (PDT)
Date: Mon, 25 Mar 2024 09:56:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Jan Bujak <j@exia.io>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Message-ID: <202403250949.3ED2F977@keescook>
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <874jf5co8g.fsf@email.froward.int.ebiederm.org>
 <202401221226.DAFA58B78@keescook>
 <87v87laxrh.fsf@email.froward.int.ebiederm.org>
 <202401221339.85DBD3931@keescook>
 <95eae92a-ecad-4e0e-b381-5835f370a9e7@leemhuis.info>
 <202402041526.23118AD@keescook>
 <51f61874-0567-4b4f-ab06-ecb3b27c9e41@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f61874-0567-4b4f-ab06-ecb3b27c9e41@leemhuis.info>

On Mon, Mar 25, 2024 at 04:26:56PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 05.02.24 00:27, Kees Cook wrote:
> > On Thu, Feb 01, 2024 at 11:47:02AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> >> for once, to make this easily accessible to everyone.
> >>
> >> Eric, what's the status wrt. to this regression? Things from here look
> >> stalled, but I might be missing something.
> >>
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > 
> > If Eric doesn't beat me to it, I'm hoping to look at this more this
> > coming week.
> 
> Friendly reminder: that was quite a while ago by now and it seems
> neither you nor Eric looked into this. Or was there some progress and I
> just missed it?

The original reporter hasn't responded to questions and no one else has
mentioned this issue, so I think we can remove this from the tracker.

#regzbot resolve: regression is not visible without manually constructing broken ELF headers


-- 
Kees Cook

