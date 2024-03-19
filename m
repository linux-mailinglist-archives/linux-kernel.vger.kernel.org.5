Return-Path: <linux-kernel+bounces-107716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB528800AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BED2833A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8B82866;
	Tue, 19 Mar 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epZgzaIC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B122657AF;
	Tue, 19 Mar 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862193; cv=none; b=JQmT+GYZLOZPwwOIw/Pd9qXxbmhSS7MBffGRDkFUeEwAIp8xUiSSe7Z5MTyeuBPWexVzHEfALmM7UNZANkPs/i5/Rbhy14ILJ1lxmrwXjZC5HZfWWmkqcjpQjYYuQLUEA16SfYTLKv9cXSdq7XRBWzU9eAZ/j6Q86byA9macOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862193; c=relaxed/simple;
	bh=GjYHvVQZs23pb77305b3S3FHd2IrH9UGYK67GbcU8xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmE99KEY2jGDRwpfgClLRM2Swjnn8jTC2yoLUjAJ9qCLCjs/Z8hoE3QNUl7p7bIfVUHJdtOXxTJTyerkFWI3SMuoZZvlQzmtqoRCUiXRp+56Oj2TwgMYBzdadh0WdsJBngeCsYeIBornEYBMb22SCV4RFKpTmDMkCMbqmVd2G7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epZgzaIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408EDC433F1;
	Tue, 19 Mar 2024 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710862193;
	bh=GjYHvVQZs23pb77305b3S3FHd2IrH9UGYK67GbcU8xg=;
	h=From:To:Cc:Subject:Date:From;
	b=epZgzaICmHiX6Rut66VHxi31UFGSx7PhZOxb4l7UGOqBQkzLQjHK/J9cM4WyLtcHf
	 1nwCt+gqfIGoljaTmCwMFy+75QnqKjkNXi5s0vmAHn/HO/qVAsYk3ngsISyL3zWRIR
	 9aQL5+WSd0EAcoEhlLqIGNlSd0sndWMZqEobUSbpl3M45Ncycn9CTrGxje5ePWWcMY
	 CwjrAMyHl4FujQxJJGj6btJmTx7JcInwUkv5zKadPIrEVDbo7fnip2YqcZ2LQ9FwN8
	 gkrBUzkCKOWcIu1/rN+/VCKaDZBkaqYF4ERwKWNOLFl98UoUBTRBjy/GOV9FXIHqVB
	 24gY89pq++hEQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmbPa-000000000LC-44WP;
	Tue, 19 Mar 2024 16:29:59 +0100
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 0/5] Bluetooth: qca: fix device-address endianness
Date: Tue, 19 Mar 2024 16:29:21 +0100
Message-ID: <20240319152926.1288-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm Bluetooth driver is configuring the device address in
reverse order for none-ROME devices, which breaks user space tools like
btmgmt and the 'local-bd-address' devicetree property.

As these Qualcomm controllers lack persistent storage for the device
address, boot firmware can use the 'local-bd-address' devicetree
property to provide a valid address. The property should specify the
address in little endian order but instead some boot firmware has been
reversing the address to match the buggy Qualcomm driver.

This specifically affects some Chromebook devices for which we now need
to maintain compatibility with the current boot firmware. As ChromeOS
updates the kernel and devicetree in lockstep, this can be done by
adding a new 'qcom,local-bd-address-broken' property that can be used to
determine if the firmware passes the address in the wrong byte order.
[1][2]

Note that this series depends on the following revert:

	https://lore.kernel.org/lkml/20240314084412.1127-1-johan+linaro@kernel.org/

Also note that the final patch is expected to be merged through the
Qualcomm SoC tree once the first four patches have been picked up by the
Bluetooth maintainers.

Johan


[1] https://lore.kernel.org/lkml/ZcuWQkmYK4Ax9kam@google.com/
[2] https://lore.kernel.org/lkml/CAD=FV=WCzrh926mkiyBnKRG_+KGuOkGN6v0DgPiXhQCD3PSQ9w@mail.gmail.com/


Changes in v3
 - add a 'qcom,local-bd-address-broken' property instead of deprecating
   the current WCN3991 binding
 - mark the bluetooth address on SC7180 Trogdor Chromebooks as broken

Changes in v2
 - add quirk to handle deprecated devicetree compatibles that expect
   broken address properties
 - deprecate 'qcom,wcn3991-bt' and mark it as broken



Johan Hovold (5):
  dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
  Bluetooth: add quirk for broken address properties
  Bluetooth: qca: fix device-address endianness
  Bluetooth: qca: add workaround for broken address properties
  arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml     |  3 +++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi           |  2 ++
 drivers/bluetooth/btqca.c                              |  8 ++++++--
 drivers/bluetooth/hci_qca.c                            | 10 ++++++++++
 include/net/bluetooth/hci.h                            |  9 +++++++++
 net/bluetooth/hci_sync.c                               |  5 ++++-
 6 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.43.2


