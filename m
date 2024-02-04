Return-Path: <linux-kernel+bounces-51772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4743848F23
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D611C212DD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6F22EE4;
	Sun,  4 Feb 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdtbKKCq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB0F22EE9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062845; cv=none; b=DWViwALui3zdbpEiL0TvxyJ12h6Ylnsm29mGVy5+Ff3e96XWko04OsW08Ks0pQNsZh8JBVU4ajW9mgHSjlfOc5SplWcUoTScMefeOg61Si2lGpVmzceiao98TgtEgDz1eP5YGwraweDa2/R+y9Xl+ykzi09mHmHBMsuyeUkYVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062845; c=relaxed/simple;
	bh=beEMEPxTnmhGmIynDJ6rtVnEmNm3uQWc7Wq1nr3UZyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUbb8kT+vFQarFubym2vW+o+LTYUa85Jeh4R93DMUHe5/o6MaL5tNichhEtpEOZPRV5nP6m6NdCjphBL1p3fGP3b6l+/5JD4tngqBmpw1kYBVYg7VDyHTpK3JKtKqJQUPCQWw0axCnQwpMyzAcy0uRFkp5hgCwfmzAKg0+oB7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdtbKKCq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707062842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJbzKOQG5Y0HNZGsJaBEogo5XOc3ovFLiwYQiXooh+I=;
	b=FdtbKKCqlJ/M6EDzA8N/8gHDk01Q17YRBKHtx0+S/W6oisG7jLVMfSgrR6W7kI/ynr2sfC
	9tRXc+T014KK5C8QabgiRFcwePB5EDMP9sjqoZmg+bgTql/hmKUllKs0ETBCrJZoFTSZpL
	t/y8ot2oJ9NNbrmpacQZDrIdkzYOR8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-Mvr3fQ2kMRyyZruMacBRBQ-1; Sun, 04 Feb 2024 11:07:18 -0500
X-MC-Unique: Mvr3fQ2kMRyyZruMacBRBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDD8D1013767;
	Sun,  4 Feb 2024 16:07:17 +0000 (UTC)
Received: from [10.22.8.85] (unknown [10.22.8.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B078492BC6;
	Sun,  4 Feb 2024 16:07:17 +0000 (UTC)
Message-ID: <149cbb48-ad60-4817-b464-ad53418aadd0@redhat.com>
Date: Sun, 4 Feb 2024 11:07:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-wq v2 3/5] workqueue: Thaw frozen pwq in
 workqueue_apply_unbound_cpumask()
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Cestmir Kalina <ckalina@redhat.com>,
 Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
 Costa Shulyupin <cshulyup@redhat.com>
References: <20240203154334.791910-4-longman@redhat.com>
 <202402041854.YeHAF3wV-lkp@intel.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <202402041854.YeHAF3wV-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 2/4/24 05:15, kernel test robot wrote:
> Hi Waiman,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on tj-wq/for-next]
> [also build test WARNING on next-20240202]
> [cannot apply to linus/master v6.8-rc2]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/workqueue-Skip-__WQ_DESTROYING-workqueues-when-updating-global-unbound-cpumask/20240203-234626
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
> patch link:    https://lore.kernel.org/r/20240203154334.791910-4-longman%40redhat.com
> patch subject: [PATCH-wq v2 3/5] workqueue: Thaw frozen pwq in workqueue_apply_unbound_cpumask()
> config: x86_64-randconfig-122-20240204 (https://download.01.org/0day-ci/archive/20240204/202402041854.YeHAF3wV-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041854.YeHAF3wV-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402041854.YeHAF3wV-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>     kernel/workqueue.c:361:40: sparse: sparse: duplicate [noderef]
>     kernel/workqueue.c:361:40: sparse: sparse: multiple address spaces given: __percpu & __rcu
>>> kernel/workqueue.c:6373:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>     kernel/workqueue.c:6373:25: sparse:    struct pool_workqueue *
>     kernel/workqueue.c:6373:25: sparse:    struct pool_workqueue [noderef] __rcu *

OK, I didn't realize that a __rcu tag is added to the dfl_pwq in 6.9. 
Will change the patch series to use the appropriate helpers to avoid 
this kind of warnings.

Cheers,
Longman


