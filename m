Return-Path: <linux-kernel+bounces-143334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5E48A3756
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFA8282E87
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154C1514E6;
	Fri, 12 Apr 2024 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkTxfwgZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941117C7F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955217; cv=none; b=fitqVvzRYcyfS8BatATNr6il+HDM9nxLSiWsMj1+o+vr/lexBvxT/Qz4FmOWvxcTbYkyUxDXk56ygg59FKN/21bo1LVwca0etff2fKhmLza1opzjoGZVt0A2HjiUbyA4X0d81rHPUm/ecZ66AU+6Away4ZI4Anzvh0A5Rid4y7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955217; c=relaxed/simple;
	bh=7KHEBo/ktcL0Syd+126vMQEFQkCpI3GKOWAVYMxiir4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiRXFhslNsXXoAyFOlEEd7N/r08wh74nm8dLjPIrWngxgqd/Oalxd2cruW53DQm6MqrS674AeMj2UzKC9w1yNmkykcDdifKmyqT9eaxWBDVJLZq99UlUVG0au2Cl4pPR8DQqa/78QBpn3TxLfKmT3ltzCdLzYKlw1UAWAgevn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkTxfwgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82740C2BD11;
	Fri, 12 Apr 2024 20:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712955216;
	bh=7KHEBo/ktcL0Syd+126vMQEFQkCpI3GKOWAVYMxiir4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkTxfwgZyKHYF+A9q7/OS7701yzGJ8mRojg/TabzLaBZDF/95o/+nZxc5hTBA5fi5
	 iDZOIat1qZf8x03nI0ybDg0R+AVU9jOMvz/P5zmUBFN+MDFL4p9yIi0Lp1yhGKdav/
	 HmbIYsT8Kd0XmMOfEA0Q/uR+ZH7jeMV0jHG97J2MAccTqlCOvXPLacIkObBwDkqwhT
	 xxOvSNRxlKNT8P1eJOiS7vxGKB/5ZoY1S16aqoX2pI1xmJmJlWKR0wbE7EyBBVpiow
	 qm8lT5QIGSSoPI6IJc1RW+hYyKHd8dQzD2LBt8YmWKcGs/gHmgEYn9u+il+czzF8TW
	 NfpE03UvkKYyw==
Date: Fri, 12 Apr 2024 20:53:34 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Chao Yu <chao@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
	hongyu.jin@unisoc.com
Subject: Re: [PATCH V3] f2fs: add REQ_TIME time update for some user behaviors
Message-ID: <ZhmfTousYopIc0HC@google.com>
References: <1710915736-31823-1-git-send-email-zhiguo.niu@unisoc.com>
 <ee24b313-a168-471e-b60f-1404c69e61a7@kernel.org>
 <CAHJ8P3KaQF8okMOyagH80+BmUUZ=ENSoAApz2H-p_1=Pu5ZTbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHJ8P3KaQF8okMOyagH80+BmUUZ=ENSoAApz2H-p_1=Pu5ZTbw@mail.gmail.com>

On 04/10, Zhiguo Niu wrote:
> Hi Jaegeuk
> Any comments about this patch?

Thank you for heads up. Applied.

> thanks!
> 
> On Wed, Mar 20, 2024 at 5:33 PM Chao Yu <chao@kernel.org> wrote:
> >
> > On 2024/3/20 14:22, Zhiguo Niu wrote:
> > > some user behaviors requested filesystem operations, which
> > > will cause filesystem not idle.
> > > Meanwhile adjust some f2fs_update_time(REQ_TIME) positions.
> > >
> > > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >
> > Reviewed-by: Chao Yu <chao@kernel.org>
> >
> > Thanks,

