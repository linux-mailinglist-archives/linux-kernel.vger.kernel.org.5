Return-Path: <linux-kernel+bounces-117334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE5E88B33B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0DEB26ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D188526D;
	Mon, 25 Mar 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti6eVYIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E671756;
	Mon, 25 Mar 2024 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379449; cv=none; b=cNZYygfF5ZBNRvxnhE6jRC+s6DMxNBvI+Ss+wBq9XLpaOVfGORtQ7uP4WmvdOnq5zlT65ezjp3VnecLtWB0ei4ENERgSRs3VOQvPzD6Go5reoLIZmlTBRl55/aXMIFwO00ShKH1x1J8X0gt7aPOJx5AsrP3/75MKOkRtWrsE4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379449; c=relaxed/simple;
	bh=trg7U+nLMFYCvy+OFlT2yFQrUXZMi1r0QsFIeOhyV5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0kYSbKQk2fP5FaT3jculc6kAKEUAIcrqKIYuhq4YPx14A+VTMndrWjauzSprrNnRJhR7rcRACFC2ar/sdxhUmaIZQCk8sp4rJCvbAGGLv9ENQ2HIYxD6VQMCmZoadbTC058UNj5oycTHGUFOdaZMD46d4K8+gifWsftW9+SxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti6eVYIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7E0C433F1;
	Mon, 25 Mar 2024 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711379448;
	bh=trg7U+nLMFYCvy+OFlT2yFQrUXZMi1r0QsFIeOhyV5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ti6eVYInJXHAVKyP7Tfo6+ocS313pVhZ7NHgFubN1R5Sf2kgudJg7yL0C6tCZ+uvt
	 zKcnghy9yia6BSRKb0mRE01TkhMQrTMAVYcZfpPEII2Kdwu/TZjHhbALDFWa0SktA0
	 YJR013P3yI0NaC77QGV/AO97/pUvRlkzHbPA7Fe6+PutVXjFP8gc2qCaYlZr6/axlv
	 HdRws+E6gi+1llflUZpe8pjiKto71vgtm1/8K2GbmoA2Tpmm+NAfwh+UYOEPxEsnRU
	 cAmRpvvMpMtOJEmZUrSlo3XTnjnpUJMluFEHASxdOMjkngO9wLm/ORZgP/XCYJtX9I
	 UnLnmod4B0sSw==
Date: Mon, 25 Mar 2024 10:10:46 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/8] block: implement NVMEM provider
Message-ID: <20240325151046.GA3591150-robh@kernel.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711048433.git.daniel@makrotopia.org>

On Thu, Mar 21, 2024 at 07:31:48PM +0000, Daniel Golle wrote:
> On embedded devices using an eMMC it is common that one or more (hw/sw)
> partitions on the eMMC are used to store MAC addresses and Wi-Fi
> calibration EEPROM data.
> 
> Implement an NVMEM provider backed by a block device as typically the
> NVMEM framework is used to have kernel drivers read and use binary data
> from EEPROMs, efuses, flash memory (MTD), ...
> 
> In order to be able to reference hardware partitions on an eMMC, add code
> to bind each hardware partition to a specific firmware subnode.
> 
> Overall, this enables uniform handling across practially all flash
> storage types used for this purpose (MTD, UBI, and now also MMC).
> 
> As part of this series it was necessary to define a device tree schema
> for block devices and partitions on them, which (similar to how it now
> works also for UBI volumes) can be matched by one or more properties.
> 
> ---
> This series has previously been submitted as RFC on July 19th 2023[1]
> and most of the basic idea did not change since. Another round of RFC
> was submitted on March 5th 2024[2] which has received overall positive
> feedback and only minor corrections have been done since (see
> changelog below).

I don't recall giving positive feedback.

I still think this should use offsets rather than partition specific 
information. Not wanting to have to update the offsets if they change is 
not reason enough to not use them.

Rob

