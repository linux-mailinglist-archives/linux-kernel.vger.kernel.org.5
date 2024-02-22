Return-Path: <linux-kernel+bounces-75987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD085F19A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2E01F22E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BEA175B5;
	Thu, 22 Feb 2024 06:46:18 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E212E4F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584378; cv=none; b=Et6YNO5ytgWKuFGxGuCBgpDGAk4bNYqBrxcAHx27ejw0f0izwHhIW0YVedM0T47pNFBunebMybNrOPD3MDByAR+mE+e+TmElcEPUpFYx6w4LH2lRYxnnjiesKWpTLppxCW4QujR0Twx6YOYj/wQW1hkjvMkGOy9eqKPBOH9ZkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584378; c=relaxed/simple;
	bh=etni9eSsEUBqPWgaCJwLr3P6yofDx35EbKlQDyBCb3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRMHdABqNCsVqADbs5RQ93mkQ6oc2MX8Dn3sEFv6aqKoVmzaIUPPDtafLfwOkiAGcy2FgnZVBdfuf/kZDdkE8+ix/MqoflzQfgPce5dxj/xKtUg3/ZBJQVK0o5uV6tNYt2Wi0aTwyUPyovkqJhrwmE50zrdQOCm+917k7cM4GY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C6E221F4D;
	Thu, 22 Feb 2024 06:46:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 860B5133DC;
	Thu, 22 Feb 2024 06:46:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MZT5HrXt1mWNWAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 22 Feb 2024 06:46:13 +0000
Message-ID: <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
Date: Thu, 22 Feb 2024 07:46:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
 <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 5C6E221F4D
X-Spam-Flag: NO

On 2/21/24 17:37, Daniel Wagner wrote:
> On Wed, Feb 21, 2024 at 04:53:44PM +0100, Hannes Reinecke wrote:
>> On 2/21/24 14:24, Daniel Wagner wrote:
>>> There is no point in retrying to connect if the authentication fails.
>>>
>>> Connection refused is also issued from the authentication path, thus
>>> also do not retry.
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>>> ---
>>>    drivers/nvme/host/fc.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>>> index a5b29e9ad342..b81046c9f171 100644
>>> --- a/drivers/nvme/host/fc.c
>>> +++ b/drivers/nvme/host/fc.c
>>> @@ -3312,6 +3312,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>>>    			ctrl->cnum, status);
>>>    		if (status > 0 && (status & NVME_SC_DNR))
>>>    			recon = false;
>>> +		if (status == NVME_SC_AUTH_REQUIRED || status == -ECONNREFUSED)
>>> +			recon = false;
>>>    	} else if (time_after_eq(jiffies, rport->dev_loss_end))
>>>    		recon = false;
>> Is this still required after the patchset to retry authentication errors?
> 
> Do you mean
> 
>    48dae46676d1 ("nvme: enable retries for authentication commands")
> 
> ?
Yes.

> 
> In this case yes, I've tested on top of this patch. This breaks the loop
> where the provided key is invalid or is missing. The loop would happy
> retry until reaching max of retries.

But that's to be expected, no? After all, that's _precisely_ what 
NVME_SC_DNR is for; if you shouldn't retry, that bit is set.
If it's not set, you should.
So why is NVME_SC_AUTH_REQUIRED an exception?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


