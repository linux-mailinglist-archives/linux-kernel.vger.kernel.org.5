Return-Path: <linux-kernel+bounces-136073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 480ED89CFC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE9EDB21415
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D336D8BF9;
	Tue,  9 Apr 2024 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxce2qzZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147DF4C85;
	Tue,  9 Apr 2024 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626052; cv=none; b=JwnrQiyXhARqNHIsgf0Eg4HlcpmtQc+SjZpAXK5EchxYvwkuYH6XPQyR1KfajZQsrZvGELCZyoCJs7eE75y8lxzvdLyN7M3rpVGSeEFQYSrfHwwQw4JhKZtL8LcS96hKfX3v32/XfcnYYvG7vKwieHH1A37Zh0q1hEL6SAmBgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626052; c=relaxed/simple;
	bh=TpKVqjJdJt2Rx3+aFUTkbwQqEDMryLywvwDEX0tYaqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PI7rKR4WN//+aSPOd5hqfq0e/njmyeTh7IjEuF5S/bIuzMP0cFJNkX1rNTBRi4NubXaWLpaP59carcroY4ykf0KLaXU3Zg9JJsc5VUcUqW9daooM++TCDhJl3HBmrhKVC18yGt9ffLEsVHMSEze53XsJHE6ARsfaoU4q4ZKqctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxce2qzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D415C433C7;
	Tue,  9 Apr 2024 01:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712626051;
	bh=TpKVqjJdJt2Rx3+aFUTkbwQqEDMryLywvwDEX0tYaqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qxce2qzZdFF6c27j22tWogDJUbx2Kzh9vADyXs/0ydLCwdJQyUgT4Mxvf4wTyW3D8
	 uj43hEG/xi+UxE/3U0PIrsWnmwyMNes/s/mVa+U9R+E8fEjoX1J99adguTf2c4p8HS
	 oE0sK50sUJXu80/vLUOucXmg2X++jHZwXET39+LWGik0z769yujNdT4U/XXawC0BlV
	 76AZcI6qlsu8cVbD+cS1vV3meRJpTDRLYkskesRNkkvV2+ODDmVyGtXucuI3D0sHUU
	 NVKQy/49eDF0rSXCXSz+DuebJTYut16jLvtbzOiuwe9EYJqfF2kaM0jS7Fs7suZEag
	 rW2GVAOD5cSxQ==
Date: Mon, 8 Apr 2024 18:27:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, syzbot
 <syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com>,
 davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: global-out-of-bounds Read in
 __nla_validate_parse
Message-ID: <20240408182730.5f8dc617@kernel.org>
In-Reply-To: <ZhO1m9aSxElXTvri@Laptop-X1>
References: <000000000000c30be606158f33db@google.com>
	<CANn89iLq3PdiuS=qYAtUKFcrd24z2Kw8k=gMNcBcaEFkTWpd0g@mail.gmail.com>
	<ZhO1m9aSxElXTvri@Laptop-X1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Apr 2024 17:15:07 +0800 Hangbin Liu wrote:
> Thanks for the report, I will check what I missed.

	.maxattr	= ARRAY_SIZE(team_nl_policy),

needs "- 1"

