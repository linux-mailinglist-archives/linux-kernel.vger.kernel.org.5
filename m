Return-Path: <linux-kernel+bounces-134755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7086C89B66A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A706281EFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FF079D8;
	Mon,  8 Apr 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4AuUaYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A37462;
	Mon,  8 Apr 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547031; cv=none; b=E1wV98uorEI2SMKDOA4/dDm4KZAiJhelRWXzSe55eey5hM/Myk0TXQtJaYD0NcHqzs6ar+TpAwl7AVqEzDSP3KGNPWv09o7IvcnN9H/XLf/ntkyust2gmZSbmyvSEvpZ/Djo/VYa2vgpcLOosjSU1Xr8ULZACv667rM8v62tyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547031; c=relaxed/simple;
	bh=1z7RxyFB+uJNVAsDVYm/gfzQrLSD3coa/jjMx+qmw3s=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=oORPW/LtHz4BIdQqsbQq/QhWinmKKGKY3FxcLOHisVZXw7oT1L6qXmAcntjMEr93zMxOcZPgYyRzz7GvsoigmI4V8+fpKZPlxxQy8XUW0LROWB/E2rXHbileCZp4RPu+pIPJugdncvBGzDGr31d2bXc28KeUmKFkqh36MNSAD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4AuUaYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0931DC433F1;
	Mon,  8 Apr 2024 03:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712547031;
	bh=1z7RxyFB+uJNVAsDVYm/gfzQrLSD3coa/jjMx+qmw3s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=t4AuUaYDz29c5TeUHRPr8a3xGe3S0s3eijZg1QJCC5BkLKdRh1+7DJ8Gptsu/W2dA
	 pr93GZt2TwjD/pJ6z72MOB4CpTZBrmUv2MtWtYjl6QHUTYcw71kv5kWVQiMRQjFFVF
	 lLZZ3y8UP9boMYaF7qCovQwtWxs3n6/1fZ7SXFDtmuAsm3wZ0euUZH98FoW1Y4BKSo
	 8Uf6R+P8PBMBry1kcwAAqL+1Sn3k26aTkPUruJG34OpSr7T1sW5uODWOzXZgsw0E0T
	 Ar6wUuf55mGCl3BD7XduIg3SV5ar38sDzgrw16QFaskjbB9sJbW8/JEJxnekdqb2Lq
	 9UAnJGw2tEHtg==
Message-ID: <02b7818fff2dd5f0cf923e500fd5b569.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <82a0768e-95b0-4091-bdd1-14c3e893726b@web.de>
References: <82a0768e-95b0-4091-bdd1-14c3e893726b@web.de>
Subject: Re: [PATCH] spmi: pmic-arb: Replace three IS_ERR() calls by null pointer checks in spmi_pmic_arb_probe()
From: Stephen Boyd <sboyd@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Andersson <andersson@kernel.org>, David Collins <quic_collinsd@quicinc.com>, Fei Shao <fshao@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Markus Elfring <Markus.Elfring@web.de>, Peng Wu <wupeng58@huawei.com>, Vinod Koul <vkoul@kernel.org>, kernel-janitors@vger.kernel.org
Date: Sun, 07 Apr 2024 20:30:28 -0700
User-Agent: alot/0.10

Quoting Markus Elfring (2024-02-04 01:24:18)
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 4 Feb 2024 09:39:48 +0100
>=20
> The devm_ioremap() function does not return error pointers.
> It returns NULL on error.
> This issue was detected once more also by using the Coccinelle software.
>=20
> Update three checks (and corresponding error codes) for failed
> function calls accordingly.
>=20
> Fixes: ffdfbafdc4f4 ("spmi: Use devm_spmi_controller_alloc()")
> Fixes: 231601cd22bd ("spmi: pmic-arb: Add support for PMIC v7")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Applied to spmi-next

