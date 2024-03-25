Return-Path: <linux-kernel+bounces-117342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32EC88AA33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9066F2E4FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D48153A7;
	Mon, 25 Mar 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgsiOPh8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A404A22;
	Mon, 25 Mar 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379582; cv=none; b=kqzuMQEj6vAOm3zq9egYdEuNld0ZhVF7TXds1x4oSUgy/N/2RyyCqFY9sDXJH2iGi5E+5njK5YPai5DOU1nw/kwZxzYhmQOp3L4rWZ/tftKsWZlmL5lIRmoVTE7FVOqe89IXDYvaxk6OEla56q71+pGQiJKPBHqPHZhtsr9Ne84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379582; c=relaxed/simple;
	bh=8OY/TKv9wGiQsrHn/ApJGX7eVaWT2gxG2A8uasC+Mv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrToFg1hnfvA21ed56MgFpkVjALMg5bEUUafg7AmgJihQ/NPgrUubw4YMyIqgNM9U1sg+O9opoqQESeFWuWBx30FRW0gV6++WOHJZdLUB7nWMQjg/OprMeFfUbyTH8hOXiGcZ/aSvEOfHA39/aoRpTUI5ouNMzNlAes5/SUsSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgsiOPh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49D8C433C7;
	Mon, 25 Mar 2024 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711379582;
	bh=8OY/TKv9wGiQsrHn/ApJGX7eVaWT2gxG2A8uasC+Mv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgsiOPh8cTJJYeddwhNyoZRcPlmuC834jgQs/O1wH86BG0FO9LqoJ5dpHz0amJ4I4
	 EJWhZGJK9Izh9RZoyHaLYBWw/VVS4qeunUwQHDLl/l0N5cqxJUG1R3HHRLkhpqeCcV
	 gzefOHXhqHL3B+Wq/GTFMKkIz3tj+p6/m5dlJ5N5yQU0W009zeOMqEyMYNsj2M0gA6
	 F/U5kY45OLHDN/4bfVRsY6AWxbZo48N7YrrOuz3X+ZrVunXrqf/4zTeQywM7KGW10T
	 E4KUwk3/L7O/Axj57s+edgORFJqzroN8d9pzbVoElqAALf4RDcKgSXtY/Myg7ie8Wq
	 YXuTMlWTQHOGg==
Date: Mon, 25 Mar 2024 10:12:59 -0500
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
Message-ID: <20240325151259.GB3591150-robh@kernel.org>
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

Also, please version your patches. 'RFC' is a tag, not a version. v1 was
July. v2 was March 5th. This is v3.

Rob

