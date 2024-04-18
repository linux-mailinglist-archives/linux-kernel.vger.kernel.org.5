Return-Path: <linux-kernel+bounces-150404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0788A9E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5767F284621
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470A16F85F;
	Thu, 18 Apr 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="P9xLf122"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239016D33E;
	Thu, 18 Apr 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454645; cv=none; b=mV70I3otDcPOTR1li7osgSo7tHKOPJZbhnfB6CdQnNDvlAX8kitK7rewadif/JuvhAwde2h2JuJImrO7PAijHtLtYFbjCpIcRCHrJewoc/gFOKGh7oyCaT2vY3GZjIem5qny0vRgPs37A2nbH/mexw1s9YYRrmAZRlspFVP4ugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454645; c=relaxed/simple;
	bh=GuLk3A8M3vQrERq+Af9nwo+nmfxC08b8IT5W6Cgpo+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BL4qeIQ2Rg0/nOEdN8xxxNeVTQ8kNnGQE9bGo67MCJzbtCmDmPoLnxaeAVKGRllrZjLLUrFrX3CAF4Yq5Swrg6yCi5y6pnIlr6nCy6oosc7xTdqYCHVmC1YJ03Uivs1vLWUxOvBFgDSN/ougqWK3Bcz0fLGRKihK5I1/NrKvzWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=P9xLf122; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713454632; x=1714059432; i=parker@finest.io;
	bh=7mJOqydJA7QzkE7pW3qqPEKjBcHf4PDVhXzfkdaj/OY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P9xLf122r0+HpA9Z0wE/MauMzgdO12dC+cL3TMF8wWMRKxUI/6+U7s3Ff5R1r2rK
	 UbAJrqFpYLQIeUvZ6/SqW3LS9aM4sf4HXGnv9lJde2pkDN6f8QkbvN18b8NTnnvDP
	 4Kj3wQv6xj/V8kU3kma2RyFgunFz9tJ/XYUkhfjTZRMQ+uNJt1CHTnI8WBn8/+kOA
	 h03tFN57i4lTUPRuHquT7onaud94REuiPtpHQFWK1jVDk5hUwbwfnUIdAZaCHJaSE
	 eqEFFGtvmjpto03PeY70/0c6GwciTk1zYGCS+52d3/UDRfWNIDnvSgYsCQQ911hy4
	 y+h+LTxgUBZx9xwNPg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MZSPL-1sIA2M3he9-00UV3c; Thu, 18 Apr
 2024 17:37:12 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 0/4] serial: exar: fix kbuild warnings and code style
Date: Thu, 18 Apr 2024 11:36:27 -0400
Message-ID: <cover.1713452766.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YIWADP/CmXoAEdKqH6ZI2qmBrbO713LInGo2tWERMSG3WR2PEgP
 o0bgc7SNMGFUhrtmBXFGHHCRVL+IUYhhMTzAn935kGTW8fXV081yTj95zGdYr/J8tLL2EB8
 HL60uYy68t9D3Th0sUQlVkbvqJQARmnYn77lFLqnvyrtVxakYPOqurYfaqL7vMRjS3b5gma
 G3DdJul/yx0m8ggEVVgAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5PXZGpAllV0=;kSybSKQ4rlhqmr0RjpPiL/8Xjey
 SJqloJYmhkkQHPVzgomc9eOmw/PNVlof0XrooKfnUlEF0m3PE3OdbIy5NNBEzwrjeN+Ve+2T9
 GgzpKYZbxL6YO3jAqjpQ8/31blPrfE8SN9v9EekgD9ju+hoqKXU+ojD7M4qFNJ7SdPkhLDju/
 laTkF6N3Ig/C1rwwwenQAmCuuIETjPno80e4sX9/zdRGfqCvWF/y5OsxQlNuhcU+wJEwUOx+b
 3BG4uK8A/qu3aYuY7LmH2vEJq9Olz7uSQj9ePZIhnvHoywv3W/GYeINsj8B+qQKWkfM7274d2
 sbQCJlvlQan1B4MwjtgdFn56zTDoYVCKyr+cW+HZoRuru14wcW2wchSgFr+WNEhC1aQmLVZUh
 SUI50KeudfU/tl5lg2mn8N+EUgRrFrl6EdHfcKDJf9s4Emx6W5jQ4VQi2lo12dJxI3ozFqsiW
 fZNFHcddOxuxiuhmkj4vb3IzRHaQFnfnP1zer+v/B87Al5CQJHaAwbc1RCBvSGN5Ncwu2vHy7
 E6iIBhFZj1K4elmYWuhPOM2VcoIdwWf7sa4rmfH1Sj5Zul/weLGkWMcrdbYJ5KcLP5BAXBHwW
 jgFwrl0f7KDEjA19EsmD/hwK+ayKfq+WJK4dzpxRAE1TL0on1bEMmGw2yFjnlwFbYZBLaGXhY
 dOq9IfY7Gsuf1yAjEKgK9wb5hGoPS+kQCYBHkJwTzvZgWqgpKOmeUJsLKApjZW5HNvtUQE3d9
 Aq9+v7l43iTZDllB0mIQihLY7ukK0F96j/pnIhKviE8sVazKnGIdvs=

From: Parker Newman <pnewman@connecttech.com>

This is a series of small patches fixing kbuilds error and code style
issues based on feedback during review of main patches.

Original patches thread:
Link: https://lore.kernel.org/linux-serial/cover.1713382717.git.pnewman@co=
nnecttech.com/

Thank you,
Parker Newman (4):
  serial: exar: add missing kernel doc function parameters
  serial: exar: use return dev_err_probe instead of returning error code
  serial: exar: remove unneeded parenthesis
  serial: exar: change port_type ternary line wrapping

 drivers/tty/serial/8250/8250_exar.c | 47 +++++++++++++++--------------
 1 file changed, 24 insertions(+), 23 deletions(-)


base-commit: c6795fbffc4547b40933ec368200bd4926a41b44
=2D-
2.43.2


