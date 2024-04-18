Return-Path: <linux-kernel+bounces-150432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72188A9F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5357F281BED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A38916F83E;
	Thu, 18 Apr 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTxcocgG"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F300A15FA9F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455779; cv=none; b=ayoHYOkCO2qLeB0OvQlrD8Ge0gLnxnmB76PSWDYZo6kdJaAC+qep1K+RESf+fzXLHbxiArHzznCYRqjQVYDEgQzK2B5GQdJiBN7EXTN4Nmvxp3yxXw475fzPdqYqqGmv/N2C1lRlhYUeZs7ElNzX+GkZaPXTCnqdZlutyyEUEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455779; c=relaxed/simple;
	bh=mDRjfBiPjMWn261FMr3b8oWZieXKRIxWEC729h8K7sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL9j9K7udsxTPWnrKRLK8gV67cTON8r/P7Vi1FCvKO3OXc1rkpP5U6RWXCaSs0KsCUzGVm97TEwJxdVhtYRkLe1iAKWuHCAbowhHKYz3Z/a9N6zL2YSz/xM8Wt7P/bbY0nKuF65KZm+QJGXJSph+sZCUlAFPYasI2tKVCSGxXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTxcocgG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed01c63657so988369b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713455777; x=1714060577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnRoVABkMpTwTwJRlnT/WRT83zNRcjsjqktPei1RqZc=;
        b=OTxcocgG+gc/7Br+1KJeAFOHbYwSFqLV0joIJBS/GUX2vZVMYpSetfcLwnw3XGMsu2
         lrxWZUV6tXbNTpig1y1H1ukh81KJxdiDYqbEfPttYwRamQ/295ZedcoLg60ukF83F8BZ
         QQNlmS18OpWYDJE+tc0o9eNdEXLfHW8/7uAtlBuMZwduvhTOdIeHVGwzYA5/p1uq4529
         R9vU9fiAt9eIVmqTFCrLMeOtS32rf2EM8i7+aaRqUQFHPyKVdWD6jPvAWdBH198uSr7Z
         sfscgwcENVmsEFNgWYOcOOHUV4ZiN9mYXDy7AtY+J9xygdVzdLQAao1ReP6c4W+LYJHt
         eyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713455777; x=1714060577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnRoVABkMpTwTwJRlnT/WRT83zNRcjsjqktPei1RqZc=;
        b=OjmuevfwkrVI+valAm7iiQEIBy/pQHt5oJi7o9oncRnprFtFLITCpMMo7WTYsVxmtK
         cMEMLosYeHY7lM08ANRefgiCVLRZa8kahPEpC5hiVZuspJX8ylLTm7L0ShDGzu7xQj7j
         GKoXhdPDtJ1CSAtBuUvLUdPZU17zy4nsXXSaQ8PQWiAlvSQIbBILPfSTWNHor0Uoddoi
         atIZLMHeMFZhbJ8AHJoJB2UiLtjYg1rz3ikPX8x2zmHNnq4vXiRWbGPdKIvbd/T69khr
         tNsHaeQaTb++QZK9XwphVmDThVbCggz3Za4l8lUwrqpVclgjot97L81mNC8dujf5zEH9
         09Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWA+KooQbGnVF/BJXNE0QefDxU1z+7BZ+tzmh6t4qOlXV/8s3PsHVwDkvnjhSmN6EuTvNgaBNCiwLcq9kjTLSQLpFaHMilTMKMKu3D+
X-Gm-Message-State: AOJu0YzE5uSCz0d6/94kKxvDvj+xgExEj1/hiEjpFNRHgCcWpLZX2wSH
	G+a1gK8vsViesgzt41E0Fb2r75ntybUVUjhWgXZQw76hMJCVIXvG
X-Google-Smtp-Source: AGHT+IGXisnKjI71uANED1CP/KTHgH+Gcr2xad6cRyLgWvCNRvdOFFUmfzdZFprOYudDsZZZcmmqGA==
X-Received: by 2002:a05:6a00:3d07:b0:6ed:41f3:cd06 with SMTP id lo7-20020a056a003d0700b006ed41f3cd06mr3912520pfb.7.1713455777244;
        Thu, 18 Apr 2024 08:56:17 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id x12-20020a056a000bcc00b006e580678dfbsm1639967pfu.193.2024.04.18.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 08:56:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 18 Apr 2024 05:56:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix selection of wake_cpu in kick_pool()
Message-ID: <ZiFCn2RLWhk7i4oB@slm.duckdns.org>
References: <20240415053550.538722-1-svens@linux.ibm.com>
 <Zh8EfxdVdiIj_27H@slm.duckdns.org>
 <yt9dpluogfw9.fsf@linux.ibm.com>
 <ZiB9rYBu-0qjsCbF@slm.duckdns.org>
 <yt9djzkvfc6a.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9djzkvfc6a.fsf@linux.ibm.com>

On Thu, Apr 18, 2024 at 07:54:37AM +0200, Sven Schnelle wrote:
> Tejun Heo <tj@kernel.org> writes:
> 
> > Hello,
> >
> > On Wed, Apr 17, 2024 at 05:36:38PM +0200, Sven Schnelle wrote:
> >> > This generally seems like a good idea but isn't this still racy? The CPU may
> >> > go down between setting p->wake_cpu and wake_up_process().
> >> 
> >> Don't know without reading the source, but how does this code normally
> >> protect against that?
> >
> > Probably by wrapping determining the wake_cpu and the wake_up inside
> > cpu_read_lock() section.
> 
> Thanks. Should i send a v2 and incorporate your additional changes or do
> you want to do that?

Yes, please send a v2.

Thanks.

-- 
tejun

