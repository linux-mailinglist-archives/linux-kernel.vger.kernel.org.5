Return-Path: <linux-kernel+bounces-75909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1DA85F08C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DBADB2396A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4664A5235;
	Thu, 22 Feb 2024 04:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4KEjPM0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC21FA2;
	Thu, 22 Feb 2024 04:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577526; cv=none; b=euX2l98+VGoAu/5nMLSxStXLrDXVtMwq1GTHcyYVCOTAn5IXrok1F4ACTnkKDAg39q5NQ4yumOViAzt7tIGW0PxtJbm5cy3KzJPFGXV0CCMeYn9VIFMgKynaRgNmllfpyBYfGV+wzCU4w5Tkj96iAVNMLd49IXE3lZ0TZWyP6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577526; c=relaxed/simple;
	bh=3rjrUjwhsSCmh0RJibzoaF4JJV18xHOBdy6qFbX+vbM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=i2C6Bveo7VuLP6m9aY9SwXEdQB4hbr3uAzjPZKiQCG5nLLsX/d8euX4q/VRtylfbpiMeXTEKckywI/D9GjLGtHueZGqgBwl4FuxZvWXuAAkXWhWMQarRR3DKcKw9ZYeLIb91lsH7bdmE9wZt12CfXrTqBB5qk7n4jctUAIfQdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4KEjPM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4BAC433C7;
	Thu, 22 Feb 2024 04:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708577526;
	bh=3rjrUjwhsSCmh0RJibzoaF4JJV18xHOBdy6qFbX+vbM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=q4KEjPM0AfWmpL0qKK2Uk86RAnIqaI55UmqGSw3s8AKJGsNCg4RP4WMPTqDrr8FyX
	 515DOgYFoWs1wIDqmqt2aPPpXJksI+L5Rh/x57IdgBmPeeXtyQBhLladlh/WNS8/nN
	 NKRmr06cY/+WjMLly2Cc7VXRxizXlHkH6CJl0aorcZJ8VXKb2RBudoD28jwYhbySeC
	 CS+tPC/dU4Ospsp0VTtNxKPiFLSpq64Cir0GKoi+I5YwBxuvCVP5naXWgx35mWij4N
	 cFyupe8IVBCkBkuGChsGbaND3a7tss645ijw+5IyVwoQ6XQiUZniGa99zVPPKhoqz5
	 6lz4s29rHQ1Pw==
Message-ID: <050cb3a63e606d40d32da0a1d4c3a61d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2c553c2a5077757e4f7af0bb895acc43881cf62c.1704616152.git.christophe.jaillet@wanadoo.fr>
References: <2c553c2a5077757e4f7af0bb895acc43881cf62c.1704616152.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: mediatek: mt7622-apmixedsys: Fix an error handling path in clk_mt8135_apmixed_probe()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>
Date: Wed, 21 Feb 2024 20:52:04 -0800
User-Agent: alot/0.10

Quoting Christophe JAILLET (2024-01-07 00:29:28)
> 'clk_data' is allocated with mtk_devm_alloc_clk_data(). So calling
> mtk_free_clk_data() explicitly in the remove function would lead to a
> double-free.
>=20
> Remove the redundant call.
>=20
> Fixes: c50e2ea6507b ("clk: mediatek: mt7622-apmixedsys: Add .remove() cal=
lback for module build")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next

