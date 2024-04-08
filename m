Return-Path: <linux-kernel+bounces-135482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC089C656
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369A0286ECB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E18172F;
	Mon,  8 Apr 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaNLfay3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE97C097;
	Mon,  8 Apr 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585213; cv=none; b=h6KNDGZQmEKe1yoG8spWFHC588hAuKwXe7TvO3avAKz74ZOholJDYXXMQ9L2kbXptF/6tprBpkpd18HrziPeOahTwGt+08h/W8ZzugESkClJLm75gE7DUxDoO/m9ciOXpVoYzUdBklmtJMcGdHl3UfMGTlhoqMXpZa1jRdLEvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585213; c=relaxed/simple;
	bh=kJRZax7tKQw/4aGj608DFmiz3SzBrQfRW1Czn6YXsFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBsmf+TBO+8jNKV09d1R7g17Zt6jTcgQ5w3h+pTCH/umds2m+CBGJ8DlRxEiWO+rVt0Hhe60rWVxmTaLNlKcJHmq+4T89E8DoYszCaalFIeIqJnBTLUqUJqojBHY0zHA2VydY265YzUp/u0Zp1Qu6zWOWwIQueL58IoaYEzdr6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaNLfay3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94005C433C7;
	Mon,  8 Apr 2024 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712585213;
	bh=kJRZax7tKQw/4aGj608DFmiz3SzBrQfRW1Czn6YXsFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iaNLfay3XcHLZIpaCy2Tg5KiN9C3T5cq/wYk6+Alx80Fm/p5jZv6aRCZll9Kz4KXQ
	 +1umEhFvpMDhygvSnwrGi9eHUz3JhVFewNicg4vs5ZfvNqvF70YPp7weJcsIgssSmU
	 1YUW1VYVR5YeCyV4p8KHNZbAEMkhNg/xbY0fdSjGw+M6v/mJ0ABsmTPOSECekQV46t
	 ofuMtPwfaSrvSagJ8G332KuTNnPDZGMzGoBzALD12Tzt68P4lMSy5Io6zjToMmO75z
	 g1OjDlOYV4RmVRBsFu0PyHTitXZMoV5SnnXcqHi41q87Dqn0TDHtavTSJk/lHAYnyZ
	 jLydp/j7C2+ZA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5aa327a5514so62092eaf.0;
        Mon, 08 Apr 2024 07:06:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWS6Hq0met6ef5CV5XhojOX/n6pkk2S+IKXYRRPnVt7XEvdYf8bfLX6WExx+8NI41IJHk9yPZPXkHC2lyZ7/YfuumatxNQaChNMQ133mzMRcb7ooUutzWOnyI12L+Z1agDMhfABzad1CGdj7g==
X-Gm-Message-State: AOJu0Yww8oFUE3aJSdxFWqcENr4QxTTKpWCyUMgSFJsuIuUE7gb5jIs5
	kNasAJciUTU9LGlkGSZE3lauxAQiX7cdYCS55W33laMnebaPh4LCew85eCqLzPXm+Jo2ltkFvlu
	u//hgfFffO5QbYbzX5oeMsbANrCc=
X-Google-Smtp-Source: AGHT+IEbfthzZ79XuDvyUQLEJLfFsf+aggAbvd3kcXbcCcp/nApsYYrvB2ACXv1jcTNPI8mdNwRCkjBg8LGXi0Cz1m8=
X-Received: by 2002:a05:6870:1651:b0:220:bd4d:674d with SMTP id
 c17-20020a056870165100b00220bd4d674dmr9057467oae.5.1712585212959; Mon, 08 Apr
 2024 07:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403154907.1420245-1-lukasz.luba@arm.com>
In-Reply-To: <20240403154907.1420245-1-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:06:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jP8j3kcUFHx45_qpeOTa9THtP3qztC0oxuiohcYs5PPQ@mail.gmail.com>
Message-ID: <CAJZ5v0jP8j3kcUFHx45_qpeOTa9THtP3qztC0oxuiohcYs5PPQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Update Energy Model after chip binning adjusted voltages
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, 
	sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org, 
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	m.szyprowski@samsung.com, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:49=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> Hi all,
>
> This is a follow-up patch aiming to add EM modification due to chip binni=
ng.
> The first RFC and the discussion can be found here [1].
>
> It uses Exynos chip driver code as a 1st user. The EM framework has been
> extended to handle this use case easily, when the voltage has been change=
d
> after setup. On my Odroid-xu4 in some OPPs I can observe ~20% power diffe=
rence.
> According to that data in driver tables it could be up to ~29%.
>
> This chip binning is applicable to a lot of SoCs, so the EM framework sho=
uld
> make it easy to update. It uses the existing OPP and DT information to
> re-calculate the new power values.
>
> It has dependency on Exynos SoC driver tree.
>
> Changes:
> v5:
> - adjusted aligning of the function arguments in patch 1/4 (Dietmar)
> - adjusted the in-code comment patch 4/4 (Dietmar)
> - added Reviewed-by to all patches (Dietmar)
> v4:
> - added asterisk in the comment section (test robot)
> - change the patch 2/4 header name and use 'Refactor'
> v3:
> - updated header description patch 2/4 (Dietmar)
> - removed 2 sentences from comment and adjusted in patch 3/4 (Dietmar)
> - patch 4/4 re-phrased code comment (Dietmar)
> - collected tags (Krzysztof, Viresh)
> v2:
> - removed 'ret' from error message which wasn't initialized (Christian)
> v1:
> - exported the OPP calculation function from the OPP/OF so it can be
>   used from EM fwk (Viresh)
> - refactored EM updating function to re-use common code
> - added new EM function which can be used by chip device drivers which
>   modify the voltage in OPPs
> RFC is at [1]
>
> Regards,
> Lukasz Luba
>
> [1] https://lore.kernel.org/lkml/20231220110339.1065505-1-lukasz.luba@arm=
com/
>
> Lukasz Luba (4):
>   OPP: OF: Export dev_opp_pm_calc_power() for usage from EM
>   PM: EM: Refactor em_adjust_new_capacity()
>   PM: EM: Add em_dev_update_chip_binning()
>   soc: samsung: exynos-asv: Update Energy Model after adjusting voltage
>
>  drivers/opp/of.c                 |  17 +++--
>  drivers/soc/samsung/exynos-asv.c |  10 ++-
>  include/linux/energy_model.h     |   5 ++
>  include/linux/pm_opp.h           |   8 +++
>  kernel/power/energy_model.c      | 106 +++++++++++++++++++++++++------
>  5 files changed, 121 insertions(+), 25 deletions(-)
>
> --

All patches in the series applied as 6.10 material, thanks!

