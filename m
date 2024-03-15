Return-Path: <linux-kernel+bounces-104851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190CA87D485
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC28F1C226F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7A537F8;
	Fri, 15 Mar 2024 19:40:53 +0000 (UTC)
Received: from relay164.nicmail.ru (relay164.nicmail.ru [91.189.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F352F62;
	Fri, 15 Mar 2024 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531652; cv=none; b=BubqsL1sQCeLUsWIbdrrVC4MLRuq9uVQslSD19kK6LUu+zqcuo4xhC4nlXAiBMqthdcHnE+S9h5m0zigSKb+sDC7/JBdjHG/8xvgfFBksZYrE4Jh34VKa4KDX5iUwWTiTIKsfxGIrI8BWQEdMC4ucEA90pMsk2Qy1WxZzGVHTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531652; c=relaxed/simple;
	bh=aiQBsDD5f3b1VBJB0HUvAlPgpSthbmbJbgAs+fvJQhI=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=WlWzq/Vle/mPNUv3wAt7ULSlFhI/yrYB1Wf4AmRToOkxUg4KSOLBYSW38JSqGywqhA7cZsDVJ3aT5yGrvecowlCV3E1XBcalyU+kMOmzGucWark3hPsvOyeo2A1go/N41P8dXitLL0eeWXtyoEPU5xeYtSTLGHgL7TXLnWfhlSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=61310 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rlDPx-0005RW-Cw;
	Fri, 15 Mar 2024 22:40:37 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1rlDPw-00C3au-31;
	Fri, 15 Mar 2024 22:40:36 +0300
Message-ID: <4d459714-734b-4cee-8ce6-d6abb9cff220@ancud.ru>
Date: Fri, 15 Mar 2024 22:40:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lee Duncan <lduncan@suse.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: ida_alloc result as scsi host_no
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

Hi all,

Today I was reading documentation on struct Scsi_Host,
as I was interested in possible values for host_no.

The documentation says that:
 > host_no - system wide unique number that is used for
identifying this host. Issued in ascending order from 0.

In the code (scsi/hosts.c: scsi_host_alloc()) host_no is set
as non-error result of ida_alloc() call (as added in
Commit 126a4fe010fd ("scsi: Use ida for host number management")
with a good reason of reusing invalidated host_no ids).

My question is about implications of using ida_alloc().
As I understand, ida does not guarantee the order of id issuing,
only that id is unclaimed in the pool and is within limits (which is
0 - INT_MAX for ida_alloc). Given that, my questions are:

1) Should it be mentioned in the documentation, that host_no is now
reclaimable? The current wording is not clear about it;

2) The documentation mentions
 > sh_list - a double linked list of pointers to all struct Scsi_Host
instances (currently ordered by ascending host_no)
I could not find what it would be now in the code, but it seems that
maintaining such a thing ordered should be a little less trivial with
reclaimable ids;

3) Does ida_alloc() ensure ascending order? Is there a possibility
of some new-more-effective ida implementation in the future,
that honors id uniqueness and limits, but does not guarantee
any particular ordering of id issuing? If it is possible, what would it break?

4) Should host_no really be limited only by int capacity (as it is now)
or maybe some additional limits would make sense?
There is at least one case in the current code with a buffer overrun
if huge host_no is used (which led me to the research on host_no).

Any clarification on the matter would be appreciated!

