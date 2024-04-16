Return-Path: <linux-kernel+bounces-147456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B738A7474
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D88C9B21D66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0940A137C33;
	Tue, 16 Apr 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hRwywDWs"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114A136E0A;
	Tue, 16 Apr 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294972; cv=none; b=Q0Ds0uTGbTISYpmgvRxnj0ghA39DlUpHQLWA3vDRQrBL+4pjo/lqqa8JVo5K1sIUJNfrkvcE+eekcFKFpApdOqorxV+GlG7ciJ917vIGtoeNfHlIsepgmttubhDTvrEObWhsX7X2hNFOPAw99+9fDf6wTebzSV5EbuVykFADngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294972; c=relaxed/simple;
	bh=x4epH4lPIIcIypeWgEsK/u6oozo9tz1rWzsjmyugMp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMa+X857xvqQw+z8WKvfREQ9AZkQkLHxxXyrhMrwHFOaBR20ov1hi2pG7EbnZxQP+iDhPjnYlrdl8KZAfrQJHOzf1XQP+lFkpxPRdvNjSLUQxTSe8EzX45EAScNyNIs2yeSvPUH04Tf4A1ivEjRj/AXH7ySIjGciUcYR+Ej4Ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hRwywDWs; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VJv044lxgz6Cnk8s;
	Tue, 16 Apr 2024 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1713294962; x=1715886963; bh=QQRuCRfKL482skjqT5kocQ8C
	I6EnKx1efQEktqxG58U=; b=hRwywDWsj1mdBrfxH7cxg9pqvsadWN3fhMyXdS0y
	B5JcftNYU3mUZdyJZjvoXBhLcXhlghq7eH37r0919YNSCb9LkBuq+bhVbqhOLg0t
	8oRxnbJfuDPL1ZQSocloUX59DiTnwzyvw77kd2cl06YVU6UkZKhDtaqnBbLEiXSd
	+CSu/eT2qaAajxWO68H6HmmDTeRqx+4K22984cGE2fP0zw5633I4cU0lduIJh+Jh
	5XI2UwMwshlrgcS+XdzJGlK6o106HLQ/5aKpxZS+2UMGjkxv1C+5Xt9aluJ9Xune
	D3pqrQZfFlqEbs0bV0884RSGqcxhUC+8ExkhGCpVsjBHZg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sHzjJj6w1wNT; Tue, 16 Apr 2024 19:16:02 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VJv0161qNz6Cnk8m;
	Tue, 16 Apr 2024 19:16:01 +0000 (UTC)
Message-ID: <2bbd7e84-aee3-4c36-9cae-791b4f4d5a82@acm.org>
Date: Tue, 16 Apr 2024 12:16:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] simplify ufshcd with the guard() macro
To: Avri Altman <avri.altman@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240416102348.614-1-avri.altman@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240416102348.614-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 03:23, Avri Altman wrote:
> We can simplify the code with the guard() macro and co for  automatic
> cleanup of locks. For making changes easier, this series is divided to
> per-lock type patches and only address the ufshcd module. There are
> still a few remaining explicit lock/unlock calls, and those are for the
> places where we do temporary unlock/relock, which doesn't fit well with
> the guard(), so far.

Why to use only the existing primitives? Several error paths could be 
eliminated if new macros would be included for e.g. automatically
calling ufshcd_release() at the end of a scope.

Bart.


