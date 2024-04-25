Return-Path: <linux-kernel+bounces-158985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3458B27D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4027BB22710
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927F014EC65;
	Thu, 25 Apr 2024 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b="EfXUwpCx"
Received: from dianne.skoll.ca (dianne.skoll.ca [144.217.161.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AE14D6F5;
	Thu, 25 Apr 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.161.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068102; cv=none; b=Kx93sUekuYPmOtRwE6sOJnU5omlbZSpeDLlaZ7yCfhPCgvBQneujDkRN/5Ft8kJLx7u/phm3eLq/coA+kNuwobdUldTDjFKll6wvzUPjGlxL67fdm7Zcqoyby3s6oJGXbskh2HX+FKYN5NSLU85F29yqaxmSzaVU3OlMw+YVSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068102; c=relaxed/simple;
	bh=yROvrMGxA5Hq3KQWM6Ddf1MRoTh0VBsOTNKKWERY6fI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlFI1maFCxm112jCAIn3Uw+9RyMkQ0/Vduczsbmgw50nAXQ4CGzPHqZL9yzwEgHxE5epwhGNUGTBzKyJjTMZHT+Ilpnsdk29XrZlZeQoT6umL/Xz5oDXOVnVuxHrbZRofmLACzttBbl69XJ0qPuEfvvLO1gJzlnm+BoNX6WJSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca; spf=pass smtp.mailfrom=skoll.ca; dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b=EfXUwpCx; arc=none smtp.client-ip=144.217.161.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skoll.ca
Received: from pi4.skoll.ca ([192.168.84.18])
	by dianne.skoll.ca (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 43PI1UgI721671
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 14:01:30 -0400
Received: from gato.skoll.ca (gato.skoll.ca [192.168.83.21])
	by pi4.skoll.ca (Postfix) with ESMTPS id 4VQNvs0MD8zgd52Y;
	Thu, 25 Apr 2024 14:01:29 -0400 (EDT)
Date: Thu, 25 Apr 2024 14:01:27 -0400
From: Dianne Skoll <dianne@skoll.ca>
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
 <jirislaby@kernel.org>
Subject: Re: N_HDLC line discipline: Race condition
Message-ID: <20240425140127.6504ade1@gato.skoll.ca>
In-Reply-To: <20240424173114.035ddd7b@gato.skoll.ca>
References: <20240424173114.035ddd7b@gato.skoll.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skoll.ca; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=canit2;
	 bh=AtzusXASmGxpKWKdChT5V9sPaGKWV7wEwpSGcofA2mc=; b=EfXUwpCxhNb8
	cBunjukjBRdR0lSvmZxeBJyrBo+CbZUiV7zsrcq1c8+pXxwwyPVhF3O7/I2smnF7
	GD2Ge4B4AQ1QAjGy1pXVEg2c6kEhD/c8hMRgRP7IgHRMht2mkIOk9pYR+c7Y8Hno
	v64c7AxecySSZhNX1oFdIOwaXA/ZBVlkF7YeYZWtT/GIjl4zYrOD2S4mbHZq/2zl
	oR4sgWl8wmnmF/KtklSi7gBzbjoKOYfkH34g4nP46BysrgUO3UHyHbxDAZXDeLSL
	jRpP52WAgZrhOz+Tyuolej98kSvKKRfBNa6qw0z3KYrjXlsUO8xBT9SG7qHenUtw
	3jyPLnfXDg==
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: mailmunge 3.16 on 192.168.83.18
X-Spam-Score: undef - relay 192.168.84.18 marked with skip_spam_scan
X-CanIt-Geo: No geolocation information available for 192.168.84.18
X-CanItPRO-Stream: outbound (inherits from default)
X-Canit-Stats-ID: Bayes signature not available
X-CanIt-Archive-Cluster: tWKWaF/NcZkqjWIj0BEJTBHJhwY
X-CanIt-Archived-As: base/20240425 / 01cfu1u2O

Hi,

I have (somewhat) narrowed down when the kernel bug appeared by installing
Debian 10, 11 and 12 in KVM virtual machines.

The bug is NOT present in Debian 10, kernel version 4.19.67.

The bug IS present in Debian 11, kernel version 5.10.209

The bug IS present in Debian 12, kernel version 6.1.85

So I guess it was introduced sometime between 4.19.67 and 5.10.209.  I'll
take a look to see if I can do a git bisect.

[To recap, the bug is that the N_HDLC line discipline sometimes
coalesces two write()s so you get them both back in a single read()
which is contrary to what it's supposed to do... preserve the write
boundaries as individual frames.]

Regards,

Dianne

