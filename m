Return-Path: <linux-kernel+bounces-71092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6DA85A088
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB881282ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0FE25578;
	Mon, 19 Feb 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="at6aA4ex"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B92137F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337315; cv=none; b=pYnfXlMAxq7rYk+bIvloxnE5pvVyVQR/eEMJEjFskHXHnwIPUaxlENA5dHVcd+cXng8d74TM4VFrNhxaxNy5BPtE0xD2wdzAfRCOby0rT2OnNzP1TnZhvdTeoODJE4/YhnstF0JmByDNgTIE2eAWrw6plYxZ/o5NIL/ij+LAZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337315; c=relaxed/simple;
	bh=TR8HS0OFrh9aNH4iX7ntd6fP5lH5BPlQhF5iDC7RPM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTVyGlfOwZ7kF5FntQsKT2+kAPg0YFQ4uwQCfoveKzKFCRUO0vk7NbkLluOt+/3kNatLX+ZqGZnB1nO/8U+Ma5hWhwXOIZL1v5qOs7XWjcQdb823C2VRAf22SVbmkcf+Yzm9AHs7AI5W6fvKkN5Bg6p49tN/H2jkKuB4hNyoh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=at6aA4ex; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708337313; x=1739873313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TR8HS0OFrh9aNH4iX7ntd6fP5lH5BPlQhF5iDC7RPM0=;
  b=at6aA4ext6IAn8SqJ6oA3rU6WsTLdLmjNw4RaQ3rll0yoQaLFhVmfXz8
   8YeLhhB22+s4DbgsA9BrcBm5HG6CAbTZg3K8yZ9mvw0pCW4M1m4lLMTWH
   0EemgSCj/oupT5/zfuc8Y/UQbkSh4scAEIkaC7YU4tzgzIAUlKsWZONRU
   44KFn+FCZzyzK3aqWOiWuDq3UvkH0XxWdoWgRDREfeVep/nxWrJqcAp36
   VipWme//xq2qE+yKeqOLLwPw1qsR1ZzpCrJfYYo8iMQusQ0dPUPggMFVU
   elQ4cDuQA1IgYUjjIIDQijis96AacNa58OZRQV780Pkbc9Jrtml26j5ba
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2532833"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2532833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 02:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="936268601"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936268601"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 02:08:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 96E9B34B; Mon, 19 Feb 2024 12:08:26 +0200 (EET)
Date: Mon, 19 Feb 2024 12:08:26 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 01/16] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Message-ID: <a2cmua3qhbmhgzdxl5mszuvatnkyf4nwxjciurguhgbulrhin4@gvswvfats5er>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-2-kirill.shutemov@linux.intel.com>
 <ZdLc61QMLu3L0Eqv@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdLc61QMLu3L0Eqv@MiWiFi-R3L-srv>

On Mon, Feb 19, 2024 at 12:45:31PM +0800, Baoquan He wrote:
> Do we need add the entry printing for ACPI_MADT_TYPE_MULTIPROC_WAKEUP
> now in acpi_table_print_madt_entry()? Surely it's not related to this
> patch.

Good catch. See patch below. Does it look okay?

> FWIW, 
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks!

From 23b7f9856a3d6b91c702def1e03872a60ae07d0e Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 19 Feb 2024 11:58:19 +0200
Subject: [PATCH] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parse

When MADT is parsed, print MULTIPROC_WAKEUP information:

ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])

This debug information will be very helpful during bring up.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/acpi/tables.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b07f7d091d13..c59a3617bca7 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
+		{
+			struct acpi_madt_multiproc_wakeup *p =
+				(struct acpi_madt_multiproc_wakeup *)header;
+			u64 reset_vector = 0;
+
+			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
+				reset_vector = p->reset_vector;
+
+			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
+				 p->version, p->mailbox_address, reset_vector);
+		}
+		break;
+
 	case ACPI_MADT_TYPE_CORE_PIC:
 		{
 			struct acpi_madt_core_pic *p = (struct acpi_madt_core_pic *)header;
-- 
2.43.0

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

