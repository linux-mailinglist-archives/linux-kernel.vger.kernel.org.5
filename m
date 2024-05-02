Return-Path: <linux-kernel+bounces-166996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB58BA31D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498031C218F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1517D1DDF8;
	Thu,  2 May 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OE/3/ODb"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68FA57CB2
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688797; cv=none; b=GgrvxwosaGmgJq2YIpqHUURhSDjDJHCQU1gr18mko8rMZ/LLL9Vw9y7vFURoJXXo4q/Cp8ENrpni2UYCfo7GeU8G96SqdMRephda6o/VxQPH3BRxVuIXJxAQegeFdxtphejISFfew5fOuQ3G2keIWpKP7zS/4GthcF3lNNCntBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688797; c=relaxed/simple;
	bh=OFyhe+pZ002CGKfqUyrrvABdHY64yqc4yo/dkPbQBfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scVpCgBZxFCC28e0OB2weng/OZgbCJYPgZiDIShPvMbneoJjtjlqMG3DJYO0BeblwUJDKDMnj4Zi0/eGOEk/cungecx3wsFWaQ1Sg5sd87y/GTV2ifB/wQrs3BhEMFFTATVgqQCsD4UqfzT3YufVByDJL4WcbeQ2JPLV80ZHliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OE/3/ODb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 442MQITb023809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 18:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714688782; bh=IcvOCz/6+um4o0OaSx3gbOetx5YYhVfo6D+c4SaOQr0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=OE/3/ODbINXLodxg7NhkZenTN6kcRtlqVKLvQNgdADvVb2lLMZg7Bj9MzT8+YpHVG
	 6Jo4V9wOjqH3Glzv9c476R0qd12p2mlh1lpNaq/MJg17GQOC4+Y4Q8FDBDi2T+JYoN
	 E4thypwFzAM3vmdhmejW+uEejodyauR+21v+LBsaAt1gcFxl9sNIK+82f6UYwFlDgH
	 0ajaBnxlty1U+P3qKQe3AyAfeZbFE1X6d+GMdar548WeReUWRCnknwARJk0Q8OTrJr
	 Eu0zxvnTVcRlXGXmfQQwvwrIC0Pu9ETmPucYrSspvathy6yMhJCeKuocDIDgxgRsC3
	 BqHjXKm0jOTTQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B4C6015C02BB; Thu,  2 May 2024 18:26:18 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, brauner@kernel.org, mforney@mforney.org,
        Max Kellermann <max.kellermann@ionos.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ext4: apply umask if ACL support is disabled"
Date: Thu,  2 May 2024 18:26:16 -0400
Message-ID: <171468877064.2998637.14217086529278734176.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315142956.2420360-1-max.kellermann@ionos.com>
References: <20240315142956.2420360-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Mar 2024 15:29:56 +0100, Max Kellermann wrote:
> This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
> commit caused a regression because now the umask was applied to
> symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
> has been fixed somewhere else already.
> 
> 

Applied, thanks!

[1/1] Revert "ext4: apply umask if ACL support is disabled"
      commit: c77194965dd0dcc26f9c1671d2e74e4eb1248af5

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

