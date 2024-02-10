Return-Path: <linux-kernel+bounces-60331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B317C850343
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5328AB282D1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E72D36B15;
	Sat, 10 Feb 2024 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GeThgPz2"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E50364A1
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707549244; cv=none; b=Ym2GITS0bngQf2AYhZLFPuknxYdvk9ySpHRlVDR+8VG8R6otQWRih+U1lcXUZr7uZKY+ev1kMnPfI+1e1sOzZG1COAuLYRI9H/ioLxt1U05d79T6yE9XxANgt0F14GXN3k3cb3qCsfTdMaG0XXPNZ66zS3AKSKcywALOLc0jl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707549244; c=relaxed/simple;
	bh=Umw67NSx6veGxflgycHZ9hWuO+uljq6JdaHaAgRnIAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkrdNcCSjzQDHsrZTJ5Xz4D4yfmc2XtXc0/nLe8hPzGfzmpKFHQstdUaM7uEu0DKgMYhSoL+ox6SaXuNe5wwG7aCtSb1n0UGDbHDrk5yQO1GkxVrkt0FHPA/caNSk1hS5eSUDORrccqBrKh8CNIZSzPLwGVElQEOU5ZJcCy+k7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GeThgPz2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d76671e5a4so14031995ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707549242; x=1708154042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMttalflqfwloIFlu0Md5bgBDJMW6J4Nu25+yNhA1O4=;
        b=GeThgPz2pcMNAE0i3ApFnj0QytJZVuqxqeVKrjHxTVGIiZ9kAd2f1tma8CxynCFHVV
         BV4jOfz1VJM/4fmGaUR2QL6BpAExkc1NBNwTWOy88b5dpOxO/IBS1XSwh07kumpJw+h3
         WWQ+5CPRDtSbP1dgJ6vrY+FZf+RkVdgIL/QDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707549242; x=1708154042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMttalflqfwloIFlu0Md5bgBDJMW6J4Nu25+yNhA1O4=;
        b=UojD+z+EMcsjmcutObo4lj3wfCmN+ZtI2ZKlefB/SVrFmiqpfVnkrBI3KG3A63QZcn
         BmwUP0qPpGJUcsuaqBjV6XnY3nysR8jJznhNzoEV6Bmu0QuRCuCgOD5lQTCgGuGC2Bdv
         0QUCwr/bnUSpgg5+wBGKiy4Rc2Xc8zV4vc14CLjHSFGNrctlpRxEwD3xqXPFQ9lKQ377
         bDupyYbJ5YauVrrjqTZWnXWBSdoB+Bgfma+/RQe0w8eN8ndnO3ZiGNwv2sopbYzdxs8r
         oVRChnzOU15YiUWeM69t+HdYbVAxpa0Zq2aTDXAXCPfkMRpQwsOplqGakeKOy8pRMBwC
         mbJQ==
X-Gm-Message-State: AOJu0Yw53oFSwmXL0BIZ1S0Rx2kEV3mMcutrhhEnTpdLm4E/gshasJk6
	MwHRAnmZ4pgIkoL4O8yQBnMu35lIAhUt1ESveX3tHM/OW8EWmIUGhCLs0gnaqrKjFYZbOZC77tg
	=
X-Google-Smtp-Source: AGHT+IEiCCvJy9lDrOwRv+k1eZW2Eqi3XGmMmZQItYkt98YYvSbj4FAdQnoh7ct/ECZZRerv7l3kew==
X-Received: by 2002:a17:902:f54e:b0:1d9:4544:ed22 with SMTP id h14-20020a170902f54e00b001d94544ed22mr1583577plf.42.1707549242539;
        Fri, 09 Feb 2024 23:14:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXC2JgAKS8vHeycLoS66y+OPZvM56enaCv8ISAoq8xgWPmei75tjoykmemdkNOmICU4z+lz4LG+M9cLspRr6SwdRzOq/SXNYi7CRwYxJHm9AgQ/YpL8bUtR07IXLj+vVPtZlgqSjeFt01GIo+btnC57gakrPrTHOZmtLXDb/PJsHth6ScAdHeN5X8+0ErVc37YMivwlTZN3HS3GRnVeCESu6CMLfCncPqSA+77fZlI/ABHEJIoOi0hPmsrQB8UuooCwh8PAO72EOTrztHnOkjEKDFgCevheVfkSblS3zKUf3FKpa36vdnCaanV77tGRcGLA4/aWkA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gw10-20020a17090b0a4a00b0029709f8a976sm2595650pjb.10.2024.02.09.23.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:14:02 -0800 (PST)
Date: Fri, 9 Feb 2024 23:14:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	drew@colorado.edu, Tnx to <Thomas_Roesch@m2.maus.de>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <202402092313.D3894DC9@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-4-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-4-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:15AM +0000, Lee Jones wrote:
> There is a general misunderstanding amongst engineers that {v}snprintf()
> returns the length of the data *actually* encoded into the destination
> array.  However, as per the C99 standard {v}snprintf() really returns
> the length of the data that *would have been* written if there were
> enough space for it.  This misunderstanding has led to buffer-overruns
> in the past.  It's generally considered safer to use the {v}scnprintf()
> variants in their place (or even sprintf() in simple cases).  So let's
> do that.
> 
> Link: https://lwn.net/Articles/69419/
> Link: https://github.com/KSPP/linux/issues/105
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

