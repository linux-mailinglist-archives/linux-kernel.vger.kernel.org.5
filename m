Return-Path: <linux-kernel+bounces-142698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBCA8A2F16
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDC52816A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E05FB9D;
	Fri, 12 Apr 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRiw++ss"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432CD5915A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927650; cv=none; b=ug3G9rlxIPuvpkpIiknxTTRXyN2SdD5u2gbFLJE20U1PhUR2mMa8F/Iul1PBColtB4DqLYhkVOyDBue20bnOi1qBul8XwDr2LZuZKk5w0+05CdWSBlJmmuk3dkvpCvxOvhw7LiRn+B4bZAa9RmrgqqNnfbsW1B6shB/PNb5VlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927650; c=relaxed/simple;
	bh=6YJNqOjFXn4Ir3YczK0thP6clNnk35Xl96pAGt768Kg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qb+xFzwxacTIVldYJ83xbJM2C5DI6926CxOvkV4OEv+n0njngWoZmmCaHR0GwSRqXKn0ZMZJRXNEjWlpHcVQX7/znlcX19MCNswN9tkmNA9GQpuqyS9qfmXoNSeVAVbmy/xQ7g0QVGSlcMSY3V0/p1EMJR5iCxE9ToduCaCnL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RRiw++ss; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41550858cabso6657485e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712927647; x=1713532447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH18SrMd/y4JjJ7b5pFwPelRx1az3iZoiPbP291BArw=;
        b=RRiw++ssuTjNbvO0YDWVkAIy7v8kqEKqxSATChnLC+qQHUAONN8QgdJE5B39KI/tc7
         aD5cTGZt5Qdi4UQJQpFHkAJfC+T+bhRrMAnRCsEumnyKzUYrLMNZb9X6XUOOQTPEOsiB
         bCy6/Y9nXDFE/UwYhdVjizRUI+lr8c9ZVgiJm1IV3AXWZRv2XOmU1YQg7GEb3SBS0s2j
         t9UOhvwnbhMbhGoBUTJlqG38kwexwa1dAPFT7OX9Uc0Rt8y+5kjopHRtY8Mj4UsmX7zV
         4KNDfP+PpTc+LcL7SjhW1GiPP/F/JaCIbKdoIdTmfBBzzQ2pnKUe13rgaNwA051EZM8R
         hkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927647; x=1713532447;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RH18SrMd/y4JjJ7b5pFwPelRx1az3iZoiPbP291BArw=;
        b=WZg6BFA2pB+71AwGrnR/ne5wzFLM0EBdd9i5O9Ciin7ZRtX4L7epkcN/8/RUPN4DfA
         sNPccsIhyVbOWWEo8bzTU+0TPXEFBbwTQQFmJ98OzclrDgWrvR4F9TEbnLUCFGjXiQx9
         dwNeHbTgs9yxCHmi02B7MO2KXlKFLIEGFw1S7FhXa+2tl1iHox1wO5wjjF0g6/DSfHUl
         F+IAm0+R0T63Pd98cto3owaWjjRKWLV+MobwixlQ0qYTehzSAmVFb61QODzla/zu/EK2
         3zZfI+lHW0/pAhT+hsMR2LANwd4gqfow6hF/yOJuS05y+3S7+4UNmZAIFXvwcjMTmOW1
         CKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnAhwiwmvP4+sMLek27RXUIiLNWfXtGiawCn+yqTXrJm1JL+7o1MnKArTB1iMCOLbYBeadC1pI6/k1DWxhzf6hgra1xGTPk8N86Dlh
X-Gm-Message-State: AOJu0Yxk326dElePFyYVhmZNSGbKIii83e5nPbkAOQmMDEQgD/wWGF3U
	T4R5GgHJjfz+5RfY1dlbUZtyFbOvrBn5CHfkRlHQIYkFU9eTwrN5YZqgMdqwkNw=
X-Google-Smtp-Source: AGHT+IFTeG5T6c3kUpQBmoojixRUDv73esoWnMSch/lx2a71iqWniDXUj8ZnnLLFy1S+Tl+cSCNsNQ==
X-Received: by 2002:a05:600c:c18:b0:418:cd0:d8ed with SMTP id fm24-20020a05600c0c1800b004180cd0d8edmr629322wmb.41.1712927647557;
        Fri, 12 Apr 2024 06:14:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c4f8300b0041627ab1554sm8826376wmq.22.2024.04.12.06.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 06:14:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240412-fix-secpwr-s4-v2-1-3802fd936d77@amlogic.com>
References: <20240412-fix-secpwr-s4-v2-1-3802fd936d77@amlogic.com>
Subject: Re: [PATCH v2] arm64: dts: meson: fix S4 power-controller node
Message-Id: <171292764682.2837390.10687361550734492802.b4-ty@linaro.org>
Date: Fri, 12 Apr 2024 15:14:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Fri, 12 Apr 2024 16:42:30 +0800, Xianwei Zhao wrote:
> The power-controller module works well by adding its parent
> node secure-monitor.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.10/arm64-dt)

[1/1] arm64: dts: meson: fix S4 power-controller node
      https://git.kernel.org/amlogic/c/72907de9051dc2aa7b55c2a020e2872184ac17cd

These changes has been applied on the intermediate git tree [1].

The v6.10/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


