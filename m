Return-Path: <linux-kernel+bounces-136582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9323089D5BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF63A1C22E77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660E980603;
	Tue,  9 Apr 2024 09:41:22 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8D80024
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655682; cv=none; b=BEJIX+AP4oh3hAxR4xDsQs8aCMS6mjdY0fanF2k97tVBn9Z6cJRxTQCE2qU845UedabKy93RG6RWSrsxjH3PRePX5LK+xD6fD89qXPcYNqo7oKysXbnXD7ci0RetoRHgLmRFGGcMZcvboSjue3fbNdM6JaaAThyDYBuN4tFaXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655682; c=relaxed/simple;
	bh=iAPmVF6KaLuV5MVatgzvCextwpb7uPvSYabYgitNEBU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=leEobDY6DWxyb92ogblZfFtFRt4jW0+5o5Fa3xW6ou/fggHGKHNQ5wWnEILPMcGot+GnvGMK3O409xiH78SUKhjT52XpeNnSYn35rNpnVMNlkMhFzkQpbOLnodECD0BJdUZSoTrh1MGeiUMDsyn7Fmp6u9q2s7tbez93jgj0+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5d650eaafso228404939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655680; x=1713260480;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBQCITvYBxj3l+cx/KB6qSZCztStj4/cKflnNOZXh/g=;
        b=Y+AVXtTBTsH0WwPf5F0x0gm1M9MY9sey5qSzdeVQr4ls66MWp7GQRZ1lvdUJtRQNoA
         2M5UNuTi5Qw4NTGoLdZRoidYVlKfD4ykPwnqoW33u8fDVbPCIJZ0rfWFB3bqrTL7Bkm+
         C6OVWCkAhyhP9tt2JHO9cc1AUXLpYD9dkJLcqpUtRvvilZWalD8eXF2pZz8SDLCytbaW
         DPAMs0Rd8IperLHaH6UXKHjIcK9PpeaezGBU2aJJ9bYanEouVLFoYCxFoPMtZNgybBff
         8EcUs9E0vjcPZfrYEbrqLyMioiJwsV3C7dR8VPdldQ+PbnnMD8K9o3x1mPupswhKlKuI
         GCSg==
X-Gm-Message-State: AOJu0YxBGsQ34cJ20LZrXLwc5r9k7yic9erssR3QeMTs+nKtk8++vpr3
	3HqtKTQhmDCS5f3UgYAbs1Nx/bGWQTYeUimxu+ekDSny/bLCOG6yGNw3MDPJ3NPnonslfcAUEIY
	OXIUoLiDTtL0pDAWpgnDOKtvZJ8s8DtzspqJDP7RhlZKoZ99Zsu0zUVGS8A==
X-Google-Smtp-Source: AGHT+IGLtjQxzEhtLYkO2w3NuHIjOE/n9MmWfIatNyGgnKGBkZaQ80l4AORlDUJIDUlZoOOL6NQuNyXcCbq9U88jL1CGmemauDPG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c7:b0:7cc:342:72f9 with SMTP id
 l7-20020a05660227c700b007cc034272f9mr273014ios.2.1712655679762; Tue, 09 Apr
 2024 02:41:19 -0700 (PDT)
Date: Tue, 09 Apr 2024 02:41:19 -0700
In-Reply-To: <000000000000c30be606158f33db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a41440615a6b909@google.com>
Subject: Re: [syzbot] Re: [PATCH net-next] net: team: fix incorrect maxattr
From: syzbot <syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH net-next] net: team: fix incorrect maxattr
Author: liuhangbin@gmail.com

On Tue, Apr 09, 2024 at 05:28:12PM +0800, Hangbin Liu wrote:
> The maxattr should be the latest attr value, i.e. array size - 1,
> not total array size.
> 
> Reported-by: syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com
> Fixes: 948dbafc15da ("net: team: use policy generated by YAML spec")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/team/team_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 4e3c8d404957..8c7dbaf7c22e 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -2808,7 +2808,7 @@ static const struct genl_multicast_group team_nl_mcgrps[] = {
>  static struct genl_family team_nl_family __ro_after_init = {
>  	.name		= TEAM_GENL_NAME,
>  	.version	= TEAM_GENL_VERSION,
> -	.maxattr	= ARRAY_SIZE(team_nl_policy),
> +	.maxattr	= ARRAY_SIZE(team_nl_policy) - 1,
>  	.policy = team_nl_policy,
>  	.netnsok	= true,
>  	.module		= THIS_MODULE,
> -- 
> 2.43.0
> 

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main

