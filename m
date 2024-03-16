Return-Path: <linux-kernel+bounces-105002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEECF87D77E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005531C21407
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375A5641;
	Sat, 16 Mar 2024 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WKxefe94"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88379360
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710547668; cv=none; b=VuvHnT7vwdy90HN32BI3V9Z5YW8ynitenx3Op4pKB8YJurID4ZkIi65DdDDBLMHxR2nMdjX/GmGMreNY8oV5XYc9OXFdRYljTAzpslqXB6CEVZ8jkypjWk1FFXIkf7fb1Q2UW192NNF5eY6onP3g5CmjfbBJArt2BqftLSYhqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710547668; c=relaxed/simple;
	bh=2VHOyHwiO3IqN1ZMy/5OKtjFBfVBCcGaEGJXKOazJMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VruO5rWX7Ms8Ot1j9TWowEoiP72zzoPd/OdqvQOtgT6+dAvReEfht2wzjVjrjVjr37F1FKlLTg0nyS+IRsGBk9IWNOdMSuXPiL0ZPaYH0AHwIZ0qr5LzFfo3yu4wHIGoABDmh+EyQzeh50LR1c8LOrw23bGvotCBGMziiSCv3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WKxefe94; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b22af648so2902741b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710547665; x=1711152465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2HVASpHp+GIKK8RtHmHX1zQq58DsTDGxV82bTx6n6U=;
        b=WKxefe94vt1804tD7yepQTT33KFHemfGBB9pL31onCFE+C8E1szJjENFWvW/1ezi2o
         PMKdLWgCURoAB/6/8qGeRf2ghRTyJ3azqzSz/5rHUgV4PysR/T58bXCdkUqcap3pWGhY
         +990jJcxdKvcexXweGgFHrCDwbgjKbwktZZjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710547665; x=1711152465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2HVASpHp+GIKK8RtHmHX1zQq58DsTDGxV82bTx6n6U=;
        b=HQbEecvUaXre8n3ZTESCP5gF6tv+OU1eS+JPr8jVvy7y5QExT5muywUCMw1ulSbit/
         WKHcq8x9iSXWjuTTNgju6xfD13hSjC54S9bF394rgy3bTX3OVdcz5VHSyCi0hKlpsyX/
         rzpK8ch+BEqeN8bQjnjzPx13ElV6Gj4VRAzKTQwmFKmS2aljb9V9zFNKE52C08ZmP3Ya
         cNe139WPz+mfrH77bjpKw85s+/RLrIZSDYeeDQhv79qhLo2WOounEE0JbpjIFGRdxufw
         6XLjwbRTi3y/m5dgbqbRitv68gkn4Ds+AOT8puurvHYnxT9A96Ivh9u/18T36GkOmaO2
         FmDw==
X-Forwarded-Encrypted: i=1; AJvYcCWFlOMrXVTkJKJ87+3C3cVEesCa1BQPUR1JIvvHoS1JkIlHF3yEIKKZlw6qate3rlhhvTucwl15qdE8s7fGrvnGfyGCI+3fOLuU5LSP
X-Gm-Message-State: AOJu0YyvG2+3Z7odhtwvi95yIOzYr8puTZt7rzFNWjmecy8bjJzNyeUe
	ySMMCUYUc00F4TROdKYPGpxciU3qQAl9cp8TFF0b9WzMM4e7Fc2BRjXH7KKWeA==
X-Google-Smtp-Source: AGHT+IE7Z210BXtfLpfT51MyCCNq9TCgiSY6ujqewEFWRsKRNEsbTJEhk1YcVLjYISgtCzMMBEDqdA==
X-Received: by 2002:a05:6a21:3396:b0:1a3:5402:d5bd with SMTP id yy22-20020a056a21339600b001a35402d5bdmr1724429pzb.1.1710547664806;
        Fri, 15 Mar 2024 17:07:44 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:39af:f807:ea8f:1b15])
        by smtp.gmail.com with UTF8SMTPSA id p19-20020a62ab13000000b006e6c0f8ce1bsm3993733pff.47.2024.03.15.17.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 17:07:44 -0700 (PDT)
Date: Fri, 15 Mar 2024 17:07:43 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
Message-ID: <ZfTiz_fhzPwRk4Xb@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306020053.18054-1-yu-hao.lin@nxp.com>

On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> With host mlme:
> Tested-by: <rafael.beims@toradex.com> #Verdin AM62 IW416 SD
> Without host mlme:
> Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # 88W8997-SD
> 
> This series add host based MLME support to the mwifiex driver, this
> enables WPA3 support in both client and AP mode.
> To enable WPA3, a firmware with corresponding V2 Key API support is
> required.
> The feature is currently only enabled on NXP IW416 (SD8978), and it
> was internally validated by NXP QA team. Other NXP Wi-Fi chips
> supported in current mwifiex are not affected by this change.

Thank you for all the evoluation in this series. This looks much better
than it did at the start, and I appreciate the additional explanation of
featureset (HW and FW versions). I'm not sure if this has been
asked/answered before, but are the MLME/WPA3 limitations exclusively
tied to the firmware support ("V2 Key API")? Or are there hardware
limitations on top (e.g., some firmware might get "V2 Key API" but still
be unsupported on a given chip family)? Could other chips chips
theoretically get this feature-set in the future?

In absence of a clear answer on this, it's definitely a good idea to do
things like you have in this series now -- that you have a short-list
(of 1) of HW where where it's validated, and additionally a FW
feature/revision check to ensure it's running appropriate firmware. But
I just wonder what the feasibility would be for adding to the shortlist
(or providing users/developers the option of doing so) in the future, if
people are so inclined.

To be clear, this is mostly an informational curiosity and
forward-looking question -- not a request to change the implementation
in this series.

Thanks,
Brian

