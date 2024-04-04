Return-Path: <linux-kernel+bounces-132133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF759899011
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8651C219A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D65613C3F3;
	Thu,  4 Apr 2024 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdw+rZef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48812DD9B;
	Thu,  4 Apr 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265799; cv=none; b=n4W/R8s1M2PABPQfevRTFMJZGHR6nbYNiuXUxVE8KbFc4YhQaXlCuiUs62GRQM4fFG6aHG0kwLqCefcXkWk/l0nlWFmGAdDt1lEkGOJNh7nNYDah4Wh4dwjMs/TRLZHH2KXzbiXC8qmgp54jzFoCiEB4ULk1aGR1qmvmiu3G0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265799; c=relaxed/simple;
	bh=PVLmlIvJKfob7xOlZGZcbXNRUxQbQRqb5Fmg9ZDcBJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrKBfzWTdXHqBpgP6H8o/D+j4I/lijHC2xD1m6XQY7Ln0LaTWUY9vuQt9onm55sPJGH+YpXZrtr9JHuyDvw5uy8VAlMyo72IZUBuWPDfzU/0snNAJl+Nyk7KosL+scs5UDwVOqLbUausxgfx49xv5ZaUf88C3hXJFBKT5wlXRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdw+rZef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D281CC43390;
	Thu,  4 Apr 2024 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265799;
	bh=PVLmlIvJKfob7xOlZGZcbXNRUxQbQRqb5Fmg9ZDcBJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rdw+rZefr1qzpCl9/JoPb60vhe8qEUu+7GJYXNCJsTvqNbrbjXw7aoyWgN5jWsSzH
	 G+2E8+4I2DMBobN6ei8IxWGodIua896TKe1vBCfvPVDqMGBYNBZx7y4S6SIi2RtcTM
	 PjXMV3GKl4nCU3v+K5a3B0lpMoSuh8RqEhG8sNTk1NbQnCqQEGjg+GCCT95ERfX+2c
	 kuL3xNEHCjZS/SfFqACNmoUOKkR+nBFlxbgSkACcfmun5+9jUNlrfoQHonQGfaY0Dj
	 fp81GQHmRkdUv9u4/vyGISfzil7Fe0om9LhGa4c+3Q0HvmNBtTPUUu8DXg5xmQbCYl
	 LtZFBuB1XaGUA==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Stephen Boyd <sboyd@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	David Heidelberg <david@ixit.cz>
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Rob Herring <robh@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v4 1/3] dt-bindings: arm: merge qcom,idle-state with idle-state
Date: Thu,  4 Apr 2024 16:22:48 -0500
Message-ID: <171226578669.615813.12438355474081050798.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202234832.155306-1-david@ixit.cz>
References: <20231202234832.155306-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 03 Dec 2023 00:47:17 +0100, David Heidelberg wrote:
> Merge Qualcomm-specific idle-state binding with generic one.
> 
> 

Applied, thanks!

[2/3] ARM: dts: qcom: include cpu in idle-state node names
      commit: e48919dc1ed568f895eca090dc6c5dc56b12480c
[3/3] ARM: dts: qcom: msm8916: idle-state compatible require the generic idle-state
      commit: 8f2cc88cd4a35e33931ca1375ea508c8c9267b57

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

