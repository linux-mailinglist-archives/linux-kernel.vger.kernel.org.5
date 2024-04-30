Return-Path: <linux-kernel+bounces-163712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0F8B6E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7ACC282048
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35759129A78;
	Tue, 30 Apr 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NSF4OoFu"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3753FC02;
	Tue, 30 Apr 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469805; cv=none; b=ml/gT+cxCSqEkL6lE/PVjgguobVieWhwxH+iZppBWN9FoItRQwZ0gcyJqel/HjOgsypqVGO2dI+UDLPlIjSx1G87mukvYAvnFujHbmKZZNgMKZv0hT8zJPfi8aHuhJmi0qaJuIxPfPwlCgcowEU39V2sgjS5KZERYBePTcKRsJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469805; c=relaxed/simple;
	bh=/x8Zhi2ct4Y6VhAKhc287XA7fVf97CpbCo/XzJpZAe0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDjg0sQBK6GEybxyJVEsDmvYoVmsx4te90ublrG28v9xamK6qRuOMag4GnI4btdKyfmNZdYs2LOXacFBs/wdxwZDPjTQypY8orq0qYwiqvijQ1bh3J+nVw+G6pno038Q5oXlLTQxZL3iJy+nWPcNwT118WPo/yS5fVG6RAEigEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NSF4OoFu; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43U9aS2v100704;
	Tue, 30 Apr 2024 04:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714469788;
	bh=e5EcbOebBnZOxjyjMA63HIyjpRB+ieKp7VwIXBGCGR0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=NSF4OoFuYkLd4fQOcsBbH41E8TcG8IznJNL4MIu9jBK8chMBVLSUo1NYvyaEYh5PC
	 9DdoVCLu+Ld6QaSCZrLHt4XGncc+BgR68cdJLn/98UhQG1lxqA1UGd10oAcILhBqXI
	 dVLHYDQ/KBB9ajKctaZ1gmlEG2l46G4+2+mkcYgU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43U9aRNK009592
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 04:36:27 -0500
Received: from flwvowa02.ent.ti.com (10.64.41.53) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 04:36:27 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Tue, 30 Apr
 2024 04:36:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 04:36:27 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43U9aQFp019953;
	Tue, 30 Apr 2024 04:36:27 -0500
Date: Tue, 30 Apr 2024 15:06:25 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Justin Stitt <justinstitt@google.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] PM: hibernate: replace deprecated strncpy with strscpy
Message-ID: <20240430093625.qbuaxltkrmlaoiza@dhruva>
References: <20240429-strncpy-kernel-power-hibernate-c-v1-1-8688f492d3e6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429-strncpy-kernel-power-hibernate-c-v1-1-8688f492d3e6@google.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Apr 29, 2024 at 20:50:30 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This kernel config option is simply assigned with the resume_file
> buffer. It should be NUL-terminated but not necessarily NUL-padded as
> per its further usage with other string apis:
> |	static int __init find_resume_device(void)
> |	{
> |		if (!strlen(resume_file))
> |			return -ENOENT;
> |
> |		pm_pr_dbg("Checking hibernation image partition %s\n", resume_file);
> 
> Use strscpy [2] as it guarantees NUL-termination on the destination
> buffer. Specifically, use the new 2-argument version of strscpy()
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
[...]

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

