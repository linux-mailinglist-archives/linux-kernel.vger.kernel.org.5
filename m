Return-Path: <linux-kernel+bounces-50169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7762384753A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E786DB27173
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E151487EB;
	Fri,  2 Feb 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF8+cc/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD991148314;
	Fri,  2 Feb 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892348; cv=none; b=i66mOe4rKoLOJYpbVhurdAcUnmV/F0aEtUrk4WBEsc5EuiIjFPLzd4kzZ92E3llA4hvqJkf5uWzyhviLa24hyGWbHP2Y4xYoGOTs5HFkx55IOknGCJ7zJ/VC7OT7OKzukjrdvrqsC+2lU5pq6/Fw+sxZgSZEAoUrGpj+QHfX9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892348; c=relaxed/simple;
	bh=gCXtpaaFuGj/Sfv2J/qgI4C+ehnvqwEiWJQgGM4NB5E=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Bhst7Re+cg5dwwwf/6ElmOeXdPp0gfzQbMYTawcl1gZa8gsHZDRx4DlSPk0U3FYrnYNkWDkauzDqBx/RuOLwVTjEQdUusl3hsdyD1S5m/SAPD1CWctYEA4pSk0BrxRRokEU3q4MCgjvDnR9RccMQEX9Mfuf5IvJfNLHjcoQEqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF8+cc/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691F3C433F1;
	Fri,  2 Feb 2024 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892348;
	bh=gCXtpaaFuGj/Sfv2J/qgI4C+ehnvqwEiWJQgGM4NB5E=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=lF8+cc/3GjCeNb/K2Y2/jTpo6vZYOAxO4wsHdUXD731NoAlK5/WtgIHIDumR6KnTf
	 CmJwcmBUkmP6BwcfHG8RxV2C0kzpVwirz4iTukokWbuasbdPt51Er5Q1gZ4w82E/7D
	 5iYiZwhCoh9iwgWLzOhW5ki5siBeQzxVvX7dxev+zvOXdpGnrLPAVvye2FmeuWEm3Q
	 9VzxEn+u561Z8heuvD0IwmWe2mi+r0FKED1GxpXx6BRRtasDbC8e7AGizIVvPEra8y
	 rk0D98GTJm6RD0K1FFjPFzJPLFFAbNwOSlGeSZBJ1hQt0XmC0sLgyFnx5BOzbIccio
	 i67hwtIH6pSAg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: Adjust n_channels usage for __counted_by
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240126223150.work.548-kees@kernel.org>
References: <20240126223150.work.548-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Arend van Spriel <aspriel@gmail.com>, Kees Cook <keescook@chromium.org>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Chi-hsien Lin <chi-hsien.lin@infineon.com>, Ian Lin <ian.lin@infineon.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Wright Feng <wright.feng@cypress.com>, Hector Martin <marcan@marcan.st>,
 linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Jisoo Jang <jisoo.jang@yonsei.ac.kr>, Hans de Goede <hdegoede@redhat.com>,
 Aloka Dixit <quic_alokad@quicinc.com>, John Keeping <john@keeping.me.uk>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170689233342.3493863.10294472294618285046.kvalo@kernel.org>
Date: Fri,  2 Feb 2024 16:45:37 +0000 (UTC)

Kees Cook <keescook@chromium.org> wrote:

> After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
> cfg80211_scan_request with __counted_by"), the compiler may enforce
> dynamic array indexing of req->channels to stay below n_channels. As a
> result, n_channels needs to be increased _before_ accessing the newly
> added array index. Increment it first, then use "i" for the prior index.
> Solves this warning in the coming GCC that has __counted_by support:
> 
> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_internal_escan_add_info':
> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3783:46: warning: operation on 'req->
> n_channels' may be undefined [-Wsequence-point]
>  3783 |                 req->channels[req->n_channels++] = chan;
>       |                               ~~~~~~~~~~~~~~~^~
> 
> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Cc: Ian Lin <ian.lin@infineon.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Wright Feng <wright.feng@cypress.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless.git, thanks.

5bdda0048c8d wifi: brcmfmac: Adjust n_channels usage for __counted_by

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240126223150.work.548-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


