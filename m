Return-Path: <linux-kernel+bounces-147780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557EF8A7995
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B061F23620
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F27A1877;
	Wed, 17 Apr 2024 00:04:09 +0000 (UTC)
Received: from 6.mo581.mail-out.ovh.net (6.mo581.mail-out.ovh.net [188.165.39.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BD184D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.39.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312249; cv=none; b=ZWOm2hr8xBrkNmIAR7QfSLFeYyulBtowTZeT34ZH+OZNRS4gxUv4m2n02dkJRCy7KRmnXXCjRNQY78i+AlCrfVjoIOVQ+V97U8+6j/9ebPlfQ6aJrCWk78nQ3qEKsuHH3LDciWzIqF4NFAGm7bmVOLS/sDfj54lDNR/mvGvhXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312249; c=relaxed/simple;
	bh=EW8jp+SOURsYTPLl+PnV7ZSN+FjJCWndNz+gCCwD2Iw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qYTmqLWfL+shRl409CzvlMaVZ7y5lYDG33jHXCE8T5bL2z+tRkT8p86DIRDTlsL+JG1x/9+NTUynn/XJu820iLvNmYcx2Mg+RCb+FAoCKZtEzVyX4+kDc1CSNHDv3P/38h8bHbj67f/cksk+xHp9LdH4OL/xAeUjBWvqCO4st4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=188.165.39.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.25.74])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4VJzfX2jmmz1NF7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:46:12 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-tl4st (unknown [10.110.96.50])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B04DC1FD1E;
	Tue, 16 Apr 2024 22:46:10 +0000 (UTC)
Received: from etezian.org ([37.59.142.95])
	by ghost-submission-6684bf9d7b-tl4st with ESMTPSA
	id NUZPKbL/HmYJMQAAgyXpiA
	(envelope-from <andi@etezian.org>); Tue, 16 Apr 2024 22:46:10 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-95G001a22ffe43-1d0d-41f9-8b5e-b6b47462b279,
                    38C292890E232DD6F9946AE994780F0893807590) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: chris.packham@alliedtelesis.co.nz, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abhinav Jain <jain.abhinav177@gmail.com>
Cc: skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
 Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <20240415161220.8347-1-jain.abhinav177@gmail.com>
References: <20240415161220.8347-1-jain.abhinav177@gmail.com>
Subject: Re: [PATCH] i2c: mpc: Removal of of_node_put with __free for auto
 cleanup
Message-Id: <171330756789.1978363.15038881964177013027.b4-ty@kernel.org>
Date: Wed, 17 Apr 2024 00:46:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 18425351976007961206
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejjedgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffteehudffvdfhudfgffdugfejjeduheehgeefgeeuhfeiuefghffgueffvdfgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht

Hi

On Mon, 15 Apr 2024 16:12:20 +0000, Abhinav Jain wrote:
> Remove of_node_put from node_ctrl and node struct device_nodes.
> Move the declaration to initialization for ensuring scope sanity.
> 
> 

Applied to i2c/i2c-host on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] i2c: mpc: Removal of of_node_put with __free for auto cleanup
      commit: 24e4a0d7c6b7a6491cc44781f3900129f56f447f


