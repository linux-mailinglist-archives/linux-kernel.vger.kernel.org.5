Return-Path: <linux-kernel+bounces-165009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821AD8B866C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBD71F230AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80750248;
	Wed,  1 May 2024 07:51:02 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A84E1C8
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549862; cv=none; b=COgK35KRbuz7PxO1bcaa2kVPtJcXIWA0oKYqDRXmDTEbkgwgRGCk97J2SaOrSNSBay4a87LEYxT+dRx4JER6s0L93JbnYLGLJusA6fj9hQGofJzCd74fZcIT6BXAB2HWImELnAKUhE1BJmagbHHLBsKYH7LoaUs/9E4GL49Kv/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549862; c=relaxed/simple;
	bh=Nvscq/NT9/+j/DykFVg7/tQ7d07STWFJVXZA2SanBcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tjbVYXaxPCuk/4DLa5ruhmlcLqe6RCIZsBdiFrFpKMvncnx90vMMWZn0JVspPbp8xfbUemssb82orWFHyYKqeYi/8XgTXJQEzZI7hPoZqk8892QR3qcwDQy5cptjliZ6HbpmLRTFBOCuIQ3CVG+40I91aMQev20e5WWQlliL5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.115])
	by sina.com (172.16.235.24) with ESMTP
	id 6631F45C00003840; Wed, 1 May 2024 15:50:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 99969545089450
X-SMAIL-UIID: 6B92299AF328438ABAD25F19B01E92F2-20240501-155054-1
From: Hillf Danton <hdanton@sina.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not be accessed in vhost_task_fn
Date: Wed,  1 May 2024 15:50:57 +0800
Message-Id: <20240501075057.1670-1-hdanton@sina.com>
In-Reply-To: <20240501020057-mutt-send-email-mst@kernel.org>
References: <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com> <20240501001544.1606-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 1 May 2024 02:01:20 -0400 Michael S. Tsirkin <mst@redhat.com>
> 
> and then it failed testing.
> 
So did my patch [1] but then the reason was spotted [2,3]

[1] https://lore.kernel.org/lkml/20240430110209.4310-1-hdanton@sina.com/
[2] https://lore.kernel.org/lkml/20240430225005.4368-1-hdanton@sina.com/
[3] https://lore.kernel.org/lkml/000000000000a7f8470617589ff2@google.com/

