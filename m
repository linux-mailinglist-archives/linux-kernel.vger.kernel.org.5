Return-Path: <linux-kernel+bounces-123953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB020891023
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276C71C26531
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB28614011;
	Fri, 29 Mar 2024 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ5AfGP4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFB139FD7;
	Fri, 29 Mar 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674623; cv=none; b=UJxpX85GD3eCEduRpH/eJxVSEJajuQRwdlW87jykmrypBZsfifEYjs4m0aOVuMzUgiUFIC0LEHC2L9qcutilHohSnh26NDihXyjZ0iKXzxARNgDFJBj5OCkjeCrlVPrStzpSMifgJeGl1CST28WtYNHYAkVzS9UypJW/9u7kJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674623; c=relaxed/simple;
	bh=7JnxwlqzuSgt3eWXjoIiGflT6soWAUdDEi2na6CjuF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ST7sA5IHnSiaZUfu4y1jrgDY/dm0BeYFyt/IjW1WmlExZKba6auY64LAL6MF40iuCp1a9lOCcGmDtVsKyoi4OVBpJwYl3G+Ezp9FsxJ6djOe6QJ4JCREDDyRn0tEnAGmpI1MU0hWAcsvwAQRc3s3aKRJIz6ahqC4ZIAtPtqHTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ5AfGP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25D4C433C7;
	Fri, 29 Mar 2024 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711674622;
	bh=7JnxwlqzuSgt3eWXjoIiGflT6soWAUdDEi2na6CjuF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fZ5AfGP4OUTFqC5Rlvth6ogwgOkxeOQ9X3d0S3Uabjj02Q9lKWsAV3/b5HCqjE79Y
	 Hd2AvSzncl9FDgTfQvwgBbMVhGr9pAXTBENcN3UXr9lG3pqCNuVeSAYBtV9xV6NyDN
	 CXg/jnCgNq+x57TuYK40ZsD/4fxK5qA/kEJE3CTTKdqWs0G7QkUvyjQdzi2ZfibLLm
	 oK8InEmcL25rkKDvc1t9VkVKvi36ICdTI9EiA82eVOZgowQR4R7lkISy2TPIPIb6Dg
	 z7vONLIwavmt96OayxXnD5QSAhmCGTpV9/Bas3cKAfmFzSBrHUWaRYb3XtBrEEDQuK
	 k5O7dXdxbV1bw==
Date: Thu, 28 Mar 2024 18:10:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Michael Chan <mchan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, Michael Chan
 <michael.chan@broadcom.com>
Subject: Re: [PATCH net-next v2] tg3: Remove residual error handling in
 tg3_suspend
Message-ID: <20240328181020.1bc21a3c@kernel.org>
In-Reply-To: <20240326183544.488242-1-kiryushin@ancud.ru>
References: <CACKFLikPmtbkvVFerB0WNvLN3w=ia_vd6fUAo8iWpAqNsegMaQ@mail.gmail.com>
	<20240326183544.488242-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 21:35:44 +0300 Nikita Kiryushin wrote:
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Please stop adding these lines, they are unless.
If you want to attribute the work to some project / employer
add (SVACE) to your author lines.

> Fixes: c866b7eac073 ("tg3: Do not use legacy PCI power management")

How is deleting dead code a fix?

Please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Hopefully you can find in there whether we suggest posting new versions
in reply to the old ones..
-- 
pw-bot: cr

