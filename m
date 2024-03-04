Return-Path: <linux-kernel+bounces-90655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D18B8702C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426941F21041
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEEC3E485;
	Mon,  4 Mar 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ys4OiY7R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF83DB91;
	Mon,  4 Mar 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559083; cv=none; b=ZPTCaoCTIGfH3hyJ3NJM8EjCkuvJg3oJ447V/bfzyWHk9LDkVUXe5gNH+UZeFf+2Y3WRBcncS3Nde9/7nhMRSfcNfiFPWMgc9X5PXlD6j4PB0UUP5/M5j+f5TS6ka4alY1cnXnNt+dUUw2EI7kVM/5m+b/T1cTkJfot/XY3Z52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559083; c=relaxed/simple;
	bh=8bOvzYkCe01NutJikhV1Y28ik1Mq792xNyLKJ+QvaWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgrZXv1X2yaP9WA6zDgEJs6tddpfcRjfxerNkHAFZ/NyINW0+62nFiz27Zq643/osibNpKvPddRqtOsOBCr6QWsULKSfIvRrn5Yy1zFEpPaphJkFIV6LadFXEPJ9OQwMFXqJs49QNrfVKeP9zPkZiNtBHtCzrq8//QO+pHHI8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ys4OiY7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FA8C433C7;
	Mon,  4 Mar 2024 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709559082;
	bh=8bOvzYkCe01NutJikhV1Y28ik1Mq792xNyLKJ+QvaWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ys4OiY7R6vv2e6J1QuvFrHqEC0BJ5G1n552UA90JnUfz27diTquY6C7tRp/4j+fgv
	 0Qr+URx9n91QiNEzsu3AIETBFW2PAu6dadeBNxYx0s5eu+lHVuiNRuEfs3JEdVIkp1
	 M1d+LE1nD4zJI4I2ppAx+AAkvAD7DYLxRztF8E1E=
Date: Mon, 4 Mar 2024 14:31:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Genjian <zhanggenjian@126.com>
Cc: stable@vger.kernel.org, axboe@kernel.dk, stable@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com, Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: Re: [PATCH 4.19.y 0/9] Fix the UAF issue caused by the loop driver
Message-ID: <2024030421-obedient-unbalance-a728@gregkh>
References: <20240301013028.2293831-1-zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301013028.2293831-1-zhanggenjian@126.com>

On Fri, Mar 01, 2024 at 09:30:19AM +0800, Genjian wrote:
> From: Genjian Zhang <zhanggenjian@kylinos.cn>
> 
> Hello!
> 
> We found that 2035c770bfdb ("loop: Check for overflow while configuring loop") lost a unlock loop_ctl_mutex in loop_get_status(...).
> which caused syzbot to report a UAF issue. However, the upstream patch does not have this issue.
> So, we revert this patch and directly apply the unmodified upstream patch.
> 
> Risk use-after-free as reported by syzbot：

This looks good, but you are backporting commits that are NOT in newer
stable releases (i.e. from 5.8 but the commit is not in 5.4.y), is that
intentional?

Does 5.4.y also have this problem?  If so, can you send a series that
fixes that up so I can take both of them at the same time?

thanks,

greg k-h

