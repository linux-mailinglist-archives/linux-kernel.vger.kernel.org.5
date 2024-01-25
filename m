Return-Path: <linux-kernel+bounces-38648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F283C3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A79291A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0FC50A7D;
	Thu, 25 Jan 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUzyXi/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473B4F8BC;
	Thu, 25 Jan 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189411; cv=none; b=JVpxdeBeY4HuIHuTJ0NbfAf4ValWM4QsSNyTRsRjCUWyJFAYx1zgXYjKQkELLJ4lpkNT83+b0om12lOSV+3F8SPFGjg97YZlHcLGQ2Q5q75Hl+wOV1Y8iiPL11jVgnsCgcE4hgMtxhGwTNU+ey/6ZqiQV/PgptKGI4Lb7uSvlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189411; c=relaxed/simple;
	bh=616lcI+RmME+q9+3VPHfZWCLqdXDF+Z6zI5Uf57tygc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0a4l69p80LI3hIHLctdd1CiHEw7L3BVcwY5oXodSZ98zS0IzhnwLOUFyywgAHtBqgI/Jxe8Pu31A5aTCUD8eQA30Xj6NMucIMQ26A1beHU3z4EKN8M0irx5qqIiQhcUXoivwqkInzXL1AxLS2lcz/HoapYixRHL2zlYvySF0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUzyXi/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF69C433F1;
	Thu, 25 Jan 2024 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189411;
	bh=616lcI+RmME+q9+3VPHfZWCLqdXDF+Z6zI5Uf57tygc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUzyXi/4JMzaBZnEPwz8BEPPY+XpD9SLMTdzneSsgy/jbk0KnCCgNu4Mex7ra/EcY
	 TrMdkfn2ysaFncfOr4MET4U1Nf4MSQP8y4PagkbdOa90wAVZjF5Sm13WHMFcxIHpnd
	 kxLwi2C4M4YV/rDIMiVb09qzjVGLD9OFyqngwwH/oe8kQNe8f4j/ZKDKvnFrYaInto
	 ppfy09gwM8TZgY/z2TNMHgxbj1uCro332nqOql59WIz+h7XjNhBtIhgwPrYMm7O690
	 rxPQZnzeYdRm5e+32CuJKAXxf31JykztEtdMr3r8srLA9xueWOEfnrkfc0L0Io6ob9
	 SAGtrZRgma8gw==
Date: Thu, 25 Jan 2024 13:30:07 +0000
From: Lee Jones <lee@kernel.org>
To: Amitesh Singh <singh.amitesh@gmail.com>
Cc: pavel@ucw.cz, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds/pca963x: implement power management
Message-ID: <20240125133007.GJ74950@google.com>
References: <20240116073421.395547-1-singh.amitesh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240116073421.395547-1-singh.amitesh@gmail.com>

On Tue, 16 Jan 2024, Amitesh Singh wrote:

> This implements power management in upstream driver
> for pca9633 which enables device sleep and resume
> on system-wide sleep/hibernation
> 
> Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
> ---
>  drivers/leds/leds-pca963x.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Same review comments as before.

-- 
Lee Jones [李琼斯]

