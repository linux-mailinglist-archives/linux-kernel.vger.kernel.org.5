Return-Path: <linux-kernel+bounces-48109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93999845756
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1ED289E18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B7315DBC9;
	Thu,  1 Feb 2024 12:23:06 +0000 (UTC)
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214D3A1C3;
	Thu,  1 Feb 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.38.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790185; cv=none; b=kRrWh0OGWQH0xgIK0241Qqh9f1nRiNcLB48ha6N1RTDjWzTqPIGJA3xMxVykQ1TfQ01xdsGqVeZ3jOSvLYz8Qg9FrUcn5o8tS+v943xJM7lHRvGcFQwh07nMxWfrrYki2uxxL8tZ/MfkEbY6zavSMBnTxrPGNF1JV98+BBWteLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790185; c=relaxed/simple;
	bh=eHsqM6NTg0ehVoKQcQCUD5ASXZATwOsT8Kua8rMIfGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2TVApuWSn1022wkwLtg0MqGD+QMzGChBedbLOzTMuRkk7PychPGGWbPd9IFqkFHDMahBwNZMyue1zBz4WYKR0MospNlhYCt4jxOd04+VWdVFs3FeClvTXmpACWzAIheoBkVbZr2jVIWXQcYeYDt9So8hRjajRolBEfjtvOyEHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=217.74.38.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 6D8C41867802;
	Thu,  1 Feb 2024 15:16:19 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id W9wfiTQKmPe6; Thu,  1 Feb 2024 15:16:18 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id CF7B918677C2;
	Thu,  1 Feb 2024 15:16:18 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y4R5zbGmj5yu; Thu,  1 Feb 2024 15:16:18 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [62.217.188.159])
	by mail.astralinux.ru (Postfix) with ESMTPSA id 8042C1866CBC;
	Thu,  1 Feb 2024 15:16:17 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: stable@vger.kernel.org,
	"Greg Kroah-Hartman ." <gregkh@linuxfoundation.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	lvc-project@linuxtesting.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Tsuchiya Yuto <kitakar@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10/5.15] media: atomisp: add error checking to atomisp_create_pipes_stream()
Date: Thu,  1 Feb 2024 15:15:32 +0300
Message-Id: <20240201121532.15164-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231109150001.22891-1-abelova@astralinux.ru>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just a friendly reminder.

