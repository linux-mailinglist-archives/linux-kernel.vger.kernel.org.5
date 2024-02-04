Return-Path: <linux-kernel+bounces-51557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C488C848C75
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FC4B228EE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060618C05;
	Sun,  4 Feb 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOMqV9/K"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CAF18AF9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707038883; cv=none; b=e/pYZXpo/XNsLUVgLJ/o8lka5SQPeidBCCYsjSg8JeWop59jnPCtbyCRasa3tT2mKUcvf6OlpV0tFR5Rdo3WTnMlCOAgJzpuJMsWgV7kKnCRohgoSgR9oCpzoNgj0UoZrlyVjyBRNSv/9QZwskvFtA9SEyUQrwqyeoa7olv5CbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707038883; c=relaxed/simple;
	bh=UuFaKeSRYDkGrMKG+Q0ICLTYQicuRK3ywZvev5g2U50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSfVi+tbmBSRiOzeHM5obkRGylQ+b+L5R5gWmPxVFp8RtvOvSNXd1a7FszMApQqxS+R5cIiyf68gt96UkHblsGUyfZqw2LHO+79I9Q2veuVvKEqzP6Tl51jjrfFjAtasYkIAe+XyqAvjKbmU1CXyTaf2edNi6Fqas+oqUBt7xCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOMqV9/K; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-603fdc46852so36307287b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 01:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707038881; x=1707643681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P5sjWNa2Zbf00IkE3XpgyHgd6FEK1NqFbKWHmhVWEP0=;
        b=AOMqV9/KnjoGzF0WNMejWggwkPdEEu0okhAvt99G2K30nN62rVipREgM+uCN/KH6jP
         J/XqdXd2g6WHETDHRzEXJqT+jXdO8ppyuVL9WesxzgjlafqJJk7NwZm7id2rlxyoj1dP
         Ses1PIGgB8nYRI1w/FM3AdgKRZg9FlyQWGGiCOb1uicleDVsGso309oAevUfAGjXLNXT
         q79+PmW8GutCEsFX3SjIcJdn6ZrRFOsTZKjXu+iWm8x9X7H6QvbWS+BCE5mDBZWCjYiY
         vDtZi58RFD3dZRtbdo6BlaRjH9yhS2HAjQfUARvsPTglSmHQzKPk2OqO6mga9LfZw7qD
         KJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707038881; x=1707643681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5sjWNa2Zbf00IkE3XpgyHgd6FEK1NqFbKWHmhVWEP0=;
        b=ScFnYfJpVVGjmbkVK4hqkmoq0MEVCuBcV3llETMGmZ91ysuMosiqWLooR3+iWlXJcx
         ANiz+pFuQvRr1S2u5INWx06sKLqTWfve8S0r7oAISYe0TOAim3hkjtJWrDUYW+qDmlhe
         jeXVdxLvI0FUupACwZKaCTy9eXPQIltFhzCOjAF1A5lrH3lbJOnjib4R35VF+kKlh4yZ
         k3XR7rukub/GynH54/Z/5OKjZJLDmWhJmvjfG722Y0/PHkAmMlNbijOb/iutLjBWu/kw
         ytsLuFdvYh9XjwSD8R4bTqy7DQdjpT9SSepsd8PZQdRG35UKcqkKSxiRSbaiRLN6OdsV
         5jdw==
X-Gm-Message-State: AOJu0YzHNh+gX+7A1jzbeGelYBGkHsJJvJMox7unh+rpH33ahGufwcT7
	ZZXBhujq/f09W3NJRoMzR1CMqlrR/VSTMfq2PfrEvsJ7lqnfUKGqJDfxDu+GFVVQw0btu6hAhTr
	s21/rwWq7CzKlFOF4OGoIgugxHN3uUQferPSvhA==
X-Google-Smtp-Source: AGHT+IGxeuAVCwWLRLJEi0G5Qg2/frr1rMxC4V7Vrc5AkNETrdVpT0PrBSYn6iO926ISWNBNkyqrg+bgXGDhBkb3aTU=
X-Received: by 2002:a25:8310:0:b0:dc6:db64:67a8 with SMTP id
 s16-20020a258310000000b00dc6db6467a8mr8149346ybk.43.1707038881088; Sun, 04
 Feb 2024 01:28:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82a0768e-95b0-4091-bdd1-14c3e893726b@web.de>
In-Reply-To: <82a0768e-95b0-4091-bdd1-14c3e893726b@web.de>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 4 Feb 2024 10:27:50 +0100
Message-ID: <CAA8EJpquHiz2r7+0ck6KFjpiQHNhgfH5D7n+MEYLKDhDXzBXGQ@mail.gmail.com>
Subject: Re: [PATCH] spmi: pmic-arb: Replace three IS_ERR() calls by null
 pointer checks in spmi_pmic_arb_probe()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Andersson <andersson@kernel.org>, David Collins <quic_collinsd@quicinc.com>, 
	Fei Shao <fshao@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Peng Wu <wupeng58@huawei.com>, Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 10:24, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 4 Feb 2024 09:39:48 +0100
>
> The devm_ioremap() function does not return error pointers.
> It returns NULL on error.
> This issue was detected once more also by using the Coccinelle software.
>
> Update three checks (and corresponding error codes) for failed
> function calls accordingly.
>
> Fixes: ffdfbafdc4f4 ("spmi: Use devm_spmi_controller_alloc()")
> Fixes: 231601cd22bd ("spmi: pmic-arb: Add support for PMIC v7")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>
> See also:
> Suggestion by Peng Wu
> [PATCH -next] spmi: pmic-arb: fix a NULL vs IS_ERR() check in spmi_pmic_arb_probe()
> https://lore.kernel.org/lkml/20221115090927.47143-1-wupeng58@huawei.com/
> https://lkml.org/lkml/2022/11/15/197
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

