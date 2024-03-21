Return-Path: <linux-kernel+bounces-110768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D888636A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E511F23177
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFC21FA5;
	Thu, 21 Mar 2024 22:42:53 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B21388
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711060973; cv=none; b=uQTPkdmHFdHJAIZotxt4CpQuYi53oK2b5o1HWo5a0w9b1xhdy1LswnnblZGpc5XfG8Zr4cJotEggvgqKUGqFYhS7wcQjtEZunb8HFFhHvptbvrUgHPIKHjulu6E8rTTukxqjcAVtZ7Ru/VX5hGqZjsQSUW3XJV4h56k3xvAqkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711060973; c=relaxed/simple;
	bh=y1gHrHxmeIBl+v80GUvxO2IfKBh1bbnBtIs+B1MIwgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCDRWZbLzRtwDfFbRhia4DpHuqECpSfsgazDysf8H2vDNyBF1815UF9hP7xQrpIfqVn6doJiicgkjPueL0lGD3v4vF/yhIe7UYL0uChDgPgaYPktM4Od55ouEtsEurn8GYwwQEyhqGij0BAGluYX9t7VUh8vwhycJY0jr9hHJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.35])
	by sina.com (10.75.12.45) with ESMTP
	id 65FCB7E300003EF3; Thu, 22 Mar 2024 06:42:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 79488531458118
X-SMAIL-UIID: DBC259E4D4454619A4D39A5139142850-20240322-064245-1
From: Hillf Danton <hdanton@sina.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Light=20Hsieh=20=28=E8=AC=9D=E6=98=8E=E7=87=88=29?= <Light.Hsieh@mediatek.com>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: avoid the deadlock case when stopping discard thread
Date: Fri, 22 Mar 2024 06:42:33 +0800
Message-Id: <20240321224233.2541-1-hdanton@sina.com>
In-Reply-To: <20240320001442.497813-1-jaegeuk@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 19 Mar 2024 17:14:42 -0700 Jaegeuk Kim <jaegeuk@kernel.org>
> f2fs_ioc_shutdown(F2FS_GOING_DOWN_NOSYNC)  issue_discard_thread
>  - mnt_want_write_file()
>    - sb_start_write(SB_FREEZE_WRITE)
	 __sb_start_write()
	   percpu_down_read()
>                                              - sb_start_intwrite(SB_FREEZE_FS);
						   __sb_start_write()
						     percpu_down_read()

Given lock acquirers for read on both sides, wtf deadlock are you fixing?

>  - f2fs_stop_checkpoint(sbi, false,            : waiting
>     STOP_CP_REASON_SHUTDOWN);
>  - f2fs_stop_discard_thread(sbi);
>    - kthread_stop()
>      : waiting
> 
>  - mnt_drop_write_file(filp);

More important, feel free to add in spin.

	Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>

