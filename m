Return-Path: <linux-kernel+bounces-127715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C9894FE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606FEB253C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A569302;
	Tue,  2 Apr 2024 10:17:17 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B75A7AE;
	Tue,  2 Apr 2024 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053036; cv=none; b=CGo8pjwD2v6GxZuf4JumjHBLKU3LChnZNgZTh8hwQW6UorqXFu9Py7pas1+oa8iaYN/vlbWUMo+vHAT5wMNLnybb5zwt5EOXYk7nbQjf+oLlIgp8Sj83iNNr+t7qNkxrdlU+ZD2LSltQdLBKxcHsgiAJFIKvUgcm+d5+WAS29Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053036; c=relaxed/simple;
	bh=7w+zfYL5/EU3k21GldfEZOmIoR0yGMwEVvQsUYIGfEg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WreR7uhbnnMuroSuJfM4KO1/urGSCd211C8rUz3gPSqMk+ttgk3/mzt0mNkOv1Deycpx5FRi4CIEfPcieAXhJsqH5YigbsXkb5+0FmxkJYHRJaYQVqctUNL4hI54DcXc4C4LlZ/v4rZ3Ks34hy/5056zoMfnY7uaQAID7RDFm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V83bQ4VC0z6K98F;
	Tue,  2 Apr 2024 18:12:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AFD60140A87;
	Tue,  2 Apr 2024 18:17:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Apr
 2024 11:17:09 +0100
Date: Tue, 2 Apr 2024 11:17:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <david@redhat.com>,
	<Vilas.Sridharan@amd.com>, <leo.duran@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>
Subject: Re: [RFC PATCH v7 12/12] memory: RAS2: Add memory RAS2 driver
Message-ID: <20240402111709.0000653a@Huawei.com>
In-Reply-To: <71d41ec9-17ed-442f-8d68-a6cb9bcbb4b0@amd.com>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
	<20240223143723.1574-13-shiju.jose@huawei.com>
	<71d41ec9-17ed-442f-8d68-a6cb9bcbb4b0@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 28 Mar 2024 11:23:38 -0400
Yazen Ghannam <yazen.ghannam@amd.com> wrote:

> On 2/23/2024 9:37 AM, shiju.jose@huawei.com wrote:
> > From: Shiju Jose <shiju.jose@huawei.com>
> >=20
> > Memory RAS2 driver binds to the platform device add by the ACPI RAS2
> > driver.
> > Driver registers the PCC channel for communicating with the ACPI compli=
ant
> > platform that contains RAS2 command support in the hardware.
> >=20
> > Add interface functions to support configuring the parameters of HW pat=
rol
> > scrubs in the system, which exposed to the kernel via the RAS2 and PCC,
> > using the RAS2 commands.
> >=20
> > Add support for RAS2 platform devices to register with scrub subsystem
> > driver. This enables user to configure the parameters of HW patrol scru=
bs,
> > which exposed to the kernel via the RAS2 table, through the scrub sysfs
> > attributes.
> >=20
> > Open Question:
> > Sysfs scrub control attribute "enable_background_scrub" is added for RA=
S2,
> > based on the feedback from Bill Schwartz <wschwartz@amperecomputing.com
> > on v4 to enable/disable the background_scrubbing in the platform as def=
ined in the
> > =E2=80=9CConfigure Scrub Parameters [INPUT]=E2=80=9C field  in RAS2 Tab=
le 5.87: Parameter Block
> > Structure for PATROL_SCRUB.
> > Is it a right approach to support "enable_background_scrub" in the sysfs
> > scrub control?
> >=20
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > ---
> >  drivers/memory/Kconfig       |  14 ++
> >  drivers/memory/Makefile      |   2 +
> >  drivers/memory/ras2.c        | 364 +++++++++++++++++++++++++++++++++++
> >  drivers/memory/ras2_common.c | 282 +++++++++++++++++++++++++++
> >  include/memory/ras2.h        |  88 +++++++++
> >  5 files changed, 750 insertions(+)
> >  create mode 100644 drivers/memory/ras2.c
> >  create mode 100644 drivers/memory/ras2_common.c
> >  create mode 100755 include/memory/ras2.h
> >  =20
>=20
> Sorry if this was already covered, but why not put the common scrub and r=
as2
> changes under /drivers/ras/?

Hi Yazen

Location / naming etc is definitely an open question.
Given the OCP RAS API has repeatedly come up in discussions (and that
has a much wider scope), a RAS focused location may well make sense + some
renaming to avoid being memory scrub specific.

Jonathan

>=20
> Thanks,
> Yazen


