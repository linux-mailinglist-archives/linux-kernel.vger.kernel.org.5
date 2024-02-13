Return-Path: <linux-kernel+bounces-63317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA8852D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771B31F21D11
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F2224FD;
	Tue, 13 Feb 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqOrg7sm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CBB225A6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819133; cv=none; b=SpdlcAe09d4fBaAm3P1m98d0ayqC1kkxq+kh8urDYby1CGg7QoIGltMU0YOkqYrlnWjuvNpBw6lwyYKA9PCOFw9Z8UEcpf7fKEJ5gf4G16xBalN/UFJLxoMe9kuwpJb7gHQ9sc9tfYj3ku3DxZgqUcZ6Vudy3me3s6+JEgn5c8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819133; c=relaxed/simple;
	bh=EqiSyCvvYVGNNTw5y6l1IGBt7A2JIvJ6PtyQAGB8DWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qLZjn8jPagvj0OQQ7O/B1+DGPEWIR6ESOaJ74loG490HONnjbc5APGV+JMDUBs6nCBGMFFzeE24wXKVmVDvrLkA+uCjF3m7OrTarpm2UX63/xXLWLo3L3F8uJ5Xsm+ZH8o3UD9RiuwJ+nUtMuBa2wLHYvvXjAI8GjWlk/BkyKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqOrg7sm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB80C433C7;
	Tue, 13 Feb 2024 10:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819133;
	bh=EqiSyCvvYVGNNTw5y6l1IGBt7A2JIvJ6PtyQAGB8DWw=;
	h=From:To:Cc:Subject:Date:From;
	b=EqOrg7smnafdd/s9KffUTWxsfcSXOlClpYW7RIsPwHqqdxMgR6SYKm/faDj49gDpb
	 /NuRLyrsuZn/G/e3UahF9PRi1jKG471AfK8GLGLqbVOF2UAaAFbTnzRcOp8EVYYQ3v
	 FGc8W3VG6f6TOAPLsfFr/fvt6DLRZcYXyLtfqIDL9EEcJ8vmEM/Hv/G9Al7Yl82IWo
	 Is/JM5Sg1A7ZMIZ5o0iffg46Re/XZe1hERpAYDhZMNrscpjnOp8RnnulLRD54Wa6zZ
	 ZmZVnp4cgSXSse2M7Yleq7njaHHeNTDnImbkG84/A+zywNDjz6xJNeC5nYlG18m5Yd
	 YnNBi/rn9AuMA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rZplq-002j7r-MV;
	Tue, 13 Feb 2024 10:12:10 +0000
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] GICv3 ITS fixes for 6.8
Date: Tue, 13 Feb 2024 10:12:03 +0000
Message-Id: <20240213101206.2137483-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, jiangkunkun@huawei.com, lpieralisi@kernel.org, yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Here's a small collection of patches that I posted separately in the
past, but that are all more or less related, so it makes sense to
repost them as a series.

It would be good to have them in 6.8, given that at least one of them
fixes a pretty bad regression, and the others can lead to
unpredictable behaviours.

Marc Zyngier (3):
  irqchip/gic-v3-its: Handle non-coherent GICv4 redistributors
  irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems
  irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

 drivers/irqchip/irq-gic-v3-its.c | 62 ++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 22 deletions(-)

-- 
2.39.2


