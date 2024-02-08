Return-Path: <linux-kernel+bounces-58146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C384E1E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3630A1C264C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D965763F4;
	Thu,  8 Feb 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neFVrZg9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79F7318C;
	Thu,  8 Feb 2024 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398516; cv=none; b=u934KfSUtAbSHsn2CM6Ltkv+6xm9i94OK2axf3gU4l+tBCH4hoedKhp/fJavd/4Sw5IMLxRZ0JRASR9swdGlCTpBzoFuYUYSvNOfjIKXGnVPYXl2vBJK8TDaqEilazrxiUyCJoWPyqpTs7P5KWfRm5V4qEaISH60hi0v5Sq2EKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398516; c=relaxed/simple;
	bh=6joLgvz/KohYxK/tbb4JeyRbAeCPrzt4MP0PieU0wtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axNe2DW/S+EcsFtjlZadivlaW8qU/evw3emO6vjWF4hdaybpGlmHwCfmyD0JVNwFf0IYIbsA+OR+7RnFlPIA+wQilR95YtV2xH23BAsRC6+bU1zquUIy8bHfjgE+QHaFC83nXUEtjHvUWIV5lHwH/fFQOAOWKwMMryXbGeyikNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neFVrZg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DC7C433C7;
	Thu,  8 Feb 2024 13:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707398516;
	bh=6joLgvz/KohYxK/tbb4JeyRbAeCPrzt4MP0PieU0wtk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=neFVrZg9R4VfYFU9T5o9TAIaWGbTQ7HOVF9FJEPMoSn1Pp5jLFblSJ4U9ccYDVS+C
	 b8jJ3sEdihK/EqeUbcdlhoDQCOA6EeFuVG/vAqMvyPqUXfzdjl0xs0mvSjUSWeed7k
	 sRHL4RtzDGdpVFjQP70gtjl/9o2JNGJIRW0HpeZeimrqyscoINU/GOqjh4GItSbyGp
	 FJhGdU6o0WLuIjyjJtGMR1H0Djpxv2wae4mWPwc4O3wAiZMBUtwVA2ds2w1k/Hgn+p
	 /EadtWlHnhyMbQ8uEhVq7nixKAQNFJJI69j7/lhB5nFAIEeiMAA67seRs9I9xAwKuL
	 p+7uD/J/h8qhA==
Message-ID: <30aec2dc-973b-4977-ac5e-eb418854c93b@kernel.org>
Date: Thu, 8 Feb 2024 14:21:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/rtla: Replace setting prio with nice for
 SCHED_OTHER
To: limingming3 <limingming890315@gmail.com>, rostedt@goodmis.org,
 colin.i.king@gmail.com, corbet@lwn.net
Cc: juri.lelli@redhat.com, williams@redhat.com, bagasdotme@gmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 limingming3@lixiang.com
References: <20240207065142.1753909-1-limingming3@lixiang.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240207065142.1753909-1-limingming3@lixiang.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/24 07:51, limingming3 wrote:
> Since the sched_priority for SCHED_OTHER is always 0, it makes no
> sence to set it.
> Setting nice for SCHED_OTHER seems more meaningful.

Thanks!

This is actually a fix, I meant to set nice since the beginning.

-- Daniel

