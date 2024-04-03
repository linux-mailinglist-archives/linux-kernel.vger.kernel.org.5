Return-Path: <linux-kernel+bounces-129888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC6E8971AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05251C25FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF092148FE2;
	Wed,  3 Apr 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOic17JM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E024A146D65;
	Wed,  3 Apr 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152426; cv=none; b=lTs7uHKoo1pmC729uG5w8JTwv+KSNcZw4s1gpCQ3nE4uUF9T2cBnQoeetUWtSIa4uT2DLzJfksSEPEvogcHScZZyU/aOBADNNpZicPxWsBjyuUjRhChDHXeIrt3fPS5S8fvoFaLwbuw6XHWaARg2m4teOAkIeRGu8nuc9rYyoNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152426; c=relaxed/simple;
	bh=m0lorB2MbPpc2sRbPkYyOS6AnvFCBRgPrepaAMOzzv0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oYzWv8jVZtcGrsk49SimKRqwzOBoOun6TKmnduua/18m02j6YF0vaZ6+FI23KJbUUmkw2i5kAvxfx9sVk05Ha7HUFqEWTA0JaTjVRo7Zf5b8desBoDvl13dej31VIQOVuBcG2EEh9AgeTv2swbuCksywFGKmTdX1An0hyF34oW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOic17JM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C15C433F1;
	Wed,  3 Apr 2024 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712152425;
	bh=m0lorB2MbPpc2sRbPkYyOS6AnvFCBRgPrepaAMOzzv0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YOic17JM08kzLf6HccVjw0tiON+A4lbyi59R2hAAwcWksGE4hL4QskZ99Ec4ieQLy
	 mQ+6OAGCtxnVIXaOBXRMjXkrFLFoJoy0BrmmDWc41/Z2tLnKK0nUKvRqUvLacufSmW
	 vXgnmo1FsVfofAq7Zfl5lRm0yxpoPs2kb/WGpMI8VUTznZsVpIX48OOtr3aWlW1t9j
	 3qIQUzwDyJUFRzhLJuBniJFjnSxtMGNxasSB5803FWt+k1J/4tGFtaXTdNpHZl9dKB
	 wjN2QHlTeDnJVocdcLi2LXzgfrx2ePZRajTehI4211rdxcvbC3pfc6FraLlELkOA3g
	 11XkAwGd8DwYg==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,  Marcel Holtmann
 <marcel@holtmann.org>,  Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
  Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Jeff Johnson
 <jjohnson@kernel.org>,  Arend van Spriel <arend.vanspriel@broadcom.com>,
  Brian Norris <briannorris@chromium.org>,  =?utf-8?B?SsOpcsO0bWU=?=
 Pouiller
 <jerome.pouiller@silabs.com>,  linux-mmc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-bluetooth@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  brcm80211@lists.linux.dev,
  brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 6/7] wifi: marvell: mwifiex: drop driver owner
 initialization
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
	<20240329-module-owner-sdio-v1-6-e4010b11ccaa@linaro.org>
Date: Wed, 03 Apr 2024 16:53:39 +0300
In-Reply-To: <20240329-module-owner-sdio-v1-6-e4010b11ccaa@linaro.org>
	(Krzysztof Kozlowski's message of "Fri, 29 Mar 2024 18:24:36 +0100")
Message-ID: <87frw25z8c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Core in sdio_register_driver() already sets the .owner, so driver does
> not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The preferred title format is:

wifi: mwifiex: drop driver owner initialization

But that's just cosmetics. Feel free to take this via sdio tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

