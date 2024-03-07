Return-Path: <linux-kernel+bounces-94924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2AF8746CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA98C288991
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50749EED7;
	Thu,  7 Mar 2024 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hp0dTOeH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E323214
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782389; cv=none; b=RF0s6beRCYUdlc7fWZpCxpUHSY4luOABH4sYQE421DpCY1zOJYTWVVPHN1Gl+/Fb7gOO3Tkf9o4Pu8QNaYucWO6kmPJhs6gzkwUG3indXUYBT8SBgykTEZUKs47mqUA5WBpAP/xE/LWUhr6tXO//VaKf5gR5ucv7wBW9PL/NoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782389; c=relaxed/simple;
	bh=7s6gbR/MnVmMo/Ea78F+ZHph4KwnqAUij8luCicQ71s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFrdaIxe1pAdXZTgf/Uz0hx5lGPJshXgr+Xjkyt4Vgq4HkI8kmJsvPWX0qIsJchFdTZ7fJZB+1DAE87gSlP+7gNMfm4LxfryfPWGMvOyUmNEbqbHrB4loVYxYMs+9G+CW4RH85BDf2AcsmDjqEW7BKzkwJ58pGXKqU24a7w4KtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hp0dTOeH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709782386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXNVkaPG+oW3QWS3kpjvLcsLvniwXLJOKpM6BAtv1ao=;
	b=hp0dTOeHdKmEjiani5uw1Q+I/xYyglKEo+pnT8m93f1+cr0viRVzh05xZ4pigzpel8uP01
	Fa1AFgo6QVJe13AG5NOHaOa5xnUWokjWH3ODS54eVLfF4LGYQWgRQ0kVn4aQQ0xu5OSHxW
	/r7zWMdk6mloQLZkQlFpTZTWgEeId+w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-r2unvn5uNdO4XiDR5xnrNw-1; Wed, 06 Mar 2024 22:33:03 -0500
X-MC-Unique: r2unvn5uNdO4XiDR5xnrNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DCB0101A523;
	Thu,  7 Mar 2024 03:33:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A51A437F6;
	Thu,  7 Mar 2024 03:33:01 +0000 (UTC)
Date: Thu, 7 Mar 2024 11:32:53 +0800
From: Baoquan He <bhe@redhat.com>
To: "Huang, Rulin" <rulin.huang@intel.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, akpm@linux-foundation.org,
	colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional
 change happened
Message-ID: <Zek1ZVmCtddF7f3y@MiWiFi-R3L-srv>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com>
 <Zei9n-VMxtzG8z4Y@pc636>
 <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>
 <140860ab-59f2-4633-8a55-fb6cfa854250@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <140860ab-59f2-4633-8a55-fb6cfa854250@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 03/07/24 at 11:01am, Huang, Rulin wrote:
> We have made changes based on your latest suggestions.
> 1.Removed bugs_on.
> 2.Removed adjustion of macros.
> 
> We submitted patch v8 based on this. Thanks to Baoquan for the
> discussion, and could you please help to review and confirm if there are
> any problems on the latest version?

Looks good to me, I don't want to exhaust a newcomer's enthusiasm and
patience before you get used to this :-). Will ack, thanks for the
awesome work.


