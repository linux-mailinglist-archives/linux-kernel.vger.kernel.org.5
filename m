Return-Path: <linux-kernel+bounces-166874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9378BA135
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3D0283B00
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5761802DE;
	Thu,  2 May 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WQ5ApR9V"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322B1802AC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680036; cv=none; b=cmwZ8Z7G8AxDG2t6Hs0XdWjMaaOUdC9t5AH3iLms9I00eNYZEl0dkTpJxhai/6YnA+DnBBtPpZuLhKmQpZ9qTJlsYJs7xXXYxYD/NsuZI4YTUxptM6MORZKL5Vgcqk33L6R9D66RvUn4tUsL2Pl3CCg9T/XNrHLeyWNbDh7LJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680036; c=relaxed/simple;
	bh=Dz2IS0uGk6KutXwNxxDqdcyx+6SIcL3NOrPBHVlDXX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3xivH0XnNDTBhgVm8f3DO69SHfopxZDnnk5IFrk0jLkYCv3k1q1rAs30D/FBBHbrwAF2V/FxXVCAjHZuN5D1/jJj+/gy+IQLFtfwIePCU/6A0Zfo3lF6rIZttRkqaZT9TGb9E/QR9rKrwpBn4vnazEW+ojTP8iQtoJZr9OdxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WQ5ApR9V; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 442K0D20006122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 16:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714680015; bh=sb24B9BC3hrQGO6UpuPnK7K5k0AjijhW9KmUQ0N9vUQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WQ5ApR9VlXqHdlJrMhEWGqwvGNAzTn7wmDToPhF43E//AQGQv5Hyf6TfeaSsi8OK0
	 y+RwAIuhxL975zvpk96yutr8BiiwDKKeHNgBTU5e51pKuP8uqtyKxLGa/Og1+iTyzq
	 mSROkQVzy6Imqi97Sm1RxCP8KG2vd9oSjFF2XSW0yuKy6qVHho0u39Yqs7lQUN+cEP
	 gZHxRp9v+c5XayZTaILEt+eFlkV+bUAOIc3f3Bh/oAzGsGw8URfaXkqCJDWeAX37OD
	 Y4As/kwbeTYIRwH/4BKC8/qMfGyAfnJhK8nkPYfxs0D0ISOI4WzJ35HQvuYIbdl2+7
	 D0gxOjaGA+iJw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AB09815C02BD; Thu,  2 May 2024 16:00:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: torvalds@linux-foundation.org, Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/3] bit more FS_IOC_GETFSUUID, FS_IOC_GETFSSYSFSPATH
Date: Thu,  2 May 2024 16:00:09 -0400
Message-ID: <171467920458.2990800.13769245148014938392.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315035308.3563511-1-kent.overstreet@linux.dev>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Mar 2024 23:52:59 -0400, Kent Overstreet wrote:
> implement FS_IOC_GETFSUUID, FS_IOC_GETFSSYSFSPATH a bit more
> 
> also: https://evilpiepirate.org/git/bcachefs.git/commit/?h=bcachefs-sysfs-ioctls
> 
> Kent Overstreet (3):
>   ext4: Add support for FS_IOC_GETFSSYSFSPATH
> 
> [...]

Applied, thanks!

[3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
      commit: fb092d407262eb4278f3d1ca24da54396a038c62

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

