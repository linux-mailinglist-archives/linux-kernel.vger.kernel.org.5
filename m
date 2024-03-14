Return-Path: <linux-kernel+bounces-102760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22E487B6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDBD284631
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E473D2E5;
	Thu, 14 Mar 2024 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dw/AcaWB"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395ABA50
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388513; cv=none; b=aPNa71gz8oqcciDVYZ0jJwUWXJeq4dOsgU+TyNKK2WG+LuAge6Yk/GxEKaNCRKN0pRNik72/alQpOkyWNcCXvfhlm3x5YvfTf7IDqE/r7+ulpe1xCfCv1ad62GA9f9t5tlQLp1VUYpaa4pyXjKHvhkd1p2cn76S7lpbBNIxzU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388513; c=relaxed/simple;
	bh=cnowjd+g1/lhYd4a3gDndVTQ3z066ZB3OLRHAiHIK6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1yfY+iBUsK0iSbe4/ZMWsbiDgS0IpgAxhk9aYgZeDBdiMfrSzAv3Ystnvv2O12HZZ1l2L0s2IiieCS+hFaUB0ZSG17upSIyM8uldnoFbWTz6dsoAlpcM6tx1zZ5wIVg+pxTJHBk+OA1To0dL2tWIx9Z0J/WLhitmw15SulpNBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dw/AcaWB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 42E3snBJ003035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 23:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1710388491; bh=kFeL3FwNojsbT7MVre4oV9xu3BLSFmfHbJAwwk8zl4I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=dw/AcaWBFjCouyvhm/BUkiRI1rCFQ0LZ5bqNxVnFGUtpKOfOUHboBLSwZSic3ixoY
	 DU+ywpVSlnwPLgvUegl39JKjwDyeEq9N0kc1N8tL4dzmkqVIp0NUDVmM1tWQgS3FAW
	 w6JCpQqyCcvmjZbj4KCSBV3AZLYhTZKI37jsSJxxvVlLIGbHKyQqFtSpFmqpvFIWzi
	 ffdRqH+lIOvEJ0QAlxhcdZCBS62g6mgky2TKTmir0oS5Mwi51lhiHJKhzdiOwCIUn9
	 ErpLdGvPfIxhezXGWAtXFYDMAx/ashI+WHzxKTiASzMjjpNGwx1/6voXQ9E3469ZXL
	 3Z/9RXkT30Mig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id EDF7A15C027D; Wed, 13 Mar 2024 23:54:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wenchao Hao <haowenchao2@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, louhongxiang@huawei.com
Subject: Re: [PATCH] ext4: remove unused parameter biop in ext4_issue_discard()
Date: Wed, 13 Mar 2024 23:54:43 -0400
Message-ID: <171038847842.855927.7814623611820545715.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226081731.3224470-1-haowenchao2@huawei.com>
References: <20240226081731.3224470-1-haowenchao2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 26 Feb 2024 16:17:31 +0800, Wenchao Hao wrote:
> all caller of ext4_issue_discard() would set biop to NULL since
> 'commit 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread
> contex")', it's unnecessary to keep this parameter any more.
> 
> 

Applied, thanks!

[1/1] ext4: remove unused parameter biop in ext4_issue_discard()
      commit: 0efcd739fc07cefd5c54e202f66b4ea5def4776b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

