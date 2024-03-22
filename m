Return-Path: <linux-kernel+bounces-111370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F58886B59
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D931F2290A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9CE3FB28;
	Fri, 22 Mar 2024 11:34:28 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8D3F8E2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107268; cv=none; b=OlblUsaHE4RSPkR5pjiP69LhgESM8/ONXbJ61uw4r7Iys//qRNA7YGfWetWLa+tpucUmLTHB74Mdnhv7PV9BCQtnFHx715Ml15X7UOrFAeXnSgU3n5lY7K1yj4pG4fRI3DzccBld4fc2wzQmZmXYpuWL7yt3d8Fi6+3UA0B967o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107268; c=relaxed/simple;
	bh=ACSUIa5eILVdV9/unH/3mAmu4AhoNpcnkH7YwBEVNng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcZmsmGk0B5qR7qj8NdsvcKzvs7wQIdCaGqYbEdBESaoqe2sLdD17WzYNJzdBpRFCH1BQE9QVKU7l2OLQ47vEidNVaidKBmnvfi0FkHCTfGKPW9OU1Se/JOx7kse7hm82+Upp3lmLrcdQkVv4qRhUIcBRhnl3z+K2NDSdtuVeqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.35])
	by sina.com (172.16.235.24) with ESMTP
	id 65FD6CAE000022C4; Fri, 22 Mar 2024 19:34:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 49593745089255
X-SMAIL-UIID: 836C24187C8B403DA6AFA1FE929A0CF9-20240322-193413-1
From: Hillf Danton <hdanton@sina.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: avoid the deadlock case when stopping discard thread
Date: Fri, 22 Mar 2024 19:33:57 +0800
Message-Id: <20240322113357.2599-1-hdanton@sina.com>
In-Reply-To: <ZfzQz5hwECOEGYVL@google.com>
References: <20240320001442.497813-1-jaegeuk@kernel.org> <20240321224233.2541-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 17:29:03 -0700 Jaegeuk Kim <jaegeuk@kernel.org>
> 
> I posted this patch before Light reported.

Yeah, his report's timestamp is 2024-03-20  6:59, nearly 7 hours later,
which shows that you constructed the deadlock with nothing to do with
his report.
> 
> And, in the report, I didn't get this:
> 
> f2fs_ioc_shutdown() --> freeze_bdev() --> freeze_super() --> sb_wait_write(sb, SB_FREEZE_FS) --> ... ->percpu_down_write().
> 
> because f2fs_ioc_shutdown() calls f2fs_stop_discard_thread() after thaw_bdev()
> like this order.
> 
>  -> freeze_bdev()
>  -> thaw_bdev()
>  -> f2fs_stop_discard_thread()
> 
> Am I missing something?

Light, could you specify to help Jaegeuk understand the deadlock you reported?


