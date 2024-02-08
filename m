Return-Path: <linux-kernel+bounces-57497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79684D9D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C363BB215FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7DA67E61;
	Thu,  8 Feb 2024 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+XQ4ddG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8D1B7E4;
	Thu,  8 Feb 2024 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372811; cv=none; b=qgcjipoW2u5D8oWIIW4wrB1VOyZWLBr7qzPj2Q7iGqyFW5SyDTUxJCmrNCSp90O8n/7YMfEV3Vakqk4G5ziPWVbkRb8ZqoVZEopkArFGYc5sJv9a5Y0D/nCLrNF5izLrDmebKgdwX5N8OpHKMZjCyGjVjr+KdqezJBvkRzaoYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372811; c=relaxed/simple;
	bh=nsCkbUSpn4ND+bMVOeVBw6ofU7yKaK/RS9W+GLDO+A0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=S3QCLYMPFHEskLB7iL81CFAW2fI/o00wK8hh5IxDb5M17qL2Xy6X/DOX9Ek8YwtVVch3V3g9nP9kZT+n285We0ZC6Xk19vDz+FZcPz8iMrnDATwKsJ/riSL6C4G1gnkuSvi2JqesKIxs1jGWRFNfOS1Vbr7+vhCVP9zxu++B32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+XQ4ddG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB152C433C7;
	Thu,  8 Feb 2024 06:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707372810;
	bh=nsCkbUSpn4ND+bMVOeVBw6ofU7yKaK/RS9W+GLDO+A0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=p+XQ4ddGNkKzd/pkWukSVBmefz9cJUMcZHu94mL8HEGBafi6UHdqxTAKPzJMkKyfV
	 lIwBHrVTH+HB+3cWxE8ppy0jFMDvmW2gC2wCB7r5iTTCDMmRZoF107Mbv6L2WoxHVg
	 poYeWZcuvSGCvWQcODOtduX2TqME7Zp1kOyevLRRXWJ18f70kVFrPMYPKrfz7ivROQ
	 yCGsDW9KusRqQLMhzD8fFEm2oeRXwCEz9vqtve3x6KxkmrRPf9CKjV0toT89vLAAf7
	 E7V/mRtAhMloK5YX7b3uDnWDtOW0uqDWYr3zIC+sT9bdmu6as17z7KrkFtVPGrv/to
	 pAH2gZZ/mcaiQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,  Gregory Greenman
 <gregory.greenman@intel.com>,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,  Johannes Berg
 <johannes.berg@intel.com>,  linux-wireless@vger.kernel.org,  LKML
 <linux-kernel@vger.kernel.org>,  Daniel Lezcano
 <daniel.lezcano@linaro.org>,  Stanislaw Gruszka
 <stanislaw.gruszka@linux.intel.com>
Subject: Re: [PATCH v1 0/3] iwlwifi: mvm: Thermal management fixes
References: <1892445.tdWV9SEqCh@kreacher>
Date: Thu, 08 Feb 2024 08:13:26 +0200
In-Reply-To: <1892445.tdWV9SEqCh@kreacher> (Rafael J. Wysocki's message of
	"Wed, 07 Feb 2024 20:08:18 +0100")
Message-ID: <875xyzh4ah.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> There are a few thermal management shortcomings in the iwlwifi driver that are
> addressed by this series.
>
> First off, the fw_trips_index[] array field in struct iwl_mvm_thermal_device
> is only populated and never read, and the code populating it has problems,
> so patch [1/3] removes it.
>
> Second, iwl_mvm_thermal_zone_register() populates the trip table after passing
> it to thermal_zone_device_register_with_trips() which is too late, because it
> can get used before it is populated.  It also may as well use THERMAL_TEMP_INVALID
> as the "invalid temperature" value.  Both these issues are addressed by patch [2/3].
>
> Finally, iwl_mvm_send_temp_report_ths_cmd() accesses the trip tables used during
> thermal zone registration directly in order to obtain the current trip point
> temperature values, which is not guaranteed to work in the future, because the
> core will store the trips information in its own copy of the trip table - see
> this patch series:
>
> https://lore.kernel.org/linux-pm/2728491.mvXUDI8C0e@kreacher/
>
> If possible, I'd like to route the $subject series through the thermal tree,
> it is requisite for the above one.

iwlwifi is getting a lot of patches lately, though I don't know if any
of them touch the thermal stuff. But if this patchset goes to the
thermal I am a bit worried about conflicts.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

