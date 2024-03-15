Return-Path: <linux-kernel+bounces-104189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC487CA75
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E831C21789
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5621799F;
	Fri, 15 Mar 2024 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfEYuUwf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A687D175A7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494017; cv=none; b=ewlYUuzcqd3/IxUK2tdR4o9awMQ0p0QYUlKntFu+JWDS7oVPnPyyfzkSSYwBZRiuVp6LJ8SfXKDH9SP/lUUSiB2KLi5QCILjIN/rJ4YwmDRUXRC0q56ptnPr5iLK3KYl9dfjq8NhDodbGoWCBUHNN91YD2h8hScG9K1VWDlgKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494017; c=relaxed/simple;
	bh=UsZF+9oc+o7aNoD9Z0So2YDg3vG30lPU/mngLQzAdzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JA46RWw1D+Z9Xa2dnhsJRzjE5M7cMD7pEEZTOO98pczto6/6nE6Kfb19VDqSpUl27DEi7YEu9+QFq6KlFOKX9CG75x5dDXrODwDoBaHo3NpI5225kcO8Q5qJfbPJxxFKFcvCSg3otvpCgnjBtfwNz5tcS5nO23HryVTbHrh4YvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfEYuUwf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710494014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxG36aunw31I+2dTdVgHhsWpfWJuD63rmQBwk2u9Iac=;
	b=JfEYuUwfnhCJzS9FMF1YcoDIn5gDBiwY12f35euwT7v/l9SRbls8KGGfVBu5DddVWqMbZW
	QLKCZ/oPM39Ji3ld184TTMFRMHTT3gmukf4NZwyqcu7bjRak8rkt72jBKLLwoi30r71s95
	1BFDYJkgAvrAzCM3yerVznA9xINtogI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-Msc5-Pd3ORSa214LqU-fLw-1; Fri, 15 Mar 2024 05:13:30 -0400
X-MC-Unique: Msc5-Pd3ORSa214LqU-fLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22079101A523;
	Fri, 15 Mar 2024 09:13:30 +0000 (UTC)
Received: from [10.45.224.236] (unknown [10.45.224.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3DB4F40C6DB3;
	Fri, 15 Mar 2024 09:13:28 +0000 (UTC)
Message-ID: <3d9efa93-16dc-47f3-b344-24c37f40df08@redhat.com>
Date: Fri, 15 Mar 2024 10:13:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] i40e: Enforce software interrupt during busy-poll
 exit
Content-Language: en-US
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
Cc: pawel.chmielewski@intel.com, aleksandr.loktionov@intel.com,
 mschmidt@redhat.com, Hugo Ferreira <hferreir@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240314120049.111241-1-ivecera@redhat.com>
 <066e0dc8-0f47-4a1c-b989-f8c16f31464f@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <066e0dc8-0f47-4a1c-b989-f8c16f31464f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 15. 03. 24 2:03, Jesse Brandeburg wrote:
> On 3/14/2024 5:00 AM, Ivan Vecera wrote:
>> As for ice bug fixed by commit b7306b42beaf ("ice: manage interrupts
>> during poll exit") followed by commit 23be7075b318 ("ice: fix software
>> generating extra interrupts") I'm seeing the similar issue also with
>> i40e driver.
> 
> Please see my comments on v1.
> 
Thanks, replying there.

Ivan


