Return-Path: <linux-kernel+bounces-75964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C9185F137
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25EF2B2231C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827EA134B9;
	Thu, 22 Feb 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOsIuMsd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E901C14;
	Thu, 22 Feb 2024 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581599; cv=none; b=Hr6nX0Fpre1L2Y9uKmMuxfSuerWxgowMSx//tR2Wx9PxV5c3IlQHlTMRV+J3S3430lrUJ3x3fOZEg5peyRx5xSl4s3UQc9YwYuSE+mE/4YEvGgXMsWt8YzFUnmhzkCalncz9Q3t646qN4Evx3JS1sZTC3tkgfSs2//JNk7Z11uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581599; c=relaxed/simple;
	bh=7eMHPhOOazEN/LI/SRIKFgefJe4Iax6HASQmBhZazhk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=dTC1fr8qolDga79cGJz63V3hce/16MSuQtzpdM1cK7/Di5qwtEPYJ8JMWbNgKUfr3uVONFANt9T/tLsW4OIaEWbLr24rF4fpILkPTfC2id8yc4uF++BnNjwOymzhSHJPFh4t+R/mYDOmtexC6GOlHLRK9bUbb5utqN4znfdSMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOsIuMsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F712C433C7;
	Thu, 22 Feb 2024 05:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708581599;
	bh=7eMHPhOOazEN/LI/SRIKFgefJe4Iax6HASQmBhZazhk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WOsIuMsdS8XnfulUu3hNg4DQZZ8rlbajlYCOctbDa1SI59lAjk5/hzQ4NwNUaSsEE
	 9AeNzDn7fGId6k2pJnVEdkxhjfSOM9SgTQNf4IP/4anQjpKztbrA3RJlDJ2i7mfXAG
	 7Oz7i77y3gYFiCkaN2j7JYrLQ6ruMFgB6Ib1ES+NLwOCfSMjOa/zWfCqDvv5l8IOTc
	 rKIX3CXrdBzBISR0mrNDkyCJlp8X21zJGQYLlftc6ljL/RgaLNYdSGXuGiJV2LPUU/
	 FaZ73TJcr+OJI+HE3xj9FMoNblOO3VHAPfZEUC+Pm5hibRzDcWEm6gzZq0ykVr69E5
	 5DvmhGrxgthRA==
Message-ID: <689300ed3176274c5150cf101eb53ca3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240213082640.457316-1-u-kumar1@ti.com>
References: <20240213082640.457316-1-u-kumar1@ti.com>
Subject: Re: [PATCH v4] clk: keystone: sci-clk: Adding support for non contiguous clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: vigneshr@ti.com, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Udit Kumar <u-kumar1@ti.com>
To: Udit Kumar <u-kumar1@ti.com>, chandru@ti.com, francesco@dolcini.it, kamlesh@ti.com, kristo@kernel.org, nm@ti.com, rishabh@ti.com, ssantosh@kernel.org
Date: Wed, 21 Feb 2024 21:59:57 -0800
User-Agent: alot/0.10

Quoting Udit Kumar (2024-02-13 00:26:40)
> Most of clocks and their parents are defined in contiguous range,
> But in few cases, there is gap in clock numbers[0].
> Driver assumes clocks to be in contiguous range, and add their clock
> ids incrementally.
>=20
> New firmware started returning error while calling get_freq and is_on
> API for non-available clock ids.
>=20
> In this fix, driver checks and adds only valid clock ids.
>=20
> [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.ht=
ml
> Section Clocks for NAVSS0_CPTS_0 Device, clock id 12-15 not present.
>=20
> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically=
 probing clocks")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---

Applied to clk-next

