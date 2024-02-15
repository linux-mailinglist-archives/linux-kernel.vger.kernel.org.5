Return-Path: <linux-kernel+bounces-66709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821D856079
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A71C23383
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2785F1332AE;
	Thu, 15 Feb 2024 10:46:36 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ABC12DD96
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993995; cv=none; b=LnQy1i9N6nKAFG2fUdatJ3QrnAdC1Tt4e0uln8kqtUJIcV+LWFZYwqaxmp8/jL48GUZdQsVAgiKQ+lMXQ31/744xvnZ5svBj5zXeCzlrgN95b+5vJwGqbgCciJppsLOBqxz6RwCPCqnY+MDsS3YxbY5iz+a+i55D2jd/dUrDrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993995; c=relaxed/simple;
	bh=xea5c/vUudL7TI9t7cbNpN7u8WkZDcV7HrZPNxRxpQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0FnpQAD7pkcytk25Zr3EXAn3riJbid/sZNzognjXNvUqo8zojZbvMc3tmeR+P6YegZTjwacmsl6XxVofSn2XirR/6exmUQwX3EmWvKwqW6WFQIQJEMQRrOesmS7KrbjdTUWBJ0lszZ3P5UPrjPilr6ATbMaZ+nzOJdVppDFn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2866522031;
	Thu, 15 Feb 2024 10:46:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A33C13A53;
	Thu, 15 Feb 2024 10:46:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ucwwAojrzWWfLgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 10:46:32 +0000
Message-ID: <d1589640-fd03-447c-9d8a-9f53c844e262@suse.cz>
Date: Thu, 15 Feb 2024 11:46:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/7] lib/stackdepot: Fix first entry having a 0-handle
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-2-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240214170157.17530-2-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 2866522031
X-Spam-Flag: NO

On 2/14/24 18:01, Oscar Salvador wrote:
> The very first entry of stack_record gets a handle of 0, but this is wrong
> because stackdepot treats a 0-handle as a non-valid one.
> E.g: See the check in stack_depot_fetch()
> 
> Fix this by adding and offset of 1.
> 
> This bug has been lurking since the very beginning of stackdepot,
> but no one really cared as it seems.
> Because of that I am not adding a Fixes tag.
> 
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


