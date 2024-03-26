Return-Path: <linux-kernel+bounces-120039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DEB88D0B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF6BB21626
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F97D13DDCA;
	Tue, 26 Mar 2024 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyDg57Uh"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0013D8B8;
	Tue, 26 Mar 2024 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491703; cv=none; b=mEKmD6m8Qmy4Y3Sw9ROOSsDxawG9acvvM53+sdoAQ556SA1DqaBRMa1OZZbQuQUgO5RcQCWdzr/l3Y3or6rvnFYLWGz5GaTTkxnJOC4j9RMcDMCR8fEBZoy1z1sDUUUIBwJ0zSYTb6DNyWSoekViw+dXkmajk1BDsvTyr5E35QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491703; c=relaxed/simple;
	bh=mg5CHL67zV3tQUE3yPMMGIP9AiC9A0NRiTrNYg3lphU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMES3jaJrlRgITCNQ0P8jXJZjmnS7QW1eIoFq07nYGTF8p+jpB1xETIt35DGuzaiu1+Xe90NOzuGoEvQmpjvbQsrQouJDWwdcuE3UwUIIX1vnWD8ZyjEEBlvYJHrpTZ3XMrffNndsnBuH7U8Mg26OmGfvAMs7Zr+cBEBVoGYM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyDg57Uh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44665605f3so715117666b.2;
        Tue, 26 Mar 2024 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711491700; x=1712096500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVLloZQohcM2K6KQJQyVlxzxH6NCVFHwUxv2R8Egdf4=;
        b=WyDg57UhA/iUzbcr/XQ0EwybNap2MO3JGObfhYCwvOZrzE9J3TEx5L4MPpvuVq+Bbd
         lPb0nts6scmVlyH41g97F7g4HrJcYdsKPpyg+XR7O+mkEEnlhUlB1jKpKY40765S7G5q
         0NQbM0zFw4qzdBOwBTZHFW5pSYWAVW2+b50U6bGQhaR3VE30vi8QB12Eq4FnEmRRdE/4
         Cft7KPXwMwEeqyBSZUUWZqqO+OEthMxtlle6zRnYhGMWK+RvF5vc0ZskTnLCxqWuFDX6
         fJtSeaMtcJGzlLJGyoQljQ4RjEasvzavbfJ5KUf5Z8OnA6Cz/jgQ1pqdZczY/qttbNtf
         v63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491700; x=1712096500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVLloZQohcM2K6KQJQyVlxzxH6NCVFHwUxv2R8Egdf4=;
        b=AklKPNUQ/U/+dNBRc4GsOc+LmDV8Fx73z8JSOD7LGgOWcQGdcCFSsZQzMZYzOOakai
         nFFQHEwX723Txpi3Fyfxq9p2162NygkKt8Wod7L4hFFFqbhOdWgrFXH4o3A+zFUKZxXW
         wT9asQhZY50WdEv95VeIxfT/GCzPvQeBdMyIgOg5a7tX7oin4ycm0TIpDMjTbfR9bY+L
         njwLorUfIrutXm101Krmi5+HcmdyL3iW3gFqtqt4+wvQ3+M/XZ15AhXgprLcDfq37htP
         +K4lHDDh6arkiWh2xNpamcZoIeU4i5JXPxB0a2/swhFYZE8UaxFj39j2BwPNuJFqYhPP
         a6dA==
X-Forwarded-Encrypted: i=1; AJvYcCWHCo0+MpOy4/eY7sdRT6VqO/LP6szzghhRle7XVzVmIEgTghB92r6h8G01OCNVGVli4eFgcCaknmpB85EnBFF/JDtzOEXVbp1SFtSYITeIkvb+f4eRXX0gG9LeJZl62Gy9mFBVupdQUQ==
X-Gm-Message-State: AOJu0YwW7D9kbYOR1qwIZwyfL5BiSoTf58vE8k8CKZiqXWA/7liO473J
	b9aQKkjjXAqSrker0OF8WcvxDREpvU5aZK7d6/flMYXroX+nULCS
X-Google-Smtp-Source: AGHT+IFbfOTWjdmcyMkuurrgXcsz3zLRqlN2HZmiCb9ThEJsejRWtXx04BXPLsIev7aMaw9frXjdaw==
X-Received: by 2002:a17:906:53c9:b0:a47:20e0:d618 with SMTP id p9-20020a17090653c900b00a4720e0d618mr763288ejo.60.1711491699853;
        Tue, 26 Mar 2024 15:21:39 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id y4-20020a1709060a8400b00a46bec6da9fsm4640433ejf.203.2024.03.26.15.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:21:39 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Corentin Labbe <clabbe@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 4/4] arm: dts: allwinner: drop underscore in node names
Date: Tue, 26 Mar 2024 23:21:38 +0100
Message-ID: <2317198.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20240317184130.157695-4-krzysztof.kozlowski@linaro.org>
References:
 <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
 <20240317184130.157695-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 17. marec 2024 ob 19:41:30 CET je Krzysztof Kozlowski napisal(a):
> Underscores should not be used in node names (dtc with W=2 warns about
> them), so replace them with hyphens.  Use also generic name for pwrseq
> node, because generic naming is favored by Devicetree spec.  All the
> clocks affected by this change use clock-output-names, so resulting
> clock name should not change.  Functional impact checked with comparing
> before/after DTBs with dtx_diff and fdtdump.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



