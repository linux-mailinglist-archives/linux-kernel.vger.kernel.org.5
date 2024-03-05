Return-Path: <linux-kernel+bounces-91728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8248715BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789F6282347
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C297D40B;
	Tue,  5 Mar 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXYvF08l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA9B7D09D;
	Tue,  5 Mar 2024 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619235; cv=none; b=g0mbAi2QJ7aT+YJ95JTLzDQKOIadw0HBR64EmNUt+0jpKyyyHVtYx80Qdksk9XLCFVgnJbV4tWGBH654G/HhE84JvkYTUZMT/0V8zeP7vcWECQ1NDLgxIziFpKupgf/ZLHK0/pVMNGr1kTAphDJbW0rZ9e3cZqA7Uteb90fKM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619235; c=relaxed/simple;
	bh=i7Fys+2mj4/9XEX2BjPBQtiBsoGLML0DccoIQi8rAyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYljgOeDDvm8DUDdzXve/ojqt+QMfO0B1yL1SkPMcVcF6N8OkYSnxIdIL7WaMRciX8ybfl+rC5ydULKIEM5e9+IXKbDBICbYw2E7Cbajqk8Pp5LLprW+2JBYopRb8nAhdW1POew08NkKF472rjNjDPWJsk4/EDg744uKkpQt6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nXYvF08l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6403BC43390;
	Tue,  5 Mar 2024 06:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709619234;
	bh=i7Fys+2mj4/9XEX2BjPBQtiBsoGLML0DccoIQi8rAyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXYvF08lnJ721IkKLSsQ1rX6VoopDE4gnBkCtBpZjeiwymnYUN8p9UJgoLLa0GKOr
	 90dP8z6Da5C/CRObKfqjYRCWlw0b2mkTGuYhz10E+NftfF6IBhADmrq4icjr9KG5pJ
	 HlJTKyaLgSLOcJzvNVkQOG8Sf3vkcsKX0Dxg06PY=
Date: Tue, 5 Mar 2024 06:13:52 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
	jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
	stable@vger.kernel.org, alexandre.chartre@oracle.com,
	x86@kernel.org, linux-kernel@vger.kernel.org, yuanzhu@bytedance.com
Subject: Re: [External] Re: [PATCH v2 0/3] Support intra-function call
 validation
Message-ID: <2024030506-observant-clamor-1c8f@gregkh>
References: <20240228024535.79980-1-qirui.001@bytedance.com>
 <2024030438-dropout-satisfy-b4c4@gregkh>
 <2024030404-conjoined-unlined-05c0@gregkh>
 <c98aa910-7b14-401d-a257-274682bb7486@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98aa910-7b14-401d-a257-274682bb7486@bytedance.com>

On Tue, Mar 05, 2024 at 11:28:01AM +0800, Rui Qi wrote:
> Hi Greg,
> I checked out commit e133c1ee6d7271007fdba3dbe78818afd88943f9 (Linux 5.4.270), applied my patche set on top, enabled CONFIG_LIVEPATCH based on x86 defconfig, compiled without any issues. I couldn't even grep unwind_hint_empty in the codebase, so I'm quite puzzled about how this phenomenon occurred. Can you tell me how to reproduce this compilation error?

Try building with 'make allmodconfig'.  Also, what compiler and version are you using?

> In addition, my patchset only applies to the LTS branch of 5.4, not to other branches. Please be careful not to merge it into other branches.Other stable branches do not have the problem of such kernel livepatch issue.

It just broke this branch, I didn't apply it anywhere else.

thanks,

greg k-h

