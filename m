Return-Path: <linux-kernel+bounces-91407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D10871112
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCB428352C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC497CF37;
	Mon,  4 Mar 2024 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9Rv3Kpi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFA7B3FA;
	Mon,  4 Mar 2024 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595212; cv=none; b=r8h7zP7b2GwqUIcC7x6lqZW6quy8WhqHuwP0VZxX+BdYxu6R8+LraTFxNMPKhOehiAO5O/1u4eXQ8fJovPyl3ZMLBrz+utUKiw1dZbcUaXpMRkKXvJGO6sp3hX4994oE1Hdh4qnAYOdcGF5uTzG2OYW0w7rM41xWDm9n2+yti90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595212; c=relaxed/simple;
	bh=Kl7s1r1CfRFt8fTgVgVThr8LZ7WoKPAxcfXM2y5+B6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArQXQ0Ue4MsvEKLfyOKqUW9x4ZibfzP+WAMrFGlnu8ziLH6Wv55v46ljCs17ilMztIkZ+U3XBTbZv29Z51zIQV1qPV3GTo9Y7S/2BoBnm6jdQOXxSBEH8NORj0WekWZfiCWcu8i69gevml4yjzHxqb0m4B1i3a8I4HIRUIodKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9Rv3Kpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85899C433C7;
	Mon,  4 Mar 2024 23:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595211;
	bh=Kl7s1r1CfRFt8fTgVgVThr8LZ7WoKPAxcfXM2y5+B6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H9Rv3KpiNyIf4FeXN6+Zs6qW8Vfucu5mt3INZ1epU4DdAJjkwjISZ1T1Xbzelz5TB
	 qKW5/0YTn+G3/keCKTbTBN4s/LarmD3F3QSCbjCh6M5FiP1B4fGVfbhK0evSzEwSSJ
	 yPfc7EYlkBYjO1aaiWFuakb75JfWcmaXXTasd5jVLfy6AOdsFw2ljAXSjTJYiYDgpL
	 PeWBEFdYZbbkqYkGzT2DtHumXIcroEBGkKLHGx1idlccqHvDMiRE3IU9sRZdgjMVnM
	 jy3dp1H/Zuz4PGuj6Z104UB3W3sOA7M9f+1UTTNXWyoSYb6NTtw8p1oX1twdjTXzVm
	 pUTg/79Q/NvuA==
Message-ID: <7ec9de4d-9e5d-4769-9bcf-3e1f3d2d816b@kernel.org>
Date: Tue, 5 Mar 2024 08:33:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240304220815.1766285-1-ipylypiv@google.com>
 <20240304220815.1766285-2-ipylypiv@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240304220815.1766285-2-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 07:08, Igor Pylypiv wrote:
> Export libata NCQ Priority configuration helpers to be reused
> for libsas managed SATA devices.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Looks good.

Acked-by: Damien Le Moal <dlemoal@kernel.org>

(I am assuming this is going to go through the scsi tree. I not, we can take it
through libata tree too).


-- 
Damien Le Moal
Western Digital Research


