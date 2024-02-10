Return-Path: <linux-kernel+bounces-60298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE908502D7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88B6283AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4622087;
	Sat, 10 Feb 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPEt6gy7"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057910A16
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548341; cv=none; b=Q3nso9ewTkZdAJT6tqIo/jDnxwtcU0ETPdQts6rxbPvMFW85fc4GHnYkEoEbtmokK6eMenbfBSgc3dy0NDnnsWzkoUhPqWVX1p+Is8kMH71c3G+RbPUcm2tOzwcy7vD0vu290ij8CWu5ZzKyPyUvtnV5gvcQ1ehZgn6W6LJsb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548341; c=relaxed/simple;
	bh=Y5SWwtzlY7akdjVtlZdQaOz5bozkiblf4oOcM6PlM54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/YHLHgHuSRIDoB9DuU7OAhrPDLEAv1MF69q3s2GBNeumQrfqs5R/OnD34pPI0MFfad0aaZ0A3vVb1E/2Dm/w+/eU9LjTt7AytSRPZrmajSGiYIZOkPjJSYGCI0G8nCifJeLKpHimRABA/AIFe5i5kPhiH1l+aE9nEqOf8dXW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mPEt6gy7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d70b0e521eso13118495ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 22:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548340; x=1708153140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGphOPJmB8lCgsiAECv7yh5QjCdlMu1K1EXUdSxvbSo=;
        b=mPEt6gy7rLDFRHrpF/wYVQQH13RKsZYdZZ4x1B5yNhNKImoJ1t04UqvFyNTg1XKgLG
         itHJNetjU6mgOTsnODS53xY+KCo14UagbwCxGMPaSs4W4K760SvwjPEgDmR6pTVt4+2B
         TdS+mIhDVM9wyIr5eYO1IGIq0r1275/Z0yKVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548340; x=1708153140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGphOPJmB8lCgsiAECv7yh5QjCdlMu1K1EXUdSxvbSo=;
        b=LRHLTKOznlDSXG8oP7ZZ2hLD65mtkr2WeVnJmPUyK/EGzpNIJ2aqxZZwWVg9hKsuaH
         dhBN1OxS+UggfOVUi5j1dnwAoPyvCmh005G82I/QkCgDR87zV2KLcE6WlJ3OWa/vnBp5
         tt7Sjl6IH+m0/b3vw0i8sU0lv/5MQaqc/7xQxz8V5Q+6G/LOuchCXgThmkkrQe2GBQBe
         kHmRSR2heNbzFOODcoTj9oXha/hE8OCw/oETt6bsdqZ7dGJLijjo9YA5wXJVvYHwcAy0
         HHs3J36/AAIpiXHxD+wswHbQTb5DQY+IEmzppPI0Aq1ASBKmGPA79NO6T4UcDr0xz4py
         MDHw==
X-Gm-Message-State: AOJu0Yy2Myy+PYxL1xt+PPZTyx8cqoA6T3gpmAB2J0YYqgqvaj0621xT
	a7ByG9kFRGYRkzspSq65z16lOYaSOCBqrhggABC5GOKhAmHIhU5L09p8QaCiow==
X-Google-Smtp-Source: AGHT+IHTnF3fGuzslfqsDKip3bFExZj3gSNORqyeS1D8vTDmuOVDSx+jeux26obr0yz2kGNSAwz50A==
X-Received: by 2002:a17:903:40cf:b0:1d9:6c3:e24f with SMTP id t15-20020a17090340cf00b001d906c3e24fmr1719392pld.38.1707548339797;
        Fri, 09 Feb 2024 22:58:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJxTovjWaiv9g0IvLBZWYtRlBzRueKPP4/yrb+Xzr6kaMgQKEcgbUHUQGkTMST1B8UcIKVDo8HYkXhW93TEzKRAW/tBwGmIDMBKV6iAp1MWi/nwB7jrZokLH7Lw3cFTuud2KbwKjlvFfNS2JaLa/z6PbM0GaO3VfUer6+XzKyWYtzkn2pqtDWz4KNNxxGzlWSjNs6tUwRNSB4Llg27wr6lZYd1q6nyD46giA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902f28c00b001da15580ca8sm1678034plc.52.2024.02.09.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 22:58:59 -0800 (PST)
Date: Fri, 9 Feb 2024 22:58:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 07/10] scsi: aic7xxx: aicasm: Trivial: Remove trailing
 whitespace
Message-ID: <202402092258.5E568EA69@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-8-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-8-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:19AM +0000, Lee Jones wrote:
> Removing out of need rather than want.  I wish to make proper changes to
> this file, but my editor is insistent on removing whitespace on save.
> Rather than go down the rabbit hole of debugging my editor right now,
> I'd rather stay productive.  So, out it comes!
> 
> EDIT: Found it.  Looks like 5a602de99797b ("Add .editorconfig file for
> basic formatting") now forces editors to trim whitespace.

If there is a v2, you can "squash" this. :)

> 
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

