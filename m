Return-Path: <linux-kernel+bounces-153509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73B58ACEE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153851C21531
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33761514DF;
	Mon, 22 Apr 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoYXfrA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9D14F128;
	Mon, 22 Apr 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794327; cv=none; b=aF3/qFA1TKqUnG0N0ZWZ7kHupch7ZBdcf9IyZ3oShRrYzYk0tzO92WOP4Q3MQwhPt/N5RS+y7M9K3GMNjLS/5aD63tlv72/iBZxlH86Bqu+L9yp2yAePyHpojM3F/jVO1sO8qP7PdXg8fnHgCpd1qVLQa8IHZ0tObnsitAQGM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794327; c=relaxed/simple;
	bh=UwLbA//oxa/QbyZ/HoUojyC7lBnUZJVO3hoIDHe65Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6FELvGi98qw/3WzYMkHKX3Z/xpjLVJC4E6XoRCeq/tVG6xueU+FIyGe5oMXJH+UjY+ooZ+kin81H/lL0cT2sfbpEv7SzMy/g1EXsbckC5kBGTm4P+dZDLdxJ+ET48KTftosaDqsXI6hglYEAJZVJE+UE3QzJhTLn7eGl55xVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoYXfrA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BB0C32781;
	Mon, 22 Apr 2024 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713794326;
	bh=UwLbA//oxa/QbyZ/HoUojyC7lBnUZJVO3hoIDHe65Ts=;
	h=From:To:Cc:Subject:Date:From;
	b=WoYXfrA9iStDxp1B39nAlyJZJuHTQHSyAPzpYjUa+gfNSc7cbbIA5+f3ls84xD9Gx
	 J4tjTPEG/CpE1pUBJkc2p44mgFNozCrG8NAsGuEF7fdHe654eDnE3+YTS2cLKGPqO6
	 DMvTVzwIzAB/jew8OGkxaKpvceewJtbgF7xwLz7d2fXG5xsWpqBApQz85xKv1YjvSw
	 3YmJvT8t62PZ2etFU2It7NUcSMMlkL9XMWHkskhlEtyhfH9eBNmRtaaFSgLbAtdl7+
	 YI+BvzmgoLW8HK7hbIXbtMPNYXao3HIT/HyCpqShUqFiqt7dhKnA75ogR/xY4FU2wq
	 gc1W8NjEu9clQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1ryuBu-0000000061j-0pAg;
	Mon, 22 Apr 2024 15:58:42 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zhengping Jiang <jiangzp@google.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH RESEND 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
Date: Mon, 22 Apr 2024 15:57:46 +0200
Message-ID: <20240422135748.23081-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm Bluetooth controllers can be registered either from a serdev
driver or from the Bluetooth line discipline. In the latter case, the
HCI UART serdev pointer is NULL, something which the driver needs to
handle without crashing.

This series fixes one such issue at setup() time which incidentally
masked a similar crash at suspend. Fix this in two separate patches so
that the latter issue is addressed in pre-6.2 stable kernels.

Johan


Johan Hovold (2):
  Bluetooth: qca: fix NULL-deref on non-serdev suspend
  Bluetooth: qca: fix NULL-deref on non-serdev setup

 drivers/bluetooth/hci_qca.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.43.2


