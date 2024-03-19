Return-Path: <linux-kernel+bounces-107719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0BD8800B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321F6281E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA083A1E;
	Tue, 19 Mar 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZEu/ANV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD132657BE;
	Tue, 19 Mar 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862193; cv=none; b=Hga3DdTiuMqDLCrhGeuHd0rbiXGj0hUCd+CTXIWhQAuMOLNH5QZ2yjzX7HiiVugBjl4bevuQEHz7+TY5eO5rAZfeDns05Z8LYlwLzY1T20sCUzr/sW0C0/koEIYrKzLQ8n5EN3ql/iVXnNkmvTut9YIV9eexOD7O/E2HtIxrQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862193; c=relaxed/simple;
	bh=8/BAOgM7/E4Oo/lzhVSkfOrC0gVN60IoirdUeSlLQpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUgYcZcQ0NWP/o45wR8H1ja/QCTBDJVG/axzfQKrK81SiSLl1NY6S4jUyhV2erv8E4zEvCBOWePEtcsLeWDr5+Fb24yifiPu+ZpNZ+PpTuaaK8PypRpW1uukECIe1vIr/ATKgcqD5/hXV0EY0YYzg/BgMAwbYuelZONgoOTWzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZEu/ANV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E101C433C7;
	Tue, 19 Mar 2024 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710862193;
	bh=8/BAOgM7/E4Oo/lzhVSkfOrC0gVN60IoirdUeSlLQpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZEu/ANVOCScrmFrRpYhb6lv9kfcI1MRolgnPAxDfUrvI856KNELYC3gAS8nuBngd
	 M9XRLrl7h90EkRCEN7dMkycWmKdksVc5h+jviA+dvCsF6khX3idFQrM08mbr/zFiH0
	 uB30woKsESP10flPIy9Es48hqFbbAc8uRLc4JmkUiN+zkmTmEOeepDeBh68U0qROlK
	 epUIiwqvdOWJeQTxGFdJIQ7w37pcOzYQEFJDNIsFdzyVgbc//n2AEKPzQYeZgANrb1
	 q545wrbYA5yREvFDOuo80nyciU2H/jCDmRWOvqvj0GJBaYCxZRVgtqlYOR+KQusKHI
	 8ACqk3BgRQhGw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmbPc-000000000LO-0cIK;
	Tue, 19 Mar 2024 16:30:00 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 5/5] arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
Date: Tue, 19 Mar 2024 16:29:26 +0100
Message-ID: <20240319152926.1288-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319152926.1288-1-johan+linaro@kernel.org>
References: <20240319152926.1288-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several Qualcomm Bluetooth controllers lack persistent storage for the
device address and instead one can be provided by the boot firmware
using the 'local-bd-address' devicetree property.

The Bluetooth bindings clearly states that the address should be
specified in little-endian order, but due to a long-standing bug in the
Qualcomm driver which reversed the address some boot firmware has been
providing the address in big-endian order instead.

The boot firmware in SC7180 Trogdor Chromebooks is known to be affected
so mark the 'local-bd-address' property as broken to maintain backwards
compatibility with older firmware when fixing the underlying driver bug.

Note that ChromeOS always updates the kernel and devicetree in lockstep
so that there is no need to handle backwards compatibility with older
devicetrees.

Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogdor and lazor dt")
Cc: stable@vger.kernel.org      # 5.10
Cc: Rob Clark <robdclark@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 46aaeba28604..ebe37678102f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -943,6 +943,8 @@ bluetooth: bluetooth {
 		vddrf-supply = <&pp1300_l2c>;
 		vddch0-supply = <&pp3300_l10c>;
 		max-speed = <3200000>;
+
+		qcom,local-bd-address-broken;
 	};
 };
 
-- 
2.43.2


