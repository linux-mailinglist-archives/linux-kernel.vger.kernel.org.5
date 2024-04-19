Return-Path: <linux-kernel+bounces-151577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAB58AB0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AD3281C22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207E912DDA7;
	Fri, 19 Apr 2024 14:23:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD82B12D1FE;
	Fri, 19 Apr 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536587; cv=none; b=b2d9jmmQB5IJyHBNRs2R32YovJaw2HAMyq7K0xTcBGKo/+Ajgf6iXTkfx1iXI849ey/zhIunq36EkcMI2j5N2vEHx86Ky08Xz7STpnvzge5vf8xb/zjc4/+OgQi8u9zID/Qni+hygs5pvR61YPmcd+aT+vsKCvMZLKR2c4Ol6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536587; c=relaxed/simple;
	bh=L7wHzGdmC2ghwhCLP4Rkc1xh41ST3VpiCaXX3R97lPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVcyzWFZ87VIlLMEuj9uwqQvHotq22ZKfqJtMfFLYgszHEw9q+4Q0fhaC4CB1p/NpA4SRZT6kbqgu/DA2kJuuebKOSm82IEmWl6TamENxNdHTsJjlynviPgzBMwcSKHo4WndLYpWD8srfzfRubf6pkAqiwClQko+WZ/SZ54679E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92603339;
	Fri, 19 Apr 2024 07:23:33 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C97B53F64C;
	Fri, 19 Apr 2024 07:23:02 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Dhruva Gole <d-gole@ti.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v11 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
Date: Fri, 19 Apr 2024 15:22:58 +0100
Message-ID: <171353646995.3805320.3344737925927159972.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
References: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Apr 2024 09:32:27 +0800, Peng Fan (OSS) wrote:
> Per Sudeep's reply in v10,
> "This series looks good overall. Since it has pinctrl driver, I need Linus
> to ack/agree to pick the whole series up or I can ack them so that Linus
> can take the whole series. Either way it is fine for me."
>
> v11 is just minor update per Andy to patch 4 and Andy's R-b applied.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/4] firmware: arm_scmi: introduce helper get_max_msg_size
      https://git.kernel.org/sudeep.holla/c/4869b5cc9641
[2/4] dt-bindings: firmware: arm,scmi: support pinctrl protocol
      https://git.kernel.org/sudeep.holla/c/1b403075e6cd
[3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
      https://git.kernel.org/sudeep.holla/c/2145af01b9cb
[4/4] pinctrl: Implementation of the generic scmi-pinctrl driver
      https://git.kernel.org/sudeep.holla/c/eb524cb651b7
--
Regards,
Sudeep


