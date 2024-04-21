Return-Path: <linux-kernel+bounces-152461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A0B8ABED0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125DD28111E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE810DDDA;
	Sun, 21 Apr 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ELKYdL7k"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277D33D5;
	Sun, 21 Apr 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713689373; cv=none; b=GNJSM7XXIgMajyaBvZzFMfDTOpfbIyKovNifRClj0kkuG9Ur97FyE1dV/PsBZdQvsLON6l61R+UfRI5RFCqQIi/6MLVdXRDBjscXiQe0arpswC8u6Sa8aHW+G64VukFTlKWv7/famBRDY9uuQLzXjjRg6+ohZUQlFNWCIGhh1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713689373; c=relaxed/simple;
	bh=IzOFxcvABLw7okAaODhaFqzHvAqBYKY/wpPe2vbfCpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drvzZMcbs8rjiVO7jPhHtywHCCsn3kIHji29Q4d4IuGE7mQght45DN4DgN+BxfyAmx6VotBKVGpjlh6QZ/cek48KyUn/6dGenU4fQVbj7Xkgvxs98x/mc7G7DTI6XbLOsLe9wb9Gxl3jT03FmbDeGErkGNP2hufe6BWYqgfahGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ELKYdL7k; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 093881F92F;
	Sun, 21 Apr 2024 10:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713689360;
	bh=BpFulAQbCdhJzSEsRhzIqEy0hJxoSMYEZcUkUy44sng=; h=From:To:Subject;
	b=ELKYdL7kDycfV2btm/G2tfgdGzxdq3yTKBM8fryRcLmWRvSfpJwGJi7cqLzWWpRxg
	 zekP2xABKZOouiZfCYNFXkQmednQ3hsIS8gpEfbAh86/gdoqvc5J7DoVW5e+zHnXVJ
	 fFYE4eDcUt9TKn5e5ZYoSdSekf3tkYS57mv8dtMHFG7kCegH98IEfDMbl9x86b/eHy
	 +YqXh+5cdPCudL9ZSXRSVla7J0qK58ZbXNW34APtWPF9WJVAD8YApOXNGNLKiZBpoe
	 Cv/08ugo+vxITYpi+Dj5KIwCRBuyDRNKIQcL1FxKzmxRe4zUfjPj7okaNWdOAp3rY2
	 4zfmL9CLbA1+Q==
Date: Sun, 21 Apr 2024 10:49:16 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Tero Kristo <t-kristo@ti.com>,
	"Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [RFC][PATCH] watchdog: rti-wdt: Provide set_timeout handler to
 make existing userspace happy
Message-ID: <20240421084916.GA4208@francesco-nb>
References: <4d82b8ce-bc34-e4b2-c5fe-9e883b0db59d@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d82b8ce-bc34-e4b2-c5fe-9e883b0db59d@siemens.com>

Hello Jan,

On Mon, Sep 13, 2021 at 01:41:43PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Prominent userspace - systemd - cannot handle watchdogs without
> WDIOF_SETTIMEOUT, even if it was configured to the same time as the
> driver selected or was used by firmware to start the watchdog. To avoid
> failing in this case, implement a handler that only fails if a deviating
> set_timeout is requested.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Are you aware of this patch https://lore.kernel.org/all/20240417205700.3947408-1-jm@ti.com/ ?

Francesco


