Return-Path: <linux-kernel+bounces-143388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A10C8A37F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD411C22543
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207C15217D;
	Fri, 12 Apr 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VWX4Azfg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94DB152160
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957698; cv=none; b=BnUk8Y1yVfslB87PWoaWo+hfjIdc+0yspMg3nxQO+LYYsd9s9XT9itLijIWiMdoVi9XyKtvE9U874fVVwRY4p5LGXT8WY+JvuZ3CZSbUO9yLkRs8TOrhA+ai0sTn/rcvy4cReC0+dlBLG0stCiWcrhrnOxh47SUBeVLxoEX9osI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957698; c=relaxed/simple;
	bh=xvw5afYe/HqYZyOcx8EYuNqAOr1fJ9DeJWTEkIqDYqA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KTRzsmGS87F53TChorVd3MQTFO2q1EyD7mEvBbHHyAduP80YzB0b2ujvZfGAIK2e+gRO7eDyDYe/0R1iNEw4A1jX6hefDEJTYDMQBo+H2a52DNOgIvY6d595QgwEnOU74UykzyQ6CqyXX0tInhos0Fs69DCub/nIFUC+pcbzozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VWX4Azfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9DBC113CC;
	Fri, 12 Apr 2024 21:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712957698;
	bh=xvw5afYe/HqYZyOcx8EYuNqAOr1fJ9DeJWTEkIqDYqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VWX4AzfgnCpedrZFXAzhx6nYm7Iwa8pedx/0Ox0YMFy1JFDMlWv62MbFfKrJGAjbO
	 Iy8paFxH8TTl51hIlQvgRzjHXn9sWIivlgWGVUEAJ63HPLhGG6sIZycEDqDnJLLOm2
	 wl6x1fXa6QhRZ8EQ5JWJTCpWlz7GUjIJUjmnwh88=
Date: Fri, 12 Apr 2024 14:34:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Alex Shi <alexs@kernel.org>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, Hugh Dickins <hughd@google.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, Zhaoyang Huang <huangzhaoyang@gmail.com>,
 <steve.kang@unisoc.com>
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
Message-Id: <20240412143457.5c6c0ae8f6df0f647d7cf0be@linux-foundation.org>
In-Reply-To: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 14:43:53 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> Livelock in [1] is reported multitimes since v515, 

Are you able to provide us with a means by which others can reproduce this?

Thanks.

