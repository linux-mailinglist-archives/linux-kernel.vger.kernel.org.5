Return-Path: <linux-kernel+bounces-59263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BD084F424
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D109B1C2325D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7728DBF;
	Fri,  9 Feb 2024 11:06:15 +0000 (UTC)
Received: from iris.vrvis.at (iris.vrvis.at [92.60.8.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CAF288B0;
	Fri,  9 Feb 2024 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.60.8.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476775; cv=none; b=SCXPUPAAz0qCk52fKGHm2SM1+ew4wEGJNBhsqCv1bT/bavNLA5m3Jgw6VwR8UtWKhEKlEYNE/TG1Kr47bHwcFYU14XxkBB3f2C4dacONQtZ1iBO0r58svIlROkqS1T7KM80iECE9GTEWTnRMp/rttNAPoIZoVQ7dvhZOp2zN4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476775; c=relaxed/simple;
	bh=rsVhIVWdZyZz7+lmh66YQaSb8PHlmfoFgBunzIJ5sf8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tBv2BnY0DUGlI/5L309n9fXSH5v/cPDS6dXfm0ctavk/MChkuoNrR9a8DrC7RrsJiZHtPN/FbF+H7Pdlpsq9m6dO9y8kDEf0UkapsvUO6xEDDdQOgXyRKE6U4R2DWI2Oxtsb1tBiu2lzT2RiHtWI95fVRSnpVzIQAEUF9qKNKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at; spf=pass smtp.mailfrom=vrvis.at; arc=none smtp.client-ip=92.60.8.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrvis.at
Received: from 84-115-229-87.cable.dynamic.surfer.at ([84.115.229.87] helo=[10.6.66.144])
	by iris.vrvis.at with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(ESMPT Server)
	(envelope-from <valentin@vrvis.at>)
	id 1rYOhl-00087n-1k;
	Fri, 09 Feb 2024 12:06:01 +0100
Message-ID: <cf6b1264-8639-46e7-8dae-5aff0306e958@vrvis.at>
Date: Fri, 9 Feb 2024 12:06:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>,
 1063338@bugs.debian.org, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, gregkh@linuxfoundation.org,
 regressions@lists.linux.dev
Subject: Re: [regression 6.1.76] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
Content-Language: en-US
To: Jordan Rife <jrife@google.com>
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan>
 <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
 <1d4c7d06-0c02-4adb-a2a3-ec85fd802ddb@vrvis.at>
 <CADKFtnQUQt=M32tYhcutP0q6exOgk9R6xgxddDdewbms+7xwTQ@mail.gmail.com>
 <CADKFtnQnz0NEWQT2K1AGARY5=_o2dhS3gRyMo-=9kuxqeQvcqQ@mail.gmail.com>
From: Valentin Kleibel <valentin@vrvis.at>
In-Reply-To: <CADKFtnQnz0NEWQT2K1AGARY5=_o2dhS3gRyMo-=9kuxqeQvcqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

> Would you be able to confirm that the attached patch fixes your issue as well?

Yes it does.

@debian maintainers: is it possible to include this patch in the next 
point release?

Thank you for your work,
Valentin

