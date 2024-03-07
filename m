Return-Path: <linux-kernel+bounces-94822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1162387459D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AED61F244F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744554C61;
	Thu,  7 Mar 2024 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUiTTKaK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFE29B0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774601; cv=none; b=SBDMk19lNqC2kIsgxyHNP3Ed/TERGJhPFd+C36jH3AxTJjMpA5yRYx1dGh66M2r7BL/tuUid/3lOGFR58FI8Pl3BPav9WEOC8HdCoZYiwrlLIDYR1c0WNfiQd1TMfmjG9tC2/pJhhOVAv9BKz9NYrWo6gx5QdbmdbxlbTMizgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774601; c=relaxed/simple;
	bh=ijfSbCNd0PPf7U4lHgL5ev2Hlx3z2Re8+n9jBncJSrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBjPYqvGAylxAOp5+FlSS5jcSC0g4pl4Nkipl+XTXeEV2YxCrw8t6l3X7yGmqo/DDhy69cRFondnBZgtIkxpKFmjCGww430L1U+cAvdoaL7qYAotuG9rKBzPt7nO6ob4qoQDB7p+Sxk6wLV6MI/3frx/xvT/vo+VUCO3zpFtZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUiTTKaK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709774598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94mdsQQK95yEtTcufvNh7AUE/lCdC45A/gjJVlEP7/0=;
	b=JUiTTKaK583VZv6YofwTWXfEnFQkZi7ceBSSnT1lrA4DFfomZz02q4X8UqRyijCwHj341m
	2JbFiRN3EWcRTencM9UfoTvIR/hIrZQcQC/BkUgCSk0YvhC9fsQJIzbq6KfbWW4TJRjO19
	sLMg7/IjDF+7g5EktPJ/Rkl/kmxeF8M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-QXrM6ykqP5CSfzd3uoJ3Xg-1; Wed,
 06 Mar 2024 20:23:15 -0500
X-MC-Unique: QXrM6ykqP5CSfzd3uoJ3Xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C28C73C0EAA1;
	Thu,  7 Mar 2024 01:23:14 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E3D3A40C6CB5;
	Thu,  7 Mar 2024 01:23:13 +0000 (UTC)
Date: Thu, 7 Mar 2024 09:23:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: rulinhuang <rulin.huang@intel.com>, akpm@linux-foundation.org,
	colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional
 change happened
Message-ID: <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com>
 <Zei9n-VMxtzG8z4Y@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zei9n-VMxtzG8z4Y@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 03/06/24 at 08:01pm, Uladzislau Rezki wrote:
> On Fri, Mar 01, 2024 at 10:54:16AM -0500, rulinhuang wrote:
.....
> 
> Sorry for the late answer, i also just noticed this email. It was not in
> my inbox...
> 
> OK, now you move part of the per-cpu allocator on the top and leave
> another part down making it split. This is just for the:
> 
> BUG_ON(va_flags & VMAP_RAM);
> 
> VMAP_RAM macro. Do we really need this BUG_ON()?

Sorry, I suggested that when reviewing v5:
https://lore.kernel.org/all/ZdiltpK5fUvwVWtD@MiWiFi-R3L-srv/T/#u

About part of per-cpu kva allocator moving and the split making, I would
argue that we will have vmap_nodes defintion and basic helper functions
like addr_to_node_id() etc at top, and leave other part like
size_to_va_pool(), node_pool_add_va() etc down. These are similar.

While about whether we should add 'BUG_ON(va_flags & VMAP_RAM);', I am
not sure about it. When I suggested that, I am also hesitant. From the
current code, alloc_vmap_area() is called in below three functions, only
__get_vm_area_node() will pass the non-NULL vm. 
 new_vmap_block()     -|
 vm_map_ram()         ----> alloc_vmap_area()
 __get_vm_area_node() -|

It could be wrongly passed in the future? Only checking if vm is
non-NULL makes me feel a little unsafe. While I am fine if removing the
BUG_ON, because there's no worry in the current code. We can wait and
see in the future.

       if (vm) {
               BUG_ON(va_flags & VMAP_RAM);
               setup_vmalloc_vm(vm, va, flags, caller);
       }

Thanks
Baoquan


