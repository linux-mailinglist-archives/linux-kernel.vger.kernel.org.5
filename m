Return-Path: <linux-kernel+bounces-164490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC238B7E30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7923C286ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38FD1802AE;
	Tue, 30 Apr 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2qZqwdl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBDB173351;
	Tue, 30 Apr 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496931; cv=none; b=vFs5MOgpziunk8gxtRIUDNmnEpx9JKA46weKhD8bKhlUGkl2a9c/FprACx9p2pV6M8bRHGv7P3nOSvQa7b7XXydGzMaDfTHpCq+/RKf7V3kspYz01zqBSfTbBwMfh8FXyaEgiFucY1IRYrrEpaeZ1rb1DkQjR8EEwoar4jkkrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496931; c=relaxed/simple;
	bh=kN2nfYaW+kqi6Y9cBOHDijd6fcDAfmABLSN9IDfyJWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwgqxpmwEtLIIzHOW7xLNALLgiIhZvMZUuvGHlH6E3aQSs7adGwnUTTd73d6+yiuKkSEZ9gHV3I1K5aQ+VKIRVLiDS4bCErLxhX9UFxsdFT+A1qoW5NfhYDLR80kjaN7t72rafXyWiwlc6KBd0rnKIZXpew0guVvNodNKjaEhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2qZqwdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3738C2BBFC;
	Tue, 30 Apr 2024 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714496930;
	bh=kN2nfYaW+kqi6Y9cBOHDijd6fcDAfmABLSN9IDfyJWY=;
	h=From:To:Cc:Subject:Date:From;
	b=Z2qZqwdll04May3CXSNcjHEwDnXHdOfX0z8EYaPg8+rHMKMkFntfBAhgZNGUnUFsx
	 TmCEtu+rpb5Ucv30HLl7wLXs90FWu3um65AQenWbgpIItuic+MLid1zu1beD0sPTTa
	 rJhkcny0kxSu6du89qiFvpaWupbBPUXVT36mbbhJiA3pRUOI+MWJd0R/F8R780j/YV
	 8quJS++aNije9JRjvKHk0JFpC9JNbODL/2LmjLw4eZJTfIRZzNcAy5lfJSDWo0HV92
	 kbFTzg5rLbLGfFliA6PzuepWK9bTt4SnHCZSul2XztDifa4M/Yc0i8sCG3EqtL5RzS
	 RJl4NvClsUzuA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s1qyJ-0000000047Q-3fzL;
	Tue, 30 Apr 2024 19:08:52 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/3] Bluetooth: qca: generalise device address check
Date: Tue, 30 Apr 2024 19:07:38 +0200
Message-ID: <20240430170741.15742-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QCA default device address apparently comes from the NVM
configuration file and can differ quite a bit between controllers.

This series adds support for storing the default address when parsing
the configuration file and using it to determine whether the controller
has been provisioned with an address.
    
This makes sure that devices without a unique address start as
unconfigured unless a valid address has been provided in the devicetree.

Included in v2 are two preparatory but otherwise independent fixes that
adds the missing sanity checks when parsing the firmware files and makes
sure that the parser can handle configuration files for WCN3xxx.

Johan


Changes in v2:
 - add missing firmware sanity checks (new patch)
 - fix nvm configuration parsing (new patch)
 - make sure to set the BD_ADDR quirk flag also when the controller
   returns BDADDR_ANY


Johan Hovold (3):
  Bluetooth: qca: add missing firmware sanity checks
  Bluetooth: qca: fix NVM configuration parsing
  Bluetooth: qca: generalise device address check

 drivers/bluetooth/btqca.c | 83 +++++++++++++++++++++++++++++++--------
 drivers/bluetooth/btqca.h |  2 +
 2 files changed, 68 insertions(+), 17 deletions(-)

-- 
2.43.2


