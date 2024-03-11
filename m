Return-Path: <linux-kernel+bounces-99471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7788788EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CD31F21013
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7354FB1;
	Mon, 11 Mar 2024 19:29:03 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCB54F95
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185343; cv=none; b=Fzlpx8XHQQzf5InrhZ526bmlpujAUokVtd01DlE4wk4TdN2B1+lBcOGV7j+4xM+aW5ed7/lb7oTzOjqQwd+M4PhzbaqVWhwekTlStTvAf7tg2F7rtTEpJf8gU/W11vj9HEreJAZ7cyHIt9I9YJFVXBcH9JMFdRYT9GG+uGZ7JSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185343; c=relaxed/simple;
	bh=oIABW2DNy9dOFuOU2pfHQlTmZCb/X3jVT9ZrNe8DWhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUxdf9P6TBXygvcC8eM2KgkD40cHXTX6HveADfs7EjMHgGhoMmvxb7seBAWPahX+oakQMZ42AeXZFi/DBwCqgzRwG+5N1Ab1VAGcs/RH7L9KWptHDh3OYz33Gn1Ms6FRPGh/MCfkmsUslqyUqtEurZc9pQJi5erwky7VagOIIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C932C34FD2;
	Mon, 11 Mar 2024 19:28:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E16013695;
	Mon, 11 Mar 2024 19:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0nXBHHtb72XkTQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 Mar 2024 19:28:59 +0000
Message-ID: <14c5a294-e68f-441f-8606-31cfb67670b7@suse.de>
Date: Mon, 11 Mar 2024 20:28:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] nvme-fabrics: introduce ref counting for
 nvmf_ctrl_options
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-4-dwagner@suse.de>
 <342cf4cf-ad14-4fd0-bcab-fe5fcecf4c0a@grimberg.me>
 <3xjjwq56sldxrr3dmcxmzhqjebctrowmfpr3istfqmnitlvpv4@mzjixl3jjnbi>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3xjjwq56sldxrr3dmcxmzhqjebctrowmfpr3istfqmnitlvpv4@mzjixl3jjnbi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: C932C34FD2
X-Spam-Flag: NO

On 3/11/24 18:36, Daniel Wagner wrote:
> On Thu, Mar 07, 2024 at 12:27:43PM +0200, Sagi Grimberg wrote:
>> Why do we need a refcount for an object that has the same exact lifetime
>> as the ctrl itself? It just feels like unneeded complication.
> 
> My claim the UAF is also possible with the current code is not correct.
> Or at least not easy to reproduce. I've re-tested a lot and I couldn't
> reproduce it.
> 
> Though, the UAF is very simple to reproduce with the sync connect patch
> applied (nvme-fc: wait for initial connect attempt to finish) together
> with Hannes' patch (nvme: authentication error are always
> non-retryable):
> 
> In this case, the initial connect fails and the resources are removed,
> while we are waiting in
> 
> +       if (!opts->connect_async) {
> +               enum nvme_ctrl_state state;
> +
> +               wait_for_completion(&ctrl->connect_completion);
> +               state = nvme_ctrl_state(&ctrl->ctrl);
> +               nvme_fc_ctrl_put(ctrl);
> +
> +               if (state != NVME_CTRL_LIVE) {
> +                       /* Cleanup is handled by the connect state machine */
> +                       return ERR_PTR(-EIO);
> +               }
> +       }
> 
> This opens up the race window. While we are waiting here for the
> completion, the ctrl entry in sysfs is still reachable. Unfortunately,
> we also fire an uevent which starts another instance of nvme-cli. And
> the new instance of nvme-cli iterates over sysfs and reads the already
> freed options object.
> 
Curiously enough, I had been digging into better error reporting for 
nvme-fabrics. And the one thing I came up with is to make the controller
_options_ as a private pointer to seq_file.
With that we can allocate and initialize the options during open(),
and then have write() do the parsing and calling create_ctrl() as usual.
But read() would then always have access to the option structure, and
we can use this structure to pass any errors. EG parsing errors could
be reported by an 'err_mask' field and so on.

That would allow us to report errors back to nvme-cli, and,
incidentally, also require reference counting.
Two stones with a bird and all that.

Patch is in testing, and I'll be posting it once I get confirmation.


Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


