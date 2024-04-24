Return-Path: <linux-kernel+bounces-156510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CAC8B038C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E256B22868
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4877158218;
	Wed, 24 Apr 2024 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="nVZa8yK/";
	dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="nVZa8yK/"
Received: from smtp.ivitera.com (smtp.ivitera.com [88.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F51581FB;
	Wed, 24 Apr 2024 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.101.85.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945335; cv=none; b=oG2j4S5soeauxaaxdB2uz3N4T1WU6P2I6+zhFnpoAWIJmVO/9Hc51gYn42GyW615q5oI+z/Hz5GWFI490kyt89sdngIUq5ebvPdcUVYN7KIQCslVWpbR9syT78QlmG2msJj7P1jUefIGIWIoOisuZknPiAwazG9MhqFCGJLjMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945335; c=relaxed/simple;
	bh=NNQ3HLb0v99awGjFWIkxNZ/8CBlj1+lvLPyh6ShnZ7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NO5UPRXT6RIay7+Iyy0Aa3thM/CuK6NcLQQ52aCle/c9dAV0yseL0CvWnsGlYilQ7r5Kzzb9yMZS+8D9bfsya5gt8Nzu9tHyMJxOv/IXNgI24odLotC+TzoMiPJ6uv4m5wVlccez8HHiPctQby+ECKNS9mGbn2taL5nvV+eZ4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ivitera.com; spf=pass smtp.mailfrom=ivitera.com; dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b=nVZa8yK/; dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b=nVZa8yK/; arc=none smtp.client-ip=88.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ivitera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ivitera.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.ivitera.com (Postfix) with ESMTP id 9DEA8170DD2;
	Wed, 24 Apr 2024 09:55:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
	t=1713945330; bh=NNQ3HLb0v99awGjFWIkxNZ/8CBlj1+lvLPyh6ShnZ7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nVZa8yK/ZLHki+moAtSxnn48z1AN9oiZpUFPJ9TZWOUX7J8hXkFSqNCdAfuk4vJVu
	 FktYKLH7Jc/BF882Q1ECKaaz9XFwmh4ATrYaNcCU0zssAmkugXO4vHZ9tQBNTh8HA/
	 KOn2DFu4UeI1DWdbKttc5u0oTy0W75Wo7+c0G6z4=
Received: from smtp.ivitera.com ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rHo5XKKDmSGk; Wed, 24 Apr 2024 09:55:30 +0200 (CEST)
Received: from [192.168.105.22] (dustin.pilsfree.net [81.201.58.138])
	(Authenticated sender: pavel)
	by smtp.ivitera.com (Postfix) with ESMTPSA id 0B33C170DCF;
	Wed, 24 Apr 2024 09:55:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
	t=1713945330; bh=NNQ3HLb0v99awGjFWIkxNZ/8CBlj1+lvLPyh6ShnZ7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nVZa8yK/ZLHki+moAtSxnn48z1AN9oiZpUFPJ9TZWOUX7J8hXkFSqNCdAfuk4vJVu
	 FktYKLH7Jc/BF882Q1ECKaaz9XFwmh4ATrYaNcCU0zssAmkugXO4vHZ9tQBNTh8HA/
	 KOn2DFu4UeI1DWdbKttc5u0oTy0W75Wo7+c0G6z4=
Message-ID: <9b40e148-f3eb-f8f5-bf2d-37a0a0629417@ivitera.com>
Date: Wed, 24 Apr 2024 09:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors
 through configfs.
Content-Language: en-US
To: Chris Wulff <Chris.Wulff@biamp.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Gruber <jimmyjgruber@gmail.com>, Lee Jones <lee@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
References: <CO1PR17MB54195BE778868AFDFE2DCB36E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
 <c9928edb-8b2d-1948-40b8-c16e34cea3e2@ivitera.com>
 <CO1PR17MB541989646698286B2B13CF23E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
From: Pavel Hofman <pavel.hofman@ivitera.com>
In-Reply-To: <CO1PR17MB541989646698286B2B13CF23E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23. 04. 24 19:22, Chris Wulff wrote:
>> From: Pavel Hofman <pavel.hofman@ivitera.com>
>> Sent: Tuesday, April 23, 2024 11:38 AM
> 
>>> +             p_it_name               playback input terminal name
>>> +             p_ot_name               playback output terminal name
>>> +             p_fu_name               playback function unit name
>>> +             p_alt0_name             playback alt mode 0 name
>>> +             p_alt1_name             playback alt mode 1 name
>>
>> Nacked-by: Pavel Hofman <pavel.hofman@ivitera.com>
>>
>> I am not sure adding a numbered parameter for every additional alt mode
>> is a way to go for the future. I am not that much concerned about UAC1,
>> but IMO (at least) in UAC2 the configuration method should be flexible
>> for more alt setttings. I can see use cases with many more altsettings.
>>
>> My proposal for adding more alt settings
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@ivitera.com/__;!!HBnMciuwfVSXJQ!TYg7j7-fh3eZAzPfiONi2lo54mf2qsWtpG0nwdaQwSqd1nGdKkTDN8o6_lSIWlWPtHoc-2Nz1KCbRhiXJnzXO8Ku1w$
>> suggested using lists to existing parameters where each item would
>> correspond to the alt setting of the same index (+1). That would allow
>> using more altsettings easily, without having to add parameters to the
>> source code and adding configfs params. I received no feedback. I do not
>> push the param list proposal, but I am convinced an acceptable solution
>> should be discussed thoroughly by the UAC2 gadget stakeholders.
>>
>> I am afraid that once p_alt1_name/c_alt1_name params are accepted, there
>> will be no way back because subsequent removal of configfs params could
>> be viewed as a regression for users.
> 
> I have been thinking about this as well. The alt names are slightly different than the rest of the settings
> since they also include alt mode 0. I was thinking p/c_alt1_name could be expanded to the array so 
> that the entries line up with the other settings and don't have an extra entry for alt 0. Perhaps a different
> name would make more sense.
> 
> Along those lines, I didn't see any gadget drivers using an array of strings for anything, which is also why
> I didn't try to do anything here that merged alt0/1 names into an array. If we were to do an array of strings
> I'm not sure what the best separator would be. Maybe ";"? The rates array uses ",".
> 
> This patch only exposes the existing strings to make them configurable, but I don't want to do anything
> that would preclude a nice interface for extra alt modes.
> 

Thanks a lot for your response. Please can you take a look at
https://lore.kernel.org/linux-usb/72e9b581-4a91-2319-cb9f-0bcb370f34a1@ivitera.com/T/#m68560853b0c7bc2478942d1f953caa2ac95512bd
?

If the params in the upper level were to stand as defaults for the
altsettings (and for the existing altsetting 1 if no specific altset
subdir configs were given), maybe the naming xxx_alt1_xxx could become a
bit confusing. E.g. p_altx_name or p_alt_non0_name?

Thanks a lot,

Pavel.

