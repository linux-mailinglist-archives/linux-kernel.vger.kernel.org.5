Return-Path: <linux-kernel+bounces-153891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E528AD493
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E601C20CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8AD155327;
	Mon, 22 Apr 2024 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHein+sB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13D219E0;
	Mon, 22 Apr 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812643; cv=none; b=fOSwye0Sszvtkr/NT4JadJjU18TPFN92OqBrGXEiEvAKGJ0WVrA/aPeDVrFspbx6VTq89CBRFf0j9PmAYxApCHXnVahkX+p9Ecnqv+7XGj6WcqjnoFpJ0h0GsI6IVAPArmEtWd0OamS7b5RL27LFdg06JR+UaWWnOWW1m2rD6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812643; c=relaxed/simple;
	bh=/KZ+ZncZH9oQrroJ39sxSYoWYSIZDlMsdiB/URZ9pzM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=HBXDgp9oMSZtBz3lC42Docukcl8ALMPePCUDUEXL5Fd+dBQBZLSLkRqwnIbZfgOIukkF/BEsc8JHlq17+Uh5MvvXh0YtWdS5TDmfD/TFlgBdSh3is7M/bis24fOucfXczBARGQ9N11uc2Q0r4MSApRp1rDzQgizAdudJtTkuF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHein+sB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEB4C113CC;
	Mon, 22 Apr 2024 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713812642;
	bh=/KZ+ZncZH9oQrroJ39sxSYoWYSIZDlMsdiB/URZ9pzM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WHein+sBgpWcoabO6I0muedj1S+MBCY6C+QWvhx2Z34KtQLi59JSQabPVt/jhhGjJ
	 O1oJGWcB991tcvPu/AYGBowBm4pnqp85w8HzmjKnNiKnNU2ANE9ybaiAKZ7VMTLP6h
	 lBl9r6damoc6WFT8SLenaB159iplSqEiVuafTKqZGMPe9fxazvaVcABvOftEextfRF
	 raXApFS9r5HzvtSx0hVWgasY/8EJv0He16tJ3kPdFTsbZyV625up7dwuQ3R/udLjV1
	 I05iC5qunRO0YhIXfCh43IRyBcV4uuso9gmeUq7KDoN/dgUY4Z/+CzJsJzoo3++gu5
	 ozPCwNLz6tIaQ==
Message-ID: <cdf0db7d978a5da02763541c66898840.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240415163649.895268-5-cristian.marussi@arm.com>
References: <20240415163649.895268-1-cristian.marussi@arm.com> <20240415163649.895268-5-cristian.marussi@arm.com>
Subject: Re: [PATCH v3 4/5] clk: scmi: Add support for re-parenting restricted clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com, mturquette@baylibre.com, Cristian Marussi <cristian.marussi@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Apr 2024 12:04:00 -0700
User-Agent: alot/0.10

Quoting Cristian Marussi (2024-04-15 09:36:48)
> Some exposed SCMI Clocks could be marked as non-supporting re-parenting
> changes.
> Configure a clk_ops descriptor which does not provide the re-parenting
> callbacks for such clocks when registering with CLK framework.
>=20
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Applied to clk-next

