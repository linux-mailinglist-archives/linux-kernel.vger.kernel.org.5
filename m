Return-Path: <linux-kernel+bounces-165127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE278B8862
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6011C2164E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B7524DD;
	Wed,  1 May 2024 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLCdG4P2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426950271
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558405; cv=none; b=a9pJnwYNvhzg8S5zDovbt7AR4Wf7tx0gaAowfHHuBJS4f877Yf84jzup6m7iAdyYZnXIJ/jPYk5/Y+U/iWr5K6F/BZFMXh2++40Ji4UswgdqBa2tSucB6rq9kJwPJbi30/ni/bPrQffqiBfOSTPn1olaM5LmOdKYwU2jVHqMLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558405; c=relaxed/simple;
	bh=LSaEPxVGB4VRFhN0LqOEtyEy/jFC7WAzADq60HPYFqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtTwsjdCsAKZxpwiQraaldthmWFSgoegkmRTIG8v/G6Q/7mP6X2adaQG0UVrQJOBCWsY2PphwnjY4g+UtdqH5wrEebqgRaNFXkmadWmGjZBnK5YXS9ar+uHT8ov0aGhdV5BQShJ3jjL8o4QUYPsnOrckbAiEhozeD20IX/mM7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLCdG4P2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97032C113CC;
	Wed,  1 May 2024 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714558405;
	bh=LSaEPxVGB4VRFhN0LqOEtyEy/jFC7WAzADq60HPYFqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLCdG4P204MY9r14VG7N5UbVi/010J52zgG0eVbq8OBvnw2QSXKJFq+2pIRVbnsCf
	 8BclO0KEVIZaP/JrN5xvnXYv8wuuKvHNwiw/Pf54JKxY9mzlEHzIavWH5IK576xSEq
	 I55U87uWnYmwTH2GBOQG1QE/Z1FrKMnqGsZfB73vPVyahsi2vFi3WHalm5TdXjvXAq
	 cQwgNg9ZvW4RxVu9Iun4hEVEfByWroq6aOSv1ORqbxxk9Kv+bTBS58D/m/QkCErbnm
	 hlCPTUphjh2563hYpo8PHwk+H9KRxG5oOoruIlFcd/9Ko7+DCsB9eIFekgefNhr0E1
	 uQn5aSkt+43vA==
Date: Wed, 1 May 2024 11:13:20 +0100
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] nvme-fabrics: short-circuit connect retries
Message-ID: <ZjIVwOazsC-miBK-@kbusch-mbp.dhcp.thefacebook.com>
References: <20240430131928.29766-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430131928.29766-1-dwagner@suse.de>

On Tue, Apr 30, 2024 at 03:19:23PM +0200, Daniel Wagner wrote:
> I've splitted the last patch into the hopefully non controversial part 'do not
> retry when DNR is set' and the 'don't retry auth failures'. I hope we can get at
> least the first few patches in and have a lively discussion on the final patch
> at LSF.

I've dropped the previous series from the nvme-6.9 branch. This series
has been added to the newly created nvme-6.10 branch.

