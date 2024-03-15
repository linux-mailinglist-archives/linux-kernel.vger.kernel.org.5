Return-Path: <linux-kernel+bounces-103993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA387C7A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E870282B76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4AE8F6A;
	Fri, 15 Mar 2024 02:42:20 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE179D3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470540; cv=none; b=HBRQM8Qqg5EckHHL4orHCNM4o/HXjaY6PKA4k6cB0d/dKb/2Mkh/HXytu20huUaUrKv9Y3uVrpSLLFNZrwe4q25vwdxSMGKT4ZnYO35gJ25HeFgwA70ygZYiOoYgdkH9Fx38B3/ms7pZEynjfBarVdEf0SR/wvJAz48/50zW/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470540; c=relaxed/simple;
	bh=l1mMy7rRIxNkKbnKRRRtolYc6FP57KEmiWYFu1gsGJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XElC+nYHLvhyB9oum25dWkulhlHR3wXrh7UUDbKCyAsKDP9jzXBKJKmBMQA1MBODXlv00TMqThre63SZ8CppHbovyK5keSQVgqN+FPmB9CvBRyKCqH4yQWG6mFcuwom8EIcvlrp2sWRQN7CdmrCxigw0FdQkRYTPyRP3IM4+eho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 42F2fj51077124;
	Fri, 15 Mar 2024 10:41:45 +0800 (GMT-8)
	(envelope-from zhang.zhengming@h3c.com)
Received: from DAG6EX01-IMDC.srv.huawei-3com.com (unknown [10.62.14.10])
	by mail.maildlp.com (Postfix) with ESMTP id 3026E2004BB3;
	Fri, 15 Mar 2024 10:43:17 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX01-IMDC.srv.huawei-3com.com (10.62.14.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Fri, 15 Mar 2024 10:41:46 +0800
From: zhangzhengming <zhang.zhengming@h3c.com>
To: <lulie@linux.alibaba.com>
CC: <akpm@linux-foundation.org>, <alibuda@linux.alibaba.com>,
        <dust.li@linux.alibaba.com>, <gregkh@linuxfoundation.org>,
        <guwen@linux.alibaba.com>, <hengqi@linux.alibaba.com>,
        <kunyu@nfschina.com>, <linux-kernel@vger.kernel.org>,
        <nabijaczleweli@nabijaczleweli.xyz>, <xuanzhuo@linux.alibaba.com>,
        <zhang.zhengming@h3c.com>, <zhao_lei1@hoperun.com>,
        <zhou.kete@h3c.com>
Subject: Re: [PATCH] relay: avoid relay_open_buf inproperly fails in buffer-only mode
Date: Fri, 15 Mar 2024 10:39:12 +0800
Message-ID: <20240315023912.13390-1-zhang.zhengming@h3c.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240220105836.15815-1-lulie@linux.alibaba.com>
References: <20240220105836.15815-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX01-IMDC.srv.huawei-3com.com (10.62.14.10)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 42F2fj51077124

> diff --git a/kernel/relay.c b/kernel/relay.c
> index a8e90e98bf2c..0d8b8325530a 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -391,12 +391,13 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
>  			goto free_buf;
>  		relay_set_buf_dentry(buf, dentry);
>  	} else {
> -		/* Only retrieve global info, nothing more, nothing less */
> +		/* In buffer-only mode, relay_open_buf is called with
> +		 * filename=NULL, but create_buf_file is still needed to
> +		 * retrieve is_global info. So dentry should be NULL here.
> +		 */
>  		dentry = chan->cb->create_buf_file(NULL, NULL,
>  						   S_IRUSR, buf,
>  						   &chan->is_global);
> -		if (IS_ERR_OR_NULL(dentry))
> -			goto free_buf;
>  	}
>  
>   	buf->cpu = cpu;
I suggest replacing IS_ERR_OR_NULL with IS_ERR instead of removing it due to the possibility of create_buf_file callback returning an error.



