Return-Path: <linux-kernel+bounces-92269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849DB871DB6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4155F28A55E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807D5D46C;
	Tue,  5 Mar 2024 11:26:08 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFC58ADC;
	Tue,  5 Mar 2024 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637968; cv=none; b=sitwrYl7KZ0mcGURvXO0zBT3Ak3zHn5YrnyE6HuS5wgRYt3Bz6p+5jKBz+MP3GN428Sthki4EPXnlBD0mAvkdK2P1IEn4QtiZbeEhRDt+L6netOt0CHEx5t1r16HdFPGrOVI784puCYOz91z+8fs3k46ZKUERIwVN/0WD9anQ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637968; c=relaxed/simple;
	bh=JseQ3jxY0Eiox8xpX+BgZ5wxeni8iP1YPYgbbwUg+dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oh+gnzPNSPAhvEDghrx9JXOXUEiCu+CQEuqzeAXX8Ec0RwePBwNAO32iTsHEovBesVoO58HFg5wqGab5hg9PBQFSnPDImR71VX7qy4fqTR/7fNhlyuwzvo+AEJhGbth2ahhRJwf++pLv2Udwm+9qcJQewwRENnZYdiN2tnQqYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.148] (port=65324 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rhSvh-0001jb-5m;
	Tue, 05 Mar 2024 14:25:54 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1101.mail.hosting.nic.ru (Exim 5.55)
	with id 1rhSvh-008GxQ-2H;
	Tue, 05 Mar 2024 14:25:53 +0300
Message-ID: <17bad2c5-e401-45cc-8351-cc28e461257c@ancud.ru>
Date: Tue, 5 Mar 2024 14:25:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: OSL: Initialize output value
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <ea6ef128-fa22-44b3-bd10-c136bc89c036@ancud.ru>
 <CAJZ5v0hxkoeFYVxQ_ZYCMK+0L=7WdBQHRp6ouv+FzahfMrs_eQ@mail.gmail.com>
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <CAJZ5v0hxkoeFYVxQ_ZYCMK+0L=7WdBQHRp6ouv+FzahfMrs_eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

On 11/21/23 23:05, Rafael J. Wysocki wrote:
> So wouldn't it be better to avoid modifying *value at all if
> raw_pci_read() returns an error?

Avoiding of modification of *value at all seems better idea to me than 
setting it to arbitrary initializing value, indeed.

In that case, buffer initialization can be ditched, and *value set only 
in case of success.

> And if it returns a success, why wouldn't it be trusted?
>
My concern is, that raw_pci_read() wraps platform-specific handlers, 
that should conform to the next rules:

1) in case of success, they must set value32 (or else, uninitialized 
data would leak to acpi_os_read_pci_configuration caller);

2) they should use passed &value32 only to set it (or else, 
uninitialized data would be used/passed somewhere, is it safe?);

Is there any way to be sure, that all the existing and future 
platform-specific pci-read handlers conform?

