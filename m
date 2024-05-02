Return-Path: <linux-kernel+bounces-166228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAC88B97CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB7D1C22B27
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3249354F87;
	Thu,  2 May 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szYua+Vq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F8548E7
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642363; cv=none; b=UjlI88zWCiMseQkHOv5LF+z0LzXvPyxpGw8+sU2eyMUztFuUmI6ixP0Ls0pfNg48tEfl9EDJR0hLHTmi+6rpNPtEDv6xwJhx2fNWfhOS0N18DkESvS53yFjk5Z9jjH2QrvwZeNKnxeLTs4yz4fz9sJ2+Tix/xABylSfwrPdH7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642363; c=relaxed/simple;
	bh=pnHl2KOj1Es6tFCYdzt37ZBCZQscbYpMzR0Z5AZrRmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fDrADzacgolLYWI2WtAQuJNw0dBqQ6C3HcwFzw6i01AFftqENd/rOO3KRvWI0UtTChnd6lUicd5+REKvg1FLSx9KkNffE8OGQ+FV3ouXIEmNeZsjeZ1eiDfT70ij1hOzIvZcRW+lnCxqLNx9cV3ZBtv1XO2bTBphSLe+CPnV3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szYua+Vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9A0C113CC;
	Thu,  2 May 2024 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642363;
	bh=pnHl2KOj1Es6tFCYdzt37ZBCZQscbYpMzR0Z5AZrRmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=szYua+Vqilje9929zd7g40MJevp6agXVtANGeuBlTG3UClfNrIisExuDdTX1x+0n3
	 a986m1hWzoHr1fiAX3lQRLAPq/TTuG2w29Rzhp9o+EZLKS+g+UXhKRYGk69Jt+UxQS
	 bz5Yi65dgkKsADSiukivawSmj+RXpHuccbZB3n6KUu2rZB6680qKZdOlmrB097uLXt
	 ek7aSSpnPoHYDZvbcG+3mcZkVtH+XmW5giDlBOsmtl+YgXFiCBNfRmom/Bgq6qp0ib
	 xg8wQBMK96CD1LE81OWGPTZ1XJpGHU7GQHhGd2W5PQfUV8DfSqho/BGDhak+RspkMa
	 N1/bOoHqp4Odw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, wens@csie.org, wangkaiyuan <wangkaiyuan@inspur.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240429024547.27724-1-wangkaiyuan@inspur.com>
References: <20240429024547.27724-1-wangkaiyuan@inspur.com>
Subject: Re: (subset) [PATCH] mfd: axp20x: convert to use maple tree
 register cache
Message-Id: <171464236184.1130487.12710545036975634302.b4-ty@kernel.org>
Date: Thu, 02 May 2024 10:32:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 29 Apr 2024 10:45:47 +0800, wangkaiyuan wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> 

Applied, thanks!

[1/1] mfd: axp20x: convert to use maple tree register cache
      commit: a0fb1c6608c5ff7526e77031e3e90475529414e3

--
Lee Jones [李琼斯]


