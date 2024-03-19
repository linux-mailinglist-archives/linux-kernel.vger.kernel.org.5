Return-Path: <linux-kernel+bounces-106935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1F87F5AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1BB1F21FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526027D3F6;
	Tue, 19 Mar 2024 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUeDGdX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880697E572;
	Tue, 19 Mar 2024 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816542; cv=none; b=Tclwbv2t7purSFM54l20f/UvH0OmhsVlPpE189kKMbyyZhecLH4ij46xdq6RNMAaL9zmCxBjeqfQ9yKQMAiI+6NptHnvDHXreTKG84OUWjiR0QZu+yQkimU3X4ifjOM/reIDWAvtQEfnJ4vrww1WoAuv1AY30gq0TisGYex0/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816542; c=relaxed/simple;
	bh=duyIFh111GdgY8uZhIwil5LxGThPSh0MWa2ewQJ7/Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pP9Qoz8lSnkJUmP3lBGBMSI87gferyFyGXXIZLFr2L6YtHbntpqvPxaCPe+fd+ef83eSFJPjlKb/pUqE5xnUHFfMyu+JZWJlyQIAtyy8kFMXabZJMven6A1TA6nHfI3fF3CunFj91P1X4hyy/zyuPNHCZzPT3GGDH88jw1v8Klo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUeDGdX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B76C43399;
	Tue, 19 Mar 2024 02:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816542;
	bh=duyIFh111GdgY8uZhIwil5LxGThPSh0MWa2ewQJ7/Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUeDGdX/hQcftX6GXGW+/Al/Q1MKvq9Dp2QePCbjF9SdlaTC4uf85IOFJHIhJYnNW
	 eyvK3cGo/FP5KRhsR4COq2aiTsbcFINiEQxrsWY20A655RFXGWmtGrSLYpR5NU/7Du
	 tpoRSqYvQ80uacKoZeEa4ieqRsGEOnh+P4kMuFo2neMiov1ugr6GfSiA7Lptpz1pON
	 o/XXq3W2NzT2bor2VNvJs5zLjbn5kTlfkIHji1ebk8Opj5XpIHPKR885q6sK5POqJD
	 Y/TU7veb59xUnHtbOQuaH5OsV2XD0c2HoBpW6qYO4lfOyNWhlGgOgNpRXL0fgaOpVL
	 RpwJa8ODI1pAw==
From: Bjorn Andersson <andersson@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Amit Kucheria <amitk@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	stable@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: Re: (subset) [PATCH v2 0/3] QCM2290 LMH
Date: Mon, 18 Mar 2024 21:48:33 -0500
Message-ID: <171081652641.198276.6279515600086976748.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 09 Mar 2024 14:15:01 +0100, Konrad Dybcio wrote:
> Wire up LMH on QCM2290 and fix a bad bug while at it.
> 
> P1-2 for thermal, P3 for qcom
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: qcm2290: Add LMH node
      commit: 7d6d561fa934594faf359f6fffee0e2dd59f8110

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

