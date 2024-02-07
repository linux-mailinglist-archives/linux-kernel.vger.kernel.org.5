Return-Path: <linux-kernel+bounces-56589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770E084CC3B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178D1B212CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C57A720;
	Wed,  7 Feb 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upz6wTkP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532D23775;
	Wed,  7 Feb 2024 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314472; cv=none; b=fESvB0HRvszTY8L1Mjc7uuZ6yvmipXoWs74SnbsnCPP+p7YDrNQfPt+yOFo73hr13R1TeJJ+lQkNptDgbRUW8HospahbGwCpNhyHyOqFiqTVi7ZxCINgwlBxQ/9kVqbk1BmHwgBC/+sBD5+OT7AIt99ZOZmXaRbVUUM6jXUreMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314472; c=relaxed/simple;
	bh=QU4zHZ5yZeKhRA/NcZb3RGYc2aTKm/UNV58L0yHSg4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I2ARtmwxlYYbIe4LqGPG95WNa4gIBEKI6mpfuDj5KXxd4u9NUCkl7CrnZi4XqNxxUqTbpDUmWOTevo5brVur56AilbRUXM28T99ot5PQ0DIhk8GfFYXuiwSlmrMMr7TDO8hFDKEV3hvgHyYyAyvNgssDRIhu2DrJhDoWW8vDUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upz6wTkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC6FC43399;
	Wed,  7 Feb 2024 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314471;
	bh=QU4zHZ5yZeKhRA/NcZb3RGYc2aTKm/UNV58L0yHSg4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=upz6wTkPOaXK7fDrCqAlhpvRtNW41LZp7hzefKj8TaSbqSsvri+h2NWWSK4EUpacc
	 T7pofSj3QSVXF+ZeC8ARmOm4Xh5U7Gl2Q47BH7IATHvJVdxy5vYOMpveckm5zUluLZ
	 ZX+RWMRDK7Cv/eEgONhjudY+dsF72jjGA9aoroNQZh+dUW2YMtXvAdc2Fr0scDMGis
	 qUi7OkZkDkTkf0A7+6KRh7C9DXehkazqmIKiKy3//RzZVGIXDKOw3YIeH8Q3e10LqM
	 XES8QOsD1tqm+EyKNWW45QbDiZxpL4/ALosiPCtXb6VFz6n+P0GCJOyhXpu0E0yJhM
	 AtPW7WSeAh/HA==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: Elliot Berman <quic_eberman@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201-phy-qcom-eusb2-repeater-fixes-v4-1-cf18c8cef6d7@linaro.org>
References: <20240201-phy-qcom-eusb2-repeater-fixes-v4-1-cf18c8cef6d7@linaro.org>
Subject: Re: [PATCH v4] phy: qualcomm: eusb2-repeater: Rework init to drop
 redundant zero-out loop
Message-Id: <170731446925.147017.11723042709584104683.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 15:01:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 01 Feb 2024 10:39:33 +0200, Abel Vesa wrote:
> Instead of incrementing the base of the global reg fields, which renders
> the second instance of the repeater broken due to wrong offsets, use
> regmap with base and offset. As for zeroing out the rest of the tuning
> regs, avoid looping though the table and just use the table as is,
> as it is already zero initialized.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: qualcomm: eusb2-repeater: Rework init to drop redundant zero-out loop
      commit: 734550d60cdf634299f0eac7f7fe15763ed990bb

Best regards,
-- 
~Vinod



