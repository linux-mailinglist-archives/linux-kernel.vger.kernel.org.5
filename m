Return-Path: <linux-kernel+bounces-55446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D85884BCCA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8941F2425C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A9134BC;
	Tue,  6 Feb 2024 18:15:54 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4E134B4;
	Tue,  6 Feb 2024 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243353; cv=none; b=mRkcmd9bF7TDFAD3dGRPTZAZoHnDxnfHrs0BpdguCy/4slsvH8oOhJFmUYjYNKoponNRG5vjsxqoVtzq6glEYXdhRSivrhata+q0jN8iJqWxkr+VjuMiB4sHJpJtD42Gk59vpM5ef3vyrk97lXjVAaZqFbcIakGMxVFE1y1sczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243353; c=relaxed/simple;
	bh=PNSprH9eWLH60SllEMizCLaXGIo9pxrBofe0UJpcjSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u3gSVYeH9w/CELXKzV1uS1DaOWhzyjpVxjPYE675hz6q90hgXADDPOSdY8WBUX05X6/gffN70h7X8gSIkaP+830TL3Gk0njAhFmsg44XmRsux/rb3tsrRnPk7ymkW/sSdagq5nlvHHrft3NM6KMrzpTA1USn2vIgQbmiGUdlabw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 6 Feb
 2024 21:15:41 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Feb 2024
 21:15:41 +0300
Message-ID: <95702cc6-187e-4ce9-b9b8-6320c9ddc7da@fintech.ru>
Date: Tue, 6 Feb 2024 10:15:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] mac802154: Fix uninit-value access in
 ieee802154_hdr_push_sechdr
To: Alexander Aring <aahringo@redhat.com>
CC: Zhang Shurong <zhang_shurong@foxmail.com>, <alex.aring@gmail.com>,
	<stefan@datenfreihafen.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-wpan@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<harperchen1110@gmail.com>
References: <CAK-6q+jsZ13Cs9iuk_WjFeYFCEnnj-dJ9QYkWaw4fh6Gi=JtHA@mail.gmail.com>
 <20240112131554.10352-1-n.zhandarovich@fintech.ru>
 <CAK-6q+gcs2djQfKRsuGpD7WERmbLhzjkHEm80MRe+2UE3bteKw@mail.gmail.com>
 <CAK-6q+hRbsFkQec3O8FnT-G9Mx07rdhEMfmTE2Q0SDN0kKN-8g@mail.gmail.com>
 <64dbd05c-4939-49ba-a8d5-807fe3ff2987@fintech.ru>
 <CAK-6q+gEjqCrnFkpKSuQiuhpx9zyuWr6y0tQpJOLquoz2pnmzw@mail.gmail.com>
Content-Language: en-US
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <CAK-6q+gEjqCrnFkpKSuQiuhpx9zyuWr6y0tQpJOLquoz2pnmzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Hi,

On 2/5/24 11:49, Alexander Aring wrote:
> Hi,
> 
> On Thu, Jan 18, 2024 at 8:00 AM Nikita Zhandarovich
> <n.zhandarovich@fintech.ru> wrote:
> ...
>>
>> I was curious whether a smaller change would suffice since I might be
>> too green to see the full picture here.
>>
>> In all honesty I am failing to see how exactly it happens that cb->secen
>> == 1 and cb->secen_override == 0 (which is exactly what occurs during
>> this error repro) at the start of mac802154_set_header_security().
>> Since there is a check in mac802154_set_header_security()
>>
>>         if (!params.enabled && cb->secen_override && cb->secen)
>>
>> maybe we take off 'cb->secen_override' part of the condition? That way
>> we catch the case when security is supposedly enabled without parameters
>> being available (not enabled) and return with error. Or is this approach
>> too lazy?
> 
> I need to see the full patch for this. In my opinion there are two patches here:
> 

Alex, I am gonna try to test your version and send out patches before
the end of week, thank you for reminding me.

> 1. fix uninit values
> 2. return an error with some mismatched security parameters. (I think
> this is where your approach comes in place)
> 
> The 1. case is what syzbot is complaining about and in my opinion easy
> to fix at [0] to init some more default values of "struct dgram_sock"
> [1].

However, if I may, I am still worried that initing stuff in [0] won't
help much. They way I see it, there are mismatched sec. parameters that
lead to the actual uninit issue, but are not victim of it themselves.

Specifically, once we enter mac802154_set_header_security() all fields
of 'cb' have values (albeit a possibly wrong combo of them), values
copied from 'ro' seemingly w/o a hitch; the function ends early (cause
of mismatch); we end up NOT filling values in ieee802154_hdr *hdr, at
the very least these:

	hdr->sec.level = level;
	hdr->sec.key_id_mode = params.out_key.mode;

Then we are back in ieee802154_header_create():
ieee802154_header_create -> ieee802154_hdr_push ->
ieee802154_hdr_push_sechdr, where we finally access aforementioned
values despite putting nothing in them.

In other words, I am unsure that mismatch in sec. parameters (cb->secen,
params.enabled etc.), which leads to uninit issues in hdr->sec.XXX
fields, is itself caused by the uninit values in dgram_sock (since KMSAN
should have caught it earlier). But if you are certain, I don't mind
taking on the patches you suggested.

> 
> Then 2. can be fixed afterwards.
> 
> - Alex
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ieee802154/socket.c#n474
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ieee802154/socket.c#n435
> 

Thank you for your patience,
Nikita

