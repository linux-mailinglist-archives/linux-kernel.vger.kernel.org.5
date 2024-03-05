Return-Path: <linux-kernel+bounces-91851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34451871775
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FCC1C212BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04197EEF0;
	Tue,  5 Mar 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="zw8Bg3ob"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C98062A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625275; cv=none; b=IOGxyW5mfbxFkfm8vShHHhAz5/drJEmNDix/x0uUzfk4PXB19XeHbPvA8tI3mOHm6jexKoTNs1SfV5M5p3bSeRsKcyjdDI4HHucCWDZugTLHCBg1MI5gQ0viP0F3aZfaRy5rMI0CL6vmE2FJpSm6C6TepOqfUozRQuAxrcd/2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625275; c=relaxed/simple;
	bh=AuzwDUD2zkHInBdtBWj8SNBTxsOukGFJEM0wrSHKMFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd99GGDbGzeqHNHxdWh3lrUdee0LdmowsMfTzMmiKhqXlGp4qhv9vAF/QAijPUkKfc5C38KcKXToyZ9wFwq5mKRiqgUp+wdhXIHx5tOQn6nN3Hm8qM4Z1jYcS2BAYmIj2kZ9yIkGlOqgJF2nh4M+VE8+7crCqFRQ1x5rNMh0qd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=zw8Bg3ob; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5675D1C751A;
	Tue,  5 Mar 2024 08:54:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709625267;
	bh=AuzwDUD2zkHInBdtBWj8SNBTxsOukGFJEM0wrSHKMFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zw8Bg3oblecWkYds4lX+J/RZrpq1OR0quO4zjfo1d22fIPRzj/Gv+S6o+zh0VsjPB
	 eo+8po+gyB5MwWqaRZg0jSGxgK+81Su70zwX0KwWr7yq7iu4ffmbZmBNJB3Vc++riA
	 eR9w0cELQQVBR5AUpfidmDNSPg4DgpP+wdPEIXsCerB0HbAWhwwTJnN/29eXR3BiYv
	 zEmjcO/3VbfvaxaiiJGxn2cASJE3jzwBp4rBtE6OegGVpYM3X69xJm93g+eeOGqmQg
	 e6QLQdChD1ueg5yaoapbHbQHPG3IGgVVBjddbhNVP5u9stff/dLq86mosW1H/i5Ph9
	 QwfX5TkOJZtww==
Date: Tue, 5 Mar 2024 08:54:26 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iommu: Fix domain check on release
Message-ID: <ZebPsvHQWJcOgmUW@8bytes.org>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305013305.204605-1-baolu.lu@linux.intel.com>

Hi Baolu,

On Tue, Mar 05, 2024 at 09:33:00AM +0800, Lu Baolu wrote:
> It fixes a NULL pointer dereference issue in the Intel iommu driver and
> strengthens the iommu core to possibly prevent similar failures in other
> iommu drivers.

Please send me another pull request once you consider this ready. I
guess it is v6.9 material.

Regards,

	Joerg

