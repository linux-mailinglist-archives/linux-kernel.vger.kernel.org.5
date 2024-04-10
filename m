Return-Path: <linux-kernel+bounces-138429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69489F11B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44041F24C32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755315AD9E;
	Wed, 10 Apr 2024 11:45:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9956015AABA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749544; cv=none; b=AJVNfOG7VgZMJcKrc2zj4cfp0gIpDmf8UysNRBNoH60hWrwCYNuuqwdDJPvFkh7Vn8e2LAUBCTlP2KlaS/v0Sa+7SZxEHHHlHUhuC0qeetGHfCBoCriUhADZA8yNLhtjAoMVeshl8XIs1nThTO1lBBFkNkJs0tuBBH2FBadgV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749544; c=relaxed/simple;
	bh=LvJgUCXexRkCISqT/1dyY3snYZAh2KoauNvZ3Rma7Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtyZhyKA98A0RMRWYR+447fPpIlgNtiGwmDsq7HYUQsOZki/otX3wLX4p8WqHyX1hRKO6CP3RFnl0w7Q1/DTRHyqX4HyyLsEyu9wn/YOpcLanQKN1uxueXY637PgcwDKMBm4dkGS0nIQ9tWwGvW/ha5owasxRP2IJ+CaR+U6KJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 837BE139F;
	Wed, 10 Apr 2024 04:46:11 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90F0F3F6C4;
	Wed, 10 Apr 2024 04:45:40 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:45:38 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Marc Bonnici <marc.bonnici@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bertrand Marquis <Bertrand.Marquis@arm.com>
Subject: Re: [PATCH v2] firmware: arm_ffa: support running as a guest in a vm
Message-ID: <ZhZ74uixE4a7yJ-Y@bogus>
References: <20240325081335.2326979-1-jens.wiklander@linaro.org>
 <ZgLrQ7FtDy3INX8F@bogus>
 <CAHUa44HuuPE_cs3i4XEvHpSV+T0koCqBPo66uOmYyQ1=Rx=NWw@mail.gmail.com>
 <Zg1TmTcqRbzla3nN@bogus>
 <CAHUa44HCfFJzw45361zpGGW+sXTcY6RZa0nsrdG6bu807PwoWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44HCfFJzw45361zpGGW+sXTcY6RZa0nsrdG6bu807PwoWg@mail.gmail.com>

On Wed, Apr 03, 2024 at 04:27:43PM +0200, Jens Wiklander wrote:
> On Wed, Apr 3, 2024 at 3:03 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > Understood. I will take a look at the patch with the above information.
>

I reworked this a bit with the idea SRI and NPI will not be required at
the same time. Posted the series [1]. It would be good if you provide
feedback on the same and check if it works fine under your setup.

--
Regards,
Sudeep

[1] https://lore.kernel.org/all/20240410-ffa_npi_support-v1-0-1a5223391bd1@arm.com

