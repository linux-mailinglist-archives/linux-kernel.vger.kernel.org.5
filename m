Return-Path: <linux-kernel+bounces-152640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1FC8AC1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413711C20A11
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F2D548EF;
	Sun, 21 Apr 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqnL3A/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31F535B5;
	Sun, 21 Apr 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738592; cv=none; b=sxCWPXkAJSRqVO7EC91G2+zkvEQ70/6OmRTmXW8x9Su00B0MdAqXBYXDsCG/YaFXnTRpl+5NestiPI/ESmgsR9Ox3IdjeEUhNaRI9nPZYYODC+eu4rI/7zEoUJcl4NM5jhSiEvq97Rts9bDsS1Hmso0QuKRE25mNu/T3wr10G6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738592; c=relaxed/simple;
	bh=2gsVchYluKLRDn6PnXnVOwHzweuEK9mvCJGqpu//7/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDJa1BpGrYzC7Un15euro8eec4rL1TldPo3PXvcGMYkviZ6oao3wXgwGLW5A/9iV5rIJe8pnaqe9uSC4jbxjYqX9ErTQVh5oqM0D1WAqKHMDfyPkB8rLU6/HaluKCvHJUUFxY4D5dCzBFHYr9eDUxGqTmmomn6c99zg7Mc8Y21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqnL3A/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3E5C32786;
	Sun, 21 Apr 2024 22:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738592;
	bh=2gsVchYluKLRDn6PnXnVOwHzweuEK9mvCJGqpu//7/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqnL3A/4HtHk1pEct0JpiMsZeQMwmy2Bg6zYlk3TdwuXtKlg5Pz2aNKz11rp/FXUT
	 YByaZ5R0ATOwD6lJ7dtpAJ3yR5H5Bz4RGNTsgH6qpzuisRnLaTQQoZ6E3QYEwpChH7
	 SrSQdwgSTjtihNyuxBF0kDx19VhjI+UqF9Aq3YHHuKIyCqu121IhTdm91FyPSj/18a
	 1eyoi89ZUTee96mFUCNHPT96RQAVBL2VtTax4aDL0bdm5UqJgxOyv5YTsti72wO9x1
	 z+bv6fQwUMjKFEQZUhHKwI98iz8hh5wh6gFU+V03ra1Vb/eciIDOwft5P5DQSLXWC+
	 1ot3jOoiGEycA==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Subject: Re: [PATCH v13] firmware: qcom: scm: Modify only the download bits in TCSR register
Date: Sun, 21 Apr 2024 17:29:26 -0500
Message-ID: <171373856760.1196479.5443899739129517057.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1711042655-31948-1-git-send-email-quic_mojha@quicinc.com>
References: <1711042655-31948-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Mar 2024 23:07:35 +0530, Mukesh Ojha wrote:
> Crashdump collection is done based on DLOAD bits of TCSR register.
> To retain other bits, scm driver need to read the register and
> modify only the DLOAD bits, as other bits in TCSR may have their
> own significance.
> 
> 

Applied, thanks!

[1/1] firmware: qcom: scm: Modify only the download bits in TCSR register
      commit: b9718298e028f9edbe0fcdf48c02a1c355409410

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

