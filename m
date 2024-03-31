Return-Path: <linux-kernel+bounces-126346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD31893560
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02287285488
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2A4145B0D;
	Sun, 31 Mar 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="aUurXb28"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DD145350
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711909392; cv=none; b=I0hUgOGMGJeGqWsL1cGqX2WrLO7vR6iD3DdtJZwnXAZvhQ5PD2jmLKC4m+1JAcPGWxaM70Nj29RW+VQCYBjwgjAVAn016d/xOYthZkRgwq9drOkPyZepbgL02kEQQEYT91Vhwk1QNbr/cbCTPIMDAsxAM49OeWdx+LN4wsNBN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711909392; c=relaxed/simple;
	bh=/Szu4y/TJfsv6oreafiiKkyjVcOjHo0V9DLU872ZZVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVrGnX3vgyvI2If0wYqtELD2+ilm+T/XfOv3Jrb0GZEi/kaVaI6f2MwK1sCK2bBVIl6nxzX96ZRNuSl3JsccqoCD+n6Jd1QbsgCidAIg+1Xp5DYMNBlGOoZ+14hsoWMgXmtfPohPpcvCvdlkNSMZq5HBugIRiS/vfnLq8JDURd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=aUurXb28; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
Message-ID: <4fe2450a-51ca-4161-9006-1325c2a16c07@kl.wtf>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1711909387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7wRlXzH8Qg7MRMYfnkHVzDjrc+zYR1Im/3e5jSkqlo=;
	b=aUurXb28LAngzLnQxRXGi+jOh7Zv+SUJc51h3qolL13q94pYE5VYpznT2MPDDS4BfrIBPp
	lYmbobVb42wSI0YbbIxgLgsCJ0i9helTz8xOWKXrkSD5nB/wjsUKIHPv0TNguWQS28cZ68
	WNGHabxkyBdI38ZxgYQl7CUPebwGPpCdeZDWsLMF6DqYs+zaJ+mLjD+SwtqlItLDUVQrP8
	JrH/eZXEHR0tgO5hVzCgsEceE+lJDi0RKVpql+bIJ5C8IEyZ23Ii9rTg14px+O/EalhZs4
	CeCENG3gRUvIiqUp+79AAiigFrgS8k+x5tHQzUfuJToyGMdDFSJZGn/VM+/pGw==
Date: Sun, 31 Mar 2024 20:23:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] HID: i2c-hid: Revert to await reset ACK before reading
 report descriptor
To: Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Douglas Anderson <dianders@chromium.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240331132332.6694-1-kl@kl.wtf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kenny Levinsen <kl@kl.wtf>
In-Reply-To: <20240331132332.6694-1-kl@kl.wtf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/31/24 3:23 PM, Kenny Levinsen wrote:
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 2df1ab3c31cc..be5d661dde41 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -737,7 +737,9 @@ static int i2c_hid_parse(struct hid_device *hid)
>   		ret = i2c_hid_start_hwreset(ihid);
>   		if (ret)
>   			msleep(1000);
> +		ret = i2c_hid_finish_hwreset(ihid);

Ah, missed the check to only call i2c_hid_finish_hwreset if 
i2c_hid_start_hwreset succeeded, v2 incoming.


