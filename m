Return-Path: <linux-kernel+bounces-82942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB4C868C09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26649288B26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7D1135A6A;
	Tue, 27 Feb 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrfpclUb"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24E54BCB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025523; cv=none; b=FlXD4qsgaEMPA4PhOtRM3sJge14duHhToFXPtI9RnR47rJaiPbjt2xgSQNwAMnNdyCl1sYE7sGhjxoY/L/9g0XlU5OClEDbrfq6bAHt8XkjbXp0uV6l2vd3bp+IEYCZffwfkINhCFvGVcnQoAPfDAvA1+8xF6JdUr+I0mj0OmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025523; c=relaxed/simple;
	bh=+caxhbxvXcG5btEQEz+HchYw+UK5NIuQWCABSjExhS8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qTfOHVNphRJ7ym/6peq0ZTd2NQ4qE/GAos1ZdpluIhhVJDMde5er0txgVccg4tdN1WMImOnHTHTNYCnd1ENC7aTWXSRUXKq1HCowZDKMCTCHpn2tcrz7Fqkuzlq2UXdEtgVcbCEBuZXkCo2KewRLwg3Anp/tYmiJCASWF4085+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DrfpclUb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso547257666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709025519; x=1709630319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTxdDYxyQ3IqtlRrYxG0cMi0muAaZV+mdO2HgBPhVk4=;
        b=DrfpclUbD5IJXFN/GU5JTGVnzMh00BH7P+hNogtw/Ep6Qc2RcJ8GkdP0Li2jjt2N2h
         rcyqcgQlkt6t0UvUusHvnHjhLOyqHnC33oz6OB0cmX5mM9Utq3AeOGIQvRPQjQ4oV3sZ
         wz1ZtpJDcN24A03hnenEOBYRRVLWI5nULGuCwFiK67Hl7d8qxrHRCn2b1zsbwxsYMVqe
         THiN71AQoiR0mLKQN3Y4YavM5KyKiELJpTMViy9I17nGWAncI3Ih73Zbgjf3+OxR+6TB
         7ik7WtYPzlJ9z9a6xXC3Go+rYE4Axd0aOAMUfDlAkmC2tuwX2+Pw6ZRPydOFN8yBT4Jr
         PlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025519; x=1709630319;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTxdDYxyQ3IqtlRrYxG0cMi0muAaZV+mdO2HgBPhVk4=;
        b=LAErealZ4sEhOA3b1ELZ7yCRgNchXXy0nbSTGoJDud2xm/1CwANys9356pTKdka3j+
         66DjGT0JFOjWo80yEY9HGsttmJDvS+3WU0ajs/m5ERiZjJRJuDxN0nuJldlWwE891PXt
         0faxWJdqVUWHVmLTCzyrQdlR9/R7LvNTDkyg01x5HIK3A9cyGwx5jo4IHa/KbjdSwA/E
         3d9g9nVqNpx2ztCyVA4llz81GRwy98Y1cFUmomUT5scmRgId5mfpURX4ogWbYw8sLKxW
         42S7k/Dq8abn1OauQrKUySriwpussOzHpFS2A11GzwP5vT1KEjNahGneIfvfem6dL69Y
         As6A==
X-Gm-Message-State: AOJu0YwUJONbi2q39glhEuQ1sXefLDSuDLhDhf2D6hccT9EcHbJ02ilt
	z2omse4A+pt9jn54RO7RbIO6uNR46Oud1NTijd6I0omm6bCeTo+gkMcQ1dw3wbhdf9M2bVyeThO
	L
X-Google-Smtp-Source: AGHT+IH5qDiaCJ1Kc19hS+XkEPETptoM/fW2uFhb8X4AvKdAgnH5cE9EdnEx4zaM+SmijwWe1GLcsw==
X-Received: by 2002:a17:906:3c05:b0:a3f:4596:c3c8 with SMTP id h5-20020a1709063c0500b00a3f4596c3c8mr6253526ejg.53.1709025518961;
        Tue, 27 Feb 2024 01:18:38 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709065f8b00b00a4395a7adecsm561154eju.165.2024.02.27.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 01:18:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, Christophe Kerello <christophe.kerello@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 devicetree@vger.kernel.org
In-Reply-To: <20240226101428.37791-1-christophe.kerello@foss.st.com>
References: <20240226101428.37791-1-christophe.kerello@foss.st.com>
Subject: Re: [PATCH v3 0/5] memory: stm32-fmc2-ebi: Add MP25 FMC2 support
Message-Id: <170902551749.40155.4302792627974952211.b4-ty@linaro.org>
Date: Tue, 27 Feb 2024 10:18:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 26 Feb 2024 11:14:23 +0100, Christophe Kerello wrote:
> On MP1 SoC, RNB signal (NAND controller signal) and NWAIT signal (PSRAM
> controller signal) have been integrated together in the SoC. That means
> that the NAND controller and the PSRAM controller (if the signal is
> used) can not be used at the same time. On MP25 SoC, the 2 signals can
> be used outside the SoC, so there is no more restrictions.
> 
> MP1 SoC also embeds revision 1.1 of the FMC2 IP when MP25 SoC embeds
> revision 2.0 of the FMC2 IP.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: memory-controller: st,stm32: add MP25 support
      https://git.kernel.org/krzk/linux-mem-ctrl/c/97dcd1ef76412d0f25d2d50215565fd4d9ef91db
[2/5] memory: stm32-fmc2-ebi: check regmap_read return value
      https://git.kernel.org/krzk/linux-mem-ctrl/c/722463f73bcf65a8c818752a38c14ee672c77da1
[3/5] memory: stm32-fmc2-ebi: add MP25 support
      https://git.kernel.org/krzk/linux-mem-ctrl/c/2ff761ff29f6e2d0e616b21af3e054dac1f2c5f4
[4/5] memory: stm32-fmc2-ebi: add MP25 RIF support
      https://git.kernel.org/krzk/linux-mem-ctrl/c/cc7d5cf8021983a736f9d963dda2dd45de02b395
[5/5] memory: stm32-fmc2-ebi: keep power domain on
      https://git.kernel.org/krzk/linux-mem-ctrl/c/e46076906722ee6f9e7fd5abad7f909cd11a26af

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


