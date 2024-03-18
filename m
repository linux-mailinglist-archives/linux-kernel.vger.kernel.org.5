Return-Path: <linux-kernel+bounces-106657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1187F19F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4AB8B217A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D0C58218;
	Mon, 18 Mar 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="onnCPRbH"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3443AA3;
	Mon, 18 Mar 2024 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795506; cv=none; b=qkk7EF87iB6TKPXcS0KX/mtxUZv/FQMdMldPGmw0Nddc+vQTfpwlcuvb/E1qXr10xJIZVxZyj26xAqBkyK0OLidD2Fnob3yzdSWZ/zBf/TAfNP8fYFaVZzvBSQ8OSRwcDGqYS3mwhS2eqfJ9s858dGeKRDKN9jFznh2fzQl/lXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795506; c=relaxed/simple;
	bh=iBeE7+uw1+a5Vgld1wKCLp+1aV7VFk9n2FjdtnYxOC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0nTymvf2sb3R/jblFnKttfCRmvQ+ZcOyf1hOgFOmVrSWVSAlIY4E9KowAPupOgrPUndqyYxkjtmzHNHiv0ZICy1fGSW7ggtFnFbDSZtP6kX7z7/qUvHtTid7uMFYghK99ZvaWKOCqJrif91pOFPYzen4xyY3Wu7y9nP4X6MDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=onnCPRbH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id E7B8820B74C0;
	Mon, 18 Mar 2024 13:58:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7B8820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710795504;
	bh=VwjmcstDx+NgU9BBFPDxpbqSu2gppqDHoUWpsVz/Th0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=onnCPRbHf1Ctws2/MdDiXWRWVU/AtpyiqTCWaP9IGfzEKNsiBab2QiD70n2xNWdiE
	 +iMmKlhUXXPx2YJll5Q9m9B6+1hqBB2jN6iRC/N/plU/BbpF12cOc5b4kBRfN/EhVJ
	 FocQoZ2pW//0/MyUBBIDG10lyLap3A58o8x5R6ow=
Message-ID: <02453956-46d0-40f4-9e20-1bb0808996bb@linux.microsoft.com>
Date: Mon, 18 Mar 2024 13:58:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v15 18/21] ipe: enable support for fs-verity as a
 trust provider
Content-Language: en-CA
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Eric Biggers <ebiggers@kernel.org>
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
 <53a067f80db2e53ae29dc811515ab51c6ef86aed.camel@huaweicloud.com>
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <53a067f80db2e53ae29dc811515ab51c6ef86aed.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/18/2024 1:08 AM, Roberto Sassu wrote:
> On Sun, 2024-03-17 at 22:17 -0700, Eric Biggers wrote:
>> On Fri, Mar 15, 2024 at 08:35:48PM -0700, Fan Wu wrote:
>>> +config IPE_PROP_FS_VERITY
>>> +	bool "Enable property for fs-verity files"
>>> +	depends on FS_VERITY && FS_VERITY_BUILTIN_SIGNATURES
>>> +	help
>>> +	  This option enables the usage of properties "fsverity_signature"
>>> +	  and "fsverity_digest". These properties evaluate to TRUE when
>>> +	  a file is fsverity enabled and with a signed digest
>>
>> Again: why would anyone care if there is a signature, if that signature is not
>> checked.
>>
>> I think you meant to write something like: "when a file is fsverity enabled and
>> has a valid builtin signature whose signing cert is in the .fs-verity keyring".
> 
> I was also thinking the same. I didn't follow the recent development
> closely, but unless IPE locks somehow the .fs-verity keyring, the
> property you suggested would not be immutable. Meaning that someone can
> add/remove a key in that keyring, making the property true or false.
> 
> Roberto

Yes, the .fs-verity keyring's mutability could affect the property's 
immutability. However, we are not planing to "lock" the keyrings, but we 
would like to use policies languages to express what certificate can be 
trusted.

For example, we can have a rule like this:

#Certificate declaration
CERTIFICATE=MyCertificate CertThumbprint=DummyThumbprint
op=EXECUTE fsverity_signature=MyCertificate action=ALLOW

This will be our immediate next work after the initial version is accepted.

-Fan


