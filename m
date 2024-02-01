Return-Path: <linux-kernel+bounces-48546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2185845D82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025171C2473B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B79522F;
	Thu,  1 Feb 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVIcQ1j4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F13FFE;
	Thu,  1 Feb 2024 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805757; cv=none; b=agQRx+aIJdg+uxHIF/WW/ePtdE4JvZdAm5L2z2nQzy5Lm5JE1OkLiKZYWceW/Qtj/Tn1JcNQuP53vl0NR/c/owXqLMCukKHYRIAYOESIR3VV6UdUSdOkqf1AOBVmq/1jvfywBR41Lakxhn2CYYGAdd+/1BgnT8V6XYbFNr/DM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805757; c=relaxed/simple;
	bh=Crd3dJgXe4fYUS6yZk7Jg/OJoQ9gKfrffjshj7lAM8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMHyyZkZO7CDB6dFLXEC7mqlExncos/maMKcQMu9X4D+6UWML7uB1cTRNcs/0V4/6I/PveIctTO8cIQQYyhsuYoNdVdV1HhaK9bEADbS3kGRUXlT6TL+ln54l2LwTFeKIyqDM0aMwjRmQa+lHSjKhRMF5wtho2jaT0Ww2Sgkv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVIcQ1j4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706805756; x=1738341756;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Crd3dJgXe4fYUS6yZk7Jg/OJoQ9gKfrffjshj7lAM8A=;
  b=ZVIcQ1j4wLvA1kpqAyDL2PaYQFti0RlU5QiS7hxb7wmv1ProZb/MKQ/e
   8WcfUPGX2U2na3Bq5l0+8n1Be8IGVfqKZmB87MnVNG1bgp1ePZzxW+dHL
   a0C9SIliP/ZFEK3zUIPHNV3fPxjJsbYAfyHs3XnzFx4Of1eNE3IL6AUKN
   pcMPcvQ6xiQwE2f9BdzzspVtPbpcEnm19Je9Men60pK/quY6/4ggIgHFv
   IXV8NbdmlHs6DOpjKOmwYi4dnJo2jsSqEEXFRA3nc0HCGey2kXrk1qX/5
   maDE1rTQQatYSS1QCSuONyYRd3i4+GkiKQENQg7d/QKY2kyItQyqFvhNY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10688931"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10688931"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4437860"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:42:34 -0800
Received: from ssigler-mobl.amr.corp.intel.com (unknown [10.209.41.165])
	by linux.intel.com (Postfix) with ESMTP id 16F6F580D28;
	Thu,  1 Feb 2024 08:42:34 -0800 (PST)
Message-ID: <94a61858ac82ceaac1ef8ae41067ae7356512d7d.camel@linux.intel.com>
Subject: Re: [PATCH 4/8] platform/x86/intel/sdsi: Add netlink SPDM transport
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, ilpo.jarvinen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Date: Thu, 01 Feb 2024 08:42:33 -0800
In-Reply-To: <ZbtjyOBHzVKXu_4H@nanopsycho>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
	 <20240201010747.471141-5-david.e.box@linux.intel.com>
	 <ZbtjyOBHzVKXu_4H@nanopsycho>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jiro,

Thanks for your comments.

On Thu, 2024-02-01 at 10:26 +0100, Jiri Pirko wrote:
> Thu, Feb 01, 2024 at 02:07:43AM CET, david.e.box@linux.intel.com=C2=A0wro=
te:
>=20
> [...]
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: spdm-req
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: binary
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: spdm-rsp
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: binary
>=20
> I don't understand the need to use netlink for this. Basically what you
> do is you just use it to pass binary blobs to and from FW.
> Advantages, like well-defined attributes, notifications etc, for which
> it makes sense to use Netlink are not utilized at all.

SPDM supports the setup of a secure channel between the responder and reque=
stor
using TLS based encryption algorthms. While this is just a transport for th=
ose
blobs, netlink seemed an appropriate interface for this type of communicati=
on.
The binary blobs can instead be broken out into the SPDM protocol messages,
right out of the spec. But for our needs this would still just define the
protocol. The algorithms themselves are not handled by the driver.

> Also, I don't thing it is good idea to have hw-driver-specific genl
> family. I'm not aware of anything like that so far. Leave netlink
> for use of generic and abstracted APIs.

Sounds like an implied rule. If so should it be documented somewhere?

>=20
> Can't you just have a simple misc device for this?

It wouldn't be too much work to convert it.

David

