Return-Path: <linux-kernel+bounces-56731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EED84CE46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08A11F21B79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1A8173E;
	Wed,  7 Feb 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sIKzYJDv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B544811F4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320315; cv=none; b=iQcYRHZFRGc2QvTF+WPV5FLSg/eVpbEBuu5gx0a1MLRd2aLNcq0SZNp4teTXJPI2muqyGLa13Aye620oAf176j68YR17Bz5r1DG59a6rP//DNneXY0S3aL+oFt9ml0OSopEvhKO1mwj0t7p7BlcoEZM56rpCVeOp8BchhivKMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320315; c=relaxed/simple;
	bh=oFGTh2OhIvPbiv0dHz2+sLUdT0AGdS+r+fNSNWcO/FA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pySDo/KdWcozWfPaq2aSjp1OcXZvEUjtATcEGFpD+Du1gnazzsSUmXA15cvB0IvsFaYPijJC/yZhjFXdydz+4lwpdmotVxsXKM2NE8LH9qdneqSaEFZT3L+EYonBsGqLpomTcSv8I9u5U8kzXCDJKr1YRNY0muaPMUGSABuj4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sIKzYJDv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso7197985e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707320311; x=1707925111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbvJWnlre9MH2EiIqsIcJXmUPZrjG2BFAN9G+36KKP0=;
        b=sIKzYJDvJiOKRktNfD+DW6VYZo1ONAQDl6JFUZYQiDqgZhxxUO/iF7okwYdwEFai15
         EMN6EKIf5E6xf2qWRrdeIamfD0VLItC25dCbahqqxmHo1kUDlqZqOGn+ljqdwMqVz1zb
         l+yNRrcCf67V3vGr/lsJ+tYSv0zdiW/IzmHod6PhFPlQuEYjBHtWGZbBXJxEIN97t8W8
         eKKXhm3QoYhdov/JC+RNY8I24cAq11SeOvzwcRS+jreqXhfUHil0DhPp+6YLn3G52OfI
         rCXq0PmkbEK4RBcg1xa9rjipE+h4R7w5bFboqpbd6D6gZ0BDwbyL4ysHxk2HgM7tvmWJ
         R+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320311; x=1707925111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbvJWnlre9MH2EiIqsIcJXmUPZrjG2BFAN9G+36KKP0=;
        b=XrWUFUXEGHHi4XvBfWL4swlYqkIVphYRp5Q04zB31rQy1sKbTVzNTVmu5PfTzaAJIh
         uQ943JkdrkNS0Axle6EFNrg2LKtXG/Ul86DZYS+XnxhAJWy6Af7EBkx57Mx7MpB5k89D
         rlvh30Tq42aklJyIMtRqNqWUmwM+rEE0c7HcWoE88ZL9vIiymEz86DIhnwshJ2AxGEwc
         ayrtKA5h1MvxlpF07UK9SR3sx5b/aHNm/TrxYBnQ4WiTqvFQVk8JfNwqjUdA67qPOfuc
         FuCLTdZsT7xY0Oazms8Y2tpm0NpltJRXTZzU/UsEXiyvQGthYuDNBA9CHvqIogUWbSp6
         KPqw==
X-Forwarded-Encrypted: i=1; AJvYcCUQVTlnYyOVGDvjOqSKSby/fyJZfAm84RE6LcJLFxy76v9h6JWXvxTCj4QoTjyvPobdqONLtN/plHL/suiGzbrqxzEO47WLIiwdxT+P
X-Gm-Message-State: AOJu0YyHTXX4VNVW6r5bU9vKJq27nR/WT5p3k9z+tK/j50kgnOrkZ00z
	AszA2JnMByEK2rihIP7kPs3gMMaZ/vOOaTHH1PDKQQJuXlanyWchPfJlbQI9mgw=
X-Google-Smtp-Source: AGHT+IGQqN+oRZ7J/ps9lkhJhgapJAFv4WN+VBydvkUTR/5OO834y+bRQjfqeYO9wqApvQHvaXOT7A==
X-Received: by 2002:a05:600c:4f0e:b0:40f:dde8:1663 with SMTP id l14-20020a05600c4f0e00b0040fdde81663mr4975194wmq.19.1707320311617;
        Wed, 07 Feb 2024 07:38:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1eYcUrPqoJ6E6XV63qXxSYuCmEy5u7Q6f5kaxMmJHILTmsgmwZdeYb1N7dcO3xGbdLEY5CdhZLczTPv8NkietV0vOOMOmNBm176mTYdh7nIZbtf2zzqNV+T3H5MOOZaCBW9yHJDykb3qEXQr6Fv1K/1RV/hWBir/thm9wO883n+ZxXl++LJv01xdCdRaLKdYvOx6g1WRd01SCDRNvNrNvTVhdpK2vVaxtBnyc/vH+pJ5qpgXcBuRIz+ADEGkO8qAeylKtbKwdcrmlLXuIX/EMRrCw5w7grPbxlWKZPgpVbfP0XqhDKiSHz2dWSAjh/CzbYeQPvgq5YFiGujLSsdG5Gjd2TeAoOAz6wpFT7stqzPJKupJpORClGMp77eZEDA9zkNxAZWVJZ23fMtBnY8bCfMAM
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c024700b0040ef0e26132sm1307678wmj.0.2024.02.07.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:38:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Henrik Grimler <henrik@grimler.se>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2] ARM: dts: samsung: exynos5420-galaxy-tab-common: add wifi node
Date: Wed,  7 Feb 2024 16:38:17 +0100
Message-Id: <170732026212.120770.6589907576886281410.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206-galaxy-tab-s-cleanup-v2-1-89025c6c66c5@grimler.se>
References: <20240206-galaxy-tab-s-cleanup-v2-1-89025c6c66c5@grimler.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 06 Feb 2024 17:02:27 +0100, Henrik Grimler wrote:
> By using brcm/brcmfmac4354-sdio.bin from linux-firmware together with
> nvram.txt from vendor firmware wifi works well on the chagall-wifi and
> klimt-lte.
> 
> 

Applied, thanks!

[1/1] ARM: dts: samsung: exynos5420-galaxy-tab-common: add wifi node
      https://git.kernel.org/krzk/linux/c/60f1164e21cc04666d23b63e1153af74e7a5650d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

