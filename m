Return-Path: <linux-kernel+bounces-16545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 153AC823FF8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9E11F232A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C75210FF;
	Thu,  4 Jan 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="XhXAcV6q";
	dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="H7UmfpeM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DC20DDF;
	Thu,  4 Jan 2024 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1704365744; h=date : from : to : cc : subject : message-id :
 mime-version : content-type : from;
 bh=LtBoXJZU4S2EMXj5t+G2Mf6DrJOQ/owAGiFqMlThCAA=;
 b=XhXAcV6qnxiuRnDDa2JmX1GYuvGuWw2/5miOPEv2h6+a+8tBPzI0PeNNd1RVho8qZCtiy
 1H77RWVwa4UF6kgCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1704365744; h=date : from :
 to : cc : subject : message-id : mime-version : content-type : from;
 bh=LtBoXJZU4S2EMXj5t+G2Mf6DrJOQ/owAGiFqMlThCAA=;
 b=H7UmfpeMf/A4ItKmV03WY69Jn1ym2CrPWnx8hwQgUrohE1AIqZKp4h5YCGFgPFB71cBc3
 uD+QnyaRY5H/KFNIfkBKEQj5x4StnH7dEICH3EWQbGaUr3FEg/HA09IE9ESBHfygL4JQxRA
 IaTZjY7SXIjh45VzMB/t+HDQ9hvU2ukE+Z/PV8akbFV1CnvKIOcnFSCxk/dOX9qpFYwfcjo
 LcGTKuDO1MOI/8Xr3OWjhFPUI2cuq0zyCF1bSq+wY/3XoaDyBOjtfuvcWECSfS5VAgSO89B
 FVovyjItePGm0qCOz8Elix8ljvc+P5Kdi/QaMXOUxI3tvM/mY9AXSU6dhFTg==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id AA1B75FFB8;
	Thu,  4 Jan 2024 11:55:44 +0100 (CET)
Date: Thu, 4 Jan 2024 11:55:44 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: linux-kernel@vger.kernel.org
cc: netdev@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, 
    Francesco Ruggeri <fruggeri@arista.com>, 
    Salam Noureddine <noureddine@arista.com>, Dmitry Safonov <dima@arista.com>, 
    David Ahern <dsahern@kernel.org>
Subject: syslog spam: TCP segment has incorrect auth options set
Message-ID: <f6b59324-1417-566f-a976-ff2402718a8d@nerdbynature.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Ever since commit 2717b5adea9e ("net/tcp: Add tcp_hash_fail() ratelimited 
logs") the following is printed, in waves of small floods, to syslog:

 kernel: TCP: TCP segment has incorrect auth options set for XX.20.239.12.54681->XX.XX.90.103.80 [S]

This host is connected to the open internet and serves as a small HTTP and 
SSH login server, not much traffic is happening here. So I'd assume these 
messages to be the result of random internet scans and/or fingerprinting 
attempts or the like. While not really a concern, these messages are 
flooding the dmesg buffer over time :-(

Is there a way to adjust the severity of these messages?

* In include/net/tcp.h this gets logged with tcp_hash_fail(), which is
* defined in include/net/tcp_ao.h and calls net_info_ratelimited(), which
* is in turn defined in include/linux/net.h and calls pr_info().

Can e.g. net_dbg_ratelimited be used instead?

Thanks,
Christian.
-- 
BOFH excuse #78:

Yes, yes, its called a design limitation

