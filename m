Return-Path: <linux-kernel+bounces-106637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBE287F156
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16131F244F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAB45788C;
	Mon, 18 Mar 2024 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P+T8Utrr"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BFE58206;
	Mon, 18 Mar 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794444; cv=none; b=Zyjkk89tCKJcoj6nF/8So9VWvrozeeWzUHqUJykDhIjmTB931ylTH2XqaSguHJkNb4LqjjxwFXSmBfeSydFeG5ux61nhxPaiSdP07MwVGouxVmthgGdK3jSqcXF5g9WPmSuSGN0JDub/qiDhzSJqZ9uWTGrtlqYMlXK/gioP/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794444; c=relaxed/simple;
	bh=mn4Xz1ZtJYWIfNb4PThhTYu0EooQbh05dxo1V6xh/po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYpt81zeEM15RaerQEqJuaN/T2AQNJ4Ern3gRByteAbf9Om13hiWoVQWtVISyyEp+bIwJkBBdmI8yDICFZ2tfODldWKsv3i2HO7xEv105bhAmUmpGfUC7w36qtMbWDmR3KA2tGYQSYHFQR5nqqtIxvBBPTsTGUp8mGaQ8Bjk0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P+T8Utrr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B38B20B74C0;
	Mon, 18 Mar 2024 13:40:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B38B20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710794442;
	bh=k0/I7p41f3QocEgsxb/Pps2tOnOrvwXWMYTG9ZCpr8M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P+T8UtrrP2wCtmdJ07oc3BDruPa8P5MIkG92h75fdRPvWL8DDBKRFVNqqr5+UyeQD
	 ooCeQJRHYKzrv7CB7fiaFoTGzm5swxy4FXiUU5m7RejK1zt0qWh+Yvh3Y/Q7OgT8bn
	 MuD2Vel7eb5QgWibwRXsNWgrHkiyiUoe4ynUfMu4=
Message-ID: <59357d13-c980-4f5a-a9e1-6ad6e480d46e@linux.microsoft.com>
Date: Mon, 18 Mar 2024 13:40:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v15 18/21] ipe: enable support for fs-verity as a
 trust provider
To: Eric Biggers <ebiggers@kernel.org>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
 tytso@mit.edu, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
 eparis@redhat.com, paul@paul-moore.com, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 fsverity@lists.linux.dev, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
 <1710560151-28904-19-git-send-email-wufan@linux.microsoft.com>
 <20240318051703.GB63337@sol.localdomain>
Content-Language: en-CA
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20240318051703.GB63337@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/17/2024 10:17 PM, Eric Biggers wrote:
> On Fri, Mar 15, 2024 at 08:35:48PM -0700, Fan Wu wrote:
>> +config IPE_PROP_FS_VERITY
>> +	bool "Enable property for fs-verity files"
>> +	depends on FS_VERITY && FS_VERITY_BUILTIN_SIGNATURES
>> +	help
>> +	  This option enables the usage of properties "fsverity_signature"
>> +	  and "fsverity_digest". These properties evaluate to TRUE when
>> +	  a file is fsverity enabled and with a signed digest
> 
> Again: why would anyone care if there is a signature, if that signature is not
> checked.
> 
> I think you meant to write something like: "when a file is fsverity enabled and
> has a valid builtin signature whose signing cert is in the .fs-verity keyring".
> 
> - Eric

Thanks for the suggestion. I agree this is a more accurate description. 
I'll update the description to include these details.

-Fan

