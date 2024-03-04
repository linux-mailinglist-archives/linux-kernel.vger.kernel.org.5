Return-Path: <linux-kernel+bounces-91411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C1871126
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EF11C20E23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8F97D3F6;
	Mon,  4 Mar 2024 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0au6PHD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82627D09A;
	Mon,  4 Mar 2024 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595505; cv=none; b=Q2nThhh68QMMiHQAh2T/4eDW34kwmhzZ6L4Pgj7d8h7oOtxBsbaWACd4y1e6irC0orL5H8DVQXzp1uVL1+8BAKvhhk10FuZNsZCPezIs3/M6MQmjrOEYhLy/ETz+QkTYo/bhIC5N6hrYYKLhmQVjA0yCGB+EusSM/pWMCMkgyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595505; c=relaxed/simple;
	bh=kHp9eMC4Mtkqez9q2HM0GPzMFq5guS/jkCgJloOJ16U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swrvC3Aj/Ba1K8Fd9YyqpnLJp91K0NXZLl0yypAwCqLNsQ8klaBI9m5CglRcD7BkaPjwEFsRpP5viLcGGbMcmAL1xJQmnhU8+WjEZBz9mQpPuyPaEHcxBz99+rJk9YVe5gpXBmihXAdV7/pCBxkWQXMDer2ja+bDQC8mDXzR++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0au6PHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F914C433F1;
	Mon,  4 Mar 2024 23:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595504;
	bh=kHp9eMC4Mtkqez9q2HM0GPzMFq5guS/jkCgJloOJ16U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f0au6PHD2vf+toAHxZuqvCI7nM790TFu4Qiru1mzSxouuh4S7h/N7urcoNwV/MaJw
	 +TJK4NokDbM1zG4WWgqh0/F8iX6g3gSXPQ18sPZp8iIYmdsHwZBttyzz+fqYxyuoEu
	 TU7eZTyTaNTfdq6I25v8LrfmvzV5ID4/t4nev/4iYa0nO395yq4XmkwgAz8wrqO3aQ
	 vvsOKHpoT7LKZdkHSD34rSTTuwZcPnDXlbASekNlywOJmJ1x3li2cu+pSlvD94HX1F
	 2I0xNLv+5bMZMhFPFojc2fYZJTm9Y0MIKSCiDuwVVPzeb4CymtfuceAS/2yUs/Sw4j
	 kjel8z56eI+MA==
Message-ID: <8e2d455c-0ff2-4127-868a-736026192e8a@kernel.org>
Date: Tue, 5 Mar 2024 08:38:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes
 group
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jack Wang <jinpu.wang@ionos.com>
References: <20240304220815.1766285-1-ipylypiv@google.com>
 <20240304220815.1766285-4-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240304220815.1766285-4-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 07:08, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Acked-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


