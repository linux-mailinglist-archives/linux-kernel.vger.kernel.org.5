Return-Path: <linux-kernel+bounces-111988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FAE8873CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246F4B22DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE9F79B65;
	Fri, 22 Mar 2024 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RBf0ivVv"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438679924;
	Fri, 22 Mar 2024 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135366; cv=none; b=cpA1MGiGVNI+w6NC+W2rTlblHMn8y26BIyqjzaZtGyfeYKl3ocllALq7PXhx2EC0CW6M38FF8PRKNOzAGROgxhLDJhrQ6/jW6ch8z0QsnvfA70MR8Gv8eHTbnP+FLolqFzyVpDskE16+8H0Czdv6WGuRHAYm6OcGyraYjc4Oh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135366; c=relaxed/simple;
	bh=BUz5hK96G+jleUn15ldF4ameZxFw2z69VYrq+t9w4a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pb6TN6gUJzJX3/4ku9CCD8ax/sVUOQFpA+IWFgfmGv+N6KFJjOZBV/ruOz6CJxM+LU3IovkuzdzhqoG5r1QrpGgNIro7/IyWglGwvwLZFNzbp2hk9q4kSpY7IpqRldRw11zz5wsmKCWeBzEUGchyJdfzAUHgoxymDfC7dT38wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RBf0ivVv; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V1XKH5p80zlgVnF;
	Fri, 22 Mar 2024 19:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711135355; x=1713727356; bh=FI4Z6ZgHS15qtNLhRTTVJj5+
	StHISvSkt2DHgw+Aldg=; b=RBf0ivVv7aAbjp3GUFo3+Fb23Fs8iMz79BTY+mUS
	EarP+Luey+lgFSgqlWVpFMnI8934ZRjKGYBsQPV0/uDEF2I/ioeqPDiIvStU5EQy
	YZy4csacStuJhxZhB+s2GHvbfAoqE3BlM720eGX2QDh6zyTAewKYwV7f5FHKF80Z
	HtHD2I1z8V+3I7isZfr9IQkxE2RLv9bhUeo5VRAWnkbLZButB2Neg0khwa3NnKF+
	nvkiPImFUpBkLDtJGfA1ADUzwaZVe0tU5craHZgAmX7UgaX6QOIzvePFsy66yZb7
	rC6fXjyxw3vKuN3wV+nx5gx9Ax294Tdaam87uhfxQBAxuA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GAB01t24zNHL; Fri, 22 Mar 2024 19:22:35 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V1XK5106BzlgTGW;
	Fri, 22 Mar 2024 19:22:33 +0000 (UTC)
Message-ID: <192acb8f-47b8-426c-bcc9-ef214a797f26@acm.org>
Date: Fri, 22 Mar 2024 12:22:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] block: add new genhd flag GENHD_FL_NVMEM
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>,
 Jan Kara <jack@suse.cz>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Damien Le Moal <dlemoal@kernel.org>,
 Li Lingfeng <lilingfeng3@huawei.com>, Christian Brauner
 <brauner@kernel.org>, Christian Heusel <christian@heusel.eu>,
 Min Li <min15.li@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
 Christian Loehle <CLoehle@hyperstone.com>, Bean Huo <beanhuo@micron.com>,
 Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <cover.1711048433.git.daniel@makrotopia.org>
 <89abd9ab93783da0e8934ebc03d66559f78f6060.1711048433.git.daniel@makrotopia.org>
 <7027ccdc-878a-420e-a7ea-5156e1d67b8a@acm.org>
 <Zf3I6DDqqyd924Ks@makrotopia.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zf3I6DDqqyd924Ks@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 11:07, Daniel Golle wrote:
> On Fri, Mar 22, 2024 at 10:49:48AM -0700, Bart Van Assche wrote:
>> On 3/21/24 12:33, Daniel Golle wrote:
>>>    enum {
>>>    	GENHD_FL_REMOVABLE			= 1 << 0,
>>>    	GENHD_FL_HIDDEN				= 1 << 1,
>>>    	GENHD_FL_NO_PART			= 1 << 2,
>>> +	GENHD_FL_NVMEM				= 1 << 3,
>>>    };
>>
>> What would break if this flag wouldn't exist?
> 
> As both, MTD and UBI already act as NVMEM providers themselves, once
> the user creates a ubiblock device or got CONFIG_MTD_BLOCK=y set in their
> kernel configuration, we would run into problems because both, the block
> layer as well as MTD or UBI would try to be an NVMEM provider for the same
> device tree node.

Why would both MTD and UBI try to be an NVMEM provider for the same
device tree node? Why can't this patch series be implemented such that
a partition UUID occurs in the device tree and such that other code
scans for that partition UUID?

Thanks,

Bart.


