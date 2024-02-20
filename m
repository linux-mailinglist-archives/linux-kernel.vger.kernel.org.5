Return-Path: <linux-kernel+bounces-73559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1026585C42B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900DA1F234D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791D3134CEF;
	Tue, 20 Feb 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="ATJl2TiW"
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B667762E4;
	Tue, 20 Feb 2024 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455543; cv=none; b=MFIdKFQDSDuI/W4qaxBNyLPMuwPgItIU8nUoNYXjYq1TD3Ahk8w4T9frjXqpH5jpRKVWK1RH+wp5rg9xvuCJ3lJ3DCw+Pcm0R7snpZP6lO4F9z6bOYioG/Hi55O5hKkTCeuG0KeZVoz3U10pt3YSWEL2oJ4SWKsUQqQOpQJ3qAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455543; c=relaxed/simple;
	bh=nQhCy9Z6IkfDzhaAFtGmFDQQ4coSnEEVrK1GWZy5cT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VLTGrqC22F2lBbNpxw/ZhkZtwJr3CHyNF+R4MbGDPkpeSzIqY89EF+CmEmyeY+WU6LvcOlEP8pFqlP6Zd3jCv/x7W4XejyImdVYyhe3js0LM3MviK+jkPH3cWz3RXNMHEdmCDTjnY9+Tkev9q9Q0P0Ix5Xw3GXZGRKBPyrKisyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=ATJl2TiW; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1708455542; x=1739991542;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nQhCy9Z6IkfDzhaAFtGmFDQQ4coSnEEVrK1GWZy5cT4=;
  b=ATJl2TiWdVdj7T+fspC0OdqdDoDUwUSW6/lLQrMvQNZzE8whscezHQub
   pss9jGlKlrdD9++C3Sc0b2jzvgIgxZ1BdOaDi6eeTGfVrAB3PCeXKmEeJ
   vNWDL33dLm8TeRQmGV18HAhvDFcr40JX1e3g8rF5K7CwT4BUTihfaTvhr
   U=;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="48972462"
X-IronPort-AV: E=Sophos;i="6.06,174,1705359600"; 
   d="scan'208";a="48972462"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 19:57:51 +0100
Received: from MUCSE844.infineon.com (172.23.7.73) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 19:57:50 +0100
Received: from [10.165.32.120] (10.165.32.120) by MUCSE844.infineon.com
 (172.23.7.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 19:57:49 +0100
Message-ID: <33838539-62ec-43d0-8223-b3d5df4bf8f6@infineon.com>
Date: Tue, 20 Feb 2024 19:57:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tpm: make locality request return value consistent
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Jarkko Sakkinen
	<jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ross Philipson <ross.philipson@oracle.com>, Peter Huewe
	<peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-4-dpsmith@apertussolutions.com>
 <CYU3XUGOX6QT.1GL070ONNPBWQ@suppilovahvero>
 <80d95a08-a1c1-44a7-959c-8bff14254608@apertussolutions.com>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <80d95a08-a1c1-44a7-959c-8bff14254608@apertussolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MUCSE820.infineon.com (172.23.29.46) To
 MUCSE844.infineon.com (172.23.7.73)

On 19.02.2024 21:29, Daniel P. Smith wrote:
> On 2/1/24 17:49, Jarkko Sakkinen wrote:
>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>>> The function tpm_tis_request_locality() is expected to return the 
>>> locality
>>> value that was requested, or a negative error code upon failure. If 
>>> it is called
>>> while locality_count of struct tis_data is non-zero, no actual 
>>> locality request
>>> will be sent. Because the ret variable is initially set to 0, the
>>> locality_count will still get increased, and the function will return 
>>> 0. For a
>>> caller, this would indicate that locality 0 was successfully 
>>> requested and not
>>> the state changes just mentioned.
>>>
>>> Additionally, the function __tpm_tis_request_locality() provides 
>>> inconsistent
>>> error codes. It will provide either a failed IO write or a -1 should 
>>> it have
>>> timed out waiting for locality request to succeed.
>>>
>>> This commit changes __tpm_tis_request_locality() to return valid 
>>> negative error
>>> codes to reflect the reason it fails. It then adjusts the return 
>>> value check in
>>> tpm_tis_request_locality() to check for a non-negative return value 
>>> before
>>> incrementing locality_cout. In addition, the initial value of the ret 
>>> value is
>>> set to a negative error to ensure the check does not pass if
>>> __tpm_tis_request_locality() is not called.
>>
>> This is way way too abtract explanation and since I don't honestly
>> understand what I'm reading, the code changes look bunch of arbitrary
>> changes with no sound logic as a whole.
> 
> In more simpler terms, the interface is inconsistent with its return
> values. To be specific, here are the sources for the possible values
> tpm_tis_request_locality() will return:
> 1. 0 - 4: _tpm_tis_request_locality() was able to set the locality
> 2. 0: a locality already open, no locality request made
> 3. -1: if timeout happens in __tpm_tis_request_locality()
> 4. -EINVAL: unlikely, return by IO write for incorrect sized write
> 
> As can easily be seen, tpm_tis_request_locality() will return 0 for both
> a successful(1) and non-successful request(2). And to be explicit for
> (2), if tpm_tis_request_locality is called for a non-zero locality and
> the locality counter is not zero, it will return 0. Thus, making the
> value 0 reflect as success when locality 0 is successfully requested and
> as failure when a locality is requested with a locality already open.

There is a potential problem here, but I think it is slightly different 
from what you describe: Currently, the kernel uses only locality 0, so 
case 1 and 2 are indistinguishable for the caller. Getting a return 
value of 0 simply means that the requested locality is now active. The 
callers don't care whether it had already been active before or not, so 
it is not a problem that the callers cannot distinguish case 1 and 2, 
and a return value of 0 always indicates "success".

It might only become a problem once you make the kernel use localities 
!= 0. Then a caller can get either 0 as the return value (if the 
locality was already active before) or the requested locality, and both 
values mean "success". In practice, this shouldn't cause any problems as 
far as I can tell, because all existing callers either check only for 
failures (negative return values), e.g. 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/tpm/tpm_tis_core.c?h=v6.8-rc5#n1214, 
or explicitly request locality 0 and check for a return value of 0, e.g. 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/tpm/tpm_tis_core.c?h=v6.8-rc5#n750. 
There is no caller that would be confused by case 2 because it requests 
an arbitrary locality and always expects that locality to be returned in 
order to indiciate "success".

Still, such an inconsistency is not nice and should be fixed, but if I 
read your patch correctly, this is not what it does: In 
tpm_tis_request_locality(), you initialize ret with -EBUSY. For 
locality_count != 0, you never assign to ret again and therefore return 
-EBUSY, even though the locality is active and can be used. The correct 
fix would be to initialize ret with l, so that no error is returned in 
such cases.

> As for failures, correct me if I am wrong, but if a function is
> returning negative error codes, it should not be using a hard coded -1
> as a generic error code. As I note, it is unlikely for the -EINVAL to be
> delivered, but the code path is still available should something in the
> future change the backing call logic.
> 
> After this change, the possible return values for
> tpm_tis_request_locality() become:
> 1. 0 - 4: the locality that was successfully requested
> 2. -EBUSY: tpm busy, unable to request locality
> 3. -EINVAL: invalid parameter
> 
> With this more consistent interface, I updated the return value checks
> at the call sites to check for negative error as the means to catch
> failures.
> 
> v/r,
> dps
>

