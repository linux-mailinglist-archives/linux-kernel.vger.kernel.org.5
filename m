Return-Path: <linux-kernel+bounces-155998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5542B8AFC83
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF081F23026
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D03E49D;
	Tue, 23 Apr 2024 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UKlBvUxs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD418B04;
	Tue, 23 Apr 2024 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914691; cv=none; b=ZALl0syyE2KJuL6QdD9q9nQwAlco1f0dKTIW04yvaBLfHIjHY6nPbjNu4BiSWT/QnNirzhV69zvx+YYU01UZGDFymu0IVILFsVOUM5QXXQbx3PHt81qkXHmy862ByBOPHXoWoPh93eFuWiTdE0DdBIlZzKyL8oraXg3d1fiD82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914691; c=relaxed/simple;
	bh=k/0foCcS/TpxBHn9jBEUKmQjPCjZQEGaRu/IhQaq+C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIQwbDit1zP9PUdF+tTVZHn1qjW7/vXmGvUBbHoPkKXuG7w2MqYUXkuHRZQnha3kOwg3ka/pLnAqil+g/ZyHxNqqt1vLOTprfUTg0lWKUItaru+04Eqf1FDm1y+Jp28eX0ZzJEVEaq0teopaRxfYy2NUeRuFOYar2cY3R+ue3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UKlBvUxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BCCC116B1;
	Tue, 23 Apr 2024 23:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713914690;
	bh=k/0foCcS/TpxBHn9jBEUKmQjPCjZQEGaRu/IhQaq+C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKlBvUxskJz17De96dXcMz60yICquL/yyU4xQERJXSG71eIhJ/haT5ysnHM74ty83
	 wFBc6IIqu1zb1Fen1CDsIumGFrvSOoBuCiOXUekmGU/OhLViQv3fdpEfMZ289G+7zv
	 g1lPKuyXQF1d83riWjf6C3jZmNbJfttlLiCwMcwc=
Date: Tue, 23 Apr 2024 16:24:41 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	Brett Henning <brett.henning@broadcom.com>,
	Harold Johnson <harold.johnson@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linuxarm@huawei.com,
	linux-api@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <2024042329-handcraft-mongoose-8f23@gregkh>
References: <20240321174423.00007e0d@Huawei.com>
 <66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
 <20240410124517.000075f2@Huawei.com>
 <CACX_a4XGLgmQC3cqCmDJnrcnfjQRW4EmV8BZTCC=MgzwYwdhXA@mail.gmail.com>
 <CACX_a4UM7wqb_eGSP2m2f2ytQGB3j+3Y4iP2H1UfMdVmm2a+=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACX_a4UM7wqb_eGSP2m2f2ytQGB3j+3Y4iP2H1UfMdVmm2a+=w@mail.gmail.com>

On Tue, Apr 23, 2024 at 04:44:37PM -0600, Sreenivas Bagalkote wrote:
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.

Now deleted.


