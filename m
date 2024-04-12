Return-Path: <linux-kernel+bounces-143413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DD8A389D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB83DB2288F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14D41494A1;
	Fri, 12 Apr 2024 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Vh1cDWep"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D76199B0;
	Fri, 12 Apr 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712961707; cv=none; b=Sy2DUGMkKZz3aV5dObPTj/7A7yV1PXwfqM1G/h8yUwd4RluhfCmxUvLryDff2mt233IprhjdGVxUrjkaKhetMyTghM9Ge858d9Ruq6MrGYYTYqaPCgpp+lbIfJoVV+0SwCt333MtuWTgZbbySWH843dNkws8DK98/uELrz0ij5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712961707; c=relaxed/simple;
	bh=d01sFWMNY6a5XivqzMMU563V1spLodoyo8ZrymDB7ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYkA/Fl3c0gJ480tQ/iGzg/Jsm7CFMJarmvP/525HJ8Kdajc1PhxeEBM9dr2lKr1qVSh1o/xzVR93ajBquLqgz6l33KnNvAkSuEOkdl7cMRad4YFjezIU1cVWJIh9ikXPjTbVNEUysMqx2pOO1jpNXiPjJIqtrs1dvkMzAp2AUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Vh1cDWep; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VGWl741yKz6Cnk8t;
	Fri, 12 Apr 2024 22:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712961697; x=1715553698; bh=fYguIvZmJIb2TUXHYrG6frK4
	BRkxztbHQmXUidBOhRk=; b=Vh1cDWep0/G7QfcgRWMqwgStJR7BcFauTD0vOpGu
	5L/n4QLowlIL/OTIcOHV917C0ToI1xhV5Mng7RyzttDMXEOUg+jiWxHB7ZIhtr1G
	php3JEqSm+PSXQw8BPIyFZMXQ1CqORLs2nsAQQOs3TXHXi5nOI1vyvcnR/m9hUsU
	gNHYDRjahRMt52WlWLRH/K1c9WcjNl9FxNjMeeE7wAQiJDE/snYknrOHoMa7nT8A
	KI4zRFh0I18I2jTBHvoSr3DADEXqhFPAMPuo2aUKLO+xH0yQtOaRthqmJ6C7iOtn
	vCbdLP2jmynnHAJ+aiNF53hKJzz0WaMCsSLBMnAh8offUA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KkPfYSOjsqdc; Fri, 12 Apr 2024 22:41:37 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VGWl52XbVz6Cnk8m;
	Fri, 12 Apr 2024 22:41:36 +0000 (UTC)
Message-ID: <37519dbb-ea60-49f8-a77b-4109cf616ed1@acm.org>
Date: Fri, 12 Apr 2024 15:41:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: sd: Only print updates to permanent stream count
To: John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240412094407.496251-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240412094407.496251-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 2:44 AM, John Garry wrote:
> Just rescanning a partition causes a print similar to the following to
> appear:
> [    1.484964] sd 0:0:0:0: [sda] permanent stream count = 5
> 
> This is bothersome, so only print this message for an update.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

