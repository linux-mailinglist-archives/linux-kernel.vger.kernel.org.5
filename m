Return-Path: <linux-kernel+bounces-79187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E8D861E99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EE128670B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DD2149389;
	Fri, 23 Feb 2024 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIkZx0bf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45A143C7B;
	Fri, 23 Feb 2024 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722929; cv=none; b=JKJZvs4CDZvOUGmmjeCiFuQSruHM5bRvHFXG/4NOreuHlAu2D/+DBn+88a9hlq2Ig2pi37As+VyDhimZHc0bWu20XBgcZD1DSikZVMnnYO/BefY/aiBnQ45efkP18j9G7abFI9Fu2q8meiNutOl+7oTDmVtHnbtvvblb7UYsTQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722929; c=relaxed/simple;
	bh=cPqJsOwJ2Igj6PpBlc/1N1gBQrxKIGjPyX4ikWmrH5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cil61BBMBezAWb+sMNd443rKXCPTq/jAr6sxLgNc47v3AV6pr5IwGc5yy6o0LZRfxieQL/o9UJUtA/DASxY8ipb2gyhHvKgskkdk+bTib71YYvCIsk8EQcT7OI0TFp28xliNOFgvDBXfn0DE/M2XBKEuamIMythNwRleDln12ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIkZx0bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85852C433F1;
	Fri, 23 Feb 2024 21:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708722928;
	bh=cPqJsOwJ2Igj6PpBlc/1N1gBQrxKIGjPyX4ikWmrH5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIkZx0bfh9gOKZ5rWDl6Jfv4Bboy+q3eSEMNNFrNwGE1+BRc5BR8s+9i1k+FjA8p7
	 ovSTR8Ga2+IkQn/Frjo0gQ2zjALzQLkNguDSb8tpJ77JE5t6VFD3DSoXbh8zROfzin
	 p1kmRU9djDjWPXJiJegxBl+VvUXiTKlQIrj1XbE0gULlNZsRrze9Efmao5bkmmWoQQ
	 ZPVh/4rxt2zGX6ox+qEL4Q1FGORjppOrC8ypEHJfVn3FftHCWUVdzVG61NEQLS65zV
	 qGp1WoNZfzSKCTT1NSzXFALE7XGUs1P17+Zm/I7pZ/gOwPCpE/crQ/hGFtddXE/IPv
	 7cDzZ3lDhAKyQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	krebbel@linux.ibm.com,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com,
	svens@linux.ibm.com,
	gor@linux.ibm.com,
	sumanthk@linux.ibm.com
Subject: Re: [PATCH] perf list: fix short description for some cache events
Date: Fri, 23 Feb 2024 13:15:26 -0800
Message-ID: <170872283705.3880577.6190909972006697810.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240221091908.1759083-1-tmricht@linux.ibm.com>
References: <20240221091908.1759083-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 10:19:08 +0100, Thomas Richter wrote:
> Correct the short description of the following events:
> DCW_REQ, DCW_REQ_CHIP_HIT, DCW_REQ_DRAWER_HIT, DCW_REQ_IV,
> DCW_ON_CHIP, DCW_ON_CHIP_IV, DCW_ON_CHIP_CHIP_HIT,
> DCW_ON_CHIP_DRAWER_HIT, CW_ON_MODULE, DCW_ON_DRAWER,
> DCW_OFF_DRAWER, IDCW_ON_MODULE_IV, IDCW_ON_MODULE_CHIP_HIT,
> IDCW_ON_MODULE_DRAWER_HIT, IDCW_ON_DRAWER_IV, IDCW_ON_DRAWER_CHIP_HIT,
> IDCW_ON_DRAWER_DRAWER_HIT, IDCW_OFF_DRAWER_IV, IDCW_OFF_DRAWER_CHIP_HIT,
> IDCW_OFF_DRAWER_DRAWER_HIT, ICW_REQ, ICW_REQ_IV, CW_REQ_CHIP_HIT,
> ICW_REQ_DRAWER_HIT, ICW_ON_CHIP, ICW_ON_CHIP_IV, ICW_ON_CHIP_CHIP_HIT,
> ICW_ON_CHIP_DRAWER_HIT, ICW_ON_MODULE and ICW_OFF_DRAWER.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

