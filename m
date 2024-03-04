Return-Path: <linux-kernel+bounces-90231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E5686FC39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CC91F2153F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFDC39FC7;
	Mon,  4 Mar 2024 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4dWYz3O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2C38F8F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541842; cv=none; b=mgRHTGwwLwpkb4PBf7rkfjyv0au3L6kp7Ma0d65mykbEc/RoOIrA6BHA8PqFXu6A2/4QHcYVLV2Dcj2Fx1MXDCep5XdrlywjJsXB+HzqQlCh89aWQvZ4fMlsu1usAmX00RUmecNtctkkqBXo6fUyJE6BrZLimuKOESDBbDCo9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541842; c=relaxed/simple;
	bh=I29VTBmWsXgiB8EffcLS3EPaMYqXfAHUkxD9L3kQnkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzBxjKs+m9GU9gGwle3/Ys3iXn+4h7hFcmyTKOsf8uqydxNgui5fbByVpquq1nOF1sKyLoWO9enNfqrB4hiPJnm+KGWJ+y0Csyw9lvHV7WXZC8Q9WzNFSPlc6bmB09Ok5S4izbJYK7/2TdWJH7wt+Al3IqZ2/ZL/mwYTT0g+6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4dWYz3O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LdMeXg6oYzzaQwNcQtAfoUHshalR516v8C8QWlVtXs=;
	b=Z4dWYz3O1CS38A+Z4ehIn0rIWKOtb/gNJQ5GOzMFyYJOytq0LMqStvRrHugKFl5y8TQiX5
	ji7yPStq5RS0OVrlN1O3XTulKY71i5FaJb2UkTHsazjX/TAz1cB6JOMpN/bHGPNhwAw89T
	fi21NWjx0ua3QcYf7G6dwfyjj66lB+A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-RAUvfw0xNwWztwDrstr7uA-1; Mon, 04 Mar 2024 03:43:56 -0500
X-MC-Unique: RAUvfw0xNwWztwDrstr7uA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 967FD811E79;
	Mon,  4 Mar 2024 08:43:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 205332166B31;
	Mon,  4 Mar 2024 08:43:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id BD16218009DB; Mon,  4 Mar 2024 09:43:53 +0100 (CET)
Date: Mon, 4 Mar 2024 09:43:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] kvm: wire up KVM_CAP_VM_GPA_BITS for x86
Message-ID: <vlr6f5dnyhb6aw5si6m4vxqemwoyg7lrti7pdy4jzatady5mgr@bv44qwgk6ppu>
References: <20240301101410.356007-1-kraxel@redhat.com>
 <20240301101410.356007-2-kraxel@redhat.com>
 <ZeH+pPO7hhgDNujs@linux.bj.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeH+pPO7hhgDNujs@linux.bj.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

> > +	kvm_caps.guest_phys_bits = boot_cpu_data.x86_phys_bits;
> 
> When KeyID_bits is non-zero, MAXPHYADDR != boot_cpu_data.x86_phys_bits
> here, you can check in detect_tme().

from detect_tme():

        /*
         * KeyID bits effectively lower the number of physical address
         * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
         */
        c->x86_phys_bits -= keyid_bits;

This looks like x86_phys_bits gets adjusted if needed.

take care,
  Gerd


