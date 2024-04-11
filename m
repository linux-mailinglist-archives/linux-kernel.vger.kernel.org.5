Return-Path: <linux-kernel+bounces-140590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D888A1696
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD67288926
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B014E2F4;
	Thu, 11 Apr 2024 14:02:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BB14D43D;
	Thu, 11 Apr 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844163; cv=none; b=jeqExNkw8t+A/01Rc9HsoztcHcmdStgz4Oh2JLo0bwyOd5VB1nqKR+o3YDXGw7E81PU041jwpbcKDwTxmtnqgUx84bi/XH2bkFSbLNHWtXkPm2PbUcer70D2znj5J9FfPZ7ZVsYDRtLeQZQMLj5j0/p/+318eQzpbwTsMaafDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844163; c=relaxed/simple;
	bh=2pFqs1VB9hO/Q7vOmAgQiyRnAX8T6W5RcsCtTiaNsUI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phFdz7ThymUREeQHECR7RoIGGd6v1NYDatNRMzyFLbEQa2Hnaojn/e+h6kvaLJnUMf4r/sUfarYQ/uVsH8ulR5V4LxdkjyCrKdqoN90PYAam/lelmLndZVPUgOscY/kf0KqR7gH+/qB/hlFpwmQYmb4CIXGADp6mebnL8YvDoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VFhDm1vTDz6K6Hw;
	Thu, 11 Apr 2024 22:00:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 45134140519;
	Thu, 11 Apr 2024 22:02:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 11 Apr
 2024 15:02:36 +0100
Date: Thu, 11 Apr 2024 15:02:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miguel Luis <miguel.luis@oracle.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 4/4] ACPI: processor: refactor
 acpi_processor_remove: isolate acpi_unmap_cpu under CONFIG_ACPI_HOTPLUG_CPU
Message-ID: <20240411150235.0000355c@Huawei.com>
In-Reply-To: <25259BC7-8CDB-4714-AEDE-CFFD14986148@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
	<20240409150536.9933-5-miguel.luis@oracle.com>
	<20240410143101.00001f5a@Huawei.com>
	<25259BC7-8CDB-4714-AEDE-CFFD14986148@oracle.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Apr 2024 11:02:37 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> > On 10 Apr 2024, at 13:31, Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > On Tue,  9 Apr 2024 15:05:33 +0000
> > Miguel Luis <miguel.luis@oracle.com> wrote:
> >   
> >> acpi_unmap_cpu is architecture dependent. Isolate it.
> >> The pre-processor guard for detach may now be restricted to
> >> cpu unmap.
> >> 
> >> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>  
> > Again the why question isn't answered by the patch description.
> > 
> > I assume this is to try and resolve the remove question of releasing
> > resources that was outstanding on vCPU HP v4 series Russell posted.
> > 
> > I've not looked as closely at the remove path as the add one yet, but
> > my gut feeling is same issue applies.
> > This code that runs in here should not be dependent on whether
> > CONFIG_ACPI_HOTPLUG_CPU is enabled or not.  
> 
> I agree.
> 
> >  What we do for the
> > make disabled flow should not run a few of the steps in 
> > acpi_processor_remove() we should make that clear by calling
> > a different function that doesn't have those steps.
> >   
> 
> Perhaps this got answered already elsewhere but is it OK for the detach handler
> to be out of CONFIG_ACPI_HOTPLUG_CPU ?

There is code that is again specific to CONFIG_ACPI_HOTPLUG_CPU and
code that is specific to the disabling only case.  So I think the conditions
will end up looking pretty similar to the attach path.
> 
> Miguel
> 
> >> ---
> >> drivers/acpi/acpi_processor.c | 13 +++++++++----
> >> 1 file changed, 9 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> >> index c6e2f64a056b..edcd6a8d4735 100644
> >> --- a/drivers/acpi/acpi_processor.c
> >> +++ b/drivers/acpi/acpi_processor.c
> >> @@ -492,6 +492,14 @@ static int acpi_processor_add(struct acpi_device *device,
> >> }
> >> 
> >> #ifdef CONFIG_ACPI_HOTPLUG_CPU
> >> +static void acpi_processor_hotunplug_unmap_cpu(struct acpi_processor *pr)
> >> +{
> >> + acpi_unmap_cpu(pr->id);
> >> +}
> >> +#else
> >> +static void acpi_processor_hotunplug_unmap_cpu(struct acpi_processor *pr) {}
> >> +#endif /* CONFIG_ACPI_HOTPLUG_CPU */
> >> +
> >> /* Removal */
> >> static void acpi_processor_remove(struct acpi_device *device)
> >> {
> >> @@ -524,7 +532,7 @@ static void acpi_processor_remove(struct acpi_device *device)
> >> 
> >> /* Remove the CPU. */
> >> arch_unregister_cpu(pr->id);
> >> - acpi_unmap_cpu(pr->id);
> >> + acpi_processor_hotunplug_unmap_cpu(pr);
> >> 
> >> cpus_write_unlock();
> >> cpu_maps_update_done();
> >> @@ -535,7 +543,6 @@ static void acpi_processor_remove(struct acpi_device *device)
> >> free_cpumask_var(pr->throttling.shared_cpu_map);
> >> kfree(pr);
> >> }
> >> -#endif /* CONFIG_ACPI_HOTPLUG_CPU */
> >> 
> >> #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
> >> bool __init processor_physically_present(acpi_handle handle)
> >> @@ -660,9 +667,7 @@ static const struct acpi_device_id processor_device_ids[] = {
> >> static struct acpi_scan_handler processor_handler = {
> >> .ids = processor_device_ids,
> >> .attach = acpi_processor_add,
> >> -#ifdef CONFIG_ACPI_HOTPLUG_CPU
> >> .detach = acpi_processor_remove,
> >> -#endif
> >> .hotplug = {
> >> .enabled = true,
> >> },  
> > 
> >   
> 


